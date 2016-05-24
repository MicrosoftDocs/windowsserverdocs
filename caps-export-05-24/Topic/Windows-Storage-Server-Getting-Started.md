---
title: Windows Storage Server Getting Started
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2e3c1bb9-b2d7-4607-9aeb-cb15b1b082d1
---
# Windows Storage Server Getting Started
This document describes the process for creating a master image of a reference installation of Windows Storage Server 2012 that can be deployed to storage appliances.  
  
## Before you begin  
Before you can create an image of a reference installation of Windows Storage Server 2012, you must obtain and install the Windows ADK and other required hardware and software.  
  
### Hardware  
The following hardware is required, except as noted.  
  
1.  **Technician computer**. A technician computer can be any computer on which you will install the Windows ADK. For installation instructions and system requirements, see [Installing the Windows ADK](http://msdn.microsoft.com/library/hh825494.aspx)I \(http:\/\/msdn.microsoft.com\/library\/hh825494.aspx\).  
  
2.  **At least one reference computer**. A reference computer is a fully assembled computer \(storage appliance\) on which you install a customized installation of Windows Storage Server 2012. After customizing the installation, you capture and store an image of the installation. If you plan to use a network for deployment or testing purposes, the technician computer and the reference computers require a network adapter and a working network environment  
  
    To test your deployment image for use in a two\-node cluster, you may need a computer that is one identical to the reference computer to act as the second node on your cluster in addition to an attached \(and configured\) storage array.  
  
3.  \(Optional\) **Destination computer**. This must be running a 64\-bit operating system and be an exact duplicate of the reference computer. This computer is optional because the reference computer can be reused as the destination computer  
  
4.  \(Optional\) **External storage**. A USB flash drive \(UFD\), or alternatively, an external USB hard disk can be used to store deployment resources when performing deployments locally  
  
### Network equipment  
If you are creating an image for a standalone storage appliance and you intend to complete deployments locally, networking equipment is optional.  
  
1.  **Network switch or router**. This is required for network\-based deployments or for testing network access of the reference storage appliance  
  
2.  **Ethernet cables**. These are required for network\-based deployments or for testing network access of the reference storage appliance  
  
3.  **Ethernet crossover cable \(or regular Ethernet cables and switch\)**. This is required for node to node communications of a clustered storage appliance  
  
### Software  
The following software is required:  
  
1.  **Windows ADK**. Before you can deploy Windows Storage Server 2012, you must have the [Windows Assessment and Deployment Kit \(ADK\) for Windows](http://www.microsoft.com/download/en/details.aspx?id=28997) \(http:\/\/www.microsoft.com\/download\/en\/details.aspx?id\=28997\) installed on your technician computer.  
  
2.  **Windows Server 2012 installation media**. You need installation media for Windows Server 2012 Standard or Windows Server 2012 Standard.  
  
3.  **Signed drivers**. You need signed 64\-bit drivers for all hardware in the reference computer. You can use the Windows Kernel Mode Code Signing process if you need the flexibility of signing the drivers yourself.  
  
    For information about digital signatures for drivers, see [Kernel\-Mode Code Signing Policy \(Windows Vist a and Later\)](http://go.microsoft.com/fwlink/?LinkId=196975) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=196975\).  
  
4.  **\(Optional\) Language packs**. You will need language packs for each supported language that you want to deploy on the storage appliance.  
  
### Checklist: Create and deploy a master image for Windows Storage Server 2012  
The following checklist provides an overview of the process for creating a master image that you can deploy to your storage appliances.  
  
|||  
|-|-|  
|**Task**|**Steps**|  
|Before you begin|1.  Review the features for each edition of Windows Storage Server 2012.<br />2.  Obtain and [install the Windows ADK](http://msdn.microsoft.com/library/hh825494.aspx) \(http:\/\/msdn.microsoft.com\/library\/hh825494.aspx\).<br />3.  Review the resources needed to complete the process.|  
|**Step 1**: Install the applicable language\-specific version of Windows Storage Server 2012 on the reference computer|1.  \(Optional\) Install language packs. Windows Storage Server 2012 supports 19 languages.<br />2.  \(Optional\) Set Windows PowerShell™ execution policy. This policy must be enabled if you customize the end user setup experience.<br />3.  Enable Windows Remote Management. This policy must be enabled if your storage appliance will be part of a failover cluster.<br />4.  \(Optional\) Add your OEM software license terms in all the supported languages. If you need end users to accept your software license terms during the appliance setup, you need to add the agreement to your installation.|  
|**Step 2**: Customize the end users’ installation experience for their usage scenario|1.  Customize the Initial Configuration Tasks \(ICT\) window for your storage appliance \(as a standalone appliance or as a node in a cluster\)<br />2.  Edit the registry and create the Nic.config and Unattend.xml files.|  
|**Step 3**: Reseal, capture, deploy, and test the master image|1.  Reseal the installation on the reference computer<br />2.  Capture the master image<br />3.  Deploy and test the master image|  
|**Step 4**: Complete post deployment tasks|Tasks include actions such as preparing a System Recovery disc and providing end user documentation. Review your OEM software license terms for more details.|  
  
