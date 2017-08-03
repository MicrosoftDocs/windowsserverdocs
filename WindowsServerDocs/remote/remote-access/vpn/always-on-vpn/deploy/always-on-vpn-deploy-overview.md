---
title: Remote Access Always On VPN Deployment Overview
description: This topic provides an overview of Always On VPN deployment in Windows Server 2016.
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.assetid: d33e6bd2-ca2e-448a-bce9-a43d4cb20766
manager: brianlic
ms.author: jamesmci
author: jamesmci
---
# Remote Access Always On VPN Deployment Overview

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows 10

You can use this guide to deploy Always On Virtual Private Network \(VPN\) connections for remote computers that are running Windows 10. 

For this deployment, you must install a new Remote Access server that is running Windows Server 2016, as well as modify some of your existing infrastructure for the deployment.

The following illustration shows the infrastructure that is required to deploy Always On VPN.

![Always On VPN Infrastructure](../../../../media/Always-On-Vpn/Ao-Vpn-Overview.jpg)

## VPN Connection Process Overview

The connection process depicted in this illustration is comprised of the following steps.

1. Using public DNS servers, the Windows 10 VPN client performs a name resolution query for the IP address of the VPN gateway.

2. Using the IP address returned by DNS, the VPN client sends a connection request to the VPN gateway.

3. The VPN gateway is also configured as a Remote Authentication Dial In User Service \(RADIUS\) Client; the VPN RADIUS Client sends the connection request to the organization/corporate NPS server for connection request processing.

4. The NPS server processes the connection request, including performing authorization and authentication, and determines whether to allow or deny the connection request.

5. The NPS server forwards an Access-Accept or Access-Deny response to the VPN gateway.

6. The connection is initiated or terminated based on the response that the VPN server received from the NPS server.

For more information on each infrastructure component depicted in the illustration above, see the following sections.

## VPN Server

The VPN Server is a new physical server or virtual machine \(VM\) that you must install to complete the steps in this guide. The server must be running Windows Server 2016. In addition, in the process of completing the steps in this guide, you must perform the following actions with the VPN Server.

- Install two Ethernet network adapters in the physical server.
- Install the server on your perimeter network between your edge and internal firewalls, with one network adapter connected to the External Perimeter Network, and one network adapter connected to the Internal Perimeter Network.
- Install and configure Remote Access as a single tenant VPN RAS Gateway for point\-to\-site VPN connections from remote computers.
- Configure Remote Access as a RADIUS Client so that it can send connection requests to the organization NPS server for processing.
- Enroll and validate the VPN server certificate from your certification authority \(CA\).

## NPS Server

The NPS Server is installed on your organization/corporate network. 

You must configure this NPS server as a RADIUS server that receives connection requests from the VPN server. The NPS server processes the connection requests, performing authorization and authentication, and sends either an Access\-Accept or Access\-Reject message to the VPN Server.

## AD DS Server

The Active Directory Domain Services \(AD DS\) server is an on\-premises Active Directory domain, which hosts on\-premises user accounts.

During completion of the steps in this guide, you will configure the following items on the domain controller.

- Enable certificate autoenrollment in Group Policy for computers and users
- Create the VPN Users Group
- Create the VPN Servers Group
- Create the NPS Servers Group

## CA Server

The Certification Authority \(CA\) Server is a certification authority that is running Active Directory Certificate Services. The VPN configuration requires an Active Directory–based public key infrastructure \(PKI\). 

The CA enrolls certificates that are used for PEAP client–server authentication. The CA creates certificates based on certificate templates. During completion of the steps in this guide, you will configure the following certificate templates on the CA.

- The User Authentication certificate template
- The VPN Server Authentication certificate template
- The NPS Server Authentication certificate template 

## DNS Servers \(Public and Private\)

Both internal and external Domain Name System \(DNS\) zones are required, which assumes that the internal zone is a delegated subdomain of the external zone \(e.g., corp.contoso.com and contoso.com\). 

>[!NOTE]
>Other DNS designs, such as split-brain DNS \(using the same domain name internally and externally in separate DNS zones\) or unrelated internal and external domains \(e.g., contoso.local and contoso.com\) are also possible, but the configuration for these environments is beyond the scope of this guide.

