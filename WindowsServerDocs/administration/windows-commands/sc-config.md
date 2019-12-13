---
title: Sc config
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ad4d68a6-efe5-452b-8501-7f1f1c552a4a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 06/05/2018
---

# Sc config



Modifies the value of a service's entries in the registry and in the Service Control Manager database.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
sc [<ServerName>] config [<ServiceName>] [type= {own | share | kernel | filesys | rec | adapt | interact type= {own | share}}] [start= {boot | system | auto | demand | disabled | delayed-auto}] [error= {normal | severe | critical | ignore}] [binpath= <BinaryPathName>] [group= <LoadOrderGroup>] [tag= {yes | no}] [depend= <dependencies>] [obj= {<AccountName> | <ObjectName>}] [displayname= <DisplayName>] [password= <Password>]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|\<ServerName>|Specifies the name of the remote server on which the service is located. The name must use the Universal Naming Convention (UNC) format (for example, \\\\myserver). To run SC.exe locally, omit this parameter.|
|\<ServiceName>|Specifies the service name returned by the **getkeyname** operation.|
|type= {own\| share \| kernel \| filesys \| rec \| adapt \| interact type= {own \| share}} | Specifies the service type.</br>**own** - Specifies a service that runs in its own process. It does not share an executable file with other services. This is the default value.</br>**share** - Specifies a service that runs as a shared process. It shares an executable file with other services.</br>**kernel** - Specifies a driver.</br>**filesys** - Specifies a file system driver.</br>**rec** - Specifies a file system-recognized driver that identifies file systems used on the computer.</br>**adapt** - Specifies an adapter driver that identifies hardware devices such as keyboards, mice, and disk drives.</br>**interact** - Specifies a service that can interact with the desktop, receiving input from users. Interactive services must be run under the LocalSystem account. This type must be used in conjunction with **type= own** or **type= shared** (for example, **type= interact** **type= own**). Using **type= interact** by itself will generate an error.|
|start= {boot \| system \| auto \| demand \| disabled \| delayed-auto}|Specifies the start type for the service.</br>**boot** - Specifies a device driver that is loaded by the boot loader.</br>**system** - Specifies a device driver that is started during kernel initialization.</br>**auto** - Specifies a service that automatically starts each time the computer is restarted and runs even if no one logs on to the computer.</br>**demand** - Specifies a service that must be started manually. This is the default value if **start=** is not specified.</br>**disabled** - Specifies a service that cannot be started. To start a disabled service, change the start type to some other value.</br>**delayed-auto** - Specifies a service that starts automatically a short time after other auto services are started.|
|error= {normal \| severe \| critical \| ignore}|Specifies the severity of the error if the service fails to start at boot time.</br>**normal** - Specifies that the error is logged and a message box is displayed, informing the user that a service has failed to start. Startup will continue. This is the default setting.</br>**severe** - Specifies that the error is logged (if possible). The computer attempts to restart with the last-known good configuration. This could result in the computer being able to restart, but the service may still be unable to run.</br>**critical** - Specifies that the error is logged (if possible). The computer attempts to restart with the last-known good configuration. If the last-known good configuration fails, startup also fails, and the boot process halts with a Stop error.</br>**ignore** - Specifies that the error is logged and startup continues. No notification is given to the user beyond recording the error in the Event Log.|
|binpath= \<BinaryPathName>|Specifies a path to the service binary file.|
|group= \<LoadOrderGroup>|Specifies the name of the group of which this service is a member. The list of groups is stored in the registry, in the **HKLM\System\CurrentControlSet\Control\ServiceGroupOrder** subkey. The default value is null.|
|tag= {yes \| no}|Specifies whether or not to obtain a TagID from the CreateService call. Tags are used only for boot-start and system-start drivers.|
|depend= \<dependencies>|Specifies the names of services or groups that must start before this service. The names are separated by forward slashes (/).|
|obj= {\<AccountName> \| \<ObjectName>}|Specifies a name of an account in which a service will run, or specifies a name of the Windows driver object in which the driver will run. The default setting is **LocalSystem**.|
|displayname= \<DisplayName>|Specifies a descriptive name for identifying the service in user interface programs. For example, the subkey name of one particular service is **wuauserv**, which has a more friendly display name of Automatic Updates.|
|password= \<Password>|Specifies a password. This is required if an account other than the LocalSystem account is used.|
|/?|Displays help at the command prompt.|

## Remarks

-   For each command-line option (parameter), the equal sign is part of the option name.
-   A space is required between an option and its value (for example, **type= own**. If the space is omitted, the operation will fail.

## <a name="BKMK_examples"></a>Examples

To specify a binary path for the NEWSERVICE service, type:
```
sc config NewService binpath= "ntsd -d c:\windows\system32\NewServ.exe"
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)