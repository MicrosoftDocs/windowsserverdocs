---
title: Sch44.ldf
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: dda8bd88-254c-4251-b529-6b0e9a73f0b2
author: Femila
---
# Sch44.ldf
  dn: CN\=TOP,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.1968  
  
 \-  
  
 dn: CN\=MS\-TS\-ExpireDate,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: showInAdvancedViewOnly  
  
 showInAdvancedViewOnly: TRUE  
  
 \-  
  
 dn: CN\=ms\-PKI\-DPAPIMasterKeys,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: searchFlags  
  
 searchFlags: 640  
  
 \-  
  
 dn: CN\=ms\-PKI\-AccountCredentials,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: searchFlags  
  
 searchFlags: 640  
  
 \-  
  
 dn: CN\=ms\-PKI\-RoamingTimeStamp,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: searchFlags  
  
 searchFlags: 640  
  
 \-  
  
 dn: CN\=Global\-Address\-List2,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: adminDescription  
  
 adminDescription: This attribute is used on a Microsoft Exchange container to store the distinguished name of a newly created global address list \(GAL\). This attribute must have an entry before you can enable Messaging Application Programming Interface \(MAPI\) clients to use a GAL.  
  
 \-  
  
 dn: CN\=Global\-Address\-List2,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: isSingleValued  
  
 isSingleValued: FALSE  
  
 \-  
  
 dn: CN\=ms\-DS\-BridgeHead\-Servers\-Used,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 adminDescription: List of bridge head servers used by KCC in the previous run.  
  
 adminDisplayName: ms\-DS\-BridgeHead\-Servers\-Used  
  
 attributeID: 1.2.840.113556.1.4.2049  
  
 attributeSyntax: 2.5.5.7  
  
 cn: ms\-DS\-BridgeHead\-Servers\-Used  
  
 instanceType: 4  
  
 isSingleValued: FALSE  
  
 lDAPDisplayName: msDS\-BridgeHeadServersUsed  
  
 linkID: 2160  
  
 objectCategory: CN\=Attribute\-Schema,CN\=Schema,CN\=Configuration,DC\=X  
  
 objectClass: attributeSchema  
  
 oMObjectClass:: KoZIhvcUAQEBCw\=\=  
  
 oMSyntax: 127  
  
 schemaFlagsEx: 1  
  
 schemaIDGUID:: ZRTtPHF7QSWHgB4epiQ6gg\=\=  
  
 searchFlags: 0  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 25  
  
 DN:  
  
 changetype: modify  
  
 add: schemaUpdateNow  
  
 schemaUpdateNow: 1  
  
 \-  
  
 dn: CN\=Site,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.2049  
  
 \-  
  
 \# Increase object version  
  
 dn: CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: objectVersion  
  
 objectVersion: 44  
  
 \-  
  
  