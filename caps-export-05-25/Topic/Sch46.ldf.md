---
title: Sch46.ldf
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: f5dd2734-360b-450d-ad20-fccd96421531
author: Femila
---
# Sch46.ldf
    
```  
dn: CN=ms-DS-Managed-Service-Account,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
replace: defaultHidingValue  
defaultHidingValue: FALSE  
-  
  
DN:  
changetype: modify  
add: schemaUpdateNow  
schemaUpdateNow: 1  
-  
  
# Increase object version  
dn: CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
replace: objectVersion  
objectVersion: 46  
-  
  
```  
  
## See Also  
 [Windows Server 2008 R2: Schema Updates](../Topic/Windows-Server-2008-R2--Schema-Updates.md)  
  
  