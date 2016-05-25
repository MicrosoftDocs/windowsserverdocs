---
title: Install IPAM Server
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4301a7d3-23f5-46b3-a203-8aaaa2d37f65
---
# Install IPAM Server
[Checklist: Deploy IPAM Server](../Topic/Checklist--Deploy-IPAM-Server.md) > **Install IPAM Server**  
  
The IPAM Server feature can be installed using the Add Roles and Features wizard in Server Manager, or using Windows PowerShell.  
  
> [!IMPORTANT]  
> IPAM Server must be installed on a domain member computer running [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] or a later operating system. The IPAM server is intended as a single purpose server and should not be installed with other network infrastructure roles such as DNS or DHCP. You cannot install IPAM on a domain controller. If IPAM Server is running on a computer that is also running the DHCP Server role, discovery of DHCP servers on the network will be disabled.  
  
Ensure that the IPAM server has network connectivity to at least one Active Directory domain controller, and all IP infrastructure servers that it will monitor and manage.  
  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
## Installing IPAM Server  
  
-   [Using the Windows interface](#BKMK_winui)  
  
-   [Using a command line](#BKMK_cmd)  
  
#### To install IPAM Server using the Windows interface  
  
1.  On the Server Manager Dashboard page, click **Add roles and features**, click **Next** twice, and select the IPAM server from the server pool. By default, the current server is selected.  
  
2.  Click **Next** twice and then on the **Select features** page, select the **IP Address Management \(IPAM\) Server** checkbox.  
  
3.  In the **Add features that are required for IP Address Management \(IPAM\) Server** dialog box, click **Add Features**.  
  
4.  Click **Next**, and then click **Install**.  
  
5.  On the **Installation progress** page, verify that installation succeeded and then click **Close**.  
  
#### To install IPAM Server using the command line  
  
1.  Open an elevated Windows PowerShell prompt, type the following command, and then press ENTER.  
  
    ```  
    Install-WindowsFeature IPAM -IncludeManagementTools  
    ```  
  
2.  In the output, verify that the value of **Exit Code** displayed is **Success**.  
  
## See Also  
[Choose an IPAM Provisioning Method](../Topic/Choose-an-IPAM-Provisioning-Method.md)  
  
