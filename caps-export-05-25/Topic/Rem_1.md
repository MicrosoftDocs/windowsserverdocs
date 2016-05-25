---
title: Rem_1
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7245aedb-ba6f-49bb-9f77-848c4853c68f
author: JasonGerend
---
# Rem_1
Provides a way to add comments to a script.  
  
## Syntax  
  
```  
rem  
```  
  
## <a name="BKMK_examples"></a>Examples  
In this example script, **rem** is used to provide a comment about what the script does:  
  
```  
rem The commands in this script set up 3 drives.  
rem The first drive is a primary partition and is  
rem assigned the letter D. The second and third drives  
rem are logical partitions, and are assigned letters  
rem E and F.  
create partition primary size=2048  
assign d:  
create partition extended  
create partition logical size=2048  
assign e:  
create partition logical  
assign f:  
```  
  
#### Additional references  
[Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
[Diskpart \[LH\]](assetId:///26a4a166-95fa-4faf-95bc-2d5345f4a57a)  
  
