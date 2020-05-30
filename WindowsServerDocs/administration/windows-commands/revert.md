---
title: revert
description: Reference topic for **** - 

ms.prod: windows-server


ms.technology: manage-windows-commands

ms.topic: article
ms.assetid: 75ad40e4-502a-401e-b11e-8b31e00424b5
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# revert



Reverts a volume back to a specified shadow copy. This is supported only for shadow copies in the CLIENTACCESSIBLE context. These shadow copies are persistent and can only be made by the system provider. If used without parameters, **revert** displays help at the command prompt.

## Syntax

```
revert <ShadowCopyID>
```

### Parameters

|Parameter|Description|
|---------|-----------|
|\<ShadowCopyID>|Specifies the shadow copy ID to revert the volume to.|

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)