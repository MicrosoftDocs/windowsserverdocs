---
ms.assetid: e5945bae-4a33-487c-a019-92a69db8cf6c
title: Updating drive firmware
ms.prod: windows-server
ms.author: toklima
ms.manager: dmoss
ms.technology: storage-spaces
ms.topic: article
author: toklima
ms.date: 10/04/2016
---
# Updating drive firmware
>Applies to: Windows Server 2019, Windows Server 2016, Windows 10

Updating the firmware for drives has historically been a cumbersome task with a potential for downtime, which is why we're making improvements to Storage Spaces, Windows Server, and Windows 10, version 1703 and newer. If you have drives that support the new firmware update mechanism included in Windows, you can update drive firmware of in-production drives without downtime. However, if you're going to update the firmware of a production drive, make sure to read our tips on how to minimize the risk while using this powerful new functionality.

  > [!Warning]
  > Firmware updates are a potentially risky maintenance operation and you should only apply them after thorough testing of the new firmware image. It is possible that new firmware on unsupported hardware could negatively affect reliability and stability, or even cause data loss. Administrators should read the release notes a given update comes with to determine its impact and applicability.

## Drive compatibility

To use Windows Server to update drive firmware, you must have supported drives. To ensure common device behavior, we began by defining new and - for Windows 10 and Windows Server 2016 - optional Hardware Lab Kit (HLK) requirements for SAS, SATA, and NVMe devices. These requirements outline which commands a SATA, SAS, or NVMe device must support to be firmware-updatable using these new, Windows-native PowerShell cmdlets. To support these requirements, there is a new HLK test to verify if vendor products support the right commands and get them implemented in future revisions. 

Contact your solution vendor for info about whether your hardware supports Windows updating the drive firmware.
Here are links to the various requirements:

