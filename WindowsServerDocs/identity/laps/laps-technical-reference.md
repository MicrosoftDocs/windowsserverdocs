---
title: Windows LAPS schema and rights extensions for Windows Server Active Directory
description: Get details about schema and rights extensions to deploy and manage Windows Local Administrator Password Solution (Windows LAPS) in Windows Server Active Directory.
author: jay98014
ms.author: jsimmons
ms.date: 07/04/2022
ms.topic: reference
---

# Windows LAPS schema extensions reference

Use detailed information about schema extensions and extended rights to help you deploy or manage Windows Local Administrator Password Solution (Windows LAPS) in your Windows Server Active Directory deployment.

> [!IMPORTANT]
> For more information on specific OS updates required to use the Windows LAPS feature, and the current status of the Microsoft Entra LAPS scenario, see [Windows LAPS availability and Microsoft Entra LAPS public preview status](laps-overview.md#windows-laps-supported-platforms-and-azure-ad-laps-preview-status).

## Schema extensions

Windows LAPS offers specific schema elements for Windows Server Active Directory. To use any of the following Windows LAPS Windows Server Active Directory-based features, you must add these new schema elements to the forest by running the `Update-LapsADSchema PowerShell` cmdlet.

## Schema attributes

Windows LAPS uses specific schema attributes that are stored on the computer object in Windows Server Active Directory for a managed device. The `Update-LapsADSchema` cmdlet adds the schema attributes to the directory and to the `mayContain` list on the computer schema class.

> [!TIP]
> Many of the following attributes specify a `SearchFlags` value of `904`. For easy reference, this value is composed of the following bit flags:
>
> - `fRODCFilteredAttribute`
> - `fNEVERVALUEAUDIT`
> - `fCONFIDENTIAL`
> - `fPRESERVEONDELETE`

### msLAPS-PasswordExpirationTime

This attribute contains a 64-bit integer that specifies the currently scheduled password expiration time in UTC.

```powershell
Name: ms-LAPS-PasswordExpirationTime
LDAP display name: msLAPS-PasswordExpirationTime
OID: 1.2.840.113556.1.6.44.1.1
Syntax: 2.5.5.16
OmSyntax: 65
IsSingleValued: True
IsMemberOfPartialAttributeSet: False
SearchFlags: 0
AttributeSecurityGuid: <not set>
```

### msLAPS-Password

This attribute contains a Unicode string that specifies the clear-text version of the current password and other information.

```powershell
Name: ms-LAPS-Password
LDAP display name: msLAPS-Password
OID: 1.2.840.113556.1.6.44.1.2
Syntax: 2.5.5.5
OmSyntax: 19
IsSingleValued: True
IsMemberOfPartialAttributeSet: False
SearchFlags: 904
AttributeSecurityGuid: <not set>
```

The data that's stored in this attribute is a JSON string that contains multiple name-value pairs. For example:

`{"n":"Administrator","t":"1d8161b41c41cde","p":"A6a3#7%eb!57be4a4B95Z43394ba956de69e5d8975#$8a6d)4f82da6ad500HGx"}`

Each name-value pair in the JSON string has a specific meaning:

|Name|Value|
|---|---|
|`"n"`|Contains the name of the managed local administrator account|
|`"t"`|Contains the UTC password update time represented as a 64-bit hexadecimal number|
|`"p"`|Contains the clear-text password|

### msLAPS-EncryptedPassword

This attribute contains a byte string that contains an encrypted version of the current password.

```powershell
Name: ms-LAPS-EncryptedPassword
LDAP display name: msLAPS-EncryptedPassword
OID: 1.2.840.113556.1.6.44.1.3
Syntax: 2.5.5.10
OmSyntax: 4
IsSingleValued: True
IsMemberOfPartialAttributeSet: False
SearchFlags: 904
AttributeSecurityGuid: f3531ec6-6330-4f8e-8d39-7a671fbac605 (ms-LAPS-Encrypted-Password-Attributes)
```

### msLAPS-EncryptedPasswordHistory

This attribute contains a multi-valued byte string. Each value contains an encrypted version of an earlier password.

```powershell
Name: ms-LAPS-EncryptedPasswordHistory
LDAP display name: msLAPS-EncryptedPasswordHistory
OID: 1.2.840.113556.1.6.44.1.4
Syntax: 2.5.5.10
OmSyntax: 4
IsSingleValued: False
IsMemberOfPartialAttributeSet: False
SearchFlags: 904
AttributeSecurityGuid: f3531ec6-6330-4f8e-8d39-7a671fbac605 (ms-LAPS-Encrypted-Password-Attributes)
```

### msLAPS-EncryptedDSRMPassword

This attribute contains a byte string that contains an encrypted version of the current Directory Services Restore Mode (DSRM) account password.

```powershell
Name: ms-LAPS-EncryptedDSRMPassword
LDAP display name: msLAPS-EncryptedDSRMPassword
OID: 1.2.840.113556.1.6.44.1.5
Syntax: 2.5.5.10
OmSyntax: 4
IsSingleValued: True
IsMemberOfPartialAttributeSet: False
SearchFlags: 904
AttributeSecurityGuid: f3531ec6-6330-4f8e-8d39-7a671fbac605 (ms-LAPS-Encrypted-Password-Attributes)
```

### msLAPS-EncryptedDSRMPasswordHistory

This attribute contains a multi-valued byte string. Each value contains an encrypted version of an earlier DSRM account password.

```powershell
Name: ms-LAPS-EncryptedDSRMPasswordHistory
LDAP display name: msLAPS-EncryptedDSRMPasswordHistory
OID: 1.2.840.113556.1.6.44.1.6
Syntax: 2.5.5.10
OmSyntax: 4
IsSingleValued: False
IsMemberOfPartialAttributeSet: False
SearchFlags: 904
AttributeSecurityGuid: f3531ec6-6330-4f8e-8d39-7a671fbac605 (ms-LAPS-Encrypted-Password-Attributes)
```

## Extended rights

Windows LAPS extends the `ms-LAPS-Encrypted-Password-Attributes` rights in Windows Server Active Directory. You can use the `ms-LAPS-Encrypted-Password-Attributes` extended rights to grant managed devices SELF permissions to read and write the encrypted password attributes that are described in the preceding sections.

```powershell
Name: ms-LAPS-Encrypted-Password-Attributes
Rights guid: f3531ec6-6330-4f8e-8d39-7a671fbac605
Valid accesses: 48 (RIGHT_DS_READ_PROPERTY | RIGHT_DS_WRITE_PROPERTY)
```

## Windows LAPS schema vs. legacy Microsoft LAPS schema

Like Windows LAPS, legacy Microsoft LAPS also requires you to use schema extensions for a Windows Server Active Directory deployment. To help you plan a migration from legacy Microsoft LAPS to Windows LAPS, the following table shows a logical mapping of schema extension elements:

|Windows LAPS schema element|Legacy Microsoft LAPS schema element|
|---|---|
|`msLAPS-PasswordExpirationTime`|`ms-Mcs-AdmPwdExpirationTime`|
|`msLAPS-Password`|`ms-Mcs-AdmPwd`|
|`msLAPS-EncryptedPassword`|Doesn't apply|
|`msLAPS-EncryptedPasswordHistory`|Doesn't apply|
|`msLAPS-EncryptedDSRMPassword`|Doesn't apply|
|`msLAPS-EncryptedDSRMPasswordHistory`|Doesn't apply|
|`ms-LAPS-Encrypted-Password-Attributes`|Doesn't apply|

## Next steps

- [Key concepts in Windows LAPS](laps-concepts.md)
- [Use Windows LAPS event logs](laps-management-event-log.md)
