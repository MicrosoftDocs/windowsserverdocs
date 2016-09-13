---
title: "System Requirements for Windows Server 2012 Essentials"
ms.custom: na
ms.date: 04/01/2014
ms.prod: windows-server-2012-r2-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
applies_to: 
  - Windows Server 2012 Essentials
  - Windows Server 2012 R2 Essentials
ms.assetid: 49565621-ecd6-412b-b91a-e12e3b8a8773
caps.latest.revision: 21
author: DonGill
manager: stevenka

---
# System Requirements for Windows Server 2012 Essentials
 Windows Server 2012 Essentials server software is a 64-bit only operating system. Table 1 defines the recommended minimum hardware requirements for  Windows Server 2012 Essentials. Table 2 defines additional hardware and software requirements for the server.  
  
> [!NOTE]
>  Are you looking for system requirements for Windows Server 2012? If so, go to [Installing Windows Server 2012](assetId:///ddf71ebb-fc52-4ecb-aa88-109167c5f1c8) in the Windows Server TechNet Library.  
  
### Table 1:  System Requirements for Windows Server 2012 Essentials  
  
|Component|Minimum|Recommended*|  
|---------------|-------------|-------------------|  
|CPU socket|1.4 GHz (64-bit processor) or faster for single core<br /><br /> 1.3 GHz (64-bit processor) or faster for multi-core|3.1 GHz (64-bit processor) or faster multi-core|  
|Memory (RAM)|2 GB|8 GB|  
|Hard disks and available storage space|160 GB hard disk with a 60 GB system partition||  
  
 *Recommended hardware requirements to support  Windows Server 2012 Essentials maximum user and device limits.  
  
### Table 2:  Additional Hardware and Software Requirements for Windows Server 2012 Essentials  
  
|Component|Description|  
|---------------|-----------------|  
|Network adapter|Gigabit Ethernet adapter (10/100/1000baseT PHY/MAC).|  
|Internet|Some functionality may require Internet access (fees may apply) or a Windows Live® ID Account.|  
|Supported Client operating systems| Windows 8, Windows 7, Macintosh OS X version 10.5 to 10.8.|  
|Router|A router or firewall that supports IPv4 NAT.|  
|Additional requirements|- Super-VGA 800 x 600 (minimum) or  1024 × 768 (recommended) or higher-resolution monitor (headed mode only)<br /><br /> - Keyboard and Microsoft® Mouse or compatible pointing device (headed mode only)<br /><br /> - DVD-ROM drive|  
|Supported networking configuration|- Your server computer must be connected via a network cable to a router.<br /><br /> - The router should be a UPnP-certified device, but it is not required.<br /><br /> - The router should be in the 192.168.x.x subnet, but it is not required.|  
  
##  <a name="BKMK_NetworkConfig"></a> Supported network configurations  
 The supported network configuration for Windows Server Essentials is as follows:  
  
-   A computer running Windows Server Essentials and connected to the network through a router or firewall. For more information, see “Connect computers to the server by using the Connector software�? in [Get Connected](../use/Get-Connected-in-Windows-Server-Essentials.md).  
  
-   Client computers running a supported operating system. For more information, see “Prepare to connect computers to the server�? in [Get Connected](../use/Get-Connected-in-Windows-Server-Essentials.md).  
  
### NIC Teaming  
 Some hardware manufacturers provide network adapters and drivers that feature fault tolerance technology. You can use fault tolerance technology to group network adapter ports for a connection to a single physical segment. This is known as “NIC Teaming.�? If connectivity through one port does not work, another port is automatically activated to handle the connection. This process is transparent to the operating system and to other devices on the network.  
  
 The Windows Server Essentials networking wizards, such as the Remote Web Access Wizard, do not support NIC Teaming because it is a scenario that is not typically used in a small business environment.  
  
 If you choose to configure NIC Teaming, you should not do so until after you install the server and complete all the server configuration tasks.  
  
 In addition, you should not use the Windows Server Essentials networking wizards after you configure NIC Teaming because doing this will have an unknown effect on the team.  
  
> [!IMPORTANT]
>  Because the Windows Server Essentials networking wizards do not support NIC Teaming, if you configure NIC Teaming and then require assistance from Microsoft support, you will be instructed to remove NIC Teaming, and then use the Windows Server Essentials networking wizards to correctly configure the server for the network.  
  
##### To remove NIC Teaming  
  
1.  Uninstall the NIC Teaming software, and then restart the server when you are prompted.  
  
2.  Use Device Manager to uninstall the virtual network adapter, and then restart the server when you are prompted.  
  
## See also  
  
<<<<<<< HEAD
-   [Install Windows Server Essentials](Install-Windows-Server-Essentials.md)
=======
-   [Install Windows Server Essentials](../install/Install-Windows-Server-Essentials.md)
>>>>>>> 4bac1739fd0378146de6c9af26f683b8076754b8
