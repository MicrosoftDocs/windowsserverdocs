---
title: Find the Current Active Directory Schema Version
description: This article describes how to find the current schema version in Active Directory for Windows Server.
author: robinharwood
ms.author: roharwoo
ms.date: 07/08/2025
ms.topic: how-to
---

# Find the current Active Directory schema version

An Active Directory (AD) schema is a set of rules that defines what kinds of object classes you can create in an AD forest. For more information, see [Active Directory schema (AD DS)](/windows/win32/ad/active-directory-schema).

This article walks you through how to find the schema version and Exchange Services schema version that your forest uses.

## Prerequisites

To perform the tasks described in this article, ensure that your environment meets the following requirements:

- Your machine should run Microsoft Exchange Server 2016 or later.
- You must install the Active Directory Domain Services (AD DS) role. To learn more, see [Install or uninstall roles, role services, or features](../../../administration/server-manager/install-or-uninstall-roles-role-services-or-features.md).
- The server must be a domain controller (DC).
- Users must be part of the Domain Admins or Enterprise Admins group.

## Finding the schema version

To find the current Active Directory schema version:

> [!NOTE]
> The internal root domain used in this demo is **contoso.local**. You need to modify the DC= field to correspond with the AD configuration in your own environment.
>
>Depending on your configuration, you might also need to import the AD PowerShell module by running the `Import-Module ActiveDirectory` command before you can start running AD cmdlets.

#### [GUI](#tab/gui)

1. Open the **Start** menu.

1. Enter **ADSIEdit.msc**, and then select **Enter** to open **ADSI Edit**.

1. In the pane on the left side of the window, right-click **ADSI Edit**, and then select **Connect to**.

1. In the **Connection Settings** window, under **Select a well known Naming Context**, select **Schema**, and then select **OK**.

1. In the pane on the left side of the window, expand the schema for your DC.

1. Right-click **CN=Schema,CN=Configuration,DC=contoso,DC=local** and then select **Properties**.

1. In the **Attribute** list, scroll down until you find the *objectvVersion* attribute. The value is the schema version.

#### [CMD](#tab/cmd)

Use the `DSQuery` command line. Run the following command:

```cmd
dsquery * "cn=schema,cn=configuration,dc=contoso,dc=local" -scope base -attr objectVersion
```

#### [PowerShell](#tab/powershell)

Use the `Get-ItemProperty` PowerShell cmdlet. Run the following command:

```powershell
Get-ItemProperty 'AD:\CN=Schema,CN=Configuration,DC=contoso,DC=local' -Name objectVersion
```

---

When you finish, use the table in [Mapping the objectVersion attribute](#mapping-the-objectversion-attribute) to find which operating system (OS) version corresponds to your version number.

### Mapping the objectVersion attribute

The following table maps the number shown in the **objectVersion** attribute with its corresponding OS version:

| Version | Operating system |
|---|---|
|91|Windows Server 2025|
|88|Windows Server 2022|
|88|Windows Server 2019|
|87|Windows Server 2016|
|69|Windows Server 2012 R2|
|56|Windows Server 2012|
|47|Windows Server 2008 R2|
|44|Windows Server 2008 RTM|
|31|Windows Server 2003 R2|
|30|Windows Server 2003 RTM, Windows 2003 Service Pack 1, Windows 2003 Service Pack 2|

## Find the current Exchange Schema version

To find the current Exchange Schema version, you can use one of the following methods:

#### [GUI](#tab/gui)

1. Open the **Start** menu.

1. Enter **ADSIEdit.msc**, and then select **Enter** to open **ADSI Edit**.

1. In the pane on the left side of the window, right-click **ADSI Edit**, and then select **Connect to**.

1. In the **Connection Settings** window, under **Select a well known Naming Context**, select **Schema**, and then select **OK**.

1. In the pane on the left side of the window, expand the schema for your DC.

1. Select **CN=Schema,CN=Configuration,DC=contoso,DC=local**.

1. In the pane in the center of the window, scroll down the **Name** list and open **CN=ms-Exch-Schema-Version-Pt**.

1. In the **Attribute** list, scroll down until you find the *rangeUpper* attribute. The value is the schema version.

#### [CMD](#tab/cmd)

Use the `DSQuery` command:

```cmd
dsquery * "CN=ms-Exch-Schema-Version-Pt,cn=schema,cn=configuration,dc=contoso,dc=local" -scope base -attr rangeUpper
```

#### [PowerShell](#tab/powershell)

Run the `Get-ItemProperty` PowerShell cmdlet:

```powershell
Get-ItemProperty "AD:\CN=ms-Exch-Schema-Version-Pt,cn=schema,cn=configuration,$((get-addomain).DistinguishedName)" -Name rangeUpper
```

---

When you finish, use the information in [Mapping the rangeUpper attribute](#mapping-the-rangeupper-attribute) to determine which version of Exchange Schema corresponds to your attribute value.

### Mapping the rangeUpper attribute

The following articles show how to map the **rangeUpper** attribute value with its corresponding Exchange Schema version:

- [Exchange 2016 Active Directory versions](/exchange/plan-and-deploy/prepare-ad-and-domains?view=exchserver-2016&preserve-view=true#exchange-2016-active-directory-versions)
- [Exchange 2019 Active Directory versions](/exchange/plan-and-deploy/prepare-ad-and-domains?view=exchserver-2019&preserve-view=true#exchange-2019-active-directory-versions)

## Related content

- [Windows Server Active Directory schema updates](Schema-Updates.md)

