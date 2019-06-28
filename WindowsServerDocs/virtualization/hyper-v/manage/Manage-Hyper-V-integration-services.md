---
title: Manage Hyper-V Integration Services
description: "Describes how to turn integration services on and off and install them if needed"
ms.technology: compute-hyper-v
author: KBDAzure
ms.author: kathydav
manager: dongill
ms.date: 12/20/2016
ms.topic: article
ms.prod: windows-server-threshold
ms.service: na
ms.assetid: 9cafd6cb-dbbe-4b91-b26c-dee1c18fd8c2
---

>Applies To: Windows 10, Windows Server 2016, Windows Server 2019

# Manage Hyper-V Integration Services

Hyper-V Integration Services enhance virtual machine performance and provide convenience features by leveraging two-way communication with the Hyper-V host. Many of these services are conveniences, such as guest file copy, while others are important to the virtual machine's functionality, such as synthetic device drivers. This set of services and drivers are sometimes referred to as "integration components". You can control whether or not individual convenience services operate for any given virtual machine. The driver components are not intended to be serviced manually.

For details about each integration service, see [Hyper-V Integration Services](https://docs.microsoft.com/virtualization/hyper-v-on-windows/reference/integration-services).

> [!IMPORTANT]
> Each service you want to use must be enabled in both the host and guest in order to function. All integration services except "Hyper-V Guest Service Interface" are on by default on Windows guest operating systems. The services can be turned on and off individually. The next sections show you how.

## Turn an integration service on or off using Hyper-V Manager

1. From the center pane, right-click the virtual machine and click **Settings**.
  
2. From the left pane of the **Settings** window, under **Management**, click **Integration Services**.
  
The Integration Services pane lists all integration services available on the Hyper-V host, and whether the host has enabled the virtual machine to use them.

### Turn an integration service on or off using PowerShell

To do this in PowerShell, use [Enable-VMIntegrationService](https://technet.microsoft.com/library/hh848500.aspx) and [Disable-VMIntegrationService](https://technet.microsoft.com/library/hh848488.aspx).

The following examples demonstrate turning the guest file copy integration service on and off for a virtual machine named "demovm".

1. Get a list of running integration services:
  
    ``` PowerShell
    Get-VMIntegrationService -VMName "DemoVM"
    ```

1. The output should look like this:

    ``` PowerShell
   VMName      Name                    Enabled PrimaryStatusDescription SecondaryStatusDescription
   ------      ----                    ------- ------------------------ --------------------------
   DemoVM      Guest Service Interface False   OK
   DemoVM      Heartbeat               True    OK                       OK
   DemoVM      Key-Value Pair Exchange True    OK
   DemoVM      Shutdown                True    OK
   DemoVM      Time Synchronization    True    OK
   DemoVM      VSS                     True    OK
   ```

1. Turn on Guest Service Interface:

   ``` PowerShell
   Enable-VMIntegrationService -VMName "DemoVM" -Name "Guest Service Interface"
   ```

1. Verify that Guest Service Interface is enabled:

   ```
   Get-VMIntegrationService -VMName "DemoVM" 
   ``` 

1. Turn off Guest Service Interface:

    ```
    Disable-VMIntegrationService -VMName "DemoVM" -Name "Guest Service Interface"
    ```
   
## Checking the guest's integration services version
Some features may not work correctly or at all if the guest's integration services are not current. To get the version information for a Windows, log on to the guest operating system, open a command prompt, and run this command:

```
REG QUERY "HKLM\Software\Microsoft\Virtual Machine\Auto" /v IntegrationServicesVersion
```

Earlier guest operating systems will not have all available services. For example, Windows Server 2008 R2 guests cannot have the "Hyper-V Guest Service Interface".

## Start and stop an integration service from a Windows Guest
In order for an integration service to be fully functional, its corresponding service must be running within the guest in addition to being enabled on the host. In Windows guests, each integration service is listed as a standard Windows service. You can use the Services applet in Control Panel or PowerShell to stop and start these services.

> [!IMPORTANT]
> Stopping an integration service may severely affect the host's ability to manage your virtual machine. To work correctly, each integration service you want to use must be enabled on both the host and guest.
> As a best practice, you should only control integration services from Hyper-V using the instructions above. The matching service in the guest operating system will stop or start automatically when you change its status in Hyper-V.
> If you start a service in the guest operating system but it is disabled in Hyper-V, the service will stop. If you stop a service in the guest operating system that is enabled in Hyper-V, Hyper-V will eventually start it again. If you disable the service in the guest, Hyper-V will be unable to start it.

### Use Windows Services to start or stop an integration service within a Windows guest

1. Open Services manager by running ```services.msc``` as an Administrator or by double-clicking the Services icon in Control Panel.

    ![Screen shot that shows the Windows Services pane](media/HVServices.png) 

1. Find the services that start with "Hyper-V". 

1. Right-click the service you want start or stop. Click the desired action.

### Use Windows PowerShell to start or stop an integration service within a Windows guest

1. To get a list of integration services, run:

    ```
    Get-Service -Name vm*
    ```

1.  The output should look similar to this:

    ```PowerShell
    Status   Name               DisplayName
    ------   ----               -----------
    Running  vmicguestinterface Hyper-V Guest Service Interface
    Running  vmicheartbeat      Hyper-V Heartbeat Service
    Running  vmickvpexchange    Hyper-V Data Exchange Service
    Running  vmicrdv            Hyper-V Remote Desktop Virtualizati...
    Running  vmicshutdown       Hyper-V Guest Shutdown Service
    Running  vmictimesync       Hyper-V Time Synchronization Service
    Stopped  vmicvmsession      Hyper-V VM Session Service
    Running  vmicvss            Hyper-V Volume Shadow Copy Requestor
    ```

1. Run either [Start-Service](https://technet.microsoft.com/library/hh849825.aspx) or [Stop-Service](https://technet.microsoft.com/library/hh849790.aspx). For example, to turn off Windows PowerShell Direct, run:

    ```
    Stop-Service -Name vmicvmsession
    ```

## Start and stop an integration service from a Linux guest 

Linux integration services are generally provided through the Linux kernel. The Linux integration services driver is named **hv_utils**.

1. To find out if **hv_utils** is loaded, use this command:

   ``` BASH
   lsmod | grep hv_utils
   ``` 
  
2. The output should look similar to this:  
  
    ``` BASH
    Module                  Size   Used by
    hv_utils               20480   0
    hv_vmbus               61440   8 hv_balloon,hyperv_keyboard,hv_netvsc,hid_hyperv,hv_utils,hyperv_fb,hv_storvsc
    ```

3. To find out if the required daemons are running, use this command.
  
    ``` BASH
    ps -ef | grep hv
    ```
  
4. The output should look similar to this: 
  
    ```BASH
    root       236     2  0 Jul11 ?        00:00:00 [hv_vmbus_con]
    root       237     2  0 Jul11 ?        00:00:00 [hv_vmbus_ctl]
    ...
    root       252     2  0 Jul11 ?        00:00:00 [hv_vmbus_ctl]
    root      1286     1  0 Jul11 ?        00:01:11 /usr/lib/linux-tools/3.13.0-32-generic/hv_kvp_daemon
    root      9333     1  0 Oct12 ?        00:00:00 /usr/lib/linux-tools/3.13.0-32-generic/hv_kvp_daemon
    root      9365     1  0 Oct12 ?        00:00:00 /usr/lib/linux-tools/3.13.0-32-generic/hv_vss_daemon
    scooley  43774 43755  0 21:20 pts/0    00:00:00 grep --color=auto hv          
    ```

5. To see what daemons are available, run:

    ``` BASH
    compgen -c hv_
    ```
  
6. The output should look similar to this:
  
    ``` BASH
    hv_vss_daemon
    hv_get_dhcp_info
    hv_get_dns_info
    hv_set_ifconfig
    hv_kvp_daemon
    hv_fcopy_daemon     
    ```
  
   Integration service daemons that might be listed include the following. If any are missing, they might not be supported on your system or they might not be installed. Find details, see [Supported Linux and FreeBSD virtual machines for Hyper-V on Windows](https://technet.microsoft.com/library/dn531030.aspx).  
   - **hv_vss_daemon**: This daemon is required to create live Linux virtual machine backups.
   - **hv_kvp_daemon**: This daemon allows setting and querying intrinsic and extrinsic key value pairs.
   - **hv_fcopy_daemon**: This daemon implements a file copying service between the host and guest.  

### Examples

These examples demonstrate stopping and starting the KVP daemon, named `hv_kvp_daemon`.

1. Use the process ID \(PID\) to stop the daemon's process. To find the PID, look at the second column of the output, or use `pidof`. Hyper-V daemons run as root, so you'll need root permissions.

    ``` BASH
    sudo kill -15 `pidof hv_kvp_daemon`
    ```

1. To verify that all `hv_kvp_daemon` process are gone, run:

    ```
    ps -ef | hv
    ```

1. To start the daemon again, run the daemon as root:

    ``` BASH
    sudo hv_kvp_daemon
    ``` 

1. To verify that the `hv_kvp_daemon` process is listed with a new process ID, run:

    ```
    ps -ef | hv
    ```

## Keep integration services up to date

We recommend that you keep integration services up to date to get the best performance and most recent features for your virtual machines. This happens for most Windows guests by default if they are set up to get important updates from Windows Update. Linux guests using current kernels will receive the latest integration components when you update the kernel.

**For virtual machines running on Windows 10 hosts:**

> [!NOTE]
> The image file vmguest.iso isn't included with Hyper-V on Windows 10 because it's no longer needed.

| Guest  | Update mechanism | Notes |
|:---------|:---------|:---------|
| Windows 10 | Windows Update | |
| Windows 8.1 | Windows Update | |
| Windows 8 | Windows Update | Requires the Data Exchange integration service.* |
| Windows 7 | Windows Update | Requires the Data Exchange integration service.* |
| Windows Vista (SP 2) | Windows Update | Requires the Data Exchange integration service.* |
| - | | |
| Windows Server 2016 | Windows Update | |
| Windows Server, Semi-Annual Channel | Windows Update | |
| Windows Server 2012 R2 | Windows Update | |
| Windows Server 2012 | Windows Update | Requires the Data Exchange integration service.* |
| Windows Server 2008 R2 (SP 1) | Windows Update | Requires the Data Exchange integration service.* |
| Windows Server 2008 (SP 2) | Windows Update | Extended support only in Windows Server 2016 ([read more](https://support.microsoft.com/lifecycle?p1=12925)). |
| Windows Home Server 2011 | Windows Update | Will not be supported in Windows Server 2016 ([read more](https://support.microsoft.com/lifecycle?p1=15820)). |
| Windows Small Business Server 2011 | Windows Update | Not under mainstream support ([read more](https://support.microsoft.com/lifecycle?p1=15817)). |
| - | | |
| Linux guests | package manager | Integration services for Linux are built into the distro but there may be optional updates available. ******** |

\* If the Data Exchange integration service can't be enabled, the integration services for these guests are available from the [Download Center](https://support.microsoft.com/kb/3071740) as a cabinet (cab) file. Instructions for applying a cab are available in this [blog post](https://blogs.technet.com/b/virtualization/archive/2015/07/24/integration-components-available-for-virtual-machines-not-connected-to-windows-update.aspx).

**For virtual machines running on Windows 8.1 hosts:**

| Guest  | Update mechanism | Notes |
|:---------|:---------|:---------|
| Windows 10 | Windows Update | |
| Windows 8.1 | Windows Update | |
| Windows 8 | Integration Services disk | See [instructions](#install-or-update-integration-services), below. |
| Windows 7 | Integration Services disk | See [instructions](#install-or-update-integration-services), below. |
| Windows Vista (SP 2) | Integration Services disk | See [instructions](#install-or-update-integration-services), below. |
| Windows XP (SP 2, SP 3) | Integration Services disk | See [instructions](#install-or-update-integration-services), below. |
| - | | |
| Windows Server 2016 | Windows Update | |
| Windows Server, Semi-Annual Channel | Windows Update | |
| Windows Server 2012 R2 | Windows Update | |
| Windows Server 2012 | Integration Services disk | See [instructions](#install-or-update-integration-services), below. |
| Windows Server 2008 R2 | Integration Services disk | See [instructions](#install-or-update-integration-services), below. |
| Windows Server 2008 (SP 2) | Integration Services disk | See [instructions](#install-or-update-integration-services), below. |
| Windows Home Server 2011 | Integration Services disk | See [instructions](#install-or-update-integration-services), below. |
| Windows Small Business Server 2011 | Integration Services disk | See [instructions](#install-or-update-integration-services), below. |
| Windows Server 2003 R2 (SP 2) | Integration Services disk | See [instructions](#install-or-update-integration-services), below. |
| Windows Server 2003 (SP 2) | Integration Services disk | See [instructions](#install-or-update-integration-services), below. |
| - | | |
| Linux guests | package manager | Integration services for Linux are built into the distro but there may be optional updates available. ** |


**For virtual machines running on Windows 8 hosts:**

| Guest  | Update mechanism | Notes |
|:---------|:---------|:---------|
| Windows 8.1 | Windows Update | |
| Windows 8 | Integration Services disk | See [instructions](#install-or-update-integration-services), below. |
| Windows 7 | Integration Services disk | See [instructions](#install-or-update-integration-services), below. |
| Windows Vista (SP 2) | Integration Services disk | See [instructions](#install-or-update-integration-services), below. |
| Windows XP (SP 2, SP 3) | Integration Services disk | See [instructions](#install-or-update-integration-services), below. |
| - | | |
| Windows Server 2012 R2 | Windows Update | |
| Windows Server 2012 | Integration Services disk | See [instructions](#install-or-update-integration-services), below. |
| Windows Server 2008 R2 | Integration Services disk | See [instructions](#install-or-update-integration-services), below.|
| Windows Server 2008 (SP 2) | Integration Services disk | See [instructions](#install-or-update-integration-services), below. |
| Windows Home Server 2011 | Integration Services disk | See [instructions](#install-or-update-integration-services), below. |
| Windows Small Business Server 2011 | Integration Services disk | See [instructions](#install-or-update-integration-services), below. |
| Windows Server 2003 R2 (SP 2) | Integration Services disk | See [instructions](#install-or-update-integration-services), below. |
| Windows Server 2003 (SP 2) | Integration Services disk | See [instructions](#install-or-update-integration-services), below. |
| - | | |
| Linux guests | package manager | Integration services for Linux are built into the distro but there may be optional updates available. ** |

For more details about Linux guests, see [Supported Linux and FreeBSD virtual machines for Hyper-V on Windows](https://technet.microsoft.com/windows-server-docs/virtualization/hyper-v/supported-linux-and-freebsd-virtual-machines-for-hyper-v-on-windows).

## Install or update integration services

For hosts earlier than Windows Server 2016 and Windows 10, you'll need to manually install or update the integration services in the guest operating systems. 
  
1.  Open Hyper-V Manager. From the Tools menu of Server Manager, click **Hyper-V Manager**.  
  
2.  Connect to the virtual machine. Right-click the virtual machine and click **Connect**.  
  
3.  From the Action menu of Virtual Machine Connection, click **Insert Integration Services Setup Disk**. This action loads the setup disk in the virtual DVD drive. Depending on the guest operating system, you might need to start the installation manually.  
  
4.  After the installation finishes, all integration services are available for use.

These steps can't be automated or done within a Windows PowerShell session for online virtual machines. You can apply them to offline VHDX images; [see this blog post](https://blogs.technet.microsoft.com/virtualization/2013/04/18/how-to-install-integration-services-when-the-virtual-machine-is-not-running/).
