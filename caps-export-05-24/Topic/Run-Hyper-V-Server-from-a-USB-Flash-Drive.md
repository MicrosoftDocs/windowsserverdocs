---
title: Run Hyper-V Server from a USB Flash Drive
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d258ac66-6f6c-43a5-8fc0-acee92290fcc
author: cwatsonmsft
---
# Run Hyper-V Server from a USB Flash Drive
  
> [!NOTE]  
> The scenario that is described in this topic is only supported for original equipment manufacturers \(OEMs\).  
  
Microsoft Hyper\-V Server supports the ability to boot from a USB flash drive. This topic describes the policy requirements, hardware requirements, and steps required to create and deploy a Hyper\-V Server image on an embedded USB flash drive. A USB flash drive with Hyper\-V Server can provide virtualization capability for servers that ship with no local hard disk drives, and it offers the same functionality and flexibility as an installation of Hyper\-V Server on a spinning disk drive.  
  
The USB flash drive must be properly formatted, prepared with a generalized Hyper\-V Server image, and it must have the boot files copied onto it to provide a virtualization experience for customers. The USB flash drive can then be used to boot Hyper\-V Server onto any computer that has hardware\-assisted virtualization capabilities and is capable of booting from USB.  
  
## Creating a bootable Hyper\-V Server USB flash drive  
The directions and limitations in the following topic apply to Hyper\-V Server 2012 R2 and Hyper\-V Server 2012: [Deploying Microsoft Hyper\-V Server 2008 R2 on USB Flash Drive](http://technet.microsoft.com/library/ee731893(WS.10).aspx).  
  
## Recommended USB flash drive hardware  
For Hyper\-V Server, the recommended hardware is the same as that recommended for Windows To Go. For more information, see [Windows To Go: Feature Overview](http://technet.microsoft.com/library/hh831833.aspx). Specific USB flash drives that are currently recommended include:  
  
-   Kingston DataTraveler Ultimate  
  
-   Super Talent Express RC8  
  
-   Western Digital My Passport Enterprise  
  
In general, a host computer used for running Hyper\-V Server from a flash drive must have the following characteristics:  
  
|Parameter|Requirement|  
|-------------|---------------|  
|Boot process|Must be capable of booting with a USB flash drive|  
|Firmware|Must be certified for use with Windows Server and configurable to boot directly from a USB flash drive. If you are unsure of the ability of the computer to boot from a USB flash drive, check with the hardware manufacturer.|  
|External USB hub|Not supported. Connect the USB flash drive directly to the host computer.|  
|USB version|2.0 or newer|  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Microsoft Hyper\-V Server 2012 R2 and Hyper\-V Server 2012 \[MTPS TOC\]](../DocSets/Harvest_TH_Microsoft-Hyper-V-Server-2012-and-Microsoft-Hyper-V-Server-2012-R2/NotInToc/Microsoft-Hyper-V-Server-2012-R2-and-Hyper-V-Server-2012_deleted.md)  
  
-   [Hyper\-V Overview](assetId:///5aad349f-ef06-464a-b36f-366fbb040143)  
  
-   [Microsoft Hyper\-V Server 2008 R2](http://technet.microsoft.com/library/ee815281(v=ws.10).aspx)  
  
