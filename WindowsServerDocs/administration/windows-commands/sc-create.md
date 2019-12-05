---
title: Sc create
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 59416460-0661-4fef-85cc-73e9d8f4beb4
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# Sc create



Creates a subkey and entries for a service in the registry and in the Service Control Manager database.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
sc [<ServerName>] create [<ServiceName>] [type= {own | share | kernel | filesys | rec | interact type= {own | share}}] [start= {boot | system | auto | demand | disabled | delayed-auto }] [error= {normal | severe | critical | ignore}] [binpath= <BinaryPathName>] [group= <LoadOrderGroup>] [tag= {yes | no}] [depend= <dependencies>] [obj= {<AccountName> | <ObjectName>}] [displayname= <DisplayName>] [password= <Password>]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|\<ServerName>|Specifies the name of the remote server on which the service is located. The name must use the Universal Naming Convention (UNC) format (for example, \\\\myserver). To run SC.exe locally, omit this parameter.|
|\<ServiceName>|Specifies the service name returned by the **getkeyname** operation.|
|type= {own \| share \| kernel \| filesys \| rec \| interact type= {own \| share}}|Specifies the service type. The default setting is **type= own**.</br>**own** - Specifies that the service runs in its own process. It does not share an executable file with other services. This is the default setting.</br>**share** - Specifies that the service runs as a shared process. It shares an executable file with other services.</br>**kernel** - Specifies a driver.</br>**filesys** - Specifies a file system driver.</br>**rec** - Specifies a file system recognized driver (identifies file systems used on the computer).</br>**interact** - Specifies that the service can interact with the desktop, receiving input from users. Interactive services must be run under the LocalSystem account. This type must be used in conjunction with **type= own** or **type= shared**. Using **type= interact** by itself will generate an "invalid parameter" error.|
|start= {boot \| system \| auto \| demand \| disabled \| delayed-auto }|Specifies the start type for the service. The default setting is **start= demand**.</br>**boot** - Specifies a device driver that is loaded by the boot loader.</br>**system** - Specifies a device driver that is started during kernel initialization.</br>**auto** - Specifies a service that automatically starts each time the computer is restarted. Note that the service runs even if no one logs on to the computer.</br>**demand** - Specifies a service that must be started manually. This is the default value if **start=** is not specified.</br>**disabled** - Specifies a service that cannot be started. To start a disabled service, change the start type to some other value.</br>**delayed-auto** - Specifies a service that starts automatically a short time after other auto services are started.|
|error= {normal \| severe \| critical \| ignore}|Specifies the severity of the error if the service fails when the computer is started. The default setting is **error= normal**.</br>**normal** - Specifies that the error is logged. A message box is displayed, informing the user that a service has failed to start. Startup will continue. This is the default setting.</br>**severe** - Specifies that the error is logged (if possible). The computer attempts to restart with the last-known good configuration. This could result in the computer being able to restart, but the service may still be unable to run.</br>**critical** - Specifies that the error is logged (if possible). The computer attempts to restart with the last-known good configuration. If the last-known good configuration fails, startup also fails, and the boot process halts with a Stop error.</br>**ignore** - Specifies that the error is logged and startup continues. No notification is given to the user beyond recording the error in the event log.|
|binpath= \<BinaryPathName>|Specifies a path to the service binary file. There is no default for **binpath=**, and this string must be supplied.|
|group= \<LoadOrderGroup>|Specifies the name of the group of which this service is a member. The list of groups is stored in the registry in the **HKLM\System\CurrentControlSet\Control\ServiceGroupOrder** subkey. The default value is null.|
|tag= {yes \| no}|Specifies whether or not a TagID is to be obtained from the CreateService call. Tags are used only for boot-start and system-start drivers.|
|depend= \<dependencies>|Specifies the names of services or groups that must start before this service starts. The names are separated by forward slashes (/).|
|obj= {\<AccountName> \| \<ObjectName>}|Specifies the name of an account in which a service will run, or specifies a name of the Windows driver object in which the driver will run.|
|displayname= \<DisplayName>|Specifies a friendly name that can be used by user interface programs to identify the service.|
|password= \<Password>|Specifies a password. This is required if an account other than LocalSystem is used.|
|/?|Displays help at the command prompt.|

## Remarks

-   For each command-line option, the equal sign is part of the option name.
-   A space is required between an option and its value (for example, **type= own**. If the space is omitted the operation will fail.

## <a name="BKMK_examples"></a>Examples

The following examples show how you can use the **sc create** command:
```
sc \\myserver create NewService binpath= c:\windows\system32\NewServ.exe
sc create NewService binpath= c:\windows\system32\NewServ.exe type= share start= auto depend= "+TDI NetBIOS"
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)
