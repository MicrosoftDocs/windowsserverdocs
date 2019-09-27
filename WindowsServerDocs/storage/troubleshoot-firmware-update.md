---
ms.assetid: 13210461-1e92-48a1-91a2-c251957ba256
title: Troubleshooting drive firmware updates	
ms.prod: windows-server
ms.author: toklima
ms.manager: masriniv
ms.technology: storage
ms.topic: article
author: toklima
ms.date: 04/18/2017
---
# Troubleshooting drive firmware updates

>Applies to: Windows 10, Windows Server (Semi-Annual Channel),

Windows 10, version 1703 and newer, and Windows Server (Semi-Annual Channel) include the capability to update firmware of HDDs and SSDs that have been certified with the Firmware Upgradeable AQ (Additional Qualifier) via PowerShell.

You can find more information about this feature here:

- [Updating drive firmware in Windows Server 2016](update-firmware.md)
- [Update Drive Firmware Without Downtime in Storage Spaces Direct](https://channel9.msdn.com/Blogs/windowsserver/Update-Drive-Firmware-Without-Downtime-in-Storage-Spaces-Direct)

Firmware updates may fail for various reasons. The purpose of this article is to help with advanced troubleshooting.

  > [!Note]
  > Information in this article, depending on the issue, may not be sufficient to fully debug all possible failure cases.

## Common issues
Architecturally, this new capability relies on APIs implemented in the Windows storage stack, which PowerShell calls into. The storage stack relies on drivers and hardware to properly implement industry defined commands. This yields several points at which failures can occur. The most commonly observed issues are:

1.	A given drive does not properly implement the industry-standard commands (does not have the AQ)
2.	The APIs needed to perform the update are not implemented or faulty (if 3rd party drivers are used)
3.	The APIs work, but there is an issue with the firmware itself (invalid/corrupt image, …)

The following sections outline troubleshooting information, depending on whether Microsoft or 3rd party drivers are used.

## Identifying inappropriate hardware
The quickest way to identify if a device supports the correct command set is to simply launch PowerShell and pass a disk's representing PhysicalDisk object into the Get-StorageFirmwareInfo cmdlet. Here is an example:

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

The SupportsUpdate field, at least for SATA and NVMe devices, will indicate if the built-in PowerShell functionality can be used to update firmware.

The SupportsUpdate field will always report “True” for SAS-attached devices, as querying for the appropriate command support is not possible with industry-standard commands.

To validate if a SAS device supports the required command set, two options exist:
1.	Try it out via the Update-StorageFirmware cmdlet with an appropriate firmware image, or
2.	Consult the Windows Server Catalogue to identify which SAS devices have successfully gained the FW Update AQ (https://www.windowsservercatalog.com/)

### Remediation options
If a given device you are testing does not support the appropriate command set, either query your vendor to see if an updated firmware is available that provides the needed command set, or consult the Windows Server Catalogue to identify devices for sourcing that implement the appropriate command set.

## Troubleshooting with 3rd-Party drivers (SAS)
The software components that most closely interact with hardware are mini-port drivers in the Windows storage stack. For some storage protocols, such as SATA and NVMe, Microsoft provides native Windows drivers. These drivers allow for additional debug information. 3rd party hardware and software vendors however are free to write their own miniport drivers for their devices and their support level for debug information may vary.

To identify what happened to the firmware download and activate APIs sent down the storage stack, regardless of miniport driver, consult the following event log channel:

Event Viewer - Application and Services Logs - Microsoft - Windows - StorDiag - **Microsoft-Windows-Storage-ClassPnP/Operational**

This channel records information about the Windows APIs sent down to the miniport drivers and what their responses are. For example, the error condition shown directly below is exhibited when attempting to download a firmware image to a SATA device, which is connected through a SAS HBA that does not properly implement the needed translation from SAS to SATA:

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
	
PowerShell will throw an error and has received the information that the function called (i.e. Kernel API) was incorrect. This could mean that either the API was not implemented by the 3rd party SAS mini-port driver (true in this case), or that the API was failed for another reason, such as a misalignment of download segments.

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

It is possible that different error condition exhibit the same error codes, if the miniport driver does not disambiguate between them. For example, trying to download an invalid firmware image through a SAS HBA to a SATA device (which the device is expected to fail) may be translated to the same failure codes.

In cases where protocols are mixed and translations occur, i.e. SATA behind SAS, it is best to test the SATA device directly connected to a SATA controller to rule it out as a potential problem.

### Remediation options
If the 3rd party driver is identified as not implementing the needed APIs or translations, it is possible to either swap to the Microsoft provided alternatives for SATA (StorAHCI.sys) and NVMe (StorNVMe.sys), or reach out to the OEM or HBA vendor that provided the SAS driver and query if a newer version with the proper support exists.

## Additional troubleshooting with Microsoft drivers (SATA/NVMe)
When Windows-native drivers, such as StorAHCI.sys or StorNVMe.sys are used to power storage devices, it is possible to get additional information about possible failure cases during firmware update operations.

Beyond the ClassPnP Operational channel, StorAHCI and StorNVMe will log the device's protocol specific return codes in the following ETW channel:

Event Viewer - Application and Services Logs - Microsoft - Windows - StorDiag - **Microsoft-Windows-Storage-StorPort/Diagnose**

The diagnostic logs are not shown by default and can be activated/shown by clicking on “View” in EventViewer and selecting “Show Analytics and Debug Logs” from the drop-down menu.

To gather these advanced log entries, enable the log, reproduce the firmware update failure, and save the diagnostic log.

Here is an example of a firmware update on a SATA device failing, because the image to be downloaded was invalid (Event ID: 258):

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

The above event contains detailed device information in parameter values 2 through 6. Here we are looking at various ATA register values. The ATA ACS specification can be used to decode the below values for failure of a Download Microcode command:
- Return Code: 0 (0000 0000) (N/A - meaningless since no payload was transferred)
- Features: 15 (0000 1111) (Bit 1 is set to ‘1' and indicates “abort”)
- SectorCount: 0 (0000 0000) (N/A)
- DriveHead: 160 (1010 0000) (N/A – only obsolete bits are set)
- Command: 146 (1001 0010) (Bit 1 is set to ‘1' indicating the availability of sense data)

This tells us that the firmware update operation was aborted by the device.

A similar level of debug information is available in this channel when using NVMe devices with the Windows-native NVMe driver (StorNVMe.sys).
