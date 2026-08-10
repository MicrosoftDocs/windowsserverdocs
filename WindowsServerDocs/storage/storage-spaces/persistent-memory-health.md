---
title: Persistent memory health management for Storage Spaces Direct in Windows Server
description: This article provides information about error handling and health management specific to persistent memory (PMem) devices in Windows Server.
author: robinharwood
ms.author: roharwoo
ms.reviewer: robhindman
ms.topic: how-to
ms.date: 02/10/2025
---

# Persistent memory health management

This article provides information about error handling and health management specific to persistent memory (PMem) devices, often called storage-class memory (SCM), which is a type of non-volatile media that can be used as top-tier storage.

These short videos provide an overview of Windows' support for persistent memory:
- [Using Non-volatile Memory (NVDIMM-N) as Block Storage in Windows Server 2016](/events/build-2016/p466)
- [Using Non-volatile Memory (NVDIMM-N) as Byte-Addressable Storage in Windows Server 2016](/events/build-2016/p470)

Also see [Understand and deploy persistent memory](deploy-persistent-memory.md).

Persistent memory devices are supported with native drivers beginning in Windows Server 2016 and Windows 10 (version 1607). While persistent memory devices behave similar to other disks (HDDs and SSDs), there are some differences.

A common use case is where two persistent memory modules are utilized as a mirrored write-back cache in a storage space. To set up such a configuration, see [Configuring Storage Spaces with a NVDIMM-N write-back cache](/sql/relational-databases/performance/configuring-storage-spaces-with-a-nvdimm-n-write-back-cache).

In Windows Server 2016, the Storage Spaces GUI shows NVDIMM-N bus type as UNKNOWN. It doesn't have any functionality loss or inability in creation of Pool, Storage VD. You can verify the bus type by running the following cmdlet:

```PowerShell
Get-PhysicalDisk | fl
```

The parameter BusType in the output correctly shows bus type as *SCM*.

## View persistent memory health status

This section describes how to view the health status of your persistent memory modules. When you use persistent memory, there are a few differences in the monitoring experience:

- Persistent memory doesn't create Physical Disk performance counters, so you won't see it appears on charts in Windows Admin Center.
- Persistent memory doesn't create Storport 505 data, so you won't get proactive outlier detection.

Otherwise, the monitoring experience is the same as for any other physical disk.

You can query for the health of a persistent memory disk by running the following cmdlets:

```PowerShell
Get-PmemDisk

DiskNumber Size   HealthStatus AtomicityType CanBeRemoved PhysicalDeviceIds UnsafeShutdownCount
---------- ----   ------------ ------------- ------------ ----------------- -------------------
2          252 GB Unhealthy    None          True         {20, 120}         2
3          252 GB Healthy      None          True         {1020, 1120}      0

Get-PmemDisk | Get-PhysicalDisk | select SerialNumber, HealthStatus, OperationalStatus, OperationalDetails

SerialNumber               HealthStatus OperationalStatus  OperationalDetails
------------               ------------ ------------------ ------------------
802c-01-1602-117cb5fc      Healthy      OK
802c-01-1602-117cb64f      Warning      Predictive Failure {Threshold Exceeded,NVDIMM_N Error}
```

It's worth noting that you can get the same information by using the `Get-PhysicalDisk` cmdlet and specifying the BusType as SCM:

```PowerShell
Get-PhysicalDisk | where BusType -eq "SCM" | select SerialNumber, HealthStatus, OperationalStatus, OperationalDetails
```

> [!NOTE]
> To find the physical location of a persistent memory device specified in an event, on the **Details** tab of the event in Event Viewer, go to **EventData** > **Location**. Note that Windows Server 2016 lists the incorrect location of persistent memory devices, but this is fixed in Windows Server, version 1709.

**HealthStatus** shows whether the persistent memory disk is healthy.

