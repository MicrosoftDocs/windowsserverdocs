---
title: flattemp
description: Reference article for the flattemp command, which enables or disables flat temporary folders.
ms.topic: reference
ms.assetid: 059a0960-1fd9-4382-87fe-a85d5dccdaea
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# flattemp

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Enables or disables flat temporary folders. You must have administrative credentials to run this command.

> [!NOTE]
> This command is only available if you have installed the Remote Desktop Session Host role service.

## Syntax

```
flattemp {/query | /enable | /disable}
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| /query | Queries the current setting. |
| /enable | Enables flat temporary folders. Users will share the temporary folder unless the temporary folder resides in the user's home folder. |
| /disable | Disables flat temporary folders. Each user's temporary folder will reside in a separate folder (determined by the user's Session ID). |
| /? | Displays help at the command prompt. |

#### Remarks

- After each user has a unique temporary folder, use `flattemp /enable` to enable flat temporary folders.

- The default method for creating temporary folders for multiple users (usually pointed to by the TEMP and TMP environment variables) is to create subfolders in the **\Temp** folder, by using the logonID as the subfolder name. For example, if the TEMP environment variable points to C:\Temp, the temporary folder assigned to the user logonID 4 is C:\Temp\4.

    Using **flattemp**, you can point directly to the \Temp folder and prevent subfolders from forming. This is useful when you want the user temporary folders to be contained in home folders, whether on an Remote Desktop Session Host server local drive or on a shared network drive. You should use the `flattemp /enable*` command only when each user has a separate temporary folder.

- You might encounter app errors if the user's temporary folder is on a network drive. This occurs when the shared network drive becomes momentarily inaccessible on the network. Because the temporary files of the app are either inaccessible or out of synchronization, it responds as if the disk has stopped. Moving the temporary folder to a network drive is not recommended. The default is to keep temporary folders on the local hard disk. If you experience unexpected behavior or disk-corruption errors with certain applications, stabilize your network or move the temporary folders back to the local hard disk.

- If you disable using separate temporary folders per-session, **flattemp** settings are ignored. This option is set in the Remote Desktop Services Configuration tool.

### Examples

To display the current setting for flat temporary folders, type:

```
flattemp /query
```

To enable flat temporary folders, type:

```
flattemp /enable
```

To disable flat temporary folders, type:

```
flattemp /disable
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

