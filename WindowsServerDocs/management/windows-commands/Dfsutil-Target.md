---
title: Dfsutil Target
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a6ea5067-213e-4433-9932-9a5b7c30dfa6
robots: noindex,nofollow
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Dfsutil Target

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

The **dfsutil target** command displays information about the folder target \(link target\) or namespace server \(root target\). Target commands are used to add, remove or modify the properties of a folder target or namespace server.



## Syntax

```
dfsutil target [<DfsPath>] \\server\sharepath | Add | Remove | /?
```

### Parameters

|Parameter|Description|
|-------------|---------------|
|<DfsPath>|UNC path of DFS link.|
|<\\\\server\\sharepath>|UNC path to the share on the Target Server.|
|Dfsutil Target Add|Adds a new folder target.|
|Dfsutil Target Remove|Removes the folder target.|
|\/?||

## Remarks
To view properties of root target do not specify <DfsPath>.

## Scripting <optional section>
<Here is where you discuss using the command within a script. You should also provide an FWLink to the Script Center.>

## <a name="BKMK_Examples"></a>Examples
To TBD, type:

```
dfsutil target \\contoso.com\Namespace1\Link1 \\MyTargetServer\LinkTarget
```

To TBD, type:

```
dfsutil target \\MyTargetServer\RootTarget
```

To view help for this command, type:

```
dfsutil target /?
```

## Additional references

-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)

-   [Dfsutil](Dfsutil.md)


