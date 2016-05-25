---
title: Dynamic Host Configuration Protocol (DHCP) Overview
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: eb9ac71c-9eb7-4d51-b98c-8d50b9ddeaec
---
# Dynamic Host Configuration Protocol (DHCP) Overview
This topic provides overview information about the Dynamic Host Configuration Protocol \(DHCP\) Server role in [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. Also see the following topics:  
  
-   [What's New in DHCP in Windows Server 2012 R2](assetId:///e8f2eac3-07b2-4241-b41c-2c6bca35d360): Provides information about changes in functionality for DHCP in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
-   [What's New in DHCP in Windows Server 2012 \[redirected\]](assetId:///f82f8081-235d-4c5a-b47b-8009e705c5fd): Provides information about changes in functionality for DHCP in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
-   [Understand and Deploy DHCP Failover](../Topic/Understand-and-Deploy-DHCP-Failover.md): Provides detailed information about a new option for DHCP high availability in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
-   [Step-by-Step: Configure DHCP Using Policy-based Assignment](../Topic/Step-by-Step--Configure-DHCP-Using-Policy-based-Assignment.md): Provides step by step instructions for configuring DHCP policies in a test lab with [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
-   [Step-by-Step: Configure DHCP for Failover](../Topic/Step-by-Step--Configure-DHCP-for-Failover.md): Provides step by step instructions for configuring DHCP failover in a test lab with [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
-   [Windows Server 2012 Virtual Labs](http://technet.microsoft.com/windowsserver/hh968267.aspx) combines IP address management \(IPAM\) in a virtual lab with DNSSEC and DHCP failover in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. See [Building a Resilient Network Infrastructure](http://go.microsoft.com/fwlink/p/?LinkID=317748) to start the virtual lab. Note: The virtual lab will take some time to start.  
  
## <a name="BKMK_1"></a>Role description  
DHCP is an Internet Engineering Task Force \(IETF\) standard designed to reduce the administration burden and complexity of configuring hosts on a TCP\/IP\-based network, such as a private intranet. Using the DHCP Server service, the process of configuring TCP\/IP on DHCP clients is automatic.  
  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] provide several enhancements to the DHCP Server service.  
  
## Practical applications  
DHCP in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] provide the following:  
  
1.  Safe, easy and reliable: Valid configuration parameters for all clients on the network can be dynamically provided. DHCP clients renew their leased address allocation automatically in the background. With DHCP failover, a new feature in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], DHCP servers can provide a highly resilient DHCP service that allows the DHCP client to extend the lease on its current IP address by contacting another DHCP server on the enterprise network.  
  
2.  Flexible assignment: DHCP supports a large and extensible set of client configuration parameters. With client reservations, it is possible to reserve a specific IP address for permanent use by a DHCP client. A new feature in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] called policy based assignment allows for even greater flexibility.  
  
3.  DHCP integration with DNS enables DNS resource records to be dynamically updated for new computers and devices, or when IP addresses of existing devices change on the network.  
  
## <a name="BKMK_NEW"></a>New and changed functionality  
  
-   [What's New in DHCP in Windows Server 2012 R2](assetId:///e8f2eac3-07b2-4241-b41c-2c6bca35d360): Provides information about changes in functionality for DHCP in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
-   [What's New in DHCP in Windows Server 2012 \[redirected\]](assetId:///f82f8081-235d-4c5a-b47b-8009e705c5fd): Provides information about changes in functionality for DHCP in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
## <a name="BKMK_INSTALL"></a>Server Manager information  
Installation of the DHCP Server role can be performed using Server Manager. The following features and tools are installed automatically when you install DHCP Server:  
  
|Feature or Tool|Description|  
|-------------------|---------------|  
|Remote Server Administration Tools|DHCP Server Tools are required to manage the DHCP Server role, but do not have to be installed on the same server. The DHCP Management console is installed automatically when you install DHCP Server unless you choose to cancel installation of Remote Server Administration Tools.|  
  
## See Also  
[Step-by-Step: Configure DHCP for Failover](../Topic/Step-by-Step--Configure-DHCP-for-Failover.md)  
[Step-by-Step: Configure DHCP Using Policy-based Assignment](../Topic/Step-by-Step--Configure-DHCP-Using-Policy-based-Assignment.md)  
  
