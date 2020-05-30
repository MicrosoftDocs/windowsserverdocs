---
title: Health Service in Windows Server
ms.prod: windows-server
manager: eldenc
ms.author: cosdar
ms.technology: storage-health-service
ms.topic: article
ms.assetid: 5bc71e71-920e-454f-8195-afebd2a23725
author: cosmosdarwin
ms.date: 02/09/2018
---
# Health Service in Windows Server

> Applies to: Windows Server 2019, Windows Server 2016

The Health Service is a new feature in Windows Server 2016 that improves the day-to-day monitoring and operational experience for clusters running Storage Spaces Direct.

## Prerequisites  

The Health Service is enabled by default with Storage Spaces Direct. No additional action is required to set it up or start it. To learn more about Storage Spaces Direct, see [Storage Spaces Direct in Windows Server 2016](../storage/storage-spaces/storage-spaces-direct-overview.md).  

## Reports

See [Health Service reports](health-service-reports.md).

## Faults

See [Health Service faults](health-service-faults.md).

## Actions

See [Health Service actions](health-service-actions.md).

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

#### Verification

When the replacement disk is inserted, it will be verified against the Supported Components Document (see the next section).

#### Pooling  

If allowed, the replacement disk is automatically substituted into its predecessor's pool to enter use. At this point, the system is returned to its initial state of perfect health, and then the Fault disappears.  

## Supported Components Document  

The Health Service provides an enforcement mechanism to restrict the components used by Storage Spaces Direct to those on a Supported Components Document provided by the administrator or solution vendor. This can be used to prevent mistaken use of unsupported hardware by you or others, which may help with warranty or support contract compliance. This functionality is currently limited to physical disk devices, including SSDs, HDDs, and NVMe drives. The Supported Components Document can restrict on model, manufacturer (optional), and firmware version (optional).

### Usage  

The Supported Components Document uses an XML-inspired syntax. We recommend using your favorite text editor, such as the free [Visual Studio Code](https://code.visualstudio.com/) or Notepad, to create an XML document which you can save and reuse.

#### Sections

The document has two independent sections: `Disks` and `Cache`.

If the `Disks` section is provided, only the drives listed (as `Disk`) are allowed to join pools. Any unlisted drives are prevented from joining pools, which effectively precludes their use in production. If this section is left empty, any drive will be allowed to join pools.

If the `Cache` section is provided, only the drives listed (as `CacheDisk`) are used for caching. If this section is left empty, Storage Spaces Direct attempts to [guess based on media type and bus type](../storage/storage-spaces/understand-the-cache.md#cache-drives-are-selected-automatically). Drives listed here should also be listed in `Disks`.

>[!IMPORTANT]
> The Supported Components Document does not apply retroactively to drives already pooled and in use.  

#### Example

```XML
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
      <TargetFirmware>
        <Version>2.1</Version>
        <BinaryPath>C:\ClusterStorage\path\to\image.bin</BinaryPath>
      </TargetFirmware>
    </Disk>
    <Disk>
      <Manufacturer>Fabrikam</Manufacturer>
      <Model>QRSTUV</Model>
    </Disk>
  </Disks>

  <Cache>
    <CacheDisk>
      <Manufacturer>Fabrikam</Manufacturer>
      <Model>QRSTUV</Model>
    </CacheDisk>
  </Cache>

</Components>

```

To list multiple drives, simply add additional `<Disk>` or `<CacheDisk>` tags.

To inject this XML when deploying Storage Spaces Direct, use the `-XML` parameter:

```PowerShell
$MyXML = Get-Content <Filepath> | Out-String  
Enable-ClusterS2D -XML $MyXML
```

To set or modify the Supported Components Document once Storage Spaces Direct has been deployed:

```PowerShell
$MyXML = Get-Content <Filepath> | Out-String  
Get-StorageSubSystem Cluster* | Set-StorageHealthSetting -Name "System.Storage.SupportedComponents.Document" -Value $MyXML  
```

>[!NOTE]
>The model, manufacturer, and the firmware version properties should exactly match the values that you get using the **Get-PhysicalDisk** cmdlet. This may differ from your "common sense" expectation, depending on your vendor's implementation. For example, rather than "Contoso", the manufacturer may be "CONTOSO-LTD", or it may be blank while the model is "Contoso-XZY9000".  

You can verify using the following PowerShell cmdlet:  

```PowerShell
Get-PhysicalDisk | Select Model, Manufacturer, FirmwareVersion  
```

## Settings

See [Health Service settings](health-service-settings.md).

## See also

- [Health Service reports](health-service-reports.md)
- [Health Service faults](health-service-faults.md)
- [Health Service actions](health-service-actions.md)
- [Health Service settings](health-service-settings.md)
- [Storage Spaces Direct in Windows Server 2016](../storage/storage-spaces/storage-spaces-direct-overview.md)
