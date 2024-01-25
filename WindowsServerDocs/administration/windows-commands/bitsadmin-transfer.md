---
title: bitsadmin transfer
description: Reference article for the bitsadmin transfer command, which transfers one or more files.
ms.topic: reference
ms.assetid: fe302141-b33a-4a05-835e-dc4fc4db7d5a
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bitsadmin transfer

Transfers one or more files. By default, the BITSAdmin service creates a download job that runs at **NORMAL** priority and updates the command window with progress information until the transfer is complete or until a critical error occurs,

The service completes the job if it successfully transfers all the files and cancels the job if a critical error occurs. The service does not create the job if it is unable to add files to the job or if you specify an invalid value for *type* or *job_priority*. To transfer more than one file, specify multiple `<RemoteFileName>-<LocalFileName>` pairs. The pairs must be space-delimited.

> [!NOTE]
> The BITSAdmin command continues to run if a transient error occurs. To end the command, press CTRL+C.

## Syntax

```
bitsadmin /transfer <name> [<type>] [/priority <job_priority>] [/ACLflags <flags>] [/DYNAMIC] <remotefilename> <localfilename>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| name | The name of the job. This command can't be a GUID. |
| type | Optional. Sets the type of job, including:<ul><li>**/DOWNLOAD.** The default value. Choose this type for download jobs.</li><li>**/UPLOAD.** Choose this type for upload jobs.</li></ul> |
| priority | Optional. Sets the priority of the job, including:<ul><li>FOREGROUND</li><li>HIGH</li><li>NORMAL</li><li>LOW</li></ul> |
| ACLflags | Optional. Indicates that you want to maintain the owner and ACL information with the file being downloaded. Specify one or more of the values, including:<ul><li>**o** - Copy owner information with file.</li><li>**g** - Copy group information with file.</li><li>**d** - Copy discretionary access control list (DACL) information with file.</li><li>**s** - Copy system access control list (SACL) information with file.</li></ul> |
| /DYNAMIC | Configures the job using [**BITS_JOB_PROPERTY_DYNAMIC_CONTENT**](/windows/win32/api/bits5_0/ne-bits5_0-bits_job_property_id), which relaxes the server-side requirements. |
| remotefilename | The name of the file after it's transferred to the server. |
| localfilename | The name of the file that resides locally. |

## Examples

To start a transfer job named *myDownloadJob*:

```
bitsadmin /transfer myDownloadJob http://prodserver/audio.wma c:\downloads\audio.wma
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [bitsadmin command](bitsadmin.md)
