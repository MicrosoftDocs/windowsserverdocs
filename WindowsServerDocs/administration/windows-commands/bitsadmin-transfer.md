---
title: bitsadmin Transfer
description: "Windows Commands topic for **bitsadmin Transfer** - Transfers one or more files."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fe302141-b33a-4a05-835e-dc4fc4db7d5a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# bitsadmin Transfer

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Transfers one or more files.
## Syntax
```
bitsadmin /Transfer Name [type] [/Priority Job_Priority] [/ACLFlags Flags] <remoteFileName> <LocalFileName>
```
## Parameters
|Parameter|Description|
|-------|--------|
|Name|The name of the job.|
|type|Optional specify the type of job. Use **/Download** for a download job or **/Upload** for an upload job.|
|Priority|Optional  set the job_priority to one of the following values:<br /><br />-   foregROUND<br />-   HIGH<br />-   NORMAL<br />-   LOW|
|ACLFlags|Specify one or more of the following flags:<br /><br />-   O: copy owner information with file.<br />-   G: copy group information with file.<br />-   D: copy DACL information with file.<br />-   S: copy SACL information with file.|
|remoteFileName|The name of the file when transferred to the server|
|LocalFileName|The name of the file that resides locally.|
## remarks
By default, the bitsadmin service creates a download job that runs at **NORMAL** priority and updates the command window with progress information until the transfer is complete or until a critical error occurs. The service completes the job if it successfully transfers all the files and cancels the job if a critical error occurs. The service does not create the job if it is unable to add files to the job or if you specify an invalid value for *type* or *Job_Priority*. To transfer more than one file, specify multiple *remoteFileName*-*LocalFileName* pairs. The pairs are space-delimited.
> [!NOTE]
> The bitsadmin command continues to run if a transient error occurs. To end the command, press CTRL+C.
## <a name="BKMK_examples"></a>Examples
The following example starts a transfer job with named *myDownloadJob*.
```
C:\>bitsadmin /Transfer myDownloadJob http://prodserver/audio.wma c:\downloads\audio.wma
```
## additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
