---
title: Connection Request Policies
description: This topic provides an overview of Network Policy Server connection request policies in Windows Server 2016.
manager: brianlic
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: 4ec45e0c-6b37-4dfb-8158-5f40677b0157
ms.author: lizross 
author: eross-msft
---

# Connection Request Policies

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this topic to learn how to use NPS connection request policies to configure the NPS as a RADIUS server, a RADIUS proxy, or both.

>[!NOTE]
>In addition to this topic, the following connection request policy documentation is available.
> - [Configure Connection Request Policies](nps-crp-configure.md)
> - [Configure Remote RADIUS Server Groups](nps-crp-rrsg-configure.md)

Connection request policies are sets of conditions and settings that allow network administrators to designate which Remote Authentication Dial-In User Service (RADIUS) servers perform the authentication and authorization of connection requests that the server running Network Policy Server (NPS) receives from RADIUS clients. Connection request policies can be configured to designate which RADIUS servers are used for RADIUS accounting.

You can create connection request policies so that some RADIUS request messages sent from RADIUS clients are processed locally (NPS is used as a RADIUS server) and other types of messages are forwarded to another RADIUS server (NPS is used as a RADIUS proxy).

With connection request policies, you can use NPS as a RADIUS server or as a RADIUS proxy, based on factors such as the following: 

- The time of day and day of the week
- The realm name in the connection request
- The type of connection being requested
- The IP address of the RADIUS client

RADIUS Access-Request messages are processed or forwarded by NPS only if the settings of the incoming message match at least one of the connection request policies configured on the NPS. 

If the policy settings match and the policy requires that the NPS process the message, NPS acts as a RADIUS server, authenticating and authorizing the connection request. If the policy settings match and the policy requires that the NPS forwards the message, NPS acts as a RADIUS proxy and forwards the connection request to a remote RADIUS server for processing.

If the settings of an incoming RADIUS Access-Request message do not match at least one of the connection request policies, an Access-Reject message is sent to the RADIUS client and the user or computer attempting to connect to the network is denied access.

## Configuration examples

The following configuration examples demonstrate how you can use connection request policies.

### NPS as a RADIUS server

The default connection request policy is the only configured policy. In this example, NPS is configured as a RADIUS server and all connection requests are processed by the local NPS. The NPS can authenticate and authorize users whose accounts are in the domain of the NPS domain and in trusted domains.


### NPS as a RADIUS proxy

The default connection request policy is deleted, and two new connection request policies are created to forward requests to two different domains. In this example, NPS is configured as a RADIUS proxy. NPS does not process any connection requests on the local server. Instead, it forwards connection requests to NPS or other RADIUS servers that are configured as members of remote RADIUS server groups.


### NPS as both RADIUS server and RADIUS proxy

In addition to the default connection request policy, a new connection request policy is created that forwards connection requests to an NPS or other RADIUS server in an untrusted domain. In this example, the proxy policy appears first in the ordered list of policies. If the connection request matches the proxy policy, the connection request is forwarded to the RADIUS server in the remote RADIUS server group. If the connection request does not match the proxy policy but does match the default connection request policy, NPS processes the connection request on the local server. If the connection request does not match either policy, it is discarded.

### NPS as RADIUS server with remote accounting servers

In this example, the local NPS is not configured to perform accounting and the default connection request policy is revised so that RADIUS accounting messages are forwarded to an NPS or other RADIUS server in a remote RADIUS server group. Although accounting messages are forwarded, authentication and authorization messages are not forwarded, and the local NPS performs these functions for the local domain and all trusted domains.


### NPS with Remote RADIUS to Windows User Mapping

In this example, NPS acts as both a RADIUS server and as a RADIUS proxy for each individual connection request by forwarding the authentication request to a remote RADIUS server while using a local Windows user account for authorization. This configuration is implemented by configuring the Remote RADIUS to Windows User Mapping attribute as a condition of the connection request policy. (In addition, a user account must be created locally that has the same name as the remote user account against which authentication is performed by the remote RADIUS server.)