The **UnsafeshutdownCount** value tracks the number of shutdowns that may cause data loss on this logical disk. It's the sum of the unsafe shutdown counts of all the underlying persistent memory devices of this disk. For more information about the health status, use the `Get-PmemPhysicalDevice` cmdlet to find information such as **OperationalStatus**.

```PowerShell
Get-PmemPhysicalDevice

DeviceId DeviceType           HealthStatus OperationalStatus PhysicalLocation FirmwareRevision Persistent memory size Volatile memory size
-------- ----------           ------------ ----------------- ---------------- ---------------- ---------------------- --------------------
1020     Intel INVDIMM device Healthy      {Ok}              CPU2_DIMM_C1     102005310        126 GB                 0 GB
1120     Intel INVDIMM device Healthy      {Ok}              CPU2_DIMM_F1     102005310        126 GB                 0 GB
120      Intel INVDIMM device Healthy      {Ok}              CPU1_DIMM_F1     102005310        126 GB                 0 GB
20       Intel INVDIMM device Unhealthy    {HardwareError}   CPU1_DIMM_C1     102005310        126 GB                 0 GB
```

This cmdlet shows which persistent memory device is unhealthy. The unhealthy device (**DeviceId** 20) matches the case in the previous example. The **PhysicalLocation** in BIOS can help identify which persistent memory device is in faulty state.

To understand the various health conditions, see the following sections.

## Warning Health Status

This condition is present when you check the health of a persistent memory device and see that its Health Status is listed as **Warning**, as shown in this example output:

| SerialNumber | HealthStatus | OperationalStatus | OperationalDetails |
| --- | --- | --- | --- |
| 802c-01-1602-117cb5fc | Healthy | OK | |
| 802c-01-1602-117cb64f | Warning | Predictive Failure | {Threshold Exceeded,NVDIMM\_N Error} |

The following table lists some information about this condition.

| Heading | Description |
| --- | --- |
| Likely condition | Warning threshold breached |
| Root Cause | Persistent memory devices track various thresholds, such as temperature, NVM lifetime, and/or energy source lifetime. When one of those thresholds is exceeded, the operating system is notified. |
| General behavior | Device remains fully operational. This is a warning, not an error. |
| Storage Spaces behavior | Device remains fully operational. This is a warning, not an error. |
| More information | OperationalStatus field of the PhysicalDisk object. EventLog – Microsoft-Windows-ScmDisk0101/Operational |
| What to do | Depending on the warning threshold breached, it may be prudent to replace the persistent memory device. |

## Writes to a persistent memory device fail

This condition is present when you check the health of a persistent memory device and see the Health Status listed as **Unhealthy**, and Operational Status mentions an **IO Error**, as shown in this example output:

| SerialNumber | HealthStatus | OperationalStatus | OperationalDetails |
| --- | --- | --- | --- |
| 802c-01-1602-117cb5fc | Healthy | OK | |
| 802c-01-1602-117cb64f | Unhealthy | {Stale Metadata, IO Error, Transient Error} | {Lost Data Persistence, Lost Data, NV...} |

The following table lists some information about this condition.

| Heading | Description |
| --- | --- |
| Likely condition | Loss of persistence / backup Power |
|Root Cause|Persistent memory devices rely on a back-up power source for their persistence – usually a battery or super-cap. If this back-up power source is unavailable or the device can't perform a backup for any reason (Controller/Flash Error), data is at risk and Windows will prevent any further writes to the affected devices. Reads are still possible to evacuate data.|
|General behavior|The NTFS volume will be dismounted.<br>The PhysicalDisk Health Status field will show "Unhealthy" for all affected NVDIMM-N devices.|
|Storage Spaces behavior|Storage Space will remain operational as long as only one persistent memory module is affected. If multiple devices are affected, writes to the Storage Space will fail. <br>The PhysicalDisk Health Status field will show "Unhealthy" for all affected persistent memory devices.|
|More information|OperationalStatus field of the PhysicalDisk object.<br>EventLog – Microsoft-Windows-ScmDisk0101/Operational|
|What to do|We recommended backing-up the affected PMem's data. To gain read access, you can manually bring the disk online (it will surface as a read-only NTFS volume).<br><br>To fully clear this condition, the root cause must be resolved (that is, service power supply or replace persistent memory module, depending on issue) and the volume on the module must either be taken offline and brought online again, or the system must be restarted.<br><br>To make the persistent memory module usable in Storage Spaces again, use the `Reset-PhysicalDisk` cmdlet, which reintegrates the device and starts the repair process.|

