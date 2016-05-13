---
title: Integration Services
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b0aea34c-5bbf-4b8c-bca9-8195c490d251
---
# Integration Services
Hyper\-V integration services, are a bundled set of software which, when installed in the virtual machine improves integration between the host server and the virtual machine. Integration services come pre\-installed in most supported guest operating systems.

The following topics list the guest operating systems supported in virtual machines running in Hyper\-V on Windows Server 2012 and Windows Server 2012 R2 for use as guest operating systems:

-   [Supported Guest Operating Systems for Hyper\-V in Windows Server 2012 R2 and Windows 8.1](assetId:///0a3a974c-1714-47c8-88ca-8c1124dda369)

-   [Supported Guest Operating Systems for Hyper\-V in Windows Server 2012 and Windows 8](assetId:///91958199-798d-4ac5-a019-3ed95c0cd2b8)

-   For supported Linux distributions as a guest operating systems on Hyper\-V, see [Supported Linux and FreeBSD virtual machines for Hyper-V on Windows](Supported-Linux-and-FreeBSD-virtual-machines-for-Hyper-V-on-Windows.md).

> [!NOTE]
> -   You might need to update the integration services installed in your virtual machines after the release of hotfix, service pack or after a virtual machine has been moved to host running a newer version of Windows Server. For more information about how to upgrade the integration services, see [Install or upgrade integration services](assetId:///243b5705-96c9-4ec7-9ec5-c68a22b0d42d#BKMK_step4)
> -   For more information about updates and hotfixes for [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] that apply to Hyper\-V see, [Hyper\-V: Update List for Windows Server 2012](http://social.technet.microsoft.com/wiki/contents/articles/15576.hyper-v-update-list-for-windows-server-2012.aspx).
> -   For more information about updates and hotfixes for [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] that apply to Hyper\-V see, [Hyper\-V: Update List for Windows Server 2012 R2](http://social.technet.microsoft.com/wiki/contents/articles/20885.hyper-v-update-list-for-windows-server-2012-r2.aspx).

## Available Integration Services
After the integration services software package has been installed in the virtual machine, the following integration services can be presented to the virtual machine. The operating system running in the virtual machine must support the selected services.

The following is the list of the integration services that can be configure in the **Integration Services** settings page for each virtual machine. By default all of the services are enabled except for **Guest services**.

|Service name|Server settings|Guest operating system|
|----------------|-------------------|--------------------------|
|**Default virtual machine setting**|**Supported on Hyper\-V running on Windows Server version**|**Windows service name**|**Linux driver \/ daemon name**|
|[Operating system shutdown](Integration-Services.md#BKMK_Shutdown)|Enabled|[!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)]|**Hyper\-V Guest Shutdown Service**|hv\_utils|
|[Time synchronization](Integration-Services.md#BKMK_time)|Enabled|[!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)]|**Hyper\-V Time Synchronization Service**|hv\_utils|
|[Data Exchange](Integration-Services.md#BKMK_KVP)|Enabled|[!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)]|**Hyper\-V Data Exchange Service**|hv\_utils and hv\_kvp\_daemon|
|[Heartbeat](Integration-Services.md#BKMK_heartbeat)|Enabled|[!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)]|**Hyper\-V Heartbeat Service**|hv\_utils|
|[Backup \(volume snapshot\)](Integration-Services.md#BKMK_backup)|Enabled|[!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)]|**Hyper\-V Volume Shadow Copy Requestor**|hv\_utils and hv\_vss\_daemon|
|[Guest services](Integration-Services.md#BKMK_guest)|Not enabled|[!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)]|**Hyper\-V Guest Services Interface**|hv\_utils and hv\_fcopy\_daemon|

> [!TIP]
> On Linux virtual machines you can check to see if the integration services driver and daemons are running by running the following commands.
> 
> -   Run the following command in your Linux guest operating system to see if the hv\_utils driver is loaded.
> 
>     ```
>     lsmod|grep hv_utils
>     ```
> -   Run the following command in your Linux guest operating system to see if the required daemons are running.
> 
>     ```
>     ps –eaf|grep hv
>     ```

### <a name="BKMK_Shutdown"></a>Operating system shutdown
The operating system shutdown service provides a mechanism to shut down the operating system of a virtual machine from the management interfaces on the host or management computer. This allows the Hyper\-V administrator the ability to initiate an orderly shutdown of the virtual machines without having to log into the virtual machine. The virtual machine will attempt to close open processes and write to disk any data in memory before shutting down the virtual machine, in the same way if the administrator had selected **Shutdown** from within the virtual machine.

You can shutdown virtual machines from the Hyper\-V Manager console or via the Stop\-VM PowerShell cmdlet. For more information about Stop\-VM cmdlet, see [Stop\-VM](http://technet.microsoft.com/library/hh848468.aspx).

### <a name="BKMK_time"></a>Time synchronization
The time synchronization service provides the ability to synchronize your virtual machines’ time with the time from the host. Just as time is critical to physical servers it is critical to virtual machines.

For additional information about time synchronization and in what scenarios you should disable the service, see [Time Synchronization](assetId:///0e2f9415-8bdb-41b8-bf31-b836fced7fb5).

### <a name="BKMK_KVP"></a>Data Exchange
The data exchange service, also known as key\-value pairs \(KVP\), allows for the sharing of information between the host and virtual machine. General information about the virtual machine and host is automatically generated and stored in the registry for virtual machines running Windows and in files for virtual machines running Linux. Additionally there is a registry key and file where information can be created manually that can be shared between the host and the virtual machine. For example a service running in a virtual machine could write to this location when a specific event has occurred that requires the Hyper\-V administrator to perform a specific action.

Access to the data from the host is via WMI scripts only.

For additional information about data exchange, see [Data Exchange](assetId:///89610b1d-b297-4f8c-b8b9-652e2389d241)

### <a name="BKMK_heartbeat"></a>Heartbeat
The heartbeat service monitors the state of running virtual machines by reporting a heartbeat at regular intervals. This service helps you identify running virtual machines that might have stopped responding. You can check the heartbeat status of a virtual machine on the **Summary** tab of the **Virtual Machines** details page or you can use the Get\-VMIntegrationSerivce cmdlet. For additional information about the Get\-VMIntegrationService cmdlet, see [Get\-VMIntegrationService](http://technet.microsoft.com/library/hh848542.aspx).

### <a name="BKMK_backup"></a>Backup \(volume snapshot\)
The backup service enables consistent backup of the virtual machines from backup software running on the host.  The backup service allows for the virtual machine to be backed up while it is running without any interruption to the virtual machine or the services running in the virtual machine.

For more information about backing up your virtual machines, see [Considerations for backing up and restoring virtual machines](Considerations-for-backing-up-and-restoring-virtual-machines.md).

### <a name="BKMK_guest"></a>Guest services
The guest service allows the Hyper\-V administrator to copy files to a running virtual machine without using a network connection. Beforehand the only way to copy files to the virtual machine was for both the virtual machine and the host be connected to same network and then either use file services to copy file or to create a remote desktop session to the virtual machine and copy files via RDS session.

> [!IMPORTANT]
> The **Hyper\-V Guest Service Interface** service enters a running state when the **Guest services** service is selected on the **Integration Services**property page of the virtual machine.
> 
> To disable this feature in a virtual machine running Windows, set the **Hyper\-V Guest Service Interface**service startup type to **Disabled** inside the virtual machine.
> 
> To disable this feature in a virtual machine running Linux, stop and disable the hv\_fcopy\_daemon daemon. Consult your Linux distribution’s documentation for the steps to stop or disable a daemon process.

To copy a file to a virtual machine you need to use the Copy\-VMFile PowerShell cmdlet. For additional information about the Copy\-VMFile Windows PowerShell cmdlet, see [Copy\-VMFile](http://technet.microsoft.com/library/dn464282.aspx).


