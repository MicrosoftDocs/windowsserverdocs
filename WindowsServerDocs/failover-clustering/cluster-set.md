---
title: Deploy a cluster set for Windows Server Failover Clusters 
description: Learn how to deploy a cluster set
author: jasongerend
ms.topic: how-to
ms.date: 09/08/2022
ms.author: jgerend
ms.reviewer: stevenek
ms.custom: contperf-fy21q4
---

# Deploy a cluster set

> Applies to: Windows Server 2019

This article provides information on how to deploy a cluster set for Windows Server Failover Clusters using PowerShell. A cluster set is a group of multiple failover clusters that are clustered together. By using a cluster set, you can increase the number of server nodes in a single Software Defined Data Center (SDDC) cloud by orders of magnitude.

Cluster sets have been tested and supported up to 64 total cluster nodes. However, cluster sets can scale to much larger limits and aren't hardcoded for a limit.

## Benefits

Cluster sets offer the following benefits:

- Significantly increases the supported SDDC cloud scale for running highly available virtual machines (VMs) by combining multiple smaller clusters into a single large fabric, while keeping the software fault boundary to a single cluster. You can easily migrate VMs across the cluster set.

- Increased resiliency. Having four 4-node clusters in a cluster set gives you better resiliency than a single 16-node cluster in that multiple compute nodes can go down and production remains intact.

- Management of failover cluster lifecycle, including onboarding and retiring clusters, without impacting tenant VM availability.

- VM flexibility across individual clusters and a present a unified storage namespace.

- Easily change the compute-to-storage workload ratio in your hyper-converged environment.

- Benefit from [Azure-like Fault Domains and Availability sets](/azure/virtual-machines/windows/manage-availability) across individual clusters in initial VM placement and subsequent migration.

- Can use even if compute and storage hardware between cluster nodes isn't identical.
- Live migration of VMs between clusters.
- Azure-like availability sets and fault domains across multiple clusters.
- Moving of SQL Server VMs between clusters.

## Requirements and limitations

There are a few requirements and limitations for using cluster sets:

- All member clusters in a cluster set must be in the same Active Directory (AD) forest.

- Member servers in the set must run the same operating system version. Virtual machines can't be live migrated between different operating systems. You can have a cluster set that consists of any one, but not multiples, of the following options:

    - Windows Server 2019 Failover Cluster and Windows Server 2019 Failover Cluster
    - Windows Server 2019 Failover Cluster and Windows Server 2019 Storage Spaces Direct
    - Windows Server 2019 Storage Spaces Direct and Windows Server 2019 Storage Spaces Direct

- Identical processor hardware is needed for all member servers for live migration between member clusters to occur; otherwise, you must select **CPU Processor Compatibility** in virtual machines settings.

- Cluster set VMs must be manually live-migrated across clusters - they can't automatically fail over.

- Storage Replica must be used between member clusters to realize storage resiliency to cluster failures. When using Storage Replica, bear in mind that namespace storage UNC paths will not change automatically on Storage Replica failover to the replica target cluster.

- Storage Spaces Direct doesn't function across member clusters in a cluster set. Rather, Storage Spaces Direct applies to a single cluster, with each cluster having its own storage pool.

## Architecture

The following diagram illustrates a cluster set at a high level:

 :::image type="content" source="media/cluster-set/cluster-set.png" alt-text="Diagram showing a cluster set." lightbox="media/cluster-set/cluster-set.png":::

The following provides a summary of each of the elements shown:

### Management cluster

The management cluster hosts the highly-available management plane and the namespace referral scale-out file server (SOFS) for the cluster set. A management cluster is logically decoupled from individual member clusters that run VM workloads. This makes the cluster set management plane resilient to any localized cluster-wide failures, such as loss of power of a member cluster.

### Cluster set namespace referral SOFS

A namespace for the cluster set is provided with an SOFS server role running on the management cluster. This is similar to a Distributed File System Namespace (DFSN). Unlike DFSN however, cluster set namespace referral metadata is auto-populated on all cluster nodes without any intervention, so there's almost no performance overhead in the storage access path. This lightweight referral mechanism doesn't participate in the I/O path.

