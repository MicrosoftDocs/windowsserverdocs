---
ms.assetid: abf69b09-6528-42e0-b164-813c7c2c78e7
title: Schema Updates
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adds
---

# Schema Updates

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This topic lists the LDF files that include the changes that Adprep.exe makes in  Windows Server 2012 R2  and.  
  
These are the LDF files included in  Windows Server 2012 R2 :  
  
-   [Sch57.ldf](#BKMK_Sch57)  
  
-   [Sch58.ldf](#BKMK_Sch58)  
  
-   [Sch59.ldf](#BKMK_Sch59)  
  
-   [Sch60.ldf](#BKMK_Sch60)  
  
-   [Sch61.ldf](#BKMK_Sch61)  
  
-   [Sch62.ldf](#BKMK_Sch62)  
  
-   [Sch63.ldf](#BKMK_Sch63)  
  
-   [Sch64.ldf](#BKMK_Sch64)  
  
-   [Sch65.ldf](#BKMK_Sch65)  
  
-   [Sch66.ldf](#BKMK_Sch66)  
  
-   [Sch67.ldf](#BKMK_Sch67)  
  
-   [Sch68.ldf](#BKMK_Sch68)  
  
-   [Sch69.ldf](#BKMK_Sch69)  
  
These are the LDF files included in  Windows Server 2012 :  
  
-   [Sch48.ldf](#BKMK_Sch48)  
  
-   [Sch49.ldf](#BKMK_Sch49)  
  
-   [Sch50.ldf](#BKMK_Sch50)  
  
-   [Sch51.ldf](#BKMK_Sch51)  
  
-   [Sch52.ldf](#BKMK_Sch52)  
  
-   [Sch53.ldf](#BKMK_Sch53)  
  
-   [Sch54.ldf](#BKMK_Sch54)  
  
-   [Sch55.ldf](#BKMK_Sch55)  
  
-   [Sch56.ldf](#BKMK_Sch56)  
  
## <a name="BKMK_SchemaUpdates2012R2"></a>Schema Updates in Windows Server 2012 R2  
  
### <a name="BKMK_Sch57"></a>Sch57.ldf  
  
```  
dn: CN=ms-DS-Issuer-Certificates,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-Issuer-Certificates  
adminDisplayName: ms-DS-Issuer-Certificates  
adminDescription: The keys used to sign certificates issued by the Registration Service.  
ldapDisplayName: msDS-IssuerCertificates  
attributeId: 1.2.840.113556.1.4.2240  
omSyntax: 4  
attributeSyntax: 2.5.5.10  
isSingleValued: FALSE  
instanceType: 4  
rangeLower: 1  
rangeUpper: 65536  
searchFlags: 0  
systemOnly: FALSE  
schemaIdGuid:: 2m89a5MIxEOJ+x+1KmYWqQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-Registration-Quota,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-Registration-Quota  
adminDisplayName: ms-DS-Registration-Quota  
adminDescription: Policy used to limit the number of registrations allowed for a single user.  
ldapDisplayName: msDS-RegistrationQuota  
attributeId: 1.2.840.113556.1.4.2241  
omSyntax: 2  
attributeSyntax: 2.5.5.9  
isSingleValued: TRUE  
instanceType: 4  
searchFlags: 0  
systemOnly: FALSE  
schemaIdGuid:: woYyymQfeUCWvOYrYQ5zDw==  
systemFlags: 16  
  
dn: CN=ms-DS-Maximum-Registration-Inactivity-Period,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-Maximum-Registration-Inactivity-Period  
adminDisplayName: ms-DS-Maximum-Registration-Inactivity-Period  
adminDescription: The maximum ammount of days used to detect inactivty of registration objects.  
ldapDisplayName: msDS-MaximumRegistrationInactivityPeriod  
attributeId: 1.2.840.113556.1.4.2242  
omSyntax: 2  
attributeSyntax: 2.5.5.9  
isSingleValued: TRUE  
instanceType: 4  
searchFlags: 0  
systemOnly: FALSE  
schemaIdGuid:: OapcCuYFykm4CAJbk2YQ5w==  
systemFlags: 16  
  
dn: CN=ms-DS-Is-Enabled,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-Is-Enabled  
adminDisplayName: ms-DS-Is-Enabled  
adminDescription: This attribute is used to enable or disable the user-device relationship.  
ldapDisplayName: msDS-IsEnabled  
attributeId: 1.2.840.113556.1.4.2248  
omSyntax: 1  
attributeSyntax: 2.5.5.8  
isSingleValued: TRUE  
instanceType: 4  
searchFlags: 0  
systemOnly: FALSE  
schemaIdGuid:: DlypIoMfgkyUzr6miM/IcQ==  
systemFlags: 16  
  
dn: CN=ms-DS-Device-OS-Type,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-Device-OS-Type  
adminDisplayName: ms-DS-Device-OS-Type  
adminDescription: This attribute is used to track the type of device based on the OS.  
ldapDisplayName: msDS-DeviceOSType  
attributeId: 1.2.840.113556.1.4.2249  
omSyntax: 64  
attributeSyntax: 2.5.5.12  
isSingleValued: FALSE  
instanceType: 4  
rangeLower: 0  
rangeUpper: 1024  
searchFlags: 0  
systemOnly: FALSE  
schemaIdGuid:: TUUOELvzy02EX41e3EccWQ==  
systemFlags: 16  
  
dn: CN=ms-DS-Device-OS-Version,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-Device-OS-Version  
adminDisplayName: ms-DS-Device-OS-Version  
adminDescription: This attribute is used to track the OS version of the device.  
ldapDisplayName: msDS-DeviceOSVersion  
attributeId: 1.2.840.113556.1.4.2250  
omSyntax: 64  
attributeSyntax: 2.5.5.12  
isSingleValued: FALSE  
instanceType: 4  
rangeLower: 0  
rangeUpper: 512  
searchFlags: 0  
systemOnly: FALSE  
schemaIdGuid:: Y4z7cKtfBEWrnRSzKain+A==  
systemFlags: 16  
  
dn: CN=ms-DS-Device-Physical-IDs,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-Device-Physical-IDs  
adminDisplayName: ms-DS-Device-Physical-IDs  
adminDescription: This attribute is used to store identifiers of the physical device.  
ldapDisplayName: msDS-DevicePhysicalIDs  
attributeId: 1.2.840.113556.1.4.2251  
omSyntax: 4  
attributeSyntax: 2.5.5.10  
isSingleValued: FALSE  
instanceType: 4  
rangeLower: 1  
rangeUpper: 10485760  
searchFlags: 1  
systemOnly: FALSE  
schemaIdGuid:: FFRhkKCiR0Spk1NAlZm3Tg==  
systemFlags: 16  
  
dn: CN=ms-DS-Device-ID,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-Device-ID  
adminDisplayName: ms-DS-Device-ID  
adminDescription: This attribute stores the ID of the device.  
ldapDisplayName: msDS-DeviceID  
attributeId: 1.2.840.113556.1.4.2252  
omSyntax: 4  
attributeSyntax: 2.5.5.10  
isSingleValued: TRUE  
instanceType: 4  
rangeLower: 16  
rangeUpper: 16  
searchFlags: 1  
systemOnly: FALSE  
schemaIdGuid:: x4EBw0Jj+0GyeffFZsvgpw==  
systemFlags: 16  
  
dn:  
changetype: modify  
add: schemaUpdateNow  
schemaUpdateNow: 1  
-  
  
dn: CN=ms-DS-Device-Registration-Service-Container,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: classSchema  
cn: ms-DS-Device-Registration-Service-Container  
adminDisplayName: ms-DS-Device-Registration-Service-Container  
adminDescription: A class for the container used to house all enrollment services used for device registrations.  
ldapDisplayName: msDS-DeviceRegistrationServiceContainer  
rDNAttID: cn  
defaultSecurityDescriptor: D:(A;;RPWPCRCCDCLCLOLORCWOWDSDDTDTSW;;;DA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)  
governsId: 1.2.840.113556.1.5.287  
instanceType: 4  
objectClassCategory: 1  
schemaIdGuid:: zlULMc09kkOpbcnjU5fCTw==  
showInAdvancedViewOnly: TRUE  
defaultHidingValue: TRUE  
systemOnly: FALSE  
systemFlags: 16  
subClassOf: top  
systemPossSuperiors: 1.2.840.113556.1.3.23  
  
dn: CN=ms-DS-Device-Container,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: classSchema  
cn: ms-DS-Device-Container  
adminDisplayName: ms-DS-Device-Container  
adminDescription: A class for the container used to hold device objects.  
ldapDisplayName: msDS-DeviceContainer  
rDNAttID: cn  
defaultSecurityDescriptor: D:(A;;RPLCLORC;;;AU)(A;;RPWPCRCCDCLCLOLORCWOWDSDDTDTSW;;;DA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)  
governsId: 1.2.840.113556.1.5.289  
instanceType: 4  
objectClassCategory: 1  
schemaIdGuid:: WIyefBuQqE627E656fwOEQ==  
showInAdvancedViewOnly: TRUE  
defaultHidingValue: TRUE  
systemOnly: FALSE  
systemFlags: 16  
subClassOf: top  
systemPossSuperiors: 1.2.840.113556.1.5.67  
  
dn:  
changetype: modify  
add: schemaUpdateNow  
schemaUpdateNow: 1  
-  
  
dn: CN=ms-DS-Device-Registration-Service,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: classSchema  
cn: ms-DS-Device-Registration-Service  
adminDisplayName: ms-DS-Device-Registration-Service  
adminDescription: An object of this class holds the registration service configuration used for devices.  
ldapDisplayName: msDS-DeviceRegistrationService  
rDNAttID: cn  
defaultSecurityDescriptor: D:(A;;RPWPCRCCDCLCLOLORCWOWDSDDTDTSW;;;DA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)  
governsId: 1.2.840.113556.1.5.284  
instanceType: 4  
objectClassCategory: 1  
schemaIdGuid:: Gjq8ltLj00mvEXsN951n9Q==  
showInAdvancedViewOnly: TRUE  
defaultHidingValue: TRUE  
systemOnly: FALSE  
systemFlags: 16  
subClassOf: top  
systemPossSuperiors: 1.2.840.113556.1.5.287  
systemMayContain: 1.2.840.113556.1.4.2240  
systemMayContain: 1.2.840.113556.1.4.2241  
systemMayContain: 1.2.840.113556.1.4.2242  
  
dn: CN=ms-DS-Device,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: classSchema  
cn: ms-DS-Device  
adminDisplayName: ms-DS-Device  
adminDescription: An object of this type represents a registered device.  
ldapDisplayName: msDS-Device  
rDNAttID: cn  
defaultSecurityDescriptor: D:(A;;RPLCLORC;;;AU)(A;;RPWPCRCCDCLCLOLORCWOWDSDDTDTSW;;;DA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)  
governsId: 1.2.840.113556.1.5.286  
instanceType: 4  
objectClassCategory: 1  
schemaIdGuid:: c7byXUFtdEez6NUujun/mQ==  
showInAdvancedViewOnly: TRUE  
defaultHidingValue: TRUE  
systemOnly: FALSE  
systemFlags: 16  
subClassOf: top  
systemPossSuperiors: 1.2.840.113556.1.5.289  
systemMayContain: 1.2.840.113556.1.4.2248  
systemMayContain: 1.2.840.113556.1.4.2249  
systemMayContain: 1.2.840.113556.1.4.2250  
systemMayContain: 1.2.840.113556.1.4.2251  
systemMayContain: 1.2.840.113556.1.4.2252  
  
dn:  
changetype: modify  
add: schemaUpdateNow  
schemaUpdateNow: 1  
-  
  
dn: CN=Schema,CN=Configuration,DC=X  
changeType: ntdsSchemaModify  
replace: objectVersion  
objectVersion: 57  
-  
```  
  
### <a name="BKMK_Sch58"></a>Sch58.ldf  
  
```  
dn: CN=ms-DS-Resource-Property-List,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
replace: defaultHidingValue  
defaultHidingValue: FALSE  
-  
  
dn:  
changetype: modify  
add: schemaUpdateNow  
schemaUpdateNow: 1  
-  
  
dn: CN=Schema,CN=Configuration,DC=X  
changeType: ntdsSchemaModify  
replace: objectVersion  
objectVersion: 58  
-  
```  
  
### <a name="BKMK_Sch59"></a>Sch59.ldf  
  
```  
dn: CN=ms-DS-User-Device-Registration,CN=Schema,CN=Configuration,DC=X  
changeType: ntdsSchemaModify  
replace: isDefunct  
isDefunct: TRUE  
-  
  
dn: CN=ms-DS-User-Device-Registration-Container,CN=Schema,CN=Configuration,DC=X  
changeType: ntdsSchemaModify  
replace: isDefunct  
isDefunct: TRUE  
-  
  
dn: CN=ms-DS-Device,CN=Schema,CN=Configuration,DC=X  
changeType: ntdsSchemaModify  
delete: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2246  
-  
  
dn: CN=User,CN=Schema,CN=Configuration,DC=X  
changeType: ntdsSchemaModify  
delete: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2244  
-  
  
dn: CN=ms-DS-User-Device-Registration-Link,CN=Schema,CN=Configuration,DC=X  
changeType: ntdsSchemaModify  
replace: isDefunct  
isDefunct: TRUE  
-  
  
dn: CN=ms-DS-User-Device-Registration-Link-BL,CN=Schema,CN=Configuration,DC=X  
changeType: ntdsSchemaModify  
replace: isDefunct  
isDefunct: TRUE  
-  
  
dn: CN=ms-DS-Authentication-Level,CN=Schema,CN=Configuration,DC=X  
changeType: ntdsSchemaModify  
replace: isDefunct  
isDefunct: TRUE  
-  
  
dn: CN=ms-DS-Approximate-Last-Use-Time-Stamp,CN=Schema,CN=Configuration,DC=X  
changeType: ntdsSchemaModify  
replace: isDefunct  
isDefunct: TRUE  
-  
  
dn: CN=ms-DS-Device-Reference,CN=Schema,CN=Configuration,DC=X  
changeType: ntdsSchemaModify  
replace: isDefunct  
isDefunct: TRUE  
-  
  
dn: CN=ms-DS-Device-Location,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-Device-Location  
adminDisplayName: ms-DS-Device-Location  
adminDescription: The DN under which the device objects will be created.  
ldapDisplayName: msDS-DeviceLocation  
attributeId: 1.2.840.113556.1.4.2261  
omSyntax: 127  
omObjectClass:: KwwCh3McAIVK  
attributeSyntax: 2.5.5.1  
isSingleValued: TRUE  
instanceType: 4  
searchFlags: 0  
systemOnly: TRUE  
schemaIdGuid:: yFb74+hd9UWxsdK2zTHnYg==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-Registered-Owner,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-Registered-Owner  
adminDisplayName: ms-DS-Registered-Owner  
adminDescription: Single valued binary attribute containing the primary SID referencing the first user to register the device. The value is not removed during de-registration, but could be managed by an administrator.  
ldapDisplayName: msDS-RegisteredOwner  
attributeId: 1.2.840.113556.1.4.2258  
omSyntax: 4  
attributeSyntax: 2.5.5.10  
isSingleValued: TRUE  
instanceType: 4  
searchFlags: 1  
isMemberOfPartialAttributeSet: TRUE  
systemOnly: FALSE  
schemaIdGuid:: 6SZ2YesBz0KZH85heYIjfg==  
systemFlags: 18  
  
dn: CN=ms-DS-Registered-Users,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-Registered-Users  
adminDisplayName: ms-DS-Registered-Users  
adminDescription: Contains the list of users that have registered the device.  Users in this list have all of the features provided by the "Company Portal" app.  And they have SSO to company resources.  
ldapDisplayName: msDS-RegisteredUsers  
attributeId: 1.2.840.113556.1.4.2263  
omSyntax: 4  
attributeSyntax: 2.5.5.10  
isSingleValued: FALSE  
instanceType: 4  
searchFlags: 1  
isMemberOfPartialAttributeSet: TRUE  
systemOnly: FALSE  
schemaIdGuid:: DBZJBI5ayE+wUgHA9uSPAg==  
systemFlags: 18  
  
dn: CN=ms-DS-Approximate-Last-Logon-Time-Stamp,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-Approximate-Last-Logon-Time-Stamp  
adminDisplayName: ms-DS-Approximate-Last-Logon-Time-Stamp  
adminDescription: The approximate time a user last logged on with from the device.  
ldapDisplayName: msDS-ApproximateLastLogonTimeStamp  
attributeId: 1.2.840.113556.1.4.2262  
omSyntax: 65  
attributeSyntax: 2.5.5.16  
isSingleValued: TRUE  
instanceType: 4  
searchFlags: 1  
isMemberOfPartialAttributeSet: TRUE  
systemOnly: FALSE  
schemaIdGuid:: O5hPo8aEDE+QUKOhSh01pA==  
systemFlags: 16  
  
dn: CN=ms-DS-Device-Object-Version,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-Device-Object-Version  
adminDisplayName: ms-DS-Device-Object-Version  
adminDescription: This attribute is used to identify the schema version of the device.  
ldapDisplayName: msDS-DeviceObjectVersion  
attributeId: 1.2.840.113556.1.4.2257  
omSyntax: 2  
attributeSyntax: 2.5.5.9  
isSingleValued: TRUE  
instanceType: 4  
searchFlags: 1  
isMemberOfPartialAttributeSet: TRUE  
systemOnly: FALSE  
schemaIdGuid:: Wmll73nxak6T3rAeBmgc+w==  
systemFlags: 18  
  
dn: CN=ms-DS-Device-OS-Type,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
replace: isSingleValued  
isSingleValued: TRUE  
-  
  
dn: CN=ms-DS-Device-OS-Type,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
replace: searchFlags  
searchFlags: 1  
-  
  
dn: CN=ms-DS-Device-OS-Version,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
replace: isSingleValued  
isSingleValued: TRUE  
-  
  
dn: CN=ms-DS-Device-Physical-IDs,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
replace: omSyntax  
omSyntax: 64  
-  
  
dn: CN=ms-DS-Device-Physical-IDs,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
replace: attributeSyntax  
attributeSyntax: 2.5.5.12  
-  
  
dn: CN=ms-DS-Device-Physical-IDs,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
replace: rangeUpper  
rangeUpper: 1024  
-  
  
dn:  
changetype: modify  
add: schemaUpdateNow  
schemaUpdateNow: 1  
-  
  
dn: CN=ms-DS-Device-Registration-Service,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMustContain  
systemMustContain: 1.2.840.113556.1.4.2261  
-  
  
dn: CN=ms-DS-Device,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2257  
systemMayContain: 1.2.840.113556.1.4.2258  
systemMayContain: 1.2.840.113556.1.4.2262  
systemMayContain: 1.2.840.113556.1.4.2263  
-  
  
dn: CN=ms-DS-Device,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
delete: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2248  
-  
  
dn: CN=ms-DS-Device,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMustContain  
systemMustContain: 1.2.840.113556.1.4.2248  
systemMustContain: 1.2.840.113556.1.2.13  
systemMustContain: 1.2.840.113556.1.4.867  
-  
  
dn:  
changetype: modify  
add: schemaUpdateNow  
schemaUpdateNow: 1  
-  
  
dn: CN=Schema,CN=Configuration,DC=X  
changeType: ntdsSchemaModify  
replace: objectVersion  
objectVersion: 59  
-  
```  
  
### <a name="BKMK_Sch60"></a>Sch60.ldf  
  
```  
dn: CN=ms-DS-Is-Member-Of-DL-Transitive,CN=Schema,CN=Configuration,DC=X  
# This constructed attribute transitively expands the   
# linked attribute "isMemberOfDL"  
changetype: ntdsschemaadd  
objectClass: attributeSchema  
lDAPDisplayName: msds-memberOfTransitive  
adminDisplayName: msds-memberOfTransitive  
adminDescription: msds-memberOfTransitive  
attributeID: 1.2.840.113556.1.4.2236  
attributeSyntax: 2.5.5.1  
oMSyntax: 127  
oMObjectClass:: KwwCh3McAIVK  
isSingleValued: FALSE  
systemOnly: TRUE  
# 0x800(only return on base search)   
searchFlags: 2048  
showInAdvancedViewOnly: TRUE  
schemaIdGuid:: tmYhhkHJJ0eVZUi//ylB3g==  
# 0x10 (base schema) +  
# 0x08 (operational) +  
# 0x04 (constructed) +  
# 0x01 (not replicated)  
systemFlags: 29  
  
dn: CN=ms-DS-Member-Transitive,CN=Schema,CN=Configuration,DC=X  
# This constructed attribute transitively expands the   
# linked attribute "member"  
changetype: ntdsschemaadd  
objectClass: attributeSchema  
lDAPDisplayName: msds-memberTransitive  
adminDisplayName: msds-memberTransitive  
adminDescription: msds-memberTransitive  
attributeID: 1.2.840.113556.1.4.2238  
attributeSyntax: 2.5.5.1  
oMSyntax: 127  
oMObjectClass:: KwwCh3McAIVK  
isSingleValued: FALSE  
systemOnly: TRUE  
# 0x800(only return on base search)   
searchFlags: 2048  
showInAdvancedViewOnly: TRUE  
schemaIdGuid:: WzkV4gSR2US4lDmeyeId/A==  
# 0x10 (base schema) +  
# 0x08 (operational) +  
# 0x04 (constructed) +  
# 0x01 (not replicated)  
systemFlags: 29  
  
dn: CN=ms-DS-Parent-Dist-Name,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsschemaadd  
objectClass: attributeSchema  
lDAPDisplayName: msDS-parentdistname  
adminDisplayName: ms-DS-Parent-Dist-Name  
adminDescription: ms-DS-Parent-Dist-Name  
attributeID: 1.2.840.113556.1.4.2203  
attributeSyntax: 2.5.5.1  
oMSyntax: 127  
oMObjectClass:: KwwCh3McAIVK  
isSingleValued: TRUE  
systemOnly: TRUE  
searchFlags: 0  
schemaIDGUID:: ff4YuRqXBPSeIZJhq+yXCw==  
showInAdvancedViewOnly: TRUE  
# 0x10 (base schema) +   
# 0x08 (operational) +   
# 0x04 (constructed) +   
# 0x01 (not replicated)  
systemFlags: 29  
  
dn: CN=ms-DS-Repl-Value-Meta-Data-Ext,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-ReplValueMetaDataExt  
adminDisplayName: ms-DS-Repl-Value-Meta-Data-Ext  
adminDescription: ms-DS-Repl-Value-Meta-Data-Ext  
attributeId: 1.2.840.113556.1.4.2235  
attributeSyntax: 2.5.5.12  
omSyntax: 64  
isSingleValued: FALSE  
systemOnly: FALSE  
searchFlags: 0  
schemaIdGuid:: 79ICHq1EskamfZ/RjXgLyg==  
showInAdvancedViewOnly: TRUE  
# 0x10 (base schema) +   
# 0x04 (constructed)  
systemFlags: 20  
  
dn:  
changetype: modify  
add: schemaUpdateNow  
schemaUpdateNow: 1  
-  
  
dn: cn=Top,cn=Schema,cn=Configuration,dc=X  
changetype: ntdsschemamodify  
add: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2238  
systemMayContain: 1.2.840.113556.1.4.2236  
systemMayContain: 1.2.840.113556.1.4.2203  
systemMayContain: 1.2.840.113556.1.4.2235  
-  
  
dn: CN=DS-Set-Owner,CN=Extended-Rights,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: controlAccessRight  
displayName: Set Owner of an object during creation.  
rightsGuid: 4125c71f-7fac-4ff0-bcb7-f09a41325286  
appliesTo: 26f11b08-a29d-4869-99bb-ef0b99fd883e  
validAccesses: 256  
  
dn: CN=DS-Bypass-Quota,CN=Extended-Rights,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: controlAccessRight  
displayName: Bypass the quota restrictions during creation.  
rightsGuid: 88a9933e-e5c8-4f2a-9dd7-2527416b8092  
appliesTo: 26f11b08-a29d-4869-99bb-ef0b99fd883e  
validAccesses: 256  
  
dn: CN=DS-Read-Partition-Secrets,CN=Extended-Rights,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: controlAccessRight  
displayName: Read secret attributes of objects in a Partition  
rightsGuid: 084c93a2-620d-4879-a836-f0ae47de0e89  
appliesTo: 26f11b08-a29d-4869-99bb-ef0b99fd883e  
validAccesses: 256  
  
dn: CN=DS-Write-Partition-Secrets,CN=Extended-Rights,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: controlAccessRight  
displayName: Write secret attributes of objects in a Partition  
rightsGuid: 94825A8D-B171-4116-8146-1E34D8F54401  
appliesTo: 26f11b08-a29d-4869-99bb-ef0b99fd883e  
validAccesses: 256  
  
dn: CN=Schema,CN=Configuration,DC=X  
changeType: ntdsSchemaModify  
replace: objectVersion  
objectVersion: 60  
-  
```  
  
### <a name="BKMK_Sch61"></a>Sch61.ldf  
  
```  
dn: CN=ms-DS-Drs-Farm-ID,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-Drs-Farm-ID  
adminDisplayName: ms-DS-Drs-Farm-ID  
adminDescription: This attribute stores the name of the federation service this DRS object is associated with.  
ldapDisplayName: msDS-DrsFarmID  
attributeId: 1.2.840.113556.1.4.2265  
omSyntax: 64  
attributeSyntax: 2.5.5.12  
isSingleValued: TRUE  
instanceType: 4  
searchFlags: 0  
isMemberOfPartialAttributeSet: TRUE  
systemOnly: TRUE  
schemaIdGuid:: ZvdVYC4gzUmovuUrsVnt+w==  
systemFlags: 16  
  
dn:  
changetype: modify  
add: schemaUpdateNow  
schemaUpdateNow: 1  
-  
  
dn: CN=ms-DS-Device-Registration-Service,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMustContain  
systemMustContain: 1.2.840.113556.1.4.2248  
systemMustContain: 1.2.840.113556.1.4.2265  
-  
  
dn: CN=Schema,CN=Configuration,DC=X  
changeType: ntdsSchemaModify  
replace: objectVersion  
objectVersion: 61  
-  
  
dn:  
changetype: modify  
add: schemaUpdateNow  
schemaUpdateNow: 1  
-  
```  
  
### <a name="BKMK_Sch62"></a>Sch62.ldf  
  
```  
dn: CN=ms-DS-Issuer-Public-Certificates,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-Issuer-Public-Certificates  
adminDisplayName: ms-DS-Issuer-Public-Certificates  
adminDescription: The public keys  of the keys used to sign certificates issued by the Registration Service.  
ldapDisplayName: msDS-IssuerPublicCertificates  
attributeId: 1.2.840.113556.1.4.2269  
omSyntax: 4  
attributeSyntax: 2.5.5.10  
isSingleValued: FALSE  
instanceType: 4  
rangeLower: 1  
rangeUpper: 65536  
searchFlags: 0  
systemOnly: FALSE  
schemaIdGuid:: /u3xtdK0dkCrD2FINCsL9g==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn:  
changetype: modify  
add: schemaUpdateNow  
schemaUpdateNow: 1  
-  
  
dn: CN=ms-DS-Device-Registration-Service,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2269  
-  
  
dn:  
changetype: modify  
add: schemaUpdateNow  
schemaUpdateNow: 1  
-  
  
dn: CN=Schema,CN=Configuration,DC=X  
changeType: ntdsSchemaModify  
replace: objectVersion  
objectVersion: 62  
-  
  
```  
  
### <a name="BKMK_Sch63"></a>Sch63.ldf  
  
```  
dn: CN=ms-DS-Issuer-Certificates,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
replace: searchFlags  
searchFlags: 128  
-  
  
dn: CN=ms-DS-Device-Registration-Service,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
replace: defaultSecurityDescriptor  
defaultSecurityDescriptor: D:(A;;RPLCLORC;;;AU)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;DA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)  
-  
  
dn: CN=ms-DS-Device-Registration-Service-Container,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
replace: defaultSecurityDescriptor  
defaultSecurityDescriptor: D:(A;;RPLCLORC;;;AU)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;DA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)  
-  
  
dn:  
changetype: modify  
add: schemaUpdateNow  
schemaUpdateNow: 1  
-  
  
dn: CN=Schema,CN=Configuration,DC=X  
changeType: ntdsSchemaModify  
replace: objectVersion  
objectVersion: 63  
-  
  
```  
  
### <a name="BKMK_Sch64"></a>Sch64.ldf  
  
```  
dn: CN=ms-DS-Device-Registration-Service,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
replace: defaultSecurityDescriptor  
defaultSecurityDescriptor: D:(A;;RPLCLORC;;;AU)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;EA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)  
-  
  
dn: CN=ms-DS-Device-Registration-Service-Container,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
replace: defaultSecurityDescriptor  
defaultSecurityDescriptor: D:(A;;RPLCLORC;;;AU)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;EA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)  
-  
  
dn: CN=ms-DS-Device,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
delete: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2252  
-  
  
dn: CN=ms-DS-Device,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMustContain  
systemMustContain: 1.2.840.113556.1.4.2252  
-  
  
dn:  
changetype: modify  
add: schemaUpdateNow  
schemaUpdateNow: 1  
-  
  
dn: CN=Schema,CN=Configuration,DC=X  
changeType: ntdsSchemaModify  
replace: objectVersion  
objectVersion: 64  
-  
```  
  
### <a name="BKMK_Sch65"></a>Sch65.ldf  
  
```  
dn: CN=ms-DS-Registration-Quota,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: showInAdvancedViewOnly  
showInAdvancedViewOnly: TRUE  
-  
  
dn: CN=ms-DS-Maximum-Registration-Inactivity-Period,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: showInAdvancedViewOnly  
showInAdvancedViewOnly: TRUE  
-  
  
dn: CN=ms-DS-Registered-Owner,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: showInAdvancedViewOnly  
showInAdvancedViewOnly: TRUE  
-  
  
dn: CN=ms-DS-Registered-Users,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: showInAdvancedViewOnly  
showInAdvancedViewOnly: TRUE  
-  
  
dn: CN=ms-DS-Approximate-Last-Logon-Time-Stamp,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: showInAdvancedViewOnly  
showInAdvancedViewOnly: TRUE  
-  
  
dn: CN=ms-DS-Is-Enabled,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: showInAdvancedViewOnly  
showInAdvancedViewOnly: TRUE  
-  
  
dn: CN=ms-DS-Device-OS-Type,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: showInAdvancedViewOnly  
showInAdvancedViewOnly: TRUE  
-  
  
dn: CN=ms-DS-Device-OS-Version,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: showInAdvancedViewOnly  
showInAdvancedViewOnly: TRUE  
-  
  
dn: CN=ms-DS-Device-Physical-IDs,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: showInAdvancedViewOnly  
showInAdvancedViewOnly: TRUE  
-  
  
dn: CN=ms-DS-Device-ID,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: showInAdvancedViewOnly  
showInAdvancedViewOnly: TRUE  
-  
  
dn: CN=ms-DS-Device-Object-Version,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: showInAdvancedViewOnly  
showInAdvancedViewOnly: TRUE  
-  
  
dn: CN=ms-DS-Drs-Farm-ID,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: showInAdvancedViewOnly  
showInAdvancedViewOnly: TRUE  
-  
  
dn: CN=ms-DS-IsManaged,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-IsManaged  
adminDisplayName: ms-DS-IsManaged  
adminDescription: This attribute is used to indicate the device is managed by a on-premises MDM.  
ldapDisplayName: msDS-IsManaged  
attributeId: 1.2.840.113556.1.4.2270  
omSyntax: 1  
attributeSyntax: 2.5.5.8  
isSingleValued: TRUE  
instanceType: 4  
searchFlags: 1  
systemOnly: FALSE  
schemaIdGuid:: zmpoYCds3kOk5fAML40zCQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-Cloud-IsManaged,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-Cloud-IsManaged  
adminDisplayName: ms-DS-Cloud-IsManaged  
adminDescription: This attribute is used to indicate the device is managed by a cloud MDM.  
ldapDisplayName: msDS-CloudIsManaged  
attributeId: 1.2.840.113556.1.4.2271  
omSyntax: 1  
attributeSyntax: 2.5.5.8  
isSingleValued: TRUE  
instanceType: 4  
searchFlags: 1  
systemOnly: FALSE  
schemaIdGuid:: jroVU4+VUku9OBNJowTdYw==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-Cloud-Anchor,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-Cloud-Anchor  
adminDisplayName: ms-DS-Cloud-Anchor  
adminDescription: This attribute is used by the DirSync engine to indicate the object SOA and to maintain the relationship between the on-premises and cloud object.  
ldapDisplayName: msDS-CloudAnchor  
attributeId: 1.2.840.113556.1.4.2273  
omSyntax: 4  
attributeSyntax: 2.5.5.10  
isSingleValued: TRUE  
instanceType: 4  
searchFlags: 0  
systemOnly: FALSE  
schemaIdGuid:: gF5WeNQD40+vrIw7yi82Uw==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-Cloud-Issuer-Public-Certificates,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-Cloud-Issuer-Public-Certificates  
adminDisplayName: ms-DS-Cloud-Issuer-Public-Certificates  
adminDescription: The public keys used by the cloud DRS to sign certificates issued by the Registration Service.  
ldapDisplayName: msDS-CloudIssuerPublicCertificates  
attributeId: 1.2.840.113556.1.4.2274  
omSyntax: 4  
attributeSyntax: 2.5.5.10  
isSingleValued: FALSE  
instanceType: 4  
rangeLower: 1  
rangeUpper: 65536  
searchFlags: 0  
systemOnly: FALSE  
schemaIdGuid:: T7XoodZL0k+Y4rzukqVUlw==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-Cloud-IsEnabled,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-Cloud-IsEnabled  
adminDisplayName: ms-DS-Cloud-IsEnabled  
adminDescription: This attribute is used to indicate whether cloud DRS is enabled.  
ldapDisplayName: msDS-CloudIsEnabled  
attributeId: 1.2.840.113556.1.4.2275  
omSyntax: 1  
attributeSyntax: 2.5.5.8  
isSingleValued: TRUE  
instanceType: 4  
searchFlags: 0  
systemOnly: FALSE  
schemaIdGuid:: KIOEiU58b0+gEyjOOtKC3A==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn:  
changetype: modify  
add: schemaUpdateNow  
schemaUpdateNow: 1  
-  
  
dn: CN=ms-DS-Device,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2270  
systemMayContain: 1.2.840.113556.1.4.2271  
systemMayContain: 1.2.840.113556.1.4.2273  
-  
  
dn: CN=ms-DS-Device-Registration-Service,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2274  
systemMayContain: 1.2.840.113556.1.4.2275  
-  
  
dn:  
changetype: modify  
add: schemaUpdateNow  
schemaUpdateNow: 1  
-  
  
dn: CN=Schema,CN=Configuration,DC=X  
changeType: ntdsSchemaModify  
replace: objectVersion  
objectVersion: 65  
-  
```  
  
### <a name="BKMK_Sch66"></a>Sch66.ldf  
  
```  
dn: CN=ms-DS-SyncServerUrl,CN=Schema,CN=Configuration,DC=X  
changeType: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-SyncServerUrl  
ldapDisplayName: msDS-SyncServerUrl  
adminDisplayName: ms-DS-SyncServerUrl  
adminDescription: Use this attribute to store the sync server (Url format) which hosts the user sync folder  
AttributeID: 1.2.840.113556.1.4.2276  
attributeSyntax: 2.5.5.12  
omSyntax: 64  
isSingleValued: FALSE  
SystemOnly: FALSE  
searchFlags: 1  
rangeLower: 1  
rangeUpper: 512  
schemaIdGuid:: 0sOst3QqpE+sJeY/6LYSGA==  
showInAdvancedViewOnly: FALSE  
systemFlags: 16  
  
dn:  
changetype: modify  
add: schemaUpdateNow  
schemaUpdateNow: 1  
-  
  
dn: CN=User,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2276  
-  
  
dn: CN=Schema,CN=Configuration,DC=X  
changeType: ntdsSchemaModify  
replace: objectVersion  
objectVersion: 66  
-  
  
dn:  
changetype: modify  
add: schemaUpdateNow  
schemaUpdateNow: 1  
-  
```  
  
### <a name="BKMK_Sch67"></a>Sch67.ldf  
  
```  
dn: CN=ms-DS-Device-Registration-Service,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
delete: systemMustContain  
systemMustContain: 1.2.840.113556.1.4.2265  
-  
  
dn:  
changetype: modify  
add: schemaUpdateNow  
schemaUpdateNow: 1  
-  
  
dn: CN=ms-DS-Drs-Farm-ID,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: isDefunct  
isDefunct: TRUE  
-  
  
dn: CN=Schema,CN=Configuration,DC=X  
changeType: ntdsSchemaModify  
replace: objectVersion  
objectVersion: 67  
-  
  
dn:  
changetype: modify  
add: schemaUpdateNow  
schemaUpdateNow: 1  
-  
```  
  
### <a name="BKMK_Sch68"></a>Sch68.ldf  
  
```  
dn: CN=ms-DS-User-Allowed-To-Authenticate-To,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-UserAllowedToAuthenticateTo  
adminDisplayName: ms-DS-User-Allowed-To-Authenticate-To  
adminDescription: This attribute is used to determine if a user has permission to authenticate to a service.  
attributeId: 1.2.840.113556.1.4.2277  
attributeSyntax: 2.5.5.10  
omSyntax: 4  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
schemaIdGuid:: f6oM3k5yhkKxeRkmce/GZA==  
systemFlags: 16  
RangeLower: 0  
RangeUpper: 132096  
instanceType: 4  
  
dn: CN=ms-DS-User-Allowed-To-Authenticate-From,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-UserAllowedToAuthenticateFrom  
adminDisplayName: ms-DS-User-Allowed-To-Authenticate-From  
adminDescription: This attribute is used to determine if a user has permission to authenticate from a computer.  
attributeId: 1.2.840.113556.1.4.2278  
attributeSyntax: 2.5.5.10  
omSyntax: 4  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
schemaIdGuid:: AJZMLOGwfUSN2nSQIle9tQ==  
systemFlags: 16  
RangeLower: 0  
RangeUpper: 132096  
instanceType: 4  
  
dn: CN=ms-DS-User-TGT-Lifetime,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-UserTGTLifetime  
adminDisplayName: User TGT Lifetime  
adminDescription: This attribute specifies the maximum age of a Kerberos TGT issued to a user in units of 10^(-7) seconds.  
attributeId: 1.2.840.113556.1.4.2279  
attributeSyntax: 2.5.5.16  
omSyntax: 65  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
schemaIdGuid:: g8khhZn1D0K5q7EiK9+VwQ==  
systemFlags: 16  
instanceType: 4  
  
dn: CN=ms-DS-Computer-Allowed-To-Authenticate-To,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-ComputerAllowedToAuthenticateTo  
adminDisplayName: ms-DS-Computer-Allowed-To-Authenticate-To  
adminDescription: This attribute is used to determine if a computer has permission to authenticate to a service.  
attributeId: 1.2.840.113556.1.4.2280  
attributeSyntax: 2.5.5.10  
omSyntax: 4  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
schemaIdGuid:: 6atbEH4Hk0e5dO8EELYlcw==  
systemFlags: 16  
RangeLower: 0  
RangeUpper: 132096  
instanceType: 4  
  
dn: CN=ms-DS-Computer-TGT-Lifetime,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-ComputerTGTLifetime  
adminDisplayName: Computer TGT Lifetime  
adminDescription: This attribute specifies the maximum age of a Kerberos TGT issued to a computer in units of 10^(-7) seconds.  
attributeId: 1.2.840.113556.1.4.2281  
attributeSyntax: 2.5.5.16  
omSyntax: 65  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
schemaIdGuid:: JHWTLrnfrEykNqW32mT9Zg==  
systemFlags: 16  
instanceType: 4  
  
dn: CN=ms-DS-Service-Allowed-To-Authenticate-To,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-ServiceAllowedToAuthenticateTo  
adminDisplayName: ms-DS-Service-Allowed-To-Authenticate-To  
adminDescription: This attribute is used to determine if a service has permission to authenticate to a service.  
attributeId: 1.2.840.113556.1.4.2282  
attributeSyntax: 2.5.5.10  
omSyntax: 4  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
schemaIdGuid:: MTGX8k2bIEi03gR07zuEnw==  
systemFlags: 16  
RangeLower: 0  
RangeUpper: 132096  
instanceType: 4  
  
dn: CN=ms-DS-Service-Allowed-To-Authenticate-From,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-ServiceAllowedToAuthenticateFrom  
adminDisplayName: ms-DS-Service-Allowed-To-Authenticate-From  
adminDescription: This attribute is used to determine if a service has permission to authenticate from a computer.  
attributeId: 1.2.840.113556.1.4.2283  
attributeSyntax: 2.5.5.10  
omSyntax: 4  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
schemaIdGuid:: mnDalxY3Zkmx0YOLpTw9iQ==  
systemFlags: 16  
RangeLower: 0  
RangeUpper: 132096  
instanceType: 4  
  
dn: CN=ms-DS-Service-TGT-Lifetime,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-ServiceTGTLifetime  
adminDisplayName: Service TGT Lifetime  
adminDescription: This attribute specifies the maximum age of a Kerberos TGT issued to a service in units of 10^(-7) seconds.  
attributeId: 1.2.840.113556.1.4.2284  
attributeSyntax: 2.5.5.16  
omSyntax: 65  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
schemaIdGuid:: IDz+XSnKfUCbq4Qh5V63XA==  
systemFlags: 16  
instanceType: 4  
  
dn: CN=ms-DS-Assigned-AuthN-Policy-Silo,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-AssignedAuthNPolicySilo  
adminDisplayName: Assigned Authentication Policy Silo  
adminDescription: This attribute specifies which AuthNPolicySilo a principal is assigned to.  
attributeId: 1.2.840.113556.1.4.2285  
attributeSyntax: 2.5.5.1  
omObjectClass:: KwwCh3McAIVK  
omSyntax: 127  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
schemaIdGuid:: QcE/svUN6kqzPWz0kwd7Pw==  
systemFlags: 16  
instanceType: 4  
linkID: 2202  
  
dn: CN=ms-DS-Assigned-AuthN-Policy-Silo-BL,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-AssignedAuthNPolicySiloBL  
adminDisplayName: Assigned Authentication Policy Silo Backlink  
adminDescription: This attribute is the backlink for msDS-AssignedAuthNPolicySilo.  
attributeId: 1.2.840.113556.1.4.2286  
attributeSyntax: 2.5.5.1  
omObjectClass:: KwwCh3McAIVK  
omSyntax: 127  
isSingleValued: FALSE  
systemOnly: TRUE  
searchFlags: 0  
schemaIdGuid:: FAUUM3r10keOxATEZmYAxw==  
systemFlags: 16  
instanceType: 4  
linkID: 2203  
  
dn: CN=ms-DS-AuthN-Policy-Silo-Members,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-AuthNPolicySiloMembers  
adminDisplayName: Authentication Policy Silo Members  
adminDescription: This attribute specifies which principals are assigned to the AuthNPolicySilo.  
attributeId: 1.2.840.113556.1.4.2287  
attributeSyntax: 2.5.5.1  
omObjectClass:: KwwCh3McAIVK  
omSyntax: 127  
isSingleValued: FALSE  
systemOnly: FALSE  
searchFlags: 0  
schemaIdGuid:: BR5NFqZIhkio6XeiAG48dw==  
systemFlags: 16  
instanceType: 4  
linkID: 2204  
  
dn: CN=ms-DS-AuthN-Policy-Silo-Members-BL,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-AuthNPolicySiloMembersBL  
adminDisplayName: Authentication Policy Silo Members Backlink  
adminDescription: This attribute is the backlink for msDS-AuthNPolicySiloMembers.  
attributeId: 1.2.840.113556.1.4.2288  
attributeSyntax: 2.5.5.1  
omObjectClass:: KwwCh3McAIVK  
omSyntax: 127  
isSingleValued: FALSE  
systemOnly: TRUE  
searchFlags: 0  
schemaIdGuid:: x8v8EeT7UUm0t63fb579RA==  
systemFlags: 16  
instanceType: 4  
linkID: 2205  
  
dn: CN=ms-DS-User-AuthN-Policy,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-UserAuthNPolicy  
adminDisplayName: User Authentication Policy  
adminDescription: This attribute specifies which AuthNPolicy should be applied to users assigned to this silo object.  
attributeId: 1.2.840.113556.1.4.2289  
attributeSyntax: 2.5.5.1  
omObjectClass:: KwwCh3McAIVK  
omSyntax: 127  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
schemaIdGuid:: 87kmzRXUKkSPeHxhUj7pWw==  
systemFlags: 16  
instanceType: 4  
linkID: 2206  
  
dn: CN=ms-DS-User-AuthN-Policy-BL,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-UserAuthNPolicyBL  
adminDisplayName: User Authentication Policy Backlink  
adminDescription: This attribute is the backlink for msDS-UserAuthNPolicy.  
attributeId: 1.2.840.113556.1.4.2290  
attributeSyntax: 2.5.5.1  
omObjectClass:: KwwCh3McAIVK  
omSyntax: 127  
isSingleValued: FALSE  
systemOnly: TRUE  
searchFlags: 0  
schemaIdGuid:: qfoXL0ddH0uXfqpS+r5lyA==  
systemFlags: 16  
instanceType: 4  
linkID: 2207  
  
dn: CN=ms-DS-Computer-AuthN-Policy,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-ComputerAuthNPolicy  
adminDisplayName: Computer Authentication Policy  
adminDescription: This attribute specifies which AuthNPolicy should be applied to computers assigned to this silo object.  
attributeId: 1.2.840.113556.1.4.2291  
attributeSyntax: 2.5.5.1  
omObjectClass:: KwwCh3McAIVK  
omSyntax: 127  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
schemaIdGuid:: yWO4r6O+D0Sp82FTzGaJKQ==  
systemFlags: 16  
instanceType: 4  
linkID: 2208  
  
dn: CN=ms-DS-Computer-AuthN-Policy-BL,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-ComputerAuthNPolicyBL  
adminDisplayName: Computer Authentication Policy Backlink  
adminDescription: This attribute is the backlink for msDS-ComputerAuthNPolicy.  
attributeId: 1.2.840.113556.1.4.2292  
attributeSyntax: 2.5.5.1  
omObjectClass:: KwwCh3McAIVK  
omSyntax: 127  
isSingleValued: FALSE  
systemOnly: TRUE  
searchFlags: 0  
schemaIdGuid:: MmLvK6EwfkWGBHr22/ExuA==  
systemFlags: 16  
instanceType: 4  
linkID: 2209  
  
dn: CN=ms-DS-Service-AuthN-Policy,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-ServiceAuthNPolicy  
adminDisplayName: Service Authentication Policy  
adminDescription: This attribute specifies which AuthNPolicy should be applied to services assigned to this silo object.  
attributeId: 1.2.840.113556.1.4.2293  
attributeSyntax: 2.5.5.1  
omObjectClass:: KwwCh3McAIVK  
omSyntax: 127  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
schemaIdGuid:: lW1qKs4o7km7JG0fwB4xEQ==  
systemFlags: 16  
instanceType: 4  
linkID: 2210  
  
dn: CN=ms-DS-Service-AuthN-Policy-BL,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-ServiceAuthNPolicyBL  
adminDisplayName: Service Authentication Policy Backlink  
adminDescription: This attribute is the backlink for msDS-ServiceAuthNPolicy.  
attributeId: 1.2.840.113556.1.4.2294  
attributeSyntax: 2.5.5.1  
omObjectClass:: KwwCh3McAIVK  
omSyntax: 127  
isSingleValued: FALSE  
systemOnly: TRUE  
searchFlags: 0  
schemaIdGuid:: 7CgRLKJao0KzLfCXnKn80g==  
systemFlags: 16  
instanceType: 4  
linkID: 2211  
  
dn: CN=ms-DS-Assigned-AuthN-Policy,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-AssignedAuthNPolicy  
adminDisplayName: Assigned Authentication Policy  
adminDescription: This attribute specifies which AuthNPolicy should be applied to this principal.  
attributeId: 1.2.840.113556.1.4.2295  
attributeSyntax: 2.5.5.1  
omObjectClass:: KwwCh3McAIVK  
omSyntax: 127  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
schemaIdGuid:: 2Ap6uPdUwUmEoOZNEoU1iA==  
systemFlags: 16  
instanceType: 4  
linkID: 2212  
  
dn: CN=ms-DS-Assigned-AuthN-Policy-BL,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-AssignedAuthNPolicyBL  
adminDisplayName: Assigned Authentication Policy Backlink  
adminDescription: This attribute is the backlink for msDS-AssignedAuthNPolicy.  
attributeId: 1.2.840.113556.1.4.2296  
attributeSyntax: 2.5.5.1  
omObjectClass:: KwwCh3McAIVK  
omSyntax: 127  
isSingleValued: FALSE  
systemOnly: TRUE  
searchFlags: 0  
schemaIdGuid:: PBsTLZ/T7kqBXo20vBznrA==  
systemFlags: 16  
instanceType: 4  
linkID: 2213  
  
dn: CN=ms-DS-AuthN-Policy-Enforced,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-AuthNPolicyEnforced  
adminDisplayName: Authentication Policy Enforced  
adminDescription: This attribute specifies whether the authentication policy is enforced.  
attributeId: 1.2.840.113556.1.4.2297  
attributeSyntax: 2.5.5.8  
omSyntax: 1  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
schemaIdGuid:: wgxWekXsukSy1yEjatWf1Q==  
instanceType: 4  
systemFlags: 16  
  
dn: CN=ms-DS-AuthN-Policy-Silo-Enforced,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-AuthNPolicySiloEnforced  
adminDisplayName: Authentication Policy Silo Enforced  
adminDescription: This attribute specifies whether the authentication policy silo is enforced.  
attributeId: 1.2.840.113556.1.4.2298  
attributeSyntax: 2.5.5.8  
omSyntax: 1  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
schemaIdGuid:: AhH18uBrPUmHJhVGzbyHcQ==  
instanceType: 4  
systemFlags: 16  
  
dn: CN=ms-DS-AuthN-Policy-Silos,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: classSchema  
ldapDisplayName: msDS-AuthNPolicySilos  
adminDisplayName: Authentication Policy Silos  
adminDescription: A container of this class can contain authentication policy silo objects.  
governsId: 1.2.840.113556.1.5.291  
objectClassCategory: 1  
rdnAttId: cn  
schemaIdGuid:: Ckex0oSPHkmnUrQB7gD+XA==  
defaultSecurityDescriptor: D:(A;;RPWPCRCCDCLCLOLORCWOWDSDDTDTSW;;;EA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)(A;;RPLCLORC;;;AU)  
showInAdvancedViewOnly: TRUE  
defaultHidingValue: TRUE  
systemOnly: FALSE  
defaultObjectCategory: CN=ms-DS-AuthN-Policy-Silos,CN=Schema,CN=Configuration,DC=X  
instanceType: 4  
systemFlags: 16  
subClassOf: top  
systemPossSuperiors: 1.2.840.113556.1.3.23  
  
dn: CN=ms-DS-AuthN-Policies,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: classSchema  
ldapDisplayName: msDS-AuthNPolicies  
adminDisplayName: Authentication Policies  
adminDescription: A container of this class can contain authentication policy objects.  
governsId: 1.2.840.113556.1.5.293  
objectClassCategory: 1  
rdnAttId: cn  
schemaIdGuid:: Xd+aOpd7fk+rtOW1XBwGtA==  
defaultSecurityDescriptor: D:(A;;RPWPCRCCDCLCLOLORCWOWDSDDTDTSW;;;EA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)(A;;RPLCLORC;;;AU)  
showInAdvancedViewOnly: TRUE  
defaultHidingValue: TRUE  
systemOnly: FALSE  
defaultObjectCategory: CN=ms-DS-AuthN-Policies,CN=Schema,CN=Configuration,DC=X  
instanceType: 4  
systemFlags: 16  
subClassOf: top  
systemPossSuperiors: 1.2.840.113556.1.3.23  
  
dn:  
changetype: modify  
add: schemaUpdateNow  
schemaUpdateNow: 1  
-  
  
dn: CN=ms-DS-AuthN-Policy-Silo,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: classSchema  
ldapDisplayName: msDS-AuthNPolicySilo  
adminDisplayName: Authentication Policy Silo  
adminDescription: An instance of this class defines authentication policies and related behaviors for assigned users, computers, and services.  
governsId: 1.2.840.113556.1.5.292  
objectClassCategory: 1  
rdnAttId: cn  
schemaIdGuid:: Hkbw+X1piUaSmTfmHWF7DQ==  
defaultSecurityDescriptor: D:(A;;RPWPCRCCDCLCLOLORCWOWDSDDTDTSW;;;EA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)(A;;RPLCLORC;;;AU)  
systemOnly: FALSE  
defaultObjectCategory: CN=ms-DS-AuthN-Policy-Silo,CN=Schema,CN=Configuration,DC=X  
systemFlags: 16  
instanceType: 4  
systemmaycontain: msDS-AuthNPolicySiloMembers  
systemmaycontain: msDS-UserAuthNPolicy  
systemmaycontain: msDS-ComputerAuthNPolicy  
systemmaycontain: msDS-ServiceAuthNPolicy  
systemmaycontain: msDS-AssignedAuthNPolicySiloBL  
systemmaycontain: msDS-AuthNPolicySiloEnforced  
subClassOf: top  
systemPossSuperiors: msDS-AuthNPolicySilos  
  
dn: CN=ms-DS-AuthN-Policy,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: classSchema  
ldapDisplayName: msDS-AuthNPolicy  
adminDisplayName: Authentication Policy  
adminDescription: An instance of this class defines authentication policy behaviors for assigned principals.  
governsId: 1.2.840.113556.1.5.294  
objectClassCategory: 1  
rdnAttId: cn  
schemaIdGuid:: VhFqq8dN9UCRgI5M5C/lzQ==  
defaultSecurityDescriptor: D:(A;;RPWPCRCCDCLCLOLORCWOWDSDDTDTSW;;;EA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)(A;;RPLCLORC;;;AU)  
systemOnly: FALSE  
defaultObjectCategory: CN=ms-DS-AuthN-Policy,CN=Schema,CN=Configuration,DC=X  
systemFlags: 16  
instanceType: 4  
systemmaycontain: msDS-UserAllowedToAuthenticateTo  
systemmaycontain: msDS-UserAllowedToAuthenticateFrom  
systemmaycontain: msDS-UserTGTLifetime  
systemmaycontain: msDS-ComputerAllowedToAuthenticateTo  
systemmaycontain: msDS-ComputerTGTLifetime  
systemmaycontain: msDS-ServiceAllowedToAuthenticateTo  
systemmaycontain: msDS-ServiceAllowedToAuthenticateFrom  
systemmaycontain: msDS-ServiceTGTLifetime  
systemmaycontain: msDS-UserAuthNPolicyBL  
systemmaycontain: msDS-ComputerAuthNPolicyBL  
systemmaycontain: msDS-ServiceAuthNPolicyBL  
systemmaycontain: msDS-AssignedAuthNPolicyBL  
systemmaycontain: msDS-AuthNPolicyEnforced  
subClassOf: top  
systemPossSuperiors: msDS-AuthNPolicies  
  
dn: CN=user,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add:  systemmaycontain  
systemmaycontain: msDS-AssignedAuthNPolicy  
systemmaycontain: msDS-AssignedAuthNPolicySilo  
systemmaycontain: msDS-AuthNPolicySiloMembersBL  
-  
  
dn: CN=Schema,CN=Configuration,DC=X  
changeType: ntdsSchemaModify  
replace: objectVersion  
objectVersion: 68  
-  
  
dn:  
changetype: modify  
add: schemaUpdateNow  
schemaUpdateNow: 1  
-  
```  
  
### <a name="BKMK_Sch69"></a>Sch69.ldf  
  
```  
dn: CN=ms-DS-AuthN-Policy-Silo,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: defaultHidingValue  
defaultHidingValue: FALSE  
-  
  
dn: CN=ms-DS-AuthN-Policy,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: defaultHidingValue  
defaultHidingValue: FALSE  
-  
  
dn: CN=Schema,CN=Configuration,DC=X  
changeType: ntdsSchemaModify  
replace: objectVersion  
objectVersion: 69  
-  
  
dn:  
changetype: modify  
add: schemaUpdateNow  
schemaUpdateNow: 1  
-  
```  
  
## <a name="BKMK_SchemaUpdates2012"></a>Schema Updates in Windows Server 2012  
  
### <a name="BKMK_Sch48"></a>Sch48.ldf  
  
```  
dn: CN=ms-DS-Members-Of-Resource-Property-List,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-MembersOfResourcePropertyList  
adminDisplayName: ms-DS-Members-Of-Resource-Property-List  
adminDescription: For a resource property list object, this multi-valued link attribute points to one or more resource property objects.  
attributeId: 1.2.840.113556.1.4.2103  
attributeSyntax: 2.5.5.1  
omSyntax: 127  
isSingleValued: FALSE  
systemOnly: FALSE  
searchFlags: 0  
omObjectClass:: KwwCh3McAIVK  
schemaIdGuid:: ERw3Ta1MQUyK0rGAqyvRPA==  
linkID: 2180  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-Members-Of-Resource-Property-List-BL,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-MembersOfResourcePropertyListBL  
adminDisplayName: ms-DS-Members-Of-Resource-Property-List-BL  
adminDescription: Backlink for ms-DS-Members-Of-Resource-Property-List. For a resource property object, this attribute references the resource property list object that it is a member of.  
attributeId: 1.2.840.113556.1.4.2104  
attributeSyntax: 2.5.5.1  
omSyntax: 127  
isSingleValued: FALSE  
systemOnly: FALSE  
searchFlags: 0  
omObjectClass:: KwwCh3McAIVK  
schemaIdGuid:: BLdpdLDtaEWlpVn0hix1pw==  
linkID: 2181  
showInAdvancedViewOnly: TRUE  
systemFlags: 17  
  
dn: CN=ms-DS-Claim-Value-Type,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-ClaimValueType  
adminDisplayName: ms-DS-Claim-Value-Type  
adminDescription: For a claim type object, specifies the value type of the claims issued.  
attributeId: 1.2.840.113556.1.4.2098  
attributeSyntax: 2.5.5.16  
omSyntax: 65  
isSingleValued: TRUE  
systemOnly: TRUE  
searchFlags: 0  
schemaIdGuid:: uRdixo7k90e31WVSuK/WGQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-Claim-Possible-Values,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-ClaimPossibleValues  
adminDisplayName: ms-DS-Claim-Possible-Values  
adminDescription: For a claim type or resource property object, this attribute describes the values suggested to a user when the he/she use the claim type or resource property in applications.  
attributeId: 1.2.840.113556.1.4.2097  
attributeSyntax: 2.5.5.12  
omSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
rangeUpper: 1048576  
schemaIdGuid:: 7u0oLnztP0Wv5JO9hvIXTw==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-Claim-Attribute-Source,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-ClaimAttributeSource  
adminDisplayName: ms-DS-Claim-Attribute-Source  
adminDescription: For a claim type object, this attribute points to the attribute that will be used as the source for the claim type.  
attributeId: 1.2.840.113556.1.4.2099  
attributeSyntax: 2.5.5.1  
omSyntax: 127  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
omObjectClass:: KwwCh3McAIVK  
schemaIdGuid:: PhK87ua6ZkGeWymISot2sA==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-Claim-Type-Applies-To-Class,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-ClaimTypeAppliesToClass  
adminDisplayName: ms-DS-Claim-Type-Applies-To-Class  
adminDescription: For a claim type object, this linked attribute points to the AD security principal classes that for which claims should be issued. (For example, a link to the user class).  
attributeId: 1.2.840.113556.1.4.2100  
attributeSyntax: 2.5.5.1  
omSyntax: 127  
isSingleValued: FALSE  
systemOnly: FALSE  
searchFlags: 0  
omObjectClass:: KwwCh3McAIVK  
schemaIdGuid:: TA77anbYfEOutsPkFFTCcg==  
linkID: 2176  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-Claim-Shares-Possible-Values-With,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-ClaimSharesPossibleValuesWith  
adminDisplayName: ms-DS-Claim-Shares-Possible-Values-With  
adminDescription: For a resource property object, this attribute indicates that the suggested values of the claims issued are defined on the object that this linked attribute points to. Overrides ms-DS-Claim-Possible-Values on itself, if populated.  
attributeId: 1.2.840.113556.1.4.2101  
attributeSyntax: 2.5.5.1  
omSyntax: 127  
isSingleValued: FALSE  
systemOnly: FALSE  
searchFlags: 0  
omObjectClass:: KwwCh3McAIVK  
schemaIdGuid:: OtHIUgvOV0+JKxj1pDokAA==  
linkID: 2178  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-Claim-Shares-Possible-Values-With-BL,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-ClaimSharesPossibleValuesWithBL  
adminDisplayName: ms-DS-Claim-Shares-Possible-Values-With-BL  
adminDescription: For a claim type object, this attribute indicates that the possible values described in ms-DS-Claim-Possible-Values are being referenced by other claim type objects.  
attributeId: 1.2.840.113556.1.4.2102  
attributeSyntax: 2.5.5.1  
omSyntax: 127  
isSingleValued: FALSE  
systemOnly: FALSE  
searchFlags: 0  
omObjectClass:: KwwCh3McAIVK  
schemaIdGuid:: 2yLVVJXs9UibvRiA67shgA==  
linkID: 2179  
showInAdvancedViewOnly: TRUE  
systemFlags: 17  
  
dn: CN=ms-DS-Is-Used-As-Resource-Security-Attribute,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-IsUsedAsResourceSecurityAttribute  
adminDisplayName: ms-DS-Is-Used-As-Resource-Security-Attribute  
adminDescription: For a resource property, this attribute indicates whether it is being used as a secure attribute.  
attributeId: 1.2.840.113556.1.4.2095  
attributeSyntax: 2.5.5.8  
omSyntax: 1  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
schemaIdGuid:: nfjJUTBHjUaitR1JMhLRfg==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-SPP-KMS-Ids,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msSPP-KMSIds  
adminDisplayName: ms-SPP-KMS-Ids  
adminDescription: KMS IDs enabled by the Activation Object  
attributeId: 1.2.840.113556.1.4.2082  
attributeSyntax: 2.5.5.10  
omSyntax: 4  
isSingleValued: FALSE  
systemOnly: FALSE  
searchFlags: 1  
rangeLower: 16  
rangeUpper: 16  
schemaIdGuid:: 2j5mm0I11kad8DFAJa8rrA==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-SPP-CSVLK-Pid,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msSPP-CSVLKPid  
adminDisplayName: ms-SPP-CSVLK-Pid  
adminDescription: ID of CSVLK product-key used to create the Activation Object  
attributeId: 1.2.840.113556.1.4.2105  
attributeSyntax: 2.5.5.12  
omSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
rangeUpper: 512  
schemaIdGuid:: DVF/tFBr4Ue1VncseeT/xA==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-SPP-CSVLK-Sku-Id,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msSPP-CSVLKSkuId  
adminDisplayName: ms-SPP-CSVLK-Sku-Id  
adminDescription: SKU ID of CSVLK product-key used to create the Activation Object  
attributeId: 1.2.840.113556.1.4.2081  
attributeSyntax: 2.5.5.10  
omSyntax: 4  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
rangeLower: 16  
rangeUpper: 16  
schemaIdGuid:: OfeElnh7bUeNdDGtdpLu9A==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-SPP-Phone-License,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msSPP-PhoneLicense  
adminDisplayName: ms-SPP-Phone-License  
adminDescription: License used during phone activation of the Active Directory forest  
attributeId: 1.2.840.113556.1.4.2086  
attributeSyntax: 2.5.5.10  
omSyntax: 4  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
rangeUpper: 5242880  
schemaIdGuid:: EtnkZ2LzUkCMeUL0W6eyIQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-SPP-Config-License,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msSPP-ConfigLicense  
adminDisplayName: ms-SPP-Config-License  
adminDescription: Product-key configuration license used during online/phone activation of the Active Directory forest  
attributeId: 1.2.840.113556.1.4.2087  
attributeSyntax: 2.5.5.10  
omSyntax: 4  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
rangeUpper: 5242880  
schemaIdGuid:: tcRTA5nRsECzxd6zL9nsBg==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-SPP-Online-License,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msSPP-OnlineLicense  
adminDisplayName: ms-SPP-Online-License  
adminDescription: License used during online activation of the Active Directory forest  
attributeId: 1.2.840.113556.1.4.2085  
attributeSyntax: 2.5.5.10  
omSyntax: 4  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
rangeUpper: 5242880  
schemaIdGuid:: jjaPCRJIzUivt6E2uWgH7Q==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-SPP-Confirmation-Id,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msSPP-ConfirmationId  
adminDisplayName: ms-SPP-Confirmation-Id  
adminDescription: Confirmation ID (CID) used for phone activation of the Active Directory forest  
attributeId: 1.2.840.113556.1.4.2084  
attributeSyntax: 2.5.5.12  
omSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
rangeUpper: 512  
schemaIdGuid:: xJeHbtqsSUqHQLC9Bam4MQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-SPP-Installation-Id,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msSPP-InstallationId  
adminDisplayName: ms-SPP-Installation-Id  
adminDescription: Installation ID (IID) used for phone activation of the Active Directory forest  
attributeId: 1.2.840.113556.1.4.2083  
attributeSyntax: 2.5.5.12  
omSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
rangeUpper: 512  
schemaIdGuid:: FLG/aXtAOUeiE8ZjgCs+Nw==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-SPP-Issuance-License,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msSPP-IssuanceLicense  
adminDisplayName: ms-SPP-Issuance-License  
adminDescription: Issuance license used during online/phone activation of the Active Directory forest  
attributeId: 1.2.840.113556.1.4.2088  
attributeSyntax: 2.5.5.10  
omSyntax: 4  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
rangeUpper: 5242880  
schemaIdGuid:: obN1EK+70kmujcTyXIIzAw==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-SPP-CSVLK-Partial-Product-Key,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msSPP-CSVLKPartialProductKey  
adminDisplayName: ms-SPP-CSVLK-Partial-Product-Key  
adminDescription: Last 5 characters of CSVLK product-key used to create the Activation Object  
attributeId: 1.2.840.113556.1.4.2106  
attributeSyntax: 2.5.5.12  
omSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
rangeLower: 5  
rangeUpper: 5  
schemaIdGuid:: kbABplKGOkWzhoetI5t8CA==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-TPM-Srk-Pub-Thumbprint,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msTPM-SrkPubThumbprint  
adminDisplayName: TPM-SrkPubThumbprint  
adminDescription: This attribute contains the thumbprint of the SrkPub corresponding to a particular TPM. This helps to index the TPM devices in the directory.  
attributeId: 1.2.840.113556.1.4.2107  
attributeSyntax: 2.5.5.10  
omSyntax: 4  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 11  
rangeUpper: 20  
schemaIdGuid:: 6wbXGXZNokSF1hw0K+O+Nw==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-TPM-Owner-Information-Temp,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msTPM-OwnerInformationTemp  
adminDisplayName: TPM-OwnerInformationTemp  
adminDescription: This attribute contains temporary owner information for a particular TPM.  
attributeId: 1.2.840.113556.1.4.2108  
attributeSyntax: 2.5.5.12  
omSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 640  
rangeUpper: 128  
schemaIdGuid:: nYCUyBO1+E+IEfT0P1rHvA==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-TPM-Tpm-Information-For-Computer,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msTPM-TpmInformationForComputer  
adminDisplayName: TPM-TpmInformationForComputer  
adminDescription: This attribute links a Computer object to a TPM object.  
attributeId: 1.2.840.113556.1.4.2109  
attributeSyntax: 2.5.5.1  
omSyntax: 127  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 16  
omObjectClass:: KwwCh3McAIVK  
schemaIdGuid:: k3sb6khe1Ua8bE30/aeKNQ==  
linkID: 2182  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-TPM-Tpm-Information-For-Computer-BL,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msTPM-TpmInformationForComputerBL  
adminDisplayName: TPM-TpmInformationForComputerBL  
adminDescription: This attribute links a TPM object to the Computer objects associated with it.  
attributeId: 1.2.840.113556.1.4.2110  
attributeSyntax: 2.5.5.1  
omSyntax: 127  
isSingleValued: FALSE  
systemOnly: TRUE  
searchFlags: 0  
omObjectClass:: KwwCh3McAIVK  
schemaIdGuid:: yYT6FM2OSEO8kW087Ucqtw==  
linkID: 2183  
showInAdvancedViewOnly: TRUE  
systemFlags: 17  
  
dn:  
changetype: modify  
add: schemaUpdateNow  
schemaUpdateNow: 1  
-  
  
dn: CN=ms-DS-Claim-Types,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: classSchema  
ldapDisplayName: msDS-ClaimTypes  
adminDisplayName: ms-DS-Claim-Types  
adminDescription: A container of this class can contain claim type objects.  
governsId: 1.2.840.113556.1.5.270  
objectClassCategory: 1  
rdnAttId: 2.5.4.3  
subClassOf: 2.5.6.0  
systemPossSuperiors: 1.2.840.113556.1.3.23  
schemaIdGuid:: NTIJNhXHIUirarVvsoBaWA==  
defaultSecurityDescriptor: D:(A;;RPWPCRCCDCLCLOLORCWOWDSDDTDTSW;;;EA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)(A;;RPLCLORC;;;AU)  
showInAdvancedViewOnly: TRUE  
defaultHidingValue: FALSE  
systemOnly: FALSE  
defaultObjectCategory: CN=ms-DS-Claim-Types,CN=Schema,CN=Configuration,DC=X  
systemFlags: 16  
  
dn: CN=ms-DS-Resource-Property-List,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: classSchema  
ldapDisplayName: msDS-ResourcePropertyList  
adminDisplayName: ms-DS-Resource-Property-List  
adminDescription: An object of this class contains a list of resource properties.  
governsId: 1.2.840.113556.1.5.274  
objectClassCategory: 1  
rdnAttId: 2.5.4.3  
subClassOf: 2.5.6.0  
systemMayContain: 1.2.840.113556.1.4.2103  
systemPossSuperiors: 1.2.840.113556.1.3.23  
schemaIdGuid:: etTjckKzRU2PVrr/gDyr+Q==  
defaultSecurityDescriptor: D:(A;;RPWPCRCCDCLCLOLORCWOWDSDDTDTSW;;;EA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)(A;;RPLCLORC;;;AU)  
showInAdvancedViewOnly: TRUE  
defaultHidingValue: FALSE  
systemOnly: FALSE  
defaultObjectCategory: CN=ms-DS-Resource-Property-List,CN=Schema,CN=Configuration,DC=X  
systemFlags: 16  
  
dn: CN=ms-DS-Resource-Properties,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: classSchema  
ldapDisplayName: msDS-ResourceProperties  
adminDisplayName: ms-DS-Resource-Properties  
adminDescription: A container of this class can contain resource properties.  
governsId: 1.2.840.113556.1.5.271  
objectClassCategory: 1  
rdnAttId: 2.5.4.3  
subClassOf: 2.5.6.0  
systemPossSuperiors: 1.2.840.113556.1.3.23  
schemaIdGuid:: hEVKelCzj0es1rS4UtgswA==  
defaultSecurityDescriptor: D:(A;;RPWPCRCCDCLCLOLORCWOWDSDDTDTSW;;;EA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)(A;;RPLCLORC;;;AU)  
showInAdvancedViewOnly: TRUE  
defaultHidingValue: FALSE  
systemOnly: FALSE  
defaultObjectCategory: CN=ms-DS-Resource-Properties,CN=Schema,CN=Configuration,DC=X  
systemFlags: 16  
  
dn: CN=ms-DS-Claim-Type-Property-Base,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: classSchema  
ldapDisplayName: msDS-ClaimTypePropertyBase  
adminDisplayName: ms-DS-Claim-Type-Property-Base  
adminDescription: An abstract class that defines the base class for claim type or resource property classes.  
governsId: 1.2.840.113556.1.5.269  
objectClassCategory: 2  
rdnAttId: 2.5.4.3  
subClassOf: 2.5.6.0  
systemMayContain: 1.2.840.113556.1.4.2101  
systemMayContain: 1.2.840.113556.1.2.557  
systemMayContain: 1.2.840.113556.1.4.2097  
schemaIdGuid:: WC9EuJDEh0SKndgLiDJxrQ==  
defaultSecurityDescriptor: D:(A;;RPWPCRCCDCLCLOLORCWOWDSDDTDTSW;;;EA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)(A;;RPLCLORC;;;AU)  
showInAdvancedViewOnly: TRUE  
defaultHidingValue: FALSE  
systemOnly: FALSE  
defaultObjectCategory: CN=ms-DS-Claim-Type-Property-Base,CN=Schema,CN=Configuration,DC=X  
systemFlags: 16  
  
dn: CN=ms-DS-Resource-Property,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: classSchema  
ldapDisplayName: msDS-ResourceProperty  
adminDisplayName: ms-DS-Resource-Property  
adminDescription: An instance of this class holds the definition of a property on resources.   
governsId: 1.2.840.113556.1.5.273  
objectClassCategory: 1  
rdnAttId: 2.5.4.3  
subClassOf: 1.2.840.113556.1.5.269  
systemMayContain: 1.2.840.113556.1.4.2095  
systemPossSuperiors: 1.2.840.113556.1.5.271  
schemaIdGuid:: Xj0oWwSElUGTOYRQGIxQGg==  
defaultSecurityDescriptor: D:(A;;RPWPCRCCDCLCLOLORCWOWDSDDTDTSW;;;EA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)(A;;RPLCLORC;;;AU)  
showInAdvancedViewOnly: TRUE  
defaultHidingValue: FALSE  
systemOnly: FALSE  
defaultObjectCategory: CN=ms-DS-Resource-Property,CN=Schema,CN=Configuration,DC=X  
systemFlags: 16  
  
dn: CN=ms-DS-Claim-Type,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: classSchema  
ldapDisplayName: msDS-ClaimType  
adminDisplayName: ms-DS-Claim-Type  
adminDescription: An instance of this class holds the definition of a claim type that can be defined on security principals.  
governsId: 1.2.840.113556.1.5.272  
objectClassCategory: 1  
rdnAttId: 2.5.4.3  
subClassOf: 1.2.840.113556.1.5.269  
systemMayContain: 1.2.840.113556.1.4.2100  
systemMayContain: 1.2.840.113556.1.4.2099  
systemPossSuperiors: 1.2.840.113556.1.5.270  
schemaIdGuid:: fIWjgWlUj02q5sJ2mXYmBA==  
defaultSecurityDescriptor: D:(A;;RPWPCRCCDCLCLOLORCWOWDSDDTDTSW;;;EA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)(A;;RPLCLORC;;;AU)  
showInAdvancedViewOnly: TRUE  
defaultHidingValue: FALSE  
systemOnly: FALSE  
defaultObjectCategory: CN=ms-DS-Claim-Type,CN=Schema,CN=Configuration,DC=X  
systemFlags: 16  
  
dn: CN=ms-SPP-Activation-Objects-Container,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: classSchema  
ldapDisplayName: msSPP-ActivationObjectsContainer  
adminDisplayName: ms-SPP-Activation-Objects-Container  
adminDescription: Container for Activation Objects used by Active Directory based activation  
governsId: 1.2.840.113556.1.5.266  
objectClassCategory: 1  
rdnAttId: 2.5.4.3  
subClassOf: 2.5.6.0  
systemPossSuperiors: 1.2.840.113556.1.3.23  
schemaIdGuid:: K4YvtyW7XU2qUWLFm9+Qrg==  
defaultSecurityDescriptor: O:BAG:BAD: (A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;DA)(A;;RPLCLORC;;;AU)  
showInAdvancedViewOnly: FALSE  
defaultHidingValue: TRUE  
systemOnly: FALSE  
defaultObjectCategory: CN=ms-SPP-Activation-Objects-Container,CN=Schema,CN=Configuration,DC=X  
systemFlags: 16  
  
dn: CN=ms-SPP-Activation-Object,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: classSchema  
ldapDisplayName: msSPP-ActivationObject  
adminDisplayName: ms-SPP-Activation-Object  
adminDescription: Activation Object used in Active Directory based activation  
governsId: 1.2.840.113556.1.5.267  
objectClassCategory: 1  
rdnAttId: 2.5.4.3  
subClassOf: 2.5.6.0  
systemMustContain: 1.2.840.113556.1.4.2082  
systemMustContain: 1.2.840.113556.1.4.2081  
systemMustContain: 1.2.840.113556.1.4.2106  
systemMustContain: 1.2.840.113556.1.4.2105  
systemMayContain: 1.2.840.113556.1.4.2088  
systemMayContain: 1.2.840.113556.1.4.2087  
systemMayContain: 1.2.840.113556.1.4.2086  
systemMayContain: 1.2.840.113556.1.4.2085  
systemMayContain: 1.2.840.113556.1.4.2084  
systemMayContain: 1.2.840.113556.1.4.2083  
systemPossSuperiors: 1.2.840.113556.1.5.266  
schemaIdGuid:: jOagUcUNykOTXcHJEb8u5Q==  
defaultSecurityDescriptor: O:BAG:BAD: (A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;DA)(A;;RPLCLORC;;;AU)  
showInAdvancedViewOnly: FALSE  
defaultHidingValue: TRUE  
systemOnly: FALSE  
defaultObjectCategory: CN=ms-SPP-Activation-Object,CN=Schema,CN=Configuration,DC=X  
systemFlags: 16  
  
dn: CN=ms-TPM-Information-Objects-Container,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: classSchema  
ldapDisplayName: msTPM-InformationObjectsContainer  
adminDisplayName: TPM-InformationObjectsContainer  
adminDescription: Container for TPM objects.  
governsId: 1.2.840.113556.1.5.276  
objectClassCategory: 1  
rdnAttId: 2.5.4.3  
subClassOf: 2.5.6.0  
systemMustContain: 2.5.4.3  
systemPossSuperiors: 1.2.840.113556.1.5.67  
systemPossSuperiors: 1.2.840.113556.1.5.66  
schemaIdGuid:: vagn4FZk3kWQozhZOHfudA==  
defaultSecurityDescriptor: D:(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;DA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)(A;;LOLCCCRP;;;DC)  
showInAdvancedViewOnly: TRUE  
defaultHidingValue: TRUE  
systemOnly: FALSE  
defaultObjectCategory: CN=ms-TPM-Information-Objects-Container,CN=Schema,CN=Configuration,DC=X  
systemFlags: 16  
  
dn: CN=ms-TPM-Information-Object,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: classSchema  
ldapDisplayName: msTPM-InformationObject  
adminDisplayName: TPM-InformationObject  
adminDescription: This class contains recovery information for a Trusted Platform Module (TPM) device.  
governsId: 1.2.840.113556.1.5.275  
objectClassCategory: 1  
rdnAttId: 2.5.4.3  
subClassOf: 2.5.6.0  
systemMustContain: 1.2.840.113556.1.4.1966  
systemMayContain: 1.2.840.113556.1.4.2108  
systemMayContain: 1.2.840.113556.1.4.2107  
systemPossSuperiors: 1.2.840.113556.1.5.276  
schemaIdGuid:: alsEhaZHQ0KnzGiQcB9mLA==  
defaultSecurityDescriptor: D:(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;DA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)(A;;RPLO;;;DC)(A;;WP;;;CO)  
showInAdvancedViewOnly: TRUE  
defaultHidingValue: TRUE  
systemOnly: FALSE  
defaultObjectCategory: CN=ms-TPM-Information-Object,CN=Schema,CN=Configuration,DC=X  
systemFlags: 16  
  
dn: CN=Top,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2102  
systemMayContain: 1.2.840.113556.1.4.2104  
-  
  
dn: CN=Computer,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2109  
-  
  
dn:  
changetype: modify  
add: schemaUpdateNow  
schemaUpdateNow: 1  
-  
  
dn: CN=Schema,CN=Configuration,DC=X  
changeType: ntdsSchemaModify  
replace: objectVersion  
objectVersion: 48  
-  
```  
  
### <a name="BKMK_Sch49"></a>Sch49.ldf  
  
```  
dn: CN=ms-DNS-Is-Signed,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDNS-IsSigned  
adminDisplayName: ms-DNS-Is-Signed  
adminDescription: An attribute used to define whether or not the DNS zone is signed.  
attributeId: 1.2.840.113556.1.4.2130  
attributeSyntax: 2.5.5.8  
omSyntax: 1  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 8  
schemaIdGuid:: TIUSqvzYXk2RyjaLjYKb7g==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DNS-NSEC3-OptOut,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDNS-NSEC3OptOut  
adminDisplayName: ms-DNS-NSEC3-OptOut  
adminDescription: An attribute used to define whether or not the DNS zone should be signed using NSEC opt-out.  
attributeId: 1.2.840.113556.1.4.2132  
attributeSyntax: 2.5.5.8  
omSyntax: 1  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 8  
schemaIdGuid:: iCDqe+KMPEKxkWbsUGsVlQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DNS-Signing-Keys,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDNS-SigningKeys  
adminDisplayName: ms-DNS-Signing-Keys  
adminDescription: An attribute that contains the set of encrypted DNSSEC signing keys used by the DNS server to sign the DNS zone.  
attributeId: 1.2.840.113556.1.4.2144  
attributeSyntax: 2.5.5.10  
omSyntax: 4  
isSingleValued: FALSE  
systemOnly: FALSE  
searchFlags: 8  
rangeUpper: 10000  
schemaIdGuid:: bT5nt9nKnk6zGmPoCY/dYw==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DNS-Sign-With-NSEC3,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDNS-SignWithNSEC3  
adminDisplayName: ms-DNS-Sign-With-NSEC3  
adminDescription: An attribute used to define whether or not the DNS zone is signed with NSEC3.  
attributeId: 1.2.840.113556.1.4.2131  
attributeSyntax: 2.5.5.8  
omSyntax: 1  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 8  
schemaIdGuid:: mSGfx6Ft/0aSPB8/gAxyHg==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DNS-NSEC3-User-Salt,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDNS-NSEC3UserSalt  
adminDisplayName: ms-DNS-NSEC3-User-Salt  
adminDescription: An attribute that defines a user-specified NSEC3 salt string to use when signing the DNS zone. If empty, random salt will be used.  
attributeId: 1.2.840.113556.1.4.2148  
attributeSyntax: 2.5.5.12  
omSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 8  
rangeLower: 0  
rangeUpper: 510  
schemaIdGuid:: cGfxryKWvE+hKDCId3YFuQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DNS-DNSKEY-Records,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDNS-DNSKEYRecords  
adminDisplayName: ms-DNS-DNSKEY-Records  
adminDescription: An attribute that contains the DNSKEY record set for the root of the DNS zone and the root key signing key signature records.  
attributeId: 1.2.840.113556.1.4.2145  
attributeSyntax: 2.5.5.10  
omSyntax: 4  
isSingleValued: FALSE  
systemOnly: FALSE  
searchFlags: 8  
rangeUpper: 10000  
schemaIdGuid:: 9VjEKC1gyUqnfLPxvlA6fg==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DNS-DS-Record-Set-TTL,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDNS-DSRecordSetTTL  
adminDisplayName: ms-DNS-DS-Record-Set-TTL  
adminDescription: An attribute that defines the time-to-live (TTL) value assigned to DS records when signing the DNS zone.  
attributeId: 1.2.840.113556.1.4.2140  
attributeSyntax: 2.5.5.9  
omSyntax: 2  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 8  
rangeLower: 0  
rangeUpper: 2592000  
schemaIdGuid:: fJuGKcRk/kKX1fvC+hJBYA==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DNS-Keymaster-Zones,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDNS-KeymasterZones  
adminDisplayName: ms-DNS-Keymaster-Zones  
adminDescription: A list of Active Directory-integrated zones for which the DNS server is the keymaster.  
attributeId: 1.2.840.113556.1.4.2128  
attributeSyntax: 2.5.5.12  
omSyntax: 64  
isSingleValued: FALSE  
systemOnly: FALSE  
searchFlags: 0  
schemaIdGuid:: O93gCxoEjEGs6S8X0j6dQg==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DNS-NSEC3-Iterations,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDNS-NSEC3Iterations  
adminDisplayName: ms-DNS-NSEC3-Iterations  
adminDescription: An attribute that defines how many NSEC3 hash iterations to perform when signing the DNS zone.  
attributeId: 1.2.840.113556.1.4.2138  
attributeSyntax: 2.5.5.9  
omSyntax: 2  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 8  
rangeLower: 0  
rangeUpper: 10000  
schemaIdGuid:: qwq3gFmJwE6OkxJudt86yg==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DNS-Propagation-Time,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDNS-PropagationTime  
adminDisplayName: ms-DNS-Propagation-Time  
adminDescription: An attribute used to define in seconds the expected time required to propagate zone changes through Active Directory.  
attributeId: 1.2.840.113556.1.4.2147  
attributeSyntax: 2.5.5.9  
omSyntax: 2  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 8  
schemaIdGuid:: Rw00uoEhoEyi9vrkR52rKg==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DNS-NSEC3-Current-Salt,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDNS-NSEC3CurrentSalt  
adminDisplayName: ms-DNS-NSEC3-Current-Salt  
adminDescription: An attribute that defines the current NSEC3 salt string being used to sign the DNS zone.  
attributeId: 1.2.840.113556.1.4.2149  
attributeSyntax: 2.5.5.12  
omSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 8  
rangeLower: 0  
rangeUpper: 510  
schemaIdGuid:: MpR9ONGmdESCzQqJquCErg==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DNS-RFC5011-Key-Rollovers,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDNS-RFC5011KeyRollovers  
adminDisplayName: ms-DNS-RFC5011-Key-Rollovers  
adminDescription: An attribute that defines whether or not the DNS zone should be maintained using key rollover procedures defined in RFC 5011.  
attributeId: 1.2.840.113556.1.4.2135  
attributeSyntax: 2.5.5.8  
omSyntax: 1  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 8  
schemaIdGuid:: QDzZJ1oGwEO92M3yx9Egqg==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DNS-NSEC3-Hash-Algorithm,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDNS-NSEC3HashAlgorithm  
adminDisplayName: ms-DNS-NSEC3-Hash-Algorithm  
adminDescription: An attribute that defines the NSEC3 hash algorithm to use when signing the DNS zone.  
attributeId: 1.2.840.113556.1.4.2136  
attributeSyntax: 2.5.5.9  
omSyntax: 2  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 8  
schemaIdGuid:: UlWe/7d9OEGIiAXOMgoDIw==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DNS-DS-Record-Algorithms,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDNS-DSRecordAlgorithms  
adminDisplayName: ms-DNS-DS-Record-Algorithms  
adminDescription: An attribute used to define the algorithms used when writing the dsset file during zone signing.  
attributeId: 1.2.840.113556.1.4.2134  
attributeSyntax: 2.5.5.9  
omSyntax: 2  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 8  
schemaIdGuid:: 0npbXPogu0S+szS5wPZVeQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DNS-DNSKEY-Record-Set-TTL,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDNS-DNSKEYRecordSetTTL  
adminDisplayName: ms-DNS-DNSKEY-Record-Set-TTL  
adminDescription: An attribute that defines the time-to-live (TTL) value assigned to DNSKEY records when signing the DNS zone.  
attributeId: 1.2.840.113556.1.4.2139  
attributeSyntax: 2.5.5.9  
omSyntax: 2  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 8  
rangeLower: 0  
rangeUpper: 2592000  
schemaIdGuid:: fzFOj9coLESm3x9JH5ezJg==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DNS-Maintain-Trust-Anchor,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDNS-MaintainTrustAnchor  
adminDisplayName: ms-DNS-Maintain-Trust-Anchor  
adminDescription: An attribute used to define the type of trust anchor to automatically publish in the forest-wide trust anchor store when the DNS zone is signed.  
attributeId: 1.2.840.113556.1.4.2133  
attributeSyntax: 2.5.5.9  
omSyntax: 2  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 8  
schemaIdGuid:: wWPADdlSVkSeFZwkNKr9lA==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DNS-NSEC3-Random-Salt-Length,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDNS-NSEC3RandomSaltLength  
adminDisplayName: ms-DNS-NSEC3-Random-Salt-Length  
adminDescription: An attribute that defines the length in bytes of the random salt used when signing the DNS zone.  
attributeId: 1.2.840.113556.1.4.2137  
attributeSyntax: 2.5.5.9  
omSyntax: 2  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 8  
rangeLower: 0  
rangeUpper: 255  
schemaIdGuid:: ZRY2E2yR502lnbHrvQ3hKQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DNS-Signing-Key-Descriptors,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDNS-SigningKeyDescriptors  
adminDisplayName: ms-DNS-Signing-Key-Descriptors  
adminDescription: An attribute that contains the set of DNSSEC Signing Key Descriptors (SKDs) used by the DNS server to generate keys and sign the DNS zone.  
attributeId: 1.2.840.113556.1.4.2143  
attributeSyntax: 2.5.5.10  
omSyntax: 4  
isSingleValued: FALSE  
systemOnly: FALSE  
searchFlags: 8  
rangeUpper: 10000  
schemaIdGuid:: zdhDNLblO0+wmGWaAhSgeQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DNS-Signature-Inception-Offset,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDNS-SignatureInceptionOffset  
adminDisplayName: ms-DNS-Signature-Inception-Offset  
adminDescription: An attribute that defines in seconds how far in the past DNSSEC signature validity periods should begin when signing the DNS zone.  
attributeId: 1.2.840.113556.1.4.2141  
attributeSyntax: 2.5.5.9  
omSyntax: 2  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 8  
rangeLower: 0  
rangeUpper: 2592000  
schemaIdGuid:: LsPUAxfiYUqWmXu8RymgJg==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DNS-Parent-Has-Secure-Delegation,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDNS-ParentHasSecureDelegation  
adminDisplayName: ms-DNS-Parent-Has-Secure-Delegation  
adminDescription: An attribute used to define whether the parental delegation to the DNS zone is secure.  
attributeId: 1.2.840.113556.1.4.2146  
attributeSyntax: 2.5.5.8  
omSyntax: 1  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 8  
schemaIdGuid:: ZGlcKBrBnkmW2L98daIjxg==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DNS-Secure-Delegation-Polling-Period,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDNS-SecureDelegationPollingPeriod  
adminDisplayName: ms-DNS-Secure-Delegation-Polling-Period  
adminDescription: An attribute that defines in seconds the time between polling attempts for child zone key rollovers.  
attributeId: 1.2.840.113556.1.4.2142  
attributeSyntax: 2.5.5.9  
omSyntax: 2  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 8  
rangeLower: 0  
rangeUpper: 2592000  
schemaIdGuid:: vvCw9uSoaESP2cPEe4ci+Q==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-Authz-Member-Rules-In-Central-Access-Policy,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msAuthz-MemberRulesInCentralAccessPolicy  
adminDisplayName: ms-Authz-Member-Rules-In-Central-Access-Policy  
adminDescription: For a central access policy, this attribute identifies the central access rules that comprise the policy.  
attributeId: 1.2.840.113556.1.4.2155  
attributeSyntax: 2.5.5.1  
omSyntax: 127  
isSingleValued: FALSE  
systemOnly: FALSE  
searchFlags: 0  
omObjectClass:: KwwCh3McAIVK  
schemaIdGuid:: ei/yV343w0KYcs7G8h0uPg==  
linkID: 2184  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-Authz-Member-Rules-In-Central-Access-Policy-BL,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msAuthz-MemberRulesInCentralAccessPolicyBL  
adminDisplayName: ms-Authz-Member-Rules-In-Central-Access-Policy-BL  
adminDescription: Backlink for ms-Authz-Member-Rules-In-Central-Access-Policy. For a central access rule object, this attribute references one or more central access policies that point to it.  
attributeId: 1.2.840.113556.1.4.2156  
attributeSyntax: 2.5.5.1  
omSyntax: 127  
isSingleValued: FALSE  
systemOnly: FALSE  
searchFlags: 0  
omObjectClass:: KwwCh3McAIVK  
schemaIdGuid:: z2duUd3+lES7OrxQapSIkQ==  
linkID: 2185  
showInAdvancedViewOnly: TRUE  
systemFlags: 17  
  
dn: CN=ms-DS-Claim-Source,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-ClaimSource  
adminDisplayName: ms-DS-Claim-Source  
adminDescription: For a claim type, this attribute indicates the source of the claim type. For example, the source can be certificate.  
attributeId: 1.2.840.113556.1.4.2157  
attributeSyntax: 2.5.5.12  
omSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
schemaIdGuid:: pvIy+ovy0Ee/kWY+j5EKcg==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-Authz-Proposed-Security-Policy,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msAuthz-ProposedSecurityPolicy  
adminDisplayName: ms-Authz-Proposed-Security-Policy  
adminDescription: For a Central Access Policy Entry, defines the proposed security policy of the objects the CAPE is applied to.  
attributeId: 1.2.840.113556.1.4.2151  
attributeSyntax: 2.5.5.12  
omSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
schemaIdGuid:: zr5GubUJakuyWktjozDoDg==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-Claim-Source-Type,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-ClaimSourceType  
adminDisplayName: ms-DS-Claim-Source-Type  
adminDescription: For a security principal claim type, lists the type of store the issued claim is sourced from  
attributeId: 1.2.840.113556.1.4.2158  
attributeSyntax: 2.5.5.12  
omSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
schemaIdGuid:: BZzxkvqNIkK70SxPAUh3VA==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-Authz-Effective-Security-Policy,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msAuthz-EffectiveSecurityPolicy  
adminDisplayName: ms-Authz-Security-Policy  
adminDescription: For a central access rule, this attribute defines the permission that is applying to the target resources on the central access rule.  
attributeId: 1.2.840.113556.1.4.2150  
attributeSyntax: 2.5.5.12  
omSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
schemaIdGuid:: GRmDB5SPtk+KQpFUXcza0w==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-Claim-Is-Single-Valued,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-ClaimIsSingleValued  
adminDisplayName: ms-DS-Claim-Is-Single-Valued  
adminDescription: For a claim type object, this attribute identifies if the claim type or resource property can only contain single value.  
attributeId: 1.2.840.113556.1.4.2160  
attributeSyntax: 2.5.5.8  
omSyntax: 1  
isSingleValued: TRUE  
systemOnly: TRUE  
searchFlags: 0  
schemaIdGuid:: uZ94zbSWSEaCGco3gWGvOA==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-Authz-Last-Effective-Security-Policy,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msAuthz-LastEffectiveSecurityPolicy  
adminDisplayName: ms-Authz-Last-Effective-Security-Policy  
adminDescription: For a Central Access Policy Entry, defines the security policy that was last applied to the objects the CAPE is applied to.  
attributeId: 1.2.840.113556.1.4.2152  
attributeSyntax: 2.5.5.12  
omSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
schemaIdGuid:: xoUWji8+okiljVrw6nifoA==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-Authz-Resource-Condition,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msAuthz-ResourceCondition  
adminDisplayName: ms-Authz-Resource-Condition  
adminDescription: For a central access rule, this attribute is an expression that identifies the scope of the target resource to which the policy applies.  
attributeId: 1.2.840.113556.1.4.2153  
attributeSyntax: 2.5.5.12  
omSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
schemaIdGuid:: d3iZgHT4aEyGTW5QioO9vQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-Claim-Is-Value-Space-Restricted,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-ClaimIsValueSpaceRestricted  
adminDisplayName: ms-DS-Claim-Is-Value-Space-Restricted  
adminDescription: For a claim type, this attribute identifies whether a user can input values other than those described in the msDS-ClaimPossibleValues in applications.  
attributeId: 1.2.840.113556.1.4.2159  
attributeSyntax: 2.5.5.8  
omSyntax: 1  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
schemaIdGuid:: x+QsDMPxgkSFeMYNS7dEIg==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-Authz-Central-Access-Policy-ID,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msAuthz-CentralAccessPolicyID  
adminDisplayName: ms-Authz-Central-Access-Policy-ID  
adminDescription: For a Central Access Policy, this attribute defines a GUID that can be used to identify the set of policies when applied to a resource.  
attributeId: 1.2.840.113556.1.4.2154  
attributeSyntax: 2.5.5.17  
omSyntax: 4  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
schemaIdGuid:: YJvyYnS+MEaUVi9mkZk6hg==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-Generation-Id,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-GenerationId  
adminDisplayName: ms-DS-Generation-Id  
adminDescription: For virtual machine snapshot resuming detection. This attribute represents the VM Generation ID.  
attributeId: 1.2.840.113556.1.4.2166  
attributeSyntax: 2.5.5.10  
omSyntax: 4  
isSingleValued: TRUE  
rangeLower: 16  
rangeUpper: 16  
systemOnly: TRUE  
searchFlags: 0  
schemaIdGuid:: PTldHreMT0uECpc7NswJww==  
showInAdvancedViewOnly: TRUE  
systemFlags: 17  
  
dn: CN=ms-DS-Claim-Shares-Possible-Values-With,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
replace: adminDescription  
adminDescription: For a claim type object, indicates that the possible values of the claims issued are defined on the object this linked attribute points to; overrides msDS-ClaimPossibleValues, msDS-ClaimValueType, and msDS-ClaimIsValueSpaceRestricted, if populated.  
-  
replace: isSingleValued  
isSingleValued: TRUE  
-  
  
dn: CN=ms-DNS-Server-Settings,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: classSchema  
ldapDisplayName: msDNS-ServerSettings  
adminDisplayName: ms-DNS-Server-Settings  
adminDescription: A container for storing DNS server settings.  
governsId: 1.2.840.113556.1.4.2129  
objectClassCategory: 1  
rdnAttId: 2.5.4.3  
subClassOf: 2.5.6.0  
systemMayContain: 1.2.840.113556.1.4.2128  
systemPossSuperiors: 1.2.840.113556.1.5.17  
schemaIdGuid:: 7cMv7xhuW0GZ5DEUqMsSSw==  
defaultSecurityDescriptor: D:(A;;RPWPCRCCDCLCLOLORCWOWDSDDTDTSW;;;EA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)(A;;RPLCLORC;;;AU)  
showInAdvancedViewOnly: TRUE  
defaultHidingValue: FALSE  
systemOnly: FALSE  
defaultObjectCategory: CN=ms-DNS-Server-Settings,CN=Schema,CN=Configuration,DC=X  
systemFlags: 16  
  
dn: CN=ms-Authz-Central-Access-Policies,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: classSchema  
ldapDisplayName: msAuthz-CentralAccessPolicies  
adminDisplayName: ms-Authz-Central-Access-Policies  
adminDescription: A container of this class can contain Central Access Policy objects.  
governsId: 1.2.840.113556.1.4.2161  
objectClassCategory: 1  
rdnAttId: 2.5.4.3  
subClassOf: 2.5.6.0  
systemPossSuperiors: 1.2.840.113556.1.3.23  
schemaIdGuid:: wyFcVTahWkWTl3lrvTWOJQ==  
defaultSecurityDescriptor: D:(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;EA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)(A;;RPLCLORC;;;AU)  
showInAdvancedViewOnly: TRUE  
defaultHidingValue: TRUE  
systemOnly: FALSE  
defaultObjectCategory: CN=ms-Authz-Central-Access-Policies,CN=Schema,CN=Configuration,DC=X  
systemFlags: 16  
  
dn: CN=ms-Authz-Central-Access-Rules,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: classSchema  
ldapDisplayName: msAuthz-CentralAccessRules  
adminDisplayName: ms-Authz-Central-Access-Rules  
adminDescription: A container of this class can contain Central Access Policy Entry objects.  
governsId: 1.2.840.113556.1.4.2162  
objectClassCategory: 1  
rdnAttId: 2.5.4.3  
subClassOf: 2.5.6.0  
systemPossSuperiors: 1.2.840.113556.1.3.23  
schemaIdGuid:: ehu7mW1gi0+ADuFb5VTKjQ==  
defaultSecurityDescriptor: D:(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;EA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)(A;;RPLCLORC;;;AU)  
showInAdvancedViewOnly: TRUE  
defaultHidingValue: TRUE  
systemOnly: FALSE  
defaultObjectCategory: CN=ms-Authz-Central-Access-Rules,CN=Schema,CN=Configuration,DC=X  
systemFlags: 16  
  
dn: CN=ms-Authz-Central-Access-Rule,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: classSchema  
ldapDisplayName: msAuthz-CentralAccessRule  
adminDisplayName: ms-Authz-Central-Access-Rule  
adminDescription: A class that defines Central Access Rules used to construct a central access policy.  
governsId: 1.2.840.113556.1.4.2163  
objectClassCategory: 1  
rdnAttId: 2.5.4.3  
subClassOf: 2.5.6.0  
systemMayContain: 1.2.840.113556.1.4.2153  
systemMayContain: 1.2.840.113556.1.4.2152  
systemMayContain: 1.2.840.113556.1.4.2151  
systemMayContain: 1.2.840.113556.1.4.2150  
systemMayContain: 1.2.840.113556.1.2.557  
systemPossSuperiors: 1.2.840.113556.1.4.2162  
schemaIdGuid:: 3AZKWxwl206IEwvdcTJyJg==  
defaultSecurityDescriptor: D:(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;EA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)(A;;RPLCLORC;;;AU)  
showInAdvancedViewOnly: TRUE  
defaultHidingValue: FALSE  
systemOnly: FALSE  
defaultObjectCategory: CN=ms-Authz-Central-Access-Rule,CN=Schema,CN=Configuration,DC=X  
systemFlags: 16  
  
dn: CN=ms-Authz-Central-Access-Policy,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: classSchema  
ldapDisplayName: msAuthz-CentralAccessPolicy  
adminDisplayName: ms-Authz-Central-Access-Policy  
adminDescription: A class that defines Central Access Policy objects.  
governsId: 1.2.840.113556.1.4.2164  
objectClassCategory: 1  
rdnAttId: 2.5.4.3  
subClassOf: 2.5.6.0  
systemMayContain: 1.2.840.113556.1.4.2155  
systemMayContain: 1.2.840.113556.1.4.2154  
systemPossSuperiors: 1.2.840.113556.1.4.2161  
schemaIdGuid:: sJxnpZ1vLEOLdR4+g08Cqg==  
defaultSecurityDescriptor: D:(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;EA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)(A;;RPLCLORC;;;AU)  
showInAdvancedViewOnly: TRUE  
defaultHidingValue: FALSE  
systemOnly: FALSE  
defaultObjectCategory: CN=ms-Authz-Central-Access-Policy,CN=Schema,CN=Configuration,DC=X  
systemFlags: 16  
  
dn: CN=ms-DS-Claim-Types,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
replace: defaultHidingValue  
defaultHidingValue: TRUE  
-  
  
dn: CN=ms-DS-Resource-Properties,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
replace: defaultHidingValue  
defaultHidingValue: TRUE  
-  
  
dn: CN=ms-DS-List-Of-Claim-Types,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
replace: defaultHidingValue  
defaultHidingValue: TRUE  
-  
  
dn: CN=ms-DS-Claim-Type,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2157  
systemMayContain: 1.2.840.113556.1.4.2158  
systemMayContain: 1.2.840.113556.1.4.2098  
systemMayContain: 1.2.840.113556.1.4.2159  
systemMayContain: 1.2.840.113556.1.4.2160  
-  
  
dn: CN=Dns-Zone,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2130  
systemMayContain: 1.2.840.113556.1.4.2131  
systemMayContain: 1.2.840.113556.1.4.2132  
systemMayContain: 1.2.840.113556.1.4.2133  
systemMayContain: 1.2.840.113556.1.4.2134  
systemMayContain: 1.2.840.113556.1.4.2135  
systemMayContain: 1.2.840.113556.1.4.2136  
systemMayContain: 1.2.840.113556.1.4.2137  
systemMayContain: 1.2.840.113556.1.4.2138  
systemMayContain: 1.2.840.113556.1.4.2139  
systemMayContain: 1.2.840.113556.1.4.2140  
systemMayContain: 1.2.840.113556.1.4.2141  
systemMayContain: 1.2.840.113556.1.4.2142  
systemMayContain: 1.2.840.113556.1.4.2143  
systemMayContain: 1.2.840.113556.1.4.2144  
systemMayContain: 1.2.840.113556.1.4.2145  
systemMayContain: 1.2.840.113556.1.4.2146  
systemMayContain: 1.2.840.113556.1.4.2147  
systemMayContain: 1.2.840.113556.1.4.2148  
systemMayContain: 1.2.840.113556.1.4.2149  
-  
  
dn: CN=Computer,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2166  
-  
  
dn:  
changetype: modify  
add: schemaUpdateNow  
schemaUpdateNow: 1  
-  
  
dn: CN=DS-Clone-Domain-Controller,CN=Extended-Rights,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: controlAccessRight  
displayName: Allow a DC to create a clone of itself  
rightsGuid: 3e0f7e18-2c7a-4c10-ba82-4d926db99a3e  
appliesTo: 19195a5b-6da0-11d0-afd3-00c04fd930c9  
validAccesses: 256  
localizationDisplayId: 80  
  
dn: CN=Schema,CN=Configuration,DC=X  
changeType: ntdsSchemaModify  
replace: objectVersion  
objectVersion: 49  
-  
```  
  
### <a name="BKMK_Sch50"></a>Sch50.ldf  
  
```  
dn: CN=ms-DS-Allowed-To-Act-On-Behalf-Of-Other-Identity,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-AllowedToActOnBehalfOfOtherIdentity  
adminDisplayName: ms-DS-Allowed-To-Act-On-Behalf-Of-Other-Identity  
adminDescription: This attribute is used for access checks to determine if a requester has permission to act on the behalf of other identities to services running as this account.  
attributeId: 1.2.840.113556.1.4.2182  
attributeSyntax: 2.5.5.15  
omSyntax: 66  
isSingleValued: TRUE  
systemOnly: TRUE  
searchFlags: 0  
rangeLower: 0  
rangeUpper: 132096  
schemaIdGuid:: 5cN4P5r3vUaguJ0YEW3ceQ==  
attributeSecurityGuid:: hri1d0qU0RGuvQAA+ANnwQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-Kds-Version,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msKds-Version  
adminDisplayName: ms-Kds-Version  
adminDescription: Version number of this root key.  
attributeId: 1.2.840.113556.1.4.2176  
attributeSyntax: 2.5.5.9  
omSyntax: 2  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 640  
schemaIdGuid:: QHPw1bDmSh6Xvg0zGL2dsQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-Kds-DomainID,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msKds-DomainID  
adminDisplayName: ms-Kds-DomainID  
adminDescription: Distinguished name of the Domain Controller which generated this root key.  
attributeId: 1.2.840.113556.1.4.2177  
attributeSyntax: 2.5.5.1  
omSyntax: 127  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 640  
omObjectClass:: KwwCh3McAIVK  
schemaIdGuid:: ggRAlgfPTOmQ6PLvxPBJXg==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-Kds-KDF-Param,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msKds-KDFParam  
adminDisplayName: ms-Kds-KDF-Param  
adminDescription: Parameters for the key derivation algorithm.  
attributeId: 1.2.840.113556.1.4.2170  
attributeSyntax: 2.5.5.10  
omSyntax: 4  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 640  
rangeUpper: 2000  
schemaIdGuid:: cgeAirj0TxW0HC5Cce/3pw==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-Kds-CreateTime,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msKds-CreateTime  
adminDisplayName: ms-Kds-CreateTime  
adminDescription: The time when this root key was created.  
attributeId: 1.2.840.113556.1.4.2179  
attributeSyntax: 2.5.5.16  
omSyntax: 65  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 640  
schemaIdGuid:: nxEYrpBjRQCzLZfbxwGu9w==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-Kds-RootKeyData,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msKds-RootKeyData  
adminDisplayName: ms-Kds-RootKeyData  
adminDescription: Root key.  
attributeId: 1.2.840.113556.1.4.2175  
attributeSyntax: 2.5.5.10  
omSyntax: 4  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 640  
rangeUpper: 128  
schemaIdGuid:: J3xiJqIIQAqhsY3OhbQpkw==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-Primary-Computer,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-PrimaryComputer  
adminDisplayName: ms-DS-Primary-Computer  
adminDescription: For a user or group object, identifies the primary computers.  
attributeId: 1.2.840.113556.1.4.2167  
attributeSyntax: 2.5.5.1  
omSyntax: 127  
isSingleValued: FALSE  
systemOnly: FALSE  
searchFlags: 1  
omObjectClass:: KwwCh3McAIVK  
schemaIdGuid:: 4vQ9obDb60yCi4suFD6egQ==  
linkID: 2186  
showInAdvancedViewOnly: TRUE  
isMemberOfPartialAttributeSet: TRUE  
systemFlags: 16  
  
dn: CN=ms-Kds-UseStartTime,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msKds-UseStartTime  
adminDisplayName: ms-Kds-UseStartTime  
adminDescription: The time after which this root key may be used.  
attributeId: 1.2.840.113556.1.4.2178  
attributeSyntax: 2.5.5.16  
omSyntax: 65  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 640  
schemaIdGuid:: fwTcbCL1SreanNlayM39og==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-Imaging-Hash-Algorithm,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msImaging-HashAlgorithm  
adminDisplayName: ms-Imaging-Hash-Algorithm  
adminDescription: Contains the name of the hash algorithm used to create the Thumbprint Hash for the Scan Repository/Secure Print Device.  
attributeId: 1.2.840.113556.1.4.2181  
attributeSyntax: 2.5.5.12  
omSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
rangeUpper: 64  
schemaIdGuid:: tQ3nigZklkGS/vO7VXUgpw==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-Kds-KDF-AlgorithmID,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msKds-KDFAlgorithmID  
adminDisplayName: ms-Kds-KDF-AlgorithmID  
adminDescription: The algorithm name of the key derivation function used to compute keys.  
attributeId: 1.2.840.113556.1.4.2169  
attributeSyntax: 2.5.5.12  
omSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 640  
rangeUpper: 200  
schemaIdGuid:: skgs203RTuyfWK1XnYtEDg==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-Imaging-Thumbprint-Hash,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msImaging-ThumbprintHash  
adminDisplayName: ms-Imaging-Thumbprint-Hash  
adminDescription: Contains a hash of the security certificate for the Scan Repository/Secure Print Device.  
attributeId: 1.2.840.113556.1.4.2180  
attributeSyntax: 2.5.5.10  
omSyntax: 4  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
rangeUpper: 1024  
schemaIdGuid:: xdvfnAQDaUWV9sT2Y/5a5g==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-Kds-PublicKey-Length,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msKds-PublicKeyLength  
adminDisplayName: ms-Kds-PublicKey-Length  
adminDescription: The length of the secret agreement public key.  
attributeId: 1.2.840.113556.1.4.2173  
attributeSyntax: 2.5.5.9  
omSyntax: 2  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 640  
schemaIdGuid:: cPQ44805SUWrW/afnlg/4A==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-Kds-PrivateKey-Length,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msKds-PrivateKeyLength  
adminDisplayName: ms-Kds-PrivateKey-Length  
adminDescription: The length of the secret agreement private key.  
attributeId: 1.2.840.113556.1.4.2174  
attributeSyntax: 2.5.5.9  
omSyntax: 2  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 640  
schemaIdGuid:: oUJfYec3SBGg3TAH4Jz8gQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-Is-Primary-Computer-For,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-IsPrimaryComputerFor  
adminDisplayName: ms-DS-Is-Primary-Computer-For  
adminDescription: Backlink atribute for msDS-IsPrimaryComputer.  
attributeId: 1.2.840.113556.1.4.2168  
attributeSyntax: 2.5.5.1  
omSyntax: 127  
isSingleValued: FALSE  
systemOnly: FALSE  
searchFlags: 0  
omObjectClass:: KwwCh3McAIVK  
schemaIdGuid:: rAaMmYc/TkSl3xGwPcilDA==  
linkID: 2187  
showInAdvancedViewOnly: TRUE  
systemFlags: 17  
  
dn: CN=ms-Kds-SecretAgreement-Param,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msKds-SecretAgreementParam  
adminDisplayName: ms-Kds-SecretAgreement-Param  
adminDescription: The parameters for the secret agreement algorithm.  
attributeId: 1.2.840.113556.1.4.2172  
attributeSyntax: 2.5.5.10  
omSyntax: 4  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 640  
rangeUpper: 2000  
schemaIdGuid:: MLCZ2e3+dUm4B+ukRNp56Q==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-Kds-SecretAgreement-AlgorithmID,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msKds-SecretAgreementAlgorithmID  
adminDisplayName: ms-Kds-SecretAgreement-AlgorithmID  
adminDescription: The name of the secret agreement algorithm to be used with public keys.  
attributeId: 1.2.840.113556.1.4.2171  
attributeSyntax: 2.5.5.12  
omSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 640  
rangeUpper: 200  
schemaIdGuid:: XZcCF14iSsuxXQ2uqLXpkA==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-Value-Type-Reference,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-ValueTypeReference  
adminDisplayName: ms-DS-Value-Type-Reference  
adminDescription: This attribute is used to link a resource property object to its value type.  
attributeId: 1.2.840.113556.1.4.2187  
attributeSyntax: 2.5.5.1  
omSyntax: 127  
isSingleValued: TRUE  
systemOnly: TRUE  
searchFlags: 0  
omObjectClass:: KwwCh3McAIVK  
schemaIdGuid:: hF38eNzBSDGJhFj3ktQdPg==  
linkID: 2188  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-Value-Type-Reference-BL,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-ValueTypeReferenceBL  
adminDisplayName: ms-DS-Value-Type-Reference-BL  
adminDescription: This is the back link for ms-DS-Value-Type-Reference. It links a value type object back to resource properties.  
attributeId: 1.2.840.113556.1.4.2188  
attributeSyntax: 2.5.5.1  
omSyntax: 127  
isSingleValued: FALSE  
systemOnly: TRUE  
searchFlags: 0  
omObjectClass:: KwwCh3McAIVK  
schemaIdGuid:: rUNVq6EjRTu5N5sxPVR0qA==  
linkID: 2189  
showInAdvancedViewOnly: TRUE  
systemFlags: 17  
  
dn: CN=ms-DS-Is-Possible-Values-Present,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-IsPossibleValuesPresent  
adminDisplayName: ms-DS-Is-Possible-Values-Present  
adminDescription: This attribute identifies if ms-DS-Claim-Possible-Values on linked resource property must have value or must not have value.  
attributeId: 1.2.840.113556.1.4.2186  
attributeSyntax: 2.5.5.8  
omSyntax: 1  
isSingleValued: TRUE  
systemOnly: TRUE  
searchFlags: 0  
schemaIdGuid:: 2tyrb1OMTyCxpJ3wxnwetA==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn:  
changetype: modify  
add: schemaUpdateNow  
schemaUpdateNow: 1  
-  
  
dn: CN=ms-Kds-Prov-RootKey,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: classSchema  
ldapDisplayName: msKds-ProvRootKey  
adminDisplayName: ms-Kds-Prov-RootKey  
adminDescription: Root keys for the Group Key Distribution Service.  
governsId: 1.2.840.113556.1.5.278  
objectClassCategory: 1  
rdnAttId: 2.5.4.3  
subClassOf: 2.5.6.0  
systemMustContain: 1.2.840.113556.1.4.2179  
systemMustContain: 1.2.840.113556.1.4.2175  
systemMustContain: 1.2.840.113556.1.4.2174  
systemMustContain: 1.2.840.113556.1.4.2173  
systemMustContain: 1.2.840.113556.1.4.2171  
systemMustContain: 1.2.840.113556.1.4.2169  
systemMustContain: 1.2.840.113556.1.4.2178  
systemMustContain: 1.2.840.113556.1.4.2177  
systemMustContain: 1.2.840.113556.1.4.2176  
systemMustContain: 2.5.4.3  
systemMayContain: 1.2.840.113556.1.4.2172  
systemMayContain: 1.2.840.113556.1.4.2170  
systemPossSuperiors: 1.2.840.113556.1.3.23  
schemaIdGuid:: Qf0CquAXGE+Gh7Ijlklzaw==  
defaultSecurityDescriptor: D:(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;EA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;DA)  
showInAdvancedViewOnly: TRUE  
defaultHidingValue: TRUE  
systemOnly: FALSE  
defaultObjectCategory: CN=ms-Kds-Prov-RootKey,CN=Schema,CN=Configuration,DC=X  
systemFlags: 16  
  
dn: CN=ms-Kds-Prov-ServerConfiguration,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: classSchema  
ldapDisplayName: msKds-ProvServerConfiguration  
adminDisplayName: ms-Kds-Prov-ServerConfiguration  
adminDescription: Configuration for the Group Key Distribution Service.  
governsId: 1.2.840.113556.1.5.277  
objectClassCategory: 1  
rdnAttId: 2.5.4.3  
subClassOf: 2.5.6.0  
systemMustContain: 1.2.840.113556.1.4.2176  
systemMayContain: 1.2.840.113556.1.4.2174  
systemMayContain: 1.2.840.113556.1.4.2173  
systemMayContain: 1.2.840.113556.1.4.2172  
systemMayContain: 1.2.840.113556.1.4.2171  
systemMayContain: 1.2.840.113556.1.4.2170  
systemMayContain: 1.2.840.113556.1.4.2169  
systemPossSuperiors: 1.2.840.113556.1.3.23  
schemaIdGuid:: qEPyXiUqpkWLcwinGuZ3zg==  
defaultSecurityDescriptor: D:(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;EA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;DA)  
showInAdvancedViewOnly: TRUE  
defaultHidingValue: TRUE  
systemOnly: FALSE  
defaultObjectCategory: CN=ms-Kds-Prov-ServerConfiguration,CN=Schema,CN=Configuration,DC=X  
systemFlags: 16  
  
dn: CN=Top,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2168  
systemMayContain: 1.2.840.113556.1.4.2188  
-  
  
dn: CN=Group,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2167  
-  
  
dn: CN=User,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2167  
-  
  
dn: CN=Computer,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2180  
systemMayContain: 1.2.840.113556.1.4.2181  
-  
  
dn: CN=Organizational-Person,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2182  
-  
  
dn: CN=ms-DS-Resource-Property,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMustContain  
systemMustContain: 1.2.840.113556.1.4.2187  
-  
  
dn: CN=ms-DS-Value-Type,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: classSchema  
ldapDisplayName: msDS-ValueType  
adminDisplayName: ms-DS-Value-Type  
adminDescription: An value type object holds value type information for a resource property.  
governsId: 1.2.840.113556.1.5.279  
objectClassCategory: 1  
rdnAttId: 2.5.4.3  
subClassOf: 2.5.6.0  
systemMustContain: 1.2.840.113556.1.4.2186  
systemMustContain: 1.2.840.113556.1.4.2160  
systemMustContain: 1.2.840.113556.1.4.2159  
systemMustContain: 1.2.840.113556.1.4.2098  
systemPossSuperiors: 1.2.840.113556.1.3.23  
schemaIdGuid:: 33/C4x2wTk+H5wVu7w65Ig==  
defaultSecurityDescriptor: D:(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;EA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;DA)  
showInAdvancedViewOnly: TRUE  
defaultHidingValue: TRUE  
systemOnly: FALSE  
defaultObjectCategory: CN=ms-DS-Value-Type,CN=Schema,CN=Configuration,DC=X  
systemFlags: 16  
  
dn:  
changetype: modify  
add: schemaUpdateNow  
schemaUpdateNow: 1  
-  
  
dn: CN=Validated-MS-DS-Behavior-Version,CN=Extended-Rights,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: controlAccessRight  
rightsGuid: d31a8757-2447-4545-8081-3bb610cacbf2  
appliesTo: f0f8ffab-1191-11d0-a060-00aa006c33ed  
displayName: Validated write to MS DS behavior version  
localizationDisplayId: 81  
validAccesses: 8  
showInAdvancedViewOnly: TRUE  
  
dn: CN=Validated-MS-DS-Additional-DNS-Host-Name,CN=Extended-Rights,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: controlAccessRight  
rightsGuid: 80863791-dbe9-4eb8-837e-7f0ab55d9ac7  
appliesTo: bf967a86-0de6-11d0-a285-00aa003049e2  
displayName: Validated write to MS DS Additional DNS Host Name  
localizationDisplayId: 82  
validAccesses: 8  
showInAdvancedViewOnly: TRUE  
  
dn: CN=Schema,CN=Configuration,DC=X  
changeType: ntdsSchemaModify  
replace: objectVersion  
objectVersion: 50  
-  
```  
  
### <a name="BKMK_Sch51"></a>Sch51.ldf  
  
```  
dn: CN=ms-DS-Transformation-Rules,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-TransformationRules  
adminDisplayName: ms-DS-Transformation-Rules  
adminDescription: Specifies the Transformation Rules for Across-Forest Claims Transformation.  
attributeId: 1.2.840.113556.1.4.2189  
attributeSyntax: 2.5.5.12  
omSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
schemaIdGuid:: cSuHVbLESDuuUUCV+R7GAA==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-Applies-To-Resource-Types,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-AppliesToResourceTypes  
adminDisplayName: ms-DS-Applies-To-Resource-Types  
adminDescription: For a resource property, this attribute indicates what resource types this resource property applies to.  
attributeId: 1.2.840.113556.1.4.2195  
attributeSyntax: 2.5.5.12  
omSyntax: 64  
isSingleValued: FALSE  
systemOnly: FALSE  
searchFlags: 0  
schemaIdGuid:: BiA/aWRXSj2EOVjwSqtLWQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-Transformation-Rules-Compiled,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-TransformationRulesCompiled  
adminDisplayName: ms-DS-Transformation-Rules-Compiled  
adminDescription: Blob containing compiled transformation rules.  
attributeId: 1.2.840.113556.1.4.2190  
attributeSyntax: 2.5.5.10  
omSyntax: 4  
isSingleValued: TRUE  
systemOnly: TRUE  
searchFlags: 128  
schemaIdGuid:: EJq0C2tTTbyicwurDdS9EA==  
showInAdvancedViewOnly: TRUE  
systemFlags: 17  
  
dn: CN=ms-DS-Egress-Claims-Transformation-Policy,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-EgressClaimsTransformationPolicy  
adminDisplayName: ms-DS-Egress-Claims-Transformation-Policy  
adminDescription: This is a link to a Claims Transformation Policy Object for the egress claims (claims leaving this forest) to the Trusted Domain. This is applicable only for an incoming or bidirectional Across-Forest Trust. When this link is not present, all claims are allowed to egress as-is.  
attributeId: 1.2.840.113556.1.4.2192  
attributeSyntax: 2.5.5.1  
omSyntax: 127  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
omObjectClass:: KwwCh3McAIVK  
schemaIdGuid:: fkI3wXOaQLCRkBsJW7QyiA==  
linkID: 2192  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-Ingress-Claims-Transformation-Policy,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-IngressClaimsTransformationPolicy  
adminDisplayName: ms-DS-Ingress-Claims-Transformation-Policy  
adminDescription: This is a link to a Claims Transformation Policy Object for the ingress claims (claims entering this forest) from the Trusted Domain. This is applicable only for an outgoing or bidirectional Across-Forest Trust. If this link is absent, all the ingress claims are dropped.  
attributeId: 1.2.840.113556.1.4.2191  
attributeSyntax: 2.5.5.1  
omSyntax: 127  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
omObjectClass:: KwwCh3McAIVK  
schemaIdGuid:: CEwohm4MQBWLFXUUfSPSDQ==  
linkID: 2190  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-TDO-Egress-BL,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-TDOEgressBL  
adminDisplayName: ms-DS-TDO-Egress-BL  
adminDescription: Backlink to TDO Egress rules link on object.  
attributeId: 1.2.840.113556.1.4.2194  
attributeSyntax: 2.5.5.1  
omSyntax: 127  
isSingleValued: FALSE  
systemOnly: TRUE  
searchFlags: 0  
omObjectClass:: KwwCh3McAIVK  
schemaIdGuid:: KWIA1ROZQiKLF4N2HR4OWw==  
linkID: 2193  
showInAdvancedViewOnly: TRUE  
systemFlags: 17  
  
dn: CN=ms-DS-TDO-Ingress-BL,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-TDOIngressBL  
adminDisplayName: ms-DS-TDO-Ingress-BL  
adminDescription: Backlink to TDO Ingress rules link on object.  
attributeId: 1.2.840.113556.1.4.2193  
attributeSyntax: 2.5.5.1  
omSyntax: 127  
isSingleValued: FALSE  
systemOnly: TRUE  
searchFlags: 0  
omObjectClass:: KwwCh3McAIVK  
schemaIdGuid:: oWFWWsaXS1SAVuQw/nvFVA==  
linkID: 2191  
showInAdvancedViewOnly: TRUE  
systemFlags: 17  
  
dn: CN=ms-DS-ManagedPassword,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-ManagedPassword  
adminDisplayName: msDS-ManagedPassword  
adminDescription: This attribute is the managed password data for a group MSA.  
attributeId: 1.2.840.113556.1.4.2196  
attributeSyntax: 2.5.5.10  
omSyntax: 4  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
schemaIdGuid:: hu1i4yi3QgiyfS3qep3yGA==  
showInAdvancedViewOnly: TRUE  
systemFlags: 20  
  
dn: CN=ms-DS-ManagedPasswordId,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-ManagedPasswordId  
adminDisplayName: msDS-ManagedPasswordId  
adminDescription: This attribute is the identifier for the current managed password data for a group MSA.  
attributeId: 1.2.840.113556.1.4.2197  
attributeSyntax: 2.5.5.10  
omSyntax: 4  
isSingleValued: TRUE  
systemOnly: TRUE  
searchFlags: 0  
rangeUpper: 1024  
schemaIdGuid:: Wil4DtPGQAq0kdYiUf+gpg==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-GroupMSAMembership,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-GroupMSAMembership  
adminDisplayName: msDS-GroupMSAMembership  
adminDescription: This attribute is used for access checks to determine if a requester has permission to retrieve the password for a group MSA.  
attributeId: 1.2.840.113556.1.4.2200  
attributeSyntax: 2.5.5.15  
omSyntax: 66  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
rangeUpper: 132096  
schemaIdGuid:: 1u2OiATOQN+0YrilDkG6OA==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-GeoCoordinates-Altitude,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-GeoCoordinatesAltitude  
adminDisplayName: ms-DS-GeoCoordinates-Altitude  
adminDescription: ms-DS-GeoCoordinates-Altitude  
attributeId: 1.2.840.113556.1.4.2183  
attributeSyntax: 2.5.5.16  
omSyntax: 65  
isSingleValued: TRUE  
searchFlags: 1  
schemaIdGuid:: twMXoUFWnE2GPl+zMl504A==  
attributeSecurityGuid:: hri1d0qU0RGuvQAA+ANnwQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-GeoCoordinates-Latitude,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-GeoCoordinatesLatitude  
adminDisplayName: ms-DS-GeoCoordinates-Latitude  
adminDescription: ms-DS-GeoCoordinates-Latitude  
attributeId: 1.2.840.113556.1.4.2184  
attributeSyntax: 2.5.5.16  
omSyntax: 65  
isSingleValued: TRUE  
searchFlags: 1  
schemaIdGuid:: TtRm3EM99UCFxTwS4WmSfg==  
attributeSecurityGuid:: hri1d0qU0RGuvQAA+ANnwQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-GeoCoordinates-Longitude,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-GeoCoordinatesLongitude  
adminDisplayName: ms-DS-GeoCoordinates-Longitude  
adminDescription: ms-DS-GeoCoordinates-Longitude  
attributeId: 1.2.840.113556.1.4.2185  
attributeSyntax: 2.5.5.16  
omSyntax: 65  
isSingleValued: TRUE  
searchFlags: 1  
schemaIdGuid:: ECHElOS66kyFd6+BOvXaJQ==  
attributeSecurityGuid:: hri1d0qU0RGuvQAA+ANnwQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-ManagedPasswordInterval,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-ManagedPasswordInterval  
adminDisplayName: msDS-ManagedPasswordInterval  
adminDescription: This attribute is used to retrieve the number of days before a managed password is automatically changed for a group MSA.  
attributeId: 1.2.840.113556.1.4.2199  
attributeSyntax: 2.5.5.9  
omSyntax: 2  
isSingleValued: TRUE  
systemOnly: TRUE  
searchFlags: 0  
schemaIdGuid:: 9451+HasQ4ii7qJrTcr0CQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-ManagedPasswordPreviousId,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-ManagedPasswordPreviousId  
adminDisplayName: msDS-ManagedPasswordPreviousId  
adminDescription: This attribute is the identifier for the previous managed password data for a group MSA.  
attributeId: 1.2.840.113556.1.4.2198  
attributeSyntax: 2.5.5.10  
omSyntax: 4  
isSingleValued: TRUE  
systemOnly: TRUE  
searchFlags: 0  
rangeUpper: 1024  
schemaIdGuid:: MSHW0EotT9CZ2RxjZGIppA==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn:  
changetype: modify  
add: schemaUpdateNow  
schemaUpdateNow: 1  
-  
  
dn: CN=ms-DS-Claims-Transformation-Policies,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: classSchema  
ldapDisplayName: msDS-ClaimsTransformationPolicies  
adminDisplayName: ms-DS-Claims-Transformation-Policies  
adminDescription: An object of this class holds the one set of Claims Transformation Policy for Across-Forest Claims Transformation.  
governsId: 1.2.840.113556.1.5.281  
objectClassCategory: 1  
rdnAttId: 2.5.4.3  
subClassOf: 2.5.6.0  
systemPossSuperiors: 1.2.840.113556.1.3.23  
schemaIdGuid:: san8yIh9T7uCekSJJ3EHYg==  
defaultSecurityDescriptor: D:(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;EA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)  
showInAdvancedViewOnly: TRUE  
defaultHidingValue: TRUE  
systemOnly: FALSE  
defaultObjectCategory: CN=ms-DS-Claims-Transformation-Policies,CN=Schema,CN=Configuration,DC=X  
systemFlags: 16  
  
dn: CN=ms-DS-Claims-Transformation-Policy-Type,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: classSchema  
ldapDisplayName: msDS-ClaimsTransformationPolicyType  
adminDisplayName: ms-DS-Claims-Transformation-Policy-Type  
adminDescription: An object of this class holds the one set of Claims Transformation Policy for Across-Forest Claims Transformation.  
governsId: 1.2.840.113556.1.5.280  
objectClassCategory: 1  
rdnAttId: 2.5.4.3  
subClassOf: 2.5.6.0  
systemMayContain: 1.2.840.113556.1.4.2190  
systemMayContain: 1.2.840.113556.1.4.2189  
systemPossSuperiors: 1.2.840.113556.1.5.281  
schemaIdGuid:: s2LrLnMTRf6BATh/Fnbtxw==  
defaultSecurityDescriptor: D:(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;EA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)  
showInAdvancedViewOnly: TRUE  
defaultHidingValue: TRUE  
systemOnly: FALSE  
defaultObjectCategory: CN=ms-DS-Claims-Transformation-Policy-Type,CN=Schema,CN=Configuration,DC=X  
systemFlags: 16  
  
dn: CN=Top,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2193  
systemMayContain: 1.2.840.113556.1.4.2194  
-  
  
dn: CN=Trusted-Domain,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2191  
systemMayContain: 1.2.840.113556.1.4.2192  
-  
  
dn: CN=ms-DS-Resource-Property,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2195  
-  
  
dn: CN=Mail-Recipient,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: mayContain  
mayContain: 1.2.840.113556.1.4.2183  
mayContain: 1.2.840.113556.1.4.2184  
mayContain: 1.2.840.113556.1.4.2185  
-  
  
dn: CN=ms-DS-Group-Managed-Service-Account,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: classSchema  
ldapDisplayName: msDS-GroupManagedServiceAccount  
adminDisplayName: msDS-Group-Managed-Service-Account  
adminDescription: The group managed service account class is used to create an account which can be shared by different computers to run Windows services.  
governsId: 1.2.840.113556.1.5.282  
objectClassCategory: 1  
rdnAttId: 2.5.4.3  
subClassOf: 1.2.840.113556.1.3.30  
systemMustContain: 1.2.840.113556.1.4.2199  
systemMayContain: 1.2.840.113556.1.4.2200  
systemMayContain: 1.2.840.113556.1.4.2198  
systemMayContain: 1.2.840.113556.1.4.2197  
systemMayContain: 1.2.840.113556.1.4.2196  
systemPossSuperiors: 1.2.840.113556.1.3.30  
systemPossSuperiors: 1.2.840.113556.1.3.23  
systemPossSuperiors: 2.5.6.5  
systemPossSuperiors: 1.2.840.113556.1.5.67  
schemaIdGuid:: ilWLe6WT90qtysAX5n8QVw==  
defaultSecurityDescriptor: D:(OD;;CR;00299570-246d-11d0-a768-00aa006e0529;;WD)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;DA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;AO)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)(A;;RPCRLCLORCSDDT;;;CO)(OA;;WP;4c164200-20c0-11d0-a768-00aa006e0529;;CO)(OA;;SW;72e39547-7b18-11d1-adef-00c04fd8d5cd;;CO)(OA;;SW;f3a64788-5306-11d1-a9c5-0000f80367c1;;CO)(OA;;WP;3e0abfd0-126a-11d0-a060-00aa006c33ed;bf967a86-0de6-11d0-a285-00aa003049e2;CO)(OA;;WP;5f202010-79a5-11d0-9020-00c04fc2d4cf;bf967a86-0de6-11d0-a285-00aa003049e2;CO)(OA;;WP;bf967950-0de6-11d0-a285-00aa003049e2;bf967a86-0de6-11d0-a285-00aa003049e2;CO)(OA;;WP;bf967953-0de6-11d0-a285-00aa003049e2;bf967a86-0de6-11d0-a285-00aa003049e2;CO)(OA;;SW;f3a64788-5306-11d1-a9c5-0000f80367c1;;PS)(OA;;RPWP;77B5B886-944A-11d1-AEBD-0000F80367C1;;PS)(OA;;SW;72e39547-7b18-11d1-adef-00c04fd8d5cd;;PS)(A;;RPLCLORC;;;AU)(OA;;RPWP;bf967a7f-0de6-11d0-a285-00aa003049e2;;CA)(OA;;RP;46a9b11d-60ae-405a-b7e8-ff8a58d456d2;;S-1-5-32-560)(OA;;RP;e362ed86-b728-0842-b27d-2dea7a9df218;;WD)  
showInAdvancedViewOnly: TRUE  
defaultHidingValue: FALSE  
systemOnly: FALSE  
defaultObjectCategory: CN=ms-DS-Group-Managed-Service-Account,CN=Schema,CN=Configuration,DC=X  
systemFlags: 16  
  
dn:  
changetype: modify  
add: schemaUpdateNow  
schemaUpdateNow: 1  
-  
  
dn: CN=Schema,CN=Configuration,DC=X  
changeType: ntdsSchemaModify  
replace: objectVersion  
objectVersion: 51  
-  
```  
  
### <a name="BKMK_Sch52"></a>Sch52.ldf  
  
```  
dn: CN=ms-DS-RID-Pool-Allocation-Enabled,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-RIDPoolAllocationEnabled  
adminDisplayName: ms-DS-RID-Pool-Allocation-Enabled  
adminDescription: This attribute indicates whether RID pool allocation is enabled or not.  
attributeId: 1.2.840.113556.1.4.2213  
attributeSyntax: 2.5.5.8  
omSyntax: 1  
instanceType: 4  
isSingleValued: TRUE  
systemOnly: TRUE  
searchFlags: 0  
schemaFlagsEx: 1  
schemaIdGuid:: jHyXJLfBQDO09is3XrcR1w==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=RID-Set-References,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
replace: searchFlags  
searchFlags: 8  
-  
  
dn: CN=Netboot-DUID,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: Netboot-DUID  
ldapDisplayName: netbootDUID  
adminDisplayName: Netboot-DUID  
adminDescription: This attribute is used to store DHCPv6 DUID device ID.  
attributeId: 1.2.840.113556.1.4.2234  
attributeSyntax: 2.5.5.10  
omSyntax: 4  
instanceType: 4  
isSingleValued: TRUE  
searchFlags: 1  
systemFlags: 16  
isMemberOfPartialAttributeSet: TRUE  
systemOnly: FALSE  
rangeLower: 2  
rangeUpper: 128  
schemaIdGuid:: vXAlU3c9T0KCLw1jbcbarQ==  
showInAdvancedViewOnly: TRUE  
  
dn:  
changetype: modify  
add: schemaUpdateNow  
schemaUpdateNow: 1  
-  
  
dn: CN=RID-Manager,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2213  
-  
  
dn: CN=domainDNS-Display,CN=409,CN=DisplaySpecifiers,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: adminContextMenu  
adminContextMenu: 3,{2fb1b669-59ea-4f64-b728-05309f2c11c8}  
-  
  
dn: CN=computer-Display,CN=409,CN=DisplaySpecifiers,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: adminPropertyPages  
adminPropertyPages: 13,{2fb1b669-59ea-4f64-b728-05309f2c11c8}  
-  
  
dn: CN=Certificate-AutoEnrollment,CN=Extended-Rights,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: controlAccessRight  
showInAdvancedViewOnly: TRUE  
appliesTo: e5209ca2-3bba-11d2-90cc-00c04fd91ab1  
displayname: AutoEnrollment  
localizationDisplayId: 83  
rightsGuid: a05b8cc2-17bc-4802-a710-e7c15ab866a2  
validAccesses: 256  
  
# Update element: computer  
dn: CN=Computer,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: mayContain  
mayContain: 1.2.840.113556.1.4.2234  
-  
  
dn: CN=ms-DS-cloudExtensionAttribute1,CN=Schema,CN=Configuration,dc=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-cloudExtensionAttribute1  
lDAPDisplayName: msDS-cloudExtensionAttribute1  
adminDisplayName: ms-DS-cloudExtensionAttribute1  
adminDescription: An attribute used to house an arbitrary cloud-relevant string  
attributeID: 1.2.840.113556.1.4.2214  
attributeSyntax: 2.5.5.12  
oMSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 1  
isMemberOfPartialAttributeSet: TRUE  
schemaIDGUID:: r+oJl9pJsk2QigRG5eq4RA==  
attributeSecurityGUID:: hri1d0qU0RGuvQAA+ANnwQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-cloudExtensionAttribute2,CN=Schema,CN=Configuration,dc=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-cloudExtensionAttribute2  
lDAPDisplayName: msDS-cloudExtensionAttribute2  
adminDisplayName: ms-DS-cloudExtensionAttribute2  
adminDescription: An attribute used to house an arbitrary cloud-relevant string  
attributeID: 1.2.840.113556.1.4.2215  
attributeSyntax: 2.5.5.12  
oMSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 1  
isMemberOfPartialAttributeSet: TRUE  
schemaIDGUID:: rOBO88HAqUuCyRqQdS8WpQ==  
attributeSecurityGUID:: hri1d0qU0RGuvQAA+ANnwQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-cloudExtensionAttribute3,CN=Schema,CN=Configuration,dc=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-cloudExtensionAttribute3  
lDAPDisplayName: msDS-cloudExtensionAttribute3  
adminDisplayName: ms-DS-cloudExtensionAttribute3  
adminDescription: An attribute used to house an arbitrary cloud-relevant string  
attributeID: 1.2.840.113556.1.4.2216  
attributeSyntax: 2.5.5.12  
oMSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 1  
isMemberOfPartialAttributeSet: TRUE  
schemaIDGUID:: Gsj2gtr6DUqw93BtRoOOtQ==  
attributeSecurityGUID:: hri1d0qU0RGuvQAA+ANnwQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-cloudExtensionAttribute4,CN=Schema,CN=Configuration,dc=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-cloudExtensionAttribute4  
lDAPDisplayName: msDS-cloudExtensionAttribute4  
adminDisplayName: ms-DS-cloudExtensionAttribute4  
adminDescription: An attribute used to house an arbitrary cloud-relevant string  
attributeID: 1.2.840.113556.1.4.2217  
attributeSyntax: 2.5.5.12  
oMSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 1  
isMemberOfPartialAttributeSet: TRUE  
schemaIDGUID:: NzS/nG5OW0iykSKwJVQnPw==  
attributeSecurityGUID:: hri1d0qU0RGuvQAA+ANnwQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-cloudExtensionAttribute5,CN=Schema,CN=Configuration,dc=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-cloudExtensionAttribute5  
lDAPDisplayName: msDS-cloudExtensionAttribute5  
adminDisplayName: ms-DS-cloudExtensionAttribute5  
adminDescription: An attribute used to house an arbitrary cloud-relevant string  
attributeID: 1.2.840.113556.1.4.2218  
attributeSyntax: 2.5.5.12  
oMSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 1  
isMemberOfPartialAttributeSet: TRUE  
schemaIDGUID:: W+gVKUfjUkiquyLlplHIZA==  
attributeSecurityGUID:: hri1d0qU0RGuvQAA+ANnwQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-cloudExtensionAttribute6,CN=Schema,CN=Configuration,dc=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-cloudExtensionAttribute6  
lDAPDisplayName: msDS-cloudExtensionAttribute6  
adminDisplayName: ms-DS-cloudExtensionAttribute6  
adminDescription: An attribute used to house an arbitrary cloud-relevant string  
attributeID: 1.2.840.113556.1.4.2219  
attributeSyntax: 2.5.5.12  
oMSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 1  
isMemberOfPartialAttributeSet: TRUE  
schemaIDGUID:: eSZFYOEo7Eus43EoMzYUVg==  
attributeSecurityGUID:: hri1d0qU0RGuvQAA+ANnwQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-cloudExtensionAttribute7,CN=Schema,CN=Configuration,dc=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-cloudExtensionAttribute7  
lDAPDisplayName: msDS-cloudExtensionAttribute7  
adminDisplayName: ms-DS-cloudExtensionAttribute7  
adminDescription: An attribute used to house an arbitrary cloud-relevant string  
attributeID: 1.2.840.113556.1.4.2220  
attributeSyntax: 2.5.5.12  
oMSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 1  
isMemberOfPartialAttributeSet: TRUE  
schemaIDGUID:: GRN8Sk7jwkCdAGD/eJDyBw==  
attributeSecurityGUID:: hri1d0qU0RGuvQAA+ANnwQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-cloudExtensionAttribute8,CN=Schema,CN=Configuration,dc=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-cloudExtensionAttribute8  
lDAPDisplayName: msDS-cloudExtensionAttribute8  
adminDisplayName: ms-DS-cloudExtensionAttribute8  
adminDescription: An attribute used to house an arbitrary cloud-relevant string  
attributeID: 1.2.840.113556.1.4.2221  
attributeSyntax: 2.5.5.12  
oMSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 1  
isMemberOfPartialAttributeSet: TRUE  
schemaIDGUID:: FMXRPEmEykSBwAIXgYANKg==  
attributeSecurityGUID:: hri1d0qU0RGuvQAA+ANnwQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-cloudExtensionAttribute9,CN=Schema,CN=Configuration,dc=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-cloudExtensionAttribute9  
lDAPDisplayName: msDS-cloudExtensionAttribute9  
adminDisplayName: ms-DS-cloudExtensionAttribute9  
adminDescription: An attribute used to house an arbitrary cloud-relevant string  
attributeID: 1.2.840.113556.1.4.2222  
attributeSyntax: 2.5.5.12  
oMSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 1  
isMemberOfPartialAttributeSet: TRUE  
schemaIDGUID:: LOFjCkAwQUSuJs2Vrw0kfg==  
attributeSecurityGUID:: hri1d0qU0RGuvQAA+ANnwQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-cloudExtensionAttribute10,CN=Schema,CN=Configuration,dc=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-cloudExtensionAttribute10  
lDAPDisplayName: msDS-cloudExtensionAttribute10  
adminDisplayName: ms-DS-cloudExtensionAttribute10  
adminDescription: An attribute used to house an arbitrary cloud-relevant string  
attributeID: 1.2.840.113556.1.4.2223  
attributeSyntax: 2.5.5.12  
oMSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 1  
isMemberOfPartialAttributeSet: TRUE  
schemaIDGUID:: s/wKZ70T/EeQswpSftgatw==  
attributeSecurityGUID:: hri1d0qU0RGuvQAA+ANnwQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-cloudExtensionAttribute11,CN=Schema,CN=Configuration,dc=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-cloudExtensionAttribute11  
lDAPDisplayName: msDS-cloudExtensionAttribute11  
adminDisplayName: ms-DS-cloudExtensionAttribute11  
adminDescription: An attribute used to house an arbitrary cloud-relevant string  
attributeID: 1.2.840.113556.1.4.2224  
attributeSyntax: 2.5.5.12  
oMSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 1  
isMemberOfPartialAttributeSet: TRUE  
schemaIDGUID:: yLuenqV9pkKJJSROEqVuJA==  
attributeSecurityGUID:: hri1d0qU0RGuvQAA+ANnwQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-cloudExtensionAttribute12,CN=Schema,CN=Configuration,dc=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-cloudExtensionAttribute12  
lDAPDisplayName: msDS-cloudExtensionAttribute12  
adminDisplayName: ms-DS-cloudExtensionAttribute12  
adminDescription: An attribute used to house an arbitrary cloud-relevant string  
attributeID: 1.2.840.113556.1.4.2225  
attributeSyntax: 2.5.5.12  
oMSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 1  
isMemberOfPartialAttributeSet: TRUE  
schemaIDGUID:: PcQBPAvhyk+Sskz2FdWwmg==  
attributeSecurityGUID:: hri1d0qU0RGuvQAA+ANnwQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-cloudExtensionAttribute13,CN=Schema,CN=Configuration,dc=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-cloudExtensionAttribute13  
lDAPDisplayName: msDS-cloudExtensionAttribute13  
adminDisplayName: ms-DS-cloudExtensionAttribute13  
adminDescription: An attribute used to house an arbitrary cloud-relevant string  
attributeID: 1.2.840.113556.1.4.2226  
attributeSyntax: 2.5.5.12  
oMSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 1  
isMemberOfPartialAttributeSet: TRUE  
schemaIDGUID:: S0a+KJCreUumsN9DdDHQNg==  
attributeSecurityGUID:: hri1d0qU0RGuvQAA+ANnwQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-cloudExtensionAttribute14,CN=Schema,CN=Configuration,dc=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-cloudExtensionAttribute14  
lDAPDisplayName: msDS-cloudExtensionAttribute14  
adminDisplayName: ms-DS-cloudExtensionAttribute14  
adminDescription: An attribute used to house an arbitrary cloud-relevant string  
attributeID: 1.2.840.113556.1.4.2227  
attributeSyntax: 2.5.5.12  
oMSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 1  
isMemberOfPartialAttributeSet: TRUE  
schemaIDGUID:: ura8zoBuJ0mFYJj+yghqnw==  
attributeSecurityGUID:: hri1d0qU0RGuvQAA+ANnwQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-cloudExtensionAttribute15,CN=Schema,CN=Configuration,dc=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-cloudExtensionAttribute15  
lDAPDisplayName: msDS-cloudExtensionAttribute15  
adminDisplayName: ms-DS-cloudExtensionAttribute15  
adminDescription: An attribute used to house an arbitrary cloud-relevant string  
attributeID: 1.2.840.113556.1.4.2228  
attributeSyntax: 2.5.5.12  
oMSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 1  
isMemberOfPartialAttributeSet: TRUE  
schemaIDGUID:: N9XkqvCKqk2cxmLq24T/Aw==  
attributeSecurityGUID:: hri1d0qU0RGuvQAA+ANnwQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-cloudExtensionAttribute16,CN=Schema,CN=Configuration,dc=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-cloudExtensionAttribute16  
lDAPDisplayName: msDS-cloudExtensionAttribute16  
adminDisplayName: ms-DS-cloudExtensionAttribute16  
adminDescription: An attribute used to house an arbitrary cloud-relevant string  
attributeID: 1.2.840.113556.1.4.2229  
attributeSyntax: 2.5.5.12  
oMSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 1  
isMemberOfPartialAttributeSet: TRUE  
schemaIDGUID:: WyGBlZZRU0ChHm/8r8YsTQ==  
attributeSecurityGUID:: hri1d0qU0RGuvQAA+ANnwQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-cloudExtensionAttribute17,CN=Schema,CN=Configuration,dc=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-cloudExtensionAttribute17  
lDAPDisplayName: msDS-cloudExtensionAttribute17  
adminDisplayName: ms-DS-cloudExtensionAttribute17  
adminDescription: An attribute used to house an arbitrary cloud-relevant string  
attributeID: 1.2.840.113556.1.4.2230  
attributeSyntax: 2.5.5.12  
oMSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 1  
isMemberOfPartialAttributeSet: TRUE  
schemaIDGUID:: 2m08PehrKUKWfi/1u5O0zg==  
attributeSecurityGUID:: hri1d0qU0RGuvQAA+ANnwQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-cloudExtensionAttribute18,CN=Schema,CN=Configuration,dc=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-cloudExtensionAttribute18  
lDAPDisplayName: msDS-cloudExtensionAttribute18  
adminDisplayName: ms-DS-cloudExtensionAttribute18  
adminDescription: An attribute used to house an arbitrary cloud-relevant string  
attributeID: 1.2.840.113556.1.4.2231  
attributeSyntax: 2.5.5.12  
oMSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 1  
isMemberOfPartialAttributeSet: TRUE  
schemaIDGUID:: NDvniKYKaUSYQm6wGzKltQ==  
attributeSecurityGUID:: hri1d0qU0RGuvQAA+ANnwQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-cloudExtensionAttribute19,CN=Schema,CN=Configuration,dc=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-cloudExtensionAttribute19  
lDAPDisplayName: msDS-cloudExtensionAttribute19  
adminDisplayName: ms-DS-cloudExtensionAttribute19  
adminDescription: An attribute used to house an arbitrary cloud-relevant string  
attributeID: 1.2.840.113556.1.4.2232  
attributeSyntax: 2.5.5.12  
oMSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 1  
isMemberOfPartialAttributeSet: TRUE  
schemaIDGUID:: mf51CQeWikaOGMgA0zhzlQ==  
attributeSecurityGUID:: hri1d0qU0RGuvQAA+ANnwQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-cloudExtensionAttribute20,CN=Schema,CN=Configuration,dc=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
cn: ms-DS-cloudExtensionAttribute20  
lDAPDisplayName: msDS-cloudExtensionAttribute20  
adminDisplayName: ms-DS-cloudExtensionAttribute20  
adminDescription: An attribute used to house an arbitrary cloud-relevant string  
attributeID: 1.2.840.113556.1.4.2233  
attributeSyntax: 2.5.5.12  
oMSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 1  
isMemberOfPartialAttributeSet: TRUE  
schemaIDGUID:: KGNE9W6LjUmVqCEXSNWs3A==  
attributeSecurityGUID:: hri1d0qU0RGuvQAA+ANnwQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-Cloud-Extensions,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: classSchema  
ldapDisplayName: msDS-CloudExtensions  
adminDisplayName: ms-DS-Cloud-Extensions  
adminDescription: A collection of attributes used to house arbitrary cloud-relevant strings.  
governsId: 1.2.840.113556.1.5.283  
objectClassCategory: 3  
rdnAttId: 2.5.4.3  
subClassOf: 2.5.6.0  
MayContain: 1.2.840.113556.1.4.2214  
MayContain: 1.2.840.113556.1.4.2215  
MayContain: 1.2.840.113556.1.4.2216  
MayContain: 1.2.840.113556.1.4.2217  
MayContain: 1.2.840.113556.1.4.2218  
MayContain: 1.2.840.113556.1.4.2219  
MayContain: 1.2.840.113556.1.4.2220  
MayContain: 1.2.840.113556.1.4.2221  
MayContain: 1.2.840.113556.1.4.2222  
MayContain: 1.2.840.113556.1.4.2223  
MayContain: 1.2.840.113556.1.4.2224  
MayContain: 1.2.840.113556.1.4.2225  
MayContain: 1.2.840.113556.1.4.2226  
MayContain: 1.2.840.113556.1.4.2227  
MayContain: 1.2.840.113556.1.4.2228  
MayContain: 1.2.840.113556.1.4.2229  
MayContain: 1.2.840.113556.1.4.2230  
MayContain: 1.2.840.113556.1.4.2231  
MayContain: 1.2.840.113556.1.4.2232  
MayContain: 1.2.840.113556.1.4.2233  
schemaIdGuid:: pIceZCaDcUe6LccG3zXjWg==  
defaultSecurityDescriptor: D:(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;DA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)(A;;RPLCLORC;;;AU)  
showInAdvancedViewOnly: TRUE  
defaultHidingValue: TRUE  
systemOnly: FALSE  
defaultObjectCategory: CN=ms-DS-Cloud-Extensions,CN=Schema,CN=Configuration,DC=X  
systemFlags: 16  
  
dn: CN=User,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemAuxiliaryClass  
systemAuxiliaryClass: 1.2.840.113556.1.5.283  
-  
  
dn: CN=Personal-Information,CN=Extended-Rights,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: appliesTo  
appliesTo: 641E87A4-8326-4771-BA2D-C706DF35E35A  
-  
  
dn: CN=Schema,CN=Configuration,DC=X  
changeType: ntdsSchemaModify  
replace: objectVersion  
objectVersion: 52  
-  
```  
  
### <a name="BKMK_Sch53"></a>Sch53.ldf  
  
```  
dn: CN=ms-Authz-Central-Access-Rule,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2156  
-  
  
dn: CN=Schema,CN=Configuration,DC=X  
changeType: ntdsSchemaModify  
replace: objectVersion  
objectVersion: 53  
-  
```  
  
### <a name="BKMK_Sch54"></a>Sch54.ldf  
  
```  
dn: CN=User-Account-Restrictions,CN=Extended-Rights,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: appliesTo  
appliesTo: 7b8b558a-93a5-4af7-adca-c017e67f1057  
-  
  
dn: CN=ms-DS-Allowed-To-Act-On-Behalf-Of-Other-Identity,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
replace: attributeSecurityGuid  
attributeSecurityGuid:: AEIWTMAg0BGnaACqAG4FKQ==  
-  
  
dn: CN=Schema,CN=Configuration,DC=X  
changeType: ntdsSchemaModify  
replace: objectVersion  
objectVersion: 54  
-  
```  
  
### <a name="BKMK_Sch55"></a>Sch55.ldf  
  
```  
dn: CN=DNS-Host-Name-Attributes,CN=Extended-Rights,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: appliesTo  
appliesTo: 7b8b558a-93a5-4af7-adca-c017e67f1057  
-  
  
dn: CN=Validated-DNS-Host-Name,CN=Extended-Rights,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: appliesTo  
appliesTo: 7b8b558a-93a5-4af7-adca-c017e67f1057  
-  
  
dn: CN=Schema,CN=Configuration,DC=X  
changeType: ntdsSchemaModify  
replace: objectVersion  
objectVersion: 55  
-  
```  
  
### <a name="BKMK_Sch56"></a>Sch56.ldf  
  
```  
# Update element: computer. Remove netboot-DUID from mayContain  
dn: CN=Computer,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
delete: mayContain  
mayContain: 1.2.840.113556.1.4.2234  
-  
  
# Update element: computer. Add netboot-DUID to SystemMayContain  
dn: CN=Computer,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2234  
-  
  
dn: CN=Schema,CN=Configuration,DC=X  
changeType: ntdsSchemaModify  
replace: objectVersion  
objectVersion: 56  
-  
```  
  


