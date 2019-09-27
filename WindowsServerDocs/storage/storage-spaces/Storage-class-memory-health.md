---
ms.assetid: 2bab6bf6-90e7-46a7-b917-14a7a8f55366
title: Storage-class Memory (NVDIMM-N) Health Management in Windows
ms.prod: windows-server
ms.author: jgerend
ms.manager: dongill
ms.technology: storage-spaces
ms.topic: article
author: JasonGerend
ms.date: 06/25/2019
ms.localizationpriority: medium
---
# Storage-class Memory (NVDIMM-N) Health Management in Windows

> Applies To: Windows Server 2019, Windows Server 2016, Windows Server (Semi-Annual Channel), Windows 10

This article provides system administrators and IT Pros with information about error handling and health management specific to storage-class memory (NVDIMM-N) devices in Windows, highlighting the differences between storage-class memory and traditional storage devices.

If you aren't familiar with Windows' support for storage-class memory devices, these short videos provide an overview:
- [Using Non-volatile Memory (NVDIMM-N) as Block Storage in Windows Server 2016](https://channel9.msdn.com/Events/Build/2016/P466)
- [Using Non-volatile Memory (NVDIMM-N) as Byte-Addressable Storage in Windows Server 2016](https://channel9.msdn.com/Events/Build/2016/P470)
- [Accelerating SQL Server 2016 performance with Persistent Memory in Windows Server 2016](https://channel9.msdn.com/Shows/Data-Exposed/SQL-Server-2016-and-Windows-Server-2016-SCM--FAST)

Also see [Understand and deploy persistent memory in Storage Spaces Direct](deploy-pmem.md).

JEDEC-compliant NVDIMM-N storage-class memory devices are supported in Windows with native drivers, starting in Windows Server 2016 and Windows 10 (version 1607). While these devices behave similar to other disks (HDDs and SSDs), there are some differences.

All conditions listed here are expected to be very rare occurrences, but depend on the conditions in which the hardware is used.

The various cases below may refer to Storage Spaces configurations. The particular configuration of interest is one where two NVDIMM-N devices are utilized as a mirrored write-back cache in a storage space. To set up such a configuration, see [Configuring Storage Spaces with a NVDIMM-N write-back cache](https://msdn.microsoft.com/library/mt650885.aspx).

In Windows Server 2016, the Storage Spaces GUI shows NVDIMM-N bus type as UNKNOWN. It doesn't have any fuctionality loss or inability in creation of Pool, Storage VD. You can verify the bus type by running the following command:

```powershell
PS C:\>Get-PhysicalDisk | fl
```
The parameter BusType in output of cmdlet will correctly show bus type as "SCM"

## Checking the health of storage-class memory
To query the health of storage-class memory, use the following commands in a Windows PowerShell session.

```powershell
PS C:\> Get-PhysicalDisk | where BusType -eq "SCM" | select SerialNumber, HealthStatus, OperationalStatus, OperationalDetails
```

Doing so yields this example output:

| SerialNumber | HealthStatus | OperationalStatus | OperationalDetails |
| --- | --- | --- | --- |
| 802c-01-1602-117cb5fc | Healthy | OK | |
| 802c-01-1602-117cb64f | Warning | Predictive Failure | {Threshold Exceeded,NVDIMM\_N Error} |

> [!NOTE]
> To find the Physical location of an NVDIMM-N device specified in an event, on the **Details** tab of the event in Event Viewer, go to **EventData** > **Location**. Note that Windows Server 2016 lists the incorrect location NVDIMM-N devices, but this is fixed in Windows Server, version 1709.

For help understanding the various health conditions, see the following sections.

## "Warning" Health Status

This condition is when you check the health of a storage-class memory device and see that it's Health Status is listed as **Warning**, as shown in this example output:

| SerialNumber | HealthStatus | OperationalStatus | OperationalDetails |
| --- | --- | --- | --- |
| 802c-01-1602-117cb5fc | Healthy | OK | |
| 802c-01-1602-117cb64f | Warning | Predictive Failure | {Threshold Exceeded,NVDIMM\_N Error} |

The following table lists some info about this condition.

| | Description |
| --- | --- |
| Likely condition | NVDIMM-N Warning Threshold breached |
| Root Cause | NVDIMM-N devices track various thresholds, such as temperature, NVM lifetime, and/or energy source lifetime. When one of those thresholds is exceeded, the operating system is notified. |
| General behavior | Device remains fully operational. This is a warning, not an error. |
| Storage Spaces behavior | Device remains fully operational. This is a warning, not an error. |
| More info | OperationalStatus field of the PhysicalDisk object. EventLog – Microsoft-Windows-ScmDisk0101/Operational |
| What to do | Depending on the warning threshold breached, it may be prudent to consider replacing the entire, or certain parts of the NVDIMM-N. For example, if the NVM lifetime threshold is breached, replacing the NVDIMM-N may make sense. |

## Writes to an NVDIMM-N fail

This condition is when you check the health of a storage-class memory device and see the Health Status listed as **Unhealthy**, and Operational Status mentions an **IO Error**, as shown in this example output:

| SerialNumber | HealthStatus | OperationalStatus | OperationalDetails |
| --- | --- | --- | --- |
| 802c-01-1602-117cb5fc | Healthy | OK | |
| 802c-01-1602-117cb64f | Unhealthy | {Stale Metadata, IO Error, Transient Error} | {Lost Data Persistence, Lost Data, NV...} |

The following table lists some info about this condition.

| | Description |
| --- | --- |
| Likely condition | Loss of Persistence / Backup Power |
|Root Cause|NVDIMM-N devices rely on a back-up power source for their persistence – usually a battery or super-cap. If this back-up power source is unavailable or the device cannot perform a backup for any reason (Controller/Flash Error), data is at risk and Windows will prevent any further writes to the affected devices. Reads are still possible to evacuate data.|
|General behavior|The NTFS volume will be dismounted.<br>The PhysicalDisk Health Status field will show "Unhealthy" for all affected NVDIMM-N devices.|
|Storage Spaces behavior|Storage Space will remain operational as long as only one NVDIMM-N is affected. If multiple devices are affected, writes to the Storage Space will fail. <br>The PhysicalDisk Health Status field will show "Unhealthy" for all affected NVDIMM-N devices.|
|More info|OperationalStatus field of the PhysicalDisk object.<br>EventLog – Microsoft-Windows-ScmDisk0101/Operational|
|What to do|We recommended backing-up the affected NVDIMM-N's data. To gain read access, you can manually bring the disk online (it will surface as a read-only NTFS volume).<br><br>To fully clear this condition, the root cause must be resolved (i.e. service power supply or replace NVDIMM-N, depending on issue) and the volume on the NVDIMM-N must either be taken offline and brought online again, or the system must be restarted.<br><br>To make the NVDIMM-N usable in Storage Spaces again, use the **Reset-PhysicalDisk** cmdlet, which re-integrates the device and starts the repair process.|

## NVDIMM-N is shown with a capacity of '0' Bytes or as a "Generic Physical Disk"

This condition is when a storage-class memory device is shown with a capacity of 0 bytes and cannot be initialized, or is exposed as a "Generic Physical Disk" object with an Operational Status of **Lost Communication**, as shown in this example output:

| SerialNumber | HealthStatus | OperationalStatus | OperationalDetails |
| --- | --- | --- | --- |
|802c-01-1602-117cb5fc|Healthy|OK||
||Warning|Lost Communication||

The following table lists some info about this condition.

||Description|
|---|---|
|Likely condition|BIOS Did Not Expose NVDIMM-N to OS|
|Root Cause|NVDIMM-N devices are DRAM based. When a corrupt DRAM address is referenced, most CPUs will initiate a machine check and restart the server. Some server platforms then un-map the NVDIMM, preventing the OS from accessing it and potentially causing another machine check. This may also occur if the BIOS detects that the NVDIMM-N has failed and needs to be replaced.|
|General behavior|NVDIMM-N is shown as uninitialized, with a capacity of 0 bytes and cannot be read or written.|
|Storage Spaces behavior|Storage Space remains operational (provided only 1 NVDIMM-N is affected).<br>NVDIMM-N PhysicalDisk object is shown with a Health Status of Warning and as a "General Physical Disk"|
|More info|OperationalStatus field of the PhysicalDisk object. <br>EventLog – Microsoft-Windows-ScmDisk0101/Operational|
|What to do|The NVDIMM-N device must be replaced or sanitized, such that the server platform exposes it to the host OS again. Replacement of the device is recommended, as additional uncorrectable errors could occur. Adding a replacement device to a storage spaces configuration can be achieved with the **Add-Physicaldisk** cmdlet.|

## NVDIMM-N is shown as a RAW or empty disk after a reboot

This condition is when you check the health of a storage-class memory device and see a Health Status of **Unhealthy** and Operational Status of **Unrecognized Metadata**, as shown in this example output:

| SerialNumber | HealthStatus | OperationalStatus | OperationalDetails |
| --- | --- | --- | --- |
|802c-01-1602-117cb5fc|Healthy|OK|{Unknown}|
|802c-01-1602-117cb64f|Unhealthy|{Unrecognized Metadata, Stale Metadata}|{Unknown}|

The following table lists some info about this condition.

||Description|
|---|---|
|Likely condition|Backup/Restore Failure|
|Root Cause|A failure in the backup or restore procedure will likely result in all data on the NVDIMM-N to be lost. When the operating system loads, it will appear as a brand new NVDIMM-N without a partition or file system and surface as RAW, meaning it doesn't have a file system.|
|General behavior|NVDIMM-N will be in read-only mode. Explicit user action is needed to begin using it again.|
|Storage Spaces behavior|Storage Spaces remains operational if only one NVDIMM is affected).<br>NVDIMM-N physical disk object will be shown with the Health Status "Unhealthy" and is not used by Storage Spaces.|
|More info|OperationalStatus field of the PhysicalDisk object.<br>EventLog – Microsoft-Windows-ScmDisk0101/Operational|
|What to do|If the user doesn't want to replace the affected device, they can use the **Reset-PhysicalDisk** cmdlet to clear the read-only condition on the affected NVDIMM-N. In Storage Spaces environments this will also attempt to re-integrate the NVDIMM-N into Storage Space and start the repair process.|

## Interleaved Sets

Interleaved sets can often be created in a platform's BIOS to make multiple NVDIMM-N devices appear as a single device to the host operating system.

Windows Server 2016 and Windows 10 Anniversary Edition do not support interleaved sets of NVDIMM-Ns.

At the time of this writing, there is no mechanism for the host operating system to correctly identify individual NVDIMM-Ns in such a set and clearly communicate to the user which particular device may have caused an error or needs to be serviced.