Each Server Message Block (SMB) referral share on the cluster set namespace referral SOFS is of type `SimpleReferral`. This referral allows SMB clients access to the target SMB share hosted on the member cluster SOFS. Referrals are cached perpetually on each of the client nodes and the cluster set namespace dynamically updates the referrals as needed automatically. Referral information is persistently cached in each cluster set node, even during reboots.

### Cluster set master

Communication between member clusters is loosely coupled and coordinated by the cluster set master (CS-Master) resource. Like other cluster set resources, CS-Master is highly available and resilient to individual member cluster failures or management cluster node failures. Through a cluster set WMI provider, CS-Master provides the management endpoint for all cluster set management actions.

### Member cluster

A member cluster runs VM and Storage Spaces Direct workloads. Multiple member clusters participate in a cluster set deployment, forming the larger SDDC cloud fabric. Member clusters differ from the management cluster in two key aspects: member clusters participate in fault domain and availability set constructs, and member clusters are sized to host VM and Storage Spaces Direct workloads. VMs that move across member clusters aren't hosted on the management cluster for this reason.

### Cluster set worker

The CS-Master interacts with a cluster resource on member clusters called the cluster set worker (CS-Worker). CS-Worker responds to requests by the CS-Master, including VM placement and resource inventorying. There's one CS-Worker instance per member cluster.

### Fault domain

A fault domain is a group of hardware and software that could fail together. While you could designate one or more clusters together as a fault domain, each node could participate in a fault domain in an availability set. Fault domain boundaries are based on data center topology, networking architecture, and other considerations.

### Availability set

An availability set is used to configure the desired redundancy of clustered workloads across fault domains by grouping and deploying workloads. For a two-tier application, you should configure at least two VMs in an availability set for each tier, which ensures that when a fault domain in an availability set goes down, your application will have at least one VM in each tier hosted on a different fault domain.

## Create a cluster set

Use PowerShell within the following example workflow to create a cluster set using two clusters. The name of the cluster set here is **CSMASTER**.

   | Cluster name | Infrastructure SOFS name |
   |--------------|-------------------------------------------|
   | SET-CLUSTER  | SOFS-CLUSTERSET                           |
   | CLUSTER1     | SOFS-CLUSTER1                             |
   | CLUSTER2     | SOFS-CLUSTER2                             |

1. Use a management client computer running Windows Server 2022 or Windows Server 2019.
1. Install Failover Cluster tools on the management cluster server.
1. Create two cluster members and with at least two Cluster Shared Volumes (CSVs) in each cluster.
1. Create a management cluster (physical or guest) that straddles the member clusters. This ensures that the cluster set management plane continues to be available despite possible member cluster failures.
1. To create the cluster set:

    ```PowerShell
    New-ClusterSet -Name CSMASTER -NamespaceRoot SOFS-CLUSTERSET -CimSession SET-CLUSTER
    ```
   > [!NOTE]
   > If you are using a static IP address, you must include *-StaticAddress x.x.x.x* on the **New-ClusterSet** command.

1. To add cluster members to the cluster set:

    ```PowerShell
    Add-ClusterSetMember -ClusterName CLUSTER1 -CimSession CSMASTER -InfraSOFSName SOFS-CLUSTER1
    Add-ClusterSetMember -ClusterName CLUSTER2 -CimSession CSMASTER -InfraSOFSName SOFS-CLUSTER2
    ```

1. To enumerate all member clusters in the cluster set:

    ```PowerShell
    Get-ClusterSetMember -CimSession CSMASTER
    ```

1. To enumerate all the member clusters in the cluster set including the management cluster nodes:

    ```PowerShell
    Get-ClusterSet -CimSession CSMASTER | Get-Cluster | Get-ClusterNode
    ```

1. To list all server nodes from all member clusters:

    ```PowerShell
    Get-ClusterSetNode -CimSession CSMASTER
    ```

