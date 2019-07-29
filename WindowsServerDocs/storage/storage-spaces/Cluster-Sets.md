---
title: Cluster Sets
ms.prod: windows-server-threshold
ms.manager: eldenc
ms.technology: storage-spaces
ms.topic: article
author: johnmarlin-msft
ms.date: 01/30/2019
description: This article describes the Cluster sets scenario
ms.localizationpriority: medium
---
# Cluster sets

> Applies to: Windows Server 2019

Cluster sets is the new cloud scale-out technology in the Windows Server 2019 release that increases cluster node count in a single Software Defined Data Center (SDDC) cloud by orders of magnitude. A cluster set is a loosely-coupled grouping of multiple Failover Clusters: compute, storage or hyper-converged. Cluster sets technology enables virtual machine fluidity across member clusters within a cluster set and a unified storage namespace across the set in support of virtual machine fluidity.

While preserving existing Failover Cluster management experiences on member clusters, a cluster set instance additionally offers key use cases around lifecycle management at the aggregate. This Windows Server 2019 Scenario Evaluation Guide provides you the necessary background information along with step-by-step instructions to evaluate cluster sets technology using PowerShell.

## Technology introduction

Cluster sets technology is developed to meet specific customer requests operating Software Defined Datacenter (SDDC) clouds at scale. Cluster sets value proposition may be summarized as the following:  