## Windows 10 VPN Client

In addition to the server components, ensure that the client computers you configure to use VPN are running Windows 10 Anniversary Update (version 1607) or later.

The Windows 10 VPN client is highly configurable and offers many options. To better illustrate the specific features this scenario uses, Table 1 identifies the VPN feature categories and specific configurations that this guide references. You’ll configure the individual settings for these features by using the VPNv2 configuration service provider (CSP) discussed later in this guide.

Table 1. VPN Features and Configurations Discussed in This Guide

| **VPN feature** | **Deployment scenario configuration** |
|-----------------|---------------------------------------|
| Connection type | Native IKEv2 |
| Routing         | Split tunneling |
| Name resolution | Domain Name Information List and DNS suffix |
| Triggering      | Always On and Trusted Network Detection |
| Authentication  | PEAP\-TLS with TPM\–protected user certificates |

>[!NOTE]
>PEAP\-TLS and TPM are "Protected Extensible Authentication Protocol with Transport Layer Security" and "Trusted Platform Module," respectively.

### VPNv2 CSP Nodes

Configuration Service Providers \(CSPs\) are interfaces that expose various management capabilities within the Windows client; conceptually, CSPs work similar to how Group Policy works. 

Each CSP has configuration nodes that represent individual settings. Also like Group Policy settings, you can tie CSP settings to registry keys, files, permissions, and so on. 

Similar to how you use the Group Policy Management Editor to configure Group Policy objects \(GPOs\), you configure CSP nodes by using a mobile device management \(MDM\) solution such as Microsoft Intune. 

MDM products like Intune offer a user\-friendly configuration option that configures the CSP in the operating system.

![Mobile Device Management to CSP configuration](../../../../media/Always-On-Vpn/Vpn-Mdm.jpg)

However, you can’t configure some CSP nodes directly through a user interface \(UI\) like the Intune Admin Console. 

In these cases, you must configure the Open Mobile Alliance Uniform Resource Identifier \(OMA\-URI\) settings manually. You configure OMA\-URIs by using the OMA Device Management protocol \(OMA\-DM\), a universal device management specification that most modern Apple, Android, and Windows devices support. As long as they adhere to the OMA\-DM specification, all MDM products should interact with these operating systems in the same way.

Windows 10 offers many CSPs, but this guide focuses on using the VPNv2 CSP to configure the VPN client. 

The VPNv2 CSP allows configuration of each VPN profile setting in Windows 10 through a unique CSP node. 

Also contained in the VPNv2 CSP is a node called *ProfileXML*, which allows you to configure all the settings in one node rather than individually. 

In this guide, you use the ProfileXML VPNv2 CSP node to create the VPN profile that is delivered to Windows 10 client computers.

For more information about ProfileXML, see the section “ProfileXML overview” later in this guide. For details about each VPNv2 CSP node, see the [VPNv2 CSP](https://msdn.microsoft.com/windows/hardware/commercialize/customize/mdm/vpnv2-csp).

## Firewalls

Ensure that your firewalls allow the traffic that is necessary for both VPN and RADIUS communications to function correctly.

For more information, see [Configure Firewalls for RADIUS Traffic](https://docs.microsoft.com/windows-server/networking/technologies/nps/nps-firewalls-configure).

## User

The remote users that are allowed to connect to your organization network must have a user account in AD DS.

User accounts in Active Directory Users and Computers have dial-in properties that NPS evaluates during the authorization process - unless the **Network Access Permission** property of the user account is set to **Control access through NPS Network Policy**. 

This is the default setting for all user accounts. In some cases, however, this setting might have a different configuration that blocks the user from connecting using VPN.

To protect against this possibility, you can configure the NPS server to ignore user account dial in properties.

For more information, see [Configure NPS to Ignore User Account Dial-in Properties](https://docs.microsoft.com/en-us/windows-server/networking/technologies/nps/nps-np-configure#configure-nps-to-ignore-user-account-dial-in-properties).

For the next section in this guide, see [Remote Access Always On VPN Deployment Planning](always-on-vpn-deploy-planning.md).
