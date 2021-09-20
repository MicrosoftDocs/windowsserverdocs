---
title: A virtual SAN should be associated with a physical host bus adapter
description: Learn what to do when a virtual storage area network (SAN) has been configured without an association to a host bus adapter (HBA).
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: 14bca69b-e779-4e90-b5c1-1b015625572f
ms.date: 8/16/2016
---
# A virtual SAN should be associated with a physical host bus adapter

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
*A virtual storage area network (SAN) has been configured without an association to a host bus adapter (HBA).*

## **Impact**
*A virtual machine will fail to start when it is configured with a virtual Fibre Channel adapter connected to a misconfigured virtual SAN. This impacts the following virtual SANs:*


\<list of virtual SANs>


## **Resolution**
*Reconfigure the virtual SAN by connecting it to a host bus adapter.*