## Device is shown with a capacity of '0' bytes or as a "Generic Physical Disk"

This condition is present when a persistent memory device is shown with a capacity of 0 bytes and can't be initialized, or is exposed as a "Generic Physical Disk" object with no serial number that displays an  Operational Status of **Lost Communication**, as shown in this example output:

| SerialNumber | HealthStatus | OperationalStatus | OperationalDetails |
| --- | --- | --- | --- |
|802c-01-1602-117cb5fc|Healthy|OK||
||Warning|Lost Communication||

The following table lists some information about this condition.

|Heading|Description|
|---|---|
|Likely condition|BIOS didn't expose persistent memory module to OS|
|Root Cause|Persistent memory devices are DRAM based. When a corrupt DRAM address is referenced, most CPUs will initiate a machine check and restart the server. Some server platforms then unmap the persistent memory module, preventing the OS from accessing it and potentially causing another machine check. This may also occur if the BIOS detects that the persistent memory module has failed and needs to be replaced.|
|General behavior|Persistent memory module is shown as uninitialized, with a capacity of 0 bytes and can't be read or written.|
|Storage Spaces behavior|Storage Space remains operational (provided only one persistent memory module is affected).<br>PMem PhysicalDisk object is shown with a Health Status of Warning and as a "General Physical Disk"|
|More information|OperationalStatus field of the PhysicalDisk object. <br>EventLog – Microsoft-Windows-ScmDisk0101/Operational|
|What to do|The persistent memory device must be replaced or sanitized, such that the server platform exposes it to the host OS again. Replacement of the device is recommended, as more uncorrectable errors could occur. Adding a replacement device to a storage spaces configuration can be achieved with the `Add-PhysicalDisk` cmdlet.|

## Device is shown as a RAW or empty disk after a reboot

This condition is present when you check the health of a persistent memory device and see a Health Status of **Unhealthy** and Operational Status of **Unrecognized Metadata**, as shown in this example output:

| SerialNumber | HealthStatus | OperationalStatus | OperationalDetails |
| --- | --- | --- | --- |
|802c-01-1602-117cb5fc|Healthy|OK|{Unknown}|
|802c-01-1602-117cb64f|Unhealthy|{Unrecognized Metadata, Stale Metadata}|{Unknown}|

The following table lists some information about this condition.

|Heading|Description|
|---|---|
|Likely condition|Backup/Restore Failure|
|Root cause|A failure in the backup or restore procedure will likely result in all data on the persistent memory module to be lost. When the operating system loads, it will appear as a brand new persistent memory device without a partition or file system and surface as RAW, meaning it doesn't have a file system.|
|General behavior|Persistent memory will be in read-only mode. Explicit user action is needed to begin using it again.|
|Storage Spaces behavior|Storage Spaces remains operational if only one persistent memory module is affected.<br>PMem physical disk object will be shown with the Health Status "Unhealthy" and isn't used by Storage Spaces.|
|More information|OperationalStatus field of the PhysicalDisk object.<br>EventLog – Microsoft-Windows-ScmDisk0101/Operational|
|What to do|If the user doesn't want to replace the affected device, they can use the `Reset-PhysicalDisk` cmdlet to clear the read-only condition on the affected persistent memory module. In Storage Spaces environments, this will also attempt to reintegrate the persistent memory module into Storage Spaces and start the repair process.|

## Next steps

For related information, see also:

- [Storage Spaces Direct overview](/windows-server/storage/storage-spaces/storage-spaces-direct-overview)
- [Understand and deploy persistent memory](deploy-persistent-memory.md)
