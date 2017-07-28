
---
title: Remote Access Always On VPN Deployment Guide for Windows Server 2016 and Windows 10
description: You can use this guide to deploy Always On Virtual Private Network (VPN) connections for remote employees by using Remote Access in Windows Server 2016 and Always On VPN profiles for Windows 10 client computers.
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.assetid: 5ae1a40b-4f10-4ace-8aaf-13f7ab581f4f
manager: brianlic
ms.author: jamesmci
author: jamesmci
---

# Remote Access Always On VPN Deployment Guide for Windows Server 2016 and Windows 10

>Applies To: Windows Server 2016, Windows 10

You can use this guide to deploy Always On Virtual Private Network \(VPN\) connections for remote employees by using Remote Access in Windows Server 2016 and Always On VPN profiles for Windows 10 client computers.

>[!IMPORTANT]
>This guide is designed for deploying Always On VPN with the Remote Access server role on an on\-premises organization network. Do not attempt to deploy Remote Access on a virtual machine \(VM\) in Microsoft Azure. Using Remote Access in Microsoft Azure is not supported, including both Remote Access VPN and DirectAccess. For more information, see [Microsoft server software support for Microsoft Azure virtual machines](https://support.microsoft.com/help/2721672/microsoft-server-software-support-for-microsoft-azure-virtual-machines).

This guide contains the following sections.

- [About this guide](#bkmk_about)

- [Prerequisites for using this guide](#bkmk_prerequisites)

- [What this guide does not provide](#bkmk_not)

- [Technology overviews](#bkmk_technology)

- [Remote Access Always On VPN Deployment Overview](always-on-vpn-deploy-overview.md)

- [Remote Access Always On VPN Deployment Planning](always-on-vpn-deploy-planning.md)

- [Remote Access Always On VPN Deployment](always-on-vpn-deploy-deployment.md)

- [Remote Access Always On VPN Advanced Features](always-on-vpn-adv-options.md)

- [Remote Access Always On VPN Troubleshooting](always-on-vpn-deploy-troubleshooting.md)

## <a name="bkmk_about"></a>About this guide

This guide is designed for network and system administrators who want to manage remote computers that connect automatically to the organization network with VPN whenever the user logs on to the device, changes networks, or simply turns on the display. This type of automatically connecting VPN is called an *Always On VPN* - because the VPN connection appears to be a persistent connection.

This guide provides instructions on deploying Remote Access as a single tenant VPN RAS Gateway for point\-to\-site VPN connections that allow your remote employees to connect to your organization network with Always On VPN connections.

It is recommended that you review the design and deployment guides for each of the technologies that are used in this deployment scenario. These guides can help you determine whether this deployment scenario provides the services and configuration that you need for your organization's network. For more information, see [Technology overviews](#bkmk_technology).

## <a name="bkmk_prerequisites"></a>Prerequisites for using this guide

This guide provides instructions on how to deploy Remote Access Always On VPN connections for remote client computers that are running Windows 10. Following are the prerequisites for performing the procedures in this guide.

- You must have an Active Directory domain infrastructure, including one or more Domain Name System \(DNS\) servers.
- You must have a Public Key Infrastructure \(PKI\) and Active Directory Certificate Services \(AD CS\).
- You must have a perimeter network that includes two firewalls. For more information, see [Remote Access Always On VPN Deployment Overview](always-on-vpn-deploy-overview.md)
- Remote client computers must be joined to the Active Directory domain.
- Remote client computers must be running the Windows 10 Anniversary Update \(version 1607\) or later operating system.
- You must be prepared to deploy one new physical server on your network, upon which you will install both Remote Access and Network Policy Server \(NPS\) as a Remote Authentication Dial-In User Service \(RADIUS\) proxy. This server must have two Ethernet network adapters installed.
- You must be prepared to install NPS as a RADIUS server on an existing server or virtual machine \(VM\), on a new physical server, or on a new VM. If you already have NPS servers on your network, you can modify an existing NPS server configuration rather than adding a new server.
- You must read the planning section of this guide to ensure that you are prepared for this deployment before you perform the deployment.
- You must perform the steps in this guide in the order in which they are presented.

## <a name="bkmk_not"></a>What this guide does not provide

This guide does not provide instructions for deploying the following items.

- Active Directory Domain Services \(AD DS\)
- Active Directory Certificate Services \(AD CS\) and a Public Key Infrastructure \(PKI\).
- Dynamic Host Configuration Protocol \(DHCP\) automatic IP address assignment to computers and other devices that are configured as DHCP clients. 
- Network hardware, such as Ethernet cabling, firewalls, switches, and hubs.
- Additional network resources, such as application and file servers, that remote users can access over an Always On VPN connection.
- Internet connectivity

## <a name="bkmk_technology"></a>Technology overviews

When performing the steps in this guide, you must install and configure the following technologies in Windows Server 2016.

If you already have some of these technologies deployed on your network, you can use the instructions in this guide to perform additional configuration of the technologies for this deployment purpose.

Following are brief overviews of these technologies and links to additional documentation.

### Remote Access

In Windows Server 2016, the Remote Access server role is a multifaceted gateway and router that provides centralized administration, configuration, and monitoring of Virtual Private Network \(VPN\) remote access services. 

You can manage Remote Access Service \(RAS\) Gateways by using Windows PowerShell commands and the Remote Access Microsoft Management Console \(MMC\). 

For more information, see [Remote Access](https://docs.microsoft.com/windows-server/remote/remote-access/remote-access).

#### Windows 10 VPN Clients

Remote client computers must be running the Windows 10 Anniversary Update \(version 1607\) or later operating system, and must be joined to your Active Directory domain.

For detailed feature descriptions and a full list of the VPN capabilities in Windows 10, see the [Windows 10 VPN Technical Guide](https://docs.microsoft.com/windows/access-protection/vpn/vpn-guide).

### Active Directory Domain Services \(AD DS\)

AD DS provides a distributed database that stores and manages information about network resources and application-specific data from directory-enabled applications. Administrators can use AD DS to organize elements of a network, such as users, computers, and other devices, into a hierarchical containment structure. The hierarchical containment structure includes the Active Directory forest, domains in the forest, and organizational units \(OUs\) in each domain. A server that is running AD DS is called a domain controller. 

AD DS contains the user accounts, computer accounts, and account properties that are required by Protected Extensible Authentication Protocol \(PEAP\) to authenticate user credentials and to evaluate authorization for VPN connection requests.

For information about deploying AD DS, see the Windows Server 2016 [Core Network Guide](https://docs.microsoft.com/windows-server/networking/core-network-guide/core-network-guide).

#### Active Directory Users and Computers

Active Directory Users and Computers is a component of AD DS that contains accounts that represent physical entities, such as a computer, a person, or a security group. A security group is a collection of user or computer accounts that administrators can manage as a single unit. User and computer accounts that belong to a particular group are referred to as group members. 

#### Group Policy Management

Group Policy Management enables directory-based change and configuration management of user and computer settings, including security and user information. You use Group Policy to define configurations for groups of users and computers. 

With Group Policy, you can specify settings for registry entries, security, software installation, scripts, folder redirection, remote installation services, and Internet Explorer maintenance. The Group Policy settings that you create are contained in a Group Policy object \(GPO\). By associating a GPO with selected Active Directory system containers — sites, domains, and OUs — you can apply the GPO's settings to the users and computers in those Active Directory containers. To manage Group Policy objects across an enterprise, you can use the Group Policy Management Editor Microsoft Management Console \(MMC\). 

### Domain Name System \(DNS\)

DNS is a name resolution protocol for TCP/IP networks, such as the Internet or an organization network. A DNS server hosts the information that enables client computers and services to resolve easily recognized, alphanumeric DNS names to the IP addresses that computers use to communicate with each other.

For more overview information about DNS, see [Domain Name System (DNS)](https://docs.microsoft.com/windows-server/networking/dns/dns-top).

For information about deploying AD DS with DNS, see the Windows Server 2016 [Core Network Guide](https://docs.microsoft.com/windows-server/networking/core-network-guide/core-network-guide).

### Active Directory Certificate Services

AD CS in Windows Server 2016 provides customizable services for creating and managing the X.509 certificates that are used in software security systems that employ public key technologies. Organizations can use AD CS to enhance security by binding the identity of a person, device, or service to a corresponding public key. AD CS also includes features that allow you to manage certificate enrollment and revocation in a variety of scalable environments.

For more information, see [Active Directory Certificate Services Overview](https://technet.microsoft.com/library/hh831740.aspx) and [Public Key Infrastructure Design Guidance](https://social.technet.microsoft.com/wiki/contents/articles/2901.public-key-infrastructure-design-guidance.aspx). 

#### Certificate Templates

Certificate templates can greatly simplify the task of administering a certification authority \(CA\) by allowing you to issue certificates that are preconfigured for selected tasks. The Certificate Templates MMC snap-in allows you to perform the following tasks.

- View properties for each certificate template.
- Copy and modify certificate templates.
- Control which users and computers can read templates and enroll for certificates.
- Perform other administrative tasks relating to certificate templates.

Certificate templates are an integral part of an enterprise certification authority (CA). They are an important element of the certificate policy for an environment, which is the set of rules and formats for certificate enrollment, use, and management.

For more information, see [Certificate Templates](https://technet.microsoft.com/library/cc730705.aspx).

#### Digital Server Certificates

This guide provides instructions for using Active Directory Certificate Services (AD CS) to both enroll and automatically enroll certificates to Remote Access and NPS infrastructure servers. AD CS allows you to build a public key infrastructure \(PKI\) and provide public key cryptography, digital certificates, and digital signature capabilities for your organization.  

When you use digital server certificates for authentication between computers on your network, the certificates provide:

1. Confidentiality through encryption. 
2. Integrity through digital signatures. 
3. Authentication by associating certificate keys with computer, user, or device accounts on a computer network. 

For more information, see [AD CS Step by Step Guide: Two Tier PKI Hierarchy Deployment](https://social.technet.microsoft.com/wiki/contents/articles/15037.ad-cs-step-by-step-guide-two-tier-pki-hierarchy-deployment.aspx).

### Network Policy Server (NPS)

NPS allows you to create and enforce organization-wide network access policies for connection request authentication and authorization. When you use NPS as a Remote Authentication Dial-In User Service \(RADIUS\) server, you configure network access servers, such as VPN servers, as RADIUS clients in NPS. You also configure network policies that NPS uses to authorize connection requests, and you can configure RADIUS accounting so that NPS logs accounting information to log files on the local hard disk or in a Microsoft SQL Server database. 

You can also configure NPS as a RADIUS proxy to forward connection requests to a remote NPS or other RADIUS server so that you can load balance connection requests and forward them to the correct domain for authentication and authorization.

For more information, see [Network Policy Server (NPS)](https://docs.microsoft.com/windows-server/networking/technologies/nps/nps-top).

For the next section in this guide, see [Remote Access Always On VPN Deployment Overview](always-on-vpn-deploy-overview.md).


