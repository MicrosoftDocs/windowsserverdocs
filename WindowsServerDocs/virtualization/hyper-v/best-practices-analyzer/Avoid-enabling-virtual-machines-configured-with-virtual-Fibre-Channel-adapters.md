---
title: Avoid enabling virtual machines configured with virtual Fibre Channel adapters to allow live migrations when there are fewer paths to Fibre Channel logical units (LUNs) on the destination than on the source
description: Learn what to do when one or more virtual machines have the AllowReducedFcRedunancy property set in the virtualization WMI provider.
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.date: 8/16/2016
---
# Avoid enabling virtual machines configured with virtual Fibre Channel adapters to allow live migrations when there are fewer paths to Fibre Channel logical units (LUNs) on the destination than on the source

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831400(v=ws.11)).

|Property|Details|
|-|-|
|**Operating System**|Windows Server 2016|
|**Product/Feature**|Hyper-V|
|**Severity**|Warning|
|**Category**|Configuration|

In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.

## **Issue**
*One or more virtual machines have the AllowReducedFcRedunancy property set in the virtualization WMI provider.*

## **Impact**
*Live migration of the following virtual machines might lead to data loss or interrupt I/O to storage:*

\<list of virtual machines>

## **Resolution**
*Consider clearing the AllowReducedFcRedundancy WMI property on the affected virtual machines. When this property is cleared, you can perform a live migration on virtual machines configured with virtual Fibre Channel adapters only when the number of paths to Fibre Channel on the destination is the same or more than the number of paths on the source. These checks help prevent loss of data or interruption of I/O to the storage.*
