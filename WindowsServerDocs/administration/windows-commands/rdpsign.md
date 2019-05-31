---
title: rdpsign
description: Learn how to digitally sign an RDP file.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4a6fa8ce-3d32-49a5-b056-bcc1a23391f5
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 07/11/2018
---
# rdpsign

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Enables you to digitally sign a Remote Desktop Protocol (.rdp) file.
for examples of how to use this command, see [Examples](#BKMK_examples).

> [!NOTE]
> In Windows Server 2008 R2, Terminal Services was renamed Remote Desktop Services. To find out what's new in the latest version, see [What s New in Remote Desktop Services in Windows Server 2012](https://technet.microsoft.com/library/hh831527) in the Windows Server TechNet Library.

## Syntax
```
rdpsign /sha1 <hash> [/q | /v |] [/l] <file_name.rdp>
```

## Parameters

|Parameter|Description|
|-------|--------|
|/sha1 \<hash>|Specifies the thumbprint, which is the Secure Hash Algorithm 1 (SHA1) hash of the signing certificate that is included in the certificate store.|
|/q|Quiet mode. No output when the command succeeds and minimal output if the command fails.|
|/v|verbose mode. Displays all warnings, messages, and status.|
|/l|Tests the signing and output results without actually replacing any of the input files.|
|/?|Displays help at the command prompt.|

## Remarks
-   The SHA1 certificate thumbprint should represent a trusted .rdp file publisher. To obtain the certificate thumbprint, open the Certificates snap-in, double-click the certificate that you want to use (either in the local computer's certificates store or in your personal certificates store), click the **details** tab, and then in the **Field** list, click **Thumbprint**.

    > [!NOTE]
    > When you copy the thumbprint for use with the rdpsign.exe tool, you must remove any spaces.

-   You must specify the .rdp file (or files) to sign by using the full file name. Wildcard characters are not accepted.
-   The signed output files will overwrite the input files.
-   if any of the .rdp files cannot be read or written to, the tool will continue to the next file if multiple files are specified.

## <a name="BKMK_examples"></a>Examples
- To sign an .rdp file that is named File1.rdp, navigate to the folder where you saved the .rdp file, and then type the following:
  ```
  rdpsign /sha1 hash file1.rdp
  ```
  > [!NOTE]
  > The *hash* value represents the SHA1 certificate thumbprint, without any spaces.
- To test whether digital signing will succeed for an .rdp file without actually signing the file, type the following:
  ```
  rdpsign /sha1 hash /l file1.rdp
  ```
- To sign multiple .rdp files, separate the file names by using spaces. For example, to sign multiple .rdp files that are named File1.rdp, File2.rdp, and File3.rdp, type the following:
  ```
  rdpsign /sha1 hash file1.rdp file2.rdp file3.rdp
  ```
  ## See Also
  [Command-Line Syntax Key](command-line-syntax-key.md)
  [Remote Desktop Services &#40;Terminal Services&#41; Command Reference](remote-desktop-services-terminal-services-command-reference.md)