## Connection request policy conditions

Connection request policy conditions are one or more RADIUS attributes that are compared to the attributes of the incoming RADIUS Access-Request message. If there are multiple conditions, then all of the conditions in the connection request message and in the connection request policy must match in order for the policy to be enforced by NPS.


Following are the available condition attributes that you can configure in connection request policies.

### Connection Properties attribute group

The Connection Properties attribute group contains the following attributes.

- **Framed Protocol**. Used to designate the type of framing for incoming packets. Examples are Point-to-Point Protocol (PPP), Serial Line Internet Protocol (SLIP), Frame Relay, and X.25.
- **Service Type**. Used to designate the type of service being requested. Examples include framed (for example, PPP connections) and login (for example, Telnet connections). For more information about RADIUS service types, see RFC 2865, "Remote Authentication Dial-in User Service (RADIUS)."
- **Tunnel Type**. Used to designate the type of tunnel that is being created by the requesting client. Tunnel types include the Point-to-Point Tunneling Protocol (PPTP) and the Layer Two Tunneling Protocol (L2TP).

### Day and Time Restrictions attribute group 

The Day and Time Restrictions attribute group contains the Day and Time Restrictions attribute. With this attribute, you can designate the day of the week and the time of day of the connection attempt. The day and time is relative to the day and time of the NPS.

### Gateway attribute group

The Gateway attribute group contains the following attributes.

- **Called Station ID**. Used to designate the phone number of the network access server. This attribute is a character string. You can use pattern-matching syntax to specify area codes.
- **NAS Identifier**. Used to designate the name of the network access server. This attribute is a character string. You can use pattern-matching syntax to specify NAS identifiers.
- **NAS IPv4 Address**. Used to designate the Internet Protocol version 4 (IPv4) address of the network access server (the RADIUS client). This attribute is a character string. You can use pattern-matching syntax to specify IP networks.
- **NAS IPv6 Address**. Used to designate the Internet Protocol version 6 (IPv6) address of the network access server (the RADIUS client). This attribute is a character string. You can use pattern-matching syntax to specify IP networks.
- **NAS Port Type**. Used to designate the type of media used by the access client. Examples are analog phone lines (known as async ), Integrated Services Digital Network (ISDN), tunnels or virtual private networks (VPNs), IEEE 802.11 wireless, and Ethernet switches.

### Machine Identity attribute group

The Machine Identity attribute group contains the Machine Identity attribute. By using this attribute, you can specify the method with which clients are identified in the policy.

### RADIUS Client Properties attribute group

The RADIUS Client Properties attribute group contains the following attributes.

- **Calling Station ID**. Used to designate the phone number used by the caller (the access client). This attribute is a character string. You can use pattern-matching syntax to specify area codes.  In 802.1x authentications the MAC Address is typically populated and can be matched from the client.  This field is typically used for Mac Address Bypass scenarios when the connection request policy is configured for 'Accept users without validating credentials'.  
- **Client Friendly Name**. Used to designate the name of the RADIUS client computer that is requesting authentication. This attribute is a character string. You can use pattern-matching syntax to specify client names.
- **Client IPv4 Address**. Used to designate the IPv4 address of the network access server (the RADIUS client). This attribute is a character string. You can use pattern-matching syntax to specify IP networks.
- **Client IPv6 Address**. Used to designate the IPv6 address of the network access server (the RADIUS client). This attribute is a character string. You can use pattern-matching syntax to specify IP networks.
- **Client Vendor**. Used to designate the vendor of the network access server that is requesting authentication. A computer running the Routing and Remote Access service is the Microsoft NAS manufacturer. You can use this attribute to configure separate policies for different NAS manufacturers. This attribute is a character string. You can use pattern-matching syntax.

### User Name attribute group

The User Name attribute group contains the User Name attribute. By using this attribute, you can designate the user name, or a portion of the user name, that must match the user name supplied by the access client in the RADIUS message. This attribute is a character string that typically contains a realm name and a user account name. You can use pattern-matching syntax to specify user names.

