---
title: System Requirements and Installation Information for Windows Server 2012 R2
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5f4e3a1b-747a-47ba-b76c-04eac6502d1d
author: jaimeo
---
# System Requirements and Installation Information for Windows Server 2012 R2
This topic addresses the information you need to install [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)]. The process of moving to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] might vary greatly depending on which operating system you are starting with and the pathway you take. We use the following terms to distinguish among different actions, any of which could be involved in a new [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] deployment.  
  
-   **Installation** is the basic concept of getting the new operating system on your hardware. Specifically, a **clean installation** requires deleting the previous operating system.  
  
-   **Upgrade** means moving from your existing operating system to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], while staying on the same hardware. You can upgrade from an evaluation version of [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], a current retail version of certain editions of [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] \(an action known as “license conversion”\), a previous retail version of certain editions of Windows Server, or from a volume\-licensed edition of [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. Even while staying on the same hardware, some server roles might require specific steps to ensure a smooth upgrade. For detailed information about upgrading by any of these methods to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], see upgrade options  
  
-   **Migration** means moving from your existing operating system to [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] by transferring to a different set of hardware. Migration, which might vary considerably depending on the server roles you have installed, is discussed in detail at [http:\/\/technet.microsoft.com\/windowsserver\/dn458795](http://technet.microsoft.com/windowsserver/dn458795).  
  
|||  
|-|-|  
|![](b93f8edc-baa1-46ad-aed5-99c8690273c0)|Did you know that Microsoft Azure provides similar functionality in the cloud? Learn more about [Microsoft Azure virtualization solutions](http://aka.ms/f9bh7g).<br /><br />Create a hybrid virtualization solution in Microsoft Azure:<br />\- [Learn about running virtual machines in Microsoft Azure](http://aka.ms/fvq05g)<br />\- [Create and upload a Windows Server VHD to Azure](http://aka.ms/eqpd65)|  
  
## Clean installation  
Before you start a clean installation of [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], you should perform the following steps.  
  
1.  Review the system requirements  
  
2.  Review preinstallation documentation  
  
3.  Obtain the product  
  
4.  Perform preinstallation tasks  
  
## Review system requirements  
The following are estimated system requirements for the [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. If your computer has less than the "minimum" requirements, you will not be able to install this product correctly. Actual requirements will vary based on your system configuration and the applications and features you install.  
  
> [!IMPORTANT]  
> The highly diverse scope of potential deployments makes it unrealistic to state “recommended” system requirements that would be generally applicable. Consult documentation for each of the server roles you intend to deploy for more details about the resource needs of particular server roles. For the best results, conduct test deployments to determine appropriate system requirements for your particular deployment scenarios.  
  
## Processor  
Processor performance depends not only on the clock frequency of the processor, but also on the number of processor cores and the size of the processor cache. The following are the processor requirements for this product:  
  
-   **Minimum**: 1.4 GHz 64\-bit processor  
  
## RAM  
The following are the estimated RAM requirements for this product:  
  
-   **Minimum**: 512 MB  
  
> [!IMPORTANT]  
> If you create a virtual machine with the minimum supported hardware parameters \(1 processor core and 512 MB RAM\) and then attempt to install this release on the virtual machine, Setup will fail.  
>   
> To avoid this, do one of the following:  
>   
> -   Allocate more than 800 MB RAM to the virtual machine you intend to install this release on. Once Setup has completed, you can change the allocation to as little as 512 MB RAM, depending on the actual server configuration.  
> -   Interrupt the boot process of this release on the virtual machine with SHIFT\+F10. In the command prompt that opens, use Diskpart.exe to create and format an installation partition. Run **Wpeutil createpagefile \/path\=C:\\pf.sys** \(assuming the installation partition you created was C:\). Close the command prompt and proceed with Setup.  
  
## Disk space requirements  
The following are the estimated **minimum** disk space requirements for the system partition.  
  
-   **Minimum**: 32 GB  
  
    > [!NOTE]  
    > Be aware that 32 GB should be considered an absolute minimum value for successful installation. This minimum should allow you to install [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] in Server Core mode, with the Web Services \(IIS\) server role. A server in Server Core mode is about 4 GB smaller than the same server in Server with a GUI mode. For the smallest possible installation footprint, start with a Server Core installation and then completely remove any server roles or features you do not need by using Features on Demand. For more information about Server Core and Minimal Server Interface modes, see [Windows Server Installation Options](../Topic/Windows-Server-Installation-Options.md).  
    >   
    > The system partition will need extra space for any of the following circumstances:  
    >   
    > -   If you install the system over a network.  
    > -   Computers with more than 16 GB of RAM will require more disk space for paging, hibernation, and dump files.  
  
## Other requirements  
You also must have the following:  
  
-   Gigabit \(10\/100\/1000baseT\) Ethernet adapter  
  
-   DVD drive \(if you intend to install the operating system from DVD media\)  
  
The following items are not strictly required, but are necessary for certain features:  
  
-   Super VGA \(1024 x 768\) or higher\-resolution monitor  
  
-   Keyboard and Microsoft® mouse \(or other compatible pointing device\)  
  
-   Internet access \(fees may apply\)  
  
## Review preinstallation documentation  
To ensure that you are aware of any issues that might require workarounds, features that have been removed from the product, and features that have been added to the product, review these topics:  
  
-   [Features Removed or Deprecated in Windows Server 2012 R2](../Topic/Features-Removed-or-Deprecated-in-Windows-Server-2012-R2.md)  
  
-   [Release Notes: Important Issues in Windows Server 2012 R2](../Topic/Release-Notes--Important-Issues-in-Windows-Server-2012-R2.md)  
  
-   [What's New in Windows Server 2012 R2](http://technet.microsoft.com/library/dn250019.aspx)  
  
## Obtain the server product  
You can obtain evaluation versions of [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] \(convertible to retail versions\) in ISO or VHD format from the [TechNet Evaluation Center](http://technet.microsoft.com/evalcenter/dn205286.aspx?CR_CC=200142594).  
  
You can obtain evaluation versions \(convertible to retail versions\) in ISO or VHD format from the [TechNet Evaluation Center](http://technet.microsoft.com/evalcenter/dn205286.aspx?CR_CC=200142594). You can also buy retail versions from the [Microsoft Store](http://www.microsoftstore.com/store/msusa/en_US/home?tid=XhF02Wsw&cid=5250&pcrid=2817831418&pkw=microsoft%20store&pmt=e&WT.srch=1&WT.mc_id=pointitsem_Microsoft+US_bing_5+-+Microsoft&WT.term=microsoft%20store&WT.campaign=5+-+Microsoft&WT.content=XhF02Wsw&WT.source=bing&WT.medium=cpc).  
  
## Perform preinstallation tasks  
Before you install [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], follow the steps in this section to prepare for the installation.  
  
-   **Disconnect UPS devices.** If you have an uninterruptible power supply \(UPS\) connected to your destination computer, disconnect the serial cable before running Setup. Setup automatically attempts to detect devices that are connected to serial ports, and UPS equipment can cause issues with the detection process.  
  
-   **Back up your servers.** Your backup should include all data and configuration information that is necessary for the computer to function. It is important to perform a backup of configuration information for servers, especially those that provide network infrastructure, such as Dynamic Host Configuration Protocol \(DHCP\) servers. When you perform the backup, be sure to include the boot and system partitions and the system state data. Another way to back up configuration information is to create a backup set for Automated System Recovery.  
  
-   **Disable your virus protection software.** Virus protection software can interfere with installation. For example, it can make installation much slower by scanning every file that is copied locally to your computer.  
  
-   **Provide mass storage drivers.** If your manufacturer has supplied a separate driver file, save the file to a floppy disk, CD, DVD, or Universal Serial Bus \(USB\) flash drive in either the root directory of the media or the **amd64** folder. To provide the driver during Setup, on the disk selection page, click **Load Driver** \(or press F6\). You can browse to locate the driver or have Setup search the media.  
  
-   **Be aware that Windows Firewall is on by default.** Server applications that must receive unsolicited inbound connections will fail until you create inbound firewall rules to allow them. Check with your application vendor to determine which ports and protocols are necessary for the application to run correctly.  
  
    For more information about Windows Firewall, see [http:\/\/go.microsoft.com\/fwlink\/?LinkID\=84639](http://go.microsoft.com/fwlink/?LinkID=84639).  
  
## Evaluation versions of Windows Server 2012  
Evaluation versions are 64\-bit only and can be installed with the Server Core option or the Server with a GUI option. For more information about these installation options, how to convert between them, and how to use the Minimal Server Interface and Features on Demand, see [http:\/\/technet.microsoft.com\/\/library\/hh831786](http://technet.microsoft.com/library/hh831786).  
  
For all editions, you have 10 days to complete online activation, at which point the evaluation period begins and runs for 180 days. During the evaluation period, a notification on the Desktop displays the days remaining the evaluation period \(except in [!INCLUDE[sbs_sbs8web_2](../Token/sbs_sbs8web_2_md.md)]\). You can also run **slmgr.vbs \/dlv** from an elevated command prompt to see the time remaining.  
  
## Limits of evaluation versions  
All evaluation versions are fully functional during the evaluation period, although booting to Safe mode is not available. The [!INCLUDE[win8_server_standard_2](../Token/win8_server_standard_2_md.md)] and [!INCLUDE[win8_server_datacenter_2](../Token/win8_server_datacenter_2_md.md)] editions come with the activation key pre\-installed. After the 180\-day evaluation period elapses, the server warns you in various ways depending on the edition:  
  
[!INCLUDE[win8_server_standard_2](../Token/win8_server_standard_2_md.md)]; [!INCLUDE[win8_server_datacenter_2](../Token/win8_server_datacenter_2_md.md)]:  
  
-   The following warning appears on the Desktop: **Windows License is expired**  
  
-   When you log on to Windows, you are prompted with the following options:  
  
    -   Activate now  
  
    -   Ask me later  
  
-   The system shuts down every hour.  
  
-   The only updates that can be installed are security updates.  
  
-   Event ID 100 from source WLMS “The license period for this installation of Windows has expired. The operating system will shut down every hour.” appears in the Application log.  
  
[!INCLUDE[sbs_sbs8web_2](../Token/sbs_sbs8web_2_md.md)]: you receive warnings on the Desktop and on the dashboard, but the server does not shut down.  
  
## Installing versions distributed as VHDs  
In addition to the other distribution channels, [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] is also available as a pre\-configured virtual hard disk \(VHD\) file, which you can obtain from the TechNet Evaluation Center \([http:\/\/technet.microsoft.com\/evalcenter\/dn205286.aspx](http://technet.microsoft.com/evalcenter/dn205286.aspx)\). VHD files are available with [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] pre\-configured in either Server Core mode or Server with a GUI mode \(though you can switch modes after installation at will\). The resulting virtual machine has the following characteristics:  
  
-   English only  
  
-   2 GB RAM  
  
-   1 CPU  
  
-   80 GB hard drive  
  
To use the VHD distribution, you must have a computer running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], or [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. The Hyper\-V server role must be installed.  
  
#### To install the VHD  
  
1.  Download the VHD file to a convenient location. A common location is C:\\Users\\Public\\Documents\\Hyper\-V\\Virtual hard disks, but any location you prefer will work.  
  
2.  Start Hyper\-V Manager. On the **Action** menu, point to **New**, and then point to **Virtual Machine**.  
  
3.  Complete the New Virtual Machine wizard, and on the **Connect Virtual Hard Disk** page, choose **Attach a virtual hard disk later**.  
  
4.  After completing the New Virtual Machine wizard, check Hyper\-V Manager to verify that the virtual machine was successfully created.  
  
5.  Right\-click the new virtual machine and point to **Settings**. In the left pane, click **IDE Controller 0**. In the right pane, point to **Hard Drive**, and then **Add**. In the menu that opens, click **Virtual Hard Disk** and point to **Browse...**. Navigate to the location of the VHD you downloaded, select that file, and then click **OK**.  
  
6.  Configure the network adapter for the resulting virtual machine: right\-click the virtual machine and select **Settings**. In the left pane, click **Network Adapter**. In the menu that appears, select one of the network adapters of the virtualization server, and then click **OK**.  
  
7.  Start the virtual machine.  
  
## Copyright  
This document is provided “as\-is”. Information and views expressed in this document, including URL and other Internet Web site references, may change without notice.  
  
This document does not provide you with any legal rights to any intellectual property in any Microsoft product. You may copy and use this document for your internal, reference purposes.  
  
©2013 Microsoft Corporation. All rights reserved.  
  
Microsoft, Active Directory, Hyper\-V, MS\-DOS, Windows, Windows NT, Windows Server, and Windows Vista are either registered trademarks or trademarks of Microsoft Corporation in the United States and\/or other countries.  
  
This product contains graphics filter software; this software is based in part on the work of the Independent JPEG Group.  
  
All other trademarks are property of their respective owners.  
  
1.0  
  
