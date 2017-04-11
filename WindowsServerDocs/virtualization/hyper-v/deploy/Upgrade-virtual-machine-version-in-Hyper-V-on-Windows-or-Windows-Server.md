---
title: Upgrade virtual machine version in Hyper-V on Windows 10 or Windows Server 2016
description: "Gives instructions and considerations for upgrading the version of a virtual machine"
ms.prod: windows-server-threshold
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 897f2454-5aee-445c-a63e-f386f514a0f6
author: KBDAzure
ms.author: kathydav
ms.date: 10/03/2016
---
# Upgrade virtual machine version in Hyper-V on Windows 10 or Windows Server 2016

>Applies To: Windows 10, Windows Server 2016 

Make the latest Hyper-V features available on your virtual machines by upgrading the configuration version. Don't do this until:  
  
- You upgrade your Hyper-V hosts to the latest version of Windows or Windows Server.  
- You upgrade the cluster functional level.   
- You're sure that you won't need to move the virtual machine back to a Hyper-V host that runs a previous version of Windows or Windows Server.  
  
For more information, see [Cluster Operating System Rolling Upgrade ](../../failover-clustering/Cluster-Operating-System-Rolling-Upgrade.md) and [Upgrading Windows Server 2012 R2 clusters to Windows Server 2016 in VMM](https://technet.microsoft.com/library/mt445417.aspx).  
    
Step 1: Check the virtual machine configuration versions  
---  
1. On the Windows desktop, click the Start button and type any part of the name **Windows PowerShell**.  
2. Right-click Windows PowerShell and select **Run as Administrator**.  
3.  Use the [Get-VM ](https://technet.microsoft.com/library/hh848479.aspx)cmdlet. Run the following command to get the versions of your virtual machines.   
```  
Get-VM * | Format-Table Name, Version  
 ```  
You can also see the configuration version in Hyper-V Manager by selecting the virtual machine and looking at the **Summary** tab.  
  
  
Step 2: Upgrade the virtual machine configuration version  
---  
1.  Shut down the virtual machine in Hyper-V Manager.  
2.  Select Action > Upgrade Configuration Version. If this option isn't available for the virtual machine, then it's already at the highest configuration version supported by the Hyper-V host.   
  
To upgrade the virtual machine configuration version by using Windows PowerShell, use the [Update-VMVersion](https://technet.microsoft.com/library/mt484146.aspx) cmdlet. Run the following command where vmname is the name of the virtual machine.  
```  
Update-VMVersion <vmname>  
```  
<a name="BKMK_SupportedConfigVersions"></a>Supported virtual machine configuration versions  
---  
The following table shows which virtual machine configuration versions are supported by Hyper-V hosts that run on specific versions of Windows operating systems.  

|Hyper-V host Windows version|  Supported virtual machine configuration versions|  
|-|-|  
|Windows Server 2016 | 8.0, 7.1, 7.0, 6.2, 5.0| 
|Windows 10 Anniversary Update |8.0, 7.1, 7.0, 6.2, 5.0|
|Windows Server 2016 Technical Preview| 7.1, 7.0, 6.2, 5.0|  
|Windows 10 build 10565 or later|   7.0, 6.2, 5.0 |  
|Windows 10 builds earlier than 10565  |    6.2, 5.0 |  
|Windows Server 2012 R2 |  5.0|  
|Windows 8.1    |5.0|  
  
Run the PowerShell cmdlet [Get-VMHostSupportedVersion](https://technet.microsoft.com/library/mt653838.aspx) to see what virtual machine configuration versions your Hyper-V Host supports. When you create a virtual machine, it's created with the default configuration version. To see what the default is, run the following command.  
 ```  
Get-VMHostSupportedVersion -Default  
 ```  
 If you need to create a virtual machine that you can move to a Hyper-V Host that runs an older version of Windows, use the [New-VM](https://technet.microsoft.com/library/hh848537.aspx) cmdlet with the -version parameter. For example, to create a virtual machine that you can move to a Hyper-V host that runs  Windows Server 2012 R2 , run the following command. This command will create a virtual machine named "WindowsCV5" with a configuration version 5.0.  
  ```  
New-VM -Name "WindowsCV5" -Version 5.0  
 ```  
   
Why should I upgrade the virtual machine configuration version?  
---  
When you move or import a virtual machine to a computer that runs Hyper-V on Windows Server 2016 or Windows 10, the virtual machine"s configuration isn't automatically updated. This means that you can move the virtual machine back to a Hyper-V host that runs a previous version of Windows or Windows Server. But, this also means that you can't use some of the new virtual machine features until you manually update the configuration version. You can't downgrade the virtual machine configuration version after you've upgraded it.  
  
   
The virtual machine configuration version represents the compatibility of the virtual machine's configuration, saved state, and snapshot files with the version of Hyper-V. When you update the configuration version, you change the file structure that is used to store the virtual machines configuration and the checkpoint files. You also update the configuration version to the latest version supported by that Hyper-V host. Upgraded virtual machines use a new configuration file format, which is designed to increase the efficiency of reading and writing virtual machine configuration data. The upgrade also reduces the potential for data corruption in the event of a storage failure.  
   
The following table lists descriptions, file name extensions, and default locations for each type of file that's used for new or upgraded virtual machines.  
   
 |Virtual machine file types |  Description|  
 |-|-|  
|Configuration  |Virtual machine configuration information that is stored in binary file format.  <br> File name extension: .vmcx <br> Default location: C:\ProgramData\Microsoft\Windows\Hyper-V\Virtual Machines|  
  |Runtime state|Virtual machine runtime state information that is stored in binary file format. <br>File name extension: .vmrs <br>Default location: C:\ProgramData\Microsoft\Windows\Hyper-V\Virtual Machines|  
|Virtual hard disk|Stores virtual hard disks for the virtual machine.<br> File name extension: .vhd or .vhdx <br>Default location: C:\ProgramData\Microsoft\Windows\Hyper-V\Virtual Hard Disks|  
 |Automatic virtual hard disk |Differencing disk files used for virtual machine checkpoints.<br> File name extension: .avhdx <br> Default location: C:\ProgramData\Microsoft\Windows\Hyper-V\Virtual Hard Disks|  
 |Checkpoint|Checkpoints are stored in multiple checkpoint files. Each checkpoint creates a configuration file and runtime state file.<br> File name extensions: .vmrs and .vmcx <br>Default location: C:\ProgramData\Microsoft\Windows\Snapshots|   
  
  
What happens if I don't upgrade the virtual machine configuration version?  
---  
If you have virtual machines that you created with an earlier version of Hyper-V, some features may not work with those virtual machines until you update the configuration version.  
  
The following table shows the minimum virtual machine configuration version required to use new Hyper-V features.  

|Feature|Minimum VM configuration version|  
|-|-|  
|Hot Add/Remove Memory|6.2|  
|Secure Boot for Linux VMs|6.2|  
|Production Checkpoints|6.2|  
|PowerShell Direct |6.2|  
|Virtual Machine Grouping|6.2|  
|Virtual Trusted Platform Module (vTPM)|7.0|  
|Virtual machine multi queues (VMMQ)|7.1|  
|XSAVE support|8.0|
|Key storage drive|8.0|
|Guest Virtualization Based Security support (VBS)|8.0|
|Nested virtualization|8.0| 
|Virtual processor count|8.0|
|Large memory VMs|8.0|
  
For more information about these features, see [What's new in Hyper-V on Windows Server 2016](../What-s-new-in-Hyper-V-on-Windows.md).