- Significantly increase the supported SDDC cloud scale for running highly available virtual machines by combining multiple smaller clusters into a single large fabric, even while keeping the software fault boundary to a single cluster
- Manage entire Failover Cluster lifecycle including onboarding and retiring clusters, without impacting tenant virtual machine availability, via fluidly migrating virtual machines across this large fabric
- Easily change the compute-to-storage ratio in your hyper-converged I
- Benefit from [Azure-like Fault Domains and Availability sets](htttps://docs.microsoft.com/azure/virtual-machines/windows/manage-availability) across clusters in initial virtual machine placement and subsequent virtual machine migration
- Mix-and-match different generations of CPU hardware into the same cluster set fabric, even while keeping individual fault domains homogenous for maximum efficiency.  Please note that the recommendation of same hardware is still present within each individual cluster as well as the entire cluster set.

From a high level view, this is what cluster sets can look like.

![Cluster sets solution View](media/Cluster-sets-Overview/Cluster-sets-solution-View.png)

The following provides a quick summary of each of the elements in the above image:

**Management cluster**

Management cluster in a cluster set is a Failover Cluster that hosts the highly-available management plane of the entire cluster set and the unified storage namespace (Cluster Set Namespace) referral Scale-Out File Server (SOFS). A management cluster is logically decoupled from member clusters that run the virtual machine workloads. This makes the cluster set management plane resilient to any localized cluster-wide failures, e.g. loss of power of a member cluster.   

**Member cluster**

A member cluster in a cluster set is typically a traditional hyper-converged cluster running virtual machine and Storage Spaces Direct workloads. Multiple member clusters participate in a single cluster set deployment, forming the larger SDDC cloud fabric. Member clusters differ from a management cluster in two key aspects: member clusters participate in fault domain and availability set constructs, and member clusters are also sized to host virtual machine and Storage Spaces Direct workloads. Cluster set virtual machines that move across cluster boundaries in a cluster set must not be hosted on the management cluster for this reason.

**Cluster set namespace referral SOFS**

A cluster set namespace referral (Cluster Set Namespace) SOFS is a Scale-Out File Server wherein each SMB Share on the Cluster Set Namespace SOFS is a referral share – of type ‘SimpleReferral’ newly introduced in Windows Server 2019. This referral allows Server Message Block (SMB) clients access to the target SMB share hosted on the member cluster SOFS. The cluster set namespace referral SOFS is a light-weight referral mechanism and as such, does not participate in the I/O path. The SMB referrals are cached perpetually on the each of the client nodes and the cluster sets namespace dynamically updates automatically these referrals as needed.

**Cluster set master**

In a cluster set, the communication between the member clusters is loosely coupled, and is coordinated by a new cluster resource called “Cluster Set Master” (CS-Master). Like any other cluster resource, CS-Master is highly available and resilient to individual member cluster failures and/or the management cluster node failures. Through a new Cluster Set WMI provider, CS-Master provides the management endpoint for all Cluster Set manageability interactions.

**Cluster set worker**

In a Cluster Set deployment, the CS-Master interacts with a new cluster resource on the member Clusters called “Cluster Set Worker” (CS-Worker). CS-Worker acts as the only liaison on the cluster to orchestrate the local cluster interactions as requested by the CS-Master. Examples of such interactions include virtual machine placement and cluster-local resource inventorying. There is only one CS-Worker instance for each of the member clusters in a cluster set. 

**Fault domain**

A fault domain is the grouping of software and hardware artifacts that the administrator determines could fail together when a failure does occur.  While an administrator could designate one or more clusters together as a fault domain, each node could participate in a fault domain in an availability set. Cluster sets by design leaves the decision of fault domain boundary determination to the administrator who is well-versed with data center topology considerations – e.g. PDU, networking – that member clusters share. 

**Availability set**

An availability set helps the administrator configure desired redundancy of clustered workloads across fault domains, by organizing those into an availability set and deploying workloads into that availability set. Let’s say if you are deploying a two-tier application, we recommend that you configure at least two virtual machines in an availability set for each tier which will ensure that when one fault domain in that availability set goes down, your application will at least have one virtual machine in each tier hosted on a different fault domain of that same availability set.

## Why use cluster sets

Cluster sets provides the benefit of scale without sacrificing resiliency.  

Cluster sets allows for clustering multiple clusters together to create a large fabric, while each cluster remains independent for resiliency.  For example, you have a several 4-node HCI clusters running virtual machines.  Each cluster provides the resiliency needed for itself.  If the storage or memory starts to fill up, scaling up is your next step.  With scaling up, there are some options and considerations.

1. Add more storage to the current cluster.  With Storage Spaces Direct, this may be tricky as the exact same model/firmware drives may not be available.  The consideration of rebuild times also need to be taken into account.
2. Add more memory.  What if you are maxed out on the memory the machines can handle?  What if all available memory slots are full?
3. Add additional compute nodes with drives into the current cluster.  This takes us back to Option 1 needing to be considered.
4. Purchase a whole new cluster

This is where cluster sets provides the benefit of scaling.  If I add my clusters into a cluster set, I can take advantage of storage or memory that may be available on another cluster without any additional purchases.  From a resiliency perspective, adding additional nodes to a Storage Spaces Direct is not going to provide additional votes for quorum.  As mentioned [here](drive-symmetry-considerations.md), a Storage Spaces Direct Cluster can survive the loss of 2 nodes before going down.  If you have a 4-node HCI cluster, 3 nodes go down will take the entire cluster down.  If you have an 8-node cluster, 3 nodes go down will take the entire cluster down.  With Cluster sets that has two 4-node HCI clusters in the set, 2 nodes in one HCI go down and 1 node in the other HCI go down, both clusters remain up.  Is it better to create one large 16-node Storage Spaces Direct cluster or break it down into four 4-node clusters and use cluster sets?  Having four 4-node clusters with cluster sets gives the same scale, but better resiliency in that multiple compute nodes can go down (unexpectedly or for maintenance) and production remains.

## Considerations for deploying cluster sets

When considering if cluster sets is something you need to use, consider these questions:

- Do you need to go beyond the current HCI compute and storage scale limits?
- Are all compute and storage not identically the same?
- Do you live migrate virtual machines between clusters?
- Would you like Azure-like computer availability sets and fault domains across multiple clusters?
- Do you need to take the time to look at all your clusters to determine where any new virtual machines need to be placed?

If your answer is yes, then cluster sets is what you need.

There are a few other items to consider where a larger SDDC might change your overall data center strategies.  SQL Server is a good example.  Does moving SQL Server virtual machines between clusters require licensing SQL to run on additional nodes?  

## Scale-out file server and cluster sets

In Windows Server 2019, there is a new scale-out file server role called Infrastructure Scale-Out File Server (SOFS). 

The following considerations apply to an Infrastructure SOFS role:

1.	There can be at most only one Infrastructure SOFS cluster role on a Failover Cluster. Infrastructure SOFS role is created by specifying the "**-Infrastructure**" switch parameter to the **Add-ClusterScaleOutFileServerRole** cmdlet.  For example:

        Add-ClusterScaleoutFileServerRole -Name "my_infra_sofs_name" -Infrastructure

2.	Each CSV volume created in the failover automatically triggers the creation of an SMB Share with an auto-generated name based on the CSV volume name. An administrator cannot directly create or modify SMB shares under an SOFS role, other than via CSV volume create/modify operations.

3.	In hyper-converged configurations, an Infrastructure SOFS allows an SMB client (Hyper-V host) to communicate with guaranteed Continuous Availability (CA) to the Infrastructure SOFS SMB server. This hyper-converged SMB loopback CA is achieved via virtual machines accessing their virtual disk (VHDx) files where the owning virtual machine identity is forwarded between the client and server. This identity forwarding allows ACL-ing VHDx files just as in standard hyper-converged cluster configurations as before.

Once a cluster set is created, the cluster set namespace relies on an Infrastructure SOFS on each of the member clusters, and additionally an Infrastructure SOFS in the management cluster.

At the time a member cluster is added to a cluster set, the administrator specifies the name of an Infrastructure SOFS on that cluster if one already exists. If the Infrastructure SOFS does not exist, a new Infrastructure SOFS role on the new member cluster is created by this operation. If an Infrastructure SOFS role already exists on the member cluster, the Add operation implicitly renames it to the specified name as needed. Any existing singleton SMB servers, or non-Infrastructure SOFS roles on the member clusters are left unutilized by the cluster set. 

At the time the cluster set is created, the administrator has the option to use an already-existing AD computer object as the namespace root on the management cluster. Cluster set creation operations create the Infrastructure SOFS cluster role on the management cluster or renames the existing Infrastructure SOFS role just as previously described for member clusters. The Infrastructure SOFS on the management cluster is used as the cluster set namespace referral (Cluster Set Namespace) SOFS. It simply means that each SMB Share on the cluster set namespace SOFS is a referral share – of type ‘SimpleReferral’ - newly introduced in Windows Server 2019.  This referral allows SMB clients access to the target SMB share hosted on the member cluster SOFS. The cluster set namespace referral SOFS is a light-weight referral mechanism and as such, does not participate in the I/O path. The SMB referrals are cached perpetually on the each of the client nodes and the cluster sets namespace dynamically updates automatically these referrals as needed

## Creating a Cluster Set

### Prerequisites

When creating a cluster set, you following prerequisites are recommended:

1. Configure a management client running Windows Server 2019.
2. Install the Failover Cluster tools on this management server.
3. Create cluster members (at least two clusters with at least two Cluster Shared Volumes on each cluster)
4. Create a management cluster (physical or guest) that straddles the member clusters.  This approach ensures that the Cluster sets management plane continues to be available despite possible member cluster failures.

### Steps

1. Create a new cluster set from three clusters as defined in the prerequisites.  The below chart gives an example of clusters to create.  The name of the cluster set in this example will be **CSMASTER**.

   | Cluster Name               | Infrastructure SOFS Name to be used later | 
   |----------------------------|-------------------------------------------|
   | SET-CLUSTER                | SOFS-CLUSTERSET                           |
   | CLUSTER1                   | SOFS-CLUSTER1                             |
   | CLUSTER2                   | SOFS-CLUSTER2                             |

2. Once all cluster have been created, use the following commands to create the cluster set master.

        New-ClusterSet -Name CSMASTER -NamespaceRoot SOFS-CLUSTERSET -CimSession SET-CLUSTER

3. To add a Cluster Server to the cluster set, the below would be used.

        Add-ClusterSetMember -ClusterName CLUSTER1 -CimSession CSMASTER -InfraSOFSName SOFS-CLUSTER1
        Add-ClusterSetMember -ClusterName CLUSTER2 -CimSession CSMASTER -InfraSOFSName SOFS-CLUSTER2

   > [!NOTE]
   > If you are using a static IP Address scheme, you must include *-StaticAddress x.x.x.x* on the **New-ClusterSet** command.

4. Once you have created the cluster set out of cluster members, you can list the nodes set and its properties.  To enumerate all the member clusters in the cluster set:

        Get-ClusterSetMember -CimSession CSMASTER

5. To enumerate all the member clusters in the cluster set including the management cluster nodes:

        Get-ClusterSet -CimSession CSMASTER | Get-Cluster | Get-ClusterNode

6. To list all the nodes from the member clusters:

        Get-ClusterSetNode -CimSession CSMASTER

7. To list all the resource groups across the cluster set:

        Get-ClusterSet -CimSession CSMASTER | Get-Cluster | Get-ClusterGroup 

8. To verify the cluster set creation process created one SMB share (identified as Volume1 or whatever the CSV folder is labeled with the ScopeName being the name of the Infrastructure File Server and the path as both) on the Infrastructure SOFS for each cluster member's CSV volume:

        Get-SmbShare -CimSession CSMASTER

8. Cluster sets has debug logs that can be collected for review.  Both the cluster set and cluster debug logs can be gathered for all members and the management cluster.

        Get-ClusterSetLog -ClusterSetCimSession CSMASTER -IncludeClusterLog -IncludeManagementClusterLog -DestinationFolderPath <path>

9. Configure Kerberos [constrained delegation](https://blogs.technet.microsoft.com/virtualization/2017/02/01/live-migration-via-constrained-delegation-with-kerberos-in-windows-server-2016/) between all cluster set members.

10. Configure the cross-cluster virtual machine live migration authentication type to Kerberos on each node in the Cluster Set.

        foreach($h in $hosts){ Set-VMHost -VirtualMachineMigrationAuthenticationType Kerberos -ComputerName $h }

11. Add the management cluster to the local administrators group on each node in the cluster set.

        foreach($h in $hosts){ Invoke-Command -ComputerName $h -ScriptBlock {Net localgroup administrators /add <management_cluster_name>$} }

## Creating new virtual machines and adding to cluster sets

After creating the cluster set, the next step is to create new virtual machines.  Normally, when it is time to create virtual machines and add them to a cluster, you need to do some checks on the clusters to see which it may be best to run on.  These checks could include:

- How much memory is available on the cluster nodes?
- How much disk space is available on the cluster nodes?
- Does the virtual machine require specific storage requirements (i.e. I want my SQL Server virtual machines to go to a cluster running faster drives; or, my infrastructure virtual machine is not as critical and can run on slower drives).

Once this questions are answered, you create the virtual machine on the cluster you need it to be.  One of the benefits of cluster sets is that cluster sets do those checks for you and place the virtual machine on the most optimal node.

The below commands will both identify the optimal cluster and deploy the virtual machine to it.  In the below example, a new virtual machine is created specifying that at least 4 gigabytes of memory is available for the virtual machine and that it will need to utilize 1 virtual processor.

- ensure that 4gb is available for the virtual machine
- set the virtual processor used at 1
- check to ensure there is at least 10% CPU available for the virtual machine

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

When it completes, you will be given the information about the virtual machine and where it was placed.  In the above example, it would show as:

        State         : Running
        ComputerName  : 1-S2D2

If you were to not have enough memory, cpu, or disk space to add the virtual machine, you will receive the error:

      Get-ClusterSetOptimalNodeForVM : A cluster node is not available for this operation.  

Once the virtual machine has been created, it will be displayed in Hyper-V manager on the specific node specified.  To add it as a cluster set virtual machine and into the cluster, the command is below.  

        Register-ClusterSetVM -CimSession CSMASTER -MemberName $targetnode.Member -VMName CSVM1

When it completes, the output will be:

         Id  VMName  State  MemberName  PSComputerName
         --  ------  -----  ----------  --------------
          1  CSVM1      On  CLUSTER1    CSMASTER

If you have added a cluster with existing virtual machines, the virtual machines will also need to be registered with Cluster sets so register all the virtual machines at once, the command to use is:

        Get-ClusterSetMember -name CLUSTER3 -CimSession CSMASTER | Register-ClusterSetVM -RegisterAll -CimSession CSMASTER

However, the process is not complete as the path to the virtual machine needs to be added to the cluster set namespace.

So for example, an existing cluster is added and it has pre-configured virtual machines the reside on the local Cluster Shared Volume (CSV), the path for the VHDX would be something similar to "C:\ClusterStorage\Volume1\MYVM\Virtual Hard Disks\MYVM.vhdx.  A storage migration would need to be accomplished as CSV paths are by design local to a single member cluster. Thus, will not be accessible to the virtual machine once they are live migrated across member clusters. 

In this example, CLUSTER3 was added to the cluster set using Add-ClusterSetMember with the Infrastructure Scale-Out File Server as SOFS-CLUSTER3.  To move the virtual machine configuration and storage, the command is:

        Move-VMStorage -DestinationStoragePath \\SOFS-CLUSTER3\Volume1 -Name MYVM

Once it completes, you will receive a warning:

        WARNING: There were issues updating the virtual machine configuration that may prevent the virtual machine from running.  For more information view the report file below.
        WARNING: Report file location: C:\Windows\Cluster\Reports\Update-ClusterVirtualMachineConfiguration '' on date at time.htm.

This warning can be ignored as the warning is "No changes in the virtual machine role storage configuration were detected".  The reason for the warning as the actual physical location does not change; only the configuration paths. 

For more information on Move-VMStorage, please review this [link](https://docs.microsoft.com/powershell/module/hyper-v/move-vmstorage?view=win10-ps). 

Live migrating a virtual machine between different cluster set clusters is not the same as in the past. In non-cluster set scenarios, the steps would be:

1. remove the virtual machine role from the Cluster.
2. live migrate the virtual machine to a member node of a different cluster.
3. add the virtual machine into the cluster as a new virtual machine role.

With Cluster sets these steps are not necessary and only one command is needed.  First, you should set all networks to be available for the migration with the command:

	Set-VMHost -UseAnyNetworkMigration $true

For example, I want to move a Cluster Set virtual machine from CLUSTER1 to NODE2-CL3 on CLUSTER3.  The single command would be:

        Move-ClusterSetVM -CimSession CSMASTER -VMName CSVM1 -Node NODE2-CL3

Please note that this does not move the virtual machine storage or configuration files.  This is not necessary as the path to the virtual machine remains as \\SOFS-CLUSTER1\VOLUME1.  Once a virtual machine has been registered with cluster sets has the Infrastructure File Server share path, the drives and virtual machine do not require being on the same machine as the virtual machine.

## Creating Availability sets Fault Domains

As described in the introduction, Azure-like fault domains and availability sets can be configured in a cluster set.  This is beneficial for initial virtual machine placements and migrations between clusters.  

In the example below, there are four clusters participating in the cluster set.  Within the set, a logical fault domain will be created with two of the clusters and a fault domain created with the other two clusters.  These two fault domains will comprise the Availabiilty Set. 

In the example below, CLUSTER1 and CLUSTER2 will be in a fault domain called **FD1** while CLUSTER3 and CLUSTER4 will be in a fault domain called **FD2**.  The availability set will be called **CSMASTER-AS** and be comprised of the two fault domains.

To create the fault domains, the commands are:

        New-ClusterSetFaultDomain -Name FD1 -FdType Logical -CimSession CSMASTER -MemberCluster CLUSTER1,CLUSTER2 -Description "This is my first fault domain"

        New-ClusterSetFaultDomain -Name FD2 -FdType Logical -CimSession CSMASTER -MemberCluster CLUSTER3,CLUSTER4 -Description "This is my second fault domain"

To ensure they have been created successfully, Get-ClusterSetFaultDomain can be run with its output shown.

        PS C:\> Get-ClusterSetFaultDomain -CimSession CSMASTER -FdName FD1 | fl *

        PSShowComputerName    : True
        FaultDomainType       : Logical
        ClusterName           : {CLUSTER1, CLUSTER2}
        Description           : This is my first fault domain
        FDName                : FD1
        Id                    : 1
        PSComputerName        : CSMASTER

Now that the fault domains have been created, the availability set needs to be created.

        New-ClusterSetAvailabilitySet -Name CSMASTER-AS -FdType Logical -CimSession CSMASTER -ParticipantName FD1,FD2

To validate it has been created, then use:

        Get-ClusterSetAvailabilitySet -AvailabilitySetName CSMASTER-AS -CimSession CSMASTER

When creating new virtual machines, you would then need to use the -AvailabilitySet parameter as part of determining the optimal node.  So it would then look something like this:

        # Identify the optimal node to create a new virtual machine
        $memoryinMB=4096
        $vpcount = 1
        $av = Get-ClusterSetAvailabilitySet -Name CSMASTER-AS -CimSession CSMASTER
        $targetnode = Get-ClusterSetOptimalNodeForVM -CimSession CSMASTER -VMMemory $memoryinMB -VMVirtualCoreCount $vpcount -VMCpuReservation 10 -AvailabilitySet $av
        $secure_string_pwd = convertto-securestring "<password>" -asplaintext -force
        $cred = new-object -typename System.Management.Automation.PSCredential ("<domain\account>",$secure_string_pwd)

Removing a cluster from cluster sets due to various life cycles. There are times when a cluster needs to be removed from a cluster set. As a best practice, all cluster set virtual machines should be moved out of the cluster. This can be accomplished using the **Move-ClusterSetVM** and **Move-VMStorage** commands.

However, if the virtual machines will not be moved as well, cluster sets runs a series of actions to provide an intuitive outcome to the administrator.  When the cluster is removed from the set, all remaining cluster set virtual machines hosted on the cluster being removed will simply become highly available virtual machines bound to that cluster, assuming they have access to their storage.  Cluster sets will also automatically update its inventory by:

- No longer tracking the health of the now-removed cluster and the virtual machines running on it
- Removes from cluster set namespace and all references to shares hosted on the now-removed cluster

For example, the command to remove the CLUSTER1 cluster from cluster sets would be:

        Remove-ClusterSetMember -ClusterName CLUSTER1 -CimSession CSMASTER

## Frequently asked questions (FAQ)

**Question:** In my cluster set, am I limited to only using hyper-converged clusters? <br>
**Answer:** No.  You can mix Storage Spaces Direct with traditional clusters.

**Question:** Can I manage my Cluster Set via System Center Virtual Machine Manager? <br>
**Answer:** System Center Virtual Machine Manager does not currently support Cluster sets <br><br> **Question:** Can Windows Server 2012 R2 or 2016 clusters co-exist in the same cluster set? <br>
**Question:** Can I migrate workloads off Windows Server 2012 R2 or 2016 clusters by simply having those clusters join the same Cluster Set? <br>
**Answer:** Cluster sets is a new technology being introduced in Windows Server 2019, so as such, does not exist in previous releases. Down-level OS-based clusters cannot join a cluster set. However, Cluster Operating System rolling upgrades technology should provide the migration functionality that you are looking for by upgrading these clusters to Windows Server 2019.

**Question:** Can Cluster sets allow me to scale storage or compute (alone)? <br>
**Answer:** Yes, by simply adding a Storage Space Direct or traditional Hyper-V cluster. With cluster sets, it is a straightforward change of Compute-to-Storage ratio even in a hyper-converged cluster set.

**Question:** What is the management tooling for cluster sets <br>
**Answer:** PowerShell or WMI in this release.

**Question:** How will the cross-cluster live migration work with processors of different generations?  <br>
**Answer:** Cluster sets does not work around processor differences and supersede what Hyper-V currently supports.  Therefore, processor compatibility mode must be used with quick migrations.  The recommendation for Cluster sets is to use the same processor hardware within each individual Cluster as well as the entire Cluster Set for live migrations between clusters to occur.

**Question:** Can my cluster set virtual machines automatically failover on a cluster failure?  <br>
**Answer:** In this release, cluster set virtual machines can only be manually live-migrated across clusters; but cannot automatically failover. 

**Question:** How do we ensure storage is resilient to cluster failures? <br>
**Answer:** Use cross-cluster Storage Replica (SR) solution across member clusters to realize the storage resiliency to cluster failures.

**Question:** I use Storage Replica (SR) to replicate across member clusters. Do cluster set namespace storage UNC paths change on SR failover to the replica target Storage Spaces Direct cluster? <br>
**Answer:** In this release, such a cluster set namespace referral change does not occur with SR failover. Please let Microsoft know if this scenario is critical to you and how you plan to use it.

**Question:** Is it possible to failover virtual machines across fault domains in a disaster recovery situation (say the entire fault domain went down)? <br>
**Answer:** No, note that cross-cluster failover within a logical fault domain is not yet supported. 

**Question:** Can my cluster set span clusters in multiple sites (or DNS domains)? <br> 
**Answer:** This is an untested scenario and not immediately planned for production support. Please let Microsoft know if this scenario is critical to you and how you plan to use it.

**Question:** Does cluster set work with IPv6? <br>
**Answer:** Both IPv4 and IPv6 are supported with cluster sets as with Failover Clusters.

**Question:** What are the Active Directory Forest requirements for cluster sets <br>
**Answer:** All member clusters must be in the same AD forest.

**Question:** How many clusters or nodes can be part of a single cluster Set? <br>
**Answer:** In Windows Server 2019, cluster sets been tested and supported up to 64 total cluster nodes. However, cluster sets architecture scales to much larger limits and is not something that is hardcoded for a limit. Please let Microsoft know if larger scale is critical to you and how you plan to use it.

**Question:** Will all Storage Spaces Direct clusters in a cluster set form a single storage pool? <br>
**Answer:** No. Storage Spaces Direct technology still operates within a single cluster and not across member clusters in a cluster set.

**Question:** Is the cluster set namespace highly available? <br>
**Answer:** Yes, the cluster set namespace is provided via a Continuously Available (CA) referral SOFS namespace server running on the management cluster. Microsoft recommends having enough number of virtual machines from member clusters to make it resilient to localized cluster-wide failures. However, to account for unforeseen catastrophic failures – e.g. all virtual machines in the management cluster going down at the same time – the referral information is additionally persistently cached in each cluster set node, even across reboots.
 
**Question:** Does the cluster set namespace-based storage access slow down storage performance in a cluster set? <br>
**Answer:** No. Cluster set namespace offers an overlay referral namespace within a cluster set – conceptually like Distributed File System Namespaces (DFSN). And unlike DFSN, all cluster set namespace referral metadata is auto-populated and auto-updated on all nodes without any administrator intervention, so there is almost no performance overhead in the storage access path. 

**Question:** How can I backup cluster set metadata? <br>
**Answer:** This guidance is the same as that of Failover Cluster. The System State Backup will backup the cluster state as well.  Through Windows Server Backup, you can do restores of just a node's cluster database (which should never be needed because of a bunch of self-healing logic we have) or do an authoritative restore to roll back the entire cluster database across all nodes. In the case of cluster sets, Microsoft recommends doing such an authoritative restore first on the member cluster and then the management cluster if needed.
