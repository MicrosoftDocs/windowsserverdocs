---
title: Health Service in Windows Server 2016
ms.custom: na
ms.prod: windows-server-threshold
manager: dongill
ms.author: JGerend
ms.technology:
  - techgroup-storage
ms.reviewer: na
ms.suite: na
ms.technology:
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5bc71e71-920e-454f-8195-afebd2a23725
author: kumudd
---
# Health Service in Windows Server 2016
> Applies To: Windows Server 2016

The Health Service is a new feature in Windows Server 2016 which significantly improves the day-to-day monitoring, operations, and maintenance experience of Storage Spaces. In Windows Server 2016, it is supported only for Storage Spaces Direct.  

## Prerequisites  

The Health Service is enabled by default with Storage Spaces Direct. No additional action is required to set it up or start it. To learn more about Storage Spaces Direct, see [Storage Spaces Direct in Windows Server 2016](../../storage/storage-spaces-direct/overview.md).  

## Metrics  

The Health Service vastly reduces the work required to get live performance and capacity information from your Storage Spaces Direct cluster. One new cmdlet provides a curated list of essential Metrics, which are collected efficiently and aggregated dynamically across nodes, with built-in logic to detect cluster membership. All values are real-time and point-in-time only.  

### Coverage  

In Windows Server 2016, the Health Service provides the following Metrics:  
-   IOPS (Read, Write, Total)  
-   IO Throughput (Read, Write, Total)  
-   IO Latency (Read, Write)  
-   Physical Capacity (Total, Remaining)  
-   Pool Capacity (Total, Remaining)  
-   Volume Capacity (Total, Remaining)  
-   CPU Utilization %, All Machines Average  
-   Memory, All Machines (Total, Available)  

### Usage  

To get Metrics for the entire Storage Spaces Direct cluster run the following PowerShell cmdlet. The **&lt;Count&gt;** parameter indicates how many sets of values to return, at one second intervals.  

        Get-StorageSubSystem clus* | Get-StorageHealthReport -Count <Count>  

You can also get Metrics for one specific volume or node using the following cmdlets:  

         Get-Volume -FileSystemLabel <Label> | Get-StorageHealthReport -Count <Count>  

         Get-StorageNode -Name <NAME> | Get-StorageHealthReport -Count <Count>  

> [!NOTE]
> The Metrics returned in each case will be the subset applicable to that scope.  


### Capacity: Putting It All Together  

The notion of available capacity in Storage Spaces is nuanced. To help you plan effectively, the Health Service provides six distinct Metrics for capacity. Here is what each represents:  

-   Physical Capacity Total: The sum of the raw capacity of all physical storage devices managed by the cluster.  

-   Physical Capacity Available: The physical capacity which is not in any non-primordial storage pool.  

-   Pool Capacity Total: The amount of raw capacity in storage pools.  

-   Pool Capacity Available: The pool capacity which is not allocated to the footprint of volumes.  

-   Volume Capacity Total: The total usable ("inside") capacity of existing volumes.  

-   Volume Capacity Available: The amount of additional data which can be stored in existing volumes.  

The following diagram illustrates the relationship between these quantities.  

![Breakdown of Capacity Metrics](media/overview-CapacityMetricsBreakdown.png)  


## Faults  

The Health Service constantly monitors your Storage Spaces Direct cluster to detect problems and generate "Faults". One new cmdlet displays any current Faults, allowing you to easily verify the health of your deployment without looking at every entity or feature in turn. Faults are designed to be precise, easy to understand, and actionable.  

Each Fault contains five important fields:  

-   Severity  

-   Description of the problem  

-   Recommended next step(s) to address the problem  

-   Identifying information for the faulting entity  

-   Its physical location (if applicable)  

For example, here is a typical fault:  

     Severity: MINOR                                         

     Reason: Connectivity has been lost to the physical disk.                           

     Recommendation: Check that the physical disk is working and properly connected.    

     Part: Manufacturer Contoso, Model XYZ9000, Serial 123456789                        

     Location: Seattle DC, Rack B07, Node 4, Slot 11                                  |  


 >[!NOTE]
 > The physical location is derived from your fault domain configuration. For more information about fault domains, see [Fault Domains in Windows Server 2016](../fault-domains.md). If you do not provide this information, the location field will be less helpful - for example, it may only show the slot number.  

### Coverage  

