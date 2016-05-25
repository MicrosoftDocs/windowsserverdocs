---
title: Sch39.ldf
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: ce023110-58cd-44ed-8018-485bd1745930
author: Femila
---
# Sch39.ldf
  dn: CN\=ms\-FVE\-KeyPackage,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msFVE\-KeyPackage  
  
 adminDisplayName: FVE\-KeyPackage  
  
 adminDescription: This attribute contains a volume's BitLocker encryption key secured by the corresponding recovery password. Full Volume Encryption \(FVE\) was the pre\-release name for BitLocker Drive Encryption.  
  
 attributeId: 1.2.840.113556.1.4.1999  
  
 attributeSyntax: 2.5.5.10  
  
 omSyntax: 4  
  
 isSingleValued: TRUE  
  
 searchFlags: 152  
  
 rangeUpper: 102400  
  
 schemaIdGuid:: qF7VH6eI3EeBKQ2qlxhqVA\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-FVE\-VolumeGuid,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msFVE\-VolumeGuid  
  
 adminDisplayName: FVE\-VolumeGuid  
  
 adminDescription: This attribute contains the GUID associated with a BitLocker\-supported disk volume. Full Volume Encryption \(FVE\) was the pre\-release name for BitLocker Drive Encryption.  
  
 attributeId: 1.2.840.113556.1.4.1998  
  
 attributeSyntax: 2.5.5.10  
  
 omSyntax: 4  
  
 isSingleValued: TRUE  
  
 searchFlags: 27  
  
 rangeUpper: 128  
  
 schemaIdGuid:: z6Xlhe7cdUCc\/aydtqLyRQ\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DS\-HAB\-Seniority\-Index,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-HABSeniorityIndex  
  
 adminDisplayName: ms\-DS\-HAB\-Seniority\-Index  
  
 adminDescription: Contains the seniority index as applied by the organization where the person works.  
  
 attributeId: 1.2.840.113556.1.4.1997  
  
 attributeSyntax: 2.5.5.9  
  
 omSyntax: 2  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 mapiID: 36000  
  
 searchFlags: 1  
  
 schemaIdGuid:: 8Un03jv9RUCYz9lljaeItQ\=\=  
  
 attributeSecurityGuid:: VAGN5Pi80RGHAgDAT7lgUA\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-FVE\-RecoveryPassword,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: adminDescription  
  
 adminDescription: This attribute contains a password that can recover a BitLocker\-encrypted volume. Full Volume Encryption \(FVE\) was the pre\-release name for BitLocker Drive Encryption.  
  
 \-  
  
 add: rangeUpper  
  
 rangeUpper: 256  
  
 \-  
  
 replace: searchFlags  
  
 searchFlags: 152  
  
 \-  
  
 dn: CN\=ms\-FVE\-RecoveryGuid,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: adminDescription  
  
 adminDescription: This attribute contains the GUID associated with a BitLocker recovery password. Full Volume Encryption \(FVE\) was the prerelease name for BitLocker Drive Encryption.  
  
 \-  
  
 add: rangeUpper  
  
 rangeUpper: 128  
  
 \-  
  
 replace: searchFlags  
  
 searchFlags: 27  
  
 \-  
  
 dn: CN\=ms\-TPM\-OwnerInformation,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: rangeUpper  
  
 rangeUpper: 128  
  
 \-  
  
 replace: searchFlags  
  
 searchFlags: 152  
  
 \-  
  
 dn: CN\=User,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.1958  
  
 \-  
  
 dn: CN\=ms\-FVE\-RecoveryInformation,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: adminDescription  
  
 adminDescription: This class contains BitLocker recovery information including GUIDs, recovery passwords, and keys. Full Volume Encryption \(FVE\) was the pre\-release name for BitLocker Drive Encryption.  
  
 \-  
  
 dn: CN\=msSFU\-30\-Posix\-Member,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: adminDescription  
  
 adminDescription: This attribute is used to store the distinguished name display name of users which are a part of the group  
  
 \-  
  
 dn: CN\=ms\-FVE\-RecoveryInformation,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.1998  
  
 systemMayContain: 1.2.840.113556.1.4.1999  
  
 \-  
  
 dn: CN\=NTDS\-DSA\-RO,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: systemOnly  
  
 systemOnly: TRUE  
  
 \-  
  
 dn: CN\=Organizational\-Person,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: mayContain  
  
 mayContain: 1.2.840.113556.1.4.1997  
  
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
  
 objectVersion: 39  
  
 \-  
  
  