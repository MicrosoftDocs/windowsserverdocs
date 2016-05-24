---
title: Sch38.ldf
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 4ea5c3b6-f0c6-4b81-9715-b4ab335eead3
author: Femila
---
# Sch38.ldf
  dn: CN\=ms\-DS\-AuthenticatedAt\-DC,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: systemOnly  
  
 systemOnly: FALSE  
  
 \-  
  
 dn:  
  
 changetype: ntdsSchemaModify  
  
 add: schemaUpdateNow  
  
 schemaUpdateNow: 1  
  
 \-  
  
 \# Increase object version  
  
 dn: CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: objectVersion  
  
 objectVersion: 38  
  
 \-  
  
  