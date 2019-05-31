---
title: Using the get-AllServers Command
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fe2e3c69-8f2e-457d-af55-d249ebf70f53
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# Using the get-AllServers Command



Retrieves information about all Windows Deployment Services servers.

> [!NOTE]
> This command may take an extended amount of time to complete if there are many Windows Deployment Services servers in your environment or if the network connection linking the servers is slow.

## Syntax

```
WDSUTIL [Options] /Get-AllServers /Show:{Config | Images | All} [/Detailed] [/Forest:{Yes | No}]
```

## Parameters

|   Parameter   |                                                                                                                 Description                                                                                                                  |
|---------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| /Show:{Config |                                                                                                                    Images                                                                                                                    |
|  [/Detailed]  | When used in conjunction with the **/Show:Images** or **/Show:All**, returns all image metadata from each image. If the **/Detailed** option is not specified, the default behavior is to return the image name, description, and file name. |
| [/Forest:{Yes |                                                                                                                     No}]                                                                                                                     |

## <a name="BKMK_examples"></a>Examples

To view information about all servers, type:
```
WDSUTIL /Get-AllServers /Show:Config
```
To view detailed information about all servers, type:
```
WDSUTIL /Verbose /Get-AllServers /Show:All /Detailed /Forest:Yes
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)