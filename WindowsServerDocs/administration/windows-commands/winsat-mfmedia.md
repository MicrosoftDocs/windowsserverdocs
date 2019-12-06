---
title: winsat mfmedia
description: "Windows Commands"
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 09a3b3dd-f746-4e6e-b684-76a9bde0c78d
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# winsat mfmedia



Measures the performance of video decoding (playback) using the Media Foundation framework.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
winsat mfmedia <parameters>
```

## Parameters

|Parameters|Description|
|----------|-----------|
|-input \<file name>|Required: Specify the file containing the video clip to be played or encoded. The file can be in any format that can be rendered by Media Foundation.|
|-dumpgraph|Specify that the filter graph should be saved to a GraphEdit-compatible file before the assessment starts.|
|-ns|Specify that the filter graph should run at the normal playback speed of the input file. By default, the filter graph runs as fast as possible, ignoring presentation times.|
|-play|Run the assessment in decode mode and play any supplied audio content in the file specified in **-input** using the default DirectSound device. By default, audio playback is disabled.|
|-nopmp|Do not make use of the Media Foundation Protected Media Pipeline (MFPMP) process during the assessment.|
|-pmp|Always make use of the MFPMP process during the assessment.</br>Note: If **-pmp** or **-nopmp** is not specified, MFPMP will be used only when necessary.|
|-v|Send verbose output to STDOUT, including status and progress information. Any errors will also be written to the command window.|
|-xml \<file name>|Save the output of the assessment as the specified XML file. If the specified file exists, it will be overwritten.|
|-idiskinfo|Save information about physical volumes and logical disks as part of the **\<SystemConfig>** section in the XML output.|
|-iguid|Create a globally unique identifier (GUID) in the XML output file.|
|-note "note text"|Add the note text to the **\<note>** section in the XML output file.|
|-icn|Include the local computer name in the XML output file.|
|-eef|Enumerate extra system information in the XML output file.|

## <a name="BKMK_examples"></a>Examples

- The following example runs the assessment with the input file that is used during a **winsat formal** assessment, without employing the Media Foundation Protected Media Pipeline (MFPMP), on a computer where c:\windows is the location of the Windows folder.  
  ```
  winsat mfmedia -input c:\windows\performance\winsat\winsat.wmv -nopmp
  ```

## Remarks

-   Membership in the local Administrators group, or equivalent, is the minimum required to use **winsat**. The command must be executed from an elevated command prompt window.
-   To open an elevated command prompt window, click **Start**, click **Accessories**, right-click **Command Prompt**, and click **Run as administrator**.

#### Additional references

