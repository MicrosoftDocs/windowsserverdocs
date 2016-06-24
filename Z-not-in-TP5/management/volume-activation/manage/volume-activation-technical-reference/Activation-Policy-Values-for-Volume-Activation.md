---
title: Activation Policy Values for Volume Activation
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5d97fc63-0f86-4936-ba46-1d92127a1121
---
# Activation Policy Values for Volume Activation
Table 8 lists policy values for Windows 8.1 and  Windows Server 2012 R2 .

**Table 8. Windows 8.1 and  Windows Server 2012 R2  policy values**

|**Element**|**Client value**|**Server value**|**Range**|
|---------------|--------------------|--------------------|-------------|
|Rearm limit|1000|1000|Not configurable|
|KMS Client Count Threshold|25|5|Not configurable|
|KMS Activation duration|180 days|180 days|Not configurable|
|KMS host listening port|1688|1688|Any open TCP port|
|OOB Grace|Not available|Not available|Not configurable|
|OOT Grace|Not available|Not available|Not configurable|
|KMS client reactivation (in minutes)|10,080 minutes<br /><br />(7 days—default)|10,080 minutes<br /><br />(7 days—default)|15–43,200 minutes<br /><br />(30 days—default)|
|Silent KMS retry interval—occurs on KMS activation failure|120 minutes|120 minutes|15–43,200 minutes<br /><br />(120 minutes—default)|

## See also

-   [Volume Activation Technical Reference](../Volume-Activation-Technical-Reference.md)

-   [Volume Activation Overview](Volume-Activation-Overview.md)


