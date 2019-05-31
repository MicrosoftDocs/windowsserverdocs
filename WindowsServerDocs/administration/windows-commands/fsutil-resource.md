---
ms.assetid: b198d8ca-a5b7-430f-8911-5cbb9f50484c
title: Fsutil resource
ms.prod: windows-server-threshold
manager: dmoss
ms.author: toklima
author: toklima
ms.technology: storage
audience: "IT Pro"
ms.topic: article
ms.date: 10/16/2017
---
# Fsutil resource
>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows 10, Windows Server 2012 R2, Windows 8.1, Windows Server 2012, Windows 8, Windows Server 2008 R2, Windows 7, Windows 2008, Windows Vista

Creates a Secondary Transactional Resource Manager, starts or stops a Transactional Resource Manager, or displays information about a Transactional Resource Manager and modifies the following behavior:

-   Whether a default Transactional Resource Manager will clean its transactional metadata at the next mount

-   The specified Transactional Resource Manager to prefer consistency over availability

-   The specified Transaction Resource Manager to prefer availability over consistency

-   The characteristics of a running Transactional Resource Manager

For examples of how to use this command, see [Examples](#BKMK_examples) .

## Syntax

```
fsutil resource [create] <RmRootPathname>
fsutil resource [info] <RmRootPathname>
fsutil resource [setautoreset] {true|false} <DefaultRmRootPathname>
fsutil resource [setavailable] <RmRootPathname>
fsutil resource [setconsistent] <RmRootPathname>
fsutil resource [setlog] [growth {<Containers> containers|<Percent> percent} <RmRootPathname>] [maxextents <Containers> <RmRootPathname>] [minextents <Containers> <RmRootPathname>] [mode {full|undo} <RmRootPathname>] [rename <RmRootPathname>] [shrink <percent> <RmRootPathname>] [size <Containers> <RmRootPathname>]
fsutil resource [start] <RmRootPathname> [<RmLogPathname> <TmLogPathname>
fsutil resource [stop] <RmRootPathname>
```

### Parameters

|        Parameter        |                                                                                                                                                                                                                                        Description                                                                                                                                                                                                                                         |
|-------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|         create          |                                                                                                                                                                                                                    Creates a secondary Transactional Resource Manager.                                                                                                                                                                                                                     |
|    <RmRootPathname>     |                                                                                                                                                                                                        Specifies the full path to a Transactional Resource Manager root directory.                                                                                                                                                                                                         |
|          info           |                                                                                                                                                                                                            Displays the specified Transactional Resource Manager’s information.                                                                                                                                                                                                            |
|      setautoreset       | Specifies whether a default Transactional Resource Manager will clean the transactional metadata on the next mount.<br /><br />-   Set the **setautoreset** parameter to **true** to specify that the Transaction Resource Manager will clean the transactional metadata on the next mount, by default.<br />-   Set the **setautoreset** parameter to **false** to specify that the Transaction Resource Manager will not clean the transactional metadata on the next mount, by default. |
| <DefaultRmRootPathname> |                                                                                                                                                                                                                       Specifies the drive name followed by a colon.                                                                                                                                                                                                                        |
|      setavailable       |                                                                                                                                                                                                 Specifies that a Transactional Resource Manager will prefer availability over consistency.                                                                                                                                                                                                 |
|      setconsistent      |                                                                                                                                                                                                 Specifies that a Transactional Resource Manager will prefer consistency over availability.                                                                                                                                                                                                 |
|         setlog          |                                                                                                                                                                                                  Changes the characteristics of a Transactional Resource Manager that is already running.                                                                                                                                                                                                  |
|         growth          |                                                                                                  Specifies the amount by which the Transactional Resource Manager log can grow.<br /><br />The growth parameter can be specified as follows:<br /><br />-   Number of containers using the format: *Containers***containers**<br />-   Percentage using the format: *Percent***percent**                                                                                                   |
|      <containers>       |                                                                                                                                                                                                      Specifies the data objects that are used by the Transactional Resource Manager.                                                                                                                                                                                                       |
|        maxextent        |                                                                                                                                                                                                Specifies the maximum number of containers for the specified Transactional Resource Manager.                                                                                                                                                                                                |
|        minextent        |                                                                                                                                                                                                Specifies the minimum number of containers for the specified Transactional Resource Manager.                                                                                                                                                                                                |
|  mode {full&#124;undo}  |                                                                                                                                                                                        Specifies whether all transactions are logged ( **full**) or only rolled back events are logged (**undo**).                                                                                                                                                                                         |
|         rename          |                                                                                                                                                                                                                  Changes the GUID for the Transactional Resource Manager.                                                                                                                                                                                                                  |
|         shrink          |                                                                                                                                                                                              Specifies percentage by which the Transactional Resource Manager log can automatically decrease.                                                                                                                                                                                              |
|          size           |                                                                                                                                                                                              Specifies the size of the Transactional Resource Manager as a specified number of *Containers*.                                                                                                                                                                                               |
|          start          |                                                                                                                                                                                                                    Starts the specified Transactional Resource Manager.                                                                                                                                                                                                                    |
|          stop           |                                                                                                                                                                                                                    Stops the specified Transactional Resource Manager.                                                                                                                                                                                                                     |

### <a name="BKMK_examples"></a>Examples
To set the log for the Transactional Resource Manager that is specified by c:\test, to have an automatic growth of five containers, type:

```
fsutil resource setlog growth 5 containers c:test
```

To set the log for the Transactional Resource Manager that is specified by c:\test, to have an automatic growth of two percent, type:

```
fsutil resource setlog growth 2 percent c:test
```

To specify that the default Transactional Resource Manager will clean the transactional metadata on the next mount on drive C, type:

```
fsutil resource setautoreset true c:\  
```

### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)

[Fsutil](Fsutil.md)

[Transactional NTFS](https://go.microsoft.com/fwlink/?LinkID=165402)


