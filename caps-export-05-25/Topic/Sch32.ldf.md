---
title: Sch32.ldf
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: f865bf62-53a3-40fb-ae32-e921415d10b5
author: Femila
---
# Sch32.ldf
  dn: CN\=ms\-DS\-KrbTgt\-Link,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-KrbTgtLink  
  
 adminDisplayName: ms\-DS\-KrbTgt\-Link  
  
 adminDescription: For a computer, identifies the user object \(krbtgt\), which is acting as the domain or secondary domain master secret. Depends on which domain or secondary domain the computer resides in.  
  
 attributeId: 1.2.840.113556.1.4.1923  
  
 attributeSyntax: 2.5.5.1  
  
 omSyntax: 127  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 omObjectClass:: KwwCh3McAIVK  
  
 schemaIdGuid:: yfWPd05vdEuFataDgzE5EA\=\=  
  
 linkID: 2100  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DS\-Revealed\-Users,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-RevealedUsers  
  
 adminDisplayName: ms\-DS\-Revealed\-Users  
  
 adminDescription: For a Directory instance \(DSA\), Identifies the user objects whose secrets have been disclosed to that instance  
  
 attributeId: 1.2.840.113556.1.4.1924  
  
 attributeSyntax: 2.5.5.7  
  
 omSyntax: 127  
  
 isSingleValued: FALSE  
  
 systemOnly: TRUE  
  
 searchFlags: 0  
  
 omObjectClass:: KoZIhvcUAQEBCw\=\=  
  
 schemaIdGuid:: IXhcGEk3OkS9aiiImQca2w\=\=  
  
 linkID: 2102  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DS\-Revealed\-List,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-RevealedList  
  
 adminDisplayName: ms\-DS\-Revealed\-List  
  
 adminDescription: For a Directory instance \(DSA\), Identifies the user objects whose secrets have been disclosed to that instance  
  
 attributeId: 1.2.840.113556.1.4.1940  
  
 attributeSyntax: 2.5.5.14  
  
 omSyntax: 127  
  
 isSingleValued: FALSE  
  
 systemOnly: TRUE  
  
 searchFlags: 0  
  
 omObjectClass:: KoZIhvcUAQEBDA\=\=  
  
 schemaIdGuid:: HNHay\+x\/ezhiGToGJ9mvgQ\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 20  
  
 dn: CN\=ms\-DS\-Has\-Full\-Replica\-NCs,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-hasFullReplicaNCs  
  
 adminDisplayName: ms\-DS\-Has\-Full\-Replica\-NCs  
  
 adminDescription: For a Directory instance \(DSA\), identifies the partitions held as full replicas  
  
 attributeId: 1.2.840.113556.1.4.1925  
  
 attributeSyntax: 2.5.5.1  
  
 omSyntax: 127  
  
 isSingleValued: FALSE  
  
 systemOnly: TRUE  
  
 searchFlags: 0  
  
 omObjectClass:: KwwCh3McAIVK  
  
 schemaIdGuid:: GC08HdBCaEiZ\/g7KHm\+p8w\=\=  
  
 linkID: 2104  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DS\-Never\-Reveal\-Group,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-NeverRevealGroup  
  
 adminDisplayName: ms\-DS\-Never\-Reveal\-Group  
  
 adminDescription: For a Directory instance \(DSA\), identifies the security group whose users will never have their secrets disclosed to that instance  
  
 attributeId: 1.2.840.113556.1.4.1926  
  
 attributeSyntax: 2.5.5.1  
  
 omSyntax: 127  
  
 isSingleValued: FALSE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 omObjectClass:: KwwCh3McAIVK  
  
 schemaIdGuid:: mVlYFUn9Zk2yXe65arqBdA\=\=  
  
 linkID: 2106  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DS\-Reveal\-OnDemand\-Group,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-RevealOnDemandGroup  
  
 adminDisplayName: ms\-DS\-Reveal\-OnDemand\-Group  
  
 adminDescription: For a Directory instance \(DSA\), identifies the security group whose users may have their secrets disclosed to that instance  
  
 attributeId: 1.2.840.113556.1.4.1928  
  
 attributeSyntax: 2.5.5.1  
  
 omSyntax: 127  
  
 isSingleValued: FALSE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 omObjectClass:: KwwCh3McAIVK  
  
 schemaIdGuid:: Sp89MNYdOEuPxTOv6MmIrQ\=\=  
  
 linkID: 2110  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DS\-Secondary\-KrbTgt\-Number,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-SecondaryKrbTgtNumber  
  
 adminDisplayName: ms\-DS\-Secondary\-KrbTgt\-Number  
  
 adminDescription: For a user object \(krbtgt\), acting as a secondary domain master secret, identifies the protocol identification number associated with the secondary domain.  
  
 attributeId: 1.2.840.113556.1.4.1929  
  
 attributeSyntax: 2.5.5.9  
  
 omSyntax: 2  
  
 isSingleValued: TRUE  
  
 systemOnly: TRUE  
  
 searchFlags: 1  
  
 rangeLower: 65536  
  
 rangeUpper: 65536  
  
 schemaIdGuid:: EmYVqpYjfkataijSP9sYZQ\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DS\-Revealed\-DSAs,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-RevealedDSAs  
  
 adminDisplayName: ms\-DS\-Revealed\-DSAs  
  
 adminDescription: Backlink for ms\-DS\-Revealed\-Users; for a user, identifies which Directory instances \(DSA\) hold that user's secret  
  
 attributeId: 1.2.840.113556.1.4.1930  
  
 attributeSyntax: 2.5.5.1  
  
 omSyntax: 127  
  
 isSingleValued: FALSE  
  
 systemOnly: TRUE  
  
 searchFlags: 0  
  
 omObjectClass:: KwwCh3McAIVK  
  
 schemaIdGuid:: rPL2lG3HXku3H\/Myw\+k8Ig\=\=  
  
 linkID: 2103  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 17  
  
 dn: CN\=ms\-DS\-KrbTgt\-Link\-BL,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-KrbTgtLinkBl  
  
 adminDisplayName: ms\-DS\-KrbTgt\-Link\-BL  
  
 adminDescription: Backlink for ms\-DS\-KrbTgt\-Link; for a user object \(krbtgt\) acting as a domain or secondary domain master secret, identifies which computers are in that domain or secondary domain  
  
 attributeId: 1.2.840.113556.1.4.1931  
  
 attributeSyntax: 2.5.5.1  
  
 omSyntax: 127  
  
 isSingleValued: FALSE  
  
 systemOnly: TRUE  
  
 searchFlags: 0  
  
 omObjectClass:: KwwCh3McAIVK  
  
 schemaIdGuid:: QYzWXd\+\/i0ObXTnZYYvyYA\=\=  
  
 linkID: 2101  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 17  
  
 dn: CN\=ms\-DS\-Is\-Domain\-For,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-IsDomainFor  
  
 adminDisplayName: ms\-DS\-Is\-Domain\-For  
  
 adminDescription: Backlink for ms\-DS\-Has\-Domain\-NCs; for a partition root object, identifies which Directory instances \(DSA\) hold that partition as their primary domain  
  
 attributeId: 1.2.840.113556.1.4.1933  
  
 attributeSyntax: 2.5.5.1  
  
 omSyntax: 127  
  
 isSingleValued: FALSE  
  
 systemOnly: TRUE  
  
 searchFlags: 0  
  
 omObjectClass:: KwwCh3McAIVK  
  
 schemaIdGuid:: KloV\/\+VE4E2DGBOliYjeTw\=\=  
  
 linkID: 2027  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 17  
  
 dn: CN\=ms\-DS\-Is\-Full\-Replica\-For,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-IsFullReplicaFor  
  
 adminDisplayName: ms\-DS\-Is\-Full\-Replica\-For  
  
 adminDescription: Backlink for ms\-Ds\-Has\-Full\-Replica\-NCs; for a partition root object, identifies which Directory instances \(DSA\) hold that partition as a full replica  
  
 attributeId: 1.2.840.113556.1.4.1932  
  
 attributeSyntax: 2.5.5.1  
  
 omSyntax: 127  
  
 isSingleValued: FALSE  
  
 systemOnly: TRUE  
  
 searchFlags: 0  
  
 omObjectClass:: KwwCh3McAIVK  
  
 schemaIdGuid:: 4HK8yLSm8EiUpf12qIyZhw\=\=  
  
 linkID: 2105  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 17  
  
 dn: CN\=ms\-DS\-Is\-Partial\-Replica\-For,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-IsPartialReplicaFor  
  
 adminDisplayName: ms\-DS\-Is\-Partial\-Replica\-For  
  
 adminDescription: Backlink for has\-Partial\-Replica\-NCs; for a partition root object, identifies which Directory instances \(DSA\) hold that partition as a partial replica  
  
 attributeId: 1.2.840.113556.1.4.1934  
  
 attributeSyntax: 2.5.5.1  
  
 omSyntax: 127  
  
 isSingleValued: FALSE  
  
 systemOnly: TRUE  
  
 searchFlags: 0  
  
 omObjectClass:: KwwCh3McAIVK  
  
 schemaIdGuid:: 9k\/JN9TGj0my\+cb3\+GR4CQ\=\=  
  
 linkID: 75  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 17  
  
 dn: CN\=Top,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.1931  
  
 systemMayContain: 1.2.840.113556.1.4.1930  
  
 systemMayContain: 1.2.840.113556.1.4.1932  
  
 systemMayContain: 1.2.840.113556.1.4.1933  
  
 systemMayContain: 1.2.840.113556.1.4.1934  
  
 \-  
  
 dn: CN\=User,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.1929  
  
 \-  
  
 dn: CN\=Computer,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.1923  
  
 \-  
  
 dn: CN\=NTDS\-DSA,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.1925  
  
 systemMayContain: 1.2.840.113556.1.4.1928  
  
 systemMayContain: 1.2.840.113556.1.4.1926  
  
 systemMayContain: 1.2.840.113556.1.4.1924  
  
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
  
 objectVersion: 32  
  
 \-  
  
  