---
title: winsat mem
description: Reference article for winsat mem command that tests system memory bandwidth using a process similar to the large memory-to-memory buffer copies in multimedia processing.
ms.topic: reference
ms.author: jgerend
author: JasonGerend
ms.date: 04/01/2023
---

# winsat mem

Applies to: Windows Server (All supported versions)

The `winsat mem` command tests system memory bandwidth using a process similar to the large memory-to-memory buffer copies in multimedia processing.

## Syntax

```CLI
winsat mem <parameters>
```

### Parameters

|Parameter|Description|
|---------|-----------|
|`-up`|Force memory testing with only one thread. The default is to run one thread per physical CPU or core.|
|`-rn`|Specify that the assessment's threads should run at normal priority. The default is to run at priority 15.|
|`-nc`|Specify that the assessment should allocate memory and flag it as uncached. This flag means that the processor's caches is bypassed for copy operations. The default is to run in cached space.|
|`-do <n>`|Specify the distance in bytes, between the end of the source buffer and the beginning of the destination buffer. The default is 64 bytes. The maximum allowable destination offset is 16 MB. Specifying an invalid destination offset results in an error.</br>Note: Zero is a valid value for `<n>`, but negative numbers aren't.|
|`-mint <n>`|Specify the minimum run time in seconds for the assessment. The default is 2.0. The minimum value is 1.0. The maximum value is 30.0.</br>Note: Specifying a `-mint` value greater than the `-maxt` value when the two parameters are used in combination results in an error.|
|`-maxt <n>`|Specify the maximum run time in seconds for the assessment. The default is 5.0. The minimum value is 1.0. The maximum value is 30.0. If used in combination with the `-mint` parameter, the assessment will begin to do periodic statistical checks of its results after the period of time specified in `-mint`. If the statistical checks pass, then the assessment finishes before the period of time specified in `-maxt` has elapsed. If the assessment runs for the period of time specified in `-maxt` without satisfying the statistical checks, then the assessment finishes at that time and return the results it has collected.|
|`-buffersize <n>`|Specify the buffer size that the memory copy test should use. Twice this amount is allocated per CPU, which determines the amount of data copied from one buffer to another. The default is 16 MB. This value is rounded to the nearest 4-KB boundary. The maximum value is 32 MB. The minimum value is 4 KB. Specifying an invalid buffer size results in an error.|
|`-v`|Send verbose output to STDOUT, including status and progress information. Any errors are also be written to the command window.|
|`-xml <file name>`|Save the output of the assessment as the specified XML file. If the specified file exists, it will be overwritten.|
|`-idiskinfo`|Save information about physical volumes and logical disks as part of the `<SystemConfig>` section in the XML output.|
|`-iguid`|Create a globally unique identifier (GUID) in the XML output file.|
|`-note <note text>`|Add the note text to the `<note text>` section in the XML output file.|
|`-icn`|Include the local computer name in the XML output file.|
|`-eef`|Enumerate extra system information in the XML output file.|

## Examples

- To run the assessment for a minimum of 4 seconds and no longer than 12 seconds, using a 32-MB buffer size and saving the results in XML format to the file `memtest.xml`:
  
```CLI
  winsat mem -mint 4.0 -maxt 12.0 -buffersize 32MB -xml memtest.xml
  ```

## Remarks

- Minimum requirement to use the `winsat mem` command is membership in the local Administrators group (or equivalent). `Winsat mem` must be executed from an elevated command prompt window.
- To open an elevated command prompt window, select **Start**, select **Accessories**, right-select **Command Prompt**, and select **Run as administrator**.
