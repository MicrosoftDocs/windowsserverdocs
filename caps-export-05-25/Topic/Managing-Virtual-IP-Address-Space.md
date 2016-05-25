---
title: Managing Virtual IP Address Space
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 65f1206e-eab4-456d-b85d-f9f7af121a06
---
# Managing Virtual IP Address Space
  
> [!NOTE]  
> This content on this page is currently being updated. Please return to this page soon for more information.  
  
Virtual IP address management in IPAM enables you to display, manage and synchronize the IP address settings that are associated with logical networks and virtual machine networks \(VM networks\) in Virtual Machine Manager \(VMM\) using one or more IPAM servers.  
  
## <a name="enable_vasm"></a>Enable the IPAM network service in VMM  
To enable an IPAM server to communicate with VMM, use the **Add Network Service Wizard** to add **Microsoft Windows Server IP Address Management**. See [Configure IPAM VMM Integration](../Topic/Configure-IPAM-VMM-Integration.md) for detailed step\-by\-step instructions. Also see [Synchronize IPAM and VMM](../Topic/Synchronize-IPAM-and-VMM.md) for procedures to add a logical network to VMM or IPAM and then synchronize network settings.  
  
After completing the wizard in VMM, and provisioning a VMM user account on the IPAM server, logical networks in VMM are displayed in IPAM under **VIRTUALIZED IP ADDRESS SPACE** and can be managed similar to the way that physical IP addresses are managed using the **IP ADDRESS SPACE** node in IPAM. Virtual IPv4 and IPv6 address ranges, addresses, subnets, and spaces are displayed in IPAM if they are enabled on the **Host Group** page of the VMM **Add Network Service Wizard**. Both provider IP address space and customer IP address space can be managed.  
  
IPAM in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] uses [Role\-based access control](../Topic/IP-Address-Management--IPAM--Overview.md#RBAC) to provision a VMM user account and VMM user group on IPAM that has permission to manage IP addresses in IPAM. The user or group must have at least **IPAM ASM Administrator** privileges and also be a member of the **Remote Management Users** group on the IPAM server.  
  
## <a name="manage_vasm"></a>View and manage virtual IP addresses and subnets  
When the IPAM network service is enabled in VMM, you can create and modify logical networks in IPAM and these will be automatically created and synchronized with VMM. Alternatively, you can create and edit a logical network in VMM and then view it in IPAM. If VMM is already configured with logical networks, these networks are automatically displayed in IPAM, assuming they are enabled as a Host Group for the IPAM network service in VMM.  
  
Virtual IP address space in IPAM consists of two types:  
  
-   **Provider IP Address Space**: Also called logical networks in VMM.  
  
-   **Customer IP Address Space**: Also called VM networks or tenant networks.  
  
A customer IP address space is contained within a provider IP address space. Therefore, each customer IP address space has an associated provider IP address space.  
  
IP address spaces are defined as IP address networks that are connected. If two networks are not connected to each other, then these networks exist in separate IP address spaces.  
  
In IPAM, subnets can be assigned to logical networks. In this way, logical networks can be displayed under provider address space. When you view **IP Address Subnets** in IPAM, the **VMM Logical Network** and **Network Site** are displayed and the view can be filtered based on these parameters \(ex: IPv4 > Provider IP Address Space > Provider IP Address Space name > VMM Logical Network name > Network Site name\).  
  
## See also  
[How to Add an IPAM Server in VMM in System Center 2012 R2](http://technet.microsoft.com/library/dn249418.aspx)  
  
