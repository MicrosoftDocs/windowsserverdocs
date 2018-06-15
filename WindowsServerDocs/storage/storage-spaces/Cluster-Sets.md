---
title: Cluster Sets
ms.prod: windows-server-threshold
ms.manager: eldenc
ms.technology: storage-spaces
ms.topic: article
author: johnmarlin-msft
ms.date: 06/08/2018
description: This article describes the Cluster Sets scenario
ms.localizationpriority: medium
---

# Cluster Sets
> Applies To: Windows Server Insider Preview build 17650 and later

“Cluster Sets” is the new cloud scale-out technology in this Preview release that increases cluster node count in a single Software Defined Data Center (SDDC) cloud by orders of magnitude. A Cluster Set is a loosely-coupled grouping of multiple Failover Clusters: compute, storage or hyper-converged. Cluster Sets technology enables virtual machine fluidity across member clusters within a Cluster Set and a unified storage namespace across the Cluster Set in support of virtual machine fluidity. 

While preserving existing Failover Cluster management experiences on member clusters, a Cluster Set instance additionally offers key use cases around lifecycle management of a Cluster Set at the aggregate. This Windows Server Preview Scenario Evaluation Guide provides you the necessary background information along with step-by-step instructions to evaluate Cluster Sets technology using PowerShell. 

## Technology Introduction

Cluster Sets technology is developed to meet specific customer requests operating Software Defined Datacenter clouds at scale. Cluster Sets value proposition in this Preview release may be summarized as the following:  

- Significantly increase the supported SDDC cloud scale for running highly avaialble virtual machines by combining multiple smaller clusters into a single large fabric, even while keeping the software fault boundary to a single cluster
- Manage entire Failover Cluster lifecycle including onboarding and retiring clusters, without impacting tenant virtual machine availability, via fluidly migrating virtual machines across this large fabric
- Easily change the compute-to-storage ratio in your hyper-converged I
- Benefit from [Azure-like Fault Domains and Availability Sets](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/manage-availability) across clusters in initial virtual machine placement and subsequent virtual machine migration
- Mix-and-match different generations of CPU hardware into the same Cluster Set fabric, even while keeping individual fault domains homogenous for maximum efficiency.  Please note that the recommendation of same hardware is still present within each individual Cluster as well as the entire Cluster Set.

From a high level view, thsi is what Cluster Sets can look like.

![Cluster Sets Solution View](media\Cluster-Sets-Overview\Cluster-Sets-Solution-View.png)

The following provides a quick summary of each of the elements in the above image:

**Management cluster**

Management cluster in a Cluster Set is a Failover Cluster that hosts the highly-available management plane of the entire Cluster Set and the unified storage namespace (Cluster Set Namespace) referral SOFS. A management cluster is logically decoupled from member clusters that run the virtual machine workloads. This makes the Cluster Set management plane resilient to any localized cluster-wide failures, e.g. loss of power of a member cluster.   

**Member cluster**

A member cluster in a Cluster Set is typically a traditional hyper-converged cluster running virtual machine and S2D workloads. Multiple member clusters participate in a single Cluster Set deployment, forming the larger SDDC cloud fabric. Member clusters differ from a management cluster in two key aspects: member clusters participate in fault domain and availability set constructs, and member clusters are also sized to host virtual machine and S2D workloads. Cluster Set virtual machines that move across cluster boundaries in a Cluster Set must not be hosted on the management cluster for this reason).

**Cluster Set namespace referral SOFS**

A Cluster Set namespace referral (Cluster Set Namespace) SOFS is a Scale-Out File Server wherein each SMB Share on the Cluster Set Namespace SOFS is a referral share – of type ‘SimpleReferral’ newly introduced in this Preview release.  This referral allows SMB clients access to the target SMB share hosted on the member cluster SOFS (SOFS-1, SOFS-2 etc. in Figure 1). The Cluster Set namespace referral SOFS is a light-weight referral mechanism and as such, does not participate in the IO path. The SMB referrals are cached perpetually on the each of the client nodes and the Cluster Sets namespace I dynamically automatically updates these referrals as needed.

**Cluster Set Master**

