---
title: Fault Domains in Windows Server 2016 Technical Preview
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology:
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d7cf0541-7346-409f-a827-f12dc864b4bb
author: kumudd
---
# Fault Domains in Windows Server 2016 Technical Preview

>Applies To: Windows Server Technical Preview


A fault domain is a set of hardware components that share a single point of failure. For example, all physical disk drives in one server are vulnerable to that server going down; similarly, all servers in one rack are vulnerable to that rack going down. Even, everything in one geographic site may be vulnerable to power outages or natural disasters.  


Fault domains are closely related to the concept of “fault tolerance”. To be fault tolerant to any given level, it is necessary to have multiple fault domains at that level. For example, to be “rack fault tolerant”, your servers and your data must be distributed across multiple racks.  

## Benefits  

The operating system on any particular server is very likely unaware of its physical circumstance. In general, two Windows Server instances may not be able to tell whether they are adjacent or hundreds of miles apart. In Windows Server 2016 Technical Preview, it is possible to make this distinction by specifying the arrangement of your hardware across several levels of fault domains.  

Benefits of doing so include:  

-   **Storage Spaces, including Storage Spaces Direct, use fault domains to maximize data safety.** Resiliency in Storage Spaces arises from keeping multiple synchronized copies of any data. When one copy is lost, others are recopied to restore resiliency. To achieve the best possible resiliency, copies should be kept in separate fault domains.  

-   **The Health Service uses fault domains to provide more helpful alerts.** Each fault domain can include an optional, freeform location descriptor, the contents of which will automatically be included in any subsequent alerts. These descriptors can assist operations or maintenance personnel and reduce errors by disambiguating hardware.  

-   **Stretch Clustering uses fault domains to determine preferred ownership.** Stretch clustering allows faraway servers to join a common cluster. For the best performance, applications or virtual machines should be run on servers that are nearby to those providing their storage. If fault domains are specified, the Stretch Cluster will do this automatically.  

## Levels of Fault Domains  

There are four levels of fault domains – Site, Rack, Chassis, and Node. Nodes are discovered automatically; each additional level is optional. For example, if your deployment does not use blade servers, the Chassis level may not make sense for you.  

   ![](media/Fault-Domains-in-Windows-Server-2016/Clustering_FaultDomains.png)  
## Usage  

   >[!IMPORTANT]
   > If you intend to configure fault domains, you must do so *before* running the **Enable-ClusterS2D** cmdlet. By default, Storage Spaces Direct configures itself to provide fault tolerance to nodes and their direct-attached storage. To achieve site fault tolerance, use Storage Replica.  

Fault domains are specified using an XML-inspired syntax. We recommend using your favorite text editor, such as Visual Studio Code (available for free *[here](https://code.visualstudio.com/)*) or Notepad, to create an XML document which you can save and reuse.  

In PowerShell, run the following cmdlet.  

    Get-ClusterFaultDomainXML  

This returns the current fault domain specification for the cluster, as XML. This reflects every discovered **&lt;Node&gt;**, wrapped in opening and closing **&lt;Topology&gt;** tags.  

Run the following to save this output to a file.  

    Get-ClusterFaultDomainXML | Out-File <Path>  
Open the file, and add **&lt;Site&gt;**, **&lt;Rack&gt;**, and **&lt;Chassis&gt;** tags to specify how these nodes are distributed across sites, racks, and chassis. Every tag must be identified by a unique **Name**. For nodes, you must keep the node’s name as populated by default.  

>[!IMPORTANT]
> While all additional tags are optional, they must adhere to the transitive Site &gt; Rack &gt; Chassis &gt; Node hierarchy, and must be properly closed.  
In addition to name, freeform **Location="…"** and **Description="…"** descriptors can be added to any tag.  

### Example: Two Sites, One Rack Each  

        <Topology>  
          <Site Name="SEA" Location="Contoso HQ, 123 Example St, Room 4010, Seattle">  
            <Rack Name="A01" Location="Aisle A, Rack 01">  
              <Node Name="Server01" Location="Rack Unit 33" />  
              <Node Name="Server02" Location="Rack Unit 35" />  
              <Node Name="Server03" Location="Rack Unit 37" />  
            </Rack>  
          </Site>  
          <Site Name="NYC" Location="Regional Datacenter, 456 Example Ave, New York City">  
            <Rack Name="B07" Location="Aisle B, Rack 07">  
              <Node Name="Server04" Location="Rack Unit 20" />  
              <Node Name="Server05" Location="Rack Unit 22" />  
              <Node Name="Server06" Location="Rack Unit 24" />  
            </Rack>  
          </Site>  
        </Topology>  

### Example: Two Chassis, Blade Servers  

        <Topology>  
          <Rack Name="A01" Location="Contoso HQ, Room 4010, Aisle A, Rack 01">  
            <Chassis Name="Chassis01" Location="Rack Unit 2 (Upper)" >  
              <Node Name="Server01" Location="Left" />  
              <Node Name="Server02" Location="Right" />  
            </Chassis>  
            <Chassis Name="Chassis02" Location="Rack Unit 6 (Lower)" >  
              <Node Name="Server03" Location="Left" />  
              <Node Name="Server04" Location="Right" />  
            </Chassis>  
          </Rack>  
        </Topology>  

To set the new fault domain specification, save your XML and run the following in PowerShell.  

    $xml = Get-Content <Path> | Out-String  
    Set-ClusterFaultDomainXML -XML $xml  

This guide presents just two examples, but the &lt;**Site**&gt;, &lt;**Rack**&gt;, &lt;**Chassis**&gt;, and &lt;**Node**&gt; tags can be mixed and matched in many additional ways to reflect the physical topology of your deployment, whatever that may be. We hope these examples illustrate the flexibility of these tags and the value of freeform location descriptors to disambiguate them.  

>[!IMPORTANT]
>The cluster cannot verify the correctness of your fault domains – they are accepted as-is. If hardware is moved or added later, the XML should be updated and reset accordingly. Stretch Clustering preferential ownership and Health Service alerts will dynamically adjust to these changes. However, once the pool and volumes have been created, Storage Spaces Direct will not retroactively move data in response to changes. For this reason, moving nodes between chassis, racks, or sites after enabling Storage Spaces Direct is not recommended nor supported unless you first evict the node and its drives from the pool.  
## See Also  

-   [Windows Server 2016 Technical Preview 5](../../get-started/Windows-Server-2016-Technical-Preview-5.md)  

-   [Storage Spaces Direct in Windows Server 2016 Technical Preview](Storage-Spaces-Direct-in-Windows-Server-2016-Technical-Preview.md)  

