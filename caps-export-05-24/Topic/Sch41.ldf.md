---
title: Sch41.ldf
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 777c860b-afa6-4067-a09a-9e9f7fc7185a
author: Femila
---
# Sch41.ldf
  dn: CN\=NTDS\-DSA,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.1959  
  
 \-  
  
 dn: CN\=NTDS\-DSA,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.1960  
  
 \-  
  
 dn: CN\=NTDS\-DSA,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.1961  
  
 \-  
  
 dn: CN\=ms\-DS\-PSO\-Applied,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: searchFlags  
  
 searchFlags: 0  
  
 \-  
  
 dn: CN\=ms\-DS\-Resultant\-PSO,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: searchFlags  
  
 searchFlags: 0  
  
 \-  
  
 dn:  
  
 changetype: ntdsSchemaModify  
  
 add: schemaUpdateNow  
  
 schemaUpdateNow: 1  
  
 \-  
  
 dn: CN\=MS\-TS\-GatewayAccess,CN\=Extended\-Rights,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: rightsGuid  
  
 rightsGuid: ffa6f046\-ca4b\-4feb\-b40d\-04dfee722543  
  
 \-  
  
 dn: CN\=Terminal\-Server\-License\-Server,CN\=Extended\-Rights,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: rightsGuid  
  
 rightsGuid: 5805bc62\-bdc9\-4428\-a5e2\-856a0f4c185e  
  
 \-  
  
 delete: appliesTo  
  
 appliesTo: 5805bc62\-bdc9\-4428\-a5e2\-856a0f4c185e  
  
 \-  
  
 \# Increase object version  
  
 dn: CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: objectVersion  
  
 objectVersion: 41  
  
 \-  
  
  