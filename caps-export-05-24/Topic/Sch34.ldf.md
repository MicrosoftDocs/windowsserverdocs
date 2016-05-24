---
title: Sch34.ldf
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 2c3dfa99-4813-493d-8600-bfea1033342d
author: Femila
---
# Sch34.ldf
  dn: CN\=ms\-DFSR\-ReadOnly,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDFSR\-ReadOnly  
  
 adminDisplayName: DFSR\-ReadOnly  
  
 adminDescription: Specify whether the content is read\-only or read\-write.  
  
 attributeId: 1.2.840.113556.1.6.13.3.28  
  
 attributeSyntax: 2.5.5.8  
  
 omSyntax: 1  
  
 isSingleValued: TRUE  
  
 searchFlags: 0  
  
 schemaIdGuid:: IYDEWkfk50adI5LAxqkN\+w\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 dn: CN\=ms\-DFSR\-Priority,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDFSR\-Priority  
  
 adminDisplayName: DFSR\-Priority  
  
 adminDescription: Priority level  
  
 attributeId: 1.2.840.113556.1.6.13.3.25  
  
 attributeSyntax: 2.5.5.9  
  
 omSyntax: 2  
  
 isSingleValued: TRUE  
  
 searchFlags: 0  
  
 schemaIdGuid:: 1ucg660y3kKxQRatJjGwGw\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 dn: CN\=ms\-DS\-Az\-Object\-Guid,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-AzObjectGuid  
  
 adminDisplayName: MS\-DS\-Az\-Object\-Guid  
  
 adminDescription: The unique and portable identifier of AzMan objects  
  
 attributeId: 1.2.840.113556.1.4.1949  
  
 attributeSyntax: 2.5.5.10  
  
 omSyntax: 4  
  
 isSingleValued: TRUE  
  
 systemOnly: TRUE  
  
 searchFlags: 1  
  
 rangeLower: 16  
  
 rangeUpper: 16  
  
 schemaIdGuid:: SOWRhDhsZUOnMq8EFWmwLA\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DS\-Az\-Generic\-Data,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-AzGenericData  
  
 adminDisplayName: MS\-DS\-Az\-Generic\-Data  
  
 adminDescription: AzMan specific generic data  
  
 attributeId: 1.2.840.113556.1.4.1950  
  
 attributeSyntax: 2.5.5.12  
  
 omSyntax: 64  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 rangeUpper: 65536  
  
 schemaIdGuid:: SeP3tVt6fECjNKMcP1OLmA\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DFSR\-CachePolicy,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDFSR\-CachePolicy  
  
 adminDisplayName: DFSR\-CachePolicy  
  
 adminDescription: On\-demand cache policy options  
  
 attributeId: 1.2.840.113556.1.6.13.3.29  
  
 attributeSyntax: 2.5.5.9  
  
 omSyntax: 2  
  
 isSingleValued: TRUE  
  
 searchFlags: 0  
  
 schemaIdGuid:: 5wh623b8aUWkX\/XstmqItQ\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 dn: CN\=ms\-DFSR\-DeletedPath,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDFSR\-DeletedPath  
  
 adminDisplayName: DFSR\-DeletedPath  
  
 adminDescription: Full path of the Deleted directory  
  
 attributeId: 1.2.840.113556.1.6.13.3.26  
  
 attributeSyntax: 2.5.5.12  
  
 omSyntax: 64  
  
 isSingleValued: TRUE  
  
 searchFlags: 0  
  
 rangeUpper: 32767  
  
 schemaIdGuid:: uPB8gZXbFEm4M1oHnvZXZA\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 dn: CN\=ms\-FVE\-RecoveryGuid,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msFVE\-RecoveryGuid  
  
 adminDisplayName: FVE\-RecoveryGuid  
  
 adminDescription: This attribute contains the GUID associated with a Full Volume Encryption \(FVE\) recovery password.  
  
 attributeId: 1.2.840.113556.1.4.1965  
  
 attributeSyntax: 2.5.5.10  
  
 omSyntax: 4  
  
 isSingleValued: TRUE  
  
 searchFlags: 9  
  
 schemaIdGuid:: vAlp93jmoEews\/hqAETAbQ\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DS\-Seniority\-Index,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-SeniorityIndex  
  
 adminDisplayName: ms\-DS\-Seniority\-Index  
  
 adminDescription: Contains the seniority index as applied by the organization where the person works.  
  
 attributeId: 1.2.840.113556.1.4.1947  
  
 attributeSyntax: 2.5.5.9  
  
 omSyntax: 2  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 1  
  
 schemaIdGuid:: 1KV7zpDwQUeswxXiyVVV2g\=\=  
  
 attributeSecurityGuid:: VAGN5Pi80RGHAgDAT7lgUA\=\=  
  
 mapiID: 35996  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-TPM\-OwnerInformation,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msTPM\-OwnerInformation  
  
 adminDisplayName: TPM\-OwnerInformation  
  
 adminDescription: This attribute contains the owner information of a particular TPM.  
  
 attributeId: 1.2.840.113556.1.4.1966  
  
 attributeSyntax: 2.5.5.12  
  
 omSyntax: 64  
  
 isSingleValued: TRUE  
  
 searchFlags: 8  
  
 schemaIdGuid:: bRpOqg1VBU6MNUr8uRep\/g\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-PKI\-DPAPIMasterKeys,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msPKIDPAPIMasterKeys  
  
 adminDisplayName: MS\-PKI\-DPAPIMasterKeys  
  
 adminDescription: Storage of encrypted DPAPI Master Keys for user  
  
 attributeId: 1.2.840.113556.1.4.1893  
  
 attributeSyntax: 2.5.5.7  
  
 omSyntax: 127  
  
 isSingleValued: FALSE  
  
 systemOnly: FALSE  
  
 searchFlags: 128  
  
 omObjectClass:: KoZIhvcUAQEBCw\=\=  
  
 schemaIdGuid:: IzD5szmSfE\+5nGdF2Hrbwg\=\=  
  
 attributeSecurityGuid:: 3kfmkW\/ZcEuVV9Y\/9PPM2A\=\=  
  
 linkID: 2046  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DS\-Phonetic\-Last\-Name,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-PhoneticLastName  
  
 adminDisplayName: ms\-DS\-Phonetic\-Last\-Name  
  
 adminDescription: Contains the phonetic last name of the person.  
  
 attributeId: 1.2.840.113556.1.4.1943  
  
 attributeSyntax: 2.5.5.12  
  
 omSyntax: 64  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 5  
  
 rangeLower: 1  
  
 rangeUpper: 64  
  
 schemaIdGuid:: 7OQX8jYIkEuIry9dS72ivA\=\=  
  
 attributeSecurityGuid:: VAGN5Pi80RGHAgDAT7lgUA\=\=  
  
 mapiID: 35983  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-PKI\-RoamingTimeStamp,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msPKIRoamingTimeStamp  
  
 adminDisplayName: MS\-PKI\-RoamingTimeStamp  
  
 adminDescription: Time stamp for last change to roaming tokens  
  
 attributeId: 1.2.840.113556.1.4.1892  
  
 attributeSyntax: 2.5.5.10  
  
 omSyntax: 4  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 128  
  
 schemaIdGuid:: rOQXZvGiq0O2DBH70frPBQ\=\=  
  
 attributeSecurityGuid:: 3kfmkW\/ZcEuVV9Y\/9PPM2A\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DFSR\-DeletedSizeInMb,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDFSR\-DeletedSizeInMb  
  
 adminDisplayName: DFSR\-DeletedSizeInMb  
  
 adminDescription: Size of the Deleted directory in MB  
  
 attributeId: 1.2.840.113556.1.6.13.3.27  
  
 attributeSyntax: 2.5.5.16  
  
 omSyntax: 65  
  
 isSingleValued: TRUE  
  
 searchFlags: 0  
  
 rangeUpper: \-1  
  
 schemaIdGuid:: 0ZrtU3WZ9EGD9QwGGhJVOg\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 dn: CN\=ms\-DS\-Phonetic\-First\-Name,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-PhoneticFirstName  
  
 adminDisplayName: ms\-DS\-Phonetic\-First\-Name  
  
 adminDescription: Contains the phonetic given name or first name of the person.  
  
 attributeId: 1.2.840.113556.1.4.1942  
  
 attributeSyntax: 2.5.5.12  
  
 omSyntax: 64  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 5  
  
 rangeLower: 1  
  
 rangeUpper: 64  
  
 schemaIdGuid:: TrocSy8wNEGsfPAfbHl4Qw\=\=  
  
 attributeSecurityGuid:: VAGN5Pi80RGHAgDAT7lgUA\=\=  
  
 mapiID: 35982  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-FVE\-RecoveryPassword,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msFVE\-RecoveryPassword  
  
 adminDisplayName: FVE\-RecoveryPassword  
  
 adminDescription: This attribute contains the password required to recover a Full Volume Encryption \(FVE\) volume.  
  
 attributeId: 1.2.840.113556.1.4.1964  
  
 attributeSyntax: 2.5.5.12  
  
 omSyntax: 64  
  
 isSingleValued: TRUE  
  
 searchFlags: 8  
  
 schemaIdGuid:: wRoGQ63IzEy3hSv6wg\/GCg\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DS\-Phonetic\-Department,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-PhoneticDepartment  
  
 adminDisplayName: ms\-DS\-Phonetic\-Department  
  
 adminDescription: Contains the phonetic department name where the person works.  
  
 attributeId: 1.2.840.113556.1.4.1944  
  
 attributeSyntax: 2.5.5.12  
  
 omSyntax: 64  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 5  
  
 rangeLower: 1  
  
 rangeUpper: 64  
  
 schemaIdGuid:: rz3VbD4A50mnAm\+oluem7w\=\=  
  
 attributeSecurityGuid:: VAGN5Pi80RGHAgDAT7lgUA\=\=  
  
 mapiID: 35984  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-PKI\-AccountCredentials,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msPKIAccountCredentials  
  
 adminDisplayName: MS\-PKI\-AccountCredentials  
  
 adminDescription: Storage of encrypted user credential token blobs for roaming  
  
 attributeId: 1.2.840.113556.1.4.1894  
  
 attributeSyntax: 2.5.5.7  
  
 omSyntax: 127  
  
 isSingleValued: FALSE  
  
 systemOnly: FALSE  
  
 searchFlags: 128  
  
 omObjectClass:: KoZIhvcUAQEBCw\=\=  
  
 schemaIdGuid:: RKffuNwx8U6sfIS69\+\+dpw\=\=  
  
 attributeSecurityGuid:: 3kfmkW\/ZcEuVV9Y\/9PPM2A\=\=  
  
 linkID: 2048  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-RADIUS\-FramedIpv6Route,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msRADIUS\-FramedIpv6Route  
  
 adminDisplayName: ms\-RADIUS\-FramedIpv6Route  
  
 adminDescription: This Attribute provides routing information to be configured for the user on the NAS.  
  
 attributeId: 1.2.840.113556.1.4.1917  
  
 attributeSyntax: 2.5.5.5  
  
 omSyntax: 22  
  
 isSingleValued: FALSE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 rangeUpper: 4096  
  
 schemaIdGuid:: BKhaWoMwY0iU5QGKeaIuwA\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 dn: CN\=ms\-DS\-Phonetic\-Display\-Name,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-PhoneticDisplayName  
  
 adminDisplayName: ms\-DS\-Phonetic\-Display\-Name  
  
 adminDescription: The phonetic display name of an object.  In the absence of a phonetic display name the existing display name is used.  
  
 attributeId: 1.2.840.113556.1.4.1946  
  
 attributeSyntax: 2.5.5.12  
  
 omSyntax: 64  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 5  
  
 rangeLower: 0  
  
 rangeUpper: 256  
  
 schemaIdGuid:: 5JQa4mYt5UyzDQ74endv8A\=\=  
  
 attributeSecurityGuid:: VAGN5Pi80RGHAgDAT7lgUA\=\=  
  
 mapiID: 35986  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DS\-Phonetic\-Company\-Name,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-PhoneticCompanyName  
  
 adminDisplayName: ms\-DS\-Phonetic\-Company\-Name  
  
 adminDescription: Contains the phonetic company name where the person works.  
  
 attributeId: 1.2.840.113556.1.4.1945  
  
 attributeSyntax: 2.5.5.12  
  
 omSyntax: 64  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 5  
  
 rangeLower: 1  
  
 rangeUpper: 64  
  
 schemaIdGuid:: jSDVW\/TlrkalFFQ7ycR2WQ\=\=  
  
 attributeSecurityGuid:: VAGN5Pi80RGHAgDAT7lgUA\=\=  
  
 mapiID: 35985  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-net\-ieee\-8023\-GP\-PolicyData,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: ms\-net\-ieee\-8023\-GP\-PolicyData  
  
 adminDisplayName: ms\-net\-ieee\-8023\-GP\-PolicyData  
  
 adminDescription: This attribute contains all of the settings and data which comprise a Group Policy configuration for 802.3 wired networks.  
  
 attributeId: 1.2.840.113556.1.4.1955  
  
 attributeSyntax: 2.5.5.12  
  
 omSyntax: 64  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 rangeUpper: 1048576  
  
 schemaIdGuid:: i5SYg1d0kU29TY1\+1mnJ9w\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-net\-ieee\-8023\-GP\-PolicyGUID,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: ms\-net\-ieee\-8023\-GP\-PolicyGUID  
  
 adminDisplayName: ms\-net\-ieee\-8023\-GP\-PolicyGUID  
  
 adminDescription: This attribute contains a GUID which identifies a specific 802.3 Group Policy object on the domain.  
  
 attributeId: 1.2.840.113556.1.4.1954  
  
 attributeSyntax: 2.5.5.12  
  
 omSyntax: 64  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 rangeUpper: 64  
  
 schemaIdGuid:: WrCnlLK4WU\+cJTnmm6oWhA\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DFSR\-MaxAgeInCacheInMin,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDFSR\-MaxAgeInCacheInMin  
  
 adminDisplayName: DFSR\-MaxAgeInCacheInMin  
  
 adminDescription: Maximum time in minutes to keep files in full form  
  
 attributeId: 1.2.840.113556.1.6.13.3.31  
  
 attributeSyntax: 2.5.5.9  
  
 omSyntax: 2  
  
 isSingleValued: TRUE  
  
 searchFlags: 0  
  
 rangeUpper: 2147483647  
  
 schemaIdGuid:: jeSwKk6s\/EqD5aNCQNthmA\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 dn: CN\=ms\-net\-ieee\-80211\-GP\-PolicyData,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: ms\-net\-ieee\-80211\-GP\-PolicyData  
  
 adminDisplayName: ms\-net\-ieee\-80211\-GP\-PolicyData  
  
 adminDescription: This attribute contains all of the settings and data which comprise a Group Policy configuration for 802.11 wireless networks.  
  
 attributeId: 1.2.840.113556.1.4.1952  
  
 attributeSyntax: 2.5.5.12  
  
 omSyntax: 64  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 rangeUpper: 4194304  
  
 schemaIdGuid:: pZUUnHZNjkaZHhQzsKZ4VQ\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-RADIUS\-FramedIpv6Prefix,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msRADIUS\-FramedIpv6Prefix  
  
 adminDisplayName: ms\-RADIUS\-FramedIpv6Prefix  
  
 adminDescription: This Attribute indicates an IPv6 prefix \(and corresponding route\) to be configured for the user.  
  
 attributeId: 1.2.840.113556.1.4.1915  
  
 attributeSyntax: 2.5.5.5  
  
 omSyntax: 22  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 rangeUpper: 16  
  
 schemaIdGuid:: ENY\+9nzWTUmHvs0eJDWaOA\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-net\-ieee\-80211\-GP\-PolicyGUID,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: ms\-net\-ieee\-80211\-GP\-PolicyGUID  
  
 adminDisplayName: ms\-net\-ieee\-80211\-GP\-PolicyGUID  
  
 adminDescription: This attribute contains a GUID which identifies a specific 802.11 Group Policy object on the domain.  
  
 attributeId: 1.2.840.113556.1.4.1951  
  
 attributeSyntax: 2.5.5.12  
  
 omSyntax: 64  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 rangeUpper: 64  
  
 schemaIdGuid:: YnBpNa8ei0SsHjiOC\+T97g\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-RADIUS\-FramedInterfaceId,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msRADIUS\-FramedInterfaceId  
  
 adminDisplayName: ms\-RADIUS\-FramedInterfaceId  
  
 adminDescription: This Attribute indicates the IPv6 interface identifier to be configured for the user.  
  
 attributeId: 1.2.840.113556.1.4.1913  
  
 attributeSyntax: 2.5.5.5  
  
 omSyntax: 22  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 rangeUpper: 8  
  
 schemaIdGuid:: I0ryplzWZU2mTzX7aHPCuQ\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DS\-NC\-RO\-Replica\-Locations,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-NC\-RO\-Replica\-Locations  
  
 adminDisplayName: ms\-DS\-NC\-RO\-Replica\-Locations  
  
 adminDescription: a linked attribute on a cross ref object for a partition. This attribute lists the DSA instances which should host the partition in a readonly manner.  
  
 attributeId: 1.2.840.113556.1.4.1967  
  
 attributeSyntax: 2.5.5.1  
  
 omSyntax: 127  
  
 isSingleValued: FALSE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 omObjectClass:: KwwCh3McAIVK  
  
 schemaIdGuid:: 35P3PViYF0SnAXNaHs6\/dA\=\=  
  
 linkID: 2114  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DS\-NC\-RO\-Replica\-Locations\-BL,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-NC\-RO\-Replica\-Locations\-BL  
  
 adminDisplayName: ms\-DS\-NC\-RO\-Replica\-Locations\-BL  
  
 adminDescription: backlink attribute for ms\-DS\-NC\-RO\-Replica\-Locations.  
  
 attributeId: 1.2.840.113556.1.4.1968  
  
 attributeSyntax: 2.5.5.1  
  
 omSyntax: 127  
  
 isSingleValued: FALSE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 omObjectClass:: KwwCh3McAIVK  
  
 schemaIdGuid:: HFFH9SpbzESDWJkqiCWBZA\=\=  
  
 linkID: 2115  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 17  
  
 dn: CN\=ms\-DFSR\-MinDurationCacheInMin,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDFSR\-MinDurationCacheInMin  
  
 adminDisplayName: DFSR\-MinDurationCacheInMin  
  
 adminDescription: Minimum time in minutes before truncating files  
  
 attributeId: 1.2.840.113556.1.6.13.3.30  
  
 attributeSyntax: 2.5.5.9  
  
 omSyntax: 2  
  
 isSingleValued: TRUE  
  
 searchFlags: 0  
  
 rangeUpper: 2147483647  
  
 schemaIdGuid:: emBdTEnOSkSYYoKpX10fzA\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 dn: CN\=ms\-net\-ieee\-8023\-GP\-PolicyReserved,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: ms\-net\-ieee\-8023\-GP\-PolicyReserved  
  
 adminDisplayName: ms\-net\-ieee\-8023\-GP\-PolicyReserved  
  
 adminDescription: Reserved for future use  
  
 attributeId: 1.2.840.113556.1.4.1956  
  
 attributeSyntax: 2.5.5.10  
  
 omSyntax: 4  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 rangeUpper: 1048576  
  
 schemaIdGuid:: xyfF0wYm602M\/RhCb\+7Izg\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-RADIUS\-SavedFramedIpv6Route,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msRADIUS\-SavedFramedIpv6Route  
  
 adminDisplayName: ms\-RADIUS\-SavedFramedIpv6Route  
  
 adminDescription: This Attribute provides routing information to be configured for the user on the NAS.  
  
 attributeId: 1.2.840.113556.1.4.1918  
  
 attributeSyntax: 2.5.5.5  
  
 omSyntax: 22  
  
 isSingleValued: FALSE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 rangeUpper: 4096  
  
 schemaIdGuid:: XLtmlp3fQU20Ny7sfifJsw\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 dn: CN\=ms\-net\-ieee\-80211\-GP\-PolicyReserved,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: ms\-net\-ieee\-80211\-GP\-PolicyReserved  
  
 adminDisplayName: ms\-net\-ieee\-80211\-GP\-PolicyReserved  
  
 adminDescription: Reserved for future use  
  
 attributeId: 1.2.840.113556.1.4.1953  
  
 attributeSyntax: 2.5.5.10  
  
 omSyntax: 4  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 rangeUpper: 4194304  
  
 schemaIdGuid:: LsZpD44I9U\+lOukjzsB8Cg\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-RADIUS\-SavedFramedIpv6Prefix,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msRADIUS\-SavedFramedIpv6Prefix  
  
 adminDisplayName: ms\-RADIUS\-SavedFramedIpv6Prefix  
  
 adminDescription: This Attribute indicates an IPv6 prefix \(and corresponding route\) to be configured for the user.  
  
 attributeId: 1.2.840.113556.1.4.1916  
  
 attributeSyntax: 2.5.5.5  
  
 omSyntax: 22  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 rangeUpper: 16  
  
 schemaIdGuid:: YqBlCeGxO0C0jVwOsOlSzA\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-RADIUS\-SavedFramedInterfaceId,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msRADIUS\-SavedFramedInterfaceId  
  
 adminDisplayName: ms\-RADIUS\-SavedFramedInterfaceId  
  
 adminDescription: This Attribute indicates the IPv6 interface identifier to be configured for the user.  
  
 attributeId: 1.2.840.113556.1.4.1914  
  
 attributeSyntax: 2.5.5.5  
  
 omSyntax: 22  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 rangeUpper: 8  
  
 schemaIdGuid:: iXLapKOS5UK2ttrRbSgKyQ\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=SAM\-Domain\-Updates,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: samDomainUpdates  
  
 adminDisplayName: SAM\-Domain\-Updates  
  
 adminDescription: Contains a bitmask of performed SAM operations on active directory  
  
 attributeId: 1.2.840.113556.1.4.1969  
  
 attributeSyntax: 2.5.5.10  
  
 omSyntax: 4  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 rangeUpper: 1024  
  
 schemaIdGuid:: FNHSBJn3m0683JDo9bp\+vg\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DFSR\-RootSizeInMb,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 delete: rangeUpper  
  
 \-  
  
 dn: CN\=ms\-net\-ieee\-8023\-GroupPolicy,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: classSchema  
  
 ldapDisplayName: ms\-net\-ieee\-8023\-GroupPolicy  
  
 adminDisplayName: ms\-net\-ieee\-8023\-GroupPolicy  
  
 adminDescription: This class represents an 802.3 wired network Group Policy object.  This class contains identifiers and configuration data relevant to an 802.3 wired network.  
  
 governsId: 1.2.840.113556.1.5.252  
  
 objectClassCategory: 1  
  
 rdnAttId: 2.5.4.3  
  
 subClassOf: 2.5.6.0  
  
 systemMayContain: 1.2.840.113556.1.4.1956  
  
 systemMayContain: 1.2.840.113556.1.4.1955  
  
 systemMayContain: 1.2.840.113556.1.4.1954  
  
 systemPossSuperiors: 1.2.840.113556.1.3.30  
  
 systemPossSuperiors: 1.2.840.113556.1.3.23  
  
 systemPossSuperiors: 2.5.6.6  
  
 schemaIdGuid:: ajqgmRmrRkSTUAy4eO0tmw\=\=  
  
 defaultSecurityDescriptor: D:\(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;DA\)\(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY\)\(A;;RPLCLORC;;;AU\)  
  
 showInAdvancedViewOnly: TRUE  
  
 defaultHidingValue: TRUE  
  
 systemOnly: FALSE  
  
 defaultObjectCategory: CN\=ms\-net\-ieee\-8023\-GroupPolicy,CN\=Schema,CN\=Configuration,DC\=X  
  
 systemFlags: 16  
  
 dn: CN\=ms\-net\-ieee\-80211\-GroupPolicy,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: classSchema  
  
 ldapDisplayName: ms\-net\-ieee\-80211\-GroupPolicy  
  
 adminDisplayName: ms\-net\-ieee\-80211\-GroupPolicy  
  
 adminDescription: This class represents an 802.11 wireless network Group Policy object.  This class contains identifiers and configuration data relevant to an 802.11 wireless network.  
  
 governsId: 1.2.840.113556.1.5.251  
  
 objectClassCategory: 1  
  
 rdnAttId: 2.5.4.3  
  
 subClassOf: 2.5.6.0  
  
 systemMayContain: 1.2.840.113556.1.4.1953  
  
 systemMayContain: 1.2.840.113556.1.4.1952  
  
 systemMayContain: 1.2.840.113556.1.4.1951  
  
 systemPossSuperiors: 1.2.840.113556.1.3.30  
  
 systemPossSuperiors: 1.2.840.113556.1.3.23  
  
 systemPossSuperiors: 2.5.6.6  
  
 schemaIdGuid:: Yxi4HCK4eUOeol\/3vcY4bQ\=\=  
  
 defaultSecurityDescriptor: D:\(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;DA\)\(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY\)\(A;;RPLCLORC;;;AU\)  
  
 showInAdvancedViewOnly: TRUE  
  
 defaultHidingValue: TRUE  
  
 systemOnly: FALSE  
  
 defaultObjectCategory: CN\=ms\-net\-ieee\-80211\-GroupPolicy,CN\=Schema,CN\=Configuration,DC\=X  
  
 systemFlags: 16  
  
 dn: CN\=ms\-FVE\-RecoveryInformation,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: classSchema  
  
 ldapDisplayName: msFVE\-RecoveryInformation  
  
 adminDisplayName: FVE\-RecoveryInformation  
  
 adminDescription: This class contains a Full Volume Encryption recovery password with its associated GUID.  
  
 governsId: 1.2.840.113556.1.5.253  
  
 objectClassCategory: 1  
  
 rdnAttId: 2.5.4.3  
  
 subClassOf: 2.5.6.0  
  
 systemMustContain: 1.2.840.113556.1.4.1965  
  
 systemMustContain: 1.2.840.113556.1.4.1964  
  
 systemPossSuperiors: 1.2.840.113556.1.3.30  
  
 schemaIdGuid:: MF1x6lOP0EC9HmEJGG14LA\=\=  
  
 defaultSecurityDescriptor: D:\(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;DA\)\(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY\)  
  
 showInAdvancedViewOnly: TRUE  
  
 defaultHidingValue: TRUE  
  
 systemOnly: FALSE  
  
 defaultObjectCategory: CN\=ms\-FVE\-RecoveryInformation,CN\=Schema,CN\=Configuration,DC\=X  
  
 systemFlags: 16  
  
 dn: CN\=NTDS\-DSA\-RO,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: classSchema  
  
 ldapDisplayName: nTDSDSARO  
  
 adminDisplayName: NTDS\-DSA\-RO  
  
 adminDescription: A subclass of Directory Service Agent which is distinguished by its reduced privilege level.  
  
 governsId: 1.2.840.113556.1.5.254  
  
 objectClassCategory: 1  
  
 rdnAttId: 2.5.4.3  
  
 subClassOf: 1.2.840.113556.1.5.7000.47  
  
 systemPossSuperiors: 2.5.6.4  
  
 systemPossSuperiors: 1.2.840.113556.1.5.17  
  
 schemaIdGuid:: wW7RhZEHyEuKs3CYBgL\/jA\=\=  
  
 defaultSecurityDescriptor: D:\(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;DA\)\(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY\)\(A;;RPLCLORC;;;AU\)  
  
 showInAdvancedViewOnly: TRUE  
  
 defaultHidingValue: TRUE  
  
 systemOnly: FALSE  
  
 defaultObjectCategory: CN\=NTDS\-DSA\-RO,CN\=Schema,CN\=Configuration,DC\=X  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DFSR\-Subscription,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: mayContain  
  
 mayContain: 1.2.840.113556.1.6.13.3.26  
  
 mayContain: 1.2.840.113556.1.6.13.3.27  
  
 mayContain: 1.2.840.113556.1.6.13.3.28  
  
 mayContain: 1.2.840.113556.1.6.13.3.29  
  
 mayContain: 1.2.840.113556.1.6.13.3.30  
  
 mayContain: 1.2.840.113556.1.6.13.3.31  
  
 \-  
  
 dn: CN\=ms\-DFSR\-ReplicationGroup,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: mayContain  
  
 mayContain: 1.2.840.113556.1.6.13.3.4  
  
 mayContain: 1.2.840.113556.1.6.13.3.6  
  
 mayContain: 1.2.840.113556.1.6.13.3.8  
  
 mayContain: 1.2.840.113556.1.6.13.3.12  
  
 mayContain: 1.2.840.113556.1.6.13.3.13  
  
 mayContain: 1.2.840.113556.1.6.13.3.27  
  
 \-  
  
 dn: CN\=ms\-DFSR\-ContentSet,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: mayContain  
  
 mayContain: 1.2.840.113556.1.6.13.3.4  
  
 mayContain: 1.2.840.113556.1.6.13.3.6  
  
 mayContain: 1.2.840.113556.1.6.13.3.8  
  
 mayContain: 1.2.840.113556.1.6.13.3.25  
  
 mayContain: 1.2.840.113556.1.6.13.3.27  
  
 \-  
  
 dn: CN\=Organizational\-Person,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: mayContain  
  
 mayContain: 1.2.840.113556.1.4.1942  
  
 mayContain: 1.2.840.113556.1.4.1943  
  
 mayContain: 1.2.840.113556.1.4.1944  
  
 mayContain: 1.2.840.113556.1.4.1945  
  
 mayContain: 1.2.840.113556.1.4.1946  
  
 mayContain: 1.2.840.113556.1.4.1947  
  
 \-  
  
 dn: CN\=Group,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.1949  
  
 systemMayContain: 1.2.840.113556.1.4.1950  
  
 systemMayContain: 1.2.840.113556.1.4.1801  
  
 systemMayContain: 1.2.840.113556.1.4.1802  
  
 systemMayContain: 1.2.840.113556.1.4.1803  
  
 systemMayContain: 1.2.840.113556.1.4.1819  
  
 \-  
  
 dn: CN\=User,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.1892  
  
 systemMayContain: 1.2.840.113556.1.4.1893  
  
 systemMayContain: 1.2.840.113556.1.4.1894  
  
 systemMayContain: 1.2.840.113556.1.4.1913  
  
 systemMayContain: 1.2.840.113556.1.4.1914  
  
 systemMayContain: 1.2.840.113556.1.4.1915  
  
 systemMayContain: 1.2.840.113556.1.4.1916  
  
 systemMayContain: 1.2.840.113556.1.4.1917  
  
 systemMayContain: 1.2.840.113556.1.4.1918  
  
 \-  
  
 dn: CN\=ms\-DFSR\-Connection,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: mayContain  
  
 mayContain: 1.2.840.113556.1.6.13.3.25  
  
 \-  
  
 dn: CN\=Cross\-Ref,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.1967  
  
 \-  
  
 dn: CN\=Computer,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.1966  
  
 \-  
  
 dn: CN\=Mail\-Recipient,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: mayContain  
  
 mayContain: 1.2.840.113556.1.4.1946  
  
 \-  
  
 dn: CN\=ms\-DS\-Az\-Admin\-Manager,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.1949  
  
 systemMayContain: 1.2.840.113556.1.4.1950  
  
 \-  
  
 dn: CN\=ms\-DS\-Az\-Application,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.1949  
  
 systemMayContain: 1.2.840.113556.1.4.1950  
  
 \-  
  
 dn: CN\=ms\-DS\-Az\-Operation,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.1949  
  
 systemMayContain: 1.2.840.113556.1.4.1950  
  
 \-  
  
 dn: CN\=ms\-DS\-Az\-Scope,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.1949  
  
 systemMayContain: 1.2.840.113556.1.4.1950  
  
 \-  
  
 dn: CN\=ms\-DS\-Az\-Task,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.1949  
  
 systemMayContain: 1.2.840.113556.1.4.1950  
  
 \-  
  
 dn: CN\=ms\-DS\-Az\-Role,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.1949  
  
 systemMayContain: 1.2.840.113556.1.4.1950  
  
 \-  
  
 dn: CN\=Sam\-Server,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.1969  
  
 \-  
  
 dn:  
  
 changetype: ntdsSchemaModify  
  
 add: schemaUpdateNow  
  
 schemaUpdateNow: 1  
  
 \-  
  
 dn: cn\=Private\-Information,CN\=Extended\-Rights,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 cn: Private\-Information  
  
 objectClass: controlAccessRight  
  
 displayName: Private Information  
  
 appliesTo: 4828cc14\-1437\-45bc\-9b07\-ad6f015e5f28  
  
 appliesTo: bf967aba\-0de6\-11d0\-a285\-00aa003049e2  
  
 rightsGUID: 91e647de\-d96f\-4b70\-9557\-d63ff4f3ccd8  
  
 validAccesses: 48  
  
 \# Increase object version  
  
 dn: CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: objectVersion  
  
 objectVersion: 34  
  
 \-  
  
  