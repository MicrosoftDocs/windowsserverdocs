---
title: What's new in Hyper-V on Windows Server 2016
description: "Gives a summary of the new features in Hyper-V"
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1a65a98e-54b6-4c41-9732-1e3d32fe3a5f
author: KBDAzure
ms.author: kathydav
ms.date: 09/21/2017
---
# What's new in Hyper-V on Windows Server

>Applies To: Windows Server 2019, Microsoft Hyper-V Server 2016, Windows Server 2016
  
This article explains the new and changed functionality of Hyper-V on Windows Server 2019, Windows Server 2016, and Microsoft Hyper-V Server 2016. To use new features on virtual machines created with Windows Server 2012 R2 and moved or imported to a server that runs Hyper-V on Windows Server 2019 or Windows Server 2016, you'll need to manually upgrade the virtual machine configuration version. For instructions, see [Upgrade virtual machine version](deploy/Upgrade-virtual-machine-version-in-Hyper-V-on-Windows-or-Windows-Server.md).  
  
Here's what's included in this article and whether the functionality is new or updated.  

## Windows Server, version 1903

### Add Hyper-V Manager to Server Core installations (updated)

As you might know, we recommend using the Server Core installation option when using Windows Server, Semi-Annual Channel in production. However, Server Core by default omits a number of useful management tools. You can add many of the most commonly used tools by installing the App Compatibility feature, but there have still been some missing tools.

So, based on customer feedback, we added one more tools to the App Compatibility feature in this version: Hyper-V Manager (virtmgmt.msc).

For more info, see [Server Core app compatibility feature](../../get-started-19/install-fod-19.md).

## Windows Server 2019

### Security: Shielded Virtual Machines improvements (new)

