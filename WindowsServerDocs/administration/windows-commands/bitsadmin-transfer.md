---
title: bitsadmin Transfer
description: "Windows Commands topic for **bitsadmin Transfer** - Transfers one or more files."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fe302141-b33a-4a05-835e-dc4fc4db7d5a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin Transfer

Transfers one or more files. To transfer more than one file, specify multiple \<RemoteFileName\>-\<LocalFileName\> pairs. The pairs are space-delimited.

## Syntax

```
bitsadmin /Transfer <Name> [<Type>] [/Priority <Job_Priority>] [/ACLFlags <Flags>] [/DYNAMIC] <RemoteFileName> <LocalFileName>
```

## Parameters

|Parameter|Description|
|---------|-----------|
|Name|The name of the job. Unlike most commands, **Name** may only be a name and not a GUID.|
|Type|Optional—specify the type of job. Use **/DOWNLOAD** (the default) for a download job or **/UPLOAD** for an upload job.|
|Priority|Optional—set the job_priority to one of the following values:</br>-   FOREGROUND</br>-   HIGH</br>-   NORMAL</br>-   LOW|
|ACLFlags|Optional—indicates that you want to maintain the owner and ACL information with the file being downloaded. For example, to maintain the owner and group with the file, set flags to `OG`. Specify one or more of the following flags:</br>-   O: Copy owner information with file.</br>-   G: Copy group information with file.</br>-   D: Copy DACL information with file.</br>-   S: Copy SACL information with file.|
|\/DYNAMIC|Configures the job with [**BITS_JOB_PROPERTY_DYNAMIC_CONTENT**](/windows/desktop/api/bits5_0/ne-bits5_0-bits_job_property_id), which relaxes the server-side requirements.|
|RemoteFileName|The name of the file when transferred to the server.|
|LocalFileName|The name of the file that resides locally.|

## Remarks

By default, the BITSAdmin service creates a download job that runs at **NORMAL** priority and updates the command window with progress information until the transfer is complete or until a critical error occurs. The service completes the job if it successfully transfers all the files and cancels the job if a critical error occurs. The service does not create the job if it is unable to add files to the job or if you specify an invalid value for *Type* or *Job_Priority*. To transfer more than one file, specify multiple *RemoteFileName*-*LocalFileName* pairs. The pairs are space-delimited.

> [!NOTE]
> The BITSAdmin command continues to run if a transient error occurs. To end the command, press CTRL+C.

## <a name="BKMK_examples"></a>Examples

The following example starts a transfer job with named *myDownloadJob*.
```
C:\>bitsadmin /Transfer myDownloadJob http://prodserver/audio.wma c:\downloads\audio.wma
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)