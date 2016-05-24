---
title: Domain Name System (DNS) Overview
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9b646fab-b6c7-4855-8ece-3b1d4e70db57
---
# Domain Name System (DNS) Overview
This topic provides overview information about the Domain Name System \(DNS\) server role in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], and the DNS Client service in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], and [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)]. Also see the following topics:  
  
-   [What's New in DNS Server in Windows Server](assetId:///e36880f8-70a1-41cd-8341-fb7a9d0c009c): Provides information about new DNS Server features and functionality in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
-   [What's New in DNS Client in Windows](assetId:///73ccffe3-4c81-4a80-babb-03036504de92): Provides information about new DNS Client features and functionality in [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and in [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
-   [DNSSEC in Windows Server 2012](../Topic/DNSSEC-in-Windows-Server-2012.md): Provides information about DNS Security Extensions support in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], including concepts and detailed deployment procedures.  
  
-   [Step-by-Step: Demonstrate DNSSEC in a Test Lab](../Topic/Step-by-Step--Demonstrate-DNSSEC-in-a-Test-Lab.md): Provides step by step instructions for deploying DNSSEC in a test lab.  
  
-   [Windows Server 2012 Virtual Labs](http://technet.microsoft.com/windowsserver/hh968267.aspx) combines IP address management \(IPAM\) in a virtual lab with DNSSEC and DHCP failover in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. See [Building a Resilient Network Infrastructure](http://go.microsoft.com/fwlink/p/?LinkID=317748) to start the virtual lab. Note: The virtual lab will take some time to start.  
  
## <a name="BKMK_1"></a>Role description  
DNS is a system that is used in TCP\/IP networks for naming computers and network services. DNS naming locates computers and services through user\-friendly names. When a user enters a DNS name in an application, DNS services can resolve the name to other information that is associated with the name, such as an IP address.  
  
Windows Server provides several enhancements to the DNS Server service. For more information about what’s new in DNS Server and DNS Client for [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], and [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], see [What's New in DNS Server in Windows Server](assetId:///e36880f8-70a1-41cd-8341-fb7a9d0c009c) and [What's New in DNS Client in Windows](assetId:///73ccffe3-4c81-4a80-babb-03036504de92).  
  
## Practical applications  
DNS in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] provides the following:  
  
-   The DNS Server service in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] has greatly enhanced support for DNS Security Extensions \(DNSSEC\), a suite of extensions that adds security to the DNS protocol. For more information about DNSSEC, see [Overview of DNSSEC](../Topic/Overview-of-DNSSEC.md).  
  
-   DNS integration with Active Directory is the same in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] as in previous operating systems. When DNS Server is installed on a domain controller, DNS is integrated Active Directory Domain Services \(AD DS\) to store and replicate DNS zones. This makes multimaster replication possible, along with more secure transmission of DNS data. In turn, AD DS requires DNS so that clients can locate domain controllers.  
  
-   DNS and DHCP integration is the same in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] as in previous operating systems. DNS and DHCP integration enables DNS resource records to be dynamically updated for new computers and devices, or when IP addresses of existing devices change on the network.  
  
## <a name="BKMK_NEW"></a>New and changed functionality  
See [What's New in DNS Server in Windows Server](assetId:///e36880f8-70a1-41cd-8341-fb7a9d0c009c) and [What's New in DNS Client in Windows](assetId:///73ccffe3-4c81-4a80-babb-03036504de92).  
  
## <a name="BKMK_INSTALL"></a>Server Manager information  
Installation of the DNS Server role can be performed using Server Manager. The following features and tools are installed automatically when you install DNS Server:  
  
|Feature or Tool|Description|  
|-------------------|---------------|  
|Remote Server Administration Tools|DNS Server Tools are required to manage the DNS Server role, but do not have to be installed on the same server. The DNS Manager console is installed automatically when you install DNS Server unless you choose to cancel installation of Remote Server Administration Tools.|  
  
> [!IMPORTANT]  
> The DNS Server role is frequently installed with Active Directory Domain Services \(AD DS\). DNS Server and can be installed on a domain controller using Server Manager’s Add Roles and Features Wizard, or it can be installed as an available option during promotion of a server to a domain controller. If you install AD DS and promote the server to a domain controller using Windows PowerShell, you can install DNS by specifying the **–InstallDns** parameter when using the **Install\-ADDSDomainController** cmdlet.  
>   
> DNS Server and AD DS role services can be installed independently or together. However, the AD DS role service is required if the DNS server will host Active Directory\-integrated DNS zones.  
  
