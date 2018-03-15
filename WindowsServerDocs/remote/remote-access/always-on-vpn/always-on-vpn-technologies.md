---
title: Always On VPN Technology Overview
description: This section provides a brief overview of the technologies of Always On VPN and links to additional documentation.
ms.prod: windows-server-threshold
ms.technology: networking, remote access, vpn
ms.topic: article
ms.assetid: 5ae1a40b-4f10-4ace-8aaf-13f7ab581f4f
manager: brianlic
ms.author: pashort
author: shortpatti
ms.date: 2/24/2018
---

# Always On VPN Technology Overview

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

For this deployment, it is not a requirement that your infrastructure servers, such as computers running AD DS, AD CS, and NPS, are running Windows Server
2016\. You can use earlier versions of Windows Server, such as Windows Server 2012 R2, for the infrastructure servers and for the server that is running
Remote Access. 

This section provides a brief overview of the technologies of Always On VPN and links to additional documentation.

## [Remote Access as a RAS Gateway VPN Server](vpn-deploy-ras.md)

The VPN Server is a new physical server or virtual machine \(VM\) that you must install. 

In the process of completing the steps in this guide, you must perform the following actions with the VPN Server.

-   Install two Ethernet network adapters in the physical server. If you are installing the VPN server on a VM, you must create two External virtual
    switches, one for each physical network adapter; and then create two virtual network adapters for the VM, with each network adapter connected to one
    virtual switch.

-   Install the server on your perimeter network between your edge and internal firewalls, with one network adapter connected to the External Perimeter
    Network, and one network adapter connected to the Internal Perimeter Network.

-   Install and configure Remote Access as a single tenant VPN RAS Gateway for point-to-site VPN connections from remote computers.

-   Configure Remote Access as a RADIUS Client so that it can send connection requests to the organization NPS server for processing.

-   Enroll and validate the VPN server certificate from your certification authority (CA).

In Windows Server 2016, the Remote Access server role is a multifaceted gateway and router that provides centralized administration, configuration, and
monitoring of Virtual Private Network (VPN) remote access services. 

You can manage Remote Access Service (RAS) Gateways by using Windows PowerShell commands and the Remote Access Microsoft Management Console (MMC).

