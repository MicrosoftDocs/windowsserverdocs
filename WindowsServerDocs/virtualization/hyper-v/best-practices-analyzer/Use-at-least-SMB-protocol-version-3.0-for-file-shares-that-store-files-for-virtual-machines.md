---
title: Use at least SMB protocol version 3.0 for file shares that store files for virtual machines.
description: Learn what to do when virtual machine files or virtual hard disk files are stored on a file share that does not support at least SMB protocol version 3.0.
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: 4bb832b8-f1aa-4c1f-a0f2-324dd53553ea
ms.date: 8/16/2016
---
# Use at least SMB protocol version 3.0 for file shares that store files for virtual machines.

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831400(v=ws.11)).

|Property|Details|
|-|-|
|**Operating System**|Windows Server 2016|
|**Product/Feature**|Hyper-V|
|**Severity**|Error|
|**Category**|Configuration|

In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.

## **Issue**
*Virtual machine files or virtual hard disk files are stored on a file share that does not support at least SMB protocol version 3.0.*

## **Impact**
*Microsoft does not support this configuration. This impacts the following virtual machines:*

\<list of virtual machines>

## **Resolution**
*Move the files to a file share that uses at least SMB protocol version 3.0.*
