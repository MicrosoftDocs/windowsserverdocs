---
title: Storage Quality of Service
ms.prod: windows-server
manager: dongill
ms.author: JGerend
ms.technology: storage-qos
ms.topic: get-started-article
ms.assetid: 8dcb8cf9-0e08-4fdd-9d7e-ec577ce8d8a0
author: kumudd
ms.date: 10/10/2016
---
# Storage Quality of Service

> Applies to: Windows Server 2019, Windows Server 2016, Windows Server (Semi-Annual Channel)

Storage Quality of Service (QoS) in Windows Server 2016 provides a way to centrally monitor and manage storage performance for virtual machines using Hyper-V and the Scale-Out File Server roles. The feature automatically improves storage resource fairness between multiple virtual machines using the same file server cluster and allows policy-based minimum and maximum performance goals to be configured in units of normalized IOPs.  

You can use Storage QoS in Windows Server 2016 to accomplish the following:  

-   **Mitigate noisy neighbor issues.** By default, Storage QoS ensures that a single virtual machine cannot consume all storage resources and starve other virtual machines of storage bandwidth.  

-   **Monitor end to end storage performance.** As soon as virtual machines stored on a Scale-Out File Server are started, their performance is monitored. Performance details of all running virtual machines and the configuration of the Scale-Out File Server cluster can be viewed from a single location  

-   **Manage Storage I/O per workload business needs** Storage QoS policies define performance minimums and maximums for virtual machines and ensures that they are met. This provides consistent performance to virtual machines, even in dense and overprovisioned environments. If policies cannot be met, alerts are available to track when VMs are out of policy or have invalid policies assigned.  

This document outlines how your business can benefit from the new Storage QoS functionality. It assumes that you have a previous working knowledge of Windows Server, Windows Server Failover Clustering, Scale-Out File Server, Hyper-V, and Windows PowerShell.

## <a name="BKMK_Overview"></a>Overview  
This section describes the requirements for using Storage QoS, an overview of a software-defined solution using Storage QoS, and a list of Storage QoS related terminologies.  

### <a name="BKMK_Requirements"></a>Storage QoS Requirements  
Storage QoS supports two deployment scenarios:  

