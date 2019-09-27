---
title: flattemp
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 059a0960-1fd9-4382-87fe-a85d5dccdaea
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# flattemp

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Enables or disables flat temporary folders.
for examples of how to use this command, see [Examples](#BKMK_examples).

> [!NOTE]
> In Windows Server 2008 R2, Terminal Services was renamed Remote Desktop Services. To find out what's new in the latest version, see [What s New in Remote Desktop Services in Windows Server 2012](https://technet.microsoft.com/library/hh831527) in the Windows Server TechNet Library.

## Syntax
```
flattemp {/query | /enable | /disable}
```

## Parameters
|Parameter|Description|
|-------|--------|
|/query|Queries the current setting.|
|/enable|Enables flat temporary folders. Users will share the temporary folder unless the temporary folder resides in the user s home folder.|
|/disable|Disables flat temporary folders. Each user s temporary folder will reside in a separate folder (determined by the user s Session ID).|
|/?|Displays help at the command prompt.|

## Remarks
-   The **flattemp** command is only available when you have installed the Terminal Server role service on a computer running  Windows Server  2008  or the rd Session Host role service on a computer running Windows Server 2008 R2.
-   You must have administrative credentials to run **flattemp**.
-   After each user has a unique temporary folder, use **flattemp /enable** to enable flat temporary folders.
-   The default method for creating temporary folders for multiple users (usually pointed to by the TEMP and TMP environment variables) is to create subfolders in the **\Temp** folder, by using the logonID as the subfolder name. For example, if the TEMP environment variable points to C:\Temp, the temporary folder assigned to the user logonID 4 is C:\Temp\4. Using **flattemp**, you can point directly to the \Temp folder and prevent subfolders from forming. This is useful when you want the user temporary folders to be contained in home folders, whether on an rd Session Host server local drive or on a shared network drive. You should use the **flattemp /enable** command only when each user has a separate temporary folder.
-   You might encounter application errors if the user's temporary folder is on a network drive. This occurs when the shared network drive becomes momentarily inaccessible on the network. Because the temporary files of the application are either inaccessible or out of synchronization, it responds as if the disk has stopped. Moving the temporary folder to a network drive is not recommended. The default is to keep temporary folders on the local hard disk. If you experience unexpected behavior or disk-corruption errors with certain applications, stabilize your network or move the temporary folders back to the local hard disk.
-   if you disable using separate temporary folders per-session, **flattemp** settings are ignored. This option is set in the Remote Desktop Services Configuration tool.

## <a name="BKMK_examples"></a>Examples
-   To display the current setting for flat temporary folders, type:
    ```
    flattemp /query
    ```
-   To enable flat temporary folders, type:
    ```
    flattemp /enable
    ```
-   To disable flat temporary folders, type:
    ```
    flattemp /disable
    ```

## additional references
[Command-Line Syntax Key](command-line-syntax-key.md)

[Remote Desktop Services &#40;Terminal Services&#41; Command Reference](remote-desktop-services-terminal-services-command-reference.md)