For more information, see [Remote Access](https://docs.microsoft.com/windows-server/remote/remote-access/remote-access).

## Network Policy Server (NPS)

The NPS Server is installed on your organization/corporate network. NPS allows you to create and enforce organization-wide network access policies for connection request authentication and authorization. When you use NPS as a Remote Authentication Dial-In User Service (RADIUS) server, you configure network access servers, such as VPN servers, as RADIUS clients in NPS.

You also configure network policies that NPS uses to authorize connection requests, and you can configure RADIUS accounting so that NPS logs accounting
information to log files on the local hard disk or in a Microsoft SQL Server database.

For more information, see [Network Policy Server (NPS)](https://docs.microsoft.com/windows-server/networking/technologies/nps/nps-top).

You must configure this NPS server as a RADIUS server that receives connection requests from the VPN server. The NPS server processes the connection requests,
performing authorization and authentication, and sends either an Access-Accept or Access-Reject message to the VPN Server.

## Active Directory Domain Services (AD DS) Server

AD DS provides a distributed database that stores and manages information about network resources and application-specific data from directory-enabled applications. Administrators can use AD DS to organize elements of a network, such as users, computers, and other devices, into a hierarchical containment structure. The hierarchical containment structure includes the Active Directory forest, domains in the forest, and organizational units (OUs) in each domain. A server that is running AD DS is called a domain controller.

AD DS contains the user accounts, computer accounts, and account properties that are required by Protected Extensible Authentication Protocol (PEAP) to authenticate user credentials and to evaluate authorization for VPN connection requests.

The Active Directory Domain Services (AD DS) server is an on-premises Active Directory domain, which hosts on-premises user accounts.

During completion of the steps in this guide, you will configure the following items on the domain controller.

-   Enable certificate autoenrollment in Group Policy for computers and users

-   Create the VPN Users Group

-   Create the VPN Servers Group

-   Create the NPS Servers Group

For information about deploying AD DS, see the Windows Server 2016 [Core Network Guide](https://docs.microsoft.com/windows-server/networking/core-network-guide/core-network-guide).

### Active Directory Users and Computers

Active Directory Users and Computers is a component of AD DS that contains accounts that represent physical entities, such as a computer, a person, or a security group. A security group is a collection of user or computer accounts that administrators can manage as a single unit. User and computer accounts that belong to a specific group are referred to as group members.

### Group Policy Management

Group Policy Management enables directory-based change and configuration management of user and computer settings, including security and user
information. You use Group Policy to define configurations for groups of users and computers.

With Group Policy, you can specify settings for registry entries, security, software installation, scripts, folder redirection, remote installation services, and Internet Explorer maintenance. The Group Policy settings that you create are contained in a Group Policy object (GPO). By associating a GPO with selected Active Directory system containers — sites, domains, and OUs — you can apply the GPO's settings to the users and computers in those Active Directory containers. To manage Group Policy objects across an enterprise, you can use the Group Policy Management Editor Microsoft Management Console (MMC).

## Active Directory Certificate Services (AD CS) Server

AD CS in Windows Server 2016 provides customizable services for creating and managing the X.509 certificates that are used in software security systems that employ public key technologies. Organizations can use AD CS to enhance security by binding the identity of a person, device, or service to a corresponding public key. AD CS also includes features that allow you to manage certificate enrollment and revocation in a variety of scalable environments.

For more information, see [Active Directory Certificate Services Overview](https://technet.microsoft.com/library/hh831740.aspx) and [Public Key Infrastructure Design Guidance](https://social.technet.microsoft.com/wiki/contents/articles/2901.public-key-infrastructure-design-guidance.aspx).

The Certification Authority (CA) Server is a certification authority that is running Active Directory Certificate Services. The VPN configuration requires an Active Directory–based public key infrastructure (PKI).

The CA enrolls certificates that are used for PEAP client–server authentication. The CA creates certificates based on certificate templates. During completion of the steps in this guide, you configure the following certificate templates on the CA:

-   The User Authentication certificate template

-   The VPN Server Authentication certificate template

-   The NPS Server Authentication certificate template

## Domain Name System (DNS) Servers (Public and Private)

DNS is a name resolution protocol for TCP/IP networks, such as the Internet or an organization network. A DNS server hosts the information that enables client
computers and services to resolve easily recognized, alphanumeric DNS names to the IP addresses that computers use to communicate with each other.

For more overview information about DNS, see [Domain Name System (DNS)](https://docs.microsoft.com/windows-server/networking/dns/dns-top).

For information about deploying AD DS with DNS, see the Windows Server 2016 [Core Network Guide](https://docs.microsoft.com/windows-server/networking/core-network-guide/core-network-guide).

Both internal and external DNS zones are required, which assumes that the internal zone is a delegated subdomain of the external zone (for example,
corp.contoso.com and contoso.com).

>[!NOTE] 
>Other DNS designs, such as split-brain DNS (using the same domain name internally and externally in separate DNS zones) or unrelated internal and external domains (for example, contoso.local and contoso.com) are also possible, but the configuration for these environments is beyond the scope of this guide.

### Certificate Templates

Certificate templates can greatly simplify the task of administering a certification authority (CA) by allowing you to issue certificates that are preconfigured for selected tasks. The Certificate Templates MMC snap-in allows you to perform the following tasks:

-   View properties for each certificate template.

-   Copy and modify certificate templates.

-   Control which users and computers can read templates and enroll for
    certificates.

-   Perform other administrative tasks relating to certificate templates.

Certificate templates are an integral part of an enterprise certification authority (CA). They are an important element of the certificate policy for an environment, which is the set of rules and formats for certificate enrollment, use, and management.

For more information, see [Certificate Templates](https://technet.microsoft.com/library/cc730705.aspx).

### Digital Server Certificates

This guide provides instructions for using Active Directory Certificate Services (AD CS) to both enroll and automatically enroll certificates to Remote Access
and NPS infrastructure servers. AD CS allows you to build a public key infrastructure (PKI) and provide public key cryptography, digital certificates, and digital signature capabilities for your organization.

When you use digital server certificates for authentication between computers on your network, the certificates provide:

-   Confidentiality through encryption.

-   Integrity through digital signatures.

-   Authentication by associating certificate keys with computer, user, or
    device accounts on a computer network.

For more information, see [AD CS Step by Step Guide: Two Tier PKI Hierarchy Deployment](https://social.technet.microsoft.com/wiki/contents/articles/15037.ad-cs-step-by-step-guide-two-tier-pki-hierarchy-deployment.aspx).

## Always On VPN Windows 10 Client

In addition to the server components, ensure that the client computers you configure to use VPN are running Windows 10 Anniversary Update (version 1607) or
later.

The Always On VPN client is highly configurable and offers many options. To better illustrate the specific features this scenario uses, Table 1 identifies the VPN feature categories and specific configurations that this guide references. You’ll configure the individual settings for these features by using the VPNv2 configuration service provider (CSP) discussed later in this guide.

Table 1. VPN Features and Configurations Discussed in This Guide

| **VPN feature** | **Deployment scenario configuration**         |
|-----------------|-----------------------------------------------|
| Connection type | Native IKEv2                                  |
| Routing         | Split tunneling                               |
| Name resolution | Domain Name Information List and DNS suffix   |
| Triggering      | Always On and Trusted Network Detection       |
| Authentication  | PEAP-TLS with TPM–protected user certificates |

>[!NOTE] 
>PEAP-TLS and TPM are "Protected Extensible Authentication Protocol with Transport Layer Security" and "Trusted Platform Module," respectively.

For detailed feature descriptions and a full list of the VPN capabilities in Windows 10, see the [Windows 10 VPN Technical Guide](https://docs.microsoft.com/windows/access-protection/vpn/vpn-guide).

### VPNv2 CSP Nodes

Configuration Service Providers (CSPs) are interfaces that expose various management capabilities within the Windows client; conceptually, CSPs work similar to how Group Policy works.

Each CSP has configuration nodes that represent individual settings. Also like Group Policy settings, you can tie CSP settings to registry keys, files, permissions, and so on.

Similar to how you use the Group Policy Management Editor to configure Group Policy objects (GPOs), you configure CSP nodes by using a mobile device management (MDM) solution such as Microsoft Intune.

MDM products like Intune offer a user-friendly configuration option that configures the CSP in the operating system.

![Mobile Device Management to CSP configuration](../../media/Always-On-Vpn/Vpn-Mdm.jpg)

Mobile Device Management to CSP configuration

However, you cannot configure some CSP nodes directly through a user interface (UI) like the Intune Admin Console.

In these cases, you must configure the Open Mobile Alliance Uniform Resource Identifier (OMA-URI) settings manually. You configure OMA-URIs by using the OMA Device Management protocol (OMA-DM), a universal device management specification that most modern Apple, Android, and Windows devices support. As long as they adhere to the OMA-DM specification, all MDM products should interact with these operating systems in the same way.

Windows 10 offers many CSPs, but this guide focuses on using the VPNv2 CSP to configure the VPN client.

The VPNv2 CSP allows configuration of each VPN profile setting in Windows 10 through a unique CSP node.

Also contained in the VPNv2 CSP is a node called *ProfileXML*, which allows you to configure all the settings in one node rather than individually.

In this guide, you use the ProfileXML VPNv2 CSP node to create the VPN profile that is delivered to Windows 10 client computers. For more information about
ProfileXML, see the ProfileXML Configuration File Overview section. For details about each VPNv2 CSP node, see the [VPNv2 CSP](https://msdn.microsoft.com/windows/hardware/commercialize/customize/mdm/vpnv2-csp).

## Firewalls
<!-- this is from the planning section -->
The VPN server is installed inside the perimeter network, which partitions the perimeter network into internal and external perimeter networks. You might need to make several routing modifications, depending on your network environment. Ensure that your firewalls allow the traffic that is necessary for both VPN and RADIUS communications to function correctly.

1.  (Optional) Configure port forwarding.<br><br>Your edge firewall must open the ports and protocol IDs associated with an IKEv2 VPN and forward them to the VPN server. In most environments, doing so requires you to configure port forwarding. Redirect Universal Datagram Protocol (UDP) ports 500 and 4500 to the VPN server.

2.  Configure routing so that the DNS servers and VPN servers can reach the Internet.<br><br>This deployment uses IKEv2 and Network Address Translation (NAT).

3.  Ensure that the VPN server can reach all the required internal networks and network resources that you want to provide to remote users.<br><br>Any network or resource that is not reachable from the VPN server is also unreachable over VPN connections from remote locations.

>[!TIP] 
>In most environments, you can adjust static routes on the edge firewall and the VPN server to allow them to reach this new internal perimeter network. In complex environments, you may need to add static routes to internal routers or adjust internal firewall rules for the VPN server and the block of IP addresses associated with VPN clients.

### RADIUS Traffic Ports on the VPN Server and NPS Server

By default, NPS and VPN listen for RADIUS traffic on ports 1812, 1813, 1645, and 1646 on all installed network adapters. If Windows Firewall with Advanced Security is enabled when you install NPS, firewall exceptions for these ports are automatically created during the installation process for both Internet Protocol version 6 (IPv6) and IPv4 traffic.

>[!IMPORTANT] 
>If your network access servers are configured to send RADIUS traffic over ports other than these defaults, remove the exceptions created in Windows Firewall with Advanced Security during NPS installation, and create exceptions for the ports that you do use for RADIUS traffic.

### Use the Same RADIUS Ports for the Internal Perimeter Network Firewall Configuration

If you are using the default RADIUS port configuration on the VPN Server and the NPS Server, ensure that you open the following ports on the Internal Perimeter Network Firewall.

-   Ports UDP1812, UDP1813, UDP1645, and UDP1646

If you are not using the default RADIUS ports in your NPS deployment, you must configure the firewall to allow RADIUS traffic on the ports that you are using.

For more information, see [Configure Firewalls for RADIUS Traffic](https://docs.microsoft.com/windows-server/networking/technologies/nps/nps-firewalls-configure).

## User

The remote users allowed to connect to your organization network must have a user account in AD DS.

User accounts in Active Directory Users and Computers have dial-in properties that NPS evaluates during the authorization process - unless the **Network
Access Permission** property of the user account is set to **Control access through NPS Network Policy**.

This is the default setting for all user accounts. In some cases, however, this setting might have a different configuration that blocks the user from
connecting using VPN.

To protect against this possibility, you can configure the NPS server to ignore user account dial-in properties.

For more information, see [Configure NPS to Ignore User Account Dial-in Properties](https://docs.microsoft.com/en-us/windows-server/networking/technologies/nps/nps-np-configure#configure-nps-to-ignore-user-account-dial-in-properties).