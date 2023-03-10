---
title: Sc.exe query
description: Reference article for the sc.exe query command, which obtains and displays information about the specified service, driver, type of service, or type of driver.
ms.topic: reference
ms.assetid: ac365f89-4b20-4de6-a582-b204c5e7d0eb
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# Sc.exe query

Obtains and displays information about the specified service, driver, type of service, or type of driver.

## Syntax

```
sc.exe [<servername>] query [<servicename>] [type= {driver | service | all}] [type= {own | share | interact | kernel | filesys | rec | adapt}] [state= {active | inactive | all}] [bufsize= <Buffersize>] [ri= <Resumeindex>] [group= <groupname>]
```

### Parameters

| Parameter | Description |
|--|--|
| `<servername>` | Specifies the name of the remote server on which the service is located. The name must use the Universal Naming Convention (UNC) format (for example, \\myserver). To run SC.exe locally, don't use this parameter. |
| `<servicename>` | Specifies the service name returned by the **getkeyname** operation. This **query** parameter isn't used in conjunction with other **query** parameters (other than *servername*). |
| `type= {driver | service | all}` | Specifies what to enumerate. The options include:<ul><li>**driver** - Specifies that only drivers are enumerated.</li><li>**service** - Specifies only services are enumerated. This is the default value.</li><li>**all** - Specifies that both drivers and services are enumerated.</li></ul> |
| `type= {own | share | interact | kernel | filesys | rec | adapt}` | Specifies the type of services or type of drivers to be enumerated. The options include:<ul><li>**own** - Specifies a service that runs in its own process. It doesn't share an executable file with other services. This is the default value.</li><li>**share** - Specifies a service that runs as a shared process. It shares an executable file with other services.</li><li>**kernel** - Specifies a driver.</li><li>**filesys** - Specifies a file system driver.</li><li>**rec** - Specifies a file system-recognized driver that identifies file systems used on the computer.</li><li>**interact** - Specifies a service that can interact with the desktop, receiving input from users. Interactive services must be run under the LocalSystem account. This type must be used in conjunction with **type= own** or **type= shared** (for example, **type= interact** **type= own**). Using **type= interact** by itself will generate an error.</li></ul> |
| `state= {active | inactive | all}` | Specifies the started state of the service to be enumerated. The options include:<ul><li>**active** - Specifies all active services. This is the default value.</li><li>**inactive** - Specifies all paused or stopped services.</li><li>**all** - Specifies all services.</li></ul> |
| `bufsize= <Buffersize>` | Specifies the size (in bytes) of the enumeration buffer. The default buffer size is 1,024 bytes. You should increase the size of the buffer when the display resulting from a query goes over 1,024 bytes. |
| `ri= <Resumeindex>` | Specifies the index number at which enumeration is to begin or resume. The default value is 0 (zero). If more information is returned than what the default buffer can display, use this parameter with the `bufsize=` parameter. |
| `group= <Groupname>` | Specifies the service group to be enumerated. By default, all groups are enumerated. By default, all groups are enumerated (**group= **). |
| /? | Displays help at the command prompt. |

#### Remarks

- Each command-line option (parameter) must include the equal sign as part of the option name.

- A space is required between an option and its value (for example, **type= own**. If the space is omitted, the operation fails.

- The **query** operation displays the following information about a service: SERVICE_NAME (service's registry subkey name), TYPE, STATE (as well as states which are not available), WIN32_EXIT_B, SERVICE_EXIT_B, CHECKPOINT, and WAIT_HINT.

- The **type=** parameter can be used twice in some cases. The first appearance of the **type=** parameter specifies whether to query services, drivers, or both (**all**). The second appearance of the **type=** parameter specifies a type from the **create** operation to further narrow a query's scope.

- When the display results from a **query** command exceed the size of the enumeration buffer, a message similar to the following is displayed:

  ```
  Enum: more data, need 1822 bytes start resume at index 79

  To display the remaining **query** information, rerun **query**, setting **bufsize=** to be the number of bytes and setting **ri=** to the specified index. For example, the remaining output would be displayed by typing the following at the command prompt:

  sc.exe query bufsize= 1822 ri= 79
  ```

## Examples

To display information for active services only, type either of the following commands:

```
sc.exe query
sc.exe query type= service
```

To display information for active services, and to specify a buffer size of 2,000 bytes, type:

```
sc.exe query type= all bufsize= 2000
```

To display information for the *wuauserv* service, type:

```
sc.exe query wuauserv
```

To display information for all services (active and inactive), type:

```
sc.exe query state= all
```

To display information for all services (active and inactive), beginning at line 56, type:

```
sc.exe query state= all ri= 56
```

To display information for interactive services, type:

```
sc.exe query type= service type= interact
```

To display information for drivers only, type:

```
sc.exe query type= driver
```

To display information for drivers in the *Network Driver Interface Specification (NDIS) group*, type:

```
sc.exe query type= driver group= NDIS
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