In Windows Server 2016, the Health Service provides the following Fault coverage:  

-   **Essential cluster hardware**:  

    -   Node down, quarantined, or isolated  

    -   Node network adapter failure, disabled, or disconnected  

    -   Node missing one or more cluster networks  

    -   Node temperature sensor  

-   **Essential storage hardware**:  

    -   Physical disk media failure, lost connectivity, or unresponsive  

     -   Storage enclosure lost connectivity  

    -   Storage enclosure fan failure or power supply failure  

    -   Storage enclosure current, voltage, or temperature sensors triggered  

-   **The Storage Spaces software stack**:  

    -   Storage pool unrecognized metadata  

    -   Data not fully resilient, or detached  

    -   Volume low capacity<sup>1</sup>  

-   **Storage Quality of Service (Storage QoS)**  

    -   Storage QoS malformed policy  

    -   Storage QoS policy breach<sup>2</sup>  

-   **Storage Replica**  

    -   Replication failed to sync, write, start, or stop  

    -   Target or source replication group failure or lost communication  

    -   Unable to meet configured recovery point objective  

    -   Log or metadata corruption  

-   **Health Service**  

    -   Any issues with automation, described in later sections  

    -   Quarantined physical disk device  

       <sup>1</sup>  Indicates the volume has reached 80% full (minor severity) or 90% full (major severity).  

       <sup>2</sup> Indicates some .vhd(s) on the volume have not met their Minimum IOPS for over 10% (minor), 30% (major), or 50% (critical) of rolling 24-hour window.  

>[!NOTE]
> The health of storage enclosure components such as fans, power supplies, and sensors is derived from SCSI Enclosure Services (SES). If your vendor does not provide this information, the Health Service cannot display it.  

### Usage  

To see any current Faults, run the following cmdlet in PowerShell:  

        Get-StorageSubSystem clus* | Debug-StorageSubSystem  

This returns any Faults which affect the overall Storage Spaces Direct cluster. Most often, these Faults relate to hardware or configuration. If there are no Faults, this cmdlet will return nothing.  

>[!NOTE]
> In a non-production environment, and at your own risk, you can experiment with this feature by triggering Faults yourself - for example, by removing one physical disk or shutting down one node. Once the Fault has appeared, re-insert the physical disk or restart the node and the Fault will disappear again.  

You can also view Faults that are affecting only specific volumes or file shares with the following cmdlets:  

        Get-Volume -FileSystemLabel <Label> | Debug-Volume  

        Get-FileShare -Name <Name> | Debug-FileShare  

This returns returns any Faults which affect only the specific volume or file share. Most often, these Faults relate to data resiliency or features like Storage QoS or Storage Replica.  

>[!NOTE]
> In Windows Server 2016 Technical Preview, it may take up to 30 minutes for certain Faults to appear. Improvements are forthcoming in subsequent releases.   

### Root Cause Analysis  

Starting in Technical Preview 5, the Health Service can assess the potential causality among faulting entities to identify and combine faults which are consequences of the same underlying problem. By recognizing chains of effect, this makes for less chatty reporting. For now, this functionality is limited to nodes, enclosures, and physical disks in the event of lost connectivity.  

For example, if an enclosure has lost connectivity, it follows that those physical disk devices within the enclosure will also be without connectivity. Therefore, only one Fault will be raised for the root cause - in this case, the enclosure.  

## Actions  

The next section describes workflows which are automated by the Health Service. To verify that an action is indeed being taken autonomously, or to track its progress or outcome, the Health Service generates "Actions". Unlike logs, Actions disappear shortly after they have completed, and are intended primarily to provide insight into ongoing activity which may impact performance or capacity (e.g. restoring resiliency or rebalancing data).  

### Usage  

One new PowerShell cmdlet displays all Actions:  

    Get-StorageHealthAction  

### Coverage  

In Windows Server 2016, the **Get-StorageHealthAction** cmdlet can return any of the following information:  

-   Retiring failed, lost connectivity, or unresponsive physical disk  

-   Switching storage pool to use replacement physical disk  

-   Restoring full resiliency to data  

-   Rebalancing storage pool  

## Automation  
This section describes workflows which are automated by the Health Service in the disk lifecycle.  

### Disk Lifecycle   

The Health Service automates most stages of the physical disk lifecycle. Let's say that the initial state of your deployment is in perfect health - which is to say, all physical disks are working properly.  

