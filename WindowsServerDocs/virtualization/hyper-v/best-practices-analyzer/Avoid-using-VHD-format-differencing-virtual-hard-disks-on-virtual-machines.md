---
title: Avoid using VHD-format differencing virtual hard disks on virtual machines that run server workloads in a production environment
description: Learn what to do when one or more virtual machines use VHD-format differencing virtual hard disks.
ms.author: mosagie
author: meaghanlewis
ms.topic: best-practice
ms.assetid: 272de33d-2708-4679-8564-ee28848a2839
ms.date: 8/16/2016
---
# Avoid using VHD-format differencing virtual hard disks on virtual machines that run server workloads in a production environment

For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831400(v=ws.11)).

|Property|Details|
|-|-|
|**Operating System**|Windows Server 2016|
|**Product/Feature**|Hyper-V|
|**Severity**|Warning|
|**Category**|Configuration|

In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.

## **Issue**
*One or more virtual machines use VHD-format differencing virtual hard disks.*

## **Impact**
*VHD-format differencing virtual hard disks could experience consistency issues if a power failure occurs. Consistency issues can happen if the physical disk performs an incomplete or incorrect update to a sector in a .vhd file that is being modified when a power failure occurs. This affects the following virtual machines:*

\<list of virtual machines>

## **Resolution**
*Shut down the virtual machine and convert the chain of VHD-format differencing virtual hard disks to the VHDX format or merge the chain to a fixed virtual hard disk. (The VHDX format has reliability mechanisms that help protect the disk from corruptions due to power failures.) However, do not convert the virtual hard disk if it is likely to be attached to an earlier release of Windows at some point. Windows releases earlier than  Windows Server 2012  do not support the VHDX format.*
