---
title: Troubleshoot Disk Management
description: Learn how to diagnose and troubleshoot the most common issues you might see when using Disk Management for Windows and Windows Server. 
ms.date: 03/17/2023
ms.topic: article
author: JasonGerend
manager: brianlic
ms.author: jgerend
---

# Troubleshoot Disk Management

> **Applies To:** Windows 11, Windows 10, Windows Server 2022, Windows Server 2019, and Windows Server 2016

This article lists some common issues you might see when using Disk Management and it provides basic troubleshooting steps to try.

> [!TIP]
> If you get an error or something doesn't work when following these steps, there's more help available. This article lists just the first few things to try. There's much more information on the [Microsoft community](https://answers.microsoft.com/en-us/windows) site in the [Files, folders, and storage](https://answers.microsoft.com/en-us/windows/forum/windows_10-files?sort=lastreplydate&dir=desc&tab=All&status=all&mod=&modAge=&advFil=&postedAfter=&postedBefore=&threadType=all&isFilterExpanded=true&tm=1514405359639) section. That section lists the wide variety of hardware and software configurations you might be dealing with. If you still need help, post a question there, [Contact Microsoft Support](https://support.microsoft.com/contactus/), or contact the manufacturer of your hardware.

## Open Disk Management

Open Disk Management with the following steps.

1. In the search box on the taskbar, enter **Computer Management**, select and hold (or right-click) **Computer Management**, and then choose **Run as administrator**.
1. After Computer Management opens, go to **Storage** > **Disk Management**.

## Disks that are missing or not initialized, plus general troubleshooting steps

:::image type="content" source="media/uninitialized-disk.png" alt-text="Screenshot that shows Disk Management highlighting an unknown disk that must be initialized.":::

**Cause:**
If you don't see the disk in File Explorer and it's listed in Disk Management as *Not Initialized*, the disk might not have a valid disk signature. It's either because the disk was never initialized and formatted, or the drive formatting has become corrupted somehow. It's also possible that the disk is having hardware problems or other issues as described further on in this article.

**Solution:** If the drive is new and just needs to be initialized, the solution is to initialize the disk. For more information, see [Initialize new disks](initialize-new-disks.md). But there's a good chance you've already tried this approach, and it didn't work. Or maybe you have a disk full of important files that you don't want the initializing process to erase.

There are many reasons a disk or memory card might be missing or fail to initialize, but the most common reason is that the disk is failing. There's only so much you can do to fix a failing disk. The following are some steps to try to get it working again. If the disk works after you've completed one of these steps, don't bother with the remaining ones. At this point, maybe update your backups.

1. Look at the disk in Disk Management. If it displays **Offline** as shown below, right-click on the **Offline** disk and select **Online**.

    :::image type="content" source="media/offline-disk.png" alt-text="Screenshot that shows the disk as offline.":::

1. If the disk appears in Disk Management as *Online*, and has a primary partition that's listed as *Healthy*, as shown here, that's a good sign.

    :::image type="content" source="media/healthy-volume.png" alt-text="Screenshot that shows a disk that's online and with a healthy volume.":::

    - If a partition has a file system, but no drive letter (for example, E:), see [Change a drive letter](change-a-drive-letter.md) to manually add a drive letter.
    - If a partition doesn't have a file system (it's listed as RAW instead of NTFS, ReFS, FAT32, or exFAT) and you know that the disk is empty, select and hold (or right-click) the partition and select **Format**. Formatting a disk erases all data on it, so don't do this step if you're trying to recover files from the disk. Instead, skip ahead to the next step.
    - If the partition is listed as *Unallocated* and you know that the partition is empty, select and hold (or right-click) the unallocated partition. Then select **New Simple Volume** and follow the instructions to create a volume in the free space. Don't do this step if you're trying to recover files from this partition. Instead, skip ahead to the next step.

    > [!NOTE]
    > Ignore any partitions that are listed as **EFI System Partition** or **Recovery Partition**. These partitions are full of important files that your PC needs to operate properly. It's best to just leave them alone to do their job of starting your PC and helping you recover from problems.

