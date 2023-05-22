---
description: Learn more about troubleshooting drive firmware updates
title: Troubleshooting drive firmware updates
ms.author: toklima
ms.topic: article
author: toklima
ms.date: 04/01/2023
---
# Troubleshooting drive firmware updates

Applies to: Windows Server 2022, Windows Server 2019, Windows 10

Windows 10, version 1703 and newer include the capability to update firmware of HDDs and SSDs that have been certified with the Firmware Upgradeable AQ (Additional Qualifier) via PowerShell.

You can find more information about this feature here:

- [Updating drive firmware in Windows Server 2016](update-firmware.md)
- Update Drive Firmware Without Downtime in Storage Spaces Direct

Firmware updates can fail for various reasons. The purpose of this article is to help with advanced troubleshooting.

  > [!Note]
  > Information in this article, depending on the issue, may not be sufficient to fully debug all possible failure cases.

## Common issues

Architecturally, this new capability relies on APIs implemented in the Windows storage stack, which PowerShell calls into. The storage stack relies on drivers and hardware to properly implement industry defined commands. This yields several points at which failures can occur. The most commonly observed issues are:

- A given drive doesn't properly implement the industry-standard commands (doesn't have the AQ.)
- The APIs needed to perform the update aren't implemented or are faulty (if 3rd-party drivers are used).
- The APIs work but there's an issue with the firmware itself (for example, an invalid/corrupt image).

The following sections outline troubleshooting information, depending on whether Microsoft or 3rd-party drivers are used.

## Identifying inappropriate hardware

The quickest way to identify whether a device supports the correct command set is to launch PowerShell and pass a disk's representing PhysicalDisk object into the Get-StorageFirmwareInfo cmdlet. Here's an example:

```powershell
Get-PhysicalDisk -SerialNumber 15140F55976D | Get-StorageFirmwareInformation
```
And here's example output:

```
PhysicalDisk          : MSFT_PhysicalDisk (ObjectId = "{1}\\TOKLIMA-DL380\root/Microsoft/Windo...)
SupportsUpdate        : True
NumberOfSlots         : 1
ActiveSlotNumber      : 0
SlotNumber            : {0}
IsSlotWritable        : {True}
FirmwareVersionInSlot : {0013}
```

The SupportsUpdate field, at least for SATA and NVMe devices, indicates if the built-in PowerShell functionality can be used to update firmware.

The SupportsUpdate field always report “True” for SAS-attached devices because querying for the appropriate command support isn't possible with industry-standard commands.

To validate whether a SAS device supports the required command set, two options exist:

