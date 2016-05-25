---
title: Sch35.ldf
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 3c701437-ed34-4cd8-93c0-71e1ecf85275
author: Femila
---
# Sch35.ldf
  dn: CN\=ms\-DS\-Last\-Successful\-Interactive\-Logon\-Time,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-LastSuccessfulInteractiveLogonTime  
  
 adminDisplayName: msDS\-LastSuccessfulInteractiveLogonTime  
  
 adminDescription: The time that the correct password was presented during a C\-A\-D logon.  
  
 attributeId: 1.2.840.113556.1.4.1970  
  
 attributeSyntax: 2.5.5.16  
  
 omSyntax: 65  
  
 isSingleValued: TRUE  
  
 systemOnly: TRUE  
  
 searchFlags: 0  
  
 schemaIdGuid:: 5ikZAV2LWEK2SgCwtJSXRw\=\=  
  
 attributeSecurityGuid:: hri1d0qU0RGuvQAA\+ANnwQ\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DS\-Failed\-Interactive\-Logon\-Count\-At\-Last\-Successful\-Logon,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-FailedInteractiveLogonCountAtLastSuccessfulLogon  
  
 adminDisplayName: ms\-DS\-Failed\-Interactive\-Logon\-Count\-At\-Last\-Successful\-Logon  
  
 adminDescription: The total number of failed interactive logons up until the last successful C\-A\-D logon.  
  
 attributeId: 1.2.840.113556.1.4.1973  
  
 attributeSyntax: 2.5.5.9  
  
 omSyntax: 2  
  
 isSingleValued: TRUE  
  
 systemOnly: TRUE  
  
 searchFlags: 0  
  
 schemaIdGuid:: 5TTSxUpkA0SmZeJuCu9emA\=\=  
  
 attributeSecurityGuid:: hri1d0qU0RGuvQAA\+ANnwQ\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DS\-Failed\-Interactive\-Logon\-Count,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-FailedInteractiveLogonCount  
  
 adminDisplayName: msDS\-FailedInteractiveLogonCount  
  
 adminDescription: The total number of failed interactive logons since this feature was turned on.  
  
 attributeId: 1.2.840.113556.1.4.1972  
  
 attributeSyntax: 2.5.5.9  
  
 omSyntax: 2  
  
 isSingleValued: TRUE  
  
 systemOnly: TRUE  
  
 searchFlags: 0  
  
 schemaIdGuid:: b6g83K1wYEmEJaTWMT2T3Q\=\=  
  
 attributeSecurityGuid:: hri1d0qU0RGuvQAA\+ANnwQ\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DS\-Last\-Failed\-Interactive\-Logon\-Time,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-LastFailedInteractiveLogonTime  
  
 adminDisplayName: msDS\-LastFailedInteractiveLogonTime  
  
 adminDescription: The time that an incorrect password was presented during a C\-A\-D logon.  
  
 attributeId: 1.2.840.113556.1.4.1971  
  
 attributeSyntax: 2.5.5.16  
  
 omSyntax: 65  
  
 isSingleValued: TRUE  
  
 systemOnly: TRUE  
  
 searchFlags: 0  
  
 schemaIdGuid:: \+trnx8MQi0uazVTxEGN0Lg\=\=  
  
 attributeSecurityGuid:: hri1d0qU0RGuvQAA\+ANnwQ\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=User,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.1970  
  
 systemMayContain: 1.2.840.113556.1.4.1971  
  
 systemMayContain: 1.2.840.113556.1.4.1972  
  
 systemMayContain: 1.2.840.113556.1.4.1973  
  
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
  
 objectVersion: 35  
  
 \-  
  
  