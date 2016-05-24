---
title: Sch43.ldf
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 1bba15dc-433d-45a5-a524-a82536b8b06e
author: Femila
---
# Sch43.ldf
  dn: CN\=ms\-DFS\-Schema\-Major\-Version,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 cn: ms\-DFS\-Schema\-Major\-Version  
  
 attributeID: 1.2.840.113556.1.4.2030  
  
 attributeSyntax: 2.5.5.9  
  
 isSingleValued: TRUE  
  
 rangeLower: 2  
  
 rangeUpper: 2  
  
 showInAdvancedViewOnly: TRUE  
  
 adminDisplayName: ms\-DFS\-Schema\-Major\-Version  
  
 adminDescription: Major version of schema of DFS metadata.  
  
 oMSyntax: 2  
  
 searchFlags: 0  
  
 lDAPDisplayName: msDFS\-SchemaMajorVersion  
  
 schemaIDGUID:: VXht7EpwYU\+apsSafB1Uxw\=\=  
  
 isMemberOfPartialAttributeSet: FALSE  
  
 objectCategory: CN\=Attribute\-Schema,CN\=Schema,CN\=Configuration,DC\=X  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DFS\-Schema\-Minor\-Version,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 cn: ms\-DFS\-Schema\-Minor\-Version  
  
 attributeID: 1.2.840.113556.1.4.2031  
  
 attributeSyntax: 2.5.5.9  
  
 isSingleValued: TRUE  
  
 rangeLower: 0  
  
 rangeUpper: 0  
  
 showInAdvancedViewOnly: TRUE  
  
 adminDisplayName: ms\-DFS\-Schema\-Minor\-Version  
  
 adminDescription: Minor version of schema of DFS metadata.  
  
 oMSyntax: 2  
  
 searchFlags: 0  
  
 lDAPDisplayName: msDFS\-SchemaMinorVersion  
  
 schemaIDGUID:: Jaf5\/vHoq0O9hmoBFc6eOA\=\=  
  
 isMemberOfPartialAttributeSet: FALSE  
  
 objectCategory: CN\=Attribute\-Schema,CN\=Schema,CN\=Configuration,DC\=X  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DFS\-Generation\-GUID\-v2,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 cn: ms\-DFS\-Generation\-GUID\-v2  
  
 attributeID: 1.2.840.113556.1.4.2032  
  
 attributeSyntax: 2.5.5.10  
  
 isSingleValued: TRUE  
  
 rangeLower: 16  
  
 rangeUpper: 16  
  
 showInAdvancedViewOnly: TRUE  
  
 adminDisplayName: ms\-DFS\-Generation\-GUID\-v2  
  
 adminDescription: To be updated each time the entry containing this attribute is modified.  
  
 oMSyntax: 4  
  
 searchFlags: 0  
  
 lDAPDisplayName: msDFS\-GenerationGUIDv2  
  
 schemaIDGUID:: 2bO4NY\/F1kOTDlBA8vGngQ\=\=  
  
 isMemberOfPartialAttributeSet: FALSE  
  
 objectCategory: CN\=Attribute\-Schema,CN\=Schema,CN\=Configuration,DC\=X  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DFS\-Namespace\-Identity\-GUID\-v2,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 cn: ms\-DFS\-Namespace\-Identity\-GUID\-v2  
  
 attributeID: 1.2.840.113556.1.4.2033  
  
 attributeSyntax: 2.5.5.10  
  
 isSingleValued: TRUE  
  
 rangeLower: 16  
  
 rangeUpper: 16  
  
 showInAdvancedViewOnly: TRUE  
  
 adminDisplayName: ms\-DFS\-Namespace\-Identity\-GUID\-v2  
  
 adminDescription: To be set only when the namespace is created. Stable across rename\/move as long as namespace is not replaced by another namespace having same name.  
  
 oMSyntax: 4  
  
 searchFlags: 0  
  
 lDAPDisplayName: msDFS\-NamespaceIdentityGUIDv2  
  
 schemaIDGUID:: zjIEIF\/sMUmlJdf0r\+NOaA\=\=  
  
 isMemberOfPartialAttributeSet: FALSE  
  
 objectCategory: CN\=Attribute\-Schema,CN\=Schema,CN\=Configuration,DC\=X  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DFS\-Last\-Modified\-v2,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 cn: ms\-DFS\-Last\-Modified\-v2  
  
 attributeID: 1.2.840.113556.1.4.2034  
  
 attributeSyntax: 2.5.5.11  
  
 isSingleValued: TRUE  
  
 showInAdvancedViewOnly: TRUE  
  
 adminDisplayName: ms\-DFS\-Last\-Modified\-v2  
  
 adminDescription: To be updated on each write to the entry containing the attribute.  
  
 oMSyntax: 24  
  
 searchFlags: 0  
  
 lDAPDisplayName: msDFS\-LastModifiedv2  
  
 schemaIDGUID:: il4JPE4xW0aD9auCd7zymw\=\=  
  
 isMemberOfPartialAttributeSet: FALSE  
  
 objectCategory: CN\=Attribute\-Schema,CN\=Schema,CN\=Configuration,DC\=X  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DFS\-Ttl\-v2,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 cn: ms\-DFS\-Ttl\-v2  
  
 attributeID: 1.2.840.113556.1.4.2035  
  
 attributeSyntax: 2.5.5.9  
  
 isSingleValued: TRUE  
  
 showInAdvancedViewOnly: TRUE  
  
 adminDisplayName: ms\-DFS\-Ttl\-v2  
  
 adminDescription: TTL associated with DFS root\/link. For use at DFS referral time.  
  
 oMSyntax: 2  
  
 searchFlags: 0  
  
 lDAPDisplayName: msDFS\-Ttlv2  
  
 schemaIDGUID:: MU2U6kqGSUOtpQYuLGFPXg\=\=  
  
 isMemberOfPartialAttributeSet: FALSE  
  
 objectCategory: CN\=Attribute\-Schema,CN\=Schema,CN\=Configuration,DC\=X  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DFS\-Comment\-v2,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 cn: ms\-DFS\-Comment\-v2  
  
 attributeID: 1.2.840.113556.1.4.2036  
  
 attributeSyntax: 2.5.5.12  
  
 isSingleValued: TRUE  
  
 rangeLower: 0  
  
 rangeUpper: 32766  
  
 showInAdvancedViewOnly: TRUE  
  
 adminDisplayName: ms\-DFS\-Comment\-v2  
  
 adminDescription: Comment associated with DFS root\/link.  
  
 oMSyntax: 64  
  
 searchFlags: 0  
  
 lDAPDisplayName: msDFS\-Commentv2  
  
 schemaIDGUID:: yc6Gt\/1hI0WywVzrOGC7Mg\=\=  
  
 isMemberOfPartialAttributeSet: FALSE  
  
 objectCategory: CN\=Attribute\-Schema,CN\=Schema,CN\=Configuration,DC\=X  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DFS\-Properties\-v2,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 cn: ms\-DFS\-Properties\-v2  
  
 attributeID: 1.2.840.113556.1.4.2037  
  
 attributeSyntax: 2.5.5.12  
  
 isSingleValued: FALSE  
  
 rangeLower: 0  
  
 rangeUpper: 1024  
  
 showInAdvancedViewOnly: TRUE  
  
 adminDisplayName: ms\-DFS\-Properties\-v2  
  
 adminDescription: Properties associated with DFS root\/link.  
  
 oMSyntax: 64  
  
 searchFlags: 0  
  
 lDAPDisplayName: msDFS\-Propertiesv2  
  
 schemaIDGUID:: xVs\+DA7r9UCbUzNOlY3\/2w\=\=  
  
 isMemberOfPartialAttributeSet: FALSE  
  
 objectCategory: CN\=Attribute\-Schema,CN\=Schema,CN\=Configuration,DC\=X  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DFS\-Target\-List\-v2,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 cn: ms\-DFS\-Target\-List\-v2  
  
 attributeID: 1.2.840.113556.1.4.2038  
  
 attributeSyntax: 2.5.5.10  
  
 isSingleValued: TRUE  
  
 rangeLower: 0  
  
 rangeUpper: 2097152  
  
 showInAdvancedViewOnly: TRUE  
  
 adminDisplayName: ms\-DFS\-Target\-List\-v2  
  
 adminDescription: Targets corresponding to DFS root\/link.  
  
 oMSyntax: 4  
  
 searchFlags: 0  
  
 lDAPDisplayName: msDFS\-TargetListv2  
  
 schemaIDGUID:: xiaxakH6NkuAnnypFhDUjw\=\=  
  
 isMemberOfPartialAttributeSet: FALSE  
  
 objectCategory: CN\=Attribute\-Schema,CN\=Schema,CN\=Configuration,DC\=X  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DFS\-Link\-Path\-v2,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 cn: ms\-DFS\-Link\-Path\-v2  
  
 attributeID: 1.2.840.113556.1.4.2039  
  
 attributeSyntax: 2.5.5.12  
  
 isSingleValued: TRUE  
  
 rangeLower: 0  
  
 rangeUpper: 32766  
  
 showInAdvancedViewOnly: TRUE  
  
 adminDisplayName: ms\-DFS\-Link\-Path\-v2  
  
 adminDescription: DFS link path relative to the DFS root target share \(i.e. without the server\/domain and DFS namespace name components\). Use forward slashes \(\/\) instead of backslashes so that LDAP searches can be done without having to use escapes.  
  
 oMSyntax: 64  
  
 searchFlags: 0  
  
 lDAPDisplayName: msDFS\-LinkPathv2  
  
 schemaIDGUID:: 9iGwhqsQokCiUh3AzDvmqQ\=\=  
  
 isMemberOfPartialAttributeSet: FALSE  
  
 objectCategory: CN\=Attribute\-Schema,CN\=Schema,CN\=Configuration,DC\=X  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DFS\-Link\-Security\-Descriptor\-v2,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 cn: ms\-DFS\-Link\-Security\-Descriptor\-v2  
  
 attributeID: 1.2.840.113556.1.4.2040  
  
 attributeSyntax: 2.5.5.15  
  
 isSingleValued: TRUE  
  
 showInAdvancedViewOnly: TRUE  
  
 adminDisplayName: ms\-DFS\-Link\-Security\-Descriptor\-v2  
  
 adminDescription: Security descriptor of the DFS links's reparse point on the filesystem.  
  
 oMSyntax: 66  
  
 searchFlags: 0  
  
 lDAPDisplayName: msDFS\-LinkSecurityDescriptorv2  
  
 schemaIDGUID:: 94fPVyY0QUizIgKztunrqA\=\=  
  
 isMemberOfPartialAttributeSet: FALSE  
  
 objectCategory: CN\=Attribute\-Schema,CN\=Schema,CN\=Configuration,DC\=X  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DFS\-Link\-Identity\-GUID\-v2,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 cn: ms\-DFS\-Link\-Identity\-GUID\-v2  
  
 attributeID: 1.2.840.113556.1.4.2041  
  
 attributeSyntax: 2.5.5.10  
  
 isSingleValued: TRUE  
  
 rangeLower: 16  
  
 rangeUpper: 16  
  
 showInAdvancedViewOnly: TRUE  
  
 adminDisplayName: ms\-DFS\-Link\-Identity\-GUID\-v2  
  
 adminDescription: To be set only when the link is created. Stable across rename\/move as long as link is not replaced by another link having same name.  
  
 oMSyntax: 4  
  
 searchFlags: 0  
  
 lDAPDisplayName: msDFS\-LinkIdentityGUIDv2  
  
 schemaIDGUID:: 8yew7SZX7k2NTtvwfhrR8Q\=\=  
  
 isMemberOfPartialAttributeSet: FALSE  
  
 objectCategory: CN\=Attribute\-Schema,CN\=Schema,CN\=Configuration,DC\=X  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DFS\-Short\-Name\-Link\-Path\-v2,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 cn: ms\-DFS\-Short\-Name\-Link\-Path\-v2  
  
 attributeID: 1.2.840.113556.1.4.2042  
  
 attributeSyntax: 2.5.5.12  
  
 isSingleValued: TRUE  
  
 rangeLower: 0  
  
 rangeUpper: 32766  
  
 showInAdvancedViewOnly: TRUE  
  
 adminDisplayName: ms\-DFS\-Short\-Name\-Link\-Path\-v2  
  
 adminDescription: Shortname DFS link path relative to the DFS root target share \(i.e. without the server\/domain and DFS namespace name components\). Use forward slashes \(\/\) instead of backslashes so that LDAP searches can be done without having to use escapes.  
  
 oMSyntax: 64  
  
 searchFlags: 0  
  
 lDAPDisplayName: msDFS\-ShortNameLinkPathv2  
  
 schemaIDGUID:: 8CZ4LfdM6UKgOREQ4NnKmQ\=\=  
  
 isMemberOfPartialAttributeSet: FALSE  
  
 objectCategory: CN\=Attribute\-Schema,CN\=Schema,CN\=Configuration,DC\=X  
  
 systemFlags: 16  
  
 DN:  
  
 changetype: modify  
  
 add: schemaUpdateNow  
  
 schemaUpdateNow: 1  
  
 \-  
  
 dn: CN\=ms\-DFS\-Namespace\-Anchor,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: classSchema  
  
 cn: ms\-DFS\-Namespace\-Anchor  
  
 subClassOf: top  
  
 governsID: 1.2.840.113556.1.5.257  
  
 rDNAttID: cn  
  
 showInAdvancedViewOnly: TRUE  
  
 adminDisplayName: ms\-DFS\-Namespace\-Anchor  
  
 adminDescription: DFS namespace anchor  
  
 objectClassCategory: 1  
  
 lDAPDisplayName: msDFS\-NamespaceAnchor  
  
 schemaIDGUID:: haBz2mRuYU2wZAFdBBZHlQ\=\=  
  
 systemOnly: FALSE  
  
 systemPossSuperiors: 1.2.840.113556.1.5.42  
  
 systemMustContain: 1.2.840.113556.1.4.2030  
  
 defaultSecurityDescriptor: D:\(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;DA\)\(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY\)\(A;;RPLCLORC;;;AU\)\(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;CO\)  
  
 systemFlags: 16  
  
 defaultHidingValue: TRUE  
  
 objectCategory: CN\=Class\-Schema,CN\=Schema,CN\=Configuration,DC\=X  
  
 defaultObjectCategory: CN\=ms\-DFS\-Namespace\-Anchor,CN\=Schema,CN\=Configuration,DC\=X  
  
 dn: CN\=ms\-DFS\-Namespace\-v2,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: classSchema  
  
 cn: ms\-DFS\-Namespace\-v2  
  
 subClassOf: top  
  
 governsID: 1.2.840.113556.1.5.258  
  
 rDNAttID: cn  
  
 showInAdvancedViewOnly: TRUE  
  
 adminDisplayName: ms\-DFS\-Namespace\-v2  
  
 adminDescription: DFS namespace  
  
 objectClassCategory: 1  
  
 lDAPDisplayName: msDFS\-Namespacev2  
  
 schemaIDGUID:: KIbLIcPzv0u\/9gYLLY8pmg\=\=  
  
 systemOnly: FALSE  
  
 systemPossSuperiors: 1.2.840.113556.1.5.257  
  
 systemMayContain: 1.2.840.113556.1.4.2036  
  
 systemMustContain: 1.2.840.113556.1.4.2037  
  
 systemMustContain: 1.2.840.113556.1.4.2038  
  
 systemMustContain: 1.2.840.113556.1.4.2035  
  
 systemMustContain: 1.2.840.113556.1.4.2034  
  
 systemMustContain: 1.2.840.113556.1.4.2033  
  
 systemMustContain: 1.2.840.113556.1.4.2032  
  
 systemMustContain: 1.2.840.113556.1.4.2031  
  
 systemMustContain: 1.2.840.113556.1.4.2030  
  
 defaultSecurityDescriptor: D:\(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;DA\)\(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY\)\(A;;RPLCLORC;;;AU\)  
  
 systemFlags: 16  
  
 defaultHidingValue: TRUE  
  
 objectCategory: CN\=Class\-Schema,CN\=Schema,CN\=Configuration,DC\=X  
  
 defaultObjectCategory: CN\=ms\-DFS\-Namespace\-v2,CN\=Schema,CN\=Configuration,DC\=X  
  
 dn: CN\=ms\-DFS\-Link\-v2,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: classSchema  
  
 cn: ms\-DFS\-Link\-v2  
  
 subClassOf: top  
  
 governsID: 1.2.840.113556.1.5.259  
  
 rDNAttID: cn  
  
 showInAdvancedViewOnly: TRUE  
  
 adminDisplayName: ms\-DFS\-Link\-v2  
  
 adminDescription: DFS Link in DFS namespace  
  
 objectClassCategory: 1  
  
 lDAPDisplayName: msDFS\-Linkv2  
  
 schemaIDGUID:: evtpd1kRlk6czWi8SHBz6w\=\=  
  
 systemOnly: FALSE  
  
 systemPossSuperiors: 1.2.840.113556.1.5.258  
  
 systemMayContain: 1.2.840.113556.1.4.2042  
  
 systemMayContain: 1.2.840.113556.1.4.2040  
  
 systemMayContain: 1.2.840.113556.1.4.2036  
  
 systemMustContain: 1.2.840.113556.1.4.2039  
  
 systemMustContain: 1.2.840.113556.1.4.2037  
  
 systemMustContain: 1.2.840.113556.1.4.2038  
  
 systemMustContain: 1.2.840.113556.1.4.2035  
  
 systemMustContain: 1.2.840.113556.1.4.2034  
  
 systemMustContain: 1.2.840.113556.1.4.2041  
  
 systemMustContain: 1.2.840.113556.1.4.2033  
  
 systemMustContain: 1.2.840.113556.1.4.2032  
  
 defaultSecurityDescriptor: D:\(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;DA\)\(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY\)\(A;;RPLCLORC;;;AU\)  
  
 systemFlags: 16  
  
 defaultHidingValue: TRUE  
  
 objectCategory: CN\=Class\-Schema,CN\=Schema,CN\=Configuration,DC\=X  
  
 defaultObjectCategory: CN\=ms\-DFS\-Link\-v2,CN\=Schema,CN\=Configuration,DC\=X  
  
 dn: CN\=ms\-DFS\-Deleted\-Link\-v2,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: classSchema  
  
 cn: ms\-DFS\-Deleted\-Link\-v2  
  
 subClassOf: top  
  
 governsID: 1.2.840.113556.1.5.260  
  
 rDNAttID: cn  
  
 showInAdvancedViewOnly: TRUE  
  
 adminDisplayName: ms\-DFS\-Deleted\-Link\-v2  
  
 adminDescription: Deleted DFS Link in DFS namespace  
  
 objectClassCategory: 1  
  
 lDAPDisplayName: msDFS\-DeletedLinkv2  
  
 schemaIDGUID:: CDQXJcoE6ECGXj\+c6b8b0w\=\=  
  
 systemOnly: FALSE  
  
 systemPossSuperiors: 1.2.840.113556.1.5.258  
  
 systemMayContain: 1.2.840.113556.1.4.2042  
  
 systemMayContain: 1.2.840.113556.1.4.2036  
  
 systemMustContain: 1.2.840.113556.1.4.2039  
  
 systemMustContain: 1.2.840.113556.1.4.2034  
  
 systemMustContain: 1.2.840.113556.1.4.2041  
  
 systemMustContain: 1.2.840.113556.1.4.2033  
  
 defaultSecurityDescriptor: D:\(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;DA\)\(A;;RPWPCRCCDCLCLORCWOWDSDDTSW;;;SY\)\(A;;RPLCLORC;;;AU\)  
  
 systemFlags: 16  
  
 defaultHidingValue: TRUE  
  
 objectCategory: CN\=Class\-Schema,CN\=Schema,CN\=Configuration,DC\=X  
  
 defaultObjectCategory: CN\=ms\-DFS\-Deleted\-Link\-v2,CN\=Schema,CN\=Configuration,DC\=X  
  
 dn: CN\=Address\-Book\-Roots2,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: addressBookRoots2  
  
 adminDisplayName: Address\-Book\-Roots2  
  
 adminDescription: Used by Exchange. Exchange configures trees of address book containers to show up in the MAPI address book. This attribute on the Exchange Config object lists the roots of the address book container trees.  
  
 attributeId: 1.2.840.113556.1.4.2046  
  
 attributeSyntax: 2.5.5.1  
  
 omSyntax: 127  
  
 isSingleValued: FALSE  
  
 linkID: 2122  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 omObjectClass:: KwwCh3McAIVK  
  
 schemaIdGuid:: dKOMUBGlTk6fT4VvYaa35A\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 schemaFlagsEx: 1  
  
 dn: CN\=Global\-Address\-List2,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: globalAddressList2  
  
 adminDisplayName: Global\-Address\-List2  
  
 adminDescription: This attribute is used on a Microsoft Exchange container to store the distinguished name of a newly created global address list \(GAL\). This attribute must have an entry before you can enable Messaging Application Programming Interface \(MAPI\) clients to use a GAL.  
  
 attributeId: 1.2.840.113556.1.4.2047  
  
 attributeSyntax: 2.5.5.1  
  
 omSyntax: 127  
  
 isSingleValued: TRUE  
  
 linkID: 2124  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 omObjectClass:: KwwCh3McAIVK  
  
 schemaIdGuid:: PfaYSBJBfEeIJjygC9gnfQ\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 schemaFlagsEx: 1  
  
 dn: CN\=Template\-Roots2,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: templateRoots2  
  
 adminDisplayName: Template\-Roots2  
  
 adminDescription: This attribute is used on the Exchange config container to indicate where the template containers are stored. This information is used by the Active Directory MAPI provider.  
  
 attributeId: 1.2.840.113556.1.4.2048  
  
 attributeSyntax: 2.5.5.1  
  
 omSyntax: 127  
  
 isSingleValued: FALSE  
  
 linkID: 2126  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 omObjectClass:: KwwCh3McAIVK  
  
 schemaIdGuid:: GqnLsYIGYkOmWRU\+IB7waQ\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 schemaFlagsEx: 1  
  
 DN:  
  
 changetype: modify  
  
 add: schemaUpdateNow  
  
 schemaUpdateNow: 1  
  
 \-  
  
 dn: CN\=ms\-Exch\-Configuration\-Container,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.2046  
  
 systemMayContain: 1.2.840.113556.1.4.2047  
  
 systemMayContain: 1.2.840.113556.1.4.2048  
  
 \-  
  
 \# Increase object version  
  
 dn: CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: objectVersion  
  
 objectVersion: 43  
  
 \-  
  
  