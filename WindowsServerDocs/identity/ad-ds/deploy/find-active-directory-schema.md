---
title: 
description: 
author: 
ms.author: 
manager: 
ms.date: 
ms.topic: article
---

# Find the current Active Directory schema

<!--For the intro, get more info from the PM about what this process is for--->

## Prerequisites

In order to perform the tasks described in this article, you need the following things:

- Admin-level permissions

## Finding the schema version

To find the current Active Directory schema version:

> [!NOTE]
> The internal root domain that we use in this demo is **contoso.local**.

#### [Active Directory](#tab/active-directory)

1. Use *ADSIEdit.msc* or *LDP.exe* to navigate to:  
    **CN=Schema,CN=Configuration,DC=contoso,DC=local**.

1. Review the **objectVersion** attribute.

#### [Command-line interface](#tab/cli)

Use the `DSQuery` command line. Run the following command:

```console
dsquery * "cn=schema,cn=configuration,dc=contoso,dc=local" -scope base -attr objectVersion
```

#### [PowerShell](#tab/powershell)

Use the `Get-ItemProperty` PowerShell cmdlet. Run the following command:

```powershell
Get-ItemProperty 'AD:\CN=Schema,CN=Configuration,DC=contoso,DC=local' -Name objectVersion
```

---

### "objectVersion" attribute to Operating System

The following information provides a mapping between the **objectVersion** attribute value and the Active Directory Schema commutability:

| Version | Operating System |
|---|---|
|13|Windows 2000 Server|
|30|Windows Server 2003 RTM, Windows 2003 Service Pack 1, Windows 2003 Service Pack 2|
|31|Windows Server 2003 R2|
|44|Windows Server 2008 RTM|
|47|Windows Server 2008 R2|
|56|Windows Server 2012|
|69|Windows Server 2012 R2|
|87|Windows Server 2016|
|88|Windows Server 2019|
|88|Windows Server 2022|

## Find the current Exchange Schema Version

To find the current Exchange Schema Version, you can use one of the following methods:  

>[!Note]
>The internal root domain that we use in this demo is **contoso.local**.

#### [Active Directory](#tab/active-directory)

1. Use *ADSIEdit.msc* or *LDP.exe* to navigate to:  
   **CN=ms-Exch-Schema-Version-Pt, CN=Schema,CN=Configuration,DC=contoso,DC=local**

2. Review the current **rangeUpper** attribute.

#### [Command-line interface](#tab/cli)

Use the `DSQuery` command line:

```console
dsquery * "CN=ms-Exch-Schema-Version-Pt,cn=schema,cn=configuration,dc=contoso,dc=local" -scope base -attr rangeUpper
```

#### [PowerShell](#tab/powershell)

Run the `Get-ItemProperty` PowerShell cmdlet:

```powershell
Get-ItemProperty "AD:\CN=ms-Exch-Schema-Version-Pt,cn=schema,cn=configuration,$((get-addomain).DistinguishedName)" -Name rangeUpper
```

---

### Some "rangeUpper" attribute map

The following articles provide a mapping between the **rangeUpper** attribute value and the Exchange Schema commutability:

- [Exchange 2016 Active Directory versions](/exchange/plan-and-deploy/prepare-ad-and-domains?view=exchserver-2016&preserve-view=true#exchange-2016-active-directory-versions)
- [Exchange 2019 Active Directory versions](/exchange/plan-and-deploy/prepare-ad-and-domains?view=exchserver-2019&preserve-view=true#exchange-2019-active-directory-versions)

## Related content

- [Schema updates](Schema-Updates.md)
