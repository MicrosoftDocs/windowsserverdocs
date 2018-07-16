---
title: Cluster Sets
ms.prod: windows-server-threshold
ms.manager: eldenc
ms.technology: storage-spaces
ms.topic: article
author: johnmarlin-msft
ms.date: 06/25/2018
description: This article describes the Cluster sets scenario
ms.localizationpriority: medium
---

# Cluster Sets

> Applies To: Windows Server Insider Preview build 17650 and later

Cluster Sets is the new cloud scale-out technology in Windows Server 2019 that increases cluster node count in a single Software Defined Data Center (SDDC) cloud by orders of magnitude. A Cluster Set is a loosely-coupled grouping of multiple Failover Clusters: compute, storage or hyper-converged. Cluster Sets technology enables virtual machine fluidity across member clusters within a Cluster Set and a unified storage namespace across the set in support of virtual machine placement. 

Cluster Sets gives you the benefit of hyperscale while continuing to maintain great resiliency. While preserving existing Failover Cluster management experiences on member clusters, a Cluster Set instance additionally offers key use cases such as lifecycle management, virtual machine placement, etc. 

This Windows Server Server 2019 Scenario Evaluation Guide provides you the necessary background information along with step-by-step instructions to evaluate Cluster Sets technology using PowerShell. 

## Why use Cluster Sets

Cluster Sets provides the benefit of hyperscale without sacrificing resiliency.  

Cluster Sets allows for clustering multiple clusters together to create a larger fabric, while each cluster continues to remain independent for resiliency.  For example, you have a several 4-node hyper-converged infrastructure (HCI) clusters running virtual machines.  Each cluster provides the resiliency needed for itself.  If the storage or memory starts to fill up, scaling up is your next step.  With scaling up, there are some options and considerations.

1. Add more storage to the current cluster ensuring it is the same type (NVME, SSD, HDD, etc)
2. Add more memory.  What if you are maxed out on the memory the machines can handle?  What if all available memory slots are full?
3. Add additional compute nodes with drives into the current cluster.  This takes us back to Option 1 needing to be considered.
4. Purchase a whole new cluster

