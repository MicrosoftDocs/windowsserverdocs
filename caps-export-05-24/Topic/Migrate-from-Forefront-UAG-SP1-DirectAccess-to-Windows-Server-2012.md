---
title: Migrate from Forefront UAG SP1 DirectAccess to Windows Server 2012
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a60329b6-d0d2-4b17-8cff-0d9fc009691b
---
# Migrate from Forefront UAG SP1 DirectAccess to Windows Server 2012
This document describes the migration of an existing Forefront UAG SP1 DirectAccess deployment to DirectAccess in [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)]. It illustrates migration of a simple scenario that includes either a single Forefront UAG server, or an array of Forefront UAG servers configured in a single domain and a single site using NAT64, and not set up as an ISATAP router. Note that this upgrade is only supported for computers running Forefront UAG SP1.  
  
## Windows Server 2012 Remote Access \(DirectAccess\) Deployment Documentation Set  
Following is a listing of the documentation for the three main Remote Access deployment paths: **Basic**, **Advanced** and **Enterprise**. Also listed are the **Managing** and **Migrating** documents available for this release.  
  
### Deploy Basic Remote Access  
  
-   **[Deploy a Single DirectAccess Server Using the Getting Started Wizard](../Topic/Deploy-a-Single-DirectAccess-Server-Using-the-Getting-Started-Wizard.md)**  
  
    -   [Test Lab Guide: Demonstrate DirectAccess Simplified Setup in an IPv4\-only Test Environment in Windows Server 2012](http://www.microsoft.com/download/details.aspx?id=29029)  
  
### Deploy Advanced Remote Access  
  
-   **[Deploy a Single DirectAccess Server with Advanced Settings](../Topic/Deploy-a-Single-DirectAccess-Server-with-Advanced-Settings.md)**  
  
    -   [Test Lab Guide: Demonstrate DirectAccess Single Server Setup with Mixed IPv4 and IPv6 in Windows Server 2012](http://www.microsoft.com/download/details.aspx?id=29031)  
  
### Deploy Remote Access in an Enterprise  
  
-   [DirectAccess Capacity Planning_1](../Topic/DirectAccess-Capacity-Planning_1.md)  
  
-   **[Deploy Remote Access in a Cluster](../Topic/Deploy-Remote-Access-in-a-Cluster.md)**  
  
    -   [Test Lab Guide: Demonstrate DirectAccess in a Cluster with Windows NLB](../Topic/Test-Lab-Guide--Demonstrate-DirectAccess-in-a-Cluster-with-Windows-NLB.md)  
  
-   **[Deploy Multiple Remote Access Servers in a Multisite Deployment](../Topic/Deploy-Multiple-Remote-Access-Servers-in-a-Multisite-Deployment.md)**  
  
    -   [Test Lab Guide: Demonstrate a DirectAccess Multisite Deployment](../Topic/Test-Lab-Guide--Demonstrate-a-DirectAccess-Multisite-Deployment.md)  
  
-   **[Deploy Remote Access with OTP Authentication_](../Topic/Deploy-Remote-Access-with-OTP-Authentication_.md)**  
  
    -   [Test Lab Guide: Demonstrate DirectAccess with OTP Authentication and RSA SecurID](../Topic/Test-Lab-Guide--Demonstrate-DirectAccess-with-OTP-Authentication-and-RSA-SecurID.md)  
  
-   **[Deploy Remote Access in a Multi-Forest Environment](../Topic/Deploy-Remote-Access-in-a-Multi-Forest-Environment.md)**  
  
-   [DirectAccess Offline Domain Join_1](../Topic/DirectAccess-Offline-Domain-Join_1.md)  
  
### Manage Remote Access  
  
-   **[Use Remote Access Monitoring and Accounting_1](../Topic/Use-Remote-Access-Monitoring-and-Accounting_1.md)**  
  
-   **[Manage DirectAccess Clients Remotely_1](../Topic/Manage-DirectAccess-Clients-Remotely_1.md)**  
  
### Migrate Remote Access  
  
-   **[Migrate Remote Access to Windows Server 2012](../Topic/Migrate-Remote-Access-to-Windows-Server-2012.md)**  
  
-   **[Migrate from Forefront UAG SP1 DirectAccess to Windows Server 2012](../Topic/Migrate-from-Forefront-UAG-SP1-DirectAccess-to-Windows-Server-2012.md)**  
  
## Before you begin deploying, see the list of unsupported configurations, known issues, and prerequisites  
  
-   [DirectAccess Unsupported Configurations_1](../Topic/DirectAccess-Unsupported-Configurations_1.md)  
  
-   [DirectAccess Known Issues_1](../Topic/DirectAccess-Known-Issues_1.md)  
  
-   [Prerequisites for Deploying DirectAccess_1](../Topic/Prerequisites-for-Deploying-DirectAccess_1.md)  
  
## <a name="BKMK_OVER"></a>Scenario description  
Supported migration scenarios for Forefront UAG SP1 are as follows:  
  
|Supported client operating systems|Supported domain controllers|Supported application servers|  
|--------------------------------------|--------------------------------|---------------------------------|  
|[!INCLUDE[firstref_client_7](../Token/firstref_client_7_md.md)]Windows 7<br /><br />[!INCLUDE[win8_client_1](../Token/win8_client_1_md.md)]<br /><br />[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|Windows 2003 Server<br /><br />[!INCLUDE[firstref_longhorn](../Token/firstref_longhorn_md.md)]<br /><br />[!INCLUDE[firstref_server_7](../Token/firstref_server_7_md.md)]<br /><br />[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|Windows 2003 Server<br /><br />[!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]<br /><br />[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]<br /><br />[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|  
  
## In this scenario  
Two migration scenarios are described:  
  
-   **Side\-by\-side migration**— Use this type of migration to keep the Forefront UAG DirectAccess server running while you deploy DirectAccess in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. After the deployment is complete, DirectAccess clients use DirectAccess configured on the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] computer, and the Forefront UAG server is removed from service. This type of migration requires duplication of some settings because FQDN, IP addresses, and certificate settings must be unique on each server.  
  
-   **Offline migration**— Use this type of migration to copy the DirectAccess configuration with identical settings from the Forefront UAG DirectAccess server to the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] computer running as a Remote Access server. Then shut down the Forefront UAG server. Service for DirectAccess clients will not be available until the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Remote Access server is up and running.  
  
## Prerequisites  
Before you begin deploying this scenario, review this list for important requirements:  
  
-   ISATAP in the corporate network is not supported. If you are using ISATAP, you should remove it and use native IPv6.  
  
-   If NAP is used inbox in UAG, NAP is now going to require a separate NPS server.  
  
    NAP was deprecated in Windows Server 2012 R2. This means that NAP may not be supported in future versions of Windows. New deployments with NAP are not recommended.  
  
## <a name="BKMK_APP"></a>Practical applications  
This scenario describes how to continue running an existing DirectAccess deployment using [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] instead of Forefront UAG.  
  
## <a name="BKMK_HARD"></a>Hardware requirements  
Hardware requirements include the following:  
  
-   One or more Forefront UAG servers successfully running a DirectAccess deployment.  
  
-   [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Remote Access server requirements:  
  
    -   A computer that meets the hardware requirements for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
-   Client requirements for DirectAccess in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]:  
  
    -   A client computer must be running [!INCLUDE[win8_client_1](../Token/win8_client_1_md.md)] or Windows 7.  
  
-   Infrastructure and management server requirements:  
  
    -   During remote management of DirectAccess client computers, clients initiate communications with management servers such as domain controllers, System Center Configuration Servers, and Health Registration Authority \(HRA\) servers for services that include Windows and antivirus updates and Network Access Protection \(NAP\) client compliance. The required servers should be deployed before beginning the Remote Access deployment.  
  
    -   If remote access requires client NAP compliance, NPS and HRS servers should be deployed before beginning remote access deployment  
  
    -   A certification authority \(CA\) server is required if certificates will be issued for authentication of IP\-HTTPS and the network location server. Note that DirectAccess in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] supports the use of self\-signed certificates created automatically during DirectAccess deployment.  
  
    -   A DNS server running Windows Server 2003, Windows Server 2008 SP2; Windows Server 2008 R2; or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] is required.  
  
## <a name="BKMK_SOFT"></a>Software requirements  
There are a number of requirements for this scenario:  
  
-   DirectAccess server requirements in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]:  
  
    -   The Remote Access server must be a domain member. The server can be deployed at the edge of the internal network, or behind an edge firewall or other device.  
  
    -   The person deploying remote access on the server requires local administrator permissions on the server, and have a domain user account. To prepare the GPOs domain administrator permissions are required.  
  