1. To list all resource groups across the cluster set:

    ```PowerShell
    Get-ClusterSet -CimSession CSMASTER | Get-Cluster | Get-ClusterGroup
    ```

1. To verify the cluster set contains one SMB share (`ScopeName` being the Infrastructure File Server name) on the infrastructure SOFS for each cluster member CSV volume:

    ```PowerShell
    Get-SmbShare -CimSession CSMASTER
    ```

1. Review the cluster set debug log files for the cluster set, the management cluster, and each cluster member:

    ```PowerShell
    Get-ClusterSetLog -ClusterSetCimSession CSMASTER -IncludeClusterLog -IncludeManagementClusterLog -DestinationFolderPath <path>
    ```

1. Configure [Kerberos with constrained delegation](https://techcommunity.microsoft.com/t5/virtualization/live-migration-via-constrained-delegation-with-kerberos-in/ba-p/382334) between all cluster set members.

1. Configure the cross-cluster VM live migration authentication type to Kerberos on each node in the cluster set:

    ```PowerShell
    foreach($h in $hosts){ Set-VMHost -VirtualMachineMigrationAuthenticationType Kerberos -ComputerName $h }
    ```

1. Add the management cluster to the local administrators group on each cluster member server node in the cluster set:

    ```PowerShell
    foreach($h in $hosts){ Invoke-Command -ComputerName $h -ScriptBlock {Net localgroup administrators /add <management_cluster_name>$} }
    ```

## Create cluster set VMs

After creating the cluster set, the next step is to create VMs. You should perform the following checks beforehand:

- Check available memory on each cluster server node
- Check available disk space on each cluster server node
- Check any specific VM storage requirements in terms of speed and performance

The `Get-ClusterSetOptimalNodeForVM` command identifies the optimal cluster and node in the cluster set and then deploys the VM on it. In the following example, a new VM is created with:

- 4 GB available
- One virtual processor
- 10% minimum CPU available

```PowerShell
# Identify the optimal node to create a new virtual machine
$memoryinMB=4096
$vpcount = 1
$targetnode = Get-ClusterSetOptimalNodeForVM -CimSession CSMASTER -VMMemory $memoryinMB -VMVirtualCoreCount $vpcount -VMCpuReservation 10
$secure_string_pwd = convertto-securestring "<password>" -asplaintext -force
$cred = new-object -typename System.Management.Automation.PSCredential ("<domain\account>",$secure_string_pwd)

# Deploy the virtual machine on the optimal node
Invoke-Command -ComputerName $targetnode.name -scriptblock { param([String]$storagepath); New-VM CSVM1 -MemoryStartupBytes 3072MB -path $storagepath -NewVHDPath CSVM.vhdx -NewVHDSizeBytes 4194304 } -ArgumentList @("\\SOFS-CLUSTER1\VOLUME1") -Credential $cred | Out-Null

Start-VM CSVM1 -ComputerName $targetnode.name | Out-Null
Get-VM CSVM1 -ComputerName $targetnode.name | fl State, ComputerName
```

When complete, you are shown which cluster node the VM was deployed on. For the above example, it would show as:

```
State         : Running
ComputerName  : 1-S2D2
```

If there's not enough memory, CPU capacity, or disk space available to add the VM, you'll receive the following error:

```
Get-ClusterSetOptimalNodeForVM : A cluster node isn't available for this operation.
```

Once the VM is created, it is displayed in Hyper-V manager on the specific node specified. To add it as a cluster set VM and add it to the cluster, use this command:

```PowerShell
Register-ClusterSetVM -CimSession CSMASTER -MemberName $targetnode.Member -VMName CSVM1
```

When complete, the output is:

```
Id  VMName  State  MemberName  PSComputerName
--  ------  -----  ----------  --------------
 1  CSVM1     On   CLUSTER1    CSMASTER
```

If you've created a cluster using existing VMs, the VMs need to be registered with the cluster set. To register all VMs at once, use:

```PowerShell
Get-ClusterSetMember -Name CLUSTER3 -CimSession CSMASTER | Register-ClusterSetVM -RegisterAll -CimSession CSMASTER
```

Next, add the VM path to the cluster set namespace.

As an example, suppose an existing cluster is added to the cluster set with pre-configured VMs that reside on the local Cluster Shared Volume (CSV). The path for the VHDX would be something similar to `C:\ClusterStorage\Volume1\MYVM\Virtual Hard Disks\MYVM.vhdx1`.

A storage migration is needed, as CSV paths are by design local to a single member cluster and are therefore not accessible to the VM once they are live migrated across member clusters.

In this example, CLUSTER3 is added to the cluster set using `Add-ClusterSetMember` with the scale-out file server SOFS-CLUSTER3. To move the VM configuration and storage, the command is:

```PowerShell
Move-VMStorage -DestinationStoragePath \\SOFS-CLUSTER3\Volume1 -Name MyVM
```

Once complete, you may receive a warning:

```
WARNING: There were issues updating the virtual machine configuration that may prevent the virtual machine from running. For more information view the report file below.
WARNING: Report file location: C:\Windows\Cluster\Reports\Update-ClusterVirtualMachineConfiguration '' on date at time.htm.
```

This warning may be ignored as there were no physical changes in the virtual machine role storage configuration. The actual physical location doesn't change; only the configuration paths do.

For more information on `Move-VMStorage`, see [Move-VMStorage](/powershell/module/hyper-v/move-vmstorage).

Live migrating a VM within a cluster set involves the following:

```PowerShell
Set-VMHost -UseAnyNetworkForMigration $true
```

Then, to move a cluster set VM from CLUSTER1 to NODE2-CL3 on CLUSTER3 for example, the command would be:

```PowerShell
Move-ClusterSetVM -CimSession CSMASTER -VMName CSVM1 -Node NODE2-CL3
```

This command doesn't move the VM storage or configuration files and isn't necessary as the path to the VM remains as \\\\SOFS-CLUSTER1\VOLUME1. Once a VM has been registered with the infrastructure file server share path, the drives and VM don't require being on the same node as the VM.

## Create the infrastructure scale-out file server

There's one Infrastructure SOFS cluster role on a cluster. The Infrastructure SOFS role is created by specifying the `-Infrastructure` switch parameter to the `Add-ClusterScaleOutFileServerRole` cmdlet. For example:

 ```PowerShell
 Add-ClusterScaleoutFileServerRole -Name "my_infra_sofs_name" -Infrastructure
```

Each CSV volume created automatically triggers the creation of an SMB share with an auto-generated name based on the CSV volume name. You can't directly create or modify SMB shares under an SOFS role, other than by using CSV volume create and modify operations.

In hyperconverged configurations, an Infrastructure SOFS allows an SMB client (Hyper-V host) to communicate with continuous availability (CA) to the Infrastructure SOFS SMB server. This hyper-converged SMB loopback CA is achieved by VMs accessing their virtual disk (VHDX) files where the owning VM identity is forwarded between the client and server. This identity forwarding allows the use of ACLs for VHDx files just as in standard hyperconverged cluster configurations as before.

Once a cluster set is created, the cluster set namespace relies on an Infrastructure SOFS on each of the member clusters, and additionally an Infrastructure SOFS in the management cluster.

At the time a member cluster is added to a cluster set, you can specify the name of an Infrastructure SOFS on that cluster if one already exists. If the Infrastructure SOFS doesn't exist, a new Infrastructure SOFS role on the new member cluster is created. If an Infrastructure SOFS role already exists on the member cluster, the Add operation implicitly renames it to the specified name as needed. Any existing SMB servers, or non-infrastructure SOFS roles on the member clusters, aren't used by the cluster set.

When the cluster set is created, you have the option to use an existing AD computer object as the namespace root on the management cluster. Cluster set creation creates the Infrastructure SOFS cluster role on the management cluster or renames the existing Infrastructure SOFS role. The Infrastructure SOFS on the management cluster is used as the cluster set namespace referral SOFS.

## Create fault domains and availability sets

Azure-like fault domains and availability sets can be configured in a cluster set. This is beneficial for initial VM placements and migrations between clusters.

The example below has four clusters in a cluster set. Within the set, one fault domain is created with two of the clusters and a second fault domain is created with the other two clusters. These two fault domains comprise the availability set.

In the example below, CLUSTER1 and CLUSTER2 are in the fault domain **FD1** and CLUSTER3 and CLUSTER4 are in the fault domain **FD2**. The availability set is **CSMASTER-AS**.

To create the fault domains, the commands are:

```PowerShell
New-ClusterSetFaultDomain -Name FD1 -FdType Logical -CimSession CSMASTER -MemberCluster CLUSTER1,CLUSTER2 -Description "First fault domain"

New-ClusterSetFaultDomain -Name FD2 -FdType Logical -CimSession CSMASTER -MemberCluster CLUSTER3,CLUSTER4 -Description "Second fault domain"
```

To ensure they've been created successfully, `Get-ClusterSetFaultDomain` can be run with its output shown for FD1:

```PowerShell
PS C:\> Get-ClusterSetFaultDomain -CimSession CSMASTER -FdName FD1 | fl *

PSShowComputerName    : True
FaultDomainType       : Logical
ClusterName           : {CLUSTER1, CLUSTER2}
Description           : First fault domain
FDName                : FD1
Id                    : 1
PSComputerName        : CSMASTER
```

Now that the fault domains have been created, the availability set is created:

```PowerShell
New-ClusterSetAvailabilitySet -Name CSMASTER-AS -FdType Logical -CimSession CSMASTER -ParticipantName FD1,FD2
```

To validate it has been created, use:

```PowerShell
Get-ClusterSetAvailabilitySet -AvailabilitySetName CSMASTER-AS -CimSession CSMASTER
```

When creating new VMs, use the `-AvailabilitySet` parameter to determine the optimal node for placement. Here's an example:

```PowerShell
# Identify the optimal node to create a new VM
$memoryinMB=4096
$vpcount = 1
$av = Get-ClusterSetAvailabilitySet -Name CSMASTER-AS -CimSession CSMASTER
$targetnode = Get-ClusterSetOptimalNodeForVM -CimSession CSMASTER -VMMemory $memoryinMB -VMVirtualCoreCount $vpcount -VMCpuReservation 10 -AvailabilitySet $av
$secure_string_pwd = convertto-securestring "<password>" -asplaintext -force
$cred = new-object -typename System.Management.Automation.PSCredential ("<domain\account>",$secure_string_pwd)
```

## Remove a cluster from a set

There are times when a cluster needs to be removed from a cluster set. As a best practice, all cluster set VMs should be moved out of the cluster beforehand. This can be done using the `Move-ClusterSetVM` and `Move-VMStorage` commands.

If the VMs aren't moved out of the cluster first, all remaining cluster set VMs hosted on the cluster being removed will become highly available VMs bound to that cluster, assuming they have access to their storage. Cluster sets also automatically update their inventory by no longer tracking the health of a removed cluster and the VMs running on it, and by removing the namespace and all references to shares hosted on the removed cluster.

For example, the command to remove the CLUSTER1 cluster from a cluster set is:

```PowerShell
Remove-ClusterSetMember -ClusterName CLUSTER1 -CimSession CSMASTER
```

## System state backup

System state backup will back up the cluster state and metadata. Using Windows Server Backup, you can restore just a node's cluster database if needed or do an authoritative restore to roll back the entire cluster database across all nodes. For cluster sets, we recommend doing an authoritative restore first for the member clusters and then for the management cluster. For more information on system state backup, see [Back up system state and bare metal](/system-center/dpm/back-up-system-state-and-bare-metal).

## Next steps

- Learn more about [Storage Replica](/windows-server/storage/storage-replica/storage-replica-overview).