- **Branch office improvements**

    You can now run shielded virtual machines on machines with intermittent connectivity to the Host Guardian Service by leveraging the new [fallback HGS](https://docs.microsoft.com/windows-server/security/guarded-fabric-shielded-vm/guarded-fabric-manage-branch-office#fallback-configuration) and [offline mode](https://docs.microsoft.com/windows-server/security/guarded-fabric-shielded-vm/guarded-fabric-manage-branch-office#offline-mode) features. Fallback HGS allows you to configure a second set of URLs for Hyper-V to try if it can't reach your primary HGS server.

    Offline mode allows you to continue to start up your shielded VMs, even if HGS can't be reached, as long as the VM has started successfully once, and the host's security configuration has not changed.

- **Troubleshooting improvements**

    We've also made it easier to [troubleshoot your shielded virtual machines](https://docs.microsoft.com/windows-server/security/guarded-fabric-shielded-vm/guarded-fabric-troubleshoot-shielded-vms) by enabling support for VMConnect Enhanced Session Mode and PowerShell Direct. These tools are particularly useful if you've lost network connectivity to your VM and need to update its configuration to restore access.

    These features do not need to be configured, and they become available automatically when a shielded VM is placed on a Hyper-V host running Windows Server version 1803 or later.

- **Linux support**

    If you run mixed-OS environments, Windows Server 2019 now supports running Ubuntu, Red Hat Enterprise Linux, and SUSE Linux Enterprise Server inside shielded virtual machines.

## Windows Server 2016

### Compatible with Connected Standby \(new\)

When the Hyper-V role is installed on a computer that uses the Always On/Always Connected (AOAC) power model, the **Connected Standby** power state is now available.  
  
### Discrete device assignment \(new\)

This feature lets you give a virtual machine direct and exclusive access to some PCIe hardware devices. Using a device in this way bypasses the Hyper-V virtualization stack, which results in faster access. For details on supported hardware, see  "Discrete device assignment" in [System requirements for Hyper-V on Windows Server 2016](System-requirements-for-Hyper-V-on-Windows.md). For details, including how to use this feature and considerations, see the post "[Discrete Device Assignment — Description and background](https://blogs.technet.microsoft.com/virtualization/2015/11/19/discrete-device-assignment-description-and-background/)" in the Virtualization blog.

### Encryption support for the operating system disk in generation 1 virtual machines \(new)

You can now protect the operating system disk using BitLocker drive encryption in generation 1 virtual machines. A new feature, key storage, creates a small, dedicated drive to store the system drive's BitLocker key. This is done instead of using a virtual Trusted Platform Module (TPM), which is available only in generation 2 virtual machines. To decrypt the disk and start the virtual machine, the Hyper-V host must either be part of an authorized guarded fabric or have the private key from one of the virtual machine's guardians. Key storage requires a version 8 virtual machine. For information on virtual machine version, see [Upgrade virtual machine version in Hyper-V on Windows 10 or Windows Server 2016](./deploy/upgrade-virtual-machine-version-in-hyper-v-on-windows-or-windows-server.md).  
  
### Host resource protection \(new\)

This feature helps prevent a virtual machine from using more than its share of system resources by looking for excessive levels of activity. This can help prevent a virtual machine's excessive activity from degrading the performance of the host or other virtual machines. When monitoring detects a virtual machine with excessive activity, the virtual machine is given fewer resources. This monitoring and enforcement is off by default. Use Windows PowerShell to turn it on or off. To turn it on, run this command:  
  
```
Set-VMProcessor TestVM -EnableHostResourceProtection $true
```

For details about this cmdlet, see [Set-VMProcessor](https://docs.microsoft.com/powershell/module/hyper-v/set-vmprocessor).

### Hot add and remove for network adapters and memory \(new\)

You can now add or remove a network adapter while the virtual machine is running, without incurring downtime. This works for generation 2 virtual machines that run either Windows or Linux operating systems.  
  
You can also adjust the amount of memory assigned to a virtual machine while it's running, even if you haven't enabled Dynamic Memory. This works for both generation 1 and generation 2 virtual machines, running Windows Server 2016 or Windows 10.  

### Hyper-V Manager improvements \(updated\) 
  
-   **Alternate credentials support** - You can now use a different set of credentials in Hyper-V Manager when you connect to another Windows Server 2016 or Windows 10 remote host. You can also save these credentials to make it easier to log on again.  
  
-   **Manage earlier versions** - With Hyper-V Manager in Windows Server 2019, Windows Server 2016, and Windows 10, you can manage computers running Hyper-V on Windows Server 2012, Windows 8, Windows Server 2012 R2 and Windows 8.1.  
  
-   **Updated management protocol** - Hyper-V Manager now communicates with remote Hyper-V hosts using the WS-MAN protocol, which permits CredSSP, Kerberos or NTLM authentication. When you use CredSSP to connect to a remote Hyper-V host, you can do a live migration without enabling constrained delegation in Active Directory. The WS-MAN-based infrastructure also makes it easier to enable a host for remote management. WS-MAN connects over port 80, which is open by default.  
  
### Integration services delivered through Windows Update \(updated\) 

Updates to integration services for Windows guests are distributed through Windows Update. For service providers and private cloud hosters, this puts the control of applying updates into the hands of the tenants who own the virtual machines. Tenants can now update their Windows virtual machines with all updates, including the integration services, using a single method. For details about integration services for Linux guests, see [Linux and FreeBSD Virtual Machines on Hyper-V](Supported-Linux-and-FreeBSD-virtual-machines-for-Hyper-V-on-Windows.md).  
  
> [!IMPORTANT]  
> The vmguest.iso image file is no longer needed, so it isn't included with Hyper-V on Windows Server 2016.  
  
### Linux Secure Boot \(new\) 

Linux operating systems running on generation 2 virtual machines can now boot with the Secure Boot option enabled. Ubuntu 14.04 and later, SUSE Linux Enterprise Server 12 and later, Red Hat Enterprise Linux 7.0 and later, and CentOS 7.0 and later are enabled for Secure Boot on hosts that run Windows Server 2016. Before you boot the virtual machine for the first time, you must configure the virtual machine to use the Microsoft UEFI Certificate Authority. You can do this from Hyper-V Manager, Virtual Machine Manager, or an elevated Windows Powershell session. For Windows PowerShell, run this command:  
  
```  
Set-VMFirmware TestVM -SecureBootTemplate MicrosoftUEFICertificateAuthority  
```  
  
For more information about Linux virtual machines on Hyper-V, see [Linux and FreeBSD Virtual Machines on Hyper-V](Supported-Linux-and-FreeBSD-virtual-machines-for-Hyper-V-on-Windows.md). For more information about the cmdlet, see [Set-VMFirmware](https://docs.microsoft.com/powershell/module/hyper-v/set-vmfirmware).

### More memory and processors for generation 2 virtual machines and Hyper-V hosts \(updated\)

Starting with version 8, generation 2 virtual machines can use significantly more memory and virtual processors. Hosts also can be configured with significantly more memory and virtual processors than were previously supported. These changes support new scenarios such as running e-commerce large in-memory databases for online transaction processing (OLTP) and data warehousing (DW). The Windows Server blog recently published the performance results of  a virtual machine with 5.5 terabytes of memory and 128 virtual processors running 4 TB in-memory database. Performance was greater than 95% of the performance of a physical server. For details, see [Windows Server 2016 Hyper-V large-scale VM performance for in-memory transaction processing](https://blogs.technet.microsoft.com/windowsserver/2016/09/28/windows-server-2016-hyper-v-large-scale-vm-performance-for-in-memory-transaction-processing/). For details about virtual machine versions, see [Upgrade virtual machine version in Hyper-V on Windows 10 or Windows Server 2016](./deploy/Upgrade-virtual-machine-version-in-Hyper-V-on-Windows-or-Windows-Server.md). For the full list of supported maximum configurations, see [Plan for Hyper-V scalability in Windows Server 2016](./plan/plan-hyper-v-scalability-in-windows-server.md). 

### Nested virtualization \(new\)

This feature lets you use a virtual machine as a Hyper-V host and create virtual machines within that virtualized host. This can be especially useful for development and test environments. To use nested virtualization, you'll need:  
  
-   To run at least Windows Server 2019, Windows Server 2016 or Windows 10 on both the physical Hyper-V host and the virtualized host.  
  
-   A processor with Intel VT-x (nested virtualization is available only for Intel processors at this time).  
  
For details and instructions, see [Run Hyper-V in a Virtual Machine with Nested Virtualization](https://docs.microsoft.com/virtualization/hyper-v-on-windows/user-guide/nested-virtualization).  
  
### Networking features \(new\)

New networking features include:  
  
-   **Remote direct memory access (RDMA) and switch embedded teaming (SET)**. You can set up RDMA on network adapters bound to a Hyper-V virtual switch, regardless of whether SET is also used. SET provides a virtual switch with some of same capabilities as NIC teaming. For details, see [Remote Direct Memory Access (RDMA) and Switch Embedded Teaming (SET)](https://docs.microsoft.com/windows-server/virtualization/hyper-v-virtual-switch/rdma-and-switch-embedded-teaming).  
  
-   **Virtual machine multi queues (VMMQ)**. Improves on VMQ throughput by allocating multiple hardware queues per virtual machine.  The default queue becomes a set of queues for a virtual machine, and traffic is spread between the queues.  
  
-   **Quality of service (QoS) for software-defined networks**. Manages the default class of traffic through the virtual switch within the default class bandwidth.  
  
For more about new networking features, see [What's new in Networking](../../networking/What-s-New-in-Networking.md).  
  
### Production checkpoints \(new\)

Production checkpoints are "point-in-time" images of a virtual machine. These give you a way to apply a checkpoint that complies with support policies when a virtual machine runs a production workload. Production checkpoints are based on backup technology inside the guest instead of a saved state. For Windows virtual machines, the Volume Snapshot Service (VSS) is used. For Linux virtual machines, the file system buffers are flushed to create a checkpoint that's consistent with the file system. If you'd rather use checkpoints based on saved states, choose standard checkpoints instead. For details, see [Choose between standard or production checkpoints in Hyper-V](manage/Choose-between-standard-or-production-checkpoints-in-Hyper-V.md).  
  
> [!IMPORTANT]  
> New virtual machines use production checkpoints as the default.  
  
### Rolling Hyper-V Cluster upgrade \(new\)

You can now add a node running Windows Server 2019 or Windows Server 2016 to a Hyper-V Cluster with nodes running Windows Server 2012 R2. This allows you to upgrade the cluster without downtime. The cluster runs at a  Windows Server 2012 R2  feature level until you upgrade all nodes in the cluster and update the cluster functional level with the Windows PowerShell cmdlet, [Update-ClusterFunctionalLevel](https://docs.microsoft.com/powershell/module/failoverclusters/Update-ClusterFunctionalLevel).  
  
> [!IMPORTANT]  
> After you update the cluster functional level, you can't return it to Windows Server 2012 R2.  
  
For a Hyper-V cluster with a functional level of Windows Server 2012 R2 with nodes running Windows Server 2012 R2, Windows Server 2019 and Windows Server 2016, note the following:  
  
-   Manage the cluster, Hyper-V, and virtual machines from a node running Windows Server 2016 or Windows 10.  
  
-   You can move virtual machines between all of the nodes in the Hyper-V cluster.  
  
-   To use new Hyper-V features, all nodes must run Windows Server 2016 or and the cluster functional level must be updated.  
  
-   The virtual machine configuration version for existing virtual machines isn't upgraded. You can upgrade the configuration version only after you upgrade the cluster functional level.  
  
-   Virtual machines that you create are compatible with Windows Server 2012 R2, virtual machine configuration level 5.  
  
After you update the cluster functional level:  
  
-   You can enable new Hyper-V features.  
  
-   To make new virtual machine features available, use the Update-VmConfigurationVersion cmdlet to manually update the virtual machine configuration level. For instructions, see [Upgrade virtual machine version](deploy/Upgrade-virtual-machine-version-in-Hyper-V-on-Windows-or-Windows-Server.md).    
-   You can't add a node to the Hyper-V Cluster that runs Windows Server 2012 R2.  
  
> [!NOTE]  
> Hyper-V on Windows 10 doesn't support failover clustering.  
  
For details and instructions, see the [Cluster Operating System Rolling Upgrade](https://technet.microsoft.com/library/dn850430.aspx).  

### Shared virtual hard disks \(updated\)
You can now resize shared virtual hard disks (.vhdx files) used for guest clustering, without downtime. Shared virtual hard disks can be grown or shrunk while the virtual machine is online. Guest clusters can now also protect shared virtual hard disks by using Hyper-V Replica for disaster recovery.

Enable replication on the collection. Enabling replication on a collection is **only exposed through the WMI interface**. See the documentation for [Msvm_CollectionReplicationService class](https://msdn.microsoft.com/library/mt167787%28v=vs.85%29.aspx) for more details. **You cannot manage replication of a collection through PowerShell cmdlet or UI.** The VMs should be on hosts that are part of a Hyper-V cluster to access features that are specific to a collection. This includes Shared VHD - shared VHDs on stand-alone hosts are not supported by Hyper-V Replica.

Follow the guidelines for shared VHDs in [Virtual Hard Disk Sharing Overview](https://technet.microsoft.com/library/dn281956.aspx), and be sure that your shared VHDs are part of a guest cluster. 

A collection with a shared VHD but no associated guest cluster cannot create reference points for the collection (regardless of whether the shared VHD is included in the reference point creation or not). 

### Virtual machine backup\(new\)

If you are backing up a single virtual machine (regardless of whether host is clustered or not), you should not use a VM group.  Nor should you use a snapshot collection. VM groups and snapshot collection are meant to be used solely for backing up guest clusters that are using shared vhdx. Instead, you should take a snapshot using the [Hyper-V WMI v2 provider](https://msdn.microsoft.com/library/windows/desktop/hh850319(v=vs.85).aspx). Likewise, do not use the [Failover Cluster WMI provider](https://msdn.microsoft.com/library/windows/desktop/mt167750(v=vs.85).aspx).

### Shielded virtual machines \(new\)

Shielded virtual machines use several features to make it harder for Hyper-V administrators and malware on the host to inspect, tamper with, or steal data from the state of a shielded virtual machine. Data and state is encrypted, Hyper-V administrators can't see the video output and disks, and the virtual machines can be restricted to run only on known, healthy hosts, as determined by a Host Guardian Server. For details, see [Guarded Fabric and Shielded VMs](../../security/guarded-fabric-shielded-vm/guarded-fabric-and-shielded-vms.md).
  
> [!NOTE]  
> Shielded virtual machines are compatible with Hyper-V Replica. To replicate a shielded virtual machine, the host you want to replicate to must be authorized to run that shielded virtual machine.  

### Start order priority for clustered virtual machines \(new\)

This feature gives you more control over which clustered virtual machines are started or restarted first. This makes it easier to start virtual machines that provide services before virtual machines that use those services. Define sets, place virtual machines in sets, and specify dependencies. Use Windows PowerShell cmdlets to manage the sets, such as [New-ClusterGroupSet](https://docs.microsoft.com/powershell/module/failoverclusters/new-clustergroupset), [Get-ClusterGroupSet](https://docs.microsoft.com/powershell/module/failoverclusters/get-clustergroupset), and [Add-ClusterGroupSetDependency](https://docs.microsoft.com/powershell/module/failoverclusters/add-clustergroupsetdependency).
.  
### Storage quality of service (QoS) \(updated\)

You can now create storage QoS policies on a Scale-Out File Server and assign them to one or more virtual disks on Hyper-V virtual machines. Storage performance is automatically readjusted to meet policies as the storage load fluctuates. For details, see [Storage Quality of Service](../../storage/storage-qos/storage-qos-overview.md).  
  
### Virtual machine configuration file format \(updated\)

Virtual machine configuration files use a new format that makes reading and writing configuration data more efficient. The format also makes data corruption less likely if a storage failure occurs. Virtual machine configuration data files use a .vmcx file name extension and runtime state data files use a .vmrs file name extension.  
  
> [!IMPORTANT]  
> The .vmcx file name extension indicates a binary file. Editing .vmcx or .vmrs files isn't supported.  
  
### Virtual machine configuration version \(updated\)

The version represents the compatibility of the virtual machine's configuration, saved state, and snapshot files with the version of Hyper-V. Virtual machines with version 5 are compatible with Windows Server 2012 R2 and can run on both Windows Server 2012 R2 and Windows Server 2016. Virtual machines with versions introduced in Windows Server 2016 and Windows Server 2019 won't run in Hyper-V on Windows Server 2012 R2.   
  
If you move or import a virtual machine to a server that runs Hyper-V on Windows Server 2016 or Windows Server 2019 from Windows Server 2012 R2, the virtual machine's configuration isn't automatically updated. This means you can move the virtual machine back to a server that runs Windows Server 2012 R2. But, this also means you can't use the new virtual machine features until you manually update the version of the virtual machine configuration.  
  
For instructions on checking and upgrading the version, see [Upgrade virtual machine version](deploy/Upgrade-virtual-machine-version-in-Hyper-V-on-Windows-or-Windows-Server.md). This article also lists the version in which some features were introduced.   
  
> [!IMPORTANT]  
> -   After you update the  version, you can't move the virtual machine to a server that runs  Windows Server 2012 R2.  
> -   You can't downgrade the configuration to a previous version.  
> -   The [Update-VMVersion](https://docs.microsoft.com/powershell/module/hyper-v/update-vmversion) cmdlet  is blocked on a Hyper-V Cluster when the cluster functional level is  Windows Server 2012 R2.  

### Virtualization-based security for generation 2 virtual machines \(new)

Virtualization-based security powers features such as Device Guard and Credential Guard, offering increased protection of the operating system against exploits from malware. Virtualization based-security is available in generation 2 guest virtual machines starting with version 8. For information on virtual machine version, see [Upgrade virtual machine version in Hyper-V on Windows 10 or Windows Server 2016](./deploy/upgrade-virtual-machine-version-in-hyper-v-on-windows-or-windows-server.md).

### Windows Containers \(new\)

Windows Containers allow many isolated applications to run on one computer system. They're fast to build and are highly scalable and portable. Two types of container runtime are available, each with a different degree of application isolation. Windows Server Containers use namespace and process isolation. Hyper-V Containers use a light-weight virtual machine for each container.  
  
Key features include:  
  
-   Support for web sites and applications using HTTPS  
  
-   Nano server can host both Windows Server and Hyper-V Containers  
  
-   Ability to manage data through container shared folders  
  
-   Ability to restrict container resources  
  
For details, including quick start guides, see the [Windows Containers Documentation](https://docs.microsoft.com/virtualization/windowscontainers/index).  
  
### Windows PowerShell Direct \(new\)

This gives you a way to run Windows PowerShell commands in a virtual machine from the host. Windows PowerShell Direct runs between the host and the virtual machine. This  means it doesn't require networking or firewall requirements, and it works regardless of your remote management configuration.  
  
Windows PowerShell Direct is an alternative to the existing tools that Hyper-V administrators use to connect to a virtual machine on a Hyper-V host:  
  
-   Remote management tools such as PowerShell or Remote Desktop  
  
-   Hyper-V Virtual Machine Connection (VMConnect)  
  
Those tools work well, but have trade-offs: VMConnect is reliable, but can be hard to automate. Remote PowerShell is powerful, but can be hard to set up and maintain. These trade-offs may become more important as your Hyper-V deployment grows. Windows PowerShell Direct addresses this by providing a powerful scripting and automation experience that's as simple as using VMConnect.
  
For requirements and instructions, see [Manage Windows virtual machines with PowerShell Direct](manage/Manage-Windows-virtual-machines-with-PowerShell-Direct.md).  
