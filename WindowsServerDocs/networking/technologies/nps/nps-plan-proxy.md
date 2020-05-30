---
title: Plan NPS as a RADIUS proxy
description: This topic provides information about Network Policy Server RADIUS proxy deployment planning in Windows Server 2016.
manager: brianlic
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: ca77d64a-065b-4bf2-8252-3e75f71b7734
ms.author: lizross 
author: eross-msft
---

# Plan NPS as a RADIUS proxy

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

When you deploy Network Policy Server (NPS) as a Remote Authentication Dial-In User Service \(RADIUS\) proxy, NPS receives connection requests from RADIUS clients, such as network access servers or other RADIUS proxies, and then forwards these connection requests to servers running NPS or other RADIUS servers. You can use these planning guidelines to simplify your RADIUS deployment.

These planning guidelines do not include circumstances in which you want to deploy NPS as a RADIUS server. When you deploy NPS as a RADIUS server, NPS performs authentication, authorization, and accounting for connection requests for the local domain and for domains that trust the local domain.

Before you deploy NPS as a RADIUS proxy on your network, use the following guidelines to plan your deployment.

- Plan NPS configuration.

- Plan RADIUS clients.

- Plan remote RADIUS server groups.

- Plan attribute manipulation rules for message forwarding.

- Plan connection request policies.

- Plan NPS accounting.

## Plan NPS configuration

When you use NPS as a RADIUS proxy, NPS forwards connection requests to an NPS or other RADIUS servers for processing. Because of this, the domain membership of the NPS proxy is irrelevant. The proxy does not need to be registered in Active Directory Domain Services \(AD DS\) because it does not need access to the dial-in properties of user accounts. In addition, you do not need to configure network policies on an NPS proxy because the proxy does not perform authorization for connection requests. The NPS proxy can be a domain member or it can be a stand-alone server with no domain membership.

NPS must be configured to communicate with RADIUS clients, also called network access servers, by using the RADIUS protocol. In addition, you can configure the types of events that NPS records in the event log and you can enter a description for the server.

### Key steps

During the planning for NPS proxy configuration, you can use the following steps.

- Determine the RADIUS ports that the NPS proxy uses to receive RADIUS messages from RADIUS clients and to send RADIUS messages to members of remote RADIUS server groups. The default User Datagram Protocol (UDP) ports are 1812 and 1645 for RADIUS authentication messages and UDP ports 1813 and 1646 for RADIUS accounting messages.

- If the NPS proxy is configured with multiple network adapters, determine the adapters over which you want RADIUS traffic to be allowed.

- Determine the types of events that you want NPS to record in the Event Log. You can log rejected connection requests, successful connection requests, or both.

- Determine whether you are deploying more than one NPS proxy. To provide fault tolerance, use at least two NPS proxies. One NPS proxy is used as the primary RADIUS proxy and the other is used as a backup. Each RADIUS client is then configured on both NPS proxies. If the primary NPS proxy becomes unavailable, RADIUS clients then send Access-Request messages to the alternate NPS proxy.

- Plan the script used to copy one NPS proxy configuration to other NPS proxies to save on administrative overhead and to prevent the incorrect configuration of a server. NPS provides the Netsh commands that allow you to copy all or part of an NPS proxy configuration for import onto another NPS proxy. You can run the commands manually at the Netsh prompt. However, if you save your command sequence as a script, you can run the script at a later date if you decide to change your proxy configurations.

## Plan RADIUS clients

RADIUS clients are network access servers, such as wireless access points, virtual private network \(VPN\) servers, 802.1X-capable switches, and dial-up servers. RADIUS proxies, which forward connection request messages to RADIUS servers, are also RADIUS clients. NPS supports all network access servers and RADIUS proxies that comply with the RADIUS protocol, as described in RFC 2865, "Remote Authentication Dial-in User Service \(RADIUS\)," and RFC 2866, "RADIUS Accounting."

In addition, both wireless access points and switches must be capable of 802.1X authentication. If you want to deploy Extensible Authentication Protocol (EAP) or Protected Extensible Authentication Protocol (PEAP), access points and switches must support the use of EAP.

To test basic interoperability for PPP connections for wireless access points, configure the access point and the access client to use Password Authentication Protocol (PAP). Use additional PPP-based authentication protocols, such as PEAP, until you have tested the ones that you intend to use for network access.

### Key steps

During the planning for RADIUS clients, you can use the following steps.

- Document the vendor-specific attributes (VSAs) you must configure in NPS. If your NASs require VSAs, log the VSA information for later use when you configure your network policies in NPS.

- Document the IP addresses of RADIUS clients and your NPS proxy to simplify the configuration of all devices. When you deploy your RADIUS clients, you must configure them to use the RADIUS protocol, with the NPS proxy IP address entered as the authenticating server. And when you configure NPS to communicate with your RADIUS clients, you must enter the RADIUS client IP addresses into the NPS snap-in.

- Create shared secrets for configuration on the RADIUS clients and in the NPS snap-in. You must configure RADIUS clients with a shared secret, or password, that you will also enter into the NPS snap-in while configuring RADIUS clients in NPS.

## Plan remote RADIUS server groups