#### Retirement  

Physical disks are automatically retired when they can no longer be used, and a corresponding Fault is raised. There are several cases:  

-   Media Failure: the physical disk is definitively failed or broken, and must be replaced.  

-   Lost Communication: the physical disk has lost connectivity for over 15 consecutive minutes.  

-   Unresponsive: the physical disk has exhibited latency of over 5.0 seconds three or more times within an hour.  

>[!NOTE]
> If connectivity is lost to many physical disks at once, or to an entire node or storage enclosure, the Health Service will *not* retire these disks since they are unlikely to be the root problem.  

If the retired disk was serving as the cache for many other physical disks, these will automatically be reassigned to another cache disk if one is available. No special user action is required.  

#### Restoring resiliency  

Once a physical disk has been retired, the Health Service immediately begins copying its data onto the remaining physical disks, to restore full resiliency. Once this has completed, the data is completely safe and fault tolerant anew.  

>[!NOTE]
> This immediate restoration requires sufficient available capacity among the remaining physical disks.  

#### Blinking the indicator light  

If possible, the Health Service will begin blinking the indicator light on the retired physical disk or its slot. This will continue indefinitely, until the retired disk is replaced.  

>[!NOTE]
> In some cases, the disk may have failed in a way that precludes even its indicator light from functioning - for example, a total loss of power.  

#### Physical replacement  

You should replace the retired physical disk when possible. Most often, this consists of a hot-swap - i.e. powering off the node or storage enclosure is not required. See the Fault for helpful location and part information.  

#### Quarantine  

When the replacement disk is inserted, it will be verified against the Allow List of supported devices. See the next section to learn more.  

#### Pooling  

If allowed, the replacement disk is automatically substituted into its predecessor's pool to enter use. At this point, the system is returned to its initial state of perfect health, and then the Fault disappears.  

## Quarantine  
The Health Service provides an enforcement mechanism to restrict the components and devices used by a Spaces Direct cluster to those on an Allow List provided by the administrator or solution vendor. This can be used to prevent mistaken use of unsupported hardware by you or others, which may help with warranty or support contract compliance. As of Technical Preview 5, this functionality is limited to physical disk devices, including SSDs, HDDs, and NVMe devices. The Allow List can restrict on model, manufacturer (optional), and firmware version (optional).  
 If an Allow List is specified, unlisted disk devices are prevented from joining pools, which effectively precludes their use in production. If no Allow List is specified, any disk device will be allowed to join pools.   

>[!IMPORTANT]
> This does not apply retroactively to drives already pooled and in use.  

### Usage  

The Allow List is specified using an XML-inspired syntax. We recommend using your favorite text editor, such as Visual Studio Code (available for free [here](http://code.visualstudio.com/)) or Notepad, to create an XML document which you can save and reuse.  

**Example Allow List**  

    <Components>  
     <Disks>  
       <Disk>  
         <Manufacturer>Contoso</Manufacturer>  
         <Model>XYZ9000</Model>  
         <AllowedFirmware>  
          <Version>2.0</Version>  
          <Version>2.1</Version>  
          <Version>2.2</Version>  
        </AllowedFirmware>  
       </Disk>  
     </Disks>  
    </Components>         

To allow multiple disk devices, simply add additional **&lt;Disk&gt;** tags with the fields you'd like to restrict on.  

To set the Allow List, run the following PowerShell cmdlet:  

    $xml = Get-Content <Path/To/File.xml> | Out-String  
    Get-StorageSubSystem clus* | Set-StorageHealthSetting -Name "System.Storage.SupportedComponents.Document" -Value $xml  


>[!NOTE]
>The model, manufacturer, and the firmware version properties should exactly match the values that you get using the **Get-PhysicalDisk** cmdlet. This may differ from your "common sense" expectation, depending on your vendor's implementation. For example, rather than "Contoso", the manufacturer may be "CONTOSO-LTD", or it may be blank while the model is "Contoso-XZY9000".  

You can verify using the following PowerShell cmdlet:  

    Get-PhysicalDisk | Select Model, Manufacturer, FirmwareVersion  

## See also  
- [Release Notes: Important Issues in Windows Server 2016](../../get-started/Release-Notes--Important-Issues-in-Windows-Server-2016-Technical-Preview.md)  
- [Storage Spaces Direct in Windows Server 2016](../../storage/storage-spaces-direct/overview.md)  
