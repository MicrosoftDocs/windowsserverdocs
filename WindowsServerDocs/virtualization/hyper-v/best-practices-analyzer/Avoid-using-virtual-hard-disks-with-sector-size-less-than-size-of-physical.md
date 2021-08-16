---
title: Avoid using virtual hard disks with a sector size less than the sector size of the physical storage that stores the virtual hard disk file
description: Learn what to do when one or more virtual hard disks have a physical sector size that is smaller than the physical sector size of the storage on which the virtual hard disk file is located.
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: b7cf994e-bf4b-4b1b-bad6-ecf7d46d105e
ms.date: 8/16/2016
---
# Avoid using virtual hard disks with a sector size less than the sector size of the physical storage that stores the virtual hard disk file

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831400(v=ws.11)).

|Property|Details|
|-|-|
|**Operating** <br />**System**|Windows Server 2016|
|**Product/Feature**|Hyper-V|
|**Severity**|Warning|
|**Category**|Configuration|

In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.

## **Issue**
*One or more virtual hard disks have a physical sector size that is smaller than the physical sector size of the storage on which the virtual hard disk file is located.*

## **Impact**
*Performance problems might occur on the virtual machine or application that use the virtual hard disk. This impacts the following virtual machines:*

\<list of virtual machines>

## **Resolution**
*Do one of the following:*

-   *Perform a storage migration to move the virtual hard disk to a new physical system*

-   *Use Windows PowerShell or WMI to enable a VHDX-format virtual hard disk to report a specific sector size*

-   *Use a registry setting to enable a VHD-format virtual hard disk to report a physical sector size of 4k*
