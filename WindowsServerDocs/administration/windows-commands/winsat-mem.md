---
title: winsat mem
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: cda017bf-6193-43c1-b71f-e379c23e1152
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# winsat mem



Tests system memory bandwidth in a manner reflective of large memory to memory buffer copies, as are used in multimedia processing.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
winsat mem <parameters>
```

## Parameters

|Parameter|Description|
|---------|-----------|
|-up|Force memory testing with only one thread. The default is to run one thread per physical CPU or core.|
|-rn|Specify that the assessment's threads should run at normal priority. The default is to run at priority 15.|
|-nc|Specify that the assessment should allocate memory and flag it as un-cached. This means that the processor's caches will be bypassed for copy operations. The default is to run in cached space.|
|-do \<n>|Specify the distance, in bytes, between the end of the source buffer and the beginning of the destination buffer. The default is 64 bytes. The maximum allowable destination offset is 16MB. Specifying an invalid destination offset will result in an error.</br>Note: Zero is a valid value for **\<n>**, but negative numbers are not.|
|-mint \<n>|Specify the minimum run time in seconds for the assessment. The default is 2.0. The minimum value is 1.0. The maximum value is 30.0.</br>Note: Specifying a **-mint** value greater than the **-maxt** value when the two parameters are used in combination will result in an error.|
|-maxt \<n>|Specify the maximum run time in seconds for the assessment. The default is 5.0. The minimum value is 1.0. The maximum value is 30.0. If used in combination with the **-mint** parameter, the assessment will begin to do periodic statistical checks of its results after the period of time specified in **-mint**. If the statistical checks pass, then the assessment will finish before the period of time specified in **-maxt** has elapsed. If the assessment runs for the period of time specified in **-maxt** without satisfying the statistical checks, then the assessment will finish at that time and return the results it has collected.|
|-buffersize \<n>|Specify the buffer size that the memory copy test should use. Twice this amount will be allocated per CPU, which determines the amount of data copied from one buffer to another. The default is 16MB. This value is rounded to the nearest 4 KB boundary. The maximum value is 32MB. The minimum value is 4 KB. Specifying an invalid buffer size will result in an error.|
|-v|Send verbose output to STDOUT, including status and progress information. Any errors will also be written to the command window.|
|-xml \<file name>|Save the output of the assessment as the specified XML file. If the specified file exists, it will be overwritten.|
|-idiskinfo|Save information about physical volumes and logical disks as part of the **\<SystemConfig>** section in the XML output.|
|-iguid|Create a globally unique identifier (GUID) in the XML output file.|
|-note "note text"|Add the note text to the **\<note>** section in the XML output file.|
|-icn|Include the local computer name in the XML output file.|
|-eef|Enumerate extra system information in the XML output file.|

## <a name="BKMK_examples"></a>Examples

- The following example runs the assessment for a minimum of 4 seconds and no longer than 12 seconds, using a 32MB buffer size and saving the results in XML format to the file **memtest.xml**.  
  ```
  winsat mem -mint 4.0 -maxt 12.0 -buffersize 32MB -xml memtest.xml
  ```

## Remarks

-   Membership in the local Administrators group, or equivalent, is the minimum required to use **winsat**. The command must be executed from an elevated command prompt window.
-   To open an elevated command prompt window, click **Start**, click **Accessories**, right-click **Command Prompt**, and click **Run as administrator**.

#### Additional references

