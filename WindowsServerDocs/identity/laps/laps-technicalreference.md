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

## Overview

This article provides additional technical details that may be helpful when deploying or managing Windows LAPS.

## Active Directory Schema Extensions

This section documents the new elements added to the Active Directory schema by the `Update-LapsADSchema` cmdlet.

### Active Directory Schema Attributes

|LDAP display name|OID|Syntax|OmSyntax|IsSingleValued|IsMemberOfPartialAttributeSet|SearchFlags|AttributeSecurityGuid|
|---|---|---|---|---|---|---|---|
|msLAPS-PasswordExpirationTime|1.2.840.113556.1.6.44.1.1|2.5.5.16|65|True|False|0||
|msLAPS-Password|1.2.840.113556.1.6.44.1.2|2.5.5.5|19|True|False|904||
|msLAPS-EncryptedPassword|1.2.840.113556.1.6.44.1.3|2.5.5.10|4|True|False|904|f3531ec6-6330-4f8e-8d39-7a671fbac605|
|msLAPS-EncryptedPasswordHistory|1.2.840.113556.1.6.44.1.4|2.5.5.10|4|False|False|904|f3531ec6-6330-4f8e-8d39-7a671fbac605|
|msLAPS-EncryptedDSRMPassword|1.2.840.113556.1.6.44.1.5|2.5.5.10|4|True|False|904|f3531ec6-6330-4f8e-8d39-7a671fbac605|
|msLAPS-EncryptedDSRMPasswordHistory|1.2.840.113556.1.6.44.1.6|2.5.5.10|4|False|False|904|f3531ec6-6330-4f8e-8d39-7a671fbac605|

A SearchFlags value of 904 is composed of the following bit flags:

* fRODCFilteredAttribute
* fNEVERVALUEAUDIT
* fCONFIDENTIAL
* fPRESERVEONDELETE

### Active Directory Extended Rights

|LDAP display name|Rights guid|Valid accesses|
|---|---|---|
|ms-LAPS-Encrypted-Password-Attributes|f3531ec6-6330-4f8e-8d39-7a671fbac605|48|
