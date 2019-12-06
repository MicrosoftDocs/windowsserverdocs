---
title: Sc query
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ac365f89-4b20-4de6-a582-b204c5e7d0eb
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# Sc query



Obtains and displays information about the specified service, driver, type of service, or type of driver.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
sc [<ServerName>] query [<ServiceName>] [type= {driver | service | all}] [type= {own | share | interact | kernel | filesys | rec | adapt}] [state= {active | inactive | all}] [bufsize= <BufferSize>] [ri= <ResumeIndex>] [group= <GroupName>]
```

## Parameters

|       Parameter        |                                                                                                                          Description                                                                                                                          |
|------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|     \<ServerName>      |                       Specifies the name of the remote server on which the service is located. The name must use the Universal Naming Convention (UNC) format (for example, \\\\myserver). To run SC.exe locally, omit this parameter.                        |
|     \<ServiceName>     |                                      Specifies the service name returned by the **getkeyname** operation. This **query** parameter is not used in conjunction with other **query** parameters (other than *ServerName*).                                      |
|     type= {driver      |                                                                                                                            service                                                                                                                            |
|       type= {own       |                                                                                                                             share                                                                                                                             |
|     state= {active     |                                                                                                                           inactive                                                                                                                            |
| bufsize= \<BufferSize> |                     Specifies the size (in bytes) of the enumeration buffer. The default buffer size is 1,024 bytes. You should increase the size of the enumeration buffer when the display resulting from a query exceeds 1,024 bytes.                      |
|   ri= \<ResumeIndex>   | Specifies the index number at which enumeration is to begin or resume. The default value is **0** (zero). Use this parameter in conjunction with the **bufsize=** parameter when more information is returned by a query than the default buffer can display. |
|  group= \<GroupName>   |                                                                             Specifies the service group to be enumerated. By default, all groups are enumerated (**group= ""**).                                                                              |
|           /?           |                                                                                                             Displays help at the command prompt.                                                                                                              |

## Remarks

- Without a space between a parameter and its value (that is, **type= own**, not **type=own**), the operation will fail.
- The **query** operation displays the following information about a service: SERVICE_NAME (service's registry subkey name), TYPE, STATE (as well as states which are not available), WIN32_EXIT_B, SERVICE_EXIT_B, CHECKPOINT, and WAIT_HINT.
- The **type=** parameter can be used twice in some cases. The first appearance of the **type=** parameter specifies whether to query services, drivers, or both (**all**). The second appearance of the **type=** parameter specifies a type from the **create** operation to further narrow a query's scope.
- When the display resulting from a **query** command exceeds the size of the enumeration buffer, a message similar to the following is displayed:  
  ```
  Enum: more data, need 1822 bytes start resume at index 79
  ```  
  To display the remaining **query** information, rerun **query**, setting **bufsize=** to be the number of bytes and setting **ri=** to the specified index. For example, the remaining output would be displayed by typing the following at the command prompt:  
  ```
  sc query bufsize= 1822 ri= 79
  ```

## <a name="BKMK_examples"></a>Examples

To display information for active services only, type either of the following commands:
```
sc query
sc query type= service
```
To display information for active services, and to specify a buffer size of 2,000 bytes, type:
```
sc query type= all bufsize= 2000
```
To display information for the WUAUSERV service, type:
```
sc query wuauserv
```
To display information for all services (active and inactive), type:
```
sc query state= all
```
To display information for all services (active and inactive), beginning at line 56, type:
```
sc query state= all ri= 56
```
To display information for interactive services, type:
```
sc query type= service type= interact
```
To display information for drivers only, type:
```
sc query type= driver
```
To display information for drivers in the Network Driver Interface Specification (NDIS) group, type:
```
sc query type= driver group= ndis
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)