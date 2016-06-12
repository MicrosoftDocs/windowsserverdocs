---
title: Fsutil resource
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b257de4d-17ae-4fca-a75c-24b4adea2281
---
# Fsutil resource
creates a Secondary Transactional Resource manager, starts or stops a Transactional Resource manager, or displays information about a Transactional Resource manager and modifies the following behavior:

-   Whether a default Transactional Resource manager will clean its transactional metadata at the next mount

-   The specified Transactional Resource manager to prefer consistency over availability

-   The specified Transaction Resource manager to prefer availability over consistency

-   The characteristics of a running Transactional Resource manager

for examples of how to use this command, see [Examples](#BKMK_examples) .

## Syntax

```
fsutil resource [create] <RmRootpathname>
fsutil resource [info] <RmRootpathname>
fsutil resource [setautoreset] {true|false} <DefaultRmRootpathname>
fsutil resource [setavailable] <RmRootpathname>
fsutil resource [setconsistent] <RmRootpathname>
fsutil resource [setlog] [growth {<Containers> containers|<Percent> percent} <RmRootpathname>] [maxextents <Containers> <RmRootpathname>] [minextents <Containers> <RmRootpathname>] [mode {full|undo} <RmRootpathname>] [rename <RmRootpathname>] [shrink <percent> <RmRootpathname>] [size <Containers> <RmRootpathname>]
fsutil resource [start] <RmRootpathname> [<RmLogpathname> <TmLogpathname>
fsutil resource [stop] <RmRootpathname>

```

### Parameters

|Parameter|Description|
|-------------|---------------|
|create|creates a secondary Transactional Resource manager.|
|<RmRootpathname>|Specifies the full path to a Transactional Resource manager root directory.|
|info|Displays the specified Transactional Resource manager’s information.|
|setautoreset|Specifies whether a default Transactional Resource manager will clean the transactional metadata on the next mount.<br /><br />-   Set the **setautoreset** parameter to **true** to specify that the Transaction Resource manager will clean the transactional metadata on the next mount, by default.<br />-   Set the **setautoreset** parameter to **false** to specify that the Transaction Resource manager will not clean the transactional metadata on the next mount, by default.|
|<DefaultRmRootpathname>|Specifies the drive name followed by a colon.|
|setavailable|Specifies that a Transactional Resource manager will prefer availability over consistency.|
|setconsistent|Specifies that a Transactional Resource manager will prefer consistency over availability.|
|setlog|changes the characteristics of a Transactional Resource manager that is already running.|
|growth|Specifies the amount by which the Transactional Resource manager log can grow.<br /><br />The growth parameter can be specified as follows:<br /><br />-   Number of containers using the format: *Containers***containers**<br />-   Percentage using the format: *Percent***percent**|
|<containers>|Specifies the data objects that are used by the Transactional Resource manager.|
|maxextent|Specifies the maximum number of containers for the specified Transactional Resource manager.|
|minextent|Specifies the minimum number of containers for the specified Transactional Resource manager.|
|mode {full&#124;undo}|Specifies whether all transactions are logged \( **full**\) or only rolled back events are logged \(**undo**\).|
|rename|changes the GUID for the Transactional Resource manager.|
|shrink|Specifies percentage by which the Transactional Resource manager log can automatically decrease.|
|size|Specifies the size of the Transactional Resource manager as a specified number of *Containers*.|
|start|starts the specified Transactional Resource manager.|
|stop|Stops the specified Transactional Resource manager.|

### <a name="BKMK_examples"></a>Examples
To set the log for the Transactional Resource manager that is specified by c:\\test, to have an automatic growth of five containers, type:

```
fsutil resource setlog growth 5 containers c:test
```

To set the log for the Transactional Resource manager that is specified by c:\\test, to have an automatic growth of two percent, type:

```
fsutil resource setlog growth 2 percent c:test
```

To specify that the default Transactional Resource manager will clean the transactional metadata on the next mount on drive C, type:

```
fsutil resource setautoreset true c:\  
```

### additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)

[Fsutil]()

[Transactional NTFS](http://go.microsoft.com/fwlink/?LinkID=165402)


