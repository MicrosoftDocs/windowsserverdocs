---
title: Sch47.ldf
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 3d34a102-dfe0-4050-8c4d-0842ba9a5708
author: Femila
---
# Sch47.ldf
    
```  
dn: CN=NTDS-DSA,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2061  
-  
  
dn: CN=ms-DS-Managed-Service-Account,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
delete: systemPossSuperiors  
systemPossSuperiors: 1.2.840.113556.1.3.30  
-  
dn:  
changetype: modify  
add: schemaUpdateNow  
schemaUpdateNow: 1  
-  
#increase object version  
dn: CN=Schema,CN=Configuration,DC=X  
changeType: ntdsSchemaModify  
replace: objectVersion  
objectVersion: 47  
-  
  
```  
  
## See Also  
 [Windows Server 2008 R2: Schema Updates](../Topic/Windows-Server-2008-R2--Schema-Updates.md)  
  
  