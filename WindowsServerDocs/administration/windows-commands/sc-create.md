---
title: sc.exe create
description: Reference article for the sc.exe create command, which creates a subkey and entries for a service in the registry and in the Service Control Manager database.
ms.topic: reference
ms.assetid: 59416460-0661-4fef-85cc-73e9d8f4beb4
ms.author: alalve
author: JasonGerend
ms.date: 09/29/2023
---

# sc.exe create

Creates a subkey and entries for a service in the registry and in the Service Control Manager database.

## Syntax

```
sc.exe [<servername>] create [<servicename>] [type= {own | share | kernel | filesys | rec | interact type= {own | share}}] [start= {boot | system | auto | demand | disabled | delayed-auto}] [error= {normal | severe | critical | ignore}] [binpath= <binarypathname>] [group= <loadordergroup>] [tag= {yes | no}] [depend= <dependencies>] [obj= {<accountname> | <objectname>}] [displayname= <displayname>] [password= <password>]
```

### Parameters

|Parameter|Description|
|---------|-----------|
| `<servername>` | Specifies the name of the remote server on which the service is located. The name must use the Universal Naming Convention (UNC) format (for example, \\myserver). To run SC.exe locally, don't use this parameter. |
| `<servicename>` | Specifies the service name returned by the **getkeyname** operation. |
| `type= {own | share | kernel | filesys | rec | interact type= {own | share}}` | Specifies the service type. The options include:<ul><li>**own** - Specifies a service that runs in its own process. It doesn't share an executable file with other services. This is the default value.</li><li>**share** - Specifies a service that runs as a shared process. It shares an executable file with other services.</li><li>**kernel** - Specifies a driver.</li><li>**filesys** - Specifies a file system driver.</li><li>**rec** - Specifies a file system-recognized driver that identifies file systems used on the computer.</li><li>**interact** - Specifies a service that can interact with the desktop, receiving input from users. Interactive services must be run under the LocalSystem account. This type must be used in conjunction with **type= own** or **type= share** (for example, **type= interact** **type= own**). Using **type= interact** by itself will generate an error.</li></ul> |
| `start= {boot | system | auto | demand | disabled | delayed-auto}` | Specifies the start type for the service. The options include:<ul><li>**boot** - Specifies a device driver that is loaded by the boot loader.</li><li>**system** - Specifies a device driver that is started during kernel initialization.</li><li>**auto** - Specifies a service that automatically starts each time the computer is restarted and runs even if no one logs on to the computer.</li><li>**demand** - Specifies a service that must be started manually. This is the default value if **start=** is not specified.</li><li>**disabled** - Specifies a service that cannot be started. To start a disabled service, change the start type to some other value.</li><li>**delayed-auto** - Specifies a service that starts automatically a short time after other auto services are started.</li></ul> |
| `error= {normal | severe | critical | ignore}` | Specifies the severity of the error if the service fails to start when the computer is started. The options include:<ul><li>**normal** - Specifies that the error is logged and a message box is displayed, informing the user that a service has failed to start. Startup will continue. This is the default setting.</li><li>**severe** - Specifies that the error is logged (if possible). The computer attempts to restart with the last-known good configuration. This could result in the computer being able to restart, but the service may still be unable to run.</li><li>**critical** - Specifies that the error is logged (if possible). The computer attempts to restart with the last-known good configuration. If the last-known good configuration fails, startup also fails, and the boot process halts with a Stop error.</li><li>**ignore** - Specifies that the error is logged and startup continues. No notification is given to the user beyond recording the error in the Event Log.</li></ul> |
| `binpath= <binarypathname>` | Specifies a path to the service binary file. There is no default for **binpath=**, and this string must be supplied. |
| `group= <loadordergroup>` | Specifies the name of the group of which this service is a member. The list of groups is stored in the registry, in the **HKLM\System\CurrentControlSet\Control\ServiceGroupOrder** subkey. The default value is null. |
| `tag= {yes | no}` | Specifies whether or not to obtain a TagID from the CreateService call. Tags are used only for boot-start and system-start drivers. |
| `depend= <dependencies>` | Specifies the names of services or groups that must start before this service. The names are separated by forward slashes (/). |
| `obj= {<accountname> | <objectname>}` | Specifies a name of an account in which a service will run, or specifies a name of the Windows driver object in which the driver will run. The default setting is **LocalSystem**. |
| `displayname= <displayname>` | Specifies a friendly name for identifying the service in user interface programs. For example, the subkey name of one particular service is **wuauserv**, which has a more friendly display name of Automatic Updates. |
| `password= <password>` | Specifies a password. This is required if an account other than the LocalSystem account is used. |
| /? | Displays help at the command prompt. |

#### Remarks

- Each command-line option (parameter) must include the equal sign as part of the option name.

- A space is required between an option and its value (for example, **type= own**. If the space is omitted, the operation fails.

## Examples

To create and register a new binary path for the *NewService* service, type:

```
sc.exe \\myserver create NewService binpath= c:\windows\system32\NewServ.exe
```

```
sc.exe create NewService binpath= c:\windows\system32\NewServ.exe type= share start= auto depend= +TDI NetBIOS
```

To learn more about the `sc.exe` command, see [SC commands](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc754599(v=ws.11)).

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