## Connection request policy settings

Connection request policy settings are a set of properties that are applied to an incoming RADIUS message. Settings consist of the following groups of properties.

- Authentication
- Accounting
- Attribute manipulation
- Forwarding request
- Advanced

The following sections provide additional detail about these settings.

### Authentication

By using this setting, you can override the authentication settings that are configured in all network policies and you can designate the authentication methods and types that are required to connect to your network.

>[!IMPORTANT]
>If you configure an authentication method in connection request policy that is less secure than the authentication method you configure in network policy, the more secure authentication method that you configure in network policy is overridden. For example, if you have one network policy that requires the use of Protected Extensible Authentication Protocol-Microsoft Challenge Handshake Authentication Protocol version 2 \(PEAP-MS-CHAP v2\), which is a password-based authentication method for secure wireless, and you also configure a connection request policy to allow unauthenticated access, the result is that no clients are required to authenticate by using PEAP-MS-CHAP v2. In this example, all clients connecting to your network are granted unauthenticated access.

### Accounting

By using this setting, you can configure connection request policy to forward accounting information to an NPS or other RADIUS server in a remote RADIUS server group so that the remote RADIUS server group performs accounting.

>[!NOTE]
>If you have multiple RADIUS servers and you want accounting information for all servers stored in one central RADIUS accounting database, you can use the connection request policy accounting setting in a policy on each RADIUS server to forward accounting data from all of the servers to one NPS or other RADIUS server that is designated as an accounting server.

Connection request policy accounting settings function independent of the accounting configuration of the local NPS. In other words, if you configure the local NPS to log RADIUS accounting information to a local file or to a Microsoft SQL Server database, it will do so regardless of whether you configure a connection request policy to forward accounting messages to a remote RADIUS server group.

If you want accounting information logged remotely but not locally, you must configure the local NPS to not perform accounting, while also configuring accounting in a connection request policy to forward accounting data to a remote RADIUS server group.

### Attribute manipulation

You can configure a set of find-and-replace rules that manipulate the text strings of one of the following attributes.

- User Name
- Called Station ID
- Calling Station ID

Find-and-replace rule processing occurs for one of the preceding attributes before the RADIUS message is subject to authentication and accounting settings. Attribute manipulation rules apply only to a single attribute. You cannot configure attribute manipulation rules for each attribute. In addition, the list of attributes that you can manipulate is a static list; you cannot add to the list of attributes available for manipulation.

>[!NOTE]
>If you are using the MS-CHAP v2 authentication protocol, you cannot manipulate the User Name attribute if the connection request policy is used to forward the RADIUS message. The only exception occurs when a backslash (\) character is used and the manipulation only affects the information to the left of it. A backslash character is typically used to indicate a domain name (the information to the left of the backslash character) and a user account name within the domain (the information to the right of the backslash character). In this case, only attribute manipulation rules that modify or replace the domain name are allowed.

For examples of how to manipulate the realm name in the User Name attribute, see the section "Examples for manipulation of the realm name in the User Name attribute" in the topic [Use Regular Expressions in NPS](nps-crp-reg-expressions.md).

### Forwarding request

You can set the following forwarding request options that are used for RADIUS Access-Request messages:

- **Authenticate requests on this server**. By using this setting, NPS uses a Windows NT 4.0 domain, Active Directory, or the local Security Accounts Manager (SAM) user accounts database to authenticate the connection request. This setting also specifies that the matching network policy configured in NPS, along with the dial-in properties of the user account, are used by NPS to authorize the connection request. In this case, the NPS is configured to perform as a RADIUS server.

- **Forward requests to the following remote RADIUS server group**. By using this setting, NPS forwards connection requests to the remote RADIUS server group that you specify. If the NPS receives a valid Access-Accept message that corresponds to the Access-Request message, the connection attempt is considered authenticated and authorized. In this case, the NPS acts as a RADIUS proxy.

