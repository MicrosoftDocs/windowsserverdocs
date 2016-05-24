---
title: Sch33.ldf
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 42ad3ba9-7c65-4c17-8556-01dab8a2843b
author: Femila
---
# Sch33.ldf
  dn: CN\=ms\-DS\-isGC,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-isGC  
  
 adminDisplayName: ms\-DS\-isGC  
  
 adminDescription: For a Directory instance \(DSA\), Identifies the state of the Global Catalog on the DSA  
  
 attributeId: 1.2.840.113556.1.4.1959  
  
 attributeSyntax: 2.5.5.8  
  
 omSyntax: 1  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 schemaIdGuid:: M8\/1HeUPnkmQ4elLQnGKRg\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 20  
  
 dn: CN\=ms\-DS\-isRODC,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-isRODC  
  
 adminDisplayName: ms\-DS\-isRODC  
  
 adminDescription: For a Directory instance \(DSA\), Identifies whether the DSA is a Read\-Only DSA  
  
 attributeId: 1.2.840.113556.1.4.1960  
  
 attributeSyntax: 2.5.5.8  
  
 omSyntax: 1  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 schemaIdGuid:: I6roqGc\+8Uqdei8aHWM6yQ\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 20  
  
 dn: CN\=ms\-DS\-SiteName,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-SiteName  
  
 adminDisplayName: ms\-DS\-SiteName  
  
 adminDescription: For a Directory instance \(DSA\), Identifies the site name that contains the DSA  
  
 attributeId: 1.2.840.113556.1.4.1961  
  
 attributeSyntax: 2.5.5.12  
  
 omSyntax: 64  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 schemaIdGuid:: bfOnmJU1ikSeb2uJZbrtnA\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 20  
  
 dn: CN\=ms\-DS\-AuthenticatedAt\-DC,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-AuthenticatedAtDC  
  
 adminDisplayName: ms\-DS\-AuthenticatedAt\-DC  
  
 adminDescription: Forwardlink for ms\-DS\-AuthenticatedTo\-Accountlist; for a User, identifies which DC a user has authenticated to  
  
 attributeId: 1.2.840.113556.1.4.1958  
  
 attributeSyntax: 2.5.5.1  
  
 omSyntax: 127  
  
 isSingleValued: FALSE  
  
 systemOnly: TRUE  
  
 searchFlags: 0  
  
 omObjectClass:: KwwCh3McAIVK  
  
 schemaIdGuid:: nOkePgRmiUSJ2YR5iolRWg\=\=  
  
 linkID: 2112  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DS\-Promotion\-Settings,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-PromotionSettings  
  
 adminDisplayName: ms\-DS\-Promotion\-Settings  
  
 adminDescription: For a Computer, contains a XML string to be used for delegated DSA promotion  
  
 attributeId: 1.2.840.113556.1.4.1962  
  
 attributeSyntax: 2.5.5.12  
  
 omSyntax: 64  
  
 isSingleValued: TRUE  
  
 systemOnly: TRUE  
  
 searchFlags: 0  
  
 rangeUpper: 65536  
  
 schemaIdGuid:: 4rSByMBDvk65u1JQqptDTA\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DS\-Supported\-Encryption\-Types,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-SupportedEncryptionTypes  
  
 adminDisplayName: msDS\-SupportedEncryptionTypes  
  
 adminDescription: The encryption algorithms supported by user, computer or trust accounts. The KDC uses this information while generating a service ticket for this account. Services\/Computers may automatically update this attribute on their respective accounts in Active Directory, and therefore need write access to this attribute.  
  
 attributeId: 1.2.840.113556.1.4.1963  
  
 attributeSyntax: 2.5.5.9  
  
 omSyntax: 2  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 schemaIdGuid:: Z5gRIAQdt0qTcc\/D1d8K\/Q\=\=  
  
 attributeSecurityGuid:: hri1d0qU0RGuvQAA\+ANnwQ\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DS\-AuthenticatedTo\-Accountlist,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-AuthenticatedToAccountlist  
  
 adminDisplayName: ms\-DS\-AuthenticatedTo\-Accountlist  
  
 adminDescription: Backlink for ms\-DS\-AuthenticatedAt\-DC; for a Computer, identifies which users have authenticated to this Computer  
  
 attributeId: 1.2.840.113556.1.4.1957  
  
 attributeSyntax: 2.5.5.1  
  
 omSyntax: 127  
  
 isSingleValued: FALSE  
  
 systemOnly: TRUE  
  
 searchFlags: 0  
  
 omObjectClass:: KwwCh3McAIVK  
  
 schemaIdGuid:: ccmy6N\+mvEeNb2J3DVJ6pQ\=\=  
  
 linkID: 2113  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 17  
  
 dn: CN\=ms\-DS\-Never\-Reveal\-Group,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: isSingleValued  
  
 isSingleValued: FALSE  
  
 \-  
  
 dn: CN\=ms\-DS\-Reveal\-OnDemand\-Group,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: isSingleValued  
  
 isSingleValued: FALSE  
  
 \-  
  
 dn: CN\=Top,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.1957  
  
 \-  
  
 dn: CN\=User,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.1963  
  
 \-  
  
 dn: CN\=Server,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.1959  
  
 systemMayContain: 1.2.840.113556.1.4.1960  
  
 systemMayContain: 1.2.840.113556.1.4.1961  
  
 \-  
  
 dn: CN\=Computer,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.1783  
  
 systemMayContain: 1.2.840.113556.1.4.1924  
  
 systemMayContain: 1.2.840.113556.1.4.1940  
  
 systemMayContain: 1.2.840.113556.1.4.1958  
  
 systemMayContain: 1.2.840.113556.1.4.1959  
  
 systemMayContain: 1.2.840.113556.1.4.1960  
  
 systemMayContain: 1.2.840.113556.1.4.1961  
  
 systemMayContain: 1.2.840.113556.1.4.1962  
  
 systemMayContain: 1.2.840.113556.1.4.1926  
  
 systemMayContain: 1.2.840.113556.1.4.1928  
  
 \-  
  
 dn: CN\=Trusted\-Domain,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.1963  
  
 \-  
  
 dn: CN\=NTDS\-DSA,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.1959  
  
 systemMayContain: 1.2.840.113556.1.4.1960  
  
 systemMayContain: 1.2.840.113556.1.4.1961  
  
 \-  
  
 delete: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.1927  
  
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
  
 objectVersion: 33  
  
 \-  
  
  