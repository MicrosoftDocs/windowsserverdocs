---
title: unexpose
description: Reference article for unexpose, which unexposes a shadow copy that was exposed by using the expose command.
ms.topic: reference
ms.assetid: 58dc7d0f-52e9-4587-9487-d3b4c3e52640
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# unexpose

Unexposes a shadow copy that was exposed by using the **expose** command. The exposed shadow copy can be specified by its Shadow ID, drive letter, share, or mount point.



## Syntax

```
unexpose {<ShadowID> | <Drive:> | <Share> | <MountPoint>}
```

### Parameters

|Parameter|Description|
|---------|-----------|
|\<ShadowID>|Unexposes the shadow copy specified by the given Shadow ID.|
|\<Drive:>|Unexposes the shadow copy associated with the specified drive letter (for example, drive P).|
|\<Share>|Unexposes the shadow copy associated with the specified share (for example, \\\\*MachineName*\).|
|\<MountPoint>|Unexposes the shadow copy associated with the specified mount point (for example, C:\shadowcopy\).|

## Remarks

-   You can use an existing alias or an environment variable in place of *ShadowID*. Use **add** without parameters to see existing aliases.

## Examples

To unexpose the shadow copy associated with Drive P, type:
```
unexpose P:
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)