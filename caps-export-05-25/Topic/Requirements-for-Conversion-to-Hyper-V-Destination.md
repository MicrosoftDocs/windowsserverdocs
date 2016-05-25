---
title: Requirements for Conversion to Hyper-V Destination
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 21b020b6-7e35-412c-ba1a-113014f9d4b9
author: cwatsonmsft
---
# Requirements for Conversion to Hyper-V Destination
MVMC successfully performs virtual machine conversions to Hyper\-V when the following conditions are met:  
  
-   The Windows user account that you are using has write access to the UNC path, which is specified on the destination Hyper\-V host for copying the virtual hard disks.  
  
-   The Hyper\-V host has the required disk space available for the converted virtual hard disks \(VHDs\).  
  
In addition, ensure that the following conditions are met for online virtual machine conversions for Windows and Linux virtual machines.  
  
## Windows virtual machines  
  
-   For conversions in an online state, ensure that you meet the following conditions on the source virtual machine:  
  
    -   Disable the Windows Firewall.  
  
    -   Enable **Remote Desktop Connection** to enable remote desktop connections.  
  
    -   Ensure that the latest version of VMware Tools are installed.  
  
-   If you only want to set the source virtual machine state to **ON** after conversion, the virtual machine must have VMware Tools installed.  
  
-   The virtual machine is joined to an Active Directory domain.  
  
-   Remote access through Windows Management Instrumentation \(WMI\) is enabled on the VMware\-based virtual machine to be converted and the destination Hyper\-V host. For more details, see the [Troubleshoot Microsoft Virtual Machine Converter](../Topic/Troubleshoot-Microsoft-Virtual-Machine-Converter.md) section in this guide.  
  
-   The account, which is used to connect to the VMware\-based virtual machine that has to be converted, is part of an Active Directory domain, and is also a local administrator on that virtual machine.  
  
## Linux virtual machines  
  
> [!IMPORTANT]  
> Linux Integration Services must be installed on Linux virtual machines for full functionality with Windows Hyper\-V and Microsoft Azure.  
>   
> For more information about the availability and applicability of Linux Integration Services, see [Linux and FreeBSD Virtual Machines on Hyper\-V](http://technet.microsoft.com/en-us/library/dn531030.aspx). For Linux distributions and versions with Linux Integration Services \(LIS\) “built in,” no further action is necessary. If the Linux distribution or version does not have Linux Integration Services built in, you must install LIS.  
  
-   The virtual machine has VMware Tools installed.  
  
-   MVMC uses Secure Shell \(SSH\) to connect to the online Linux virtual machine to uninstall the VMware Tools on the virtual machine. To enable SSH communication to the virtual machine, ensure that SSH is enabled and is prepared to accept input on TCP port 22.  
  
    > [!NOTE]  
    > Root credentials are required to directly uninstall the VMware Tools; su or sudo is not currently supported.  
  
> [!NOTE]  
> The following assumptions are valid after a successful conversion:  
>   
> -   The destination virtual machine is in a started or stopped state depending on the settings chosen by the user.  
> -   For online conversions, after the virtual disks that are attached to the virtual machine are copied successfully to the source machine on which MVMC is installed, the source virtual machine is restored to a started or stopped state, depending on the settings that were chosen by the user.  
> -   For offline conversions, the source virtual machine is always restored to a stopped state.  
> -   Product activation requires each instance of a Windows operating system installation to be activated as with any generic Windows operating system activation. This procedure applies to any Windows virtual machine that is created from a VHD. Because conversion creates a second instance of the virtual machine on Hyper\-V, this instance has to be activated.  
  
> [!IMPORTANT]  
> Managing Linux virtual machines in Microsoft Azure requires network and SSH connectivity to the virtual machine. In order to ensure that Linux virtual machines are accessible after migration from VMware to Microsoft Azure, perform the following recommended steps before migration:  
>   
> -   Ensure that you install Linux Integration Services \(LIS\) on the virtual machine – either built in or installed from RPM.  
> -   Verify that the Linux firewall allows SSH \(TCP port 22\) inbound traffic.  
> -   Remove the \/etc\/udev\/rules.d\/70\-persistent\-net.rules file, if it exists.  
>   
>     -   Remove or disable NetworkManager. To remove NetworkManager:  
>     -   rpm –e NetworkManager  
>   
>         \-or\-  
>     -   dpkg –r NetworkManager  
> -   Verify that the network adapter is configured to receive IP addresses from DHP:  
>   
>     -   Modify ifcfg\-eth or interfaces.  
>     -   Ensure the eth0 is set for auto start with DHCP.  
>     -   Remove any MAC address or ID specification for eth0 from the interface configuration file.  
> -   Read [Azure Linux Agent User Guide](http://azure.microsoft.com/documentation/articles/virtual-machines-linux-agent-user-guide/).  
  