When you configure a remote RADIUS server group on an NPS proxy, you are telling the NPS proxy where to send some or all connection request messages that it receives from network access servers and NPS proxies or other RADIUS proxies.

You can use NPS as a RADIUS proxy to forward connection requests to one or more remote RADIUS server groups, and each group can contain one or more RADIUS servers. When you want the NPS proxy to forward messages to multiple groups, configure one connection request policy per group. The connection request policy contains additional information, such as attribute manipulation rules, that tell the NPS proxy which messages to send to the remote RADIUS server group specified in the policy.

You can configure remote RADIUS server groups by using the Netsh commands for NPS, by configuring groups directly in the NPS snap-in under Remote RADIUS Server Groups, or by running the New Connection Request Policy wizard.

### Key steps

During the planning for remote RADIUS server groups, you can use the following steps.

- Determine the domains that contain the RADIUS servers to which you want the NPS proxy to forward connection requests. These domains contain the user accounts for users that connect to the network through the RADIUS clients you deploy.

- Determine whether you need to add new RADIUS servers in domains where RADIUS is not already deployed.

- Document the IP addresses of RADIUS servers that you want to add to remote RADIUS server groups.

- Determine how many remote RADIUS server groups you need to create. In some cases, it is best to create one remote RADIUS server group per domain, and then add the RADIUS servers for the domain to the group. However, there might be cases in which you have a large amount of resources in one domain, including a large number of users with user accounts in the domain, a large number of domain controllers, and a large number of RADIUS servers. Or your domain might cover a large geographical area, causing you to have network access servers and RADIUS servers in locations that are distant from each other. In these and possibly other cases, you can create multiple remote RADIUS server groups per domain.

- Create shared secrets for configuration on the NPS proxy and on the remote RADIUS servers.

## Plan attribute manipulation rules for message forwarding

Attribute manipulation rules, which are configured in connection request policies, allow you to identify the Access-Request messages that you want to forward to a specific remote RADIUS server group.

You can configure NPS to forward all connection requests to one remote RADIUS server group without using attribute manipulation rules.

If you have more than one location to which you want to forward connection requests, however, you must create a connection request policy for each location, then configure the policy with the remote RADIUS server group to which you want to forward messages as well as with the attribute manipulation rules that tell NPS which messages to forward.

You can create rules for the following attributes.

- Called-Station-ID. The phone number of the network access server (NAS). The value of this attribute is a character string. You can use pattern-matching syntax to specify area codes.

- Calling-Station-ID. The phone number used by the caller. The value of this attribute is a character string. You can use pattern-matching syntax to specify area codes.

- User-Name. The user name that is provided by the access client and that is included by the NAS in the RADIUS Access-Request message. The value of this attribute is a character string that typically contains a realm name and a user account name.

To correctly replace or convert realm names in the user name of a connection request, you must configure attribute manipulation rules for the User-Name attribute on the appropriate connection request policy.

### Key steps

During the planning for attribute manipulation rules, you can use the following steps.

- Plan message routing from the NAS through the proxy to the remote RADIUS servers to verify that you have a logical path with which to forward messages to the RADIUS servers.

- Determine one or more attributes that you want to use for each connection request policy.

- Document the attribute manipulation rules that you plan to use for each connection request policy, and match the rules to the remote RADIUS server group to which messages are forwarded.

## Plan connection request policies

The default connection request policy is configured for NPS when it is used as a RADIUS server. Additional connection request policies can be used to define more specific conditions, create attribute manipulation rules that tell NPS which messages to forward to remote RADIUS server groups, and to specify advanced attributes. Use the New Connection Request Policy Wizard to create either common or custom connection request policies.

### Key steps

During the planning for connection request policies, you can use the following steps.

- Delete the default connection request policy on each server running NPS that functions solely as a RADIUS proxy.

- Plan additional conditions and settings that are required for each policy, combining this information with the remote RADIUS server group and the attribute manipulation rules planned for the policy.

- Design the plan to distribute common connection request policies to all NPS proxies. Create policies common to multiple NPS proxies on one NPS, and then use the Netsh commands for NPS to import the connection request policies and server configuration on all other proxies.

## Plan NPS accounting

When you configure NPS as a RADIUS proxy, you can configure it to perform RADIUS accounting by using NPS format log files, database-compatible format log files, or NPS SQL Server logging.

You can also forward accounting messages to a remote RADIUS server group that performs accounting by using one of these logging formats.

### Key steps

During the planning for NPS accounting, you can use the following steps.

- Determine whether you want the NPS proxy to perform accounting services or to forward accounting messages to a remote RADIUS server group for accounting.

- Plan to disable local NPS proxy accounting if you plan to forward accounting messages to other servers.

- Plan connection request policy configuration steps if you plan to forward accounting messages to other servers. If you disable local accounting for the NPS proxy, each connection request policy that you configure on that proxy must have accounting message forwarding enabled and configured properly.

- Determine the logging format that you want to use: IAS format log files, database-compatible format log files, or NPS SQL Server logging.

To configure load balancing for NPS as a RADIUS proxy, see [NPS Proxy Server Load Balancing](nps-manage-proxy-lb.md).

