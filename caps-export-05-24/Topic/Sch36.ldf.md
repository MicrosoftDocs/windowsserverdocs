---
title: Sch36.ldf
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 5af04393-ab94-4c95-aba6-d887f72d8df6
author: Femila
---
# Sch36.ldf
  dn: CN\=ms\-DS\-Revealed\-List\-BL,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-RevealedListBL  
  
 adminDisplayName: ms\-DS\-Revealed\-List\-BL  
  
 adminDescription: back\-link attribute for ms\-DS\-Revealed\-List.  
  
 attributeId: 1.2.840.113556.1.4.1975  
  
 attributeSyntax: 2.5.5.1  
  
 omSyntax: 127  
  
 isSingleValued: FALSE  
  
 systemOnly: TRUE  
  
 searchFlags: 0  
  
 omObjectClass:: KwwCh3McAIVK  
  
 schemaIdGuid:: \/Ygcqvawn0Kyyp2QImboCA\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 20  
  
 dn: CN\=From\-Server,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: searchFlags  
  
 searchFlags: 1  
  
 \-  
  
 dn: CN\=msNPAllowDialin,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: searchFlags  
  
 searchFlags: 16  
  
 \-  
  
 dn: CN\=msNPCallingStationID,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: searchFlags  
  
 searchFlags: 16  
  
 \-  
  
 dn: CN\=msNPSavedCallingStationID,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: searchFlags  
  
 searchFlags: 16  
  
 \-  
  
 dn: CN\=msRADIUSCallbackNumber,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: searchFlags  
  
 searchFlags: 16  
  
 \-  
  
 dn: CN\=msRADIUSFramedIPAddress,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: searchFlags  
  
 searchFlags: 16  
  
 \-  
  
 dn: CN\=msRADIUSFramedRoute,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: searchFlags  
  
 searchFlags: 16  
  
 \-  
  
 dn: CN\=msRADIUSServiceType,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: searchFlags  
  
 searchFlags: 16  
  
 \-  
  
 dn: CN\=msRASSavedCallbackNumber,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: searchFlags  
  
 searchFlags: 16  
  
 \-  
  
 dn: CN\=msRASSavedFramedIPAddress,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: searchFlags  
  
 searchFlags: 16  
  
 \-  
  
 dn: CN\=msRASSavedFramedRoute,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: searchFlags  
  
 searchFlags: 16  
  
 \-  
  
 dn: CN\=ms\-RADIUS\-FramedInterfaceId,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: searchFlags  
  
 searchFlags: 16  
  
 \-  
  
 dn: CN\=ms\-RADIUS\-SavedFramedInterfaceId,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: searchFlags  
  
 searchFlags: 16  
  
 \-  
  
 dn: CN\=ms\-RADIUS\-FramedIpv6Prefix,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: searchFlags  
  
 searchFlags: 16  
  
 \-  
  
 dn: CN\=ms\-RADIUS\-SavedFramedIpv6Prefix,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: searchFlags  
  
 searchFlags: 16  
  
 \-  
  
 dn: CN\=ms\-RADIUS\-FramedIpv6Route,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: searchFlags  
  
 searchFlags: 16  
  
 \-  
  
 dn: CN\=ms\-RADIUS\-SavedFramedIpv6Route,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: searchFlags  
  
 searchFlags: 16  
  
 \-  
  
 dn: CN\=ms\-FVE\-RecoveryPassword,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: searchFlags  
  
 searchFlags: 136  
  
 \-  
  
 dn: CN\=ms\-FVE\-RecoveryGuid,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: searchFlags  
  
 searchFlags: 137  
  
 \-  
  
 dn: CN\=ms\-TPM\-OwnerInformation,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: searchFlags  
  
 searchFlags: 136  
  
 \-  
  
 dn: CN\=Top,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.1975  
  
 \-  
  
 dn:  
  
 changetype: ntdsSchemaModify  
  
 add: schemaUpdateNow  
  
 schemaUpdateNow: 1  
  
 \-  
  
 dn: cn\=Read\-Only\-Replication\-Secret\-Synchronization,CN\=Extended\-Rights,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: localizationDisplayId  
  
 localizationDisplayId: 72  
  
 \-  
  
 dn: cn\=Read\-Only\-Replication\-Secret\-Synchronization,CN\=Extended\-Rights,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: controlAccessRight  
  
 displayName: Read Only Replication Secret Synchronization  
  
 localizationDisplayId: 73  
  
 appliesTo: 19195a5b\-6da0\-11d0\-afd3\-00c04fd930c9  
  
 appliesTo: bf967a87\-0de6\-11d0\-a285\-00aa003049e2  
  
 appliesTo: bf967a8f\-0de6\-11d0\-a285\-00aa003049e2  
  
 rightsGUID: 1131f6ae\-9c07\-11d1\-f79f\-00c04fc2dcd2  
  
 validAccesses: 256  
  
 \# Increase object version  
  
 dn: CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: objectVersion  
  
 objectVersion: 36  
  
 \-  
  
  