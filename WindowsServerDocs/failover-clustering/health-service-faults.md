---
title: Health Service faults
ms.prod: windows-server-threshold
manager: eldenc
ms.author: cosdar
ms.technology: storage-health-service
ms.topic: article
ms.assetid:
author: cosmosdarwin
ms.date: 08/14/2017
---
# Health Service faults
> Applies to Windows Server 2016

The Health Service is a new feature in Windows Server 2016 that improves the day-to-day monitoring and operational experience for clusters running Storage Spaces Direct.

## Faults  

The Health Service constantly monitors your Storage Spaces Direct cluster to detect problems and generate "Faults". One new cmdlet displays any current Faults, allowing you to easily verify the health of your deployment without looking at every entity or feature in turn. Faults are designed to be precise, easy to understand, and actionable.  

Each Fault contains five important fields:  

-   Severity
-   Description of the problem
-   Recommended next step(s) to address the problem
-   Identifying information for the faulting entity
-   Its physical location (if applicable)

For example, here is a typical fault:  

```
Severity: MINOR                                         
Reason: Connectivity has been lost to the physical disk.                           
Recommendation: Check that the physical disk is working and properly connected.    
Part: Manufacturer Contoso, Model XYZ9000, Serial 123456789                        
Location: Seattle DC, Rack B07, Node 4, Slot 11
```

 >[!NOTE]
 > The physical location is derived from your fault domain configuration. For more information about fault domains, see [Fault Domains in Windows Server 2016](fault-domains.md). If you do not provide this information, the location field will be less helpful - for example, it may only show the slot number.  

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

```PowerShell
Get-StorageSubSystem Cluster* | Debug-StorageSubSystem  
```

This returns any Faults which affect the overall Storage Spaces Direct cluster. Most often, these Faults relate to hardware or configuration. If there are no Faults, this cmdlet will return nothing.  

>[!NOTE]
> In a non-production environment, and at your own risk, you can experiment with this feature by triggering Faults yourself - for example, by removing one physical disk or shutting down one node. Once the Fault has appeared, re-insert the physical disk or restart the node and the Fault will disappear again.  

You can also view Faults that are affecting only specific volumes or file shares with the following cmdlets:  

```PowerShell
Get-Volume -FileSystemLabel <Label> | Debug-Volume  

Get-FileShare -Name <Name> | Debug-FileShare  
```

This returns any faults that affect only the specific volume or file share. Most often, these Faults relate to data resiliency or features like Storage QoS or Storage Replica.  

>[!NOTE]
> In Windows Server 2016, it may take up to 30 minutes for certain Faults to appear. Improvements are forthcoming in subsequent releases.   

### Root Cause Analysis  

The Health Service can assess the potential causality among faulting entities to identify and combine faults which are consequences of the same underlying problem. By recognizing chains of effect, this makes for less chatty reporting. For now, this functionality is limited to nodes, enclosures, and physical disks in the event of lost connectivity.  

For example, if an enclosure has lost connectivity, it follows that those physical disk devices within the enclosure will also be without connectivity. Therefore, only one Fault will be raised for the root cause - in this case, the enclosure.  

## See also

- [Health Service in Windows Server 2016](health-service-overview.md) 
- [Developer documentation, sample code, and API reference on MSDN](https://msdn.microsoft.com/windowshealthservice)
