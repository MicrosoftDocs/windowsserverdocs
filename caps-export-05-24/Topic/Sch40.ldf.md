---
title: Sch40.ldf
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: bdfe402a-1eef-4794-bc5b-fd5301b69f8a
author: Femila
---
# Sch40.ldf
  dn: CN\=ms\-DS\-Password\-Reversible\-Encryption\-Enabled,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-PasswordReversibleEncryptionEnabled  
  
 adminDisplayName: Password Reversible Encryption Status  
  
 adminDescription: Password reversible encryption status for user accounts  
  
 attributeId: 1.2.840.113556.1.4.2016  
  
 attributeSyntax: 2.5.5.8  
  
 omSyntax: 1  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 schemaIdGuid:: j93MdWyvh0S7S2nk04qVnA\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DS\-NC\-Type,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-NcType  
  
 adminDisplayName: ms\-DS\-NC\-Type  
  
 adminDescription: A bit field that maintains information about aspects of a NC replica that are relevant to replication.  
  
 attributeId: 1.2.840.113556.1.4.2024  
  
 attributeSyntax: 2.5.5.9  
  
 omSyntax: 2  
  
 isSingleValued: TRUE  
  
 systemOnly: TRUE  
  
 searchFlags: 0  
  
 schemaIdGuid:: 16wuWivMz0idmrbxoAJN6Q\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 17  
  
 dn: CN\=ms\-DS\-PSO\-Applies\-To,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-PSOAppliesTo  
  
 adminDisplayName: Password settings object applies to  
  
 adminDescription: Links to objects that this password settings object applies to  
  
 attributeId: 1.2.840.113556.1.4.2020  
  
 attributeSyntax: 2.5.5.1  
  
 omSyntax: 127  
  
 isSingleValued: FALSE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 omObjectClass:: KwwCh3McAIVK  
  
 schemaIdGuid:: SA\/IZNLNgUiobU6XtvVh\/A\=\=  
  
 linkID: 2118  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DS\-PSO\-Applied,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-PSOApplied  
  
 adminDisplayName: Password settings object applied  
  
 adminDescription: Password settings object applied to this object  
  
 attributeId: 1.2.840.113556.1.4.2021  
  
 attributeSyntax: 2.5.5.1  
  
 omSyntax: 127  
  
 isSingleValued: FALSE  
  
 systemOnly: TRUE  
  
 searchFlags: 16  
  
 omObjectClass:: KwwCh3McAIVK  
  
 schemaIdGuid:: MfBsXqi9yEOspI\/uQScAWw\=\=  
  
 linkID: 2119  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 17  
  
 dn: CN\=ms\-DS\-Resultant\-PSO,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-ResultantPSO  
  
 adminDisplayName: Resultant password settings object applied  
  
 adminDescription: Resultant password settings object applied to this object  
  
 attributeId: 1.2.840.113556.1.4.2022  
  
 attributeSyntax: 2.5.5.1  
  
 omSyntax: 127  
  
 isSingleValued: TRUE  
  
 systemOnly: TRUE  
  
 searchFlags: 16  
  
 omObjectClass:: KwwCh3McAIVK  
  
 schemaIdGuid:: k6B\+t9CIgEeamJEfjosdyg\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 20  
  
 dn: CN\=ms\-DS\-Lockout\-Duration,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-LockoutDuration  
  
 adminDisplayName: Lockout Duration  
  
 adminDescription: Lockout duration for locked out user accounts  
  
 attributeId: 1.2.840.113556.1.4.2018  
  
 attributeSyntax: 2.5.5.16  
  
 omSyntax: 65  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 rangeUpper: 0  
  
 schemaIdGuid:: mogfQi5H5E\+OueHQvGBxsg\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DS\-Lockout\-Threshold,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-LockoutThreshold  
  
 adminDisplayName: Lockout Threshold  
  
 adminDescription: Lockout threshold for lockout of user accounts  
  
 attributeId: 1.2.840.113556.1.4.2019  
  
 attributeSyntax: 2.5.5.9  
  
 omSyntax: 2  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 rangeLower: 0  
  
 rangeUpper: 65535  
  
 schemaIdGuid:: XsPIuBlKlUqZ0Gn\+REYobw\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DS\-Minimum\-Password\-Age,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-MinimumPasswordAge  
  
 adminDisplayName: Minimum Password Age  
  
 adminDescription: Minimum Password Age for user accounts  
  
 attributeId: 1.2.840.113556.1.4.2012  
  
 attributeSyntax: 2.5.5.16  
  
 omSyntax: 65  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 rangeUpper: 0  
  
 schemaIdGuid:: ePh0KpxN\+UmXs2dn0cvZow\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DS\-Maximum\-Password\-Age,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-MaximumPasswordAge  
  
 adminDisplayName: Maximum Password Age  
  
 adminDescription: Maximum Password Age for user accounts  
  
 attributeId: 1.2.840.113556.1.4.2011  
  
 attributeSyntax: 2.5.5.16  
  
 omSyntax: 65  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 rangeUpper: 0  
  
 schemaIdGuid:: 9TfT\/ZlJzk\+yUo\/5ybQ4dQ\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DS\-Minimum\-Password\-Length,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-MinimumPasswordLength  
  
 adminDisplayName: Minimum Password Length  
  
 adminDescription: Minimum Password Length for user accounts  
  
 attributeId: 1.2.840.113556.1.4.2013  
  
 attributeSyntax: 2.5.5.9  
  
 omSyntax: 2  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 rangeLower: 0  
  
 rangeUpper: 255  
  
 schemaIdGuid:: OTQbsjpMHES7XwjyDpsxXg\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DS\-Password\-History\-Length,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-PasswordHistoryLength  
  
 adminDisplayName: Password History Length  
  
 adminDescription: Password History Length for user accounts  
  
 attributeId: 1.2.840.113556.1.4.2014  
  
 attributeSyntax: 2.5.5.9  
  
 omSyntax: 2  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 rangeLower: 0  
  
 rangeUpper: 65535  
  
 schemaIdGuid:: txvY\/ox2L0yWQSJF3jR5TQ\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DS\-Lockout\-Observation\-Window,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-LockoutObservationWindow  
  
 adminDisplayName: Lockout Observation Window  
  
 adminDescription: Observation Window for lockout of user accounts  
  
 attributeId: 1.2.840.113556.1.4.2017  
  
 attributeSyntax: 2.5.5.16  
  
 omSyntax: 65  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 rangeUpper: 0  
  
 schemaIdGuid:: idpbsK92ika4khvlVVjsyA\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DS\-Password\-Complexity\-Enabled,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-PasswordComplexityEnabled  
  
 adminDisplayName: Password Complexity Status  
  
 adminDescription: Password complexity status for user accounts  
  
 attributeId: 1.2.840.113556.1.4.2015  
  
 attributeSyntax: 2.5.5.8  
  
 omSyntax: 1  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 schemaIdGuid:: SwVo28PJ8EuxWw\+1JVKmEA\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DS\-Password\-Settings\-Precedence,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-PasswordSettingsPrecedence  
  
 adminDisplayName: Password Settings Precedence  
  
 adminDescription: Password Settings Precedence  
  
 attributeId: 1.2.840.113556.1.4.2023  
  
 attributeSyntax: 2.5.5.9  
  
 omSyntax: 2  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 rangeLower: 1  
  
 schemaIdGuid:: rHRjRQofF0aTz7xVp8nTQQ\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=MS\-TS\-ManagingLS2,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msTSManagingLS2  
  
 adminDisplayName: MS\-TS\-ManagingLS2  
  
 adminDescription: Issuer name of the second TS per user CAL.  
  
 attributeId: 1.2.840.113556.1.4.2002  
  
 attributeSyntax: 2.5.5.12  
  
 omSyntax: 64  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 1  
  
 rangeLower: 0  
  
 rangeUpper: 255  
  
 schemaIdGuid:: VwefNL1RyE\+dZj7O6oolvg\=\=  
  
 attributeSecurityGuid:: YrwFWMm9KESl4oVqD0wYXg\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=MS\-TS\-ManagingLS3,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msTSManagingLS3  
  
 adminDisplayName: MS\-TS\-ManagingLS3  
  
 adminDescription: Issuer name of the third TS per user CAL.  
  
 attributeId: 1.2.840.113556.1.4.2005  
  
 attributeSyntax: 2.5.5.12  
  
 omSyntax: 64  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 1  
  
 rangeLower: 0  
  
 rangeUpper: 255  
  
 schemaIdGuid:: wdzV\+jAhh0yhGHUyLNZwUA\=\=  
  
 attributeSecurityGuid:: YrwFWMm9KESl4oVqD0wYXg\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=MS\-TS\-ManagingLS4,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msTSManagingLS4  
  
 adminDisplayName: MS\-TS\-ManagingLS4  
  
 adminDescription: Issuer name of the fourth TS per user CAL.  
  
 attributeId: 1.2.840.113556.1.4.2008  
  
 attributeSyntax: 2.5.5.12  
  
 omSyntax: 64  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 1  
  
 rangeLower: 0  
  
 rangeUpper: 255  
  
 schemaIdGuid:: oLaj9wchQEGzBnXLUhcx5Q\=\=  
  
 attributeSecurityGuid:: YrwFWMm9KESl4oVqD0wYXg\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=MS\-TS\-ExpireDate2,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msTSExpireDate2  
  
 adminDisplayName: MS\-TS\-ExpireDate2  
  
 adminDescription: Expiration date of the second TS per user CAL.  
  
 attributeId: 1.2.840.113556.1.4.2000  
  
 attributeSyntax: 2.5.5.11  
  
 omSyntax: 24  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 1  
  
 schemaIdGuid:: cc\/fVD\+8C0\+dWkskdruJJQ\=\=  
  
 attributeSecurityGuid:: YrwFWMm9KESl4oVqD0wYXg\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=MS\-TS\-ExpireDate3,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msTSExpireDate3  
  
 adminDisplayName: MS\-TS\-ExpireDate3  
  
 adminDescription: Expiration date of the third TS per user CAL.  
  
 attributeId: 1.2.840.113556.1.4.2003  
  
 attributeSyntax: 2.5.5.11  
  
 omSyntax: 24  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 1  
  
 schemaIdGuid:: BH\+8QXK\+MEm9EB80OUEjhw\=\=  
  
 attributeSecurityGuid:: YrwFWMm9KESl4oVqD0wYXg\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=MS\-TS\-ExpireDate4,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msTSExpireDate4  
  
 adminDisplayName: MS\-TS\-ExpireDate4  
  
 adminDescription: Expiration date of the fourth TS per user CAL.  
  
 attributeId: 1.2.840.113556.1.4.2006  
  
 attributeSyntax: 2.5.5.11  
  
 omSyntax: 24  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 1  
  
 schemaIdGuid:: Q9wRXkogr0\+gCGhjYhxvXw\=\=  
  
 attributeSecurityGuid:: YrwFWMm9KESl4oVqD0wYXg\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=MS\-TSLS\-Property01,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msTSLSProperty01  
  
 adminDisplayName: MS\-TSLS\-Property01  
  
 adminDescription: Placeholder Terminal Server License Server Property 01  
  
 attributeId: 1.2.840.113556.1.4.2009  
  
 attributeSyntax: 2.5.5.12  
  
 omSyntax: 64  
  
 isSingleValued: FALSE  
  
 systemOnly: FALSE  
  
 searchFlags: 1  
  
 rangeLower: 0  
  
 rangeUpper: 32767  
  
 schemaIdGuid:: kDXlhx2XUkqVW0eU0VqErg\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=MS\-TSLS\-Property02,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msTSLSProperty02  
  
 adminDisplayName: MS\-TSLS\-Property02  
  
 adminDescription: Placeholder Terminal Server License Server Property 02  
  
 attributeId: 1.2.840.113556.1.4.2010  
  
 attributeSyntax: 2.5.5.12  
  
 omSyntax: 64  
  
 isSingleValued: FALSE  
  
 systemOnly: FALSE  
  
 searchFlags: 1  
  
 rangeLower: 0  
  
 rangeUpper: 32767  
  
 schemaIdGuid:: sHvHR24xL06X8Q1MSPyp3Q\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=MS\-TS\-LicenseVersion2,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msTSLicenseVersion2  
  
 adminDisplayName: MS\-TS\-LicenseVersion2  
  
 adminDescription: Version of the second TS per user CAL.  
  
 attributeId: 1.2.840.113556.1.4.2001  
  
 attributeSyntax: 2.5.5.12  
  
 omSyntax: 64  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 1  
  
 rangeLower: 0  
  
 rangeUpper: 255  
  
 schemaIdGuid:: A\/ENS5eN2UWtaYXDCAuk5w\=\=  
  
 attributeSecurityGuid:: YrwFWMm9KESl4oVqD0wYXg\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=MS\-TS\-LicenseVersion3,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msTSLicenseVersion3  
  
 adminDisplayName: MS\-TS\-LicenseVersion3  
  
 adminDescription: Version of the third TS per user CAL.  
  
 attributeId: 1.2.840.113556.1.4.2004  
  
 attributeSyntax: 2.5.5.12  
  
 omSyntax: 64  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 1  
  
 rangeLower: 0  
  
 rangeUpper: 255  
  
 schemaIdGuid:: gY\+6\+KtMc0mjyDptpipeMQ\=\=  
  
 attributeSecurityGuid:: YrwFWMm9KESl4oVqD0wYXg\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=MS\-TS\-LicenseVersion4,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msTSLicenseVersion4  
  
 adminDisplayName: MS\-TS\-LicenseVersion4  
  
 adminDescription: Version of the fourth TS per user CAL.  
  
 attributeId: 1.2.840.113556.1.4.2007  
  
 attributeSyntax: 2.5.5.12  
  
 omSyntax: 64  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 1  
  
 rangeLower: 0  
  
 rangeUpper: 255  
  
 schemaIdGuid:: l13KcAQjCkmKJ1JnjI0glQ\=\=  
  
 attributeSecurityGuid:: YrwFWMm9KESl4oVqD0wYXg\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DS\-Is\-User\-Cachable\-At\-Rodc,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-IsUserCachableAtRodc  
  
 adminDisplayName: ms\-DS\-Is\-User\-Cachable\-At\-Rodc  
  
 adminDescription: For a Read\-Only Directory instance \(DSA\), Identifies whether the specified user's secrets are cachable.  
  
 attributeId: 1.2.840.113556.1.4.2025  
  
 attributeSyntax: 2.5.5.9  
  
 omSyntax: 2  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 schemaIdGuid:: WiQB\/h80VkWVH0jAM6iQUA\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 20  
  
 dn: CN\=Title,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: rangeUpper  
  
 rangeUpper: 128  
  
 \-  
  
 dn: CN\=Last\-Logon\-Timestamp,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: searchFlags  
  
 searchFlags: 1  
  
 \-  
  
 dn: CN\=ms\-FVE\-RecoveryPassword,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: searchFlags  
  
 searchFlags: 664  
  
 \-  
  
 dn: CN\=ms\-TPM\-OwnerInformation,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: searchFlags  
  
 searchFlags: 664  
  
 \-  
  
 dn: CN\=ms\-FVE\-KeyPackage,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: searchFlags  
  
 searchFlags: 664  
  
 \-  
  
 dn: CN\=Picture,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: mapiId  
  
 mapiId: 35998  
  
 \-  
  
 dn: CN\=ms\-DS\-Source\-Object\-DN,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: attributeSecurityGuid  
  
 attributeSecurityGuid:: VAGN5Pi80RGHAgDAT7lgUA\=\=  
  
 \-  
  
 dn: CN\=ipServiceProtocol,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: isSingleValued  
  
 isSingleValued: FALSE  
  
 \-  
  
 dn: CN\=Device,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemPossSuperiors  
  
 systemPossSuperiors: 1.2.840.113556.1.5.67  
  
 \-  
  
 dn: CN\=ipService,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: possSuperiors  
  
 possSuperiors: 1.2.840.113556.1.5.67  
  
 \-  
  
 dn: CN\=ipService,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: possSuperiors  
  
 possSuperiors: 1.3.6.1.1.1.2.9  
  
 \-  
  
 dn: CN\=ipProtocol,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: possSuperiors  
  
 possSuperiors: 1.2.840.113556.1.5.67  
  
 \-  
  
 dn: CN\=ipProtocol,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: possSuperiors  
  
 possSuperiors: 1.3.6.1.1.1.2.9  
  
 \-  
  
 dn: CN\=ipHost,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: mayContain  
  
 mayContain: 0.9.2342.19200300.100.1.10  
  
 \-  
  
 dn: CN\=ipNetwork,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: possSuperiors  
  
 possSuperiors: 1.2.840.113556.1.5.67  
  
 \-  
  
 dn: CN\=ipNetwork,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: possSuperiors  
  
 possSuperiors: 1.3.6.1.1.1.2.9  
  
 \-  
  
 dn: CN\=ipNetwork,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: mayContain  
  
 mayContain: 0.9.2342.19200300.100.1.10  
  
 \-  
  
 dn: CN\=nisNetgroup,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: possSuperiors  
  
 possSuperiors: 1.2.840.113556.1.5.67  
  
 \-  
  
 dn: CN\=nisNetGroup,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: possSuperiors  
  
 possSuperiors: 1.3.6.1.1.1.2.9  
  
 \-  
  
 dn: CN\=nisMap,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: possSuperiors  
  
 possSuperiors: 1.2.840.113556.1.5.67  
  
 \-  
  
 dn: CN\=nisObject,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: possSuperiors  
  
 possSuperiors: 1.2.840.113556.1.5.67  
  
 \-  
  
 dn: CN\=nisObject,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: possSuperiors  
  
 possSuperiors: 1.3.6.1.1.1.2.9  
  
 \-  
  
 dn: CN\=msSFU\-30\-Mail\-Aliases,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: possSuperiors  
  
 possSuperiors: 1.2.840.113556.1.5.67  
  
 \-  
  
 dn: CN\=msSFU\-30\-Mail\-Aliases,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: possSuperiors  
  
 possSuperiors: 1.3.6.1.1.1.2.9  
  
 \-  
  
 dn: CN\=msSFU\-30\-Net\-Id,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: possSuperiors  
  
 possSuperiors: 1.2.840.113556.1.5.67  
  
 \-  
  
 dn: CN\=msSFU\-30\-Net\-Id,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: possSuperiors  
  
 possSuperiors: 1.3.6.1.1.1.2.9  
  
 \-  
  
 dn: CN\=msSFU\-30\-Network\-User,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: possSuperiors  
  
 possSuperiors: 1.2.840.113556.1.5.67  
  
 \-  
  
 dn: CN\=msSFU\-30\-Network\-User,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: possSuperiors  
  
 possSuperiors: 1.3.6.1.1.1.2.9  
  
 \-  
  
 dn: CN\=ms\-DS\-Password\-Settings\-Container,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: classSchema  
  
 ldapDisplayName: msDS\-PasswordSettingsContainer  
  
 adminDisplayName: ms\-DS\-Password\-Settings\-Container  
  
 adminDescription: Container for password settings objects  
  
 governsId: 1.2.840.113556.1.5.256  
  
 objectClassCategory: 1  
  
 rdnAttId: 2.5.4.3  
  
 subClassOf: 2.5.6.0  
  
 systemPossSuperiors: 1.2.840.113556.1.3.23  
  
 schemaIdGuid:: arAGW\/NMwES9FkO8EKmH2g\=\=  
  
 defaultSecurityDescriptor: D:\(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;DA\)\(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY\)  
  
 showInAdvancedViewOnly: TRUE  
  
 systemOnly: FALSE  
  
 defaultObjectCategory: CN\=ms\-DS\-Password\-Settings\-Container,CN\=Schema,CN\=Configuration,DC\=X  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DS\-Password\-Settings,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: classSchema  
  
 ldapDisplayName: msDS\-PasswordSettings  
  
 adminDisplayName: ms\-DS\-Password\-Settings  
  
 adminDescription: Password settings object for accounts  
  
 governsId: 1.2.840.113556.1.5.255  
  
 objectClassCategory: 1  
  
 rdnAttId: 2.5.4.3  
  
 subClassOf: 2.5.6.0  
  
 systemMustContain: 1.2.840.113556.1.4.2023  
  
 systemMustContain: 1.2.840.113556.1.4.2016  
  
 systemMustContain: 1.2.840.113556.1.4.2019  
  
 systemMustContain: 1.2.840.113556.1.4.2018  
  
 systemMustContain: 1.2.840.113556.1.4.2017  
  
 systemMustContain: 1.2.840.113556.1.4.2015  
  
 systemMustContain: 1.2.840.113556.1.4.2013  
  
 systemMustContain: 1.2.840.113556.1.4.2012  
  
 systemMustContain: 1.2.840.113556.1.4.2011  
  
 systemMustContain: 1.2.840.113556.1.4.2014  
  
 systemMayContain: 1.2.840.113556.1.4.2020  
  
 systemPossSuperiors: 1.2.840.113556.1.5.256  
  
 schemaIdGuid:: uJ3NO0v4HEWVL2xSuB\+exg\=\=  
  
 defaultSecurityDescriptor: D:\(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;DA\)\(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY\)  
  
 showInAdvancedViewOnly: TRUE  
  
 systemOnly: FALSE  
  
 defaultObjectCategory: CN\=ms\-DS\-Password\-Settings,CN\=Schema,CN\=Configuration,DC\=X  
  
 systemFlags: 16  
  
 dn: CN\=User,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.2000  
  
 systemMayContain: 1.2.840.113556.1.4.2001  
  
 systemMayContain: 1.2.840.113556.1.4.2002  
  
 systemMayContain: 1.2.840.113556.1.4.2003  
  
 systemMayContain: 1.2.840.113556.1.4.2004  
  
 systemMayContain: 1.2.840.113556.1.4.2005  
  
 systemMayContain: 1.2.840.113556.1.4.2006  
  
 systemMayContain: 1.2.840.113556.1.4.2007  
  
 systemMayContain: 1.2.840.113556.1.4.2008  
  
 systemMayContain: 1.2.840.113556.1.4.2009  
  
 systemMayContain: 1.2.840.113556.1.4.2010  
  
 systemMayContain: 1.2.840.113556.1.4.2022  
  
 \-  
  
 dn: CN\=Top,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.2021  
  
 systemMayContain: 1.2.840.113556.1.4.2024  
  
 \-  
  
 dn: CN\=ms\-FVE\-RecoveryInformation,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: mayContain  
  
 mayContain: 1.2.840.113556.1.4.1998  
  
 mayContain: 1.2.840.113556.1.4.1999  
  
 \-  
  
 dn: CN\=ms\-FVE\-RecoveryInformation,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 delete: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.1998  
  
 systemMayContain: 1.2.840.113556.1.4.1999  
  
 \-  
  
 dn: CN\=Server,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.2025  
  
 \-  
  
 dn: CN\=Computer,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.2025  
  
 \-  
  
 dn: CN\=NTDS\-DSA,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.2025  
  
 \-  
  
 dn:  
  
 changetype: ntdsSchemaModify  
  
 add: schemaUpdateNow  
  
 schemaUpdateNow: 1  
  
 \-  
  
 dn: CN\=Reload\-SSL\-Certificate,CN\=Extended\-Rights,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: controlAccessRight  
  
 displayName: Reload SSL\/TLS Certificate  
  
 rightsGuid: 1a60ea8d\-58a6\-4b20\-bcdc\-fb71eb8a9ff8  
  
 appliesTo: f0f8ffab\-1191\-11d0\-a060\-00aa006c33ed  
  
 validAccesses: 256  
  
 localizationDisplayId: 76  
  
 dn: CN\=DS\-Replication\-Get\-Changes\-In\-Filtered\-Set,CN\=Extended\-Rights,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: controlAccessRight  
  
 displayName: Replicating Directory Changes In Filtered Set  
  
 appliesTo: 19195a5b\-6da0\-11d0\-afd3\-00c04fd930c9  
  
 appliesTo: bf967a87\-0de6\-11d0\-a285\-00aa003049e2  
  
 appliesTo: bf967a8f\-0de6\-11d0\-a285\-00aa003049e2  
  
 rightsGuid: 89e95b76\-444d\-4c62\-991a\-0facbeda640c  
  
 validAccesses: 256  
  
 localizationDisplayId: 77  
  
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
  
 objectVersion: 40  
  
 \-  
  
  