---
title: Sch45.ldf
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: bd0b082f-2afe-4e2a-80bc-2f10c18f618b
author: Femila
---
# Sch45.ldf
    
```  
DN: CN=ms-DS-USN-Last-Sync-Success,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
adminDisplayName: ms-DS-USN-Last-Sync-Success  
adminDescription: The USN at which the last successful replication synchronization occurred.  
attributeID: 1.2.840.113556.1.4.2055  
attributeSyntax: 2.5.5.16  
isSingleValued: TRUE  
lDAPDisplayName: msDS-USNLastSyncSuccess  
objectCategory: CN=Attribute-Schema,CN=Schema,CN=Configuration,DC=X  
objectClass: attributeSchema  
oMSyntax: 65  
schemaFlagsEx: 1  
searchFlags: 0  
schemaIDGUID:: trj3MfjJLU+je1ioIwMDMQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 25  
systemOnly: FALSE  
  
dn: CN=Is-Recycled,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: isRecycled  
adminDisplayName: Is-Recycled  
adminDescription: Is the object recycled.  
attributeId: 1.2.840.113556.1.4.2058  
attributeSyntax: 2.5.5.8  
omSyntax: 1  
isSingleValued: TRUE  
systemOnly: TRUE  
schemaFlagsEx: 1  
searchFlags: 8  
schemaIdGuid:: VpK1j/FVS0Sqy/W0gv40WQ==  
showInAdvancedViewOnly: TRUE  
isMemberOfPartialAttributeSet: TRUE  
systemFlags: 18  
  
dn: CN=ms-DS-Optional-Feature-GUID,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-OptionalFeatureGUID  
adminDisplayName: ms-DS-Optional-Feature-GUID  
adminDescription: GUID of an optional feature.  
attributeId: 1.2.840.113556.1.4.2062  
attributeSyntax: 2.5.5.10  
omSyntax: 4  
isSingleValued: TRUE  
schemaFlagsEx: 1  
systemOnly: TRUE  
searchFlags: 0  
rangeLower: 16  
rangeUpper: 16  
schemaIdGuid:: qL2Im4LdmEmpHV8tK68ZJw==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-Enabled-Feature,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-EnabledFeature  
adminDisplayName: ms-DS-Enabled-Feature  
adminDescription: Enabled optional features.  
attributeId: 1.2.840.113556.1.4.2061  
attributeSyntax: 2.5.5.1  
omSyntax: 127  
schemaFlagsEx: 1  
isSingleValued: FALSE  
systemOnly: TRUE  
searchFlags: 0  
omObjectClass:: KwwCh3McAIVK  
schemaIdGuid:: r64GV0C5sk+8/FJoaDrZ/g==  
linkID: 2168  
isMemberOfPartialAttributeSet: TRUE  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-Imaging-PSP-String,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msImaging-PSPString  
adminDisplayName: ms-Imaging-PSP-String  
adminDescription: Schema Attribute that contains the XML sequence for this PostScan Process.  
attributeId: 1.2.840.113556.1.4.2054  
attributeSyntax: 2.5.5.12  
omSyntax: 64  
schemaFlagsEx: 1  
isSingleValued: TRUE  
searchFlags: 0  
rangeUpper: 524288  
schemaIdGuid:: rmBne+3WpkS2vp3mLAnsZw==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-OIDToGroup-Link,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-OIDToGroupLink  
adminDisplayName: ms-DS-OIDToGroup-Link  
adminDescription: For an OID, identifies the group object corresponding to the issuance policy represented by this OID.  
attributeId: 1.2.840.113556.1.4.2051  
attributeSyntax: 2.5.5.1  
omSyntax: 127  
isSingleValued: TRUE  
systemOnly: FALSE  
schemaFlagsEx: 1  
searchFlags: 0  
omObjectClass:: KwwCh3McAIVK  
schemaIdGuid:: fKXJ+UE5jUO+vw7a8qyhhw==  
linkID: 2164  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-OIDToGroup-Link-BL,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-OIDToGroupLinkBl  
adminDisplayName: ms-DS-OIDToGroup-Link-BL  
adminDescription: Backlink for ms-DS-OIDToGroup-Link; identifies the issuance policy, represented by an OID object, which is mapped to this group.  
attributeId: 1.2.840.113556.1.4.2052  
attributeSyntax: 2.5.5.1  
omSyntax: 127  
isSingleValued: FALSE  
systemOnly: TRUE  
schemaFlagsEx: 1  
searchFlags: 0  
omObjectClass:: KwwCh3McAIVK  
schemaIdGuid:: IA09GkRYmUGtJQ9QOadq2g==  
linkID: 2165  
showInAdvancedViewOnly: TRUE  
systemFlags: 17  
  
dn: CN=ms-Imaging-PSP-Identifier,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msImaging-PSPIdentifier  
adminDisplayName: ms-Imaging-PSP-Identifier  
adminDescription: Schema Attribute that contains the unique identifier for this PostScan Process.  
attributeId: 1.2.840.113556.1.4.2053  
attributeSyntax: 2.5.5.10  
omSyntax: 4  
isSingleValued: TRUE  
searchFlags: 0  
schemaIdGuid:: 6TxYUfqUEku5kDBMNbGFlQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-Host-Service-Account,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-HostServiceAccount  
adminDisplayName: ms-DS-Host-Service-Account  
adminDescription: Service Accounts configured to run on this computer.  
attributeId: 1.2.840.113556.1.4.2056  
attributeSyntax: 2.5.5.1  
omSyntax: 127  
isSingleValued: FALSE  
searchFlags: 0  
schemaFlagsEx: 1  
omObjectClass:: KwwCh3McAIVK  
schemaIdGuid:: QxBkgKIV4UCSooyoZvcHdg==  
attributeSecurityGuid:: hri1d0qU0RGuvQAA+ANnwQ==  
linkID: 2166  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-Host-Service-Account-BL,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-HostServiceAccountBL  
adminDisplayName: ms-DS-Host-Service-Account-BL  
adminDescription: Service Accounts Back Link for linking machines associated with the service account.  
attributeId: 1.2.840.113556.1.4.2057  
attributeSyntax: 2.5.5.1  
omSyntax: 127  
isSingleValued: FALSE  
searchFlags: 0  
schemaFlagsEx: 1  
omObjectClass:: KwwCh3McAIVK  
schemaIdGuid:: 6+SrefOI50iJ1vS8fpjDMQ==  
linkID: 2167  
showInAdvancedViewOnly: TRUE  
systemFlags: 17  
  
dn: CN=ms-DS-Required-Domain-Behavior-Version,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-RequiredDomainBehaviorVersion  
adminDisplayName: ms-DS-Required-Domain-Behavior-Version  
adminDescription: Required domain function level for this feature.  
attributeId: 1.2.840.113556.1.4.2066  
attributeSyntax: 2.5.5.9  
omSyntax: 2  
isSingleValued: TRUE  
systemOnly: TRUE  
searchFlags: 0  
schemaFlagsEx: 1  
schemaIdGuid:: /j3d6g6uwky5uV/ltu0t0g==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-Required-Forest-Behavior-Version,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-RequiredForestBehaviorVersion  
adminDisplayName: ms-DS-Required-Forest-Behavior-Version  
adminDescription: Required forest function level for this feature.  
attributeId: 1.2.840.113556.1.4.2079  
attributeSyntax: 2.5.5.9  
omSyntax: 2  
isSingleValued: TRUE  
systemOnly: TRUE  
searchFlags: 0  
schemaFlagsEx: 1  
schemaIdGuid:: 6KLsS1OmskGP7nIVdUdL7A==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-PKI-Credential-Roaming-Tokens,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msPKI-CredentialRoamingTokens  
adminDisplayName: ms-PKI-Credential-Roaming-Tokens  
adminDescription: Storage of encrypted user credential token blobs for roaming.  
attributeId: 1.2.840.113556.1.4.2050  
attributeSyntax: 2.5.5.7  
omSyntax: 127  
isSingleValued: FALSE  
searchFlags: 128  
omObjectClass:: KoZIhvcUAQEBCw==  
schemaIdGuid:: OFr/txgIsEKBENPRVMl/JA==  
attributeSecurityGuid:: 3kfmkW/ZcEuVV9Y/9PPM2A==  
linkID: 2162  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-Local-Effective-Recycle-Time,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-LocalEffectiveRecycleTime  
adminDisplayName: ms-DS-Local-Effective-Recycle-Time  
adminDescription: Recycle time of the object in the local DIT.  
attributeId: 1.2.840.113556.1.4.2060  
attributeSyntax: 2.5.5.11  
omSyntax: 24  
isSingleValued: TRUE  
systemOnly: TRUE  
searchFlags: 0  
schemaFlagsEx: 1  
schemaIdGuid:: awHWStKwm0yTtllksXuWjA==  
showInAdvancedViewOnly: TRUE  
systemFlags: 20  
  
dn: CN=ms-DS-Local-Effective-Deletion-Time,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-LocalEffectiveDeletionTime  
adminDisplayName: ms-DS-Local-Effective-Deletion-Time  
adminDescription: Deletion time of the object in the local DIT.  
attributeId: 1.2.840.113556.1.4.2059  
attributeSyntax: 2.5.5.11  
omSyntax: 24  
isSingleValued: TRUE  
systemOnly: TRUE  
searchFlags: 0  
schemaFlagsEx: 1  
schemaIdGuid:: DIDylB9T60qXXUisOf2MpA==  
showInAdvancedViewOnly: TRUE  
systemFlags: 20  
  
dn: CN=ms-DS-Last-Known-RDN,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-LastKnownRDN  
adminDisplayName: ms-DS-Last-Known-RDN  
adminDescription: Holds original RDN of a deleted object.  
attributeId: 1.2.840.113556.1.4.2067  
attributeSyntax: 2.5.5.12  
omSyntax: 64  
isSingleValued: TRUE  
schemaFlagsEx: 1  
systemOnly: TRUE  
searchFlags: 0  
rangeLower: 1  
rangeUpper: 255  
schemaIdGuid:: WFixij5obUaHf9ZA4fmmEQ==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-Enabled-Feature-BL,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-EnabledFeatureBL  
adminDisplayName: ms-DS-Enabled-Feature-BL  
adminDescription: Scopes where this optional feature is enabled.  
attributeId: 1.2.840.113556.1.4.2069  
attributeSyntax: 2.5.5.1  
omSyntax: 127  
isSingleValued: FALSE  
schemaFlagsEx: 1  
systemOnly: TRUE  
searchFlags: 0  
omObjectClass:: KwwCh3McAIVK  
schemaIdGuid:: vAFbzsYXuESdwalmiwCQGw==  
linkID: 2169  
showInAdvancedViewOnly: TRUE  
systemFlags: 17  
  
dn: CN=ms-DS-Deleted-Object-Lifetime,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-DeletedObjectLifetime  
adminDisplayName: ms-DS-Deleted-Object-Lifetime  
adminDescription: Lifetime of a deleted object.  
attributeId: 1.2.840.113556.1.4.2068  
attributeSyntax: 2.5.5.9  
omSyntax: 10  
isSingleValued: TRUE  
schemaFlagsEx: 1  
systemOnly: FALSE  
searchFlags: 0  
schemaIdGuid:: toyzqZoY702KcA/PoVgUjg==  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-DS-Optional-Feature-Flags,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msDS-OptionalFeatureFlags  
adminDisplayName: ms-DS-Optional-Feature-Flags  
adminDescription: An integer value that contains flags that define behavior of an optional feature in Active Directory.  
attributeId: 1.2.840.113556.1.4.2063   
attributeSyntax: 2.5.5.9  
omSyntax: 2  
isSingleValued: TRUE  
schemaFlagsEx: 1  
systemOnly: TRUE  
searchFlags: 0  
schemaIdGuid:: wWAFirmXEUidt9wGFZiWWw==   
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-PKI-Enrollment-Servers,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaadd  
objectClass: attributeSchema  
cn: ms-PKI-Enrollment-Servers  
attributeID: 1.2.840.113556.1.4.2076  
attributeSyntax: 2.5.5.12  
isSingleValued: FALSE  
adminDisplayName: ms-PKI-Enrollment-Servers  
adminDescription: Priority, authentication type, and URI of each certificate enrollment web service.  
oMSyntax: 64  
lDAPDisplayName: msPKI-Enrollment-Servers  
name: ms-PKI-Enrollment-Servers  
schemaIDGUID:: j9Mr8tChMkiLKAMxQ4iGpg==  
instanceType: 4  
rangeUpper: 65536  
isMemberOfPartialAttributeSet: TRUE  
searchFlags: 0  
# System-Flags=FLAG_SCHEMA_BASE_OBJECT  
systemFlags: 16  
systemOnly: FALSE  
showInAdvancedViewOnly: TRUE  
  
dn: CN=ms-PKI-Site-Name,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaadd  
objectClass: attributeSchema  
cn: ms-PKI-Site-Name  
attributeID: 1.2.840.113556.1.4.2077  
attributeSyntax: 2.5.5.12  
isSingleValued: TRUE  
adminDisplayName: ms-PKI-Site-Name  
adminDescription: Active Directory site to which the CA machine belongs.  
oMSyntax: 64  
lDAPDisplayName: msPKI-Site-Name  
name: ms-PKI-Site-Name  
schemaIDGUID:: H3HYDPwKJkmksQmwjT1DbA==  
instanceType: 4  
rangeUpper: 1024  
isMemberOfPartialAttributeSet: TRUE  
searchFlags: 0  
systemOnly: FALSE  
# System-Flags=FLAG_SCHEMA_BASE_OBJECT  
systemFlags: 16  
showInAdvancedViewOnly: TRUE  
  
dn: CN=ms-TS-Endpoint-Data,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msTSEndpointData  
adminDisplayName: ms-TS-Endpoint-Data  
adminDescription: This attribute represents the VM Name for machine in TSV deployment.  
attributeId: 1.2.840.113556.1.4.2070  
attributeSyntax: 2.5.5.12  
schemaIDGUID:: B8ThQERD80CrQzYlo0pjog==  
omSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
rangeLower: 0  
rangeUpper: 32767  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-TS-Endpoint-Type,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msTSEndpointType  
adminDisplayName: ms-TS-Endpoint-Type  
adminDescription: This attribute defines if the machine is a physical machine or a virtual machine.  
attributeId: 1.2.840.113556.1.4.2071  
attributeSyntax: 2.5.5.9  
schemaIDGUID:: gN56N9jixUabzW2d7JOzXg==  
omSyntax: 2  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-TS-Endpoint-Plugin,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msTSEndpointPlugin  
adminDisplayName: ms-TS-Endpoint-Plugin  
adminDescription: This attribute represents the name of the plugin which handles the orchestration.  
attributeId: 1.2.840.113556.1.4.2072  
attributeSyntax: 2.5.5.12  
schemaIDGUID:: abUIPB+AWEGxe+Nj1q5pag==  
omSyntax: 64  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
rangeLower: 0  
rangeUpper: 32767  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-TS-Primary-Desktop,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msTSPrimaryDesktop  
adminDisplayName: ms-TS-Primary-Desktop  
adminDescription: This attribute represents the forward link to user's primary desktop.  
attributeId: 1.2.840.113556.1.4.2073  
attributeSyntax: 2.5.5.1  
schemaIDGUID:: lJYlKeQJN0KfcpMG6+Y6sg==  
omSyntax: 127  
isSingleValued: TRUE  
systemOnly: FALSE  
searchFlags: 0  
linkID: 2170  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-TS-Secondary-Desktops,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msTSSecondaryDesktops  
adminDisplayName: ms-TS-Secondary-Desktops  
adminDescription: This attribute represents the array of forward links to user's secondary desktops.  
attributeId: 1.2.840.113556.1.4.2075  
attributeSyntax: 2.5.5.1  
schemaIDGUID:: mqI69jG74Ui/qwpsWh05wg==  
omSyntax: 127  
isSingleValued: FALSE  
systemOnly: FALSE  
searchFlags: 0  
linkID: 2172  
showInAdvancedViewOnly: TRUE  
systemFlags: 16  
  
dn: CN=ms-TS-Primary-Desktop-BL,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msTSPrimaryDesktopBL  
adminDisplayName: ms-TS-Primary-Desktop-BL  
adminDescription: This attribute represents the backward link to user.  
attributeId: 1.2.840.113556.1.4.2074  
attributeSyntax: 2.5.5.1  
schemaIDGUID:: GNyqndFA0U6iv2ub9H09qg==  
omSyntax: 127  
isSingleValued: FALSE  
systemOnly: TRUE  
searchFlags: 0  
linkID: 2171  
showInAdvancedViewOnly: TRUE  
systemFlags: 17  
  
dn: CN=ms-TS-Secondary-Desktop-BL,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: attributeSchema  
ldapDisplayName: msTSSecondaryDesktopBL  
adminDisplayName: ms-TS-Secondary-Desktop-BL  
adminDescription: This attribute represents the backward link to user.  
attributeId: 1.2.840.113556.1.4.2078  
attributeSyntax: 2.5.5.1  
schemaIDGUID:: rwexNAqgWkWxOd0aGxLYrw==  
omSyntax: 127  
isSingleValued: FALSE  
systemOnly: TRUE  
searchFlags: 0  
linkID: 2173  
showInAdvancedViewOnly: TRUE  
systemFlags: 17  
  
DN:  
changetype: modify  
add: schemaUpdateNow  
schemaUpdateNow: 1  
-  
  
dn: CN=ms-Imaging-PSPs,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: classSchema  
ldapDisplayName: msImaging-PSPs  
adminDisplayName: ms-Imaging-PSPs  
adminDescription: Container for all Enterprise Scan Post Scan Process objects.  
governsId: 1.2.840.113556.1.5.262  
objectClassCategory: 1  
rdnAttId: 2.5.4.3  
subClassOf: 1.2.840.113556.1.3.23  
systemPossSuperiors: 1.2.840.113556.1.3.23  
schemaIdGuid:: wSrtoAyXd0eEjuxjoOxE/A==  
defaultSecurityDescriptor: D:(A;;RPWPCRCCDCLCLOLORCWOWDSDDTDTSW;;;DA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)(A;;RPLCLORC;;;AU)  
showInAdvancedViewOnly: TRUE  
defaultHidingValue: FALSE  
systemOnly: FALSE  
defaultObjectCategory: CN=ms-Imaging-PSPs,CN=Schema,CN=Configuration,DC=X  
systemFlags: 16  
  
dn: CN=ms-DS-Optional-Feature,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: classSchema  
ldapDisplayName: msDS-OptionalFeature  
adminDisplayName: ms-DS-Optional-Feature  
adminDescription: Configuration for an optional DS feature.  
governsId: 1.2.840.113556.1.5.265  
objectClassCategory: 1  
rdnAttId: 2.5.4.3  
subClassOf: 2.5.6.0  
systemMayContain: 1.2.840.113556.1.4.2079  
systemMayContain: 1.2.840.113556.1.4.2066  
systemMustContain: 1.2.840.113556.1.4.2062  
systemMustContain: 1.2.840.113556.1.4.2063  
systemPossSuperiors: 1.2.840.113556.1.3.23  
schemaIdGuid:: QQDwRK81i0ayCmzoc3xYCw==  
defaultSecurityDescriptor: D:(A;;RPLCLORC;;;AU)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;EA)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;CO)(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY)  
showInAdvancedViewOnly: TRUE  
defaultHidingValue: TRUE  
systemOnly: TRUE  
defaultObjectCategory: CN=ms-DS-Optional-Feature,CN=Schema,CN=Configuration,DC=X  
systemFlags: 16  
  
dn: CN=ms-Imaging-PostScanProcess,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: classSchema  
ldapDisplayName: msImaging-PostScanProcess  
adminDisplayName: ms-Imaging-PostScanProcess  
adminDescription: Enterprise Scan Post Scan Process object.  
governsId: 1.2.840.113556.1.5.263  
objectClassCategory: 1  
rdnAttId: 2.5.4.3  
subClassOf: 2.5.6.0  
systemMustContain: 1.2.840.113556.1.2.13  
systemMustContain: 1.2.840.113556.1.4.2053  
systemMayContain: 1.2.840.113556.1.4.2054  
systemMayContain: 1.2.840.113556.1.4.223  
systemPossSuperiors: 1.2.840.113556.1.5.262  
schemaIdGuid:: fCV8H6O4JUWC+BHMx77jbg==  
defaultSecurityDescriptor: D:(A;;RPWPCRCCDCLCLOLORCWOWDSDDTDTSW;;;DA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)(A;;RPLCLORC;;;AU)  
showInAdvancedViewOnly: TRUE  
defaultHidingValue: FALSE  
systemOnly: FALSE  
defaultObjectCategory: CN=ms-Imaging-PostScanProcess,CN=Schema,CN=Configuration,DC=X  
systemFlags: 16  
  
dn: CN=ms-DS-Managed-Service-Account,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: classSchema  
ldapDisplayName: msDS-ManagedServiceAccount  
adminDisplayName: ms-DS-Managed-Service-Account  
adminDescription: Service account class is used to create accounts that are used for running Windows services.  
governsId: 1.2.840.113556.1.5.264  
objectClassCategory: 1  
rdnAttId: 2.5.4.3  
subClassOf: 1.2.840.113556.1.3.30  
systemPossSuperiors: 1.2.840.113556.1.5.67  
systemPossSuperiors: 2.5.6.5  
systemPossSuperiors: 1.2.840.113556.1.3.23  
systemPossSuperiors: 1.2.840.113556.1.3.30  
schemaIdGuid:: RGIgzidYhkq6HBwMOGwbZA==  
defaultSecurityDescriptor: D:(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;DA)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;AO)(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY)(A;;RPCRLCLORCSDDT;;;CO)(OA;;WP;4c164200-20c0-11d0-a768-00aa006e0529;;CO)(OA;;SW;72e39547-7b18-11d1-adef-00c04fd8d5cd;;CO)(OA;;SW;f3a64788-5306-11d1-a9c5-0000f80367c1;;CO)(OA;;WP;3e0abfd0-126a-11d0-a060-00aa006c33ed;bf967a86-0de6-11d0-a285-00aa003049e2;CO)(OA;;WP;5f202010-79a5-11d0-9020-00c04fc2d4cf;bf967a86-0de6-11d0-a285-00aa003049e2;CO)(OA;;WP;bf967950-0de6-11d0-a285-00aa003049e2;bf967a86-0de6-11d0-a285-00aa003049e2;CO)(OA;;WP;bf967953-0de6-11d0-a285-00aa003049e2;bf967a86-0de6-11d0-a285-00aa003049e2;CO)(OA;;SW;f3a64788-5306-11d1-a9c5-0000f80367c1;;PS)(OA;;RPWP;77B5B886-944A-11d1-AEBD-0000F80367C1;;PS)(OA;;SW;72e39547-7b18-11d1-adef-00c04fd8d5cd;;PS)(A;;RPLCLORC;;;AU)(OA;;CR;ab721a53-1e2f-11d0-9819-00aa0040529b;;WD)(OA;;RPWP;bf967a7f-0de6-11d0-a285-00aa003049e2;;CA)(OA;;RP;46a9b11d-60ae-405a-b7e8-ff8a58d456d2;;S-1-5-32-560)  
showInAdvancedViewOnly: TRUE  
defaultHidingValue: TRUE  
systemOnly: FALSE  
defaultObjectCategory: CN=ms-DS-Managed-Service-Account,CN=Schema,CN=Configuration,DC=X  
systemFlags: 16  
  
dn: CN=DMD,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2055  
-  
  
dn: CN=Configuration,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2055  
-  
  
dn: CN=domain-DNS,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2055  
-  
  
dn: CN=ms-PKI-Cert-Template-OID,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
replace: searchFlags  
searchFlags: 1  
-  
  
dn: CN=Top,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2052  
systemMayContain: 1.2.840.113556.1.4.2057  
systemMayContain: 1.2.840.113556.1.4.2058  
systemMayContain: 1.2.840.113556.1.4.2059  
systemMayContain: 1.2.840.113556.1.4.2060  
-  
  
dn: CN=Top,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2067  
systemMayContain: 1.2.840.113556.1.4.2069  
-  
  
dn: CN=NTDS-Service,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2068  
-  
  
dn: CN=User,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2050  
-  
  
dn: CN=Computer,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2056  
-  
  
dn: CN=Cross-Ref-Container,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2061  
-  
  
dn: CN=Domain-DNS,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2061  
-  
  
dn: CN=ms-PKI-Enterprise-Oid,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2051  
-  
  
dn: CN=PKI-Enrollment-Service,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2076  
systemMayContain: 1.2.840.113556.1.4.2077  
-  
  
dn: CN=User,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2073  
systemMayContain: 1.2.840.113556.1.4.2075  
-  
  
dn: CN=Computer,CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: systemMayContain  
systemMayContain: 1.2.840.113556.1.4.2070  
systemMayContain: 1.2.840.113556.1.4.2071  
systemMayContain: 1.2.840.113556.1.4.2072  
systemMayContain: 1.2.840.113556.1.4.2074  
systemMayContain: 1.2.840.113556.1.4.2078  
-  
  
DN:  
changetype: modify  
add: schemaUpdateNow  
schemaUpdateNow: 1  
-  
  
dn: CN=Optional Features,CN=Directory Service,CN=Windows NT,CN=Services,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: container  
systemFlags: -1946157056  
  
dn: CN=Recycle Bin Feature,CN=Optional Features,CN=Directory Service,CN=Windows NT,CN=Services,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: msDS-OptionalFeature  
msDS-OptionalFeatureGUID:: 2NxtdtCsXkTzuaf5tnRPKg==  
msDS-RequiredForestBehaviorVersion: 4  
msDS-OptionalFeatureFlags: 1  
systemFlags: -1946157056  
  
dn: CN=User-Change-Password,CN=Extended-Rights,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: appliesTo  
appliesTo: ce206244-5827-4a86-ba1c-1c0c386c1b64  
-  
  
dn: CN=User-Force-Change-Password,CN=Extended-Rights,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: appliesTo  
appliesTo: ce206244-5827-4a86-ba1c-1c0c386c1b64  
-  
  
dn: CN=Send-As,CN=Extended-Rights,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: appliesTo  
appliesTo: ce206244-5827-4a86-ba1c-1c0c386c1b64  
-  
  
dn: CN=Receive-As,CN=Extended-Rights,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: appliesTo  
appliesTo: ce206244-5827-4a86-ba1c-1c0c386c1b64  
-  
  
dn: CN=User-Account-Restrictions,CN=Extended-Rights,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: appliesTo  
appliesTo: ce206244-5827-4a86-ba1c-1c0c386c1b64  
-  
  
dn: CN=Personal-Information,CN=Extended-Rights,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: appliesTo  
appliesTo: ce206244-5827-4a86-ba1c-1c0c386c1b64  
-  
  
dn: CN=Public-Information,CN=Extended-Rights,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: appliesTo  
appliesTo: ce206244-5827-4a86-ba1c-1c0c386c1b64  
-  
  
dn: CN=Validated-DNS-Host-Name,CN=Extended-Rights,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: appliesTo  
appliesTo: ce206244-5827-4a86-ba1c-1c0c386c1b64  
-  
  
dn: CN=Validated-SPN,CN=Extended-Rights,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: appliesTo  
appliesTo: ce206244-5827-4a86-ba1c-1c0c386c1b64  
-  
  
dn: CN=DNS-Host-Name-Attributes,CN=Extended-Rights,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: appliesTo  
appliesTo: ce206244-5827-4a86-ba1c-1c0c386c1b64  
-  
  
dn: CN=Allowed-To-Authenticate,CN=Extended-Rights,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: appliesTo  
appliesTo: ce206244-5827-4a86-ba1c-1c0c386c1b64  
-  
  
dn: CN=MS-TS-GatewayAccess,CN=Extended-Rights,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
add: appliesTo  
appliesTo: ce206244-5827-4a86-ba1c-1c0c386c1b64  
-  
  
dn: CN=Run-Protect-Admin-Groups-Task,CN=Extended-Rights,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: controlAccessRight  
displayName: Run Protect Admin Groups Task  
rightsGuid: 7726b9d5-a4b4-4288-a6b2-dce952e80a7f  
appliesTo: 19195a5b-6da0-11d0-afd3-00c04fd930c9  
validAccesses: 256  
localizationDisplayId: 78  
  
dn: CN=Manage-Optional-Features,CN=Extended-Rights,CN=Configuration,DC=X  
changetype: ntdsSchemaAdd  
objectClass: controlAccessRight  
displayName: Manage Optional Features for Active Directory  
rightsGuid: 7c0e2a7c-a419-48e4-a995-10180aad54dd  
appliesTo: ef9e60e0-56f7-11d1-a9c6-0000f80367c1  
validAccesses: 256  
localizationDisplayId: 79  
  
dn: CN=Schema,CN=Configuration,DC=X  
changetype: ntdsSchemaModify  
replace: objectVersion  
objectVersion: 45  
-  
  
```  
  
## See Also  
 [Windows Server 2008 R2: Schema Updates](../Topic/Windows-Server-2008-R2--Schema-Updates.md)  
  
  