- Test SAS device via the Update-StorageFirmware cmdlet with an appropriate firmware image; or
- Consult the Windows Server Catalog to identify which SAS devices have successfully gained the FW Update AQ (https://www.windowsservercatalog.com/)

### Remediation options

If a given device you're testing doesn't support the appropriate command set, either query your vendor to see if an updated firmware is available that provides the needed command set, or consult the Windows Server Catalog to identify devices for sourcing that implement the appropriate command set.

## Troubleshooting with 3rd-Party drivers (SAS)

The software components that most closely interact with hardware are mini-port drivers in the Windows storage stack. For some storage protocols, such as SATA and NVMe, Microsoft provides native Windows drivers. These drivers support additional debug information. 3rd-party hardware and software vendors however can write custom miniport drivers for their devices. In these cases, support for debug information can vary.

To identify what happened to the firmware download and activate APIs sent down the storage stack, regardless of miniport driver, consult the following event log channel:

Event Viewer - Application and Services Logs - Microsoft - Windows - StorDiag - **Microsoft-Windows-Storage-ClassPnP/Operational**

This channel records information about the Windows APIs sent down to the miniport drivers and their responses. For example, the following error condition occurs when attempting to download a firmware image to a SATA device connected through a SAS HBA that doesn't properly implement the needed translation from SAS to SATA:

```powershell
Get-PhysicalDisk -SerialNumber 44GS103UT5EW | Update-StorageFirmware -ImagePath C:\Firmware\J3E160@3.enc -SlotNumber 0
```
Here's an example of the output:

```
Update-StorageFirmware : Failed

Extended information:
A warning or error has been encountered during storage firmware update.
Incorrect function.

Activity ID: {1224482b-2315-4a38-81eb-27bb7de19c00}
At line:1 char:47
+ ... S103UT5EW | Update-StorageFirmware -ImagePath C:\Firmware\J3E160@3.en ...
+                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ CategoryInfo          : NotSpecified: (:) [Update-StorageFirmware], CimException
+ FullyQualifiedErrorId : StorageWMI 4,Microsoft.Management.Infrastructure.CimCmdlets.InvokeCimMethodCommand,Update-StorageFirmware
```

PowerShell throws an error and has received the information that the function called (that is, the Kernel API) was incorrect. An error could mean that either the API wasn't implemented by the 3rd-party SAS mini-port driver (correct in this case), or that the API failed for another reason, such as a misalignment of download segments.

```
EventData
DeviceGUID	{132EDB55-6BAC-A3A0-C2D5-203C7551D700}
DeviceNumber	1
Vendor	ATA
Model	TOSHIBA THNSNJ12
FirmwareVersion	6101
SerialNumber	44GS103UT5EW
DownLevelIrpStatus	0xc0000185
SrbStatus	132
ScsiStatus	2
SenseKey	5
AdditionalSenseCode	36
AdditionalSenseCodeQualifier	0
CdbByteCount	10
CdbBytes	3B0E0000000001000000
NumberOfRetriesDone	0
```

The ETW event 507 from the channel shows that a SCSI SRB request failed and provides the additional information that SenseKey was ‘5' (Illegal Request), and that AdditionalSense information was ‘36' (Illegal Field in CDB).

   > [!Note]
   > This information is provided directly by the miniport in question and the accuracy of this information will depend on the implementation and sophistication of the miniport driver.

It's possible for different error conditions to exhibit the same error codes if the miniport driver doesn't disambiguate between them. For example, trying to download an invalid firmware image through a SAS HBA to a SATA device (which the device is expected to fail) can result in identical failure codes.

In cases where protocols are mixed and translations occur, that is, SATA behind SAS, it's best to test the SATA device directly connected to a SATA controller to rule it out as a potential problem.

### Remediation options

If the 3rd-party driver is identified as not implementing the needed APIs or translations, it's possible to either swap to the Microsoft provided alternatives for SATA (StorAHCI.sys) and NVMe (StorNVMe.sys), or reach out to the OEM or HBA vendor that provided the SAS driver and query if a newer version with the proper support exists.

## More troubleshooting with Microsoft drivers (SATA/NVMe)

When Windows-native drivers, such as `StorAHCI.sys` or `StorNVMe.sys` are used to power storage devices, it's possible to get additional information about possible failure cases during firmware update operations.

Beyond the ClassPnP Operational channel, StorAHCI and StorNVMe log the device's protocol specific return codes in the following ETW channel:

Event Viewer - Application and Services Logs - Microsoft - Windows - StorDiag - **Microsoft-Windows-Storage-StorPort/Diagnose**

The diagnostic logs aren't shown by default and can be activated/shown by selecting “View” in EventViewer and then selecting “Show Analytics and Debug Logs” from the drop-down menu.

To gather these advanced log entries, enable the log, reproduce the firmware update failure, and save the diagnostic log.

Here's an example of a firmware update on a SATA device failing, because the image to be downloaded was invalid (Event ID: 258):

```
EventData
MiniportName	storahci
MiniportEventId	19
MiniportEventDescription	Firmware Activate Completion
PortNumber	0
Bus	2
Target	0
LUN	0
Irp	0xffff8c84cd45aca0
Srb	0xffffab0024030bc0
Parameter1Name	SrbStatus
Parameter1Value	130
Parameter2Name	ReturnCode
Parameter2Value	0
Parameter3Name	FeaturesReg
Parameter3Value	15
Parameter4Name	SectorCountReg
Parameter4Value	0
Parameter5Name	DriveHeadReg
Parameter5Value	160
Parameter6Name	CommandReg
Parameter6Value	146
Parameter7Name	NULL
Parameter7Value	0
Parameter8Name	NULL
Parameter8Value	0
```

The above event contains detailed device information in parameter values 2 through 6. Here we're looking at various ATA register values. The ATA ACS specification can be used to decode the below values for failure of a Download Microcode command:

- Return Code: 0 (0000 0000) (N/A - Meaningless because no payload was transferred.)
- Features: 15 (0000 1111) (Bit 1 is set to ‘1' and indicates “abort”.)
- SectorCount: 0 (0000 0000) (N/A)
- DriveHead: 160 (1010 0000) (N/A – Only obsolete bits are set.)
- Command: 146 (1001 0010) (Bit 1 is set to ‘1' indicating the availability of sense data.)

This tells us that the firmware update operation was aborted by the device.

A similar level of debug information is available in this channel when using NVMe devices with the Windows-native NVMe driver (StorNVMe.sys).