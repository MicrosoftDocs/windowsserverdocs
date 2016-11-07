---
title: Network Policy Server (NPS)
description: This topic provides an overview of Network Policy Server in Windows Server 2016, and includes links to additional guidance about NPS.
manager: dongill
ms.prod: windows-server-threshold
ms.technology: networking-nlb
ms.topic: article
ms.assetid: 9c7a67e0-0953-479c-8736-ccb356230bde
ms.author: jamesmci 
author: jamesmci
---

# Network Policy Server (NPS)

>Applies To: Windows Server&reg; 2016

You can use this topic for an overview of Network Policy Server in Windows Server 2016.

>[!NOTE]
>In addition to this topic, the following NPS documentation is available.
> - Deploy NPS using the section "Deploying optional features for network access authentication and Web services" in the Windows Server 2016 [Core Network Guide](https://technet.microsoft.com/windows-server-docs/networking/core-network-guide/core-network-guide#BKMK_optionalfeatures).
> - Deploy server certificates to NPS servers with the guide [Deploy Server Certificates for 802.1X Wired and Wireless Deployments](https://technet.microsoft.com/windows-server-docs/networking/core-network-guide/cncg/server-certs/deploy-server-certificates-for-802.1x-wired-and-wireless-deployments).
> - Use NPS for wireless authentication with the guide [Deploy Password-Based 802.1X Authenticated Wireless Access](Deploy Password-Based 802.1X Authenticated Wireless Access).

Network Policy Server (NPS) allows you to create and enforce organization-wide network access policies for connection request authentication and authorization. 

You can also configure NPS as a Remote Authentication Dial-In User Service (RADIUS) proxy to forward connection requests to a remote NPS or other RADIUS server so that you can load balance connection requests and forward them to the correct domain for authentication and authorization.

NPS allows you to centrally configure and manage network access authentication, authorization, and accounting with the following features:

- **RADIUS server**. NPS performs centralized authentication, authorization, and accounting for wireless, authenticating switch, remote access dial-up and virtual private network (VPN) connections. When you use NPS as a RADIUS server, you configure network access servers, such as wireless access points and VPN servers, as RADIUS clients in NPS. You also configure network policies that NPS uses to authorize connection requests, and you can configure RADIUS accounting so that NPS logs accounting information to log files on the local hard disk or in a Microsoft SQL Server database. 
- **RADIUS proxy**. When you use NPS as a RADIUS proxy, you configure connection request policies that tell the NPS server which connection requests to forward to other RADIUS servers and to which RADIUS servers you want to forward connection requests. You can also configure NPS to forward accounting data to be logged by one or more computers in a remote RADIUS server group.
- **RADIUS accounting**. You can configure NPS to log events to a local log file or to a local or remote instance of Microsoft SQL Server.

>[!IMPORTANT]
>Network Access Protection \(NAP\), Health Registration Authority \(HRA\), and Host Credential Authorization Protocol \(HCAP\) are deprecated, and are not available in Windows Server 2016.

You can configure NPS with any combination of these features. For example, you can configure one NPS server as a RADIUS server for VPN connections and also as a RADIUS proxy to forward some connection requests to members of a remote RADIUS server group for authentication and authorization in another domain.

The following sections provide more detailed information about NPS as a RADIUS server and proxy.

## RADIUS server and proxy

You can use NPS as a RADIUS server, a RADIUS proxy, or both.

### RADIUS server

NPS is the Microsoft implementation of the RADIUS standard specified by the Internet Engineering Task Force (IETF) in RFCs 2865 and 2866. As a RADIUS server, NPS performs centralized connection authentication, authorization, and accounting for many types of network access, including wireless, authenticating switch, dial-up and virtual private network (VPN) remote access, and router-to-router connections.

NPS enables the use of a heterogeneous set of wireless, switch, remote access, or VPN equipment. You can use NPS with the Remote Access service, which is available in Windows Server 2016.

When a server running NPS is a member of an Active Directory&reg; Domain Services (AD DS) domain, NPS uses the directory service as its user account database and is part of a single sign-on solution. The same set of credentials is used for network access control (authenticating and authorizing access to a network) and to log on to an AD DS domain.

Internet service providers (ISPs) and organizations that maintain network access have the increased challenge of managing all types of network access from a single point of administration, regardless of the type of network access equipment used. The RADIUS standard supports this functionality in both homogeneous and heterogeneous environments. RADIUS is a client-server protocol that enables network access equipment (used as RADIUS clients) to submit authentication and accounting requests to a RADIUS server.

A RADIUS server has access to user account information and can check network access authentication credentials. If user credentials are authenticated and the connection attempt is authorized, the RADIUS server authorizes user access on the basis of specified conditions, and then logs the network access connection in an accounting log. The use of RADIUS allows the network access user authentication, authorization, and accounting data to be collected and maintained in a central location, rather than on each access server.

### RADIUS proxy

As a RADIUS proxy, NPS forwards authentication and accounting messages to NPS and other RADIUS servers. 

With NPS, organizations can also outsource remote access infrastructure to a service provider while retaining control over user authentication, authorization, and accounting.

NPS configurations can be created for the following scenarios:

- Wireless access
- Organization dial-up or virtual private network (VPN) remote access
- Outsourced dial-up or wireless access
- Internet access
- Authenticated access to extranet resources for business partners

## RADIUS server and RADIUS proxy configuration examples

The following configuration examples demonstrate how you can configure NPS as a RADIUS server and a RADIUS proxy.

**NPS as a RADIUS server**. In this example, NPS is configured as a RADIUS server, the default connection request policy is the only configured policy, and all connection requests are processed by the local NPS server. The NPS server can authenticate and authorize users whose accounts are in the domain of the NPS server and in trusted domains.

**NPS as a RADIUS proxy**. In this example, the NPS server is configured as a RADIUS proxy that forwards connection requests to remote RADIUS server groups in two untrusted domains. The default connection request policy is deleted, and two new connection request policies are created to forward requests to each of the two untrusted domains. In this example, NPS does not process any connection requests on the local server. 

**NPS as both RADIUS server and RADIUS proxy**. In addition to the default connection request policy, which designates that connection requests are processed locally, a new connection request policy is created that forwards connection requests to an NPS or other RADIUS server in an untrusted domain. This second policy is named the Proxy policy. In this example, the Proxy policy appears first in the ordered list of policies. If the connection request matches the Proxy policy, the connection request is forwarded to the RADIUS server in the remote RADIUS server group. If the connection request does not match the Proxy policy but does match the default connection request policy, NPS processes the connection request on the local server. If the connection request does not match either policy, it is discarded.

**NPS as a RADIUS server with remote accounting servers**. In this example, the local NPS server is not configured to perform accounting and the default connection request policy is revised so that RADIUS accounting messages are forwarded to an NPS server or other RADIUS server in a remote RADIUS server group. Although accounting messages are forwarded, authentication and authorization messages are not forwarded, and the local NPS server performs these functions for the local domain and all trusted domains.

**NPS with remote RADIUS to Windows user mapping**. In this example, NPS acts as both a RADIUS server and as a RADIUS proxy for each individual connection request by forwarding the authentication request to a remote RADIUS server while using a local Windows user account for authorization. This configuration is implemented by configuring the Remote RADIUS to Windows User Mapping attribute as a condition of the connection request policy. \(In addition, a user account must be created locally on the RADIUS server that has the same name as the remote user account against which authentication is performed by the remote RADIUS server.\)



## Configuration

To configure NPS as a RADIUS server, you can use either standard configuration or advanced configuration in the NPS console or in Server Manager. To configure NPS as a RADIUS proxy, you must use advanced configuration.

### Standard configuration

With standard configuration, wizards are provided to help you configure NPS for the following scenarios:

- RADIUS server for dial-up or VPN connections
- RADIUS server for 802.1X wireless or wired connections

To configure NPS using a wizard, open the NPS console, select one of the preceding scenarios, and then click the link that opens the wizard.

### Advanced configuration

When you use advanced configuration, you manually configure NPS as a RADIUS server or RADIUS proxy. 

To configure NPS by using advanced configuration, open the NPS console, and then click the arrow next to **Advanced Configuration** to expand this section.

The following advanced configuration items are provided.

#### Configure RADIUS server

To configure NPS as a RADIUS server, you must configure RADIUS clients, network policy, and RADIUS accounting.

#### Configure RADIUS proxy

To configure NPS as a RADIUS proxy, you must configure RADIUS clients, remote RADIUS server groups, and connection request policies.

## NPS logging

NPS logging is also called RADIUS accounting. Configure NPS logging to your requirements whether NPS is used as a RADIUS server, proxy, or any combination of these configurations.

To configure NPS logging, you must configure which events you want logged and viewed with Event Viewer, and then determine which other information you want to log. In addition, you must decide whether you want to log user authentication and accounting information to text log files stored on the local computer or to a SQL Server database on either the local computer or a remote computer.

