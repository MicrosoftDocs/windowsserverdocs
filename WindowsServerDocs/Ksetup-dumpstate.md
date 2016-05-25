---
title: Ksetup:dumpstate
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3ef2f7b8-97af-4f42-9542-cff324840637
---
# Ksetup:dumpstate
Displays the current state of realm settings for all realms that are defined on the computer. For examples of how this command can be used, see [Examples](#BKMK_Examples).  
  
## Syntax  
  
```  
ksetup /dumpstate  
```  
  
### Parameters  
None  
  
## Remarks  
The output of this command includes the default realm \(the domain that the computer is a member of\) and all the realms that are defined on this computer. The following is included for each realm:  
  
-   All the Key Distribution Centers \(KDCs\) that are associated with this realm  
  
-   All the **set realm** flags for this realm  
  
-   The KDC password  
  
This command does not display the domain name that is specified by DNS detection or by the command **ksetup \/domain**.  
  
This command does not display the computer password that is set by using the command **ksetup \/setcomputerpassword**.  
  
**Ksetup** produces the same output as **ksetup \/dumpstate**.  
  
## <a name="BKMK_Examples"></a>Examples  
Find most of the Kerberos realm configurations on a computer:  
  
```  
ksetup /dumpstate  
```  
  
## Additional references  
  
-   [Ksetup](Ksetup.md)  
  
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  