-   **Hyper-V using a Scale-Out File Server** This scenario requires both of the following:  

    -   Storage cluster that is a Scale-Out File Server cluster  

    -   Compute cluster that has least one server with the Hyper-V role enabled  

    For Storage QoS, the Failover Cluster is required on Storage servers, but the compute servers are not required to be in a failover cluster. All servers (used for both Storage and Compute) must be running Windows Server 2016.  

    If you do not have a Scale-Out File Server cluster deployed for evaluation purposes, for step by step instructions to build one using either existing servers or virtual machines, see [Windows Server 2012 R2 Storage: Step-by-step with Storage Spaces, SMB Scale-Out and Shared VHDX (Physical)](https://blogs.technet.com/b/josebda/archive/2013/07/31/windows-server-2012-r2-storage-step-by-step-with-storage-spaces-smb-scale-out-and-shared-vhdx-physical.aspx).  

-   **Hyper-V using Cluster Shared Volumes.** This scenario requires both of the following:  

    -   Compute cluster with the Hyper-V role enabled  

    -   Hyper-V using Cluster Shared Volumes (CSV) for storage  

Failover Cluster is required. All servers must be running the same version of Windows Server 2016.  

### <a name="BKMK_SolutionOverview"></a>Using Storage QoS in a software-defined storage solution  
Storage Quality of Service is built into the Microsoft software-defined storage solution provided by Scale-Out File Server and Hyper-V. The Scale-Out File Server exposes file shares to the Hyper-V servers using the SMB3 protocol. A new Policy Manager has been added to the File Server cluster, which provides the central storage performance monitoring.  

![Scale-Out File Server and Storage QoS](media/overview-Clustering_SOFSStorageQoS.png)  

**Figure 1: Using Storage QoS in a software-defined storage solution in Scale-Out File Server**  

As Hyper-V servers launch virtual machines, they are monitored by the Policy Manager. The Policy Manager communicates the Storage QoS policy and any limits or reservations back to the Hyper-V server, which controls the performance of the virtual machine as appropriate.  

When there are changes to Storage QoS policies or to the performance demands by virtual machines, the Policy Manager notifies the Hyper-V servers to adjust their behavior. This feedback loop ensures that all virtual machines VHDs perform consistently according to the Storage QoS policies as defined.  

### <a name="BKMK_Glossary"></a>Glossary  

|Term|Description|  
|--------|---------------|  
|Normalized IOPs|All of the storage usage is measured in "Normalized IOPs."  This is a count of the storage input/output operations per second.  Any IO that is 8KB or smaller is considered as one normalized IO.  Any IO that is larger than 8KB is treated as multiple normalized IOs. For example, a 256KB request is treated as 32 normalized IOPs.<br /><br />Windows Server 2016 includes the ability to specify the size used to normalize IOs.  On the storage cluster, the normalized size can be specified and take effect on the normalization calculations cluster wide.  The default remains 8KB.|  
|Flow|Each file handle opened by a Hyper-V server to a VHD or VHDX file is considered a "flow". If a virtual machine has two virtual hard disks attached, it will have 1 flow to the file server cluster per file. If a VHDX is shared with multiple virtual machines, it will have 1 flow per virtual machine.|  
|InitiatorName|Name of the virtual machine that is reported to the Scale-Out File Server for each flow.|  
|InitiatorID|An identifier matching the virtual machine ID.  This can always be used to uniquely identify individual flows virtual machines even if the virtual machines have the same InitiatorName.|  
|Policy|Storage QoS policies are stored in the cluster database, and have the following properties: PolicyId, MinimumIOPS, MaximumIOPS, ParentPolicy, and PolicyType.|  
|PolicyId|Unique identifier for a policy.  It is generated by default, but can be specified if desired.|  
|MinimumIOPS|Minimum normalized IOPS that will be provided by a policy.  Also known as "Reservation".|  
|MaximumIOPS|Maximum normalized IOPS that will be limited by a policy.  Also known as "Limit".|  
|Aggregated |A policy type where the specified MinimumIOPS & MaximumIOPS and Bandwidth are shared among all flows assigned to the policy. All VHD's assigned the policy on that storage system have a  single allocation of I/O bandwidth for them to all share.|  
|Dedicated|A policy type where the specified Minimum & MaximumIOPs and Bandwidth are managed for individual VHD/VHDx.|  

## <a name="BKMK_SetUpQoS"></a>How to set up Storage QoS and monitor basic performance  
This section describes how to enable the new Storage QoS feature and how to monitor storage performance without applying custom policies.  

### <a name="BKMK_SetupStorageQoSonStorageCluster"></a>Set up Storage QoS on a Storage Cluster  
This section discusses how to enable Storage QoS on either a new or an existing Failover Cluster and Scale-Out File Server that is running Windows Server 2016.  

#### Set up Storage QoS on a new installation  
If you have configured a new Failover Cluster and configured a Cluster Shared Volume(CSV) on Windows Server 2016, then the Storage QoS feature will be set up automatically.  

#### Verify Storage QoS installation  
After you have created a Failover Cluster and configured a CSV disk, , **Storage QoS Resource** is displayed as a Cluster Core Resource and visible in both Failover Cluster Manager and Windows PowerShell. The intent is that the failover cluster system will manage this resource and you should not have to do any actions against this resource.  We display  it in both Failover Cluster Manager and PowerShell to be consistent with the other failover cluster system resources like the new Health Service.  

![Storage QoS Resource appears in Cluster Core Resources](media/overview-Clustering_StorageQoSFCM.png)  

**Figure 2: Storage QoS Resource displayed as a Cluster Core Resource in Failover Cluster Manager**  

Use the following PowerShell cmdlet to view the status of Storage QoS Resource.  

```PowerShell  
PS C:\> Get-ClusterResource -Name "Storage Qos Resource"  

Name                   State      OwnerGroup        ResourceType                 
----                   -----      ----------        ------------                 
Storage Qos Resource   Online     Cluster Group     Storage QoS Policy Manager  
```  

### <a name="BKMK_SetupStorageQoSonComputeCluster"></a>Set up Storage QoS on a Compute Cluster  
The Hyper-V role in Windows Server 2016 has built-in support for Storage QoS and is enabled by default.  

#### Install Remote Administration Tools to manage Storage QoS policies from remote computers  
You can manage Storage QoS policies and monitor flows from compute hosts using the Remote Server Administration Tools.  These are available as optional features on all Windows Server 2016 installations, and can be downloaded separately for Windows 10 at the [Microsoft Download Center](https://www.microsoft.com/download/details.aspx?id=45520) website.

The **RSAT-Clustering** optional feature includes the Windows PowerShell module for remote management of Failover Clustering, including Storage QoS.  

-   Windows PowerShell: Add-WindowsFeature RSAT-Clustering  

The **RSAT-Hyper-V-Tools** optional feature includes the Windows PowerShell module for remote management of Hyper-V.  

-   Windows PowerShell: Add-WindowsFeature RSAT-Hyper-V-Tools  

#### Deploy virtual machines to run workloads for testing  
You will need some virtual machines stored on the Scale-Out File Server with relevant workloads.  For some tips in how to simulate load and do some stress testing, see the following page for a recommended tool (DiskSpd) and some example usage: [DiskSpd, PowerShell and storage performance: measuring IOPs, throughput and latency for both local disks and SMB file shares.](https://blogs.technet.com/b/josebda/archive/2014/10/13/diskspd-powershell-and-storage-performance-measuring-iops-throughput-and-latency-for-both-local-disks-and-smb-file-shares.aspx)  

The example scenarios shown in this guide includes five virtual machines. BuildVM1, BuildVM2, BuildVM3 and BuildVM4 are running a desktop workload with low to moderate storage demands. TestVm1 is running an online transaction processing benchmark with high storage demand.  

### View current storage performance metrics  
This section includes:  

-   How to query flows using the `Get-StorageQosFlow` cmdlet.  

-   How to view performance for a volume using the `Get-StorageQosVolume` cmdlet.  

#### Query flows using the Get-StorageQosFlow cmdlet  

The Get-StorageQosFlow cmdlet shows all current flows initiated by Hyper-V servers. All data is collected by the Scale-Out File Server cluster, hence the cmdlet can be used on any node in the Scale-Out File Server cluster, or against a remote server using the -CimSession parameter.  

**The following sample command shows how to view all files opened by Hyper-V on server using Get-StorageQoSFlow**.  

```PowerShell
PS C:\> Get-StorageQosFlow  

InitiatorName    InitiatorNodeNam StorageNodeName  FilePath        Status  
                 e  
-------------    ---------------- ---------------  --------        ------  
                                  plang-fs3.pla... C:\ClusterSt... Ok  
                                  plang-fs2.pla... C:\ClusterSt... Ok  
                                  plang-fs1.pla... C:\ClusterSt... Ok  
                                  plang-fs3.pla... C:\ClusterSt... Ok  
                                  plang-fs2.pla... C:\ClusterSt... Ok  
                                  plang-fs1.pla... C:\ClusterSt... Ok  
TR20-VMM         plang-z400.pl... plang-fs1.pla... C:\ClusterSt... Ok  
BuildVM4         plang-c2.plan... plang-fs1.pla... C:\ClusterSt... Ok  
WinOltp1         plang-c1.plan... plang-fs1.pla... C:\ClusterSt... Ok  
BuildVM3         plang-c2.plan... plang-fs1.pla... C:\ClusterSt... Ok  
BuildVM1         plang-c2.plan... plang-fs1.pla... C:\ClusterSt... Ok  
TR20-VMM         plang-z400.pl... plang-fs1.pla... C:\ClusterSt... Ok  
BuildVM2         plang-c2.plan... plang-fs1.pla... C:\ClusterSt... Ok  
TR20-VMM         plang-z400.pl... plang-fs1.pla... C:\ClusterSt... Ok  
                                  plang-fs3.pla... C:\ClusterSt... Ok  
                                  plang-fs2.pla... C:\ClusterSt... Ok  
BuildVM4         plang-c2.plan... plang-fs2.pla... C:\ClusterSt... Ok  
WinOltp1         plang-c1.plan... plang-fs2.pla... C:\ClusterSt... Ok  
BuildVM3         plang-c2.plan... plang-fs2.pla... C:\ClusterSt... Ok  
WinOltp1         plang-c1.plan... plang-fs2.pla... C:\ClusterSt... Ok  
                                  plang-fs1.pla... C:\ClusterSt... Ok  
```  

The following sample command is formatted to show virtual machine name, Hyper-V host name, IOPs, and VHD file name, sorted by IOPS.  

```PowerShell  
PS C:\> Get-StorageQosFlow | Sort-Object StorageNodeIOPs -Descending | ft InitiatorName, @{Expression={$_.InitiatorNodeName.Substring(0,$_.InitiatorNodeName.IndexOf('.'))};Label="InitiatorNodeName"}, StorageNodeIOPs, Status, @{Expression={$_.FilePath.Substring($_.FilePath.LastIndexOf('\')+1)};Label="File"} -AutoSize  

InitiatorName InitiatorNodeName StorageNodeIOPs Status File  
------------- ----------------- --------------- ------ ----  
WinOltp1      plang-c1                     3482     Ok IOMETER.VHDX  
BuildVM2      plang-c2                      544     Ok BUILDVM2.VHDX  
BuildVM1      plang-c2                      497     Ok BUILDVM1.VHDX  
BuildVM4      plang-c2                      316     Ok BUILDVM4.VHDX  
BuildVM3      plang-c2                      296     Ok BUILDVM3.VHDX  
BuildVM4      plang-c2                      195     Ok WIN8RTM_ENTERPRISE_VL_BU...  
TR20-VMM      plang-z400                    156     Ok DATA1.VHDX  
BuildVM3      plang-c2                       81     Ok WIN8RTM_ENTERPRISE_VL_BU...  
WinOltp1      plang-c1                       65     Ok BOOT.VHDX  
                                             18     Ok DefaultFlow  
                                             12     Ok DefaultFlow  
WinOltp1      plang-c1                        4     Ok 9914.0.AMD64FRE.WINMAIN....  
TR20-VMM      plang-z400                      4     Ok DATA2.VHDX  
TR20-VMM      plang-z400                      3     Ok BOOT.VHDX  
                                              0     Ok DefaultFlow  
                                              0     Ok DefaultFlow  
                                              0     Ok DefaultFlow  
                                              0     Ok DefaultFlow  
                                              0     Ok DefaultFlow  
                                              0     Ok DefaultFlow  
                                              0     Ok DefaultFlow  
```  

The following sample command shows how to filter flows based on InitiatorName to easily find the storage performance and settings for a specific virtual machine.  

```PowerShell
PS C:\> Get-StorageQosFlow -InitiatorName BuildVm1 | Format-List

FilePath           : C:\ClusterStorage\Volume2\SHARES\TWO\BUILDWORKLOAD\BUILDVM1.V  
                     HDX  
FlowId             : ebfecb54-e47a-5a2d-8ec0-0940994ff21c  
InitiatorId        : ae4e3dd0-3bde-42ef-b035-9064309e6fec  
InitiatorIOPS      : 464  
InitiatorLatency   : 26.2684  
InitiatorName      : BuildVM1  
InitiatorNodeName  : plang-c2.plang.nttest.microsoft.com  
Interval           : 300000  
Limit              : 500  
PolicyId           : b145e63a-3c9e-48a8-87f8-1dfc2abfe5f4  
Reservation        : 500  
Status             : Ok  
StorageNodeIOPS    : 475  
StorageNodeLatency : 7.9725  
StorageNodeName    : plang-fs1.plang.nttest.microsoft.com  
TimeStamp          : 2/12/2015 2:58:49 PM  
VolumeId           : 4d91fc3a-1a1e-4917-86f6-54853b2a6787  
PSComputerName     :  
MaximumIops        : 500  
MinimumIops        : 500  
```  

The data returned by the `Get-StorageQosFlow` cmdlet includes:  

-   The Hyper-V hostname (InitiatorNodeName).  

-   The virtual machine's name and its Id (InitiatorName and InitiatorId)  

-   Recent average performance as observed by the Hyper-V host for the virtual disk (InitiatorIOPS, InitiatorLatency)  

-   Recent average performance as observed by the Storage cluster for the virtual disk (StorageNodeIOPS, StorageNodeLatency)  

-   Current policy being applied to the file, if any, and the resulting configuration (PolicyId, Reservation, Limit)  

-   Status of the policy  

    -   **Ok** - No issues exist  

    -   InsufficientThroughput- A policy is applied, but the Minimum IOPs cannot be delivered.  This can happen if the minimum for a VM, or all VMs together, are more than the storage volume can deliver.  

    -   **UnknownPolicyId** - A policy was assigned to the virtual machine on the Hyper-V host, but is missing from the file server.  This policy should be removed from the virtual machine configuration, or a matching policy should be created on the file server cluster.  

#### View performance for a volume using Get-StorageQosVolume  
Storage performance metrics are also collected on a per-storage volume level, in addition to the per-flow performance metrics.  This makes it easy to see the average total utilization in normalized IOPs, latency, and aggregate limits and reservations applied to a volume.  

```PowerShell
PS C:\> Get-StorageQosVolume | Format-List  

Interval       : 300000  
IOPS           : 0  
Latency        : 0  
Limit          : 0  
Reservation    : 0  
Status         : Ok  
TimeStamp      : 2/12/2015 2:59:38 PM  
VolumeId       : 434f561f-88ae-46c0-a152-8c6641561504  
PSComputerName :  
MaximumIops    : 0  
MinimumIops    : 0  

Interval       : 300000  
IOPS           : 1097  
Latency        : 3.1524  
Limit          : 0  
Reservation    : 1568  
Status         : Ok  
TimeStamp      : 2/12/2015 2:59:38 PM  
VolumeId       : 4d91fc3a-1a1e-4917-86f6-54853b2a6787  
PSComputerName :  
MaximumIops    : 0  
MinimumIops    : 1568  

Interval       : 300000  
IOPS           : 5354  
Latency        : 6.5084  
Limit          : 0  
Reservation    : 781  
Status         : Ok  
TimeStamp      : 2/12/2015 2:59:38 PM  
VolumeId       : 0d2fd367-8d74-4146-9934-306726913dda  
PSComputerName :  
MaximumIops    : 0  
MinimumIops    : 781  
```  

## <a name="BKMK_CreateQoSPolicies"></a>How to create and monitor Storage QoS Policies  
This section describes how to create Storage QoS policies, apply these policies to virtual machines, and monitor a storage cluster after policies are applied.  

### Create Storage QoS policies  
Storage QoS policies are defined and managed in the Scale-Out File Server cluster.  You can create as many policies as needed for flexible deployments (up to 10,000 per storage cluster).  

Each VHD/VHDX file assigned to a virtual machine may be configured with a policy. Different files and virtual machines can use the same policy or they can each be configured with separate policies.  If multiple VHD/VHDX files or multiple virtual machines are configured with the same policy, they will be aggregated together and will share the MinimumIOPS and MaximumIOPS fairly. If you use separate policies for multiple VHD/VHDX files or virtual machines, the minimum and maximums are tracked separately for each.  

If you create multiple similar policies for different virtual machines and the virtual machines have equal storage demand, they will receive a similar share of IOPs.  If one VM demands more and the other less, then IOPs will follow that demand.  

### Types of Storage QoS Policies  
There are two types of policies: Aggregated (previously known as SingleInstance) and Dedicated (previously known as MultiInstance). Aggregated policies apply maximums and minimum for the combined set of VHD/VHDX files and virtual machines where they apply. In effect, they share a specified set of IOPS and bandwidth. Dedicated policies apply the minimum and maximum values for each VHD/VHDx, separately. This makes it easy to create a single policy that applies similar limits to multiple VHD/VHDx files.  

For instance, if you create a Aggregated policy with a minimum of 300 IOPs and a maximum of 500 IOPs. If you apply this policy to 5 different VHD/VHDx files, you are making sure that the 5 VHD/VHDx files combined will be guaranteed at least 300 IOPs (if there is demand and the storage system can provide that performance) and no more than 500 IOPs. If the VHD/VHDx files have similar high demand for IOPs and the storage system can keep up, each VHD/VHDx files will get about 100 IOPs.  

However, if you create a Dedicated policy with similar limits and apply it to VHD/VHDx files on 5 different virtual machines, each virtual machine will get at least 300 IOPs and no more than 500 IOPs. If the virtual machines have similar high demand for IOPs and the storage system can keep up, each virtual machine will get about 500 IOPs. .  If one of the virtual machines has multiple VHD/VHDx files with the same MulitInstance policy configured, they will share the limit so that the total IO from the VM from files with that policy will not exceed the limits.  

Hence, if you have a group of VHD/VHDx files that you want to exhibit the same performance characteristics and you don't want the trouble of creating multiple, similar policies, you can use a single Dedicated policy and apply to the files of each virtual machine.

Keep the number of VHD/VHDx files assigned to a single Aggregated policy to 20 or less.  This policy type was meant to do aggregation with a few VMs on a cluster.

### Create and apply a Dedicated policy  
First, use the `New-StorageQosPolicy` cmdlet to create a policy on the Scale-Out File Server as shown in the following example:  

```PowerShell
$desktopVmPolicy = New-StorageQosPolicy -Name Desktop -PolicyType Dedicated -MinimumIops 100 -MaximumIops 200  
```  

Next, apply it to the appropriate virtual machines' hard disk drives on the Hyper-V server.  Note the PolicyId from the previous step or store it in a variable in your scripts.  

On the Scale-Out File Server, using PowerShell, create a Storage QoS policy and get its Policy ID as shown in the following example:  

```PowerShell
PS C:\> $desktopVmPolicy = New-StorageQosPolicy -Name Desktop -PolicyType Dedicated -MinimumIops 100 -MaximumIops 200  

C:\> $desktopVmPolicy.PolicyId  

Guid  
----  
cd6e6b87-fb13-492b-9103-41c6f631f8e0  
```  

On the Hyper-V server, using PowerShell, set the Storage QoS Policy using the Policy ID as shown in the following example:  

```PowerShell
Get-VM -Name Build* | Get-VMHardDiskDrive | Set-VMHardDiskDrive -QoSPolicyID cd6e6b87-fb13-492b-9103-41c6f631f8e0  
```  

### Confirm that the policies are applied  
Use `Get-StorageQosFlow` PowerShell cmdlet to confirm that the MinimumIOPs and MaximumIOPs have been applied to the appropriate flows as shown in the following example.  

```PowerShell
PS C:\> Get-StorageQoSflow | Sort-Object InitiatorName |  
 ft InitiatorName, Status, MinimumIOPs, MaximumIOPs, StorageNodeIOPs, Status, @{Expression={$_.FilePath.Substring($_.FilePath.LastIndexOf('\')+1)};Label="File"} -AutoSize  

InitiatorName Status MinimumIops MaximumIops StorageNodeIOPs Status File  
------------- ------ ----------- ----------- --------------- ------ ----  
BuildVM1          Ok         100         200             250     Ok BUILDVM1.VHDX  
BuildVM2          Ok         100         200             251     Ok BUILDVM2.VHDX  
BuildVM3          Ok         100         200             252     Ok BUILDVM3.VHDX  
BuildVM4          Ok         100         200             233     Ok BUILDVM4.VHDX  
TR20-VMM          Ok          33         666               1     Ok DATA2.VHDX  
TR20-VMM          Ok          33         666               5     Ok DATA1.VHDX  
TR20-VMM          Ok          33         666               4     Ok BOOT.VHDX  
WinOltp1          Ok           0           0               0     Ok 9914.0.AMD6...  
WinOltp1          Ok           0           0            5166     Ok IOMETER.VHDX  
WinOltp1          Ok           0           0               0     Ok BOOT.VHDX  
```  

On the Hyper-V server, you can also use the provided script **Get-VMHardDiskDrivePolicy.ps1** to see what policy is applied to a virtual hard disk drive.  

```PowerShell
PS C:\> Get-VM -Name BuildVM1 | Get-VMHardDiskDrive | Format-List  

Path                          : \\plang-fs.plang.nttest.microsoft.com\two\BuildWorkload  
                                \BuildVM1.vhdx  
DiskNumber                    :  
MaximumIOPS                   : 0  
MinimumIOPS                   : 0  
QoSPolicyID                   : cd6e6b87-fb13-492b-9103-41c6f631f8e0  
SupportPersistentReservations : False  
ControllerLocation            : 0  
ControllerNumber              : 0  
ControllerType                : IDE  
PoolName                      : Primordial  
Name                          : Hard Drive  
Id                            : Microsoft:AE4E3DD0-3BDE-42EF-B035-9064309E6FEC\83F8638B  
                                -8DCA-4152-9EDA-2CA8B33039B4\0\0\D  
VMId                          : ae4e3dd0-3bde-42ef-b035-9064309e6fec  
VMName                        : BuildVM1  
VMSnapshotId                  : 00000000-0000-0000-0000-000000000000  
VMSnapshotName                :  
ComputerName                  : PLANG-C2  
IsDeleted                     : False  
```  

### Query for Storage QoS Policies  
`Get-StorageQosPolicy` lists all configured policies and their status on a Scale-Out File Server.  

```PowerShell
PS C:\> Get-StorageQosPolicy  

Name                 MinimumIops          MaximumIops          Status  
----                 -----------          -----------          ------  
Default              0                    0                    Ok  
Limit500             0                    500                  Ok  
SilverVm             500                  500                  Ok  
Desktop              100                  200                  Ok  
Limit500             0                    0                    Ok  
VMM                  100                  2000                 Ok  
Vdi                  1                    100                  Ok  
```  

Status can change over time based on how the system is performing.  

-   **Ok** - All flows using that policy are receiving their requested MinimumIOPs.  

-   **InsufficientThroughput** - One or more of the flows using this policy are not receiving the Minimum IOPs  

You can also pipe a policy to `Get-StorageQosPolicy` to get the status of all flows configured to use the policy as follows:  

```PowerShell
PS C:\> Get-StorageQosPolicy -Name Desktop | Get-StorageQosFlow | ft InitiatorName, *IOPS, Status, FilePath -AutoSize  

InitiatorName MaximumIops MinimumIops InitiatorIOPS StorageNodeIOPS Status FilePat  
                                                                           h  
------------- ----------- ----------- ------------- --------------- ------ -------  
BuildVM4              100          50           187              17     Ok C:\C...  
BuildVM3              100          50           194              25     Ok C:\C...  
BuildVM1              200         100           195             196     Ok C:\C...  
BuildVM2              200         100           193             192     Ok C:\C...  
BuildVM4              200         100           187             169     Ok C:\C...  
BuildVM3              200         100           194             169     Ok C:\C...  
```  

### Create an Aggregated Policy  
Aggregated policies may be used if you want multiple virtual hard disks to share a single pool of IOPs and bandwidth.  For example, if you apply the same Aggregated policy to hard disks from two virtual machines, the minimum will be split between them according to demand.  Both disks will be guaranteed a combined minimum, and together they will not exceed the specified maximum IOPs or bandwidth.  

The same approach could also be used to provide a single allocation to all VHD/VHDx files for the virtual machines  comprising a service or belonging to a tenant in a multihosted environment.  

There is no difference in the process to create Dedicated and Aggregated policies other than the PolicyType that is specified.  

The following example shows how to create an Aggregated Storage QoS Policy and get its policyID on a Scale-Out File Server:  

```PowerShell
PS C:\> $highPerf = New-StorageQosPolicy -Name SqlWorkload -MinimumIops 1000 -MaximumIops 5000 -PolicyType Aggregated  
[plang-fs]: PS C:\Users\plang\Documents> $highPerf.PolicyId  

Guid  
----  
7e2f3e73-1ae4-4710-8219-0769a4aba072  
```  

The following example shows how to apply the Storage QoS Policy on Hyper-V server using the policyID obtained in the preceding example:  

```PowerShell
PS C:\> Get-VM -Name WinOltp1 | Get-VMHardDiskDrive | Set-VMHardDiskDrive -QoSPolicyID 7e2f3e73-1ae4-4710-8219-0769a4aba072  
```  

The following example shows how to viewing effects of the Storage QoS policy from file server:  

```PowerShell
PS C:\> Get-StorageQosFlow -InitiatorName WinOltp1 | format-list InitiatorName, PolicyId, MinimumIOPs, MaximumIOPs, StorageNodeIOPs, FilePath  

InitiatorName   : WinOltp1  
PolicyId        : 7e2f3e73-1ae4-4710-8219-0769a4aba072  
MinimumIops     : 250  
MaximumIops     : 1250  
StorageNodeIOPs : 0  
FilePath        : C:\ClusterStorage\Volume2\SHARES\TWO\BASEVHD\9914.0.AMD64FRE.WIN  
                  MAIN.141218-1718_SERVER_SERVERDATACENTER_EN-US.VHDX  

InitiatorName   : WinOltp1  
PolicyId        : 7e2f3e73-1ae4-4710-8219-0769a4aba072  
MinimumIops     : 250  
MaximumIops     : 1250  
StorageNodeIOPs : 0  
FilePath        : C:\ClusterStorage\Volume3\SHARES\THREE\WINOLTP1\BOOT.VHDX  

InitiatorName   : WinOltp1  
PolicyId        : 7e2f3e73-1ae4-4710-8219-0769a4aba072  
MinimumIops     : 1000  
MaximumIops     : 5000  
StorageNodeIOPs : 4550  
FilePath        : C:\ClusterStorage\Volume3\SHARES\THREE\WINOLTP1\IOMETER.VHDX  
PS C:\> Get-StorageQosFlow -InitiatorName WinOltp1 | for  
mat-list InitiatorName, PolicyId, MinimumIOPs, MaximumIOPs, StorageNodeIOPs, FilePath  

InitiatorName   : WinOltp1  
PolicyId        : 7e2f3e73-1ae4-4710-8219-0769a4aba072  
MinimumIops     : 250  
MaximumIops     : 1250  
StorageNodeIOPs : 0  
FilePath        : C:\ClusterStorage\Volume2\SHARES\TWO\BASEVHD\9914.0.AMD64FRE.WIN  
                  MAIN.141218-1718_SERVER_SERVERDATACENTER_EN-US.VHDX  

InitiatorName   : WinOltp1  
PolicyId        : 7e2f3e73-1ae4-4710-8219-0769a4aba072  
MinimumIops     : 250  
MaximumIops     : 1250  
StorageNodeIOPs : 0  
FilePath        : C:\ClusterStorage\Volume3\SHARES\THREE\WINOLTP1\BOOT.VHDX  

InitiatorName   : WinOltp1  
PolicyId        : 7e2f3e73-1ae4-4710-8219-0769a4aba072  
MinimumIops     : 1000  
MaximumIops     : 5000  
StorageNodeIOPs : 4550  
FilePath        : C:\ClusterStorage\Volume3\SHARES\THREE\WINOLTP1\IOMETER.VHDX  
```  

Each virtual hard disk will have the MinimumIOPs and MaximumIOPs and MaximumIobandwidth value adjusted based on its load.  This ensures that the total amount of bandwidth used for the group of disks stays within the range defined by policy.  In the example above, the first two disks are idle, and the third one is allowed to use up to the maximum IOPs.  If the first two disks start issuing IO again, then the maximum IOPs of the third disk will be lowered automatically.  

### Modify an existing policy  
The properties of Name, MinimumIOPs,  MaximumIOPs, and MaximumIoBandwidthcan be changed after a policy is created.  However, the Policy Type (Aggregated/Dedicated) cannot be changed once the policy is created.  

The following Windows PowerShell cmdlet shows how to change the MaximumIOPs property for an existing policy:  

```PowerShell
[DBG]: PS C:\demoscripts>> Get-StorageQosPolicy -Name SqlWorkload | Set-StorageQosPolicy -MaximumIops 6000  
```  

The following cmdlet verifies the change:  

```PowerShell
PS C:\> Get-StorageQosPolicy -Name SqlWorkload  

Name                    MinimumIops            MaximumIops            Status  
----                    -----------            -----------            ------  
SqlWorkload             1000                   6000                   Ok    

[plang-fs1]: PS C:\Users\plang\Documents> Get-StorageQosPolicy -Name SqlWorkload | Get-Storag  
eQosFlow | Format-Table InitiatorName, PolicyId, MaximumIops, MinimumIops, StorageNodeIops -A  
utoSize  

InitiatorName PolicyId                             MaximumIops MinimumIops StorageNodeIops  
------------- --------                             ----------- ----------- ---------------  
WinOltp1      7e2f3e73-1ae4-4710-8219-0769a4aba072        1500         250               0  
WinOltp1      7e2f3e73-1ae4-4710-8219-0769a4aba072        1500         250               0  
WinOltp1      7e2f3e73-1ae4-4710-8219-0769a4aba072        6000        1000            4507  
```  

## <a name="BKMK_KnownIssues"></a>How to identify and address common issues  
This section describes how to find virtual machines with invalid Storage QoS policies, how to recreate a matching policy, how to remove a policy from a virtual machine, and how to identify virtual machines that do not meet the Storage QoS policy requirements.  

### <a name="BKMK_FindingVMsWithInvalidPolicies"></a>Identify virtual machines with invalid policies  

If a policy is deleted from the file server before it's removed from a virtual machine, the virtual machine will keep running as if no policy were applied.  

```PowerShell
PS C:\> Get-StorageQosPolicy -Name SqlWorkload | Remove-StorageQosPolicy  

Confirm  
Are you sure you want to perform this action?  
Performing the operation "DeletePolicy" on target "MSFT_StorageQoSPolicy (PolicyId =  
"7e2f3e73-1ae4-4710-8219-0769a4aba072")".  
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [?] Help (default is "Y"):  
```  

The status for the flows will now show "UnknownPolicyId"  

```PowerShell
PS C:\> Get-StorageQoSflow | Sort-Object InitiatorName | ft InitiatorName, Status, MinimumIOPs, MaximumIOPs, StorageNodeIOPs, Status, @{Expression={$_.FilePath.Substring($_.FilePath.LastIndexOf('\')+1)};Label="File"} -AutoSize  

InitiatorName          Status MinimumIops MaximumIops StorageNodeIOPs          Status File  
-------------          ------ ----------- ----------- ---------------          ------ ----  
                           Ok           0           0               0              Ok Def...  
                           Ok           0           0              10              Ok Def...  
                           Ok           0           0              13              Ok Def...  
                           Ok           0           0               0              Ok Def...  
                           Ok           0           0               0              Ok Def...  
                           Ok           0           0               0              Ok Def...  
                           Ok           0           0               0              Ok Def...  
                           Ok           0           0               0              Ok Def...  
                           Ok           0           0               0              Ok Def...  
BuildVM1                   Ok         100         200             193              Ok BUI...  
BuildVM2                   Ok         100         200             196              Ok BUI...  
BuildVM3                   Ok          50          64              17              Ok WIN...  
BuildVM3                   Ok          50         136             179              Ok BUI...  
BuildVM4                   Ok          50         100              23              Ok WIN...  
BuildVM4                   Ok         100         200             173              Ok BUI...  
TR20-VMM                   Ok          33         666               2              Ok DAT...  
TR20-VMM                   Ok          25         975               3              Ok DAT...  
TR20-VMM                   Ok          75        1025              12              Ok BOO...  
WinOltp1      UnknownPolicyId           0           0               0 UnknownPolicyId 991...  
WinOltp1      UnknownPolicyId           0           0            4926 UnknownPolicyId IOM...  
WinOltp1      UnknownPolicyId           0           0               0 UnknownPolicyId BOO...  
```  

#### <a name="BKMK_RecreateMatchingPolicy"></a>Recreate a matching Storage QoS policy  
If a policy was unintentionally removed, you can create a new one using the old PolicyId.  First, get the needed PolicyId  

```PowerShell
PS C:\> Get-StorageQosFlow -Status UnknownPolicyId | ft InitiatorName, PolicyId -AutoSize  

InitiatorName PolicyId  
------------- --------  
WinOltp1      7e2f3e73-1ae4-4710-8219-0769a4aba072  
WinOltp1      7e2f3e73-1ae4-4710-8219-0769a4aba072  
WinOltp1      7e2f3e73-1ae4-4710-8219-0769a4aba072  
```  

Next, create a new policy using that PolicyId  

```PowerShell
PS C:\> New-StorageQosPolicy -PolicyId 7e2f3e73-1ae4-4710-8219-0769a4aba072 -PolicyType Aggregated -Name RestoredPolicy -MinimumIops 100 -MaximumIops 2000  

Name                    MinimumIops            MaximumIops            Status  
----                    -----------            -----------            ------  
RestoredPolicy          100                    2000                   Ok  
```  

Finally, verify that it was applied.  

```PowerShell
PS C:\> Get-StorageQoSflow | Sort-Object InitiatorName | ft InitiatorName, Status, MinimumIOPs, MaximumIOPs, StorageNodeIOPs, Status, @{Expression={$_.FilePath.Substring($_.FilePath.LastIndexOf('\')+1)};Label="File"} -AutoSize  

InitiatorName Status MinimumIops MaximumIops StorageNodeIOPs Status File  
------------- ------ ----------- ----------- --------------- ------ ----  
                  Ok           0           0               0     Ok DefaultFlow  
                  Ok           0           0               8     Ok DefaultFlow  
                  Ok           0           0               9     Ok DefaultFlow  
                  Ok           0           0               0     Ok DefaultFlow  
                  Ok           0           0               0     Ok DefaultFlow  
                  Ok           0           0               0     Ok DefaultFlow  
                  Ok           0           0               0     Ok DefaultFlow  
                  Ok           0           0               0     Ok DefaultFlow  
                  Ok           0           0               0     Ok DefaultFlow  
BuildVM1          Ok         100         200             192     Ok BUILDVM1.VHDX  
BuildVM2          Ok         100         200             193     Ok BUILDVM2.VHDX  
BuildVM3          Ok          50         100              24     Ok WIN8RTM_ENTERPRISE_VL...  
BuildVM3          Ok         100         200             166     Ok BUILDVM3.VHDX  
BuildVM4          Ok          50         100              12     Ok WIN8RTM_ENTERPRISE_VL...  
BuildVM4          Ok         100         200             178     Ok BUILDVM4.VHDX  
TR20-VMM          Ok          33         666               2     Ok DATA2.VHDX  
TR20-VMM          Ok          33         666               2     Ok DATA1.VHDX  
TR20-VMM          Ok          33         666              10     Ok BOOT.VHDX  
WinOltp1          Ok          25         500               0     Ok 9914.0.AMD64FRE.WINMA...  
```  

#### <a name="BKMK_RemovePolicyFromVM"></a>Remove Storage QoS Policies  

If the policy was removed intentionally, or if a VM was imported with a policy that you don't need, it may be removed.  

```PowerShell
PS C:\> Get-VM -Name WinOltp1 | Get-VMHardDiskDrive | Set-VMHardDiskDrive -QoSPolicyID $null  
```  

Once the PolicyId is removed from the virtual hard disk settings, the status will be "Ok" and no minimum or maximum will be applied.  

```PowerShell
PS C:\> Get-StorageQoSflow | Sort-Object InitiatorName | ft InitiatorName, MinimumIOPs, MaximumIOPs, StorageNodeIOPs, Status, @{Expression={$_.FilePath.Substring($_.FilePath.LastIndexOf('\')+1)};Label="File"} -AutoSize  

InitiatorName MinimumIops MaximumIops StorageNodeIOPs Status File  
------------- ----------- ----------- --------------- ------ ----  
                        0           0               0     Ok DefaultFlow  
                        0           0              16     Ok DefaultFlow  
                        0           0              12     Ok DefaultFlow  
                        0           0               0     Ok DefaultFlow  
                        0           0               0     Ok DefaultFlow  
                        0           0               0     Ok DefaultFlow  
                        0           0               0     Ok DefaultFlow  
                        0           0               0     Ok DefaultFlow  
                        0           0               0     Ok DefaultFlow  
BuildVM1              100         200             197     Ok BUILDVM1.VHDX  
BuildVM2              100         200             192     Ok BUILDVM2.VHDX  
BuildVM3                9           9              23     Ok WIN8RTM_ENTERPRISE_VL_BUILDW...  
BuildVM3               91         191             171     Ok BUILDVM3.VHDX  
BuildVM4                8           8              18     Ok WIN8RTM_ENTERPRISE_VL_BUILDW...  
BuildVM4               92         192             163     Ok BUILDVM4.VHDX  
TR20-VMM               33         666               2     Ok DATA2.VHDX  
TR20-VMM               33         666               1     Ok DATA1.VHDX  
TR20-VMM               33         666               5     Ok BOOT.VHDX  
WinOltp1                0           0               0     Ok 9914.0.AMD64FRE.WINMAIN.1412...  
WinOltp1                0           0            1811     Ok IOMETER.VHDX  
WinOltp1                0           0               0     Ok BOOT.VHDX  
```  

### <a name="BKMK_VMsThatDoNotMeetStorageQoSPoilicies"></a>Find virtual machines that are not meeting Storage QoS Policies  
The **InsufficientThroughput** status is assigned to any flows that:  

-   Have a minimum defined IOPs set by policy; and  

-   Are initiating IO at a rate meeting or exceeding the minimum; and  

-   Are not achieving minimum IOP rate  

```PowerShell
PS C:\> Get-StorageQoSflow | Sort-Object InitiatorName | ft InitiatorName, MinimumIOPs, MaximumIOPs, StorageNodeIOPs, Status, @{Expression={$_.FilePath.Substring($_.FilePath.LastIndexOf('\')+1)};Label="File"} -AutoSize  

InitiatorName MinimumIops MaximumIops StorageNodeIOPs                 Status File  
------------- ----------- ----------- ---------------                 ------ ----  
                        0           0               0                     Ok DefaultFlow  
                        0           0               0                     Ok DefaultFlow  
                        0           0              15                     Ok DefaultFlow  
                        0           0               0                     Ok DefaultFlow  
                        0           0               0                     Ok DefaultFlow  
                        0           0               0                     Ok DefaultFlow  
                        0           0               0                     Ok DefaultFlow  
                        0           0               0                     Ok DefaultFlow  
                        0           0               0                     Ok DefaultFlow  
BuildVM3               50         100              20                     Ok WIN8RTM_ENTE...  
BuildVM3              100         200             174                     Ok BUILDVM3.VHDX  
BuildVM4               50         100              11                     Ok WIN8RTM_ENTE...  
BuildVM4              100         200             188                     Ok BUILDVM4.VHDX  
TR20-VMM               33         666               3                     Ok DATA1.VHDX  
TR20-VMM               78        1032             180                     Ok BOOT.VHDX  
TR20-VMM               22         968               4                     Ok DATA2.VHDX  
WinOltp1             3750        5000               0                     Ok 9914.0.AMD64...  
WinOltp1            15000       20000           11679 InsufficientThroughput IOMETER.VHDX  
WinOltp1             3750        5000               0                     Ok BOOT.VHDX  
```  

You can determine flows for any status, including **InsufficientThroughput** as shown in the following example:  

```PowerShell
PS C:\> Get-StorageQosFlow -Status InsufficientThroughput | fl  

FilePath           : C:\ClusterStorage\Volume3\SHARES\THREE\WINOLTP1\IOMETER.VHDX  
FlowId             : 1ca356ff-fd33-5b5d-b60a-2c8659dc803e  
InitiatorId        : 2ceabcef-2eba-4f1b-9e66-10f960b50bbf  
InitiatorIOPS      : 12168  
InitiatorLatency   : 22.983  
InitiatorName      : WinOltp1  
InitiatorNodeName  : plang-c1.plang.nttest.microsoft.com  
Interval           : 300000  
Limit              : 20000  
PolicyId           : 5d1bf221-c8f0-4368-abcf-aa139e8a7c72  
Reservation        : 15000  
Status             : InsufficientThroughput  
StorageNodeIOPS    : 12181  
StorageNodeLatency : 22.0514  
StorageNodeName    : plang-fs2.plang.nttest.microsoft.com  
TimeStamp          : 2/13/2015 12:07:30 PM  
VolumeId           : 0d2fd367-8d74-4146-9934-306726913dda  
PSComputerName     :  
MaximumIops        : 20000  
MinimumIops        : 15000  
```  

## <a name="BKMK_Health"></a>Monitor Health using Storage QoS  
The new Health Service simplifies the monitoring of the Storage Cluster, providing a single place to check for any actionable events in any of the nodes. This section describes how monitor the health of your storage cluster using the `debug-storagesubsystem` cmdlet.  

### View Storage Status with Debug-StorageSubSystem  
Clustered Storage Spaces also provide information on the health of the storage cluster in a single location. This can help administrators quickly identify current problems in storage deployments and monitor as issues arrive or are dismissed.  

#### VM with invalid policy  
VMs with invalid policies are also reported through the storage subsystem health monitoring.  Here is an example from the same state as described in [Finding VMs with invalid policies](#BKMK_FindingVMsWithInvalidPolicies) section of this document.  

```PowerShell
C:\> Get-StorageSubSystem -FriendlyName Clustered* | Debug-StorageSubSystem  

EventTime                 :  
FaultId                   : 0d16d034-9f15-4920-a305-f9852abf47c3  
FaultingObject            :  
FaultingObjectDescription : Storage QoS Policy 5d1bf221-c8f0-4368-abcf-aa139e8a7c72  
FaultingObjectLocation    :  
FaultType                 : Storage QoS policy used by consumer does not exist.  
PerceivedSeverity         : Minor  
Reason                    : One or more storage consumers (usually Virtual Machines) are  
                            using a non-existent policy with id  
                            5d1bf221-c8f0-4368-abcf-aa139e8a7c72. Consumer details:  

                            Flow ID: 1ca356ff-fd33-5b5d-b60a-2c8659dc803e  
                            Initiator ID: 2ceabcef-2eba-4f1b-9e66-10f960b50bbf  
                            Initiator Name: WinOltp1  
                            Initiator Node: plang-c1.plang.nttest.microsoft.com  
                            File Path:  
                            C:\ClusterStorage\Volume3\SHARES\THREE\WINOLTP1\IOMETER.VHDX  
RecommendedActions        : {Reconfigure the storage consumers (usually Virtual Machines)  
                            to use a valid policy., Recreate any missing Storage QoS  
                            policies.}  
PSComputerName            :  
```  

#### Lost redundancy for a storage spaces virtual disk  

In this example, a Clustered Storage Space has a virtual disk created as a three-way mirror.  A failed disk was removed from the system, but a replacement disk was not added.  The storage subsystem is reporting a loss of redundancy with HealthStatus **Warning**, but OperationalStatus "**OK** because the volume is still online.  

```PowerShell
PS C:\> Get-StorageSubSystem -FriendlyName Clustered*  

FriendlyName                   HealthStatus                   OperationalStatus  
------------                   ------------                   -----------------  
Clustered Windows Storage o... Warning                        OK  

[plang-fs1]: PS C:\Users\plang\Documents> Get-StorageSubSystem -FriendlyName Clustered* | Deb  
ug-StorageSubSystem  

EventTime                 :  
FaultId                   : dfb4b672-22a6-4229-b2ed-c29d7485bede  
FaultingObject            :  
FaultingObjectDescription : Virtual disk 'Two'  
FaultingObjectLocation    :  
FaultType                 : VirtualDiskDegradedFaultType  
PerceivedSeverity         : Minor  
Reason                    : Virtual disk 'Two' does not have enough redundancy remaining to  
                            successfully repair or regenerate its data.  
RecommendedActions        : {Rebalance the pool, replace failed physical disks, or add new  
                            physical disks to the storage pool, then repair the virtual  
                            disk.}  
PSComputerName            :  
```  

### Sample script for continuous monitoring of Storage QoS  

This section includes a sample script showing how common failures can be monitored using WMI script.  It's designed as a starting part for developers to retrieve health events in real time.  

**Example script:**  

```PowerShell
param($cimSession)  
# Register and display events  
Register-CimIndicationEvent -Namespace root\microsoft\windows\storage -ClassName msft_storagefaultevent -CimSession $cimSession  

while ($true)  
{  
     $e = (Wait-Event)  
     $e.SourceEventArgs.NewEvent  
     Remove-Event $e.SourceIdentifier  
}  
```  

## Frequently Asked Questions  

### How do I retain a Storage QoS policy being enforced for my virtual machine if I move its VHD/VHDx files to another storage cluster  

The setting on the VHD/VHDx file that specifies the policy is the GUID of a policy ID.  When a policy is created, the GUID can be specified using the **PolicyID** parameter.  If that parameter is not specified, a random GUID is created.  Therefore, you can get the PolicyID on the storage cluster where the VMs currently store their VHD/VHDx files and create an identical policy on the destination storage cluster and then specify that it be created with the same GUID.  When the VMs files are moved to the new storage clusters, the policy with the same GUID will be in effect.  

System Center Virtual Machine Manager can be used to apply policies across multiple storage clusters, which makes this scenario much easier.  
### If I change the Storage QoS Policy, why don't I see it take effect immediately when I run Get-StorageQoSFlow  

If you have a flow that is hitting a maximum of a policy and you change the policy to either make it higher or lower, and then you immediately determine the latency/IOPS/BandWidth of the flows using the PowerShell cmdlets, it will take up to 5 minutes to see the full effects of the policy change on the flows.  The new limits will be in effect within a few seconds, but the **Get-StorgeQoSFlow** PowerShell cmdlet uses an average of each counter using a 5 minute sliding window.  Otherwise, if it was showing a current value and you ran the PowerShell cmdlet multiple times in a row, you may see vastly different values because values for IOPS and latencies can fluctuate significantly from one second to another.

### <a name="BKMK_Updates"></a>What new functionality was added in Windows Server 2016

In Windows Server 2016 the Storage QoS Policy type names were renamed.  The **Multi-instance** policy type is renamed as **Dedicated** and **Single-instance** was renamed as **Aggregated**. The management behavior of Dedicated policies is also modified - VHD/VHDX files within the same virtual machine that have the same **Dedicated** policy applied to them will not share I/O allocations.  

There are two new Storage QoS features Windows Server 2016:  

-   **Maximum Bandwidth**  

    Storage QoS in Windows Server 2016 introduces the ability to specify the maximum bandwidth that the flows assigned to the policy may consume.  The parameter when specifying it in the **StorageQosPolicy** cmdlets is **MaximumIOBandwidth** and the output is expressed in bytes per second.  
    If both **MaximimIops** and **MaximumIOBandwidth** are set in a policy, they will both be in effect and the first one to be reached by the flow(s) will limit the I/O of the flows.  

-   **IOPS normalization is configurable**  

    Storage QoSin  uses normalization of IOPS.  The default is to use a normalization size of 8K.  Storage QoS in Windows Server 2016 introduces the ability to specify a different normalization size for the storage cluster.  This normalization size effects all flows on the storage cluster and takes effect immediately (within a few seconds) once it is changed.  The minimum is 1KB and the maximum is 4GB (recommend not setting more than 4MB since it's unusual to have more than 4MB IOs).  

    Something to consider is that the same IO pattern/throughput shows up with different IOPS numbers in the Storage QoS output when you change the IOPS normalization due to the change in normalization calculation.  If you are comparing IOPS between storage clusters, you may also want to verify what normalization value each is using since that will effect the normalized IOPS reported.    

#### Example 1: Creating a new policy and viewing the maximum bandwidth on the storage cluster  
In PowerShell, you can specify the units that a number is expressed in.  In the following example, 10MB is used as the maximum bandwidth value.  Storage QoS will convert this and save it as bytes per second  Hence, 10MB is converted into 10485760 bytes per second.  

```PowerShell
PS C:\Windows\system32> New-StorageQosPolicy -Name HR_VMs -MaximumIops 1000 -MinimumIops 20 -MaximumIOBandwidth 10MB  

Name   MinimumIops MaximumIops MaximumIOBandwidth Status  
----   ----------- ----------- ------------------ ------  
HR_VMs 20          1000        10485760           Ok  

PS C:\Windows\system32> Get-StorageQosPolicy  

Name    MinimumIops MaximumIops MaximumIOBandwidth Status  
----    ----------- ----------- ------------------ ------  
Default 0           0           0                  Ok  
HR_VMs  20          1000        10485760           Ok  

PS C:\Windows\system32> Get-StorageQoSFlow | fL InitiatorName,FilePath,InitiatorIOPS,InitiatorLatency,InitiatorBandwidth  

InitiatorName      : testsQoS  
FilePath           : C:\ClusterStorage\Volume2\TESTSQOS\VIRTUAL HARD DISKS\TESTSQOS.VHDX  
InitiatorIOPS      : 5  
InitiatorLatency   : 1.5455  
InitiatorBandwidth : 37888  
```  

#### Example 2: Get IOPS normalization settings and specify  a new value  

The following example demonstrates how to get the storage clusters IOPS normalization settings (default of 8KB), then set it to 32KB, and then show it again.  Note, in this example, specify "32KB", since PowerShell allows specifying the unit instead of requiring the conversion to bytes.   The output does show the value in bytes per second.  

```PowerShell
PS C:\Windows\system32> Get-StorageQosPolicyStore  

IOPSNormalizationSize  
---------------------  
8192  

PS C:\Windows\system32> Set-StorageQosPolicyStore -IOPSNormalizationSize 32KB  
PS C:\Windows\system32> Get-StorageQosPolicyStore  

IOPSNormalizationSize  
---------------------  
32768  
```    

## See Also  
- [Windows Server 2016](../../get-started/windows-server-2016.md)  
- [Storage Replica in Windows Server 2016](../storage-replica/storage-replica-overview.md)  
- [Storage Spaces Direct in Windows Server 2016](../storage-spaces/storage-spaces-direct-overview.md)  