-   Remote access client requirements:  
  
    -   DirectAccess clients must be domain members. Domains containing clients can belong to the same forest as the Remote Access server, or have a two\-way trust with the Remote Access server forest or domain.  
  
    -   An Active Directory security group is required to contain the computers that will be configured as DirectAccess clients.  
  
### Using ISATAP  
ISATAP is not recommended for use as the IPv6 to IPv4 transition technology in DirectAccess in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. If Forefront UAG is configured to use ISATAP, it is recommended to disable it, and use NAT64 instead.  
  
With ISATAP disabled DirectAccess clients can initiate connections to computers on the internal network, and the computers on the internal network are able to respond. However, computers on the internal network will not be able to initiate connections to DirectAccess  for purposes of remote client management. If you want to be able to remote client management, consider deploying native IPv6 for management servers that will connect to DirectAccess client computers.  
  
### Using NAP  
Forefront UAG provides complex Network Access Policy \(NAP\) configuration settings, and the Network Policy Server \(NPS\) and Health Registration Authority \(HRA\) roles can be installed on the Forefront UAG server.  These settings are not supported for DirectAccess in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], you can only specify whether or not client compliance is enforced using NAP during IPsec authentication.  NPS and HRA roles are installed on remote servers in the internal network. The HRA server must be accessible over the first DirectAccess tunnel, or over the Internet.  
  
