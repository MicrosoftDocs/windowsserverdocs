---
title: Network Policy Server (NPS) overview
description: Learn about using Network Policy Server (NPS) in Windows Server to manage network access authentication, authorization, and accounting.
ms.topic: overview
ms.author: roharwoo
author: robinharwood
ms.date: 05/05/2025
# customer intent: As an administrator, I want to become familiar with Network Policy Server (NPS) in Windows Server so that I can centrally configure and manage network access authentication, authorization, and accounting.
---

# Network Policy Server overview

This article provides an overview of the Network Policy Server (NPS) in Windows Server. You can use NPS to create and enforce organization-wide network access policies for connection request authentication and authorization. You can also configure NPS as a Remote Authentication Dial-In User Service (RADIUS) proxy. When you use NPS as a RADIUS proxy, NPS forwards connection requests to a remote NPS RADIUS server or other RADIUS servers. You can use the proxy configuration to load-balance connection requests and forward them to the correct domain for authentication and authorization. NPS is installed when you install the Network Policy and Access Services (NPAS) role in Windows Server.

## NPS features

You can use NPS to centrally configure and manage network access authentication, authorization, and accounting. NPS offers the following features for that purpose:

- **RADIUS server**. NPS performs centralized authentication, authorization, and accounting for wireless, authenticating switch, remote access dial-up, and virtual private network (VPN) connections. When you use NPS as a RADIUS server, you configure the following components:
  - Network access servers, such as wireless access points and VPN servers. You configure them as RADIUS clients in NPS.
  - Network policies that NPS uses to authorize connection requests.
  - RADIUS accounting. This component is optional. If you configure it, NPS logs accounting information to log files on the local hard disk or in a Microsoft SQL Server database.

  For more information, see [RADIUS server](#radius-server).

- **RADIUS proxy**. When you use NPS as a RADIUS proxy, you configure connection request policies that tell NPS:
  - Specify which connection requests should be forwarded to other RADIUS servers.
    - Define the target RADIUS servers to which these connection requests are forwarded.

  Additionally, you can configure NPS to forward accounting data for logging purposes to one or more computers within a remote RADIUS server group. To configure NPS as a RADIUS proxy server, see the following resources:

  - [RADIUS proxy](#radius-proxy)
  - [Configure connection request policies](nps-crp-configure.md)

- **RADIUS accounting**. You can configure NPS to log events to a local log file or to a local or remote instance of SQL Server. For more information, see [NPS logging](#nps-logging).

You can configure NPS with any combination of these features. For example, you can configure one NPS deployment as a RADIUS server for VPN connections. You can also configure that same deployment as a RADIUS proxy to forward certain connection requests. Specifically, it can forward some requests to members of a remote RADIUS server group for authentication and authorization in another domain.

> [!IMPORTANT]
> In previous versions of Windows Server, NPAS included Network Access Protection (NAP), Health Registration Authority (HRA), and Host Credential Authorization Protocol (HCAP). NAP, HRA, and HCAP were deprecated in Windows Server 2012 R2, and aren't available in Windows Server 2016 or later. If you have a NAP deployment that uses operating systems earlier than Windows Server 2016, you can't migrate your NAP deployment to Windows Server 2016 or later.

## Windows Server installation options and NPS

The availability of NPS functionality depends on the options that you select when you install Windows Server:

- When you use the Server with Desktop Experience installation option, the NPAS role is available on Windows Server. The role is available on the Standard and Datacenter editions.
- When you use the Server Core installation option, the NPAS role isn't available.

## RADIUS server and proxy

You can use NPS as a RADIUS server, a RADIUS proxy, or both. The following sections provide detailed information about these uses.

### RADIUS server

NPS is the Microsoft implementation of the RADIUS standard specified by the Internet Engineering Task Force (IETF) in Request for Comments (RFCs) [2865](https://datatracker.ietf.org/doc/rfc2865/) and [2866](https://datatracker.ietf.org/doc/rfc2866/). As a RADIUS server, NPS performs centralized connection authentication, authorization, and accounting for many types of network access. Examples of network access types include wireless, authenticating switch, dial-up, and VPN remote access, and router-to-router connections.

> [!NOTE]
> For information on deploying NPS as a RADIUS server, see [Deploy Network Policy Server](nps-deploy.md).

NPS supports the use of a heterogeneous set of wireless, switch, remote access, or VPN equipment. You can use NPS with the Remote Access service, which is available in Windows Server.

NPS uses an Active Directory Domain Services (AD DS) domain or the local Security Accounts Manager (SAM) user accounts database to authenticate user credentials for connection attempts. When a server running NPS is a member of an AD DS domain, NPS uses the directory service as its user account database. In this case, NPS is part of a single sign-on solution. The same set of credentials is used for network access control (authenticating and authorizing access to a network) and to sign in to an AD DS domain.

> [!NOTE]
> NPS uses the dial-in properties of the user account and network policies to authorize a connection.

Internet service providers (ISPs) and organizations that maintain network access have an increased challenge. They need to manage all types of network access from a single point of administration, regardless of the type of network access equipment used. The RADIUS standard supports this functionality in both homogeneous and heterogeneous environments. RADIUS is a client-server protocol that enables network access equipment (used as RADIUS clients) to submit authentication and accounting requests to a RADIUS server.

A RADIUS server has access to user account information and can check network access authentication credentials. If user credentials are authenticated and the connection attempt is authorized, the RADIUS server authorizes user access based on specified conditions. Then the RADIUS server logs the network access connection in an accounting log. The use of RADIUS allows the data for network access user authentication, authorization, and accounting to be collected and maintained in a central location, rather than on each access server.

#### Use NPS as a RADIUS server

You can use NPS as a RADIUS server in the following cases:

- You're using an AD DS domain or the local SAM user accounts database as your user account database for access clients.
- You're using Remote Access on multiple dial-up servers, VPN servers, or demand-dial routers, and you want to centralize both the configuration of network policies and connection logging and accounting.
- You're outsourcing your dial-up, VPN, or wireless access to a service provider. The access servers use RADIUS to authenticate and authorize connections that are made by members of your organization.
- You want to centralize authentication, authorization, and accounting for a heterogeneous set of access servers.

The following diagram shows NPS as a RADIUS server for various access clients.

:::image type="content" source="../../media/Nps-Server/Nps-Server.jpg" alt-text="Diagram that shows NPS as a RADIUS server that communicates with various types of access servers, a domain controller, and SQL Server.":::

### RADIUS proxy

As a RADIUS proxy, NPS forwards authentication and accounting messages to NPS RADIUS servers and other RADIUS servers. When you use NPS as a RADIUS proxy, it routes RADIUS messages between RADIUS clients and RADIUS servers. RADIUS clients are also called network access servers. The RADIUS servers perform user authentication, authorization, and accounting for the connection attempt.

You can configure an unlimited number of RADIUS clients and remote RADIUS server groups in NPS. You can also configure RADIUS clients by specifying an IP address range.

When you use NPS as a RADIUS proxy, it serves as a central switching or routing point through which RADIUS access and accounting messages flow. NPS records information in an accounting log about the messages that are forwarded.

#### Use NPS as a RADIUS proxy

You can use NPS as a RADIUS proxy in the following cases:

- You're a service provider who offers outsourced dial-up, VPN, or wireless network access services to multiple customers. Your network-attached storage (NAS) systems send connection requests to the NPS RADIUS proxy. Based on the realm portion of the user name in the connection request, the NPS RADIUS proxy forwards the connection request to a RADIUS server. The customer maintains that server, which can authenticate and authorize the connection attempt.

- You want to provide authentication and authorization for user accounts that aren't members of either of the following domains:

  - The domain where the NPS deployment is a member.
  - A domain that has a two-way trust with the domain in which the NPS deployment is a member.

  Examples of user accounts include accounts in untrusted domains, one-way trusted domains, and other forests. Instead of configuring your access servers to send their connection requests to an NPS RADIUS server, you can configure them to send their connection requests to an NPS RADIUS proxy. The NPS RADIUS proxy uses the realm name portion of the user name and forwards the request to an NPS RADIUS server in the correct domain or forest. Connection attempts for user accounts in one domain or forest can be authenticated for NAS systems in another domain or forest.

- You want to perform authentication and authorization by using a database that's not a Windows account database. In this case, connection requests that match a specified realm name are forwarded to a RADIUS server that has access to a different database of user accounts and authorization data. Examples of other user databases include NetIQ eDirectory and Structured Query Language (SQL) databases.

- You want to process a large number of connection requests. In this case, instead of configuring your RADIUS clients to attempt to balance their connection and accounting requests across multiple RADIUS servers, you can configure them to send their connection and accounting requests to an NPS RADIUS proxy. The NPS RADIUS proxy dynamically balances the load of connection and accounting requests across multiple RADIUS servers and increases the processing of large numbers of RADIUS clients and authentications per second.

- You want to provide RADIUS authentication and authorization for outsourced service providers and minimize intranet firewall configuration. An intranet firewall is between your intranet and perimeter network (the network between your intranet and the internet). If you place NPS on your perimeter network, the firewall between your perimeter network and intranet must allow traffic to flow between NPS and multiple domain controllers. If you replace the NPS deployment with an NPS proxy, the firewall must allow only RADIUS traffic to flow between the NPS proxy and one or multiple NPS deployments within your intranet.

> [!IMPORTANT]
> NPS supports authentication across forests without a RADIUS proxy when the forest functional level is Windows Server 2003 or higher and there's a two-way trust relationship between forests. But if you use either of the following frameworks with certificates as your authentication method, you must use a RADIUS proxy for authentication across forests:
>
> - Extensible Authentication Protocol-Transport Layer Security (EAP-TLS)
> - Protected Extensible Authentication Protocol-Transport Layer Security (PEAP-TLS)

The following diagram shows NPS as a RADIUS proxy between RADIUS clients and RADIUS servers.

:::image type="content" source="../../media/Nps-Proxy/Nps-Proxy.jpg" alt-text="Diagram that shows NPS as a proxy server that uses the RADIUS protocol to communicate with access servers and RADIUS servers.":::

With NPS, organizations can also outsource remote access infrastructure to a service provider while retaining control over user authentication, authorization, and accounting.

You can create NPS configurations for the following scenarios:

- Wireless access
- Organization dial-up or VPN remote access
- Outsourced dial-up or wireless access
- Internet access
- Authenticated access to extranet resources for business partners

## RADIUS server and RADIUS proxy configuration examples

The following configuration examples demonstrate how you can configure NPS as a RADIUS server and a RADIUS proxy.

### NPS as a RADIUS server

This example uses the following configuration:

- NPS is configured as a RADIUS server.
- The default connection request policy is the only configured policy.
- The local NPS RADIUS server processes all connection requests.

The NPS RADIUS server can authenticate and authorize user accounts that are in the domain of the NPS RADIUS server and in trusted domains.

### NPS as a RADIUS proxy

In this example, NPS is configured as a RADIUS proxy that forwards connection requests. The requests are forwarded to remote RADIUS server groups in two untrusted domains.

The default connection request policy is deleted. Two new connection request policies are created to forward requests to each of the two untrusted domains.

In this example, NPS doesn't process any connection requests on the local server.

### NPS as both a RADIUS server and a RADIUS proxy

This example uses two connection request policies:

- The default connection request policy, which designates that connection requests are processed locally.
- A new connection request policy. It forwards connection requests to an NPS RADIUS server or other RADIUS server in an untrusted domain.

The second policy is named the Proxy policy. It appears first in the ordered list of policies.

- If a connection request matches the Proxy policy, the connection request is forwarded to the RADIUS server in the remote RADIUS server group.
- If the connection request doesn't match the Proxy policy but does match the default connection request policy, NPS processes the connection request on the local server.
- If the connection request doesn't match either policy, it's discarded.

### NPS as a RADIUS server with remote accounting servers

In this example, the local NPS RADIUS server isn't configured to perform accounting. The default connection request policy is revised so that RADIUS accounting messages are forwarded to an NPS RADIUS server or other RADIUS server in a remote RADIUS server group.

Although accounting messages are forwarded in this example, authentication and authorization messages aren't forwarded. The local NPS RADIUS server performs the authentication and authorization functions for the local domain and all trusted domains.

### NPS with a mapping between remote RADIUS users and local Windows users

In this example, NPS acts as both a RADIUS server and as a RADIUS proxy. NPS handles each individual connection request in the following way:

- The authentication request is forwarded to a remote RADIUS server.
- A local Windows user account is used for authorization.

To implement this configuration, you configure the **Remote RADIUS to Windows User Mapping** attribute as a condition of the connection request policy. You also create a user account locally on the RADIUS server. That account must have the same name as the remote user account against which the remote RADIUS server performs authentication.

## Configuration

To configure NPS as a RADIUS server, you can use either the standard configuration or advanced configuration in the NPS console or in Server Manager. To configure NPS as a RADIUS proxy, you must use the advanced configuration.

### Standard configuration

With the standard configuration, wizards are provided to help you configure NPS for the following scenarios:

- RADIUS server for dial-up or VPN connections
- RADIUS server for 802.1X wireless or wired connections

To configure NPS by using a wizard, open the NPS console, select one of the preceding scenarios, and then select the link for the wizard.

### Advanced configuration

When you use the advanced configuration, you manually configure NPS as a RADIUS server or RADIUS proxy.

To configure NPS by using the advanced configuration, open the NPS console, and then expand **Advanced Configuration**.

The following sections describe the advanced configuration items that are provided.

#### Configure a RADIUS server

To configure NPS as a RADIUS server, you must configure RADIUS clients, network policies, and RADIUS accounting.

For instructions on making these configurations, see the following articles:

- [Configure RADIUS clients](nps-radius-clients-configure.md)
- [Configure network policies](nps-np-configure.md)
- [Configure Network Policy Server accounting](nps-accounting-configure.md)

#### Configure a RADIUS proxy

To configure NPS as a RADIUS proxy, you must configure RADIUS clients, remote RADIUS server groups, and connection request policies.

For instructions on making these configurations, see the following articles:

- [Configure RADIUS clients](nps-radius-clients-configure.md)
- [Configure remote RADIUS server groups](nps-crp-rrsg-configure.md)
- [Configure connection request policies](nps-crp-configure.md)

## NPS logging

NPS logging is also called RADIUS accounting. You can configure NPS logging to meet your requirements whether NPS is used as a RADIUS server, proxy, or any combination of these configurations.

To configure NPS logging, you must configure the events that you want to log and view with Event Viewer, and then determine which other information you want to log. Also, you must decide where to store user authentication and accounting information logs. The following options are available:

- Text log files stored on the local computer
- A SQL Server database on either the local computer or a remote computer

For more information, see [Configure Network Policy Server accounting](nps-accounting-configure.md).

## Related content

- [Network Policy Server best practices](nps-best-practices.md)
- [Getting started with Network Policy Server](nps-getstart-top.md)
- [Plan Network Policy Server](nps-plan-top.md)
- [Deploy Network Policy Server](nps-deploy.md)
- [Manage Network Policy Server (NPS)](nps-manage-top.md)
- [NPS cmdlets in Windows PowerShell](/powershell/module/nps/)

