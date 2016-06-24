---
title: San
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d57c2df1-eb82-4b81-b8cd-e30564c6a929
---
# San
Displays or sets the storage area network (SAN) policy for the operating system.

> [!NOTE]
> This command is only applicable to Windows 7 and Windows Server 2008 R2.

For an example of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).

## Syntax

```
san [policy={OnlineAll | OfflineAll | OfflineShared}] [noerr]
```

### Parameters

|Parameter|Description|
|-------------|---------------|
|policy={ OnlineAll &#124; OfflineAll &#124; OfflineShared }]|Sets the SAN policy for the currently booted operating system. The SAN policy determines whether a newly discovered disk is brought online or remains offline, and whether it becomes read/write or remains read-only. When a disk is offline, the disk layout can be read, but no volume devices are surfaced through Plug and Play. This means that no file system can be mounted on the disk. When a disk is online, one or more volume devices are installed for the disk. The following is an explanation of each parameter:<br /><br />-   **OnlineAll**. Specifies that all newly discovered disks will be brought online and made read/write. **Important:**     Specifying **OnlineAll** on a server that shares disks could lead to data corruption. Therefore, you should not set this policy if disks are shared among servers unless the server is part of a cluster.<br />-   **OfflineAll**. Specifies that all newly discovered disks except the startup disk will be offline and read-only by default.<br />-   **OfflineShared**. Specifies that all newly discovered disks that do not reside on a shared bus (such as SCSI and iSCSI) are brought online and made read-write. Disks that are left offline will be read-only by default.<br /><br />For more information, see [VDS_SAN_POLICY Enumeration](http://go.microsoft.com/fwlink/?LinkId=203815) (http://go.microsoft.com/fwlink/?LinkId=203815).|
|noerr|Used for scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code.|

## Remarks

-   If the command is given with no parameters, the current SAN policy is displayed.

## <a name="BKMK_Examples"></a>Examples
To view the current policy, type:

```
san
```

To make all newly discovered disks, except the startup disk, offline and read-only by default, type:

```
san policy=OfflineAll
```

## Additional references

-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)


