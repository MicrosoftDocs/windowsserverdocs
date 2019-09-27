---
ms.assetid: e5f55f3e-8d2a-4526-8d67-36a539126c22
title: Fsutil tiering
ms.prod: windows-server
manager: dmoss
ms.author: toklima
author: toklima
ms.technology: storage
audience: "IT Pro"
ms.topic: article
ms.date: 10/16/2017
---
# Fsutil tiering
>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows 10

Enables management of storage tier functions, such as setting and disabling flags and listing of tiers.

## Syntax

```
fsutil tiering [clearflags] <volume> <flags>
fsutil tiering [queryflags] <volume>
fsutil tiering [regionlist] <volume>
fsutil tiering [setflags] <volume> <flags>
fsutil tiering [tierlist] <volume>
```

### Parameters

|Parameter|Description|
|-------------|---------------|
|clearflags|Disables the tiering behavior flags of a volume.|
|\<volume>|Specifies the volume.|
|/TrNH|For volumes with tiered storage, causes Heat gathering to be disabled.<br /><br>Applies to NTFS and ReFS only.|
|queryflags|Queries the tiering behavior flags of a volume.|
|regionlist|Lists the tiered regions of a volume and their respective storage tiers.|
|setflags|Enables the tiering behavior flags of a volume.|
|tierlist|Lists the storage tieres associated with a volume.|


### Examples

To query the flags on volume C, type:

```
fsutil tiering clearflags C:
```

To set the flags on volume C, type:

```
fsutil tiering setflags C: /TrNH
```

To clear the flags on volume C, type:

```
fsutil tiering clearflags C: /TrNH
```

To list the regions of volume C and their respective storage tiers, type:

```
fsutil tiering regionlist C:
```

To list the tiers of volume C, type:

```
fsutil tiering tierlist C:
```



### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)

[Fsutil](Fsutil.md)