- **Accept users without validating credentials**. By using this setting, NPS does not verify the identity of the user attempting to connect to the network and NPS does not attempt to verify that the user or computer has the right to connect to the network. When NPS is configured to allow unauthenticated access and it receives a connection request, NPS immediately sends an Access-Accept message to the RADIUS client and the user or computer is granted network access. This setting is used for some types of compulsory tunneling where the access client is tunneled before user credentials are authenticated.

>[!NOTE]
>This authentication option cannot be used when the authentication protocol of the access client is MS-CHAP v2 or Extensible Authentication Protocol-Transport Layer Security (EAP-TLS), both of which provide mutual authentication. In mutual authentication, the access client proves that it is a valid access client to the authenticating server (the NPS), and the authenticating server proves that it is a valid authenticating server to the access client. When this authentication option is used, the Access-Accept message is returned. However, the authenticating server does not provide validation to the access client, and mutual authentication fails.

For examples of how to use regular expressions to create routing rules that forward RADIUS messages with a specified realm name to a remote RADIUS server group, see the section "Example for RADIUS message forwarding by a proxy server" in the topic [Use Regular Expressions in NPS](nps-crp-reg-expressions.md).

### Advanced

You can set advanced properties to specify the series of RADIUS attributes that are:

- Added to the RADIUS response message when the NPS is being used as a RADIUS authentication or accounting server. When there are attributes specified on both a network policy and the connection request policy, the attributes that are sent in the RADIUS response message are the combination of the two sets of attributes.
- Added to the RADIUS message when the NPS is being used as a RADIUS authentication or accounting proxy. If the attribute already exists in the message that is forwarded, it is replaced with the value of the attribute specified in the connection request policy. 

In addition, some attributes that are available for configuration on the connection request policy **Settings** tab in the **Advanced** category provide specialized functionality. For example, you can configure the **Remote RADIUS to Windows User Mapping** attribute when you want to split the authentication and authorization of a connection request between two user accounts databases.

The **Remote RADIUS to Windows User Mapping** attribute specifies that Windows authorization occurs for users who are authenticated by a remote RADIUS server. In other words, a remote RADIUS server performs authentication against a user account in a remote user accounts database, but the local NPS authorizes the connection request against a user account in a local user accounts database. This is useful when you want to allow visitors access to your network.

For example, visitors from partner organizations can be authenticated by their own partner organization RADIUS server, and then use a Windows user account at your organization to access a guest local area network (LAN) on your network.

Other attributes that provide specialized functionality are:

- **MS-Quarantine-IPFilter and MS-Quarantine-Session-Timeout**. These attributes are used when you deploy Network Access Quarantine Control (NAQC) with your Routing and Remote Access VPN deployment.
- **Passport-User-Mapping-UPN-Suffix**. This attribute allows you to authenticate connection requests with Windows Live™ ID user account credentials.
- **Tunnel-Tag**. This attribute designates the VLAN ID number to which the connection should be assigned by the NAS when you deploy virtual local area networks (VLANs).

## Default connection request policy

A default connection request policy is created when you install NPS. This policy has the following configuration.

- Authentication is not configured.
- Accounting is not configured to forward accounting information to a remote RADIUS server group.
- Attribute is not configured with attribute manipulation rules that forward connection requests to remote RADIUS server groups.
- Forwarding Request is configured so that connection requests are authenticated and authorized on the local NPS.
- Advanced attributes are not configured.

The default connection request policy uses NPS as a RADIUS server. To configure a server running NPS to act as a RADIUS proxy, you must also configure a remote RADIUS server group. You can create a new remote RADIUS server group while you are creating a new connection request policy by using the New Connection Request Policy Wizard. You can either delete the default connection request policy or verify that the default connection request policy is the last policy processed by NPS by placing it last in the ordered list of policies.

>[!NOTE]
>If NPS and the Remote Access service are installed on the same computer, and the Remote Access service is configured for Windows authentication and accounting, it is possible for Remote Access authentication and accounting requests to be forwarded to a RADIUS server. This can occur when Remote Access authentication and accounting requests match a connection request policy that is configured to forward them to a remote RADIUS server group.
