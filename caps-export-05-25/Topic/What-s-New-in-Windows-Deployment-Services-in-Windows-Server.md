---
title: What&#39;s New in Windows Deployment Services in Windows Server
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5673f31f-7e42-40c9-b2c3-154b1f0f0793
---
# What&#39;s New in Windows Deployment Services in Windows Server
This topic describes the Windows Deployment Services \(WDS\) functionality that is new or changed in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and Windows Server 2012.  
  
WDS is a server role that enables you to remotely deploy Windows operating systems. You can use it to set up new computers by using a network\-based installation. This means that you do not have to install each operating system directly from a CD, USB drive, or DVD. To use WDS, you should have a working knowledge of common desktop deployment technologies and networking components, including Dynamic Host Configuration Protocol \(DHCP\), Domain Name System \(DNS\), and Active Directory Domain Services \(AD DS\). It is also helpful to understand the Preboot eXecution Environment \(also known as Pre\-Execution Environment\).  
  
**In this topic:**  
  
-   [What’s new in Windows Deployment Services in Windows Server 2012 R2](../Topic/What-s-New-in-Windows-Deployment-Services-in-Windows-Server.md#BKMK_WDS2012R2)  
  
-   [What’s new in Windows Deployment Services in Windows Server 2012](../Topic/What-s-New-in-Windows-Deployment-Services-in-Windows-Server.md#BKMK_WDS2012)  
  
## <a name="BKMK_WDS2012R2"></a>What’s new in Windows Deployment Services in Windows Server 2012 R2  
The following table compares the features and functionality included in each version of Windows Deployment Services, up to and including Windows Server 2012 R2:  
  
|Feature|Windows Server 2003|[!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]|[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|  
|-----------|-----------------------|-----------------------------------------------------------------|-----------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------|  
|Operating systems deployed|Legacy mode: Windows 2000, Windows XP, Windows Server 2003<br /><br />Mixed mode: Windows 2000, Windows XP, Windows Server 2003, [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)], [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]<br /><br />Native mode: Windows 2000 Professional, Windows XP, Windows Server 2003, [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)], [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]|Windows 2000<br /><br />Windows Server 2003<br /><br />[!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]<br /><br />[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]<br /><br />Windows XP<br /><br />[!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)]<br /><br />[!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)]|Windows Server 2003<br /><br />[!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]<br /><br />[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]<br /><br />[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]<br /><br />[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]<br /><br />Windows XP<br /><br />[!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)] SP1<br /><br />[!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)]<br /><br />[!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)]<br /><br />[!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)]|Windows Server 2003<br /><br />[!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]<br /><br />[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]<br /><br />[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]<br /><br />[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]<br /><br />Windows XP<br /><br />[!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)] SP1<br /><br />[!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)]<br /><br />[!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)]<br /><br />[!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)]|  
|Image types deployed|Legacy mode: RISETUP and RIPREP<br /><br />Mixed mode: RISETUP, RIPREP, .wim<br /><br />Native mode: .wim|For a new installation, only .wim images are supported.<br /><br />If you upgrade from Windows Server 2003, you can convert any RIPREP images to .wim format after the upgrade. However, RISETUP images are not supported.|.wim<br /><br />.vhd images of [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] are supported as part of an unattended installation \(managed by using the command line only\). **Note:** .vhd images are only used for booting from VHD scenarios, and they are not applied directly to volumes.|.wim and .vhd images are both supported similar to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].<br /><br />.vhd images can now be managed via the WDS management snap\-in in addition to the command\-line.<br /><br />In addition, .vhdx files \(a new file format available in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]\) are supported directly and over multicast.<br /><br />The .vhdx format supports a sparse, dynamic representation of a disk, which produces a relatively small disk image file \(compared to directly storing the full contents of the disk\). The .vhdx format is supported for VDH boot scenarios in addition to direct application to system volumes \(similar to .wim deployments\).|  
|Boot environment|Legacy mode: OSChooser<br /><br />Mixed mode: OSChooser and Windows Preinstallation Environment \(Windows PE\)<br /><br />Native mode: Windows PE|Windows PE|Windows PE|Windows PE|  
|Administration experience|Legacy mode: Remote Installation Services \(RIS\) toolset<br /><br />Mixed mode: RIS toolset to manage RISETUP and RIPREP images. Microsoft Management Console \(MMC\) snap\-in and WDSUTIL to manage .wim images.<br /><br />Native mode: MMC snap\-in and WDSUTIL|MMC snap\-in and WDSUTIL|MMC snap\-in and WDSUTIL|MMC snap\-in and WDSUTIL. Windows PowerShell cmdlets added in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].|  
|Multicasting|Not supported.|Supported for install images. \(The Boot.wim file must be from the DVD for Windows Server 2003, [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)] with SP1, [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)], or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].\)|Supported for install images. \(The Boot.wim file must be from the DVD for [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)] with SP1, [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)], or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].\)<br /><br />Supported for boot images for computers with EFI \(managed by using the command line only\).<br /><br />Provides the ability to automatically disconnect slow clients and divide transmissions into multiple streams based on client speeds \(the boot image must be [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]\).<br /><br />Provides support for multicasting in environments that use IPv6 \(the boot image must be from [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)] with SP1, [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)], or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]\).|Provides support for TFTP and multicasting over IPv6 and DHCPv6.<br /><br />Improved multicast deployment by eliminating the need for making a local copy of the install.wim file. You can apply the install.wim file while it is being downloaded without significant impact to the application process.<br /><br />Applying the install.wim file concurrently with the multicast download decreases overall deployment time, offers higher disk write throughput, and requires less space on the client system.<br /><br />Reduced default block size fits within an Ethernet MTU and works on customer hardware that does not support IP fragmentation.|  
|Driver provisioning|Not supported.|Not supported.|Provides the ability to deploy driver packages to client computers based on their hardware as part of an installation \(the install image must be [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)] with SP1, [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)], or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]\).<br /><br />Provides the ability to add driver packages to boot images \([!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] images only\).|Extends filters for driver groups to support manufacturer Model Number and **Device Groups**. Driver import automatically detects and prevents duplicate driver packages from being added to the driver store.|  
|Extensibility|Supports custom PXE providers.|Supports custom PXE providers.<br /><br />Supports transmitting data and images by using multicasting on a stand\-alone server \(Transport Server\). However, you must develop a way to boot clients.<br /><br />Supports custom multicast providers.|Supports custom PXE providers.<br /><br />Supports transmitting data and images by using multicasting on a stand\-alone server \(Transport Server\).<br /><br />Includes a PXE provider to boot clients.<br /><br />Supports custom multicast providers.|Supports custom PXE providers.<br /><br />Supports transmitting data and images by using multicasting on a stand\-alone server \(Transport Server\). Includes a PXE provider to boot clients.<br /><br />Supports custom multicast providers.|  
|Extensible Firmware Interface \(EFI\)|Supports network booting of Itanium\-based computers with EFI.|Supports network booting of Itanium\-based and x64\-based computers with EFI\/UEFI.|Supports network booting of x64\-based computers with UEFI.<br /><br />Includes Auto\-add functionality.<br /><br />Includes DHCP referral to direct clients to a specific PXE server.<br /><br />Provides the ability to deploy boot images by using multicasting.|Support x86 clients \(32\-bit processors\) with Unified Extensible Firmware Interface \(UEFI\) to network boot and complete an end\-to\-end deployment by using WDS.|  
|PowerShell cmdlet scripting|Not supported|Not supported|Not supported|Supported on [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] only<br /><br />A WDS server running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] can be managed by using the Windows PowerShell cmdlets for WDS. By using Windows PowerShell cmdlets, you can add driver packages, add client images, enable and disable boot and install images, and perform many other common WDS tasks. For a full reference, see [Windows Deployment Services in Windows PowerShell](http://technet.microsoft.com/library/dn283416.aspx).|  
  
## <a name="BKMK_WDS2012"></a>What’s new in Windows Deployment Services in Windows Server 2012  
In Windows Server 2012, WDS offers enhanced support in the following areas:  
  
-   [ARM architecture and support](../Topic/What-s-New-in-Windows-Deployment-Services-in-Windows-Server.md#BKMK_ARM)  
  
-   [WDS infrastructure for custom deployments](../Topic/What-s-New-in-Windows-Deployment-Services-in-Windows-Server.md#BKMK_WDS)  
  
-   [WDS management console](../Topic/What-s-New-in-Windows-Deployment-Services-in-Windows-Server.md#BKMK_WDSMC)  
  
-   [WDSclient.exe](../Topic/What-s-New-in-Windows-Deployment-Services-in-Windows-Server.md#BKMK_WDSclient)  
  
-   [Standalone server mode](../Topic/What-s-New-in-Windows-Deployment-Services-in-Windows-Server.md#BKMK_Standalone)  
  
-   [Default domain policies](../Topic/What-s-New-in-Windows-Deployment-Services-in-Windows-Server.md#BKMK_DDP)  
  
-   [Expected Deployment Results Wizard](../Topic/What-s-New-in-Windows-Deployment-Services-in-Windows-Server.md#BKMK_Wizard)  
  
-   [Trivial File Transfer Protocol](../Topic/What-s-New-in-Windows-Deployment-Services-in-Windows-Server.md#BKMK_TFTP)  
  
-   [Troubleshooting](../Topic/What-s-New-in-Windows-Deployment-Services-in-Windows-Server.md#BKMK_Troubleshooting)  
  
-   [Boot image and install image priorities](../Topic/What-s-New-in-Windows-Deployment-Services-in-Windows-Server.md#BKMK_BootImage)  
  
### <a name="BKMK_ARM"></a>ARM architecture and support  
WDS can now deploy images to ARM clients, which is a CPU architecture that is specially engineered for low\-cost, low\-power consumption devices such as tablets, cell phones, GPS units, portable game consoles, network routers, and media players.  
  
**What value does this change add?**  
  
The ability to deploy images to ARM clients in addition to x86 and x64 architectures means a broader range of devices will be capable of running Windows.  
  
**What works differently?**  
  
-   Provides support for Windows on ARM machines as deployment clients.  
  
-   Provides support for all existing deployment features on Windows on ARM clients, most notably multicast.  
  
> [!NOTE]  
> PXE boot is not currently supported by the network drivers on ARM clients.  
  
### <a name="BKMK_WDS"></a>WDS infrastructure for custom deployments  
**What value does this change add?**  
  
New features that offer the ability to control all aspects of the deployment process.  
  
**What works differently?**  
  
The improvements include a variety of configuration options that allow administrators to more tightly control the deployment payload \(such as images and driver packages\) that is sent to client computers. These improvements include the following:  
  
-   Install image filters, which are similar to the set of driver group filters.  
  
-   Support for boot and install image priority to influence the ordering of these images as they appear in Boot Manager and WDS client image selection menus.  
  
-   The Expected Deployment Results Wizard, which allows administrators to view deployment information such as the set of matching driver groups that would be sent to a prestaged device.  
  
-   Ability to control which clients are able to boot from the PXE server.  
  
-   Control over the boot parameters of PXE clients including boot program, prompt policy, and boot.wim instance.  
  
-   Ability to control the WIM and VHD images that are deployed to the client.  
  
-   More control over the drivers that are deployed to the client.  
  
-   Control over the unattend file\(s\) that are used to customize the setup experience for the client.  
  
-   Lower\-level WDSUTIL commands that allow administrators to set custom metadata tags and values on deployment payload and prestaged devices that get matched to directly influence the deployment process.  
  
### <a name="BKMK_WDSMC"></a>WDS management console  
**What value does this change add?**  
  
Extensions to the management console provide users with more convenient features to configure deployment options for their client computers.  
  
**What works differently?**  
  
The following set of features were added:  
  
-   **Create Client Unattend** dialog to make it easy for administrators to author client unattend files.  
  
-   Approve Pending Device Wizard, which simplifies and extends the functionality of the previous approve option.  
  
-   Built\-in support for prestaged devices that supersede the **Remote Install** tab of the **Active Directory Users & Computers** snap\-in.  
  
### <a name="BKMK_WDSclient"></a>WDSclient.exe  
**What value does this change add?**  
  
WDSclient.exe is a new standalone client that can perform Dynamic Driver Provisioning \(DDP\) queries, direct VHD application, and metadata queries.  
  
**What works differently?**  
  
The WDSclient tool supports the above functionality for use in custom deployment scripts.  
  
### <a name="BKMK_Standalone"></a>Standalone server mode  
**What value does this change add?**  
  
Standalone server mode removes the dependency on Active Directory.  
  
**What works differently?**  
  
Starting in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], Windows Deployment Services can be installed in a Standalone server mode. This removes the dependency on Active Directory.  You still require DHCP, DNS and sufficient permissions to install and configure Windows Deployment Services. In this scenario, a local store is used to retain information about pre\-staged devices.  
  
### <a name="BKMK_DDP"></a>Default domain policies  
**What value does this change add?**  
  
Default domain policy enhancements provide more control over provisioning drivers to client computers.  
  
**What works differently?**  
  
Default domain policy enhancements include:  
  
-   Support for hardware model.  
  
-   Support for image IDs and custom device groups.  
  
-   Duplicate driver package avoidance to prevent the same package from being added multiple times to the driver store.  
  
### <a name="BKMK_Wizard"></a>Expected Deployment Results Wizard  
**What value does this change add?**  
  
The Expected Deployment Results Wizard enables administrators to model the process of deploying a computer and seeing what boot images, install images, driver groups the computer will be offered from the server.  
  
**What works differently?**  
  
Expected Deployment Results Wizard is designed to help administrators efficiently test configuration changes to their servers and see how they impact deployments to all or specific \(prestaged\) computers. The tool is especially valuable when used to test some of the advanced configuration options afforded by the WDS infrastructure for custom deployments.  
  
### <a name="BKMK_TFTP"></a>Trivial File Transfer Protocol  
**What value does this change add?**  
  
Trivial File Transfer Protocol \(TFTP\) enhancements result in improved performance.  
  
**What works differently?**  
  
TFTP \(Trivial File Transfer Protocol\) has been enhanced and delivers improved results in performance.  
  
You use the Windows Deployment Services Trivial File Transfer Protocol \(TFTP\) server to download the files that are needed to do a network boot using the Pre\-Boot Execution Environment \(PXE\). PXE technology is a standard created by Intel that establishes a common and consistent set of pre\-boot services within the boot firmware. The end goal is to enable a client to do a network boot and receive a network boot program \(NBP\) from a network boot server.  
  
TFTP enhancements include:  
  
-   **Scalable buffer management** Provides support for a shared client buffer; allows buffering an entire file instead of a fixed size buffer for each client. Scalable TFTP buffer feature allows maintaining a single buffer per file in the server. When the server is buffering a file in shared mode, different sessions can read from the same shared buffer.  
  
-   **Scalable port management** Ability to use a dynamic or a fixed range of UDP ports to service clients with shared UDP port allocation. Sharing the same server port among different TFTP sessions improves scalability because there are sufficient ports when more clients are actively using the server.  
  
-   **Variable\-size transmission window** Allows the client and server to determine the largest workable window size, resulting in improved TFTP performance. Provides the ability to dynamically determine the optimal window size.  
  
-   **Maximum TFTP block size** Previously implemented as a registry setting, this is now exposed to users through WDSUTIL and the WDS MMC snap\-in.  
  
### <a name="BKMK_Troubleshooting"></a>Troubleshooting  
**What value does this change add?**  
  
Expanded tracing for troubleshooting issues with minimal impact to system performance.  
  
**What works differently?**  
  
Tracing has moved from plain text files to ETW logging, which enables efficient logging that works well even when diagnosing potential race conditions.  
  
### <a name="BKMK_BootImage"></a>Boot image and install image priorities  
**What value does this change add?**  
  
When you have multiple boot or install images available to client computers, clients will be presented with a boot and an install menu that displays the selection of images to choose from.  
  
**What works differently?**  
  
Windows Deployment Services now allows you to set priorities to control the order that both boot and install image listings are presented to clients.  This ability is integrated directly into the Windows Deployment Services user interface.  
  
## See also  
  
-   [Windows Deployment Services Overview](../Topic/Windows-Deployment-Services-Overview.md)  
  
-   [What's New in Windows Deployment Services in Windows Server 2008 R2](http://technet.microsoft.com/library/dd735188(v=ws.10).aspx)  
  
-   [Windows Deployment Services: What's New in Windows Server 2008 R2, Windows Server 2008, and Windows Server 2003](http://technet.microsoft.com/library/dd348499(v=ws.10).aspx)  
  