1. If you have an external disk that's not showing up, unplug the disk, plug it back in, and then select **Action** > **Rescan Disks**.
1. Shut down your PC, turn off your external hard disk (if it's an external disk with a power cord), and then turn your PC and the disk back on.
    To turn off your PC in Windows 10, select the Start button, select the Power button, and then select **Shut down**.
1. Plug the disk into a different USB port that's directly on your PC (not on a hub).
    Sometimes, USB disks don't get enough power from some ports, or they have other issues with particular ports. This issue is especially common with USB hubs, but sometimes there are differences between ports on a PC. So if you have other ports, try a few different ones.
1. Try a different cable.
    Cables fail often, so try using a different cable to plug in the disk. If you have an internal disk in a desktop PC, you need to shut down your PC before switching cables. See your PC's manual for details.
1. Check Device Manager for issues.
    Select and hold (or right-click) the Start button, then select **Device Manager** from the context menu. Look for any devices with an exclamation point beside it or other issues. Select the device and then read its status.

    Here's a list of [Error codes in Device Manager](https://support.microsoft.com/help/310123/error-codes-in-device-manager-in-windows), but one approach that sometimes works is to select and hold (or right-click) the problematic device, select **Uninstall device**, and then **Action** > **Scan for hardware changes**.

    :::image type="content" source="media/device-manager.png" alt-text="Screenshot of Device Manager showing an unknown USB device.":::

1. Plug the disk into a different PC.

    If the disk doesn't work on another PC, it's a good sign that there's something wrong with the disk, and not your PC. Search for and ask for help at the [Microsoft community](https://answers.microsoft.com/) site, or contact your disk manufacturer or [Microsoft Support](https://support.microsoft.com/contactus/).

    If you just can't get it working, there are apps that can try to recover data from a failing disk. Or if the files are vitally important, you can pay a data recovery lab to try to recover them. If you find something that works for you, let us know in the comments section.

> [!IMPORTANT]
> Disks fail often, so it's important to regularly back up any files you care about. If you have a disk that sometimes doesn't appear or gives errors, consider this a reminder to double-check your backup methods. It's OK if you're a little behind - we've all been there. The best backup solution is one you use, so we encourage you to find one that works for you and stick with it.
>
> [!TIP]
> For more information on using apps built into Windows to backup files to an external drive such as a USB drive, see [Backup and restore in Windows](https://support.microsoft.com/help/17143/windows-10-back-up-your-files). You can also save files in Microsoft OneDrive, which syncs files from your PC to the cloud. If your hard disk fails, you'll still be able to get any files you store in OneDrive from OneDrive.com. For more information, see [Sync files with OneDrive in Windows](https://support.microsoft.com/help/17184/windows-10-onedrive).

## A basic or dynamic disk's status is Unreadable

**Cause:** The basic or dynamic disk isn't accessible and might have experienced hardware failure, corruption, or I/O errors. The disk's copy of the system's disk configuration database might be corrupted. An error icon appears on disks that display the **Unreadable** status.

Disks might also display the **Unreadable** status while they're spinning up or when Disk Management is rescanning all of the disks on the system. In some cases, an unreadable disk has failed and isn't recoverable. For dynamic disks, the **Unreadable** status usually results from corruption or I/O errors on part of the disk, rather than failure of the entire disk.

**Solution:** Rescan the disks or restart the computer to see if the disk status changes. Also try the troubleshooting steps described in [Disks that are missing or not initialized, plus general troubleshooting steps](#disks-that-are-missing-or-not-initialized-plus-general-troubleshooting-steps).

## A dynamic disk's status is Foreign

**Cause:** The **Foreign** status occurs when you move a dynamic disk to the local computer from another computer PC. A warning icon appears on disks that display the **Foreign** status.

In some cases, a disk that was previously connected to the system can display the **Foreign** status. Configuration data for dynamic disks is stored on all dynamic disks, so the information about which disks the system owns is lost when all dynamic disks fail.

**Solution:** Add the disk to your computer's system configuration so that you can access data on the disk. To add a disk to your computer's system configuration, import the foreign disk. Select and hold (or right-click) the disk, and then select **Import Foreign Disks**. Any existing volumes on the foreign disk become visible and accessible when you import the disk.

## A dynamic disk's status is Online (Errors)

**Cause:** The dynamic disk has I/O errors on a region of the disk. A warning icon appears on the dynamic disk with errors.

**Solution:**  If the I/O errors are temporary, reactivate the disk to return it to **Online** status.

## A dynamic disk's status is Offline or Missing

**Cause:** An **Offline** dynamic disk might be corrupted or intermittently unavailable. An error icon appears on the offline dynamic disk.

If the disk status is **Offline** and the disk's name changes to **Missing**, the disk was recently available on the system but can no longer be located or identified. The missing disk might be corrupted, powered down, or disconnected.

**Solution:**
To bring a disk that's offline and missing back online:

1. Repair any disk, controller, or cable problems.
1. Make sure that the physical disk is turned on, plugged in, and attached to the computer.
1. Next, use the **Reactivate Disk** command to bring the disk back online.
1. Try the troubleshooting steps described in [Disks that are missing or not initialized, plus general troubleshooting steps](#disks-that-are-missing-or-not-initialized-plus-general-troubleshooting-steps).
1. If the disk status remains **Offline** and the disk name remains **Missing**, and you determine that the disk has a problem that can't be repaired, you can remove the disk from the system by selecting and holding (or right-clicking) the disk and then clicking **Remove Disk**). However, before you can remove the disk, you must delete all volumes (or mirrors) on the disk. You can save any mirrored volumes on the disk by removing the mirror instead of the entire volume. Deleting a volume destroys the data in the volume, so you should remove a disk only if you're certain that the disk is permanently damaged and unusable.

**To bring a disk that is Offline and is still named Disk \# (not Missing) back online, try one or more of the following procedures:**

1. In Disk Management, select and hold (or right-click) the disk and then select **Reactivate Disk** to bring the disk back online. If the disk status remains **Offline**, check the cables and disk controller, and make sure that the physical disk is healthy. Correct any problems and try to reactivate the disk again. If the disk reactivation succeeds, any volumes on the disk should automatically return to the **Healthy** status.
1. In Event Viewer, check the event logs for any disk-related errors such as "No good config copies". If the event logs contain this error, you can [search additional resources](/dotnet/visual-basic/getting-started/additional-resources) for answers. Or contact [Microsoft Product Support](https://support.microsoft.com).

1. Try moving the disk to another computer. If you can get the disk to go **Online** on another computer, the problem is most likely due to the configuration of the computer on which the disk doesn't go **Online**.

1. Try moving the disk to another computer that has dynamic disks. Import the disk on that computer and then move the disk back to the computer on which it wouldn't go **Online**.

## A basic or dynamic volume's status is Failed

**Cause:**  The basic or dynamic volume can't be started automatically, the disk is damaged, or the file system is corrupt. Unless the disk or file system can be repaired, the **Failed** status indicates data loss.

**Solution:**

If the volume is a basic volume with **Failed** status:

- Make sure that the underlying physical disk is turned on, plugged in, and attached to the computer.
- Try the troubleshooting steps described in [Disks that are missing or not initialized, plus general troubleshooting steps](#disks-that-are-missing-or-not-initialized-plus-general-troubleshooting-steps).

If the volume is a dynamic volume with **Failed** status:

-   Make sure the underlying disks are online. If not, return the disks to the **Online** status. If this step succeeds, the volume automatically restarts and returns to the **Healthy** status. If the dynamic disk returns to the **Online** status, but the dynamic volume doesn't return to the **Healthy** status, you can reactivate the volume manually.
-   If the dynamic volume is a mirrored or RAID-5 volume with old data, bringing the underlying disk online doesn't automatically restart the volume. If the disks that contain current data are disconnected, bring those disks online first (to let the data synchronize). Otherwise, restart the mirrored or RAID-5 volume manually, and then run the error-checking tool or `Chkdsk.exe`.
- Try the troubleshooting steps described in [Disks that are missing or not initialized, plus general troubleshooting steps](#disks-that-are-missing-or-not-initialized-plus-general-troubleshooting-steps).

## A basic or dynamic volume's status is Unknown

**Cause:**  The **Unknown** status occurs when the boot sector for the volume is corrupted (possibly due to a virus) and you can no longer access data on the volume. The **Unknown** status also occurs when you install a new disk but don't successfully complete the wizard to create a disk signature.

**Solution**  Initialize the disk. For more information, see [Initialize new disks](initialize-new-disks.md).

## A dynamic volume's status is Data Incomplete

**Cause:** You moved some, but not all of the disks in a multi-disk volume. Data on this volume gets destroyed unless you move and import the remaining disks that contain this volume.

**Solution:**

1. Move all the disks that comprise the multi-disk volume to the computer.
1. Import the disks. For more information on how to move and import disks, see [Move disks to another computer](move-disks-to-another-computer.md).

If you no longer require the multi-disk volume, you can import the disk and create new volumes on it. To do so:

1. Select and hold (or right-click) the volume with **Failed** or **Failed Redundancy** status and then select **Delete Volume**.
1. Select and hold (or right-click) the disk and then select **New Volume**.

## A dynamic volume's status is Healthy (At Risk)

**Cause:** This status indicates that the dynamic volume is accessible, but I/O errors are detected on the underlying dynamic disk. If an I/O error is detected on any part of a dynamic disk, all volumes on the disk display the **Healthy (At Risk)** status and a warning icon appears on the volume.

When the volume status is **Healthy (At Risk)**, an underlying disk's status is usually **Online (Errors)**.

**Solution:**  
1. Return the underlying disk to the **Online** status. Once you return the disk to **Online** status, the volume should return to the **Healthy** status. If the **Healthy (At Risk)** status persists, the disk might be failing.

1. Back up the data and replace the disk as soon as possible.

## Can't manage striped volumes using Disk Management or DiskPart

**Cause:** Some non-Microsoft disk management products replace Microsoft Logical Disk Manager (LDM) for advanced disk management, which can disable the LDM.

**Solution:** If you're using non-Microsoft disk management software that has disabled LDM, contact the software vendor to get troubleshooting support for the disk configuration.

## Disk Management can't start the Virtual Disk Service

**Cause:** You might see this error when a remote computer doesn't support the Virtual Disk Service (VDS). Or the error might occur if you can't establish a connection to the remote computer because Windows Firewall is blocking the connection.

**Solution:**

1. If the remote computer supports VDS, you can configure Windows Defender Firewall to allow VDS connections. If the remote computer doesn't support VDS, you can use Remote Desktop Connection to connect to it, and then run Disk Management directly on the remote computer.
1. To manage disks on remote computers that support VDS, configure the Windows Defender Firewall on both the local computer (on which you're running Disk Management) and the remote computer.
1. On the local computer, configure Windows Defender Firewall to enable the Remote Volume Management Exception.

> [!NOTE]
> The Remote Volume Management Exception includes exceptions for Vds.exe, Vdsldr.exe, and TCP port 135. Also, work groups don't support remote connections. Both the local and remote computers must be members of a domain.

## Related links

- [Free up drive space in Windows 10](https://support.microsoft.com/help/12425/windows-10-free-up-drive-space).
