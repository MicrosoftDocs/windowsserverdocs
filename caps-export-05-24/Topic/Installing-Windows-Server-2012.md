---
title: Installing Windows Server 2012
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ddf71ebb-fc52-4ecb-aa88-109167c5f1c8
author: jaimeo
---
# Installing Windows Server 2012
This document provides information about installing the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] operating system, including any known issues that you may need to work around before starting an installation. It also provides information that you can use to troubleshoot problems that may occur during the installation. For information about serious known issues that you may need to work around after installation is complete, see the release notes, available at the same location as this document.  
  
Setup works in several stages. You will be prompted for some basic information, and then Setup will copy files and restart the computer. Setup concludes by presenting a menu for Initial Configuration Tasks, which you can use to configure your server for your specific needs.  
  
## Preinstallation information  
  
### <a name="BKMK_sysreq"></a>System requirements  
The following are estimated system requirements for the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. If your computer has less than the "minimum" requirements, you will not be able to install this product correctly. Actual requirements will vary based on your system configuration and the applications and features you install.  
  
#### Processor  
Processor performance depends not only on the clock frequency of the processor, but also on the number of processor cores and the size of the processor cache. The following are the processor requirements for this product:  
  
-   **Minimum**: 1.4 GHz 64\-bit processor  
  
#### RAM  
The following are the estimated RAM requirements for this product:  
  
-   **Minimum**: 512 MB  
  
#### Disk space requirements  
The following are the estimated **minimum** disk space requirements for the system partition.  
  
-   **Minimum**: 32 GB  
  
    > [!NOTE]  
    > Be aware that 32 GB should be considered an absolute minimum value for successful installation. The system partition will need extra space for any of the following circumstances:  
    >   
    > -   If you install the system over a network.  
    > -   Computers with more than 16 GB of RAM will require more disk space for paging, hibernation, and dump files.  
  
### Other requirements  
You also need to have the following:  
  
-   DVD drive  
  
-   Super VGA \(800 x 600\) or higher\-resolution monitor  
  
-   Keyboard and Microsoft® mouse \(or other compatible pointing device\)  
  
-   Internet access \(fees may apply\)  
  
### Important information for x64\-based operating systems  
**Ensure that you have updated and digitally signed kernel\-mode drivers for Windows Server 2012**  
  
If you install a Plug and Play device, you may receive a warning if the driver is not digitally signed. If you install an application that contains a driver that is not digitally signed, you will not receive an error during Setup. In both cases, [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] will not load the unsigned driver.  
  
If you are not sure whether the driver is digitally signed, or if you are unable to boot into your computer after the installation, use the following procedure to disable the driver signature requirement. This procedure enables your computer to start correctly, and the unsigned driver will load successfully.  
  
**To disable the signature requirement for the current boot process:**  
  
1.  Restart the computer and during startup, press F8.  
  
2.  Select **Advanced Boot Options**.  
  
3.  Select **Disable Driver Signature Enforcement**.  
  
4.  Boot into Windows® and uninstall the unsigned driver.  
  
For more information, see [http:\/\/go.microsoft.com\/fwlink\/?LinkId\=66577](http://go.microsoft.com/fwlink/?LinkId=66577).  
  
## Before you start Setup  
Before you install [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], follow the steps in this section to prepare for the installation.  
  
-   **Disconnect UPS devices.** If you have an uninterruptible power supply \(UPS\) connected to your destination computer, disconnect the serial cable before running Setup. Setup automatically attempts to detect devices that are connected to serial ports, and UPS equipment can cause issues with the detection process.  
  
-   **Back up your servers.** Your backup should include all data and configuration information that is necessary for the computer to function. It is important to perform a backup of configuration information for servers, especially those that provide network infrastructure, such as Dynamic Host Configuration Protocol \(DHCP\) servers. When you perform the backup, be sure to include the boot and system partitions and the system state data. Another way to back up configuration information is to create a backup set for Automated System Recovery.  
  
-   **Disable your virus protection software.** Virus protection software can interfere with installation. For example, it can make installation much slower by scanning every file that is copied locally to your computer.  
  
-   **Provide mass storage drivers.** If your manufacturer has supplied a separate driver file, save the file to a floppy disk, CD, DVD, or Universal Serial Bus \(USB\) flash drive in either the root directory of the media or the **amd64** folder. To provide the driver during Setup, on the disk selection page, click **Load Driver** \(or press F6\). You can browse to locate the driver or have Setup search the media.  
  
-   **Be aware that Windows Firewall is on by default.** Server applications that must receive unsolicited inbound connections will fail until you create inbound firewall rules to allow them. Check with your application vendor to determine which ports and protocols are necessary for the application to run correctly.  
  
    For more information about Windows Firewall, see [http:\/\/go.microsoft.com\/fwlink\/?LinkID\=84639](http://go.microsoft.com/fwlink/?LinkID=84639).  
  
## Supported upgrade paths  
The table below briefly summarizes supported upgrade paths to [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. For more details on upgrade paths, important caveats to upgrade, and additional information about evaluation versions, see [http:\/\/go.microsoft.com\/fwlink\/?LinkId\=260917](http://go.microsoft.com/fwlink/?LinkId=260917).  
  
If you do not see your current version in the left column, upgrading to this release of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] is not supported.  
  
If you see more than one edition in the right column, upgrade to either edition from the same starting version is supported.  
  
|||  
|-|-|  
|If you are running:|You can upgrade to these editions:|  
|Windows Server 2008 Standard with SP2 or Windows Server 2008 Enterprise with SP2|[!INCLUDE[win8_server_standard_2](../Token/win8_server_standard_2_md.md)], [!INCLUDE[win8_server_datacenter_2](../Token/win8_server_datacenter_2_md.md)]|  
|Windows Server 2008 Datacenter with SP2|[!INCLUDE[win8_server_datacenter_2](../Token/win8_server_datacenter_2_md.md)]|  
|Windows Web Server 2008|[!INCLUDE[win8_server_standard_2](../Token/win8_server_standard_2_md.md)]|  
|[!INCLUDE[nextref_server_7std](../Token/nextref_server_7std_md.md)] with SP1 or [!INCLUDE[nextref_server_7ent](../Token/nextref_server_7ent_md.md)] with SP1|[!INCLUDE[win8_server_standard_2](../Token/win8_server_standard_2_md.md)], [!INCLUDE[win8_server_datacenter_2](../Token/win8_server_datacenter_2_md.md)]|  
|[!INCLUDE[nextref_server_7dat](../Token/nextref_server_7dat_md.md)] with SP1|[!INCLUDE[win8_server_datacenter_2](../Token/win8_server_datacenter_2_md.md)]|  
|[!INCLUDE[nextref_server_7web](../Token/nextref_server_7web_md.md)]|[!INCLUDE[win8_server_standard_2](../Token/win8_server_standard_2_md.md)]|  
  
## Copyright  
This document is provided “as\-is”. Information and views expressed in this document, including URL and other Internet Web site references, may change without notice.  
  
This document does not provide you with any legal rights to any intellectual property in any Microsoft product. You may copy and use this document for your internal, reference purposes.  
  
©2012 Microsoft Corporation. All rights reserved.  
  
Microsoft, Active Directory, Hyper\-V, MS\-DOS, Windows, Windows NT, Windows Server, and Windows Vista are either registered trademarks or trademarks of Microsoft Corporation in the United States and\/or other countries.  
  
This product contains graphics filter software; this software is based in part on the work of the Independent JPEG Group.  
  
All other trademarks are property of their respective owners.  
  
2.0  
  
