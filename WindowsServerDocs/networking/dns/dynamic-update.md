---
title: Dynamic DNS Update in Windows and Windows Server
description: Learn about dynamic DNS updates in Windows and Windows Server, including how client and server computers update their DNS names, how secure dynamic update works, and how to resolve name conflicts.
ms.topic: concept-article
author: robinharwood
ms.author: roharwoo
ms.date: 02/13/2025
---

# Dynamic update

Dynamic update allows DNS client computers to register and update their resource records with a DNS server whenever changes occur. This feature reduces the need for manual administration of zone records, especially for clients that frequently move or change locations and use DHCP to obtain an IP address.

The DNS Client and Server services support dynamic update, as described in [RFC 2136](https://datatracker.ietf.org/doc/rfc2136/). The DNS Server service can enable or disable dynamic updates on a per-zone basis. By default, the Windows Server DNS Client service dynamically updates host (A) resource records in DNS when configured for TCP/IP. The DNS Server service is configured to allow only secure dynamic updates by default.

## Protocol overview

RFC 2136 introduces the `UPDATE` message format, which allows adding and deleting resource records in a specified zone while checking for prerequisite conditions. The update is atomic, meaning all conditions must be met for the update to occur.

The zone update must be committed on a primary DNS server for that zone. The secondary DNS server forwards an update using the replication topology until it reaches the primary DNS server. When you use an Active Directory-integrated zone, an update for a resource record in a zone can be sent to any DNS server running on an Active Directory domain controller whose data store contains the zone.

When a zone transfer process starts, it locks the zone. This lock ensures that a secondary DNS server receives a consistent view of the zone while transferring the data. During this time, the zone can't accept dynamic updates. If the zone is large and frequently locked for transfers, it can starve dynamic update clients and cause system instability. To avoid this issue, Windows Server DNS Server service queues update requests that arrive during the zone transfer and processes them after the transfer is complete.

## How computers update their DNS names

By default, computers that are statically configured for TCP/IP attempt to dynamically register host (A) and pointer (PTR) resource records for IP addresses configured and used by their installed network connections. All computers register records based on their FQDN.

DNS clients don't attempt dynamic update of the following items:

- Over a remote access or virtual private network (VPN) connection. To modify this configuration, you can modify the advanced TCP/IP settings of the particular network connection or modify the registry.

- Top-level domain (TLD) zones. Any zone named with a single-label name is considered a TLD zone, for example, `com`, `edu`, `blank`, `my-company`.

Also by default, the primary DNS suffix portion of a computer’s FQDN is the same as the name of the Active Directory domain to which the computer is joined. To allow different primary DNS suffixes, a domain administrator can create a restricted list of allowed suffixes by modifying the **msDS-AllowedDNSSuffixes** attribute in the domain object container. A domain administrator can manage the attribute using Active Directory Service Interfaces (ADSI) or the Lightweight Directory Access Protocol (LDAP). Dynamic updates can be sent for any of the following reasons or events:

- An IP address is added, removed, or modified in the TCP/IP properties configuration for any one of the installed network connections.
- At startup time, when the computer is turned on.
- A member server is promoted to a domain controller.
- An IP address lease changes or renews with the DHCP server any one of the installed network connections, for example, when the computer is started or if the `ipconfig /renew` command is used.
- The `ipconfig /registerdns` command is used to manually force a refresh of the client name registration in DNS.

> [!IMPORTANT]
> If you use `ipconfig /registerdns`, the DNS client service attempts to directly register its DNS record, bypassing the DHCP server. This registration occurs even if the DHCP server is configured to **Always dynamically update DNS A and PTR records**. If the client doesn't have permission to update its resource record, the registration silently fails. If the DNS client has this permission, the resource record is updated. Permissions can be reset such that the DHCP server is no longer able to perform future updates on the resource record.  
> The recommended method to update DNS registration for DHCP clients running Windows is to use `ipconfig /renew`. Don't use `ipconfig /registerdns`.

When one of the previous events triggers a dynamic update, the DNS Client service sends updates. This trigger is designed so that if a change to the IP address information occurs, corresponding updates in DNS are performed to synchronize name-to-address mappings for the computer. The DNS Client service performs this function for all network connections used on the system, including connections not configured to use DHCP.

This update process assumes that installation defaults are in effect for servers running Windows Server. Specific names and update behavior is tunable where advanced TCP/IP properties are configured to use nondefault DNS settings.

In addition to the full computer name (or primary name) of the computer, connection-specific DNS names can be configured and optionally registered or updated in DNS.

## How dynamic update works

Dynamic updates are typically requested when either a DNS name or IP address changes on the computer. For example, suppose a client named `oldhost` is first configured with the following names:

- **Computer name**: `oldhost`
- **DNS domain name**: `example.contoso.com`
- **Full computer name**: `oldhost.example.contoso.com`

In this example, no connection-specific DNS domain names are configured for the computer. Later, the computer is renamed from `oldhost` to `newhost`, resulting in the following name changes on the system:

- **Computer name**: `newhost`
- **DNS domain name**: `example.contoso.com`
- **Full computer name**: `newhost.example.contoso.com`

After the name change is applied in System properties, you're prompted to restart the computer. When the computer restarts Windows, the DNS Client service performs the following sequence to update DNS:

1. The DNS Client service sends an SOA type query using the DNS domain name of the computer.

   The client computer uses the currently configured FQDN of the computer (such as `newhost.example.contoso.com`) as the name specified in this query.

1. The authoritative DNS server for the zone containing the client FQDN responds to the SOA-type query.

   For standard primary zones, the primary server (owner) returned in the SOA query response is fixed and static. It always matches the exact DNS name as it appears in the SOA resource record stored with the zone. If the zone being updated is directory-integrated, any DNS server running on a domain controller for the Active Directory domain in the FQDN can respond. It can dynamically insert its own name as the primary server (owner) of the zone in the SOA query response.

1. The DNS Client service then attempts to contact the primary DNS server.

   The client processes the SOA query response for its name to determine the IP address of the DNS server authorized as the primary server for accepting its name. It then proceeds to perform the following sequence of steps as needed to contact and dynamically update its primary server:

   - It sends a dynamic update request to the primary server determined in the SOA query response.
   - If the update succeeds, no further action is taken.
   - If this update fails, the client next sends an NS-type query for the zone name specified in the SOA record.
   - When it receives a response to this query, it sends an SOA query to the first DNS server listed in the response.

   After the SOA query is resolved, the client sends a dynamic update to the server specified in the returned SOA record.

   - If the update succeeds, no further action is taken.
   - If this update fails, then the client repeats the SOA query process by sending a request to the next DNS server listed in the response.

1. After the primary DNS server that can perform the update is contacted, the client sends the update request and the DNS server processes it.

   The contents of the update request include instructions to add A (and possibly PTR) resource records for `newhost.example.contoso.com` and remove these same record types for `oldhost.example.contoso.com`, the name that was previously registered.

   The DNS server also checks to ensure that updates are permitted for the client request. For standard primary zones, dynamic updates aren't secured, so any client update attempt succeeds. For Active Directory–integrated zones, updates are secured and performed using directory-based security settings. For more information, see the [Secure dynamic update](#secure-dynamic-update) section later in this article.

Dynamic updates are sent or refreshed periodically. By default, computers send a refresh once every seven days. If the update results in no changes to zone data, the zone remains at its current version and no changes are written. Updates result in zone changes or increased zone transfers only when names or addresses change.

Names aren't removed from DNS zones if they become inactive or aren't updated within the refresh interval (seven days). DNS doesn't have a mechanism to release or tombstone names. However, DNS clients try to delete old name records when a new name is applied. DNS clients also attempt to update name records when an address change occurs.

When the DNS Client service registers A and PTR resource records for a computer, it uses a default caching Time To Live (TTL) of 15 minutes for host records. This TTL determines how long other DNS servers and clients cache a computer’s records when they're included in a query response.

## Time to Live

Whenever a dynamic update client registers in DNS, the associated A and PTR resource records include the Time to Live (TTL). By default, the TTL is set to 10 minutes for records registered by the Netlogon service. For records registered by the DHCP Client service, the TTL is set to 15 minutes. If the DNS Server service dynamically registers records for its own zones, the default TTL is 20 minutes. You can change the default setting in the registry. A small value causes cached entries to expire sooner, which increases DNS traffic but decreases the risk of cached records becoming outdated. Expiring entries quickly is useful for computers that frequently renew their DHCP leases. Long retention times are useful for computers that renew their DHCP leases infrequently.

## Resolving name conflicts

When the DNS Client service attempts to register an A record, it checks if the authoritative DNS zone already contains an A record for the same name but with a different IP address. By default, the DNS Client service attempts to replace the existing A record (or records) with the new A record containing the IP address of the DNS client. As a result, any computer on the network can modify the existing A record unless secure dynamic update is used. Zones that are configured for secure dynamic update allow only authorized users to modify the resource record.

You can change the default setting so that the DNS Client service ends the registration process and logs the error in Event Viewer, instead of replacing the existing A record. For more information, see the [Secure dynamic update](#secure-dynamic-update) section later in this article.

## DNS and DHCP

Windows DNS clients are dynamic update-aware and can initiate the dynamic update process. A DNS client negotiates the process of dynamic update with the DHCP server when the client leases an IP address or renews the lease. This negotiation determines which computer updates the A and PTR resource records of the client. The DNS client and DHCP server negotiate who updates the records. The client and server send dynamic update requests to the primary DNS servers that are authoritative for the names to be updated.

The Windows Server DHCP Server service can update DNS records for clients that don't support the DHCP Client service FQDN option. This functionality can be enabled in the **DNS** tab of the server properties for the DHCP console. The DHCP server first obtains the name of legacy clients from the `DHCP REQUEST` packet. It then appends the domain name given for that scope and registers the A and PTR resource records.

In some cases, stale PTR, or A resource records can appear on DNS servers when the lease of a DHCP client expires. For example, when a DNS client tries to negotiate a dynamic update procedure with a DHCP server, the DNS client must register both A and PTR resource records itself. Later, if the client is improperly removed from the network, the client can't deregister its A and PTR resource records and they become stale.

If a stale A resource record appears in a zone that allows only secure dynamic updates, no computer is able to register any other resource record for the name in that A resource record. To prevent problems with stale PTR and A resource records, you can enable the aging and scavenging feature. For more information about the aging and scavenging feature, see [DNS aging and scavenging](aging-scavenging.md).

To provide fault tolerance for dynamic updates, consider Active Directory integration for those zones that accept dynamic updates from Windows clients. To speed up the discovery of authoritative DNS servers, you can configure each client with a list of preferred and alternate DNS servers that are primary for that directory-integrated zone. If a client fails to update the zone with its preferred DNS server because the DNS server is unavailable, the client can try an alternate server. When the preferred DNS server becomes available, it loads the updated, directory-integrated zone that includes the update from the client.

## Dynamic update process

In this section, we describe the dynamic update process for DHCP clients, statically configured clients, remote access clients, and multihomed clients.

### DHCP client process

To initiate the dynamic update process, the DHCP client sends its FQDN to the DHCP server in the `DHCPREQUEST` packet by using the DHCP Client service FQDN option. The DHCP server then replies to the DHCP client by sending a DHCP acknowledgment (`DHCPACK`) message that includes the FQDN option (option code 81).

The following table lists the fields of the FQDN option of the `DHCPREQUEST` packet.

| Field | Explanation |
| --- | --- |
| Code | Specifies the code for this option (81). |
| Len | Specifies the length, in octets, of this option (minimum of 4). |
| Flags | Can be one of the following values: </p> 0. Client wants to register the A resource record and requests that the server update the PTR resource record.</p> 1. Client wants server to register the A and PTR resource records.</p> 3. DHCP server registers the A and PTR resource records regardless of the request of the client. |
| `RCODE1` and `RCODE2` | The DHCP server uses these fields to specify the response code from the A and PTR resource records registrations performed on the client’s behalf and to indicate whether it attempted the update before sending `DHCPACK`. |
| Domain Name | Specifies the FQDN of the client. |

The conditions under which DHCP clients send the FQDN option depend on the operating system that the client is running and how the client is configured. The actions taken by DHCP servers also depend on the operating system that the server is running and how the server is configured.

By default, the Windows DHCP Client service uses the following process.

1. The Windows DHCP Client service sends the FQDN option with the Flags field set to 0. This flag requests that the client update the A resource record, and the DHCP Server service updates the PTR resource record.

1. The client waits for a response from the DHCP server. Unless the DHCP server sets the Flags field to 3, the DNS client then initiates an update for the A resource record.

1. If the DHCP server doesn't support or isn't configured for the registration of the DNS record, an FQDN isn't included in the response. In this case, the DNS client attempts to register the A and PTR resource records.

Depending on what the DHCP client requests, the DHCP server can take different actions.

If the DHCP client sends a `DHCPREQUEST` message without the FQDN option, the behavior depends on the type of DHCP server and its configuration. The DHCP server updates both records if you configure it to update records on behalf of DHCP clients that don't support the FQDN option.

In the following cases, the DHCP server doesn't perform any action:

- The DHCP server doesn't support dynamic update.

- The DHCP server is configured not to do dynamic updates for clients that don't support the FQDN option.

- The DHCP server is configured not to register DNS resource records.

If the Windows DHCP client requests that the server updates the PTR resource record but not the A resource record, the behavior depends on the type of DHCP server and its configuration.

The server can perform any of the following actions:

- If the Windows DHCP server is configured not to perform dynamic updates, it doesn't include the FQDN option in its response. It also doesn't update either resource record. In this case, the DNS client attempts to update both the A and PTR resource records if it's capable.

- If the Windows DHCP server is configured to update according to the request of the DHCP client, the server attempts to update the PTR resource record. The DHCP server sends a `DHCPACK` message to the DHCP client. This message contains the FQDN option with the Flags field set to `0`. The `DHCPACK` message confirms that the DHCP server updates the PTR record. The DNS client then attempts to update the A resource record, if it's capable.

- If the DHCP server is configured to always update A and PTR both records, the DHCP server attempts to update both resource records. The DHCP server `DHCPACK` message to the DHCP client contains the FQDN option with the Flags field set to `3`, notifying the DHCP client that the DHCP server updates A and PTR records. In this case, the DNS client doesn't attempt to update either resource record.

### Statically configured and remote access clients process

Statically configured clients and remote access clients don't rely on the DHCP server for DNS registration. Statically configured clients dynamically update their A and PTR resource records every time they start. Clients also update every 24 hours to refresh records in the DNS database.

Remote access clients can dynamically update A and PTR resource records when a dial-up connection is made. They can also attempt to withdraw, or deregister, the A and PTR resource records when the user closes down the connection explicitly. Computers running Windows Server with a remote access network connection attempt to dynamically register the A and PTR records for the IP address of this connection. By default, the DNS Client service on Windows client doesn't attempt dynamic update over a remote access or VPN connection. To modify this configuration, you can modify the advanced TCP/IP settings of the particular network connection or modify the registry.

In all operating systems, if a remote access client doesn't receive a successful response from the attempt to deregister a DNS resource record, or fails for any other reason to deregister a resource record within four seconds, the DNS client closes the connection. In such cases, the DNS database might contain a stale record.

If the remote access client fails to deregister a DNS resource record, it adds a message to the event log, which you can view by using Event Viewer. The remote access client never deletes stale records, but the remote access server attempts to deregister the PTR resource record when the client is disconnected.

By default, the Windows DNS Client service doesn't attempt to update A and PTR records automatically for dial-up connections.

### Multihomed client process

If a dynamic update client is multihomed, meaning the client has more than one network connection and associated IP address, it registers all IP addresses for each network connection. If you don't want it to register these IP addresses, you can configure the network connection to not register IP addresses.

The dynamic update client doesn't register all IP addresses with the DNS servers in all namespaces that the computer is connected to. For example, a multihomed computer, `client1.example.contoso.com`, is connected to both the Internet and the corporate intranet. The client is connected to the intranet by adapter A, a DHCP adapter with the IP address `172.16.8.7`. The client is also connected to the Internet by adapter B, a remote access adapter with the IP address `10.3.3.9`. The client resolves intranet names by using a name server on the intranet, and resolves Internet names by using a name server on the Internet.

## Secure dynamic update

DNS update security is available only for zones that are integrated into Active Directory. When you integrate a zone into Active Directory, access control lists (ACL) are available in the DNS console for you to add or remove users and groups from the ACL for a specified zone or resource record. ACLs are for DNS administration access control only, and don't influence DNS query resolution.

By default, dynamic update security for DNS servers and clients are handled as follows:

- DNS clients attempt to use unsecured dynamic update first. If an unsecured update is refused, clients try to use secure update.

  The default update policy permits clients to attempt to overwrite a previously registered resource record, unless blocked.

- After a zone becomes Active Directory–integrated, DNS servers running Windows Server default to allowing only secure dynamic updates.

  When you use file-based zone storage, the default for the DNS Server service is to not allow dynamic updates on its zones. For zones that are either directory-integrated or use standard file-based storage, you can change the zone to allow all dynamic updates. This setting permits all updates to be accepted.

Dynamic update is an addition to the DNS standard specification, defined in [RFC 2136](https://datatracker.ietf.org/doc/rfc2136/).

The dynamic registration of DNS resource records can be restricted with the use of registry entries.

## How secure dynamic update works

The secure dynamic update process is described as follows:

1. To initiate a secure dynamic update, the DNS client first initiates the security context negotiation process, during which the tokens are passed between client and server using TKEY resource records. At the end of the negotiation process, the security context is established.

1. The DNS client sends the dynamic update request to the DNS server. This request contains resource records for adding, deleting, or modifying data.

   1. The request is signed using the previously established security context.

   1. The signature is passed in the TSIG resource record, which is included in the dynamic update packet.

1. The server attempts to update Active Directory using the client’s credentials and sends the result of the update to the client. These results are also signed using the security context and the signature passed in the TSIG resource record included in the response.

### Secure dynamic update process

The secure dynamic update process is described as follows:

1. The DNS client queries the preferred DNS server to determine which DNS server is authoritative for the domain name it's attempting to update. The preferred DNS server responds with the name of the zone and the primary DNS server that is authoritative for the zone.

1. The DNS client attempts a standard dynamic update, and if the zone is configured to allow only secure dynamic updates (the default configuration for Active Directory-integrated zones), the DNS server refuses the nonsecure update. If the zone is configured for standard dynamic update rather than secure dynamic update, the DNS server accepts the DNS client’s attempt to add, delete, or modify resource records in that zone.

1. The DNS client and DNS server begin TKEY negotiation.

   1. The DNS client, and DNS server negotiate an underlying security mechanism. Windows dynamic update clients and DNS servers can only use the Kerberos protocol.

   1. Using the security mechanism, the DNS client, and DNS server verify their respective identities and establish the security context.

1. The DNS client sends the dynamic update request to the DNS server, signed using the established security context. The signature is included in the signature field of the TSIG resource record that is included in the dynamic update request packet. The DNS server verifies the origin of the dynamic update packet by using the security context and the TSIG signature.

1. The DNS server attempts to add, delete, or modify resource records in Active Directory. The update depends on whether the DNS client has the proper permissions and if the prerequisites are satisfied.

1. The DNS server sends a reply to the DNS client stating whether it was able to make the update, signed using the established security context. The signature is included in the signature field of the TSIG resource record that is included in the dynamic update response packet. If the DNS client receives a spoofed reply, it ignores it and waits for a signed response.

### Security for DHCP clients that don't support the FQDN option

Windows DHCP clients that don't support the FQDN option (option 81) aren't capable of dynamic updates. If you want the A and PTR resource records for these clients dynamically registered in DNS, you must configure the DHCP server to perform dynamic updates on their behalf.

Having the DHCP server perform secure dynamic updates on behalf of DHCP clients that don't support the FQDN option requires extra configuration to avoid a permission issue. When a DHCP server performs a secure dynamic update on a name, it becomes the owner of that name. Only that DHCP server can update any record for that name.

For example, suppose that the DHCP server DHCP1 created an object for the name `host1.example.com` and then stopped responding, and that later the backup DHCP server, DHCP2, tried to update a record for the same name, `host1.example.com`. In this situation, DHCP2 isn't able to update the name because it doesn't own the name.

To avoid this issue, use the built-in security group called _DnsUpdateProxy_. If you add all DHCP servers as members of the DnsUpdateProxy group, another server can update one server’s records if the first server fails. Also, because all objects created by the members of the DnsUpdateProxy group aren't secured, the first user to modify the set of records associated with a DNS name becomes its owner. When legacy clients are upgraded, they can take ownership of their name records at the DNS server. If every DHCP server registering resource records for older clients are a member of the DnsUpdateProxy group, the problems discussed earlier don't occur.

### Securing records using the DnsUpdateProxy group

When the DHCP server is a member of the DnsUpdateProxy group, it doesn't secure the DNS domain names it registers. As a result, don't use this group in an Active Directory integrated-zone that allows only secure dynamic updates without taking more steps to allow records created by members of the group to be secured.

To protect against unsecured records or to allow members of the DnsUpdateProxy group to register records in zones that allow only secured dynamic updates, create a dedicated user account. Using the credentials of this user account, configure DHCP servers to perform DNS dynamic updates. Multiple DHCP servers can use the credentials of one dedicated user account.

The dedicated user account is a standard user account used only to supply DHCP servers with credentials for DNS dynamic update registration. Each DHCP server supplies these credentials when registering names on behalf of DHCP clients using DNS dynamic update. The dedicated user account is created in the same forest where the primary DNS server for the zone to be updated resides. The dedicated user account can also be located in another forest as long as the forest it resides in has a forest trust established with the forest containing the primary DNS server for the zone to be updated.

When installed on a domain controller, the DHCP Server service inherits the security permissions of the domain controller. Meaning it has the authority to update or delete any DNS record that is registered in a secure Active Directory-integrated zone. Other computers running Windows Server, such as domain controllers, securely register these records. When installed on a domain controller, configure the DHCP server with the credentials of the dedicated user account to prevent the server from inheriting, and possibly misusing, the privileges of the domain controller.

Configure a dedicated user account and configure the DHCP Server service with the account credentials under the following circumstances:

- A domain controller is configured to function as a DHCP server.
- The DHCP server is configured to perform DNS dynamic updates on behalf of DHCP clients.
- The DHCP server updates DNS zones that are configured to allow only secure dynamic updates.

After you create a dedicated user account, you can configure DHCP servers with the user account credentials by using the DHCP console or by using the command `netsh dhcp server set dnscredentials`.

> [!NOTE]
>
> - If the supplied credentials belong to an object that is a member of the DnsUpdateProxy security group, the next object to register the same name record in DNS will become the record owner.  
>
> - If you specify credentials for the DHCP server to use when registering DHCP client computers in DNS, these credentials aren't backed up. After a DHCP database is restored, new credentials must be configured.  
