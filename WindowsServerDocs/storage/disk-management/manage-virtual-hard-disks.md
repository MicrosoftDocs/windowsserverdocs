---
title: Manage Virtual Hard Disks (VHD)
description: This article describes how to manage Virtual Hard Disks
ms.prod: windows-server-threshold 
ms.technology: storage 
ms.topic: article 
author: JasonGerend 
manager: brianlic 
ms.author: jrgerend 
---

# Manage Virtual Hard Disks (VHD)

> **Applies To:** Windows 10, Windows 8.1, Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The Virtual Hard Disk (VHD) format is a publicly available image format specification that specifies a virtual hard disk encapsulated in a single file, capable of hosting native file systems while supporting standard disk and file operations. For example, they are commonly used as part of the Hyper-V feature of Windows Server 2008 R2. For more information about VHDs, refer to the See Also section of this article. 

You can use Disk Management to create, attach, and detach virtual hard disks (VHDs).

## Viewing VHDs in Disk Management

VHDs appear just like physical disks in Disk Management. When a VHD has been attached (that is, made available to the system for use), it appears blue. If the disk is detached (that is, made unavailable), its icon reverts to gray.

## Creating a VHD

> [!NOTE]
> You must be a member of the **Backup Operators** or **Administrators** group, at minimum, to complete these steps.

**To create a VHD**

1.  On the **Action** menu, select **Create VHD**.

2.  In the **Create and Attach Virtual Hard Disk** dialog box, specify both the location on the physical computer where you want the VHD file to be stored, and the size of the VHD.

3.  In **Virtual hard disk format**, select **Dynamically expanding** or **Fixed size**, and then click **OK**.

## Attaching and detaching a VHD

To make a VHD available for use (either one you have just created or another existing VHD): 

1. On the **Action** menu, select **Attach VHD**. 
2. Specify the location of the VHD, using a fully-qualified path.

To detach the VHD, which will make it unavailable: 

1. On the **Action** menu, select **Detach VHD**, or right-click the VHD in the volume list or graphical view. 
2. Select **Detach VHD**. Detaching a VHD does not delete the VHD or any data stored in it.

## Additional considerations

-   The path specifying the location for the VHD must be fully-qualified and cannot be in the \\Windows directory.
-   The minimum size for a VHD is 3 megabytes (MB).
-   A VHD can only be a basic disk.
-   Because a VHD is initialized when it is created, creating a large fixed-size VHD might take some time.

## See Also

-   [Virtual Hard Disk Image Format Specification](http://go.microsoft.com/fwlink/?LinkId=139201)
-   [Virtual Server 2005 Administrator\'s Guide Glossary](http://go.microsoft.com/fwlink/?LinkId=143882)


