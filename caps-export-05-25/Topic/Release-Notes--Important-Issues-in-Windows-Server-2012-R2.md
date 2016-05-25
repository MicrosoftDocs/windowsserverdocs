---
title: Release Notes: Important Issues in Windows Server 2012 R2
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 84f5dec4-fc3b-47d3-b8a0-128fbad2fec0
author: jaimeo
---
# Release Notes: Important Issues in Windows Server 2012 R2
These release notes address the most critical issues and information about the Windows Server 2012 R2 operating system. For information about by\-design changes, new features, and fixes in this release, see documentation and announcements from the specific feature teams. For information about important steps to take before installing this release, including issues that you may need to work around, see “System Requirements and Installation Options for Windows Server 2012 R2.” Unless otherwise specified, these notes apply to all editions and installation options of Windows Server 2012 R2.  
  
This document is continuously updated; as critical issues requiring a workaround are discovered, they are added.  
  
## Setup with UEFI and 4K native drives  
If you boot a computer in UEFI mode from the Windows Server 2012 R2 installation DVD and then attempt to install Windows Server 2012 R2 onto a drive that uses the 4K logical sector size \(“4K native”\), you will receive the following error: “We couldn't create a new partition.”  
  
To avoid this, create the needed partition using Diskpart.exe instead of allowing Setup.exe to do it. When the installation wizard gets to the **Where do you want to install Windows?** page, press SHIFT\+F10 to open a command prompt. Use DiskPart to create the partition, and then return to the installation wizard to continue installation. For information about using Diskpart.exe for this, see [Sample: Configure UEFI\/GPT\-Based Hard Drive Partitions by Using Windows PE and DiskPart](http://technet.microsoft.com/library/hh825686.aspx)  
  
If this has already occurred, follow these steps:  
  
1.  On the **Where do you want to install Windows?** page of the wizard, select a partition created by Setup and then click **Delete**. Repeat for any other partitions also created by Setup.  
  
2.  Click **New** to create a new installation partition, and then continue with installation.  
  
For additional information about 4K sector drives, including steps to determine if your drive is of this type, see [Microsoft support policy for 4K sector hard drives in Windows](http://support.microsoft.com/kb/2510009)  
  
## Setup on virtual machines  
If you create a virtual machine with the minimum supported hardware parameters \(1 processor core and 512 MB RAM\) and then attempt to install this release on the virtual machine, Setup will fail.  
  
To avoid this, do one of the following:  
  
-   Allocate more than 800 MB RAM to the virtual machine you intend to install this release on. Once Setup has completed, you can change the allocation to as little as 512 MB RAM, depending on the actual server configuration.  
  
-   Interrupt the boot process of this release on the virtual machine with SHIFT\+F10. In the command prompt that opens, use Diskpart.exe to create and format an installation partition. Run **Wpeutil createpagefile \/path\=C:\\pf.sys** \(assuming the installation partition you created was C:\). Close the command prompt and proceed with Setup.  
  
## Add\/Remove Features wizard  
In two screens, the wizard refers to Windows Server 2012; the text should read “Windows Server 2012 and Windows Server 2012 R2.” There is no impact to functionality.  
  
## Internet Explorer 11  
  
-   Input Method Editor \(IME\) input does not accept non\-Latin characters with Adobe Flash in Internet Explorer. Only Latin characters can be inserted with an IME. To avoid this, use Internet Explorer for desktop.  
  
-   If you visit a website that contains Adobe Flash Player\-based content, no PlayTo endpoints are listed in the Devices charm. There is no workaround at this time.  
  
-   When you pause Adobe Flash Player\-based content in Internet Explorer and switch to Internet Explorer for desktop, the content might not be visible when you return. To avoid this, do not pause content when switching to the desktop. If this has already occurred, try refreshing the web page.  
  
## Storage Spaces  
If you host a shared VHDX resource on Storage Spaces and then enable deduplication, virtual machines will not boot while the shared VHDX is attached. Do not enable deduplication on volumes that host shared VHDX resources.  
  
## Windows Server Essentials Experience  
These issues affect both Windows Server 2012 R2 Essentials and other editions of Windows Server 2012 R2 when the Essentials Experience is installed with Server Manager.  
  
-   The Windows Server Essentials Experience only works in a single\-domain environment that does not include a read\-only domain controller. There is no workaround at this time.  
  
-   If you install Windows Server Essentials as a virtual machine, and if your server is not connected to the network \(or the DHCP service is not available\) while running the Configure Windows Server Essentials wizard, Anywhere Access functionalities \(such as Remote Web Access, virtual private networking, and DirectAccess\) are blocked.  
  
    To avoid this, ensure that your server has a network connection when you install Windows Server Essentials as a virtual machine and run the Configure Windows Server Essentials Wizard. If this has already occurred, manually configure the DNS forwarder settings.  
  
-   If you enable NIC teaming and then run the Anywhere Access setup wizard, auto\-configuration of the router is skipped and you will receive a false “No internet connection” warning on the dashboard.  
  
    To correct this, manually configure the router to forward traffic on port 80\/443 to the address of the teamed network interface adapter. If the server is a domain controller and had the DNS server role installed, you should also ensure that DNS on the teamed NiC is set to \(‘127.0.0.1’,’::1’\) and that DNS forwarders are properly configured.  
  
## Work Folders  
The client and server must be running the same milestone release for Work Folders to function properly. For example, if the server is running this milestone release of Windows Server 2012 R2, the client must be running the same milestone release of Windows 8.1.  
  
## Copyright  
This document is provided “as\-is”. Information and views expressed in this document, including URL and other Internet Web site references, may change without notice.  
  
This document does not provide you with any legal rights to any intellectual property in any Microsoft product. You may copy and use this document for your internal, reference purposes.  
  
©2013 Microsoft Corporation. All rights reserved.  
  
Microsoft, Active Directory, Hyper\-V, MS\-DOS, Windows, Windows NT, Windows Server, and Windows Vista are either registered trademarks or trademarks of Microsoft Corporation in the United States and\/or other countries.  
  
This product contains graphics filter software; this software is based in part on the work of the Independent JPEG Group.  
  
All other trademarks are property of their respective owners.  
  
4.0  
  
