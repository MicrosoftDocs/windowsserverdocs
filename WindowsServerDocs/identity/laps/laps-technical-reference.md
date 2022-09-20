---
ms.assetid: 1d4c57e1-9203-4f15-80fb-0197dd3839ac
title: Local Administrator Password Solution Technical Reference
description: Local Administrator Password Solution Technical Reference
author: jsimmons
ms.author: jsimmons
manager: jsimmons
ms.date: 07/04/2022
ms.topic: article
---

# Windows LAPS Technical Reference

This article provides other technical details that may be helpful when deploying or managing Windows LAPS.

## Windows Server Active Directory Schema Extensions

This section documents the new Windows LAPS Windows Server Active Directory schema elements. In order to use any of the Windows LAPS Windows Server Active Directory-based features, you must add these new schema elements to the forest by running the `Update-LapsADSchema` cmdlet.

### Windows Server Active Directory schema attributes

Windows LAPS uses many new schema attributes that are all stored on the computer object in Windows Server Active Directory for a given managed device. The `Update-LapsADSchema` cmdlet adds these new schema attributes to the directory, and also adds them to the mayContain list on the computer schema class.

> [!TIP]
> Many of the attributes below specify a SearchFlags value of 904. For easy reference, this value is composed of the following bit flags:
>
> * fRODCFilteredAttribute
> * fNEVERVALUEAUDIT
> * fCONFIDENTIAL
> * fPRESERVEONDELETE

#### msLAPS-PasswordExpirationTime

This attribute contains a 64-bit integer that specifies the currently scheduled password expiration time in UTC.

```text
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

#### msLAPS-Password

This attribute contains a Unicode string that specifies the clear-text version of the current password (plus other information).

```text
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

The data stored in this attribute is a JSON string containing multiple name-value pairs. For example:

`{"n":"Administrator","t":"1d8161b41c41cde","p":"A6a3#7%eb!57be4a4B95Z43394ba956de69e5d8975#$8a6d)4f82da6ad500HGx"}`

Each name-value pair in the JSON string has a specific meaning as follows:

|Name|Value|
|---|---|
|"n"|Contains the name of the managed local administrator account|
|"t"|Contains the UTC password update time represented as a 64-bit hexadecimal number|
|"p"|Contains the clear-text password|

#### msLAPS-EncryptedPassword

This attribute contains a byte string that contains an encrypted version of the current password.

```text
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

#### msLAPS-EncryptedPasswordHistory

This attribute contains a multi-valued byte string, where each value contains an encrypted version of a previous password.

```text
Name: ms-LAPS-EncryptedPassword
LDAP display name: msLAPS-EncryptedPassword
OID: 1.2.840.113556.1.6.44.1.4
Syntax: 2.5.5.10
OmSyntax: 4
IsSingleValued: False
IsMemberOfPartialAttributeSet: False
SearchFlags: 904
AttributeSecurityGuid: f3531ec6-6330-4f8e-8d39-7a671fbac605 (ms-LAPS-Encrypted-Password-Attributes)
```

#### msLAPS-EncryptedDSRMPassword

This attribute contains a byte string that contains an encrypted version of the current Directory Services Repair Mode (DSRM) account password.

```text
Name: ms-LAPS-EncryptedPassword
LDAP display name: msLAPS-EncryptedPassword
OID: 1.2.840.113556.1.6.44.1.5
Syntax: 2.5.5.10
OmSyntax: 4
IsSingleValued: True
IsMemberOfPartialAttributeSet: False
SearchFlags: 904
AttributeSecurityGuid: f3531ec6-6330-4f8e-8d39-7a671fbac605 (ms-LAPS-Encrypted-Password-Attributes)
```

#### msLAPS-EncryptedDSRMPasswordHistory

This attribute contains a multi-valued byte string, where each value contains an encrypted version of a previous Directory Services Repair Mode (DSRM) account password.

```text
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

### Windows Server Active Directory extended rights

#### ms-LAPS-Encrypted-Password-Attributes

The ms-LAPS-Encrypted-Password-Attributes extended right is used to grant managed devices SELF permission to read and write the various encrypted password attributes (see above).

```text
Name: ms-LAPS-Encrypted-Password-Attributes
Rights guid: f3531ec6-6330-4f8e-8d39-7a671fbac605
Valid accesses: 48 (RIGHT_DS_READ_PROPERTY | RIGHT_DS_WRITE_PROPERTY)
```

### Comparison with legacy LAPS schema

Legacy LAPS also required extension of the Windows Server Active Directory schema. For comparison purposes, this table provides a logical mapping between the Windows LAPS schema elements versus the legacy LAPS schema elements.

|Windows LAPS schema element|Legacy LAPS schema element|
|---|---|
|msLAPS-PasswordExpirationTime|ms-Mcs-AdmPwdExpirationTime|
|msLAPS-Password|ms-Mcs-AdmPwd|
|msLAPS-EncryptedPassword|N\A|
|msLAPS-EncryptedPasswordHistory|N\A|
|msLAPS-EncryptedDSRMPassword|N\A|
|msLAPS-EncryptedDSRMPasswordHistory|N\A|
|ms-LAPS-Encrypted-Password-Attributes|N\A|

## See also

[Windows LAPS Concepts](../laps/laps-concepts.md)