This is where Cluster Sets provides the benefit of scaling.  If I add my clusters into a Cluster Set, I can take advantage of storage or memory that may be available on another cluster without any additional purchases.  From a resiliency perspective, adding additional nodes to a Storage Spaces Direct is not going to provide additional votes for quorum.  As mentioned [here](https://docs.microsoft.com/windows-server/storage/storage-spaces/drive-symmetry-considerations), a Storage Spaces Direct Cluster can survive the loss of 2 nodes before going down.  If you have a 4-node HCI cluster, 3 nodes go down will take the entire cluster down.  If you have an 8-node cluster, 3 nodes go down will take the entire cluster down.  With Cluster Sets that has two 4-node HCI clusters in the set, 2 nodes in one HCI go down and 1 node in the other HCI go down, both clusters remain up.  Is it better to create one large 16-node Storage Spaces Direct cluster or break it down into four 4-node clusters and use Cluster Sets?  Having four 4-node clusters with Cluster Sets gives the same scale, but better resiliency in that multiple compute nodes can go down (unexpectedly or for maintenance) and production remains.

## Considerations for deploying Cluster Sets

When considering if Cluster Sets is something you need to use, consider these questions:

- Do you need to go beyond the current HCI compute and storage scale limits?
- Is hyperscale with the same resiliency important to you?
- Are all compute and storage not identically the same?
- Do you live migrate virtual machines between clusters?
- Would you like Azure-like computer availability sets and fault domains across multiple clusters?
- Do you need to take the time to look at all your clusters to determine where any new virtual machines need to be placed?

If your answer is yes, then Cluster Sets is what you need.

There are a few other items to consider where a larger SDDC might change your overall data center strategies.  SQL Server is a good example.  Does moving SQL Server virtual machines between clusters require licensing SQL to run on additional nodes?  

## Scale-out file server and Cluster Sets

In Windows Server 2019, there is a new scale-out file server role called Infrastructure Scale-Out File Server (SOFS). 

The following considerations apply to an Infrastructure SOFS role:

1. There can be at most only one Infrastructure SOFS cluster role on a Failover Cluster. Infrastructure SOFS role is created by specifying the "**-Infrastructure**" switch parameter to the **Add-ClusterScaleOutFileServerRole** cmdlet.  For example:

        Add-ClusterScaleoutFileServerRole -Name "my_infra_sofs_name" -Infrastructure

2. Each CSV volume created in the Failover Cluster automatically triggers the creation of an SMB Share with an auto-generated name based on the CSV volume name. An administrator cannot directly create or modify SMB shares under an SOFS role, other than via CSV volume create/modify operations.

3. In hyper-converged configurations, an Infrastructure SOFS allows an SMB client (Hyper-V host) to communicate with Continuous Availability (CA) to the Infrastructure SOFS SMB server. This hyper-converged SMB loopback CA is achieved via virtual machines accessing their virtual disk (VHDx) files where the owning virtual machine identity is forwarded between the client and server. This identity forwarding allows ACL-ing VHDx files just as in standard hyper-converged cluster configurations as before.  

4. It gives the benefit of moving virtual machines around without having to change storage location paths.  For example, you have a virtual machine running on one cluster and wish to move it to another.  The virtual machine is running on a cluster called CLUSTER1 and the virtual machine storage is on a different cluster called CLUSTER2.  The path to the VHDX would be defined as \\CLUSTER2SOFS\VOLUME1\VM\VM.VHDX. If you wanted to migrate the virtual machine to CLUSTER2, the VHDX path would never have to change.  The same would apply if you moved the virtual machine off of the current cluster to another.  Changing and specifying paths is always a big concern as you must ensure the path is proper before moves can take place in order for the virtual machine to remain up and successfully live migrate.

Once a cluster cet is created, the Cluster Set namespace relies on an Infrastructure SOFS on each of the member clusters, and additionally an Infrastructure SOFS on the Cluster Set head cluster.

At the time a member cluster is added to a Cluster Set, the administrator specifies the name of an Infrastructure SOFS on that cluster if one already exists. If the Infrastructure SOFS does not exist, a new Infrastructure SOFS role on the new member cluster is created by this operation. If an Infrastructure SOFS role already exists on the member cluster, the Add operation implicitly renames it to the specified name as needed. Any existing singleton SMB servers, or non-Infrastructure SOFS roles on the member clusters are left unutilized by the Cluster Set. 

At the time the Cluster Set is created, the administrator has the option to use an already-existing AD computer object as the namespace root on the head cluster. Cluster Set creation operations create the Infrastructure SOFS cluster role on the head cluster or renames the existing Infrastructure SOFS role just as previously described for member clusters. The Infrastructure SOFS on the head cluster is used as the Cluster Set namespace referral (Cluster Set Namespace) SOFS. It simply means that each SMB Share on the Cluster Set namespace SOFS is a referral share.  This referral allows SMB clients access to the target SMB share hosted on the member cluster SOFS. The Cluster Set namespace referral SOFS is a light-weight referral mechanism and as such, does not participate in the I/O path. The SMB referrals are cached perpetually on the each of the client nodes and the Cluster Sets namespace dynamically updates automatically these referrals as needed

## Technology introduction
Cluster Sets technology is developed to meet specific customer requests operating Software Defined Datacenter (SDDC) clouds at scale. Cluster Sets value proposition in Windows Server 2019 may be summarized as the following:  

- Significantly increase the supported SDDC cloud scale for running highly available virtual machines by combining multiple smaller clusters into a single large fabric, even while keeping the software fault boundary to a single cluster
- Manage entire Failover Cluster lifecycle including onboarding and retiring clusters, without impacting tenant virtual machine availability, via fluidly migrating virtual machines across this large fabric
- Easily change the compute-to-storage ratio in your hyper-converged infrastructure
- Benefit from [Azure-like Fault Domains and Availability sets](htttps://docs.microsoft.com/azure/virtual-machines/windows/manage-availability) across clusters in initial virtual machine placement and subsequent virtual machine migration
- Mix-and-match different generations of CPU hardware into the same Cluster Set fabric, even while keeping individual fault domains homogenous for maximum efficiency.  Please note that the recommendation of same hardware is still present within each individual cluster as well as the entire Cluster Set.

From a high level view, this is what cluster sets can look like.

![Cluster sets solution View](media\Cluster-sets-Overview\Cluster-Set-Overview.png)

The following provides a quick summary of each of the elements in the above image:

**Head cluster**

The head cluster in a Cluster Set is a Failover Cluster that hosts the highly-available centralized management of the entire Cluster Set and the unified namespace (Cluster Set Namespace) referral Scale-Out File Server (SOFS). A head cluster is logically separated from member clusters that run the virtual machine workloads. This makes Cluster Set management resilient to any localized cluster-wide failures, such as loss of power of a member cluster.   The head cluster can be on bare-metal or virtualized.  The recommendation is to have it as virtual machines unless you start getting to 5 or more clusters added to the set.

**Member cluster**

A member cluster in a Cluster Set is typically a traditional hyper-converged cluster running virtual machine and Storage Spaces Direct workloads. Multiple member clusters participate in a single Cluster Set deployment, forming the larger SDDC fabric. Member clusters differ from a head cluster in two key aspects: member clusters can participate in fault domain and availability set, and member clusters are also sized to host virtual machine and Storage Spaces Direct workloads. Cluster Set virtual machines that move across cluster boundaries in a Cluster Set must not be hosted on the head cluster for this reason.

**Cluster Set namespace referral SOFS**

A Cluster Set namespace referral (Cluster Set Namespace) SOFS is a Scale-Out File Server where each Server Message Block (SMB) share on the Cluster Set Namespace SOFS is a "referral" share.  This referral allows Server Message Block (SMB) clients access to the target share hosted on the member cluster. The SMB referrals are cached on the each of the client nodes and the Cluster Sets namespace dynamically updates these referrals as needed.

**Cluster Set master resource**

In a Cluster Set, the communication between the member clusters is coordinated by a new cluster resource called “Cluster Set Master”. Like any other cluster resource, Cluster Set Master is highly available and resilient to individual member cluster failures and/or the head cluster node failures. Through a new Cluster Set WMI provider, Cluster Set Master provides the management endpoint for all manageability interactions.  There is only one Cluster Set master for the entire Cluster Set.

**Cluster Set worker resource**

In a Cluster Set deployment, the Cluster Set Master interacts with a new cluster resource on the member Clusters called “Cluster Set Worker”. The Cluster Set Worker orchestrates the local cluster interactions as requested by the Cluster Set Master. Examples of such interactions include virtual machine placement and cluster-local resource inventorying. There is only one Cluster Set Worker instance for each of the member clusters in a Cluster Set. 

**Fault domain**

A fault domain is the grouping of software and hardware artifacts that the administrator determines could fail together when a failure does occur.  While an administrator could designate one or more clusters together as a fault domain, each node could participate in a fault domain in an availability set. Cluster Sets by design leaves the decision of fault domain boundary determination to the administrator who is well-versed with data center topology considerations. 

**Availability set**

An availability set helps the administrator configure desired redundancy of clustered workloads across fault domains, by organizing those into an availability aet and deploying workloads into that availability set.  For example, if you are deploying a two-tier application, we recommend that you configure at least two virtual machines in an availability set for each tier which will ensure that if one fault domain in that availability set goes down, your application will at least have one virtual machine in each tier hosted on a different fault domain of that same availability set.


## Creating a Cluster Set

### Prerequisites
When creating a Cluster Set, the following prerequisites are recommended:

1. Create cluster members (at least two nodes) that will act as the highly available head cluster.  This can be virtualized or bare-metal.
2. Create cluster members (at least two clusters with at least two Cluster Shared Volumes on each cluster) that will act as the worker clusters.  One of the Cluster Shared Volumes will be for the Cluster Set Worker Scale-out File Server and the other for holding virtual machines files (vhdx, configuration files, etc).


### Steps

The following steps can be used to create the Cluster Set and all members of the set.  In the below examples, all commands will be specified from the console of the head cluster (unless specified).

1. Create a new Cluster Set from three clusters as defined in the prerequisites.  The below chart gives an example of cluster names to create.  The names can be whatever fits in your organizational naming schemes.  The name of the Cluster Set in this example will be **CSMASTER**.

        | Cluster Name      | Infrastructure SOFS Name to be used later | 
        |-------------------|-------------------------------------------|
        | SETCLUSTER        | SOFSCLUSTERSET                            |
        | CLUSTER1          | SOFSCLUSTER1                              |
        | CLUSTER2          | SOFSCLUSTER2                              |

2. Once all clusters have been created, use the following commands to create the Cluster Set.

        New-ClusterSet -Name CSMASTER -NamespaceRoot SOFSCLUSTERSET

3. To add a Cluster Server to the Cluster Set, the below would be used.

        Add-ClusterSetMember -ClusterName CLUSTER1 -InfraSOFSName SOFSCLUSTER1
        Add-ClusterSetMember -ClusterName CLUSTER2 -InfraSOFSName SOFSCLUSTER2

**NOTE:**
If you are using a static IP Address scheme, you must include *-StaticAddress x.x.x.x* on the **New-ClusterSet** command.

4. Once you have created the Cluster Set out of cluster members, you can list the nodes set and its properties.  To enumerate all the member clusters in the Cluster Set:

        Get-ClusterSetMember 

5. To enumerate all the member clusters in the Cluster Set including the head cluster nodes:

        Get-ClusterSet | Get-Cluster | Get-ClusterNode

6. To list all the nodes from the member clusters:

        Get-ClusterSetNode 

7. To list all the resource groups across the Cluster Set:

        Get-ClusterSet | Get-Cluster | Get-ClusterGroup 

8. To verify the Cluster Set creation process created one SMB share (identified as Volume1 or whatever the CSV folder is labeled with the ScopeName being the name of the Infrastructure File Server and the path as both) on the Infrastructure SOFS for each cluster member's CSV volume:

        Get-SmbShare 

8. Cluster Sets has debug logs that can be collected for review.  Both the Cluster Set and cluster debug logs can be gathered for all members and the head cluster.

        Get-ClusterSetLog -IncludeClusterLog -IncludeManagementClusterLog -DestinationFolderPath <path>

9. Configure kerberos [constrained delegation](https://blogs.technet.microsoft.com/virtualization/2017/02/01/live-migration-via-constrained-delegation-with-kerberos-in-windows-server-2016/) between all Cluster Set members.

10. Configure the cross-cluster virtual machine live migration authentication type to Kerberos on each node in the Cluster Set.

        $hosts=(Get-ClusterSetNode)
        foreach($h in $hosts){ Set-VMHost -VirtualMachineMigrationAuthenticationType Kerberos -ComputerName $h }

11. Add the head cluster to the local administrators group on each node in the Cluster Set.

        $hosts=(Get-ClusterSetNode)
        foreach($h in $hosts){ Invoke-Command -ComputerName $h -ScriptBlock {Net localgroup administrators /add SETCLUSTER$} }

## Creating new virtual machines and adding to Cluster Sets

After creating the Cluster Set, the next step is to create new virtual machines.  Normally, when it is time to create virtual machines and add them to a cluster, you need to do some checks on the clusters to see which it may be best to run on.  These checks could include:

- How much memory is available on the cluster nodes?
- How much CPU utilization is available on the cluster nodes?
- Does the virtual machine require specific storage requirements (i.e. I want my SQL Server virtual machines to go to a cluster running faster drives; or, my infrastructure virtual machine is not as critical and can run on slower drives).

Once these questions are answered, you create the virtual machine on the cluster you need it to be.  One of the benefits of Cluster Sets is that Cluster Sets can do those checks for you and place the virtual machine on the most optimal node.

The below commands will both identify the optimal cluster and deploy the virtual machine to it.  In the below example, a new virtual machine is created specifying that at least 4 gigabytes of memory is available for the virtual machine and that is at least 10% CPU utilization available on the host.

        # Identify the optimal node to create a new virtual machine
        $memoryinMB=4096
        $vpcount = 1
        $targetnode = Get-ClusterSetOptimalNodeForVM -VMMemory $memoryinMB -VMVirtualCoreCount $vpcount -VMCpuReservation 10
        $secure_string_pwd = convertto-securestring "<password>" -asplaintext -force
        $cred = new-object -typename System.Management.Automation.PSCredential ("<domain\account>",$secure_string_pwd)

        # Deploy the virtual machine on the optimal node
        Invoke-Command -ComputerName $targetnode.name -scriptblock { param([String]$storagepath); New-VM CSVM1 -MemoryStartupBytes 3072MB -path $storagepath -NewVHDPath CSVM.vhdx -NewVHDSizeBytes 4194304 } -ArgumentList @("\\SOFSCLUSTER1\VOLUME1") -Credential $cred | Out-Null
        Start-VM CSVM1 -ComputerName $targetnode.name | Out-Null
        Get-VM CSVM1 -ComputerName $targetnode.name | fl State, ComputerName

When it completes, you will be given the information about the virtual machine and where it was placed.  In the above example, it would show similar to:

        State         : Running
        ComputerName  : 1-S2D2

        NOTE: ComputerName above may vary depending on virtual machine placement.

If you were to not have enough memory, cpu, or disk space to add the virtual machine, you will receive the error:

      Get-ClusterSetOptimalNodeForVM : A cluster node is not available for this operation.  

Once the virtual machine has been created, it will be displayed in Hyper-V Manager on the specific node specified.  To add it as a Cluster Set virtual machine and into the cluster, run the command below while on the node it is currently running.  

        Register-ClusterSetVM -CimSession CSMASTER -MemberName $targetnode.Member -VMName CSVM1

When it completes, the output will be:

         Id  VMName  State  MemberName  PSComputerName
         --  ------  -----  ----------  --------------
          1  CSVM1      On  CLUSTER1    CSMASTER

If you have added a cluster with existing virtual machines, the virtual machines will also need to be registered with Cluster Sets.  To register all the virtual machines at once, the command to use while on that cluster is:

        Get-ClusterSetMember -name CLUSTER3 -CimSession CSMASTER | Register-ClusterSetVM -RegisterAll

However, the process is not complete as the path to the virtual machine needs to be added to the Cluster Set namespace.

So for example, an existing cluster is added and it has pre-configured virtual machines the reside on the local Cluster Shared Volume (CSV), the path for the VHDX would be something similar to "C:\ClusterStorage\Volume1\MYVM\Virtual Hard Disks\MYVM.vhdx".  A storage migration would need to be accomplished as CSV paths are by design local to a single member cluster. Thus, will not be accessible to the virtual machine once they are live migrated across member clusters. 

In this example, CLUSTER3 was added to the Cluster Set using Add-ClusterSetMember with the Infrastructure Scale-Out File Server as SOFSCLUSTER3.  To move the virtual machine configuration and storage, while on the console of the specific cluster, the command is:

        Move-VMStorage -DestinationStoragePath \\SOFSCLUSTER3\Volume1 -Name MYVM

Once it completes, you will receive a warning:

        WARNING: There were issues updating the virtual machine configuration that may prevent the virtual machine from running.  For more information view the report file below.
        WARNING: Report file location: C:\Windows\Cluster\Reports\Update-ClusterVirtualMachineConfiguration '' on date at time.htm.

This warning can be ignored as the warning is "No changes in the virtual machine role storage configuration were detected".  The reason for the warning as the actual physical location does not change; only the configuration paths. 

For more information on Move-VMStorage, please review this [link](https://docs.microsoft.com/en-us/powershell/module/hyper-v/move-vmstorage?view=win10-ps). 

Live migrating a virtual machine between different Cluster Set clusters is not the same as in the past. In non-Cluster Set scenarios, the steps would be:

1. Remove the virtual machine role from the Cluster
2. Live migrate the virtual machine to a member node of a different cluster
3. Add the virtual machine into the cluster as a new virtual machine role

With Cluster Sets, the above steps are not necessary and only one command is needed.  For example, I want to move a Cluster Set registered virtual machine from CLUSTER1 to CLUSTER3.  The single command would be:

        Move-ClusterSetVM -VMName CSVM1 -ClusterName CLUSTER3

Please note that this does not move the virtual machine storage or configuration files.  This is not necessary as the path to the virtual machine remains as \\SOFSCLUSTER1\VOLUME1.  Once a virtual machine has been registered with Cluster Sets, the Infrastructure File Server share path for the drives and virtual machine do not require being on the same machine as the virtual machine.

## Creating Availability sets Fault Domains

As described in the introduction, Azure-like fault domans and availability sets can be configured in a Cluster Set.  This is beneficial for initial virtual machine placements and migrations between clusters.  

In the example below, there are four clusters participating in the Cluster Set.  Within the set, a logical fault domain will be created with two of the clusters and a fault domain created with the other two clusters.  These two fault domains will comprise the Availabiilty Set. 

In the example below, CLUSTER1 and CLUSTER2 will be in a fault domain called **FD1** while CLUSTER3 and CLUSTER4 will be in a fault domain called **FD2**.  The availability set will be called **CLUSTERSETAS** and be comprised of the two fault domains.  This is done while on the console of the head cluster.

To create the fault domains, the commands are:

        New-ClusterSetFaultDomain -Name FD1 -FdType Logical -MemberCluster CLUSTER1,CLUSTER2 -Description "This is my first fault domain"

        New-ClusterSetFaultDomain -Name FD2 -FdType Logical -MemberCluster CLUSTER3,CLUSTER4 -Description "This is my second fault domain"

To ensure they have been created successfully, Get-ClusterSetFaultDomain can be run with its output shown.

        PS C:\> Get-ClusterSetFaultDomain -FdName FD1 | fl *

        PSShowComputerName    : True
        FaultDomainType       : Logical
        ClusterName           : {CLUSTER1, CLUSTER2}
        Description           : This is my first fault domain
        FDName                : FD1
        Id                    : 1
        PSComputerName        : CSMASTER

Now that the fault domains have been created, the availability set needs to be created.

        New-ClusterSetAvailabilitySet -Name CLUSTERSETAS -FdType Logical -ParticipantName FD1,FD2

To validate it has been created, then use:

        Get-ClusterSetAvailabilitySet -AvailabilitySetName CLUSTERSETAS 

When creating new virtual machines, you would then need to use the -AvailabilitySet parameter as part of determining the optimal node.  So it would then look something like this:

        # Identify the optimal node to create a new virtual machine
        $memoryinMB=4096
        $vpcount = 1
        $av = Get-ClusterSetAvailabilitySet -Name CLUSTERSETAS 
        $targetnode = Get-ClusterSetOptimalNodeForVM -CimSession CSMASTER -VMMemory $memoryinMB -VMVirtualCoreCount $vpcount -VMCpuReservation 10 -AvailabilitySet $av
        $secure_string_pwd = convertto-securestring "<password>" -asplaintext -force
        $cred = new-object -typename System.Management.Automation.PSCredential ("<domain\account>",$secure_string_pwd)

Removing a cluster from Cluster Sets due to various life cycles. There are times when a cluster needs to be removed from a Cluster Set. As a best practice, all Cluster Set virtual machines should be moved out of the cluster. This can be accomplished using the **Move-ClusterSetVM** and **Move-VMStorage** commands.

However, if the virtual machines will not be moved as well, Cluster Sets runs a series of actions to provide an intuitive outcome to the administrator.  When the cluster is removed from the set, all remaining Cluster Set virtual machines hosted on the cluster being removed will simply become highly available virtual machines bound to that cluster, assuming they have access to their storage.  Cluster Sets will also automatically update its inventory by:

- No longer tracking the health of the now-removed cluster and the virtual machines running on it
- Removes from Cluster Set namespace and all references to shares hosted on the now-removed cluster

For example, the command to remove the CLUSTER1 cluster from Cluster Sets would be:

        Remove-ClusterSetMember -ClusterName CLUSTER1 

## Frequently asked questions (FAQ)

**Question:** In my Cluster Set, am I limited to only using hyper-converged clusters? <br>
**Answer:** No.  You can mix both hyper-converged (Storage Spaces Direct) with non hyper-converged (traditional clusters).

**Question:** Can I manage my Cluster Set via System Center Virtual Machine Manager? <br>
**Answer:** System Center Virtual Machine Manager does not currently support Cluster Sets <br><br> 

**Question:** Can I migrate workloads off Windows Server 2012 R2 or 2016 clusters by simply having those clusters join the same Cluster Set? <br>
**Answer:** Cluster Sets is a new technology being introduced in Windows Server 2019, so as such, does not exist in previous releases. Down-level OS-based clusters cannot join a Cluster Set. However, Cluster Operating System rolling upgrades technology should provide the migration functionality that you are looking for by upgrading these clusters to Windows Server 2019.

**Question:** Can Cluster Sets allow me to scale storage or compute (alone)? <br>
**Answer:** Yes, by simply adding a Storage Space Direct or traditional Hyper-V cluster. With Cluster Sets, it is a straightforward change of Compute-to-Storage ratio even in a hyper-converged Cluster Set.

**Question:** What is the management tooling for Cluster Sets <br>
**Answer:** PowerShell or WMI.

**Question:** How will the cross-cluster live migration work with processors of different generations?  <br>
**Answer:** Cluster Sets does not work around processor differences and supercede what Hyper-V currently supports.  The recommendation for Cluster Sets is to use the same processor hardware within each individual cluster as well as the entire Cluster Set for live migrations between clusters to occur.  Otherwise, the processor compatibility mode must be selected or use quick migrations.  

**Question:** Can my Cluster Set virtual machines automatically failover on a cluster failure?  <br>
**Answer:** In Windows Server 2019, Cluster Set virtual machines can only be manually live-migrated across clusters; but cannot automatically failover. However, items such as automatic failovers, node fairness, etc, will remain if failovers occur within the same cluster.

**Question:** How do we ensure storage is resilient to cluster failures? <br>
**Answer:** Use cross-cluster Storage Replica (SR) solution across member clusters to realize the storage resiliency to cluster failures.

**Question:** I use Storage Replica (SR) to replicate across member clusters. Does Cluster Set namespace storage UNC paths change on SR failover to the replica target cluster in the same Cluster Set? <br>
**Answer:** No.  Such a Cluster Set namespace referral change in Windows Server 2019. Please let Microsoft know if this scenario is critical to you and how you plan to use it.

**Question:** Can my Cluster Set span clusters in multiple sites (or DNS domains)? <br> 
**Answer:** This is an untested scenario and not immediately planned for production support. Please let Microsoft know if this scenario is critical to you and how you plan to use it.

**Question:** Does Cluster Set work with IPv6? <br>
**Answer:** Both IPv4 and IPv6 are supported with Cluster Sets as with Failover Clusters.

**Question:** What are the Active Directory Forest requirements for Cluster Sets <br>
**Answer:** All member clusters must be in the same AD forest.

**Question:** How many clusters or nodes can be part of a single Cluster Set? <br>
**Answer:** Cluster Sets been tested with 64 total cluster nodes and 8 total clusters. However, Cluster Sets architecture can scale to much larger limits. Please let Microsoft know if larger hyperscale is critical to you and how you plan to use it.

**Question:** Will all Storage Spaces Direct clusters in a Cluster Set form a single storage pool? <br>
**Answer:** No. Storage Spaces Direct technology still operates within a single cluster and not across member clusters in a Cluster Set.

**Question:** Is the Cluster Set namespace highly available? <br>
**Answer:** Yes, the Cluster Set namespace is provided via a Continuously Available (CA) referral SOFS namespace server running on the head cluster. Microsoft recommends having enough number of virtual machines from member clusters to make it resilient to localized cluster-wide failures. However, to account for unforeseen catastrophic failures, the referral information is additionally persistently cached in each Cluster Set node, even across reboots.
 
**Question:** Does the Cluster Set namespace-based storage access slow down storage performance in a Cluster Set? <br>
**Answer:** No. Cluster Set namespace offers an overlay referral namespace within a Cluster Set, similar to Distributed File System Namespaces (DFSN). Unlike DFSN, all Cluster Set namespace referral metadata is auto-populated and auto-updated on all nodes without any administrator intervention, so there is almost no performance overhead in the storage access path. 

**Question:** How can I backup Cluster Set metadata? <br>
**Answer:** This guidance is the same as that of Failover Cluster where a System State Backup will backup the cluster state as well.  Through Windows Server Backup, you can just a node's cluster database with an authoritative restore to roll back the entire cluster database across all nodes. In the case of Cluster Sets, Microsoft recommends doing such an authoritative restore first on the member cluster and then the head cluster if needed.