-   SATA: [Device.Storage.Hd.Sata](https://msdn.microsoft.com/windows/hardware/commercialize/design/compatibility/device-storage#devicestoragehdsata) - in the **[If Implemented\] Firmware Download & Activate** section
    
-   SAS: [Device.Storage.Hd.Sas](https://msdn.microsoft.com/windows/hardware/commercialize/design/compatibility/device-storage#devicestoragehdsas) - in the **[If Implemented\] Firmware Download & Activate** section

-   NVMe: [Device.Storage.ControllerDrive.NVMe](https://msdn.microsoft.com/windows/hardware/commercialize/design/compatibility/device-storage#devicestoragecontrollerdrivenvme) - in sections **5.7** and **5.8**.

## PowerShell cmdlets

The two cmdlets added to Windows are:

-   Get-StorageFirmwareInformation
-   Update-StorageFirmware

The first cmdlet provides you with detailed information about the device's capabilities, firmware images, and revisions. In this case, the machine only contains a single SATA SSD with 1 firmware slot. Here's an example:

   ```powershell
   Get-PhysicalDisk | Get-StorageFirmwareInformation

   SupportsUpdate        : True
   NumberOfSlots         : 1
   ActiveSlotNumber      : 0
   SlotNumber            : {0}
   IsSlotWritable        : {True}
   FirmwareVersionInSlot : {J3E16101}
   ```

Note that SAS devices always report "SupportsUpdate" as "True", since there is no way of explicitly querying the device for support of these commands.

The second cmdlet, Update-StorageFirmware, enables administrators to update the drive firmware with an image file, if the drive supports the new firmware update mechanism. You should obtain this image file from the OEM or drive vendor directly.

  > [!Note]
  > Before updating any production hardware, test the particular firmware image on identical hardware in a lab setting.

The drive will first load the new firmware image to an internal staging area. While this happens, I/O typically continues. The image activates after downloading. During this time the drive will not be able to respond to I/O commands as an internal reset occurs. This means that this drive serves no data during the activation. An application accessing data on this drive would have to wait for a response until the firmware activation completes. Here's an example of the cmdlet in action:

   ```powershell 
   $pd | Update-StorageFirmware -ImagePath C:\Firmware\J3E160@3.enc -SlotNumber 0
   $pd | Get-StorageFirmwareInformation

   SupportsUpdate        : True
   NumberOfSlots         : 1
   ActiveSlotNumber      : 0
   SlotNumber            : {0}
   IsSlotWritable        : {True}
   FirmwareVersionInSlot : {J3E160@3}
   ```

Drives typically do not complete I/O requests when they activate a new firmware image. How long a drive takes to activate depends on its design and the type of firmware you update. We have observed update times range from fewer than 5 seconds to more than 30 seconds.

This drive performed the firmware update within ~5.8 seconds, as shown here:

```powershell 
Measure-Command {$pd | Update-StorageFirmware -ImagePath C:\\Firmware\\J3E16101.enc -SlotNumber 0}

 Days : 0
 Hours : 0
 Minutes : 0
 Seconds : 5
 Milliseconds : 791
 Ticks : 57913910
 TotalDays : 6.70299884259259E-05
 TotalHours : 0.00160871972222222
 TotalMinutes : 0.0965231833333333
 TotalSeconds : 5.791391
 TotalMilliseconds : 5791.391
 ```

## Updating drives in production

Before placing a server into production, we highly recommend updating the firmware of your drives to the firmware recommended by the hardware vendor or OEM that sold and supports your solution (storage enclosures, drives, and servers).

Once a server is in production, it's a good idea to make as few changes to the server as is practical. However, there may be times when your solution vendor advises you that there is a critically important firmware update for your drives. If this occurs, here are a few good practices to follow before applying any drive firmware updates:

1. Review the firmware release notes and confirm that the update addresses issues that could affect your environment, and that the firmware doesn't contain any known issues that could adversely affect you.

2. Install the firmware on a server in your lab that has identical drives (including the revision of the drive if there are multiple revisions of the same drive), and test the drive under load with the new firmware. For info about doing synthetic load testing, see [Test Storage Spaces Performance Using Synthetic Workloads](https://technet.microsoft.com/library/dn894707.aspx).

## Automated firmware updates with Storage Spaces Direct

Windows Server 2016 includes a Health Service for Storage Spaces Direct deployments (including Microsoft Azure Stack solutions). The main purpose of the Health Service is to make monitoring and management of your hardware deployment easier. As part of its management functions, it has the capability to roll-out drive firmware across an entire cluster without taking any workloads offline or incurring downtime. This capability is policy-driven, with the control in the admin's hands.

Using the Health Service to roll-out firmware across a cluster is very simple and involves the following steps:

-   Identify what HDD and SSD drives you expect to be part of your Storage Spaces Direct cluster, and whether the drives support Windows performing firmware updates
-   List those drives in the Supported Components xml file
-   Identify the firmware versions you expect those drives to have in the Supported Components xml (including location paths of the firmware images)
-   Upload the xml file to the cluster DB

At this point, the Health Service will inspect and parse the xml and identify any drives that do not have the desired firmware version deployed. It will then proceed to re-direct I/O away from the affected drives – going node-by-node – and updating the firmware on them. A Storage Spaces Direct cluster achieves resiliency by spreading data across multiple server nodes; it is possible for the health service to isolate an entire node worth of drives for updates. Once a node updates, it will initiate a repair in Storage Spaces, bringing all copies of data across the cluster back in sync with each other, before moving on to the next node. It is expected and normal for Storage Spaces to transition to a "degraded" mode of operation while firmware is rolled out.

To ensure a stable roll-out and sufficient validation time of a new firmware image, there exists a significant delay between the updates of several servers. Per default, the Health Service will wait 7 days before updating the 2<sup>nd</sup> server. Any subsequent server (3<sup>rd</sup>, 4<sup>th</sup>, …) updates with a 1 day delay. Should an administrator find the firmware to be unstable or otherwise undesirable, she can stop further roll-out by the health service at any time. If the firmware has been previously validated and a quicker roll-out is desired, these default values can be modified from days, to hours or minutes.

Here is an example of the supported components xml for a generic Storage Spaces Direct cluster:

```xml
 <Components>
     <Disks>
        <Disk>
            <Manufacturer>Contoso</Manufacturer>
            <Model>XYZ9000</Model>
            <AllowedFirmware>
              <Version>2.0</Version>
              <Version>2.1>/Version>
              <Version>2.2</Version>
            </AllowedFirmware>
            <TargetFirmware>
              <Version>2.2</Version>
              <BinaryPath>\\path\to\image.bin</BinaryPath>
            </TargetFirmware>
        </Disk>
        ...
        ...
    </Disks>
 </Components>
```

To get the roll-out of the new firmware started in this Storage Spaces Direct cluster, simply upload the .xml to the cluster DB:

```powershell
$SpacesDirect = Get-StorageSubSystem Clus*

$CurrentDoc = $SpacesDirect | Get-StorageHealthSetting -Name "System.Storage.SupportedComponents.Document"

$CurrentDoc.Value | Out-File <Path>
```

Edit the file in your favorite editor, such as Visual Studio Code or Notepad, then save it.

```powershell
$NewDoc = Get-Content <Path> | Out-String

$SpacesDirect | Set-StorageHealthSetting -Name "System.Storage.SupportedComponents.Document" -Value $NewDoc
```

If you would like to see the Health Service in action and learn more about its roll-out mechanism, have a look at this video: https://channel9.msdn.com/Blogs/windowsserver/Update-Drive-Firmware-Without-Downtime-in-Storage-Spaces-Direct

## Frequently asked questions

Also see [Troubleshooting drive firmware updates](troubleshoot-firmware-update.md).

### Will this work on any storage device

This will work on storage devices that implement the correct commands in their firmware. The Get-StorageFirmwareInformation cmdlet will show if a drive's firmware indeed does support the correct commands (for SATA/NVMe) and the HLK test allows vendors and OEMs to test this behavior.

### After I update a SATA drive, it reports to no longer support the update mechanism. Is something wrong with the drive

No, the drive is fine, unless the new firmware doesn't allow updates anymore. You are hitting a known issue whereby a cached version of the drive's capabilities is incorrect. Running "Update-StorageProviderCache -DiscoveryLevel Full" will re-enumerate the drive capabilities and update the cached copy. As a work-around, we recommend running the above command once before initiating a firmware update or complete roll-out on a Spaces Direct cluster.

### Can I update firmware on my SAN through this mechanism
No - SANs usually have their own utilities and interfaces for such maintenance operations. This new mechanism is for directly attached storage, such as SATA, SAS, or NVMe devices.

### From where do I get the firmware image

You should always obtain any firmware directly from your OEM, solution vendor, or drive vendor and not download it from other parties. Windows provides the mechanism to get the image to the drive, but cannot verify its integrity.

### Will this work on clustered drives

The cmdlets can perform their function on clustered drives as well, but keep in mind that the Health Service orchestration mitigates the I/O impact on running workloads. If the cmdlets are used directly on clustered drives, I/O is likely to stall. In general, it is a best practice to perform drive firmware updates when there is no, or just a minimal workload on the underlying drives.

### What happens when I update firmware on Storage Spaces

On Windows Server 2016 with the Health Service deployed on Storage Spaces Direct, you can perform this operation without taking your workloads offline, assuming the drives support Windows Server updating the firmware.

### What happens if the update fails

The update could fail for various reasons, some of them are: 1) The drive doesn't support the correct commands for Windows to update its firmware. In this case the new firmware image never activates and the drive continues functioning with the old image. 2) The image cannot download to or be applied to this drive (version mismatch, corrupt image, …). In this case the drive fails the activate command. Again, the old firmware image will continue function.

If the drive does not respond at all after a firmware update, you are likely hitting a bug in the drive firmware itself. Test all firmware updates in a lab environment before putting them in production. The only remediation may be to replace the drive.

For more info, see [Troubleshooting drive firmware updates](troubleshoot-firmware-update.md).

### How do I stop an in-progress firmware roll-out

Disable the roll-out in PowerShell via:
```powershell
Get-StorageSubSystem Cluster* | Set-StorageHealthSetting -Name "System.Storage.PhysicalDisk.AutoFirmwareUpdate.RollOut.Enabled" -Value false
```

### I am seeing an access denied or path-not-found error during roll out. How do I fix this

Ensure that the firmware image you would like to use for the update is accessible by all cluster nodes. The easiest way to ensure this is to place it on a cluster shared volume.
