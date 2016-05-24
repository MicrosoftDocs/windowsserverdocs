---
title: Software-Defined Storage Design Considerations Guide
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0923b851-eb0a-48ee-bfcb-d584363be668
---
# Software-Defined Storage Design Considerations Guide
This guide details a series of steps that you can follow to design a storage solution that meets your organization’s unique requirements. The guide uses the Software\-Defined Storage Design Calculator spreadsheet to record your requirements and calculate hardware and software configurations.  
  
**Who is this guide intended for?** Information technology \(IT\) professionals within small, medium, and large organizations who are responsible for designing a storage solution that supports virtualized or other workloads.  
  
**How can this guide help you?** You can use this guide and the [Software\-Defined Storage Design Calculator](http://aka.ms/sdscalc) spreadsheet to design a storage solution that uses the Storage Spaces and Scale\-Out File Server functionality of Windows Server 2012 R2 along with cost\-effective servers and shared serial\-attached SCSI \(SAS\) storage enclosures.  
  
Storage Spaces is a software\-defined storage technology that enables you to virtualize storage by grouping SSDs and hard disks into storage pools and then creating high\-performance and resilient virtual disks, called storage spaces, from available capacity in the pools. You can then place Cluster Shared Volumes \(CSVs\) and file shares on these virtual disks, which in turn host data for your workloads \(see Figure 1\).  
  
![](../Image/StorageSpaces_SharedSAS_Architecture.jpg)  
  
**Figure 1 –** Software\-defined storage architecture using Storage Spaces with shared SAS storage enclosures  
  
**Where can you find background info?** The following topics provide background info about Storage Spaces and general guidance on designing a virtualization fabric including compute, network, and storage resources:  
  
-   [Storage Spaces Overview](../Topic/Storage-Spaces-Overview.md)  
  
-   [Provide cost\-effective storage for Hyper\-V workloads by using Windows Server](https://technet.microsoft.com/en-us/library/dn554251.aspx)  
  
-   [Virtualization Fabric Design Considerations Guide](https://technet.microsoft.com/library/dn800994.aspx)  
  
## Design considerations overview  
This guide and the [Software\-Defined Storage Design Calculator](http://aka.ms/sdscalc) spreadsheet provide a set of steps to design a storage solution based on Storage Spaces. You'll likely move back and forth through some of these steps as you refine your design, talk with a hardware vendor, purchase hardware, and get ready to deploy.  
  
Here's what's in this guide:  
  
[Step 1: Determine storage requirements](../Topic/Software-Defined-Storage-Design-Considerations-Guide.md#BKMK_Step1)  
  
[Step 2: Review the design and adjust as necessary](../Topic/Software-Defined-Storage-Design-Considerations-Guide.md#BKMK_Step2)  
  
[Step 3: Work with a Storage Spaces hardware vendor to finalize the design](../Topic/Software-Defined-Storage-Design-Considerations-Guide.md#BKMK_Step3)  
  
[Step 4: Prepare to deploy the solution](../Topic/Software-Defined-Storage-Design-Considerations-Guide.md#BKMK_Step4)  
  
[Appendix A: Choose deployment and management tools](../Topic/Software-Defined-Storage-Design-Considerations-Guide.md#BKMK_AppendixA)  
  
If you want to jump right into designing a solution, use the **QuickDesign** sheet in the Software\-Defined Storage Design Calculator spreadsheet shown in Figure 2 to select a solution template that adheres to best practices. To customize the design to match your specific needs, use the **AdvancedDesign** sheet of the spreadsheet to select a template and then customize it with the help of the following sections.  
  
![](../Image/Software-DefinedStorageDesignCalculator-QuickStart.jpg)  
  
**Figure 2 –** The QuickDesign sheet of the Software\-Defined Storage Design Calculator  
  
## <a name="BKMK_Step1"></a>Step 1: Determine storage requirements  
The first step in designing a storage solution is to identify your workloads \(applications, servers, and clients\) and then determine your storage requirements.  
  
### Task 1: Describe your workload  
Describing your workload involves a number of subtasks: identifying the workload, determining its performance characteristics, deciding how much capacity you need, and whether to store backups of your workload data on the same storage as the workload itself.  
  
#### Task 1a: Identify your workload  
Start by specifying the workload you want to provide storage for, and whether it works with clustered Scale\-Out File Servers.  
  
-   **What workload do you want to use the storage for?** On the **AdvancedDesign** sheet of the Software\-Defined Storage Design Calculator spreadsheet, first use the **Template** list to specify how many cluster nodes and storage enclosures to use in the initial draft of the design \(the spreadsheet will add enclosures to the design as needed, and you can add nodes as well\). Then use the **Role** field \(shown in Figure 3\) to specify what server role you want to provide storage for. For example, you might want to provide storage for an array of services and applications running in Hyper\-V virtual machines, which you could generically call a general\-purpose Hyper\-V workload.  
  
    ![](../Image/Software-DefinedStorageCalculator-Task1.jpg)  
  
    **Figure 3 –**  Task 1 on the AdvancedDesign sheet of the spreadsheet  
  
-   **Does your workload work with Scale\-Out File Server \(SOFS\)?** Scale\-Out File Server clusters let you create continuously available file shares that can fail over and rebalance load between nodes without dropping SMB 3 network connections. That increases uptime and lets you scale performance by adding cluster nodes.  
  
    Hyper\-V, Microsoft SQL Server, Microsoft Internet Information Server \(IIS\), and the System Center Virtual Machine Manager \(VMM\) library share work well with continuously available file shares on a Scale\-Out File Server. If you have other workloads, they probably aren't optimized for Scale\-Out File Server \(for example, file shares supporting information worker data\).  
  
    If your workload requires storage in a file share but doesn't support Scale\-Out File Server, you can use the **File Server for general use** cluster type, though without the scaling and continuous availability benefits of a Scale\-Out File Server. Because of the scaling limitations, these general\-use file server clusters are typically designed around a two\-node cluster.  
  
    For more info, see [Scale-Out File Server for Application Data Overview_1](../Topic/Scale-Out-File-Server-for-Application-Data-Overview_1.md).  
  
#### Task 1b Determine the performance characteristics of your workload  
While storage vendors love to discuss how many IOPS \(input\/output operations per second\) their solution provides \(see [Achieving Over 1\-Million IOPS from Hyper\-V VMs in a Scale\-Out File Server Cluster Using Windows Server 2012 R2](http://www.microsoft.com/download/details.aspx?id=42960) for one of our examples\!\), these numbers usually represent a best\-case scenario under highly optimized conditions that often diverge from your workloads.  
  
For more useful comparisons, it's helpful to understand the performance characteristics of your existing workloads. The better you know your workloads, the better the conversation you can have with your hardware vendor. You'll also find the info handy when designing storage pools and virtual disks to provide sufficient performance and capacity. And later, when you're setting up your new storage solution, you'll be able to use the data to test the performance of the storage using synthetically generated workloads that closely match the characteristics of your existing workloads.  
  
##### Monitor basic workload performance  
To understand the performance of your existing workloads, take some time to monitor the following characteristics \(usually with [Windows Performance Monitor](https://technet.microsoft.com/en-us/library/cc749249.aspx)\):  
  
-   **Peak and baseline IOPS** \- Use the **Peak IOPS** and **Baseline IOPS** fields of the Software\-Defined Storage Design Calculator spreadsheet to record how many chunks of data the workloads currently transfer per second \(adjust the IOPS to allow for more or less load in your new solution\). You can monitor this in Performance Monitor with the **Logical Disk** > **Disk Transfers\/sec** counter.  
  
-   **Peak throughput** \- How much data is transferred per second? \(IOPS multiplied by block size \= throughput.\) You can measure this separately in Performance Monitor with the **Logical Disk** > **Disk Reads Bytes\/sec** and **Disk Writes Bytes\/sec** counters.  
  
-   **Queue depth** \- How many I\/Os are waiting in the queue to be processed? You can measure this in Peformance Monitor with the **Logical Disk** > **Avg. Disk Queue Length** counter.  
  
-   **Maximum latency** \- How long does each I\/O \(data transfer\) take? You can monitor this in Performance Monitor with the **Logical Disk** > **Avg. Disk sec\/Read** and **Avg. Disk sec\/Write** counters.  
  
-   **Active data \(working I\/O\) set** \- Use the **Active data** field of the spreadsheet to record how much of your workload's data is actively changing. We don't have any performance counters for this, so instead think about your workload's characteristics \- for example, database size would influence how much data is active in a SQL Server workload.  
  
-   **Demand variation over time** \- What peak usage times are important to monitor? For example, Monday morning login traffic or end of the month reporting traffic.  
  
-   **Minimum required throughput for backups** \- If you're going to use your storage cluster to back up your data, how much throughput is required to keep your backups updated?  
  
##### Optionally monitor detailed I\/O characteristics  
Additionally, it can be helpful to look at some of the I\/O characteristics of the workloads:  
  
-   **I\/O \(block\) size** \- How large are the chunks of data your workloads are transferring? You can monitor this in Performance Monitor with the **Logical Disk** > **Avg. Disk Bytes\/Read** and **Avg. Disk Bytes\/Write** counters.  
  
-   **Read and write ratio** \- What's the split between reading and writing for your workloads? You can monitor this in Performance Monitor with the **Logical Disk** > **Disk Reads\/sec** and **Disk Writes\/sec** counters.  
  
-   **Random and sequential ratio** \- What's the split between random I\/Os and sequential I\/Os to contiguous data blocks? For example, databases usually perform random I\/O to scattered data blocks, while reading or writing a large file or data stream results in sequential I\/O to contiguous data blocks. There aren't any Performance Monitor counters to determine whether I\/O is random or sequential \- you'll probably have to estimate based on what you know about your workloads.  
  
-   **Encryption** \- Are you using or do you require encryption at rest \(such as Bitlocker Drive Encryption\) or in\-flight \(SMB 3 encryption\)? Encryption reduces performance, so most customers rely on physical security for their storage clusters and related network infrastructure.  
  
    You can limit the performance impact of encryption by enabling it only on the volumes and shares that require enhanced security, and by monitoring after deployment to confirm adequate performance for your sensitive workloads.  
  
#### Task 1c: Decide how much capacity you need  
To decide how much capacity you need, consider the following factors.  
  
-   **Current size** \- Use the **Current size** field of the Software\-Defined Storage Design Calculator spreadsheet to record the starting size of the data you want to store.  
  
-   **Yearly growth rate** \- Use the **Yearly growth** field of the spreadsheet to record the rate at which your data is growing.  
  
-   **Storage lifetime** \- Use the **Storage life** field of the spreadsheet to record how long do you want the storage to last before you add capacity.  
  
> [!NOTE]  
> When it comes time to purchase more storage, we recommend adding another storage cluster and associated storage enclosures \(which together can be referred to as a storage scale\-unit\). Although it can be tempting to add disks or enclosures to an existing cluster, doing so can yield mismatched warranty periods, lower performance, and a configuration that doesn't support enclosure awareness.  
  
#### Task 1d: Decide whether to store backups on the same storage  
Do you want to use your storage cluster to store backups of your data in addition to your primary data? Many customers use a separate server or cluster for backups, but storing backups on the same solution can reduce the amount of hardware you have to purchase.  
  
If you want to use the solution for primary data and backups, determine how much HDD and SSD capacity to reserve for backups \- this capacity is typically put in its own storage pool.  
  
-   **HDD capacity % for backups** \- Use the **HDD capacity %** field of the Software\-Defined Storage Design Calculator spreadsheet to record the percentage of HDD capacity that you want to reserve for storing backups, or put **0%** if you'll use another system for storing backups. A typical value to reserve is 33% of your total HDD capacity, with backups stored on virtual disks that use the dual\-parity layout and Data Deduplication.  
  
-   **SSD capacity % for backups** \- Use the **SSD capacity %** field of the spreadsheet to record the SSD capacity that you want to reserve for improving the write performance of backups, or put **0%** if you'll use another system for storing backups.  
  
    If you have a large amount of data to backup, add 4 small SSDs to the pool per 16\-32 HDDs \(depending on how much you want to spend to increase write performance\) and set the usage type of the SSDs to `Journal` by using the `Set-PhysicalDisk -Usage Journal` command. If you're not using enclosure awareness, you can add in multiples of 3 SSDs per 12\-24 HDDs. Because the sequential write performance of SSDs is typically "only" 2\-4 times greater than near\-line SAS hard drives, the journal disks will likely be the performance bottleneck if you have more than 4 times as many hard disks as SSD journal disks. However, write performance is usually good enough for most backup workloads with a 1:8 SSD to HDD ratio.  
  
> [!NOTE]  
> Storage Spaces uses two types of write journals \- a 1 GB data journal \(write\-back cache\), and a 256 MB parity journal that is used only with parity spaces. The journals are striped across physical disks using the mirror resiliency type and use the same number of data copies as the associated virtual disk. For example, a dual\-parity virtual disk would use a hidden three\-way mirror to store a 1 GB write\-back cache and a 256 MB parity journal with three data copies, consuming 3.75 GB \(1.25 GB X 3 data copies\) of space on the journal disks. Because the journal is so small, these journal SSDs can be smaller than your other SSDs \(100 GB is more than enough\).  
>   
> While it can be tempting to try to use excess SSD capacity not used by the journals, it's generally not worth the effort. For example, if you leave the journal SSDs in the pool set to the Automatic usage setting, non\-tiered virtual disks \(including parity spaces\) will stripe their data across both the HDDs and SSDs. However, virtual disk performance is limited by the slowest disks in a pool \(ignoring SSDs used for write\-back caches and storage tiers\). So non\-tiered virtual disks that stripe data across SSDs and HDDs won't be any faster than if they just striped across HDDs. Furthermore, striping data across the journal SSDs could consume too much of the SSD capacity, reducing the journal sizes and thus hurting performance.  
  
### Task 2: Select a storage architecture  
In Windows Server 2012 R2, you'll probably want to use a disaggregated storage architecture with storage tiers enabled, but here's some more background:  
  
-   **Solution architecture** \- In Windows Server 2012 R2, Storage Spaces uses a disaggregated storage architecture for most workloads, including virtualized workloads. With the disaggregated architecture, workloads run on a separate server and access storage in the Storage Spaces server or cluster across network links using the SMB protocol.  
  
    The disaggregated architecture enables you to scale your workloads independently of your storage, so if one grows at a different rate than the other you're not stuck buying both storage and compute at the same time \- you just buy the one you need. It also lets you pool storage capacity and performance so that you don’t end up with excess capacity and performance scattered between servers, unable to be used by the workloads that need it in the moment. A disaggregated architecture is also useful when using Data Deduplication and parity spaces as a target for backups, since Data Deduplication requires additional compute resources that you might not want to take away from your workloads.  
  
    However, some vendors also offer Storage Spaces solutions that use the hyperconverged architecture. With the hyperconverged architecture, virtualized workloads run directly on the same server or cluster that hosts the storage. Hyperconverged solutions can reduce costs, especially for small\-scale solutions that eliminate the need for a second server or cluster, as long as your compute and storage needs grow at a similar rate.  
  
-   **Storage model** \- In Windows Server 2012 R2, the Storage Spaces subsystem uses shared SAS disks and enclosures in clusters with all nodes of the cluster sharing the same disks and storage enclosures.  
  
-   **Storage tiers** \- Storage tiers improve performance by moving frequently accessed data to SSD storage while leaving the bulk of your data stored on bigger and less expensive HDDs. If you need the highest level of performance, go with an all\-SSD solution; for a balance of performance and capacity, use storage tiers; if capacity is your primary goal, reduce or eliminate the SSD tier.  
  
### Task 3: Design for resiliency  
How important is uninterrupted uptime for your storage? How much does your team hate replacing hardware in the middle of the night? Consider these questions while designing your storage resiliency at the cluster, pool, and virtual disk levels.  
  
#### Task 3a: Design cluster resiliency  
Consider the following cluster resiliency factors:  
  
-   **Cluster nodes** \- Use the **Node count** field in the Software\-Defined Storage Design Calculator spreadsheet to adjust the number of cluster nodes in your design. Most customers start the design process with a two\-node cluster, then add nodes if they anticipate a lot of load. For example, you might decide that you have too much load to have running on a single node during a node failure or maintenance, so you choose three nodes. Storage pools can remain online with a single cluster node as long as you have a cluster witness and at least 50% of the physical disks in your storage pool disks are available.  
  
    Note that clusters with five or more nodes can be hard to connect to each storage enclosure with redundant connections, and performance bottlenecks can occur that limit further performance gains, though some vendors provide creative solutions to these limitations.  
  
-   **SAS connections and MPIO** \- Use the **MPIO** field in the spreadsheet to specify whether to use redundant SAS connections between each node and connected storage enclosures. If you have more than one connection to each storage enclosure, you can enable Multipath I\/O \(MPIO\) to provide redundancy and increased bandwidth between the storage nodes and the storage enclosures.  
  
    It's typical to use one or two SAS HBAs \(not RAID adapters\), with two total ports and cables per node per enclosure, for redundancy. Adding more can be impractical because of the limited number of ports on a storage enclosure. Note that Storage Spaces doesn't support the use of SAS switches, though SAS expanders in storage enclosures are fine.  
  
-   **Network adapters, ports, and cables** \- How many network adapter, port, and cable failures do you want to be able to tolerate? It's typical to use one or two network adapters, with two total ports and two cables per node, for redundancy and performance, but some customers might choose to use more for increased bandwidth or to support different network configurations.  
  
    If you're using the storage to support Hyper\-V or other high\-bandwidth workloads on other servers, you'll probably need a minimum of two 10 GbE RDMA\-capable network ports per cluster node for sufficient bandwidth and resiliency. If you need to be able to route the RDMA traffic between subnets, you'll also need to select iWARP network hardware. For more info, see [Deploy SMB Direct with Ethernet \(iWARP\) Network Adapters](https://technet.microsoft.com/en-us/library/dn583825.aspx).  
  
-   **Network switches** \- How many network switch failures do you want to be able to tolerate? A two\-switch configuration is a typical choice for your datacenter network that carries traffic between your storage cluster and your Hyper\-V or other clusters consuming the storage.  
  
    If you're using redundant network connections, you'll probably want two 10 GbE switches for communication between the storage cluster and workloads that rely on it. The switches should also support the technologies necessary for proper performance with your network adapters \- for example, you'll might want to enable jumbo frames and RoCEv2 will require one or more VLANs, and priority flow control \(PFC\). You'll probably also want one or two 1 GbE switches for communication with each server node's headless management \(BMC\) interface for bare\-metal provisioning.  
  
#### Task 3b: Design storage pool resiliency  
Storage Spaces takes all your hard disks and SSDs and puts them into one or more software\-defined storage pools, from which you can carve out virtual disks. By default, returning a virtual disk to its full resiliency after a disk failure requires replacing all failed disks. Or you can design some extra capacity into each pool so that nobody has to replace disks in the middle of the night.  
  
Use the following sections to define how resilient to make your storage pool\(s\):  
  
-   **Number of pools** \- Use the **Workload pools** field in the Software\-Defined Storage Design Calculator spreadsheet to specify how many pools to use for your \(non\-backup\) workloads. Storage pools are management and fault domains, so increasing the number means more pools to manage and space set aside for virtual disk repairs, but it also limits the impact of disk failures to just the virtual disks in the pool, as shown in Table 1.  
  
    Typically you'll use one pool unless you have more than 84 disks, which is the maximum recommended number of disks per clustered storage pool. If you include more disks in a pool, it can lead to failover times increasing to the point of causing I\/Os to fail.  
  
### Table 1 \- Pool count and fault tolerance  
  
|Number of pools|Mirror type|Resiliency overhead|Pool fault tolerance<sup>1</sup>|System fault tolerance<sup>2</sup>|  
|-------------------|---------------|-----------------------|------------------------------------|--------------------------------------|  
|1|Two\-way|50%|1 Disk|1 Disk|  
||Three\-way|67%|2 Disks|2 Disks|  
|2|Two\-way|50%|1 Disk|2 Disks|  
||Three\-way|67%|2 Disks|4 Disks|  
|3|Two\-way|50%|1 Disk|3 Disks|  
||Three\-way|67%|2 Disks|6 Disks|  
|4|Two\-way|50%|1 Disk|4 Disks|  
||Three\-way|67%|2 Disks|8 Disks|  
  
<sup>1</sup>Total number of disks that can be lost in a Pool before allocated Virtual Disks are subject to data loss  
  
<sup>2</sup>Total number of failed disks in the storage system \(assuming they fail evenly across the pools\) before Virtual Disks are subject to data loss  
  
-   **SSD failures to automatically repair** \- Use the **SSDs to repair** field in the spreadsheet to specify how many SSD failures you want to automatically repair per pool, which will then calculate how much capacity to reserve in your pools. The calculation is complex, so unless you do equations for fun, we suggest using the spreadsheet to calculate it. Basically you'll need enough space in the appropriate enclosure to recreate the data on each failed disk, plus some extra margin. Note that if you have fewer data copies than enclosures, the amount of capacity to hold back is reduced because the data in a failed disk can be recreated across two enclosures instead of one.  
  
    Small\-scale deployments often don't set aside any SSD capacity, while larger deployments often set aside SSD capacity to repair one failed SSD per pool, which might also reduce the maximum column count \- disks across which data is striped \- for your virtual disks by one.  
  
-   **HDD failures to automatically repair** \- Use the **HDDs to repair** field in the spreadsheet to specify how many HDD failures you want to automatically repair per pool, which will then calculate how much capacity to reserve in your pools.  
  
    Small\-scale deployments often set aside enough HDD capacity to repair one failed HDD per pool, while larger deployments might reserve capacity for three or more repairs per pool. Note that virtual disks use the same column count for both tiers, with the maximum column count determined by the smallest tier \(usually the SSD tier\).  
  
-   **Hot spares** \- Hot spares work with Windows Server 2012 and are simple to design, but are slower than using spare pool capacity to repair virtual disks and don't save much \(if any\) capacity so we don't recommend it for Windows Server 2012 R2.  
  
    If you decide to use hot spares to recover full resiliency after one failed disk, when adding disks to the pool, set the allocation type to **hot spare** for one HDD and one SSD per pool, per enclosure \(if you're using enclosure awareness\).  
  
#### Task 3c: Design virtual disk resiliency  
There are three factors that determine how resilient the virtual disks you create from pooled space are:  
  
-   **Storage layout** \- Use the **Layout** field in the in the Software\-Defined Storage Design Calculator spreadsheet to specify your storage layout \(and data copies, which is discussed next\). Storage Spaces provides three primary storage layouts \(also known as resiliency types\), which control how resilient your data is:  
  
    -   **Mirror** \- Writes data in a stripe across multiple disks while also writing one or two extra copies of the data. Mirror is similar to a RAID 1 or RAID 10 array and balances performance with capacity.  
  
        Use the mirror layout for most workloads – it helps protect your data from disk failures and provides great performance, especially when you add SSDs to your storage pool and use storage tiers.  
  
    -   **Parity** \- Writes data in a stripe across physical disks while also writing one or two copies of parity information. Parity is pretty much the same as RAID 5 \(or RAID 6 if you're using dual\-parity\), and optimizes capacity at the expense of write performance.  
  
        Use the parity layout for archival and streaming media workloads, or other workloads where you want to maximize capacity and you’re OK with lower write performance. Parity spaces have the same performance limitations as RAID 5 and RAID 6 arrays \- they have good read performance but are much slower than mirrors for writes, especially small\-block random writes. This write slowdown is even more pronounced with dual\-parity, though you can improve it significantly by adding SSD journal disks \(captured in the **Backup reserve** > **SSD capacity** field of the spreadsheet\).  
  
    -   **Simple \(no resiliency\)** \- Writes data in a stripe across physical disks without any extra copies or parity information. It's pretty much the same as RAID 0 \- it maximizes performance and capacity, but provides no resiliency.  
  
        Because the simple layout doesn’t provide any protection from disk failures, use it only when you require the highest performance and capacity and you’re OK with losing or recreating the data if a disk fails. You can also use the simple layout when your application provides its own data protection.  
  
-   **Data copies** \- The mirror and parity layouts let you control whether you want to store two or three copies of your data, protecting you from one or two simultaneous disk failures. Deployments with a lot of disks and critical data typically use three data copies for additional protection, though this comes with a small reduction in write performance when compared to two data copies.  
  
    Note that it takes longer to repair parity spaces than mirror spaces following a disk failure because the data must be reconstructed from parity information, which can increase the likelihood of a second disk failing before the repair completes. This repair time increases as hard disk sizes increase, so if you're using the parity layout and your hard disks are bigger than 1 TB,  you'll probably want to use dual\-parity to minimize the likelihood of losing data due to two hard disks failing in rapid succession.  
  
-   **Enclosure awareness** \- Use the **Enclosure awareness** field in the in the spreadsheet to specify whether to enable enclosure awareness, making each enclosure a fault domain. Enclosure awareness stores copies of your data on different enclosures so that if an entire enclosure fails, your virtual disks remain available. If you have three or more storage enclosures \(see Table 2\), you can enable enclosure awareness.  
  
    Keeping copies of your data on separate enclosures can reduce the number of disks that are accessed simultaneously \(the column count\) per virtual disk, however, because data is striped only across disks within an enclosure instead of across all disks in the pool. While this can reduce absolute throughput for a particular virtual disk, performance in the pool typically remains high because other virtual disks can be accessed in parallel. Using a column count of 4\-6 usually provides the best balance of throughput and latency for virtualized workloads.  
  
### Table 2 \- Maximum fault tolerance without disrupting virtual disks that have enclosure awareness enabled  
  
|Resiliency type|Three enclosures|Four enclosures|  
|-------------------|--------------------|-------------------|  
|Simple|Not supported|Not supported|  
|Two\-way Mirror|1 enclosure; or 1 disk\*|1 enclosure; or 1 disk\*|  
|Three\-way Mirror|1 enclosure \+ 1 disk\*; or 2 disks\*|1 enclosure \+ 1 disk\*;<br /><br />or 2 disks\*|  
|Single Parity|Not supported|Not supported|  
|Dual Parity|Not supported|1 enclosure \+ 1 disk\*;<br /><br />or 2 disks\*|  
  
\* per pool  
  
-   **Virtual disks per node** \- Use the **Virtual disks\/node** field in the spreadsheet to specify how many virtual disks to use per node. Virtual disks can be accessed by only a single node a time, so to share load across cluster nodes, create virtual disks in multiples of the number of cluster nodes. A larger number of virtual disks per node balances load more evenly, including during a failover on three or four\-node clusters. 2\-4 virtual disks per node \(divided evenly across pools\) is a typical range of starting values, though you might need more to increase this value to prevent virtual disks from becoming too large.  
  
### Task 4: Select storage hardware  
The next task is to specify what size storage enclosures and disks to use, as well as to think about CPU and RAM requirements.  
  
-   **Storage enclosures** \- Record the number of drive slots your storage enclosure uses and whether to fill all slots with drives in the **Disk slots** and **Fill all slots** fields in the Software\-Defined Storage Design Calculator spreadsheet. It usually saves cost to increase the size of the enclosure to fit the number of disks you need until not all disks can fit in one enclosure, and then add a second, third, or fourth enclosure, evenly distributing disks across enclosures \(and probably filling each enclosure\).  
  
-   **SSD and HDD types** \- What rotational speed \(for HDDs\) and disk model meets your capacity and performance requirements and is supported by your hardware vendor? Typically customers use near line 7200 rpm HDDs in conjunction with SSDs and storage tiers \- the SSDs provide most of the performance, while the HDDs provide most of the capacity.  
  
-   **HDD size** \- Record size of your HDDs in the **HDD size** field in the spreadsheet. Check with your hardware vendor to see what they offer, but typically the biggest hard disks have the best price per TB and sufficient performance for your HDD tier.  
  
    Together with the values you entered previously, the HDD size determines how many HDDs the solution uses to get the capacity you want. The total capacity and the number of HDDs is then shown in the **Hardware Design** section of the worksheet, discussed in Step 2.  
  
-   **SSD size** \- Record the size of your SSDs in the **SSD size** field in the spreadsheet. How big should your SSDs be? This is a little trickier \- the number of SSDs in your solution determines the absolute performance of your storage \(by extension of how many SSDs can be accessed at once\), while the capacity of your SSD tiers determines how much data can be accessed at SSD speed. If you have more active data than fits on your SSD storage tiers, active data spills over onto your HDD tiers, increasing latency and decreasing the responsiveness of your workloads and how much load you can add. Note that the number of SSDs per pool usually limits the maximum column count for your virtual disks, which affects the performance of both tiers.  
  
-   **SSD\/HDD ratio** \- Use the **SSD\/HDD ratio** field in the spreadsheet to record the ratio of SSDs to HDDs in the design. When sizing a Storage Spaces solution, pick the number and size of HDDs in your solution based on how much capacity you need, then pick the number and size of your SSDs based on how much performance you need, and how much active data you have. The ratio of SSDs to HDDs is a convenient way to increase or decrease the performance of your solution. 25% SSDs by number is a typical value that provides a good balance of performance and capacity, but you can adjust this value to increase performance or decrease cost.  
  
-   **Processor** \- If your solution includes RDMA network cards, which process network traffic directly, the storage cluster nodes probably don't need the most powerful processors, though Data Deduplication performance will vary depending on your processors. Two six\-core CPUs is a typical choice for cluster nodes.  
  
-   **RAM** \- RAM on storage cluster nodes is used by Data Deduplication \(if you're using it\) and some of its caching layers, though you probably won't be able to use a CSV cache \(typically one of the largest consumers of RAM on a clustered file server\). 64 GB of RAM is a typical choice for cluster nodes.  
  
-   **Firmware and driver versions:** Which firmware and drivers versions does your hardware vendor recommend for each of your components? It's important to use versions that have been found to be free of issues at scale and under load and not just rely on the drivers that are included with Windows Server.  
  
## <a name="BKMK_Step2"></a>Step 2: Review the design and adjust as necessary  
Once you've gone through the tasks in Step 1 of this topic and the Software\-Defined Storage Design Calculator, you'll get a recommended design for your hardware and software. Figure 4 shows an example of this.  
  
![](../Image/Software-DefinedStorageDesignCalculator-Step2.jpg)  
  
**Figure 4 –** An example design from the Software\-Defined Storage Calculator spreadsheet  
  
The following sections go into some detail on the design points the spreadsheet takes into consideration.  
  
### Task 1: Understand the virtual disk design  
Here's how the Software\-Defined Storage Design Calculator designs your virtual disks:  
  
-   **HDD and SSD repair capacity** \- The amount of capacity you set aside in each pool for repairs is calculated based on how many failed disks per pool and enclosure you want to automatically repair. This capacity reduces the amount of SSD and HDD space available for each tier of your virtual disks.  
  
-   **Number of virtual disks** \- The larger the number of virtual disks, the more effort to provision and manage the virtual disks. However, to balance load evenly across nodes of a cluster, you should have at least two virtual disks per node \(four or more is typical of larger solutions\).  
  
    If you have SSDs in the pool, each virtual disk gets its own 1 GB write\-back cache, so even though increasing the number of virtual disks uses up some of your SSD tier capacity, it can also provide a minor boost to write performance.  
  
-   **Virtual disk size** \- Currently we recommend creating virtual disks that are 10 TB or smaller to maximize reliability at large scales under load.  
  
-   **HDD and SSD tier sizes** \- When sizing your storage tiers \(and by extension the size of your virtual disks\), the spreadsheet takes the total amount of SSD space in the pool, subtracts the amount of SSD capacity to preserve for repairing failed SSDs and for write\-back caches, and then divides what's left by the number of virtual disks you want to create. It does a similar calculation for HDD capacity.  
  
    Note that SMB load balancing assumes that your virtual disks are identical \(or at least symmetrical\) across cluster nodes, so if you need to create multiple types of virtual disks, create each in multiples of the number of cluster nodes so that load can be balanced more evenly.  
  
-   **Column count** \- Storage Spaces writes data across multiple disks in chunks called stripes. The number of disks in a stripe is called the column count.  
  
    Increasing the column count increases the number of physical disks across which a virtual disk is striped, which increases throughput and IOPS for that virtual disk. However, it can also increase latency. For this reason, you can optimize overall cluster performance by using multiple virtual disks with 3\-4 columns \(when using mirrors\) or seven columns when using parity spaces, which are the values the spreadsheet uses. The performance of the entire cluster remains high because multiple virtual disks are used in parallel, making up for the reduced column count.  
  
    If you want to automatically repair virtual disks after a disk failure, you can't use the maximum column count your hardware allows \- even if it matches the recommended 3\-4 column count. Instead, the spreadsheet reduces the column count by the number of SSD failures you want the pool to be able to automatically recover from \(one SSD failure is a typical design point\). The HDD tier uses the same column count as the SSD tier, so if you specify that you want to automatically repair after three failed HDDs, for example, the spreadsheet sets aside more HDD capacity in the pool, usually without affecting the column count further.  
  
    Table 3 provides formulas for calculating your column count \(assuming that you have fewer SSDs than HDDs and that you temporarily ignore any SSDs used for journal disks\), but the spreadsheet makes this much easier. Round the results down to the nearest whole number. But again, we recommend sticking to no more than 3\-4 columns for mirrors and seven for parity spaces.  
  
    ### Table 3 \- Calculating the column count for virtual disks  
  
    |Resiliency type|With enclosure\-awareness|Without enclosure\-awareness|  
    |-------------------|-----------------------------|--------------------------------|  
    |Mirror|`Columns = (Number of SSDs / Number of pools / Number of enclosures) - Number of disk failures to automatically repair`|`Columns = (Number of SSDs / Number of pools / Number of data copies) - Number of disk failures to automatically repair`|  
    |Parity|`Columns = (Number of enclosures * 2) -1`\*|`Columns = (Number of disks / Number of pools) - Number of disk failures to automatically repair`|  
  
    \*For enclosure\-aware parity spaces, disks per enclosure should be at least two plus the number of disk failures to automatically repair  
  
    > [!NOTE]  
    > When using enclosure awareness, be careful not to use a larger column count than the number of SSDs per enclosure per pool \(assuming that you have fewer SSDs than HDDs\). The Software\-Defined Storage Calculator takes this into consideration for you.  
  
-   **Write\-back cache size \-** Increasing the size of the write\-back cache usually provides little \(if any\) performance improvement, and can cause cluster failover times to increase too much while under load. That's why we recommend sticking to the default 1 GB value, even if you're using SSDs as journal disks for parity spaces and have excess SSD capacity.  
  
### Task 2: Design a virtual disk for cluster quorum  
In addition to the virtual disks you create for your data and backups, you'll probably want to create a small virtual disk to use for the cluster quorum of the storage cluster and for other clusters \(via a file share witness\).  The Software\-Defined Storage Design Calculator doesn’t design your cluster quorum virtual disk, but it’s easy to do –just use the following list:  
  
-   **Size** \- 1 GB is a minimum; more than 10 GB is probably wasting disk space unless you're using it for a lot of clusters. Note that Storage Spaces rounds up your virtual disk size to multiples of 1 GB times your column count, so you'll likely have a 4 GB or so minimum virtual disk size.  
  
-   **Resiliency type** \- You can use either a two\-way mirror or three\-way mirror for the quorum disk \- if you use VMM to create the cluster you'll get a three\-way mirror.  
  
-   **Storage tiers** \- The cluster quorum disk is small and doesn't require much performance, so there is no need for storage tiers \- you'd just be wasting SSD capacity.  
  
-   **Witness disk type** \- Once you've create the virtual disk, you can use it as a disk witness with clusters that have a SAS connection to the shared storage enclosures, or a file share witness for other clusters that can't access the shared storage directly.  
  
> [!TIP]  
> If you use the default settings when creating the cluster quorum virtual disk, data is striped across all disks in the pool, including a small amount on your SSDs. If you want to manually specify just the pool HDDs when creating the virtual disk, use Windows PowerShell to create the virtual disk, piping just the PhysicalDisk objects for the HDDs in the pool to the New\-Volume cmdlet.  
  
## <a name="BKMK_Step3"></a>Step 3: Work with a Storage Spaces hardware vendor to finalize the design  
After going through steps 1\-2 in this topic and the Software\-Defined Storage Design Calculator, you’ll have a set of recommendations that you can discuss with a hardware vendor. Once you've selected hardware, you can adjust the values in Step 1 of the spreadsheet to match the exact configuration you'll buy.  
  
Now is also a good time to chat with your hardware vendor about what sector size their disks use. Until recently, all disks used 512 byte sectors to store data. Today’s SSDs and HDDs typically use 4 KB physical sectors for storing data \(these disks are called advanced format disks\), but might present 512 byte logical sectors to the operating system for backwards compatibility \(these are called 512e disks because they emulate 512 byte sectors\). If the operating systems and applications in your virtual machines support native 4 KB sector disks \(and most recent versions do\), you’ll get optimal performance if all disks are native 4K disks instead of 512e disks. Native 4K disks use 4 KB physical and logical sectors and are faster than 512e disks because they don’t need to emulate 512 byte sectors, which involves performing additional read operations when writing \(known as read\-modify\-write\).  
  
> [!IMPORTANT]  
> For production environments, we recommend purchasing all hardware from a vendor that tests and supports the hardware as an integrated solution with Storage Spaces. [Microsoft Cloud Platform \(CPS\) Powered by Dell](http://www.microsoft.com/en-us/server-cloud/products/cloud-platform-system/) is an example of such a solution. It's also important to follow each vendor's recommendations on which driver and firmware versions to use.  
  
## <a name="BKMK_Step4"></a>Step 4: Prepare to deploy the solution  
When you get ready to deploy storage with Storage Spaces, there are some settings that you should consider changing based on our learnings with Storage Spaces in large\-scale environments, as discussed in the following tasks.  
  
### Task 1: Determine your cluster node and MPIO settings  
Here’s a list of some settings that you should consider adjusting on each cluster node:  
  
-   **Windows updates** \- We've been releasing critical updates to Windows and Storage Spaces componenents based on our large\-scale testing, so it's important to apply Windows updates to your storage cluster nodes regularly \- we recommend monthly.  
  
-   **Storage Spaces repair registry updates \-** There are some manual steps that you must take to update the way Storage Spaces repairs virtual disks \- see [Optimize Storage Spaces repair settings on Scale\-Out File Servers](https://technet.microsoft.com/en-us/library/dn858079.aspx) for more information.  
  
-   **Windows file\-delete notification \(trim\/unmap\)** \- Although Windows has built\-in support for file\-delete notification \(issuing trim commands to reclaim SSD storage\), we recommend disabling Windows file\-delete notification on servers that use Storage Spaces. To do so, from an elevated command prompt, use the following command on each node of the cluster: `Fsutil behavior set DisableDeleteNotify 1`  
  
-   **Multipath I\/O \(MPIO\) settings** \- If you're using multiple SAS connections to your storage enclosure, enable MPIO on each node of the cluster so that Storage Spaces can communicate with the enclosures over multiple cables. You'll also want to set the global MPIO policy \- **Round Robin** is the default policy, but according to our internal testing, **Least Blocks** provides increased performance under most circumstances.  
  
    To max out your performance, you can also set the policy on individual SSDs to Round Robin \(which has the effect of using Least Blocks for your HDDs, and Round Robin for SSDs\). To set the MPIO policy for individual SSDs, use the Mpclaim.exe command from each node to set the MPIO policy for each SSD. For example, to set the MPIO policy to Round Robin \(represented by a 2 in MPclaim\) for disk 10, use this command from an elevated command prompt: `Mpclaim -l -d 10 2`.  
  
-   **Physical disk caches** \- In some cases leaving disk\-based write\-caches enabled can decrease performance so we recommend disabling them on all disks. To do so, use the Diskcache.exe tool, as described in Microsoft Knowledge Base article [811392](http://support.microsoft.com/en-us/kb/811392).  
  
### Task 2: Determine your storage pool, volume, and .vhdx settings  
There are a few storage pool and volume settings that are important to set:  
  
-   **How to retire missing physical disks \-** To enable Storage Spaces to use spare pool capacity to repair virtual disks after a failed physical disk, use the [Set\-StoragePool](http://technet.microsoft.com/library/hh848672.aspx) cmdlet to set the `RetireMissingPhysicalDisks` policy to `Always`.  
  
    If you're doing anything that could temporarily affect the connectivity of multiple disks, such as replacing a tray for multiple disks, set the policy to **Never** during the maintenance action. If your environment uses hot spare disks, leave the policy set to **Auto**.  
  
-   **Whether to enable large File Record Segment \(FRS\) on volumes** \- To allow large .vhdx files to properly be extended, there are new recommendations for formatting volumes. When formatting volumes that will be hosting very large files, such as .vhdx files larger than 1 TB, use the [Format\-Volume](https://technet.microsoft.com/library/dn454966.aspx) cmdlet with the `-AllocationUnitSize 64KB –UseLargeFRS` parameters to format volumes with 64 KB NTFS allocation unit size and enable large FRS support.  
  
-   **Whether to use 4 KB logical sectors for your storage pools** – To maintain compatibility with older server applications, Storage Spaces uses 512 byte sectors for virtual disks unless there are any 4K native disks in the pool when you create it \(see Table 4\). However, you can’t add 4K native disks to a pool that uses 512 byte sectors for virtual disks, so if you think you might ever add a 4K native disk to the pool \(such as when replacing a failed disk\), create your pools with 4 KB logical sectors, even if you don’t yet have any 4K native disks.  
  
    To check the sector sizes used by your physical disks, use the following Windows PowerShell command: `Get-PhysicalDisk | Sort-Object SlotNumber | Select-Object SlotNumber, FriendlyName, Manufacturer, Model, PhysicalSectorSize, LogicalSectorSize | Format-Table`  
  
    To create a storage pool with 4 KB logical sectors, use the [New\-StoragePool](http://technet.microsoft.com/library/hh848689.aspx) cmdlet with the `–LogicalSectorSizeDefault 4096` parameter to force the pool to use 4 KB logical sectors when you create it.  
  
    ### Table 4 – The default sector sizes used by Windows Server with different disk types  
  
    |Disk types in pool|Disk physical sector size|Disk logical sector size|Storage Spaces logical sector size|.vhdx physical sector size|.vhdx logical sector size|  
    |----------------------|-----------------------------|----------------------------|--------------------------------------|------------------------------|-----------------------------|  
    |**512 native** \(older disks\)|512 bytes|512 bytes|512 bytes|512 bytes|512 bytes|  
    |**512e**\*|4 KB|512 bytes|512 bytes|512 bytes|512 bytes|  
    |**4K native** \(or a mix of 4K native & 512e\*\)|4 KB|4 KB \(and 512 bytes if you have any 512e disks\)|4 KB|4 KB|512 bytes|  
  
    <sup>*</sup>You could also have 512 native disks mixed in – we’re omitting them for simplicity.  
  
-   **Whether to use 4 KB logical sectors for .vhdx files** – By default, Hyper\-V uses 512 byte logical sectors for .vhdx virtual hard disks to maintain compatibility with older applications, even if the underlying storage pool and disks use 4 KB logical sectors \(see Table 4\). Hyper\-V essentially creates 512e virtual hard disks. However, most applications these days support 4 KB logical sectors, so if your pool uses 4 KB logical sectors, you can optimize performance by creating your .vhdx files with 4 KB logical sectors as well.  
  
    To create a .vhdx file with 4 KB logical sectors, use the following example: `New-VHD -Path C:\ClusterStorage\Volume1\sharedvhdx.vhdx -SizeBytes 200GB -PhysicalSectorSizeBytes 4KB -LogicalSectorSizeBytes 4KB`  
  
    For more information about advanced format disks, see [Understanding the Impact of Large Sector Media for IT Pros](https://technet.microsoft.com/en-us/library/hh147334(v=ws.10).aspx), [Hyper\-V Support for Large Sector Disks Overview](https://technet.microsoft.com/en-us/library/hh831459.aspx), and [Advanced Format \(4K\) Disk Compatibility Update](https://msdn.microsoft.com/library/windows/desktop/hh848035.aspx).  
  
    > [!NOTE]  
    > If your storage pool uses 4 KB logical sectors but you have shared .vhdx files that use the default 512 byte logical sectors, you could see the following error when initializing a shared .vhdx file: `The request could not be performed because of an I/O device error`. To resolve this problem, install the hotfix included in Microsoft Knowledge Base Article [3025091](https://support.microsoft.com/kb/3025091).  
  
-   **Whether to use multiple sources when repairing virtual disks \(repair policy \- aka rebuild priority\)** \- If you're using spare pool capacity to repair virtual disks after physical disk failures, repairs by default copy data in parallel from multiple disks at a time, reducing the time it takes to return to full resiliency. If you want to minimize the impact to other I\/O operations during the repair process, you can instead enable sequential repairs, which copies one slab \(disk extent\) at a time. However, sequential repairs generally aren't necessary to maintain good performance.  
  
    Most SAS SSDs optimize their storage reclamation and device lifetimes without assistance from the operating system, and we've occasionally seen SSDs increase latency when processing trim commands from the operating system, reducing performance. We're continuing to work with SSD manufacturers as well as our Storage Spaces solution hardware vendors to ensure the best behavior between Windows and flash memory and will update this page if the situation changes.  
  
-   **Whether your storage has redundant sources of power** \- If your storage nodes and enclosures have redundant power supplies and sources of power \(such as a uninterruptable power supply – UPS – or service from multiple electric utilities\), you can use Windows PowerShell to enable the **IsPowerProtected** switch on your storage pools, which increases write performance by disabling write\-through operations at the disk level, relying on the disk to always complete the operation.  
  
    However, enabling **IsPowerProtected** will lead to data corruption if the node or storage enclosures lose power during a write operation, making it critically important to ensure redundant and reliable power.  
  
### Task 3: Determine CSV and Data Deduplication settings  
Depending on your workload, you might want to enable Data Deduplication or a CSV cache:  
  
-   **Data deduplication** \- If you have workloads that are compatible with Data Deduplication, such as backups, VHD libraries, and VDI deployments, you can enable deduplication on the relevant virtual disks.  
  
    For more info, see [Plan to Deploy Data Deduplication](https://technet.microsoft.com/en-us/library/hh831700.aspx), and [Large scale Virtual Desktop Infrastructure deployment using Windows Server 2012 R2 with Storage Tiers and Data Deduplication](http://download.microsoft.com/download/8/8/F/88FB4BBF-8ADC-41E0-A64F-489CEEF5218E/WindowsServer2012R2DeduplicatedVDIDeployment.docx)  
  
-   **Cluster shared volumes \(CSV\) and file shares** \- To minimize administration overhead and make it easier to balance load across your shares and cluster nodes, you'll usually want to create a single CSV per virtual disk, and a single continuously available file share per CSV.  
  
-   **CSV cache** \- You can allocate system memory from the nodes of the cluster to a CSV cache that can improve performance of reads from workloads such as Hyper\-V. However, the CSV cache isn't used by tiered virtual disks \(which are probably your primary data disks\), or virtual disks that use Data Deduplication \(which are probably your backup disks\), which might leave nothing left to use the CSV cache for… If you do find a reason to use the CSV cache with your storage cluster \- maybe you've got a lot of virtual disks that don't use storage tiers \- the maximum size of the CSV cache that you should use in Windows Server 2012 R2 is 64 GB.  
  
## Next steps  
After you complete the steps in this topic, you'll have a design for your storage solution's hardware and software. Once you've worked with your hardware vendor to finalize your hardware and then adjusted your software design based on your final hardware selections, it's time to deploy Windows Server and create your storage pools, virtual disks, and file shares.  
  
For information about deploying Storage Spaces, see [Deploy Clustered Storage Spaces](https://technet.microsoft.com/en-us/library/jj822937.aspx).  
  
## <a name="BKMK_AppendixA"></a>Appendix A: Choose deployment and management tools  
When determining which deployment and management tools to use, consider the scale of your solution and current infrastructure, as well as your team's skills and preferences.  
  
### Task 1: Choose deployment tools  
Deploying the storage solution involves the following:  
  
1.  Install Windows Server on each node \(if it wasn't installed at the factory\)  
  
2.  Join the cluster nodes to your domain and do other initial configuration tasks  
  
3.  Create the cluster  
  
4.  Create storage pools and virtual disks  
  
5.  Create file shares  
  
See Table 5 for a listing of common deployment tools \(you might want to use a couple of them\). For example, if you have a two\-node cluster, you can probably use Failover Cluster Manager and Server Manager along with a little bit of Windows PowerShell.  
  
But if you have a three\-node cluster that you're using for data and backup storage, you'll probably want to create 13 file shares \(2 data shares and 2 backup shares per cluster node, plus 1 file share quorum\) \- which also means creating 13 volumes, 13 virtual disks, and probably 3 storage pools. That's 42 objects\! For that many objects, you might use an existing VMM installation to deploy the cluster, a Windows PowerShell script to automate the creation of the pools, tiered virtual disks, and volumes, and a VMM script to create the files shares and assign appropriate permissions.  
  
### Table 5 \- Storage Spaces deployment tools  
  
|Tool|Advantages|Disadvantages|  
|--------|--------------|-----------------|  
|Failover Cluster Manager & Server Manager|-   Easy to use|-   Slow automatic refreshes in Server Manager when working with storage<br />-   Some tasks require Windows PowerShell<br />-   No automation can make provisioning more than a couple virtual disks and file shares tedious|  
|System Center Virtual Machine Manager|-   Easy to use<br />-   Partial automation of cluster deployment<br />-   Automated management of file share permissions<br />-   Can be used to deploy and manage VMs|-   Some tasks require Windows PowerShell \(including storage tiers\)<br />-   Requires System Center licenses<br />-   Might require additional infrastructure if you don't already have System Center or are deploying at a scale that's greater than your existing deployment can handle|  
|Microsoft Deployment Toolkit|-   Lots of control over operating system installation options<br />-   Can be used to deploy other PCs and servers|-   Can be complex<br />-   Some approaches require System Center Configuration Manager licenses|  
|Windows PowerShell|-   Complete control over all aspects of storage<br />-   Can automate by writing scripts|-   Requires knowledge of Windows PowerShell<br />-   Scripts require development and testing|  
  
### Task 2: Choose management tools  
After you've deployed your storage, some of the management tasks you'll perform include monitoring for failed physical disks or other issues, replacing disks that fail, and updating firmware and drivers.  
  
See Table 6 for the most common management options \(which overlap a lot with your deployment options\).  
  
### Table 6 \- Storage Spaces management tools  
  
|Tool|Advantages|Disadvantages|  
|--------|--------------|-----------------|  
|Failover Cluster Manager & Server Manager|-   Easy to use<br />-   Graphical displays for monitoring|-   Slow automatic refreshes in Server Manager when working with storage<br />-   Performance and usability decreases with large numbers of objects<br />-   Some tasks require Windows PowerShell|  
|System Center Virtual Machine Manager & Operations Manager|-   Easy to use<br />-   Graphical displays for monitoring multiple systems<br />-   Alerting for common problems<br />-   Common tool for managing VMs and storage|-   Some tasks require Windows PowerShell<br />-   Requires System Center licenses<br />-   Might require additional infrastructure if you don't already have System Center or are deploying at a scale that's greater than your existing deployment can handle|  
|Windows PowerShell|-   Complete control over all aspects of storage<br />-   Can automate by writing scripts<br />-   Powerful [example scripts](https://gallery.technet.microsoft.com/scriptcenter/Test-StorageHealthps1-66d84fd4) available|-   Requires knowledge of Windows PowerShell<br />-   Arguably more difficult to get an intuitive sense of overall storage health.<br />-   Scripts require development and testing|  
  
## See also  
  
|Content type|References|  
|----------------|--------------|  
|Evaluation|-   [Storage Spaces Overview](../Topic/Storage-Spaces-Overview.md)<br />-   [Provide cost\-effective storage for Hyper\-V workloads by using Windows Server](https://technet.microsoft.com/en-us/library/dn554251.aspx)<br />-   [Microsoft Cloud Platform System Storage Performance](https://www.microsoft.com/en-us/download/details.aspx?id=45917&WT.mc_id=Blog_WS_Announce_TTD)|  
|Planning|-   [Scale-Out File Server for Application Data Overview_1](../Topic/Scale-Out-File-Server-for-Application-Data-Overview_1.md)<br />-   [Plan to Deploy Data Deduplication](../Topic/Plan-to-Deploy-Data-Deduplication.md)<br />-   [Storage Spaces \- Designing for Performance](http://social.technet.microsoft.com/wiki/contents/articles/15200.storage-spaces-designing-for-performance.aspx)<br />-   [Spaces\-Based, Software\-Defined Storage: Design and Configuration Best Practices](http://channel9.msdn.com/events/Ignite/2015/BRK3463) \(a video based on an early version of this topic\)|  
|Deployment|-   [MPIO Policies](https://technet.microsoft.com/en-us/library/dd851699.aspx)<br />-   [Deploy Clustered Storage Spaces](https://technet.microsoft.com/en-us/library/jj822937.aspx)<br />-   [Large scale Virtual Desktop Infrastructure deployment using Windows Server 2012 R2 with Storage Tiers and Data Deduplication](http://download.microsoft.com/download/8/8/F/88FB4BBF-8ADC-41E0-A64F-489CEEF5218E/WindowsServer2012R2DeduplicatedVDIDeployment.docx)<br />-   [Adding and Managing Hyper\-V Hosts and Scale\-Out File Servers in VMM](https://technet.microsoft.com/en-us/library/gg610671.aspx)<br />-   [Deploy SMB Direct with Ethernet \(iWARP\) Network Adapters](https://technet.microsoft.com/en-us/library/dn583825.aspx)|  
|Operations|-   [Test\-StorageHealth.ps1 \- Storage Cluster Health Test](https://gallery.technet.microsoft.com/scriptcenter/Test-StorageHealthps1-66d84fd4)<br />-   [Microsoft System Center Operations Manager Management Pack for Windows Server Storage Spaces 2012 R2](http://www.microsoft.com/en-us/download/details.aspx?id=46832)|  
  