In a Cluster Set, the communication between the member clusters is loosely coupled, and is coordinated by a new cluster resource called “Cluster Set Master” (CS-Master). Like any other cluster resource, CS-Master is highly available and resilient to individual member cluster failures and/or the management cluster node failures. Through a new Cluster Set WMI provider, CS-Master provides the management endpoint for all Cluster Set manageability interactions.

**Cluster Set Worker**

In a Cluster Set deployment, the CS-Master interacts with a new cluster resource on the member Clusters called “Cluster Set Worker” (CS-Worker). CS-Worker acts as the only liaison on the cluster to orchestrate the local cluster interactions as requested by the CS-Master. Examples of such interactions include virtual machine placement and cluster-local resource inventorying. There is only one CS-Worker instance for each of the member clusters in a Cluster Set. 

**Logical Fault Domain (LFD)**

Compute fault domains (FDs) may be of two types in a Cluster Set: Logical Fault Domains (LFD) or Node Fault Domains (Node-FD). In either case, a Fault Domain is the grouping of software and hardware artifacts that the administrator determines could fail together when a failure does occur.  While an administrator could designate one or more clusters together as a LFD, each node could participate as a Node-FD in Availability Set. Cluster Sets by design leaves the decision of FD boundary determination to the administrator who is well-versed with data center topological considerations – e.g. PDU, networking – that member clusters share. 

**Availability Set**

An Availability Set helps the administrator configure desired redundancy of clustered workloads across fault domains, by organizing those FDs into an Availability Set and deploying workloads into that Availability Set. Let’s say if you are deploying a two-tier application, we recommend that you configure at least two virtual machines in an Availability Set for each tier which will ensure that when one FD in that Availability Set goes down, your application will at least have one virtual machine in each tier hosted on a different FD of that same Availability Set.

## Why use Cluster Sets

Cluster Sets provides the benefit of scale without sacrificing resiliency.  

Cluster Sets allows for clustering multiple clusters together to create a large fabric, while each cluster remains independent for resiliency.  For example, you have a several 4-node HCI clusters running virtual machines.  Each cluster provides the resiliency needed for itself.  If the storage or memory starts to fill up, scaling up is your next step.  With scaling up, there are some options and considerations.

1. Add more storage to the current cluster.  With Storage Spaces Direct, this may be tricky as the exact same model/firmware drives may not be available.  The consideration of rebuild times also need to be taken into account.
2. Add more memory.  What if you are maxed out on the memory the machines can handle?  What if all available memory slots are full?
3. Add additional compute nodes with drives into the current cluster.  This takes us back to Option 1 needing to be considered.
4. Purchase a whole new cluster

This is where Cluster Sets provides the benefit of scaling.  If I add my clusters into a Cluster Set, I can take advantage of storage or memory that may be available on another Cluster without any additonal purchases.  From a resiliency perspective, adding additional nodes to a Storage Spaces Direct is not going to provide additional votes for quorum.  As mentioned [here](https://docs.microsoft.com/en-us/windows-server/storage/storage-spaces/drive-symmetry-considerations), a Storage Spaces Direct Cluster can survive the loss of 2 nodes before going down.  If you have a 4-node HCI cluster, 3 nodes go down will take the entire cluster down.  If you have an 8-node cluster, 3 nodes go down will take the entire cluster down.  With Cluster Sets that has two 4-node HCI clusters in the set, 2 nodes in one HCI go down and 1 node in the other HCI go down, both Clusters remain up.  Is it better to create one large 16-node Storage Spaces Direct cluster or break it down into four 4-node clusters and use Cluster Sets?  Having four 4-node clusters with Cluster Sets gives the same scale, but better resiliency in that multiple compute nodes can go down (unexpectedly or for maintenance) and production remains.

## Considerations for deploying Cluster Sets

When considering if Cluster Sets is something you need to use, consider these questions:

- Do you need to go beyond the current HCI compute and storage scale limits?
- Are all compute and storage not identically the same?
- Do you live migrate virtual machines between clusters?
- Would you like Azure-like computer availability sets and fault domains across multiple clusters?
- Do you need to take the time to look at all your clusters to determine where any new virtual machines need to be placed?

If your answer is yes, then Cluster Sets is what you need.

There are a few other items to consider where a larger SDDC might change your overall data center strategies.  SQL Server is a good example.  Does moving SQL Server virtual machines between clusters require licensing SQL to run on additional nodes?  

## Scale-out File Server and Cluster Sets

In Windows Server 2019, there is a new scale-out file server role called Infrastructure Scale-Out File Server (SOFS). 

The following considerations apply to an Infrastructure SOFS role:

1.	There can be at most only one Infrastructure SOFS cluster role on a Failover Cluster. Infrastructure SOFS role is created by specifying the "**-Infrastructure**" switch parameter to the **Add-ClusterScaleOutFileServerRole** cmdlet.  For example:

        Add-ClusterScaleoutFileServerRole -Name "my_infra_sofs_name" -Infrastructure

2.	Each CSV volume created in the failover automatically triggers the creation of an SMB Share with an auto-generated name based on the CSV volume name. An administrator cannot directly create or modify SMB shares under an I SOFS role, other than via CSV volume create/modify operations.

3.	In hyper-converged configurations, an Infrastructure SOFS allows an SMB client (Hyper-V host) to communicate with guaranteed Continuous Availability (CA) to the Infrastructure SOFS SMB server. This hyper-converged SMB loopback CA is achieved via virtual machines accessing their virtual disk (VHDx) files where the owning virtual machine identity is forwarded between the client and server. This identity forwarding allows ACL-ing VHDx files just as in standard hyper-converged cluster configurations as before.

Once a Cluster Set is created, the Cluster Set namespace relies on an Infrastructure SOFS on each of the member clusters, and additionally an Infrastructure SOFS in the management cluster.

At the time a member cluster is added to a Cluster Set, the administrator specifies the name of an Infrastructure SOFS on that cluster if one already exists. If the Infrastructure SOFS does not exist, a new I SOFS role on the new member cluster is created by this operation. If an Infrastructure SOFS role already exists on the member cluster, the Add operation implicitly renames it to the specified name as needed. Any existing singleton SMB servers, or non-I SOFS roles on the member clusters are left unutilized by the Cluster Set. 

At the time the Cluster Set is created, the administrator has the option to use an already-existing AD computer object as the namespace root on the management cluster. Cluster Set creation operations create the Infrastructure SOFS cluster role on the management cluster or renames the existing I SOFS role just as previously described for member clusters. The Infrastructure SOFS on the management cluster is used as the Cluster Set namespace referral (Cluster Set Namespace) SOFS. It simply means that each SMB Share on the Cluster Set Namespace SOFS is a referral share – of type ‘SimpleReferral’ - newly introduced in this Preview release.  This referral allows SMB clients access to the target SMB share hosted on the member cluster SOFS (SOFS-1, SOFS-2 etc. in Figure 1). The Cluster Set namespace referral SOFS is a light-weight referral mechanism and as such, does not participate in the IO path. The SMB referrals are cached perpetually on the each of the client nodes and the Cluster Sets namespace I dynamically automatically updates these referrals as needed

## Creating a Cluster Set

### Prerequisites
When creating a Cluster Set, you following prerequisites are recommended:

1. Configure a management client running the latest Windows Server Insider release.
2. Install the Failover Cluster tools on this management server.
3. Create cluster members (at least two clusters with at least two Cluster Shared Volumes on each cluster)
4. Create a management cluster (physical or guest) that straddles the member clusters.  This approach ensures that the Cluster Sets management plane continues to be available despite possible member cluster failures.

### Steps
1. Create a new Cluster Set from three clusters as defined in the prerequisites.  The below chart gives an example of clusters to create.  The name of the Cluster Set in this example will be **CSMASTER**.

        | Cluster Name               | Infrastructure SOFS Name to be used later | 
        |----------------------------|-------------------------------------------|
        | SET-CLUSTER                | SOFS-CLUSTERSET                           |
        | CLUSTER1                   | SOFS-CLUSTER1                             |
        | CLUSTER2                   | SOFS-CLUSTER2                             |

2. Once all cluster have been created, use the following commands to create the Cluster Set Master.

        New-ClusterSet -Name CSMASTER -NamespaceRoot SOFS-CLUSTERSET -CimSession SET-CLUSTER

3. To add a Cluster Server to the Cluster Set, the below would be used.

        Add-ClusterSetMember -ClusterName CLUSTER1 -CimSession CSMASTER -InfraSOFSName SOFS-CLUSTER1
        Add-ClusterSetMember -ClusterName CLUSTER2 -CimSession CSMASTER -InfraSOFSName SOFS-CLUSTER2

**NOTE:**
If you are using a static IP Address scheme, you must include *-StaticAddress x.x.x.x* on the **New-ClusterSet** command.

4. Once you have created the Cluster Set out of cluster members, you can list the nodes Set and its properties.  To enumerate all the member clusters in the Cluster Set:

        Get-ClusterSetMember -CimSession CSMASTER

5. To enumerate all the member Clusters in the Cluster Set including the management cluster nodes:

        Get-ClusterSet -CimSession CSMASTER | Get-Cluster | Get-ClusterNode

6. To list all the nodes from the member Clusters:

        Get-ClusterSetNode -CimSession CSMASTER

7. To list all the resource groups across the Cluster Set:

        Get-ClusterSet -CimSession CSMASTER | Get-Cluster | Get-ClusterGroup 

8. To verify the Cluster Set creation process created one SMB share (identified as Volume1 or whatever the CSV folder is labeled with the ScopeName being the name of the Infrastructure File Server and the path as both) on the Infrastructure SOFS for each cluster member's CSV volume:

        Get-SmbShare -CimSession CSMASTER

8. Cluster Sets has debug logs that can be collected for review.  Both the Cluster Set and Cluster debug logs can be gathered for all members and the management cluster.

        Get-ClusterSetLog -ClusterSetCimSession CSMASTER -IncludeClusterLog -IncludeManagementClusterLog -DestinationFolderPath <path>

9. Configure Kerberos [constrained delegation](https://blogs.technet.microsoft.com/virtualization/2017/02/01/live-migration-via-constrained-delegation-with-kerberos-in-windows-server-2016/) between all Cluster Set members.

10. Configure the cross-cluster virtual machine live migration authentication type to Kerberos on each node in the Cluster Set.

        foreach($h in $hosts){ Set-virtual machineHost -VirtualMachineMigrationAuthenticationType Kerberos -ComputerName $h }

11. Add the management cluster to the local administrators group on each node in the Cluster Set.

        foreach($h in $hosts){ Invoke-Command -ComputerName $h -ScriptBlock {Net localgroup administrators /add <management_cluster_name>$} }

## Creating new virtual machines and adding to Cluster Sets

After creating the Cluster Set, the next step is to create new virtual machines.  Normally, when it is time to create virtual machines and add them to a cluster, you need to do some checks on the clusters to see which it may be best to run on.  These checks could include:

- How much memory is available on the cluster nodes?
- How much disk space is available on the cluster nodes?
- Does the virtual machine require specific storage requirements (i.e. I want my SQL Server virtual machines to go to a cluster running faster drives; or, my infrastructure virtual machine is not as critical and can run on slower drives).

Once this questions are answered, you create the virtual machine on the cluster you need it to be.  One of the benefits of Cluster Sets is that Cluster Sets can do those checks for you and place the virtual machine on the most optimal node.

The below commands will both identify the optimal cluster and deploy the virtual machine to it.  In the below example, a new virtual machine is created specifying that at least 4 gigabytes of memory is available for the virtual machine and that it will need to utilize 1 virtual processor.

- ensure that 4gb is available for the virtual machine
- set the virtual processor used at 1
- check to ensure there is at least 10% CPU avaialble for the virtual machine

        # Identify the optimal node to create a new virtual machine
        $memoryinMB=4096
        $vpcount = 1
        $targetnode = Get-ClusterSetOptimalNodeForvirtual machine -CimSession CSMASTER -virtual machineMemory $memoryinMB -virtual machineVirtualCoreCount $vpcount -virtual machineCpuReservation 10
        $secure_string_pwd = convertto-securestring "<password>" -asplaintext -force
        $cred = new-object -typename System.Management.Automation.PSCredential ("<domain\account>",$secure_string_pwd)

        # Deploy the virtual machine on the optimal node
        Invoke-Command -ComputerName $targetnode.name -scriptblock { param([String]$storagepath); New-virtual machine CSvirtual machine1 -MemoryStartupBytes 3072MB -path $storagepath -NewVHDPath CSvirtual machine.vhdx -NewVHDSizeBytes 4194304 } -ArgumentList @("\\SOFS-CLUSTER1\VOLUME1") -Credential $cred | Out-Null
        Start-virtual machine CSvirtual machine1 -ComputerName $targetnode.name | Out-Null
        Get-virtual machine CSvirtual machine1 -ComputerName $targetnode.name | fl State, ComputerName

When it completes, you will be given the information about the virtual machine and where it was placed.  In the above example, it would show as:

        State         : Running
        ComputerName  : 1-S2D2

If you were to not have enough memory, cpu, or disk space to add the virtual machine, you will receive the error:

      Get-ClusterSetOptimalNodeForvirtual machine : A cluster node is not available for this operation.  

Once the virtual machine has been created, it will be dosplayed in Hyper-V manager on the specific node specified.  To add it as a Cluster Set virtual machine and into the cluster, the command is below.  

        Register-ClusterSetvirtual machine -CimSession CSMASTER -MemberName $targetnode.Member -virtual machineName CSvirtual machine1

When it completes, the output will be:

         Id  virtual machineName  State  MemberName  PSComputerName
         --  ------  -----  ----------  --------------
          1  CSvirtual machine1      On  CLUSTER1    CSMASTER

If you have added a cluster with existing virtual machines, the virtual machines will alos need to be registered with Cluster Sets.  To register all the virtual machines at once, the command to use is:

        Get-ClusterSetMember -name CLUSTER3 -CimSession CSMASTER | Register-ClusterSetvirtual machine -RegisterAll -CimSession CSMASTER

However, the process is not complete as the path to the virtual machine needs to be added to the Cluster Set namespace.

So for example, an existing cluster is added and it has pre-configured virtual machines the reside on the local Cluster Shared Volume (CSV), the path for the VHDX would be something similar to "C:\ClusterStorage\Volume1\MYvirtual machine\Virtual Hard Disks\MYvirtual machine.vhdx.  A storage migration would need to be accomplished as CSV paths are by design local to a single member cluster. Thus, will not be accessible to the virtual machine once they are live migrated across member clusters. 

In this example, CLUSTER3 was added to the Cluster Set using Add-ClusterSetMember with the Infrastructure Scale-Out File Server as SOFS-CLUSTER3.  To move the virtual machine configuration and storage, the command is:

        Move-virtual machineStorage -DestinationStoragePath \\SOFS-CLUSTER3\Volume1 -Name MYvirtual machine

Once it completes, you will receive a warning:

        WARNING: There were issues updating the virtual machine configuration that may prevent the virtual machine from running.  For more information view the report file below.
        WARNING: Report file location: C:\Windows\Cluster\Reports\Update-ClusterVirtualMachineConfiguration '' on date at time.htm.

This warning can be ignored as the warning is "No changes in the virtual machine role storage configuration were detected".  The reason for the warning as the actual physical location does not change; only the configuration paths. 

For more information on Move-virtual machineStorage, please review this [link](https://docs.microsoft.com/en-us/powershell/module/hyper-v/move-virtual machinestorage?view=win10-ps). 

Live migrating a virtual machine between different Cluster Set clusters is not the same as in the past. In non-Cluster Set scenarios, the steps would be:

1. remove the virtual machine role from the Cluster.
2. live migrate the virtual machine to a member node of a different cluster.
3. add the virtual machine into the cluster as a new virtual machine role.

With Cluster Sets, these steps are not necessary and only one command is needed.  For example, I want to move a Cluster Set virtual machine from CLUSTER1 to CLUSTER3.  The single command would be:

        Move-ClusterSetvirtual machine -CimSession CSMASTER -virtual machineName CSvirtual machine1 -ClusterName CLUSTER3

Please note that this does not move the virtual machine storage or configuration files.  This is not necessary as the path to the virtual machine remains as \\SOFS-CLUSTER1\VOLUME1.  Once a virtual machine has been registered with Cluster Sets and has the Infrastructure File Server share path, the drives and virtual machine do not require being on the same machine as the virtual machine.

## Creating Availability Sets and Fault Domains

As described in the introduction, Azure-like fault domans and availability sets can be configured in a Cluster Set.  This is beneficial for initial virtual machine placements and migrations between clusters.  

In the example below, there are four clusters participating in the Cluster Set.  Within the set, a logical fault domain will be created with two of the clusters and a fault domain created with the other two clusters.  These two fault domains will comprise the Availabiilty Set. 

In the example below, CLUSTER1 and CLUSTER2 will be in a fault domain called **FD1** while CLUSTER3 and CLUSTER4 will be in a fault domain called **FD2**.  The Availability Set will be called **CSMASTER-AS** and be comprised of the two fault domains.

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

Now that the fault domains have been created, the Availability Set needs to be created.

        New-ClusterSetAvailabilitySet -Name CSMASTER-AS -FdType Logical -CimSession CSMASTER -ParticipantName FD1,FD2

To validate it has been created, then use:

        Get-ClusterSetAvailabilitySet -AvailabilitySetName CSMASTER-AS -CimSession CSMASTER

When creating new virtual machines, you would then need to use the -AvailabilitySet parameter as part of determining the optimal node.  So it would then look something like this:

        # Identify the optimal node to create a new virtual machine
        $memoryinMB=4096
        $vpcount = 1
        $av = Get-ClusterSetAvailabilitySet -Name CSMASTER-AS -CimSession CSMASTER
        $targetnode = Get-ClusterSetOptimalNodeForvirtual machine -CimSession CSMASTER -virtual machineMemory $memoryinMB -virtual machineVirtualCoreCount $vpcount -virtual machineCpuReservation 10 -AvailabilitySet $av
        $secure_string_pwd = convertto-securestring "<password>" -asplaintext -force
        $cred = new-object -typename System.Management.Automation.PSCredential ("<domain\account>",$secure_string_pwd)

## Removing a cluster from Cluster Sets

Due to various life cycles, there are times with a cluster needs to be removed from a Cluster Set. As the best practice, all Cluster Set virtual machines should be moved out of the cluster being removed onto a cluster still participating in the set. This can be accomplished using the **Move-ClusterSetvirtualMachine** and **Move-VMStorage** commands.

However, if the virtual machines will not be moved as well, Cluster Sets takes a series of actions to provide an intuitive outcome to the administrator.  When the cluster is removed from the set, all remaining Cluster Set virtual machines hosted on the cluster being removed will simply become highly available virtual machines bound to that cluster, assuming they have access to their storage.  Cluster sets will also automatically update its inventory by:

- No longer tracking the health of the now-removed cluster and the virtual machines running on it
- Removes from Cluster Set namespace and all references to shares hosted on the now-removed cluster

For example, the command to remove the CLUSTER1 cluster from Cluster Sets would be:

        Remove-ClusterSetMember -ClusterName CLUSTER1 -CimSession CSMASTER

## Frequently asked questions (FAQ)

**Question:** In my Cluster Set, am I limited to only using hyper-converged clusters? <br>
**Answer:** No.  You can mix Storage Spaces Direct with traditional clusters.

**Question:** Can I manage my Cluster Set via System Center Virtual Machine Manager? <br>
**Answer:** System Center Virtual Machine Manager does not currently support Cluster Sets.

**Question:** Can Windows Server 2012 R2 or 2016 clusters co-exist in the same Cluster Set? <br>
**Question:** Can I migrate workloads off Windows Server 2012 R2 or 2016 clusters by simply having those clusters join the same Cluster Set? <br>
**Answer:** Cluster Sets is a new technology being introduced in Windows Server TAP/Insider builds, so as such, does not exist in previous releases. Down-level OS-based clusters cannot join a Cluster Set. However, Cluster Operating System rolling upgrades technology should provide the migration functionality that you are looking for by upgrading these clusters to Windows Server 2019.

**Question:** Can Cluster Sets allow me to scale storage or compute (alone)? <br>
**Answer:** Yes, by simply adding a Storage Space Direct or traditional Hyper-V cluster. With Cluster Sets, it is straightforward to change Compute-to-Storage ratio even in a hyper-converged Cluster Set.

**Question:** What is the management tooling for Cluster Sets? <br>
**Answer:** PowerShell or WMI in this release.

**Question:** How will the cross-cluster live migration work with processors of different generations?  <br>
**Answer:** Cluster Sets does not work around processor differences and supercede what Hyper-V currently supports.  Therefore, processor compatibility mode must be used with quick migrations.  The recommendation for Cluster Sets is to use the same processor hardware within each individual Cluster as well as the entire Cluster Set for live migrations between clusters to occur.

**Question:** Can my Cluster Set virtual machines automatically failover on a cluster failure?  <br>
**Answer:** In this release, Cluster Set virtual machines can only be manually live-migrated across clusters; but cannot automatically failover. 

**Question:** How do we ensure storage is resilient to cluster failures? <br>
**Answer:** Use cross-cluster Storage Replica (SR) solution across member clusters to realize the storage resiliency to cluster failures.

**Question:** I use Storage Replica (SR) to replicate across member clusters. Do Cluster Set Namespace storage UNC paths change on SR failover to the replica target S2D cluster? <br>
**Answer:** In this release, such a Cluster Set Namespace referral change does not occur with SR failover. Please let Microsoft know if this scenario is critical to you and how you plan to use it.

**Question:** Is it possible to failover virtual machines across fault domains in a DR situation (say the entire FD went down)? <br>
**Answer:** No, note that cross-cluster failover within a logical fault domain is not yet supported. 

**Question:** Can my Cluster Set span clusters in multiple sites (or DNS domains)? <br> 
**Answer:** This is an untested scenario and not immediately planned for production support. Please let Microsoft know if this scenario is critical to you and how you plan to use it.

**Question:** Does Cluster Set work with IPv6? <br>
**Answer:** Both IPv4 and IPv6 are supported with Cluster Sets, just as with Failover Clusters.

**Question:** What are the Active Directory Forest requirements for Cluster Sets? <br>
**Answer:** All member clusters must be in the same AD forest.

**Question:** How many clusters or nodes can be part of a single Cluster Set? <br>
**Answer:** In preview, Cluster Sets has been tested and supported up to 64 total cluster nodes. However, Cluster Sets architecture scales to much larger limits and is not something that is hardcoded for a limit. Please let Microsoft know if larger scale is critical to you and how you plan to use it.

**Question:** Will all Storage Spaces Direct clusters in a Cluster Set form a single storage pool? <br>
**Answer:** No. Storage Spaces Direct technology still operates within a single cluster and not across member clusters in a Cluster Set.

**Question:** Is Cluster Set Namespace highly available? <br>
**Answer:** Yes, the Cluster Set Namespace is provided via a Continuously Available (CA) referral SOFS namespace server running on the management cluster. Microsoft recommends having enough number of virtual machines from member clusters to make it resilient to localized cluster-wide failures. However, to account for unforeseen catastrophic failures – e.g. all virtual machines in the management cluster going down at the same time – the referral information is additionally persistently cached in each Cluster Set node, even across reboots.
 
**Question:** Does the Cluster Set Namespace-based storage access slow down storage performance in a Cluster Set? <br>
**Answer:** No. Cluster Set Namespace offers an overlay referral namespace within a Cluster Set – conceptually like Distributed File System Namespaces (DFSN). And unlike DFSN, all Cluster Set Namespace referral metadata is auto-populated and auto-updated on all nodes without any administrator intervention, so there is almost no performance overhead in the storage access path. 

**Question:** How can I backup Cluster Set metadata? <br>
**Answer:** This guidance is the same as that of Failover Cluster. The System State Backup will backup the cluster state as well.  Through Windows Server Backup, you can do restores of just a nodes ClusDB (which should never be needed because of a bunch of self-healing logic we have) or do an Authoritative restore to roll back the entire ClusDB across all nodes. In the case of Cluster Sets, Microsoft recommends doing such authoritative restore first on the member cluster and then the management cluster if needed. 
