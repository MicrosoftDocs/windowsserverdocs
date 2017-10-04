---
title: Troubleshooting Disk Management
description: This article describes how to troubleshoot Disk Management issues
ms.prod: windows-server-threshold 
ms.technology: storage 
ms.topic: article 
author: JasonGerend 
manager: brianlic 
ms.author: jrgerend 
---

# Troubleshooting Disk Management

> **Applies To:** Windows 10, Windows 8.1, Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This section lists a few common issues you may encounter when using Disk Management.

## What problem are you having?

-   [Partitions on basic disks added to the system do not appear in the Disk Management Volume List view.](#BKMK_1)
-   [A basic disk's status is Not Initialized.](#BKMK_2)
-   [A basic or dynamic disk's status is Unreadable.](#BKMK_3)
-   [A dynamic disk's status is Foreign.](#BKMK_4)
-   [A dynamic disk's status is Online (Errors).](#BKMK_5)
-   [A dynamic disk's status is Offline or Missing.](#BKMK_6)
-   [A basic or dynamic volume's status is Failed.](#BKMK_7)
-   [A basic or dynamic volume's status is Unknown.](#BKMK_8)
-   [A dynamic volume's status is Data Incomplete.](#BKMK_9)
-   [A dynamic volume's status is Healthy (At Risk).](#BKMK_10)
-   [Cannot manage striped volumes using Disk Management or DiskPart.](#BKMK_11)
-   [Disk Management cannot start the Virtual Disk Service](#BKMK_virtdisk)

<a id="BKMK_1"></a>
##### Partitions on basic disks added to the system do not appear in the Disk Management Volume List view.

**Cause:** Volumes on basic disks added to the system are not automatically mounted and assigned drive letters by default.
Dynamic disks appear as **Foreign** when they are added to the system. To use the volumes, you must import the **Foreign** disks and then bring the volumes **Online**.
Removable media devices (such as Zip or Jaz drives), and optical discs (such as CD-ROM or DVD-RAM) are always automatically mounted by the system.

**Solution:** Manually mount the basic volumes by assigning drive letters, or by creating mount points using Disk Management or the [DiskPart](http://go.microsoft.com/fwlink/?LinkId=64110) or [mountvol](http://go.microsoft.com/fwlink/?LinkId=64111) commands.

<a id="BKMK_2"></a>
##### A basic disk's status is Not Initialized.

**Cause:**  The disk does not contain a valid signature. After you install a new disk, the operating system must write a disk signature, the end of sector marker (also called signature word), and a Master Boot Record or GUID Partition Table before you can create partitions on the disk. When you first start Disk Management after installing a new disk, a wizard appears that provides a list of the new disks detected by the operating system. If you cancel the wizard before the disk signature is written, the disk status remains **Not Initialized**.

**Solution:**  Initialize the disk. The disk status briefly changes to **Initializing** and then to **Online** status. For instructions describing how to initialize a disk, see [Initialize New Disks](initialize-new-disks.md). See also [Disk Status Descriptions](http://go.microsoft.com/fwlink/?LinkId=64112)

<a id="BKMK_3"></a>
##### A basic or dynamic disk's status is Unreadable.

**Cause:** The basic or dynamic disk is not accessible and might have experienced hardware failure, corruption, or I/O errors. The disk's copy of the system's disk configuration database might be corrupted. An error icon appears on disks that display the **Unreadable** status.

Disks might also display the **Unreadable** status while they are spinning up or when Disk Management is rescanning all of the disks on the system. In some cases, an unreadable disk has failed and is not recoverable. For dynamic disks, the **Unreadable** status usually results from corruption or I/O errors on part of the disk, rather than failure of the entire disk.

**Solution:** Rescan the disks or restart the computer to see if the disk status changes. For instructions describing how to rescan the disks, see <http://go.microsoft.com/fwlink/?LinkId=64114>. See also [Disk Status Descriptions](http://go.microsoft.com/fwlink/?LinkId=64112).

<a id="BKMK_4"></a>
##### A dynamic disk's status is Foreign.

**Cause:** The **Foreign** status occurs when you move a dynamic disk to the local computer from another computer running Windows 2000, Windows XP Professional, Windows XP 64-Bit Edition, or Windows Server 2003 operating systems. A warning icon appears on disks that display the **Foreign** status.

In some cases, a disk that was previously connected to the system can display the **Foreign** status. Configuration data for dynamic disks is stored on all dynamic disks, so the information about which disks are owned by the system is lost when all dynamic disks fail.

**Solution:** Add the disk to your computer's system configuration so that you can access data on the disk. To add a disk to your computer's system configuration, import the foreign disk (right-click the disk and then click **Import Foreign Disks**). Any existing volumes on the foreign disk become visible and accessible when you import the disk. See  [Disk Status Descriptions](http://go.microsoft.com/fwlink/?LinkId=64112).

<a id="BKMK_5"></a>
##### A dynamic disk's status is Online (Errors).

**Cause:** The dynamic disk has I/O errors on a region of the disk. A warning icon appears on the dynamic disk with errors.

**Solution:**  If the I/O errors are temporary, reactivate the disk to return it to **Online** status. For instructions describing how to bring the disk back online, see [Reactivate a Missing or Offline Dynamic Disk](reactivate-a-missing-or-offline-dynamic-disk.md). See also [disk status descriptions](http://go.microsoft.com/fwlink/?LinkId=64112).

<a id="BKMK_6"></a>
##### A dynamic disk's status is Offline or Missing.

**Cause:** An **Offline** dynamic disk might be corrupted or intermittently unavailable. An error icon appears on the offline dynamic disk.

If the disk status is **Offline** and the disk's name changes to **Missing**, the disk was recently available on the system but can no longer be located or identified. The missing disk may be corrupted, powered down, or disconnected.

**Solution:**
To bring a disk that is Offline and Missing back online:
1. Repair any disk, controller, or cable problems. 
2. Make sure that the physical disk is turned on, plugged in, and attached to the computer. 
3. Next, use the **Reactivate Disk** command to bring the disk back online. For instructions describing how to reactivate missing or offline disks, see [Reactivate a Missing or Offline Dynamic Disk](reactivate-a-missing-or-offline-dynamic-disk.md)

4. If the disk status remains **Offline** and the disk name remains **Missing**, and you determine that the disk has a problem that cannot be repaired, you can remove the disk from the system by right-clicking the disk and then clicking **Remove Disk**). However, before you can remove the disk, you must delete all volumes (or mirrors) on the disk. You can save any mirrored volumes on the disk by removing the mirror instead of the entire volume. Deleting a volume destroys the data in the volume, so you should remove a disk only if you are absolutely certain that the disk is permanently damaged and unusable.

**To bring a disk that is Offline and is still named Disk \# (not Missing) back online, try one or more of the following procedures:**

1. In Disk Management, right-click the disk and then click **Reactivate Disk** to bring the disk back online. If the disk status remains **Offline**, check the cables and disk controller, and make sure that the physical disk is healthy. Correct any problems and try to reactivate the disk again. If the disk reactivation succeeds, any volumes on the disk should automatically return to the **Healthy** status.
2. In Event Viewer, check the event logs for any disk-related errors such as "No good config copies". If the event logs contain this error, contact [Microsoft Product Support Services](https://msdn.microsoft.com/library/aa263468(v=vs.60).aspx).

3. Try moving the disk to another computer. If you can get the disk to go **Online** on another computer, the problem is most likely due to the configuration of the computer on which the disk does not go **Online**.

4. Try moving the disk to another computer that has dynamic disks. Import the disk on that computer and then move the disk back to the computer on which it would not go **Online**. See also [Disk Status Descriptions](http://go.microsoft.com/fwlink/?LinkId=64112).

<a id="BKMK_7"></a>
##### A basic or dynamic volume's status is Failed.

**Cause:**  The basic or dynamic volume cannot be started automatically, the disk is damaged, or the file system is corrupt. Unless the disk or file system can be repaired, the **Failed** status indicates data loss.

**Solution:**  If the volume is a basic volume with **Failed** status:

-   Make sure that the underlying physical disk is turned on, plugged in, and attached to the computer. No other user action is possible for basic volumes.

    If the volume is a dynamic volume with **Failed** status: 
-   Make sure the underlying disks are online. If not, return the disks to the **Online** status. If this succeeds, the volume automatically restarts and returns to the **Healthy** status. If the dynamic disk returns to the **Online** status, but the dynamic volume does not return to the **Healthy** status, you can reactivate the volume manually. 

    For instructions describing how to reactivate or bring a disk online, see [Reactivate a Missing or Offline Dynamic Disk](reactivate-a-missing-or-offline-dynamic-disk.md). If the dynamic volume is a mirrored or RAID-5 volume with old data, bringing the underlying disk online will not automatically restart the volume. If the disks that contain current data are disconnected,  bring those disks online first (to allow the data to become synchronized). Otherwise, restart the mirrored or RAID-5 volume manually, and then run the Error-checking tool or Chkdsk.exe.
    See [How to reactivate a volume](http://go.microsoft.com/fwlink/?LinkId=64115). Also see [Disk Status Descriptions](http://go.microsoft.com/fwlink/?LinkId=64112).

<a id="BKMK_8"></a>
##### A basic or dynamic volume's status is Unknown.

**Cause:**  The **Unknown** status occurs when the boot sector for the volume is corrupted (possibly due to a virus) and you can no longer access data on the volume. The **Unknown** status also occurs when you install a new disk but do not successfully complete the wizard to create a disk signature.

**Solution**  Initialize the disk. For instructions, see [Initialize New Disks](initialize-new-disks.md). For more information, see [volume status descriptions](http://go.microsoft.com/fwlink/?LinkId=64113).

<a id="BKMK_9"></a>
##### A dynamic volume's status is Data Incomplete.

**Cause:** You moved some but not all of the disks in a multi-disk volume. Data on this volume will be destroyed unless you move and import the remaining disks that contain this volume.

**Solution:**  
1. Move all the disks that comprise the multi-disk volume to the computer.

2. Import the disks. For instructions describing how to move and import disks, see [Move Disks to Another Computer](move-disks-to-another-computer.md).

If you no longer require the multidisk volume, you can import the disk and create new volumes on it. To do so: 

1. Right-click the volume with **Failed** or **Failed Redundancy** status and then click **Delete Volume**. 
2. Right-click the disk and then click **New Volume**. For more information, see [Volume Status Descriptions](http://go.microsoft.com/fwlink/?LinkId=64113).

<a id="BKMK_10"></a>
##### A dynamic volume's status is Healthy (At Risk).

**Cause:**  Indicates that the dynamic volume is currently accessible, but I/O errors have been detected on the underlying dynamic disk. If an I/O error is detected on any part of a dynamic disk, all volumes on the disk display the **Healthy (At Risk)** status and a warning icon appears on the volume.

When the volume status is **Healthy (At Risk)**, an underlying disk's status is usually **Online (Errors)**.

**Solution:**  Return the underlying disk to the **Online** status. Once the disk is returned to **Online** status, the volume should return to the **Healthy** status. If the **Healthy (At Risk)** status persists, the disk might be failing. Back up the data and replace the disk as soon as possible. For instructions describing how to bring the disk back online, see [Reactivate a Missing or Offline Dynamic Disk](reactivate-a-missing-or-offline-dynamic-disk.md). For more information, see [Volume Status Descriptions](http://go.microsoft.com/fwlink/?LinkId=64113).

<a id="BKMK_11"></a>
##### Cannot manage striped volumes using Disk Management or DiskPart.

**Cause:**  Some non-Microsoft disk management products replace Microsoft Logical Disk Manager (LDM) for advanced disk management, which can disable the LDM.

**Solution:**  If you are using non-Microsoft disk management software that has disabled LDM, you must contact the vendor on the non-Microsoft disk management software for support or assistance in troubleshooting problems with the disk configuration.

<a id="BKMK_virtdisk"></a>
##### Disk Management cannot start the Virtual Disk Service.

**Cause:**  If a remote computer does not support the Virtual Disk Service (VDS) or if you cannot establish a connection to the remote computer because it is blocked by Windows Firewall, you may receive this error.

**Solution:**  If the remote computer supports VDS, you can configure Windows Defender Firewall to allow VDS connections. If the remote computer does not support VDS, you can use Remote Desktop Connection to connect to it and then run Disk Management directly on the remote computer.

To manage disks on remote computers that do support VDS, you must configure the Windows Defender Firewall on both the local computer (on which you are running Disk Management) and the remote computer. On the local computer, configure Windows Defender Firewall to enable the Remote Volume Management Exception.

> [!NOTE]
> The Remote Volume Management Exception includes exceptions for Vds.exe, Vdsldr.exe, and TCP port 135.

The following table details how to configure Windows Defender Firewall on various remote computers to allow connections from Disk Management that is running on a computer with Windows Server 2008, Windows Vista, or Windows Vista with Service Pack 1 (SP1).

<br />

| Remote computer operating system | Windows Defender Firewall configuration |
| ---| --- |
| <p>Windows Server 2008</p> | <p>Enable Remote Volume Management Exception.</p> | 
|<p>Windows Vista</p> | <p> <ul><li>Enable Remote Volume Management Exception.</p></li> <p><li>Enable the File and Print Sharing exception.</p></li></ul> |
| <p>Windows Vista with SP1</p> | <p> Enable Remote Volume Management Exception.</p> |
| <p>Windows Server 2003 with SP1</p> | <p>Enable the following exceptions:</p><ul><li>TCP port 135<br /><br /></li><li>Vds.exe<br /><br /></li></ul> |

 > [!NOTE]
 > Remote connections in workgroups are not supported. Both the local computer and the remote computer must be members of a domain.