---
title: Revert
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 75ad40e4-502a-401e-b11e-8b31e00424b5
---
# Revert
Reverts a volume back to a specified shadow copy. This is supported only for shadow copies in the CLIENTACCESSIBLE context. These shadow copies are persistent and can only be made by the system provider. If used without parameters, **revert** displays help at the command prompt.

## Syntax

```
revert <ShadowCopyID>
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|<ShadowCopyID>|Specifies the shadow copy ID to revert the volume to.|

#### Additional references
[Command-Line Syntax Key](../Command-Line-Syntax-Key.md)


