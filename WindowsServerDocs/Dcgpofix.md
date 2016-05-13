---
title: Dcgpofix
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 81d5fa65-2aea-49d3-b353-357441846c00
---
# Dcgpofix
Recreates the default Group Policy Objects \(GPOs\) for a domain. For examples of how this command can be used, see [Examples](#BKMK_Examples).

## Syntax

```
DCGPOFix [/ignoreschema] [/target: {Domain | DC | Both}] [/?]
```

### Parameters

|Parameter|Description|
|-------------|---------------|
|\/ignoreschema|Ignores the version of the Active Directory® schema mc<br /><br />when you run this command. Otherwise, the command only works on the same schema version as the Windows version in which the command was shipped.|
|\/target {Domain &#124; DC &#124; Both}|Specifies which GPO to restore. You can restore the Default Domain Policy GPO, the Default Domain Controllers GPO, or both.|
|\/?|Displays Help at the command prompt.|

## Remarks

-   The **dcgpofix** command is available in [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)] and [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)], except on Server Core installations.

-   Although the [!INCLUDE[gpmc_1](includes/gpmc_1_md.md)] is distributed with [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)] and [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)], you must install Group Policy Management as a feature through Server Manager.

## <a name="BKMK_Examples"></a>Examples
Restore the Default Domain Policy GPO to its original state. You will lose any changes that you have made to this GPO. As a best practice, you should configure the Default Domain Policy GPO only to manage the default Account Policies settings, Password Policy, Account Lockout Policy, and Kerberos Policy. In this example, you ignore the version of the Active Directory schema so that the **dcgpofix** command is not limited to same schema as the Windows version in which the command was shipped.

```
dcgpofix /ignoreschema /target:Domain
```

Restore the Default Domain Controllers Policy GPO to its original state. You will lose any changes that you have made to this GPO. As a best practice, you should configure the Default Domain Controllers Policy GPO only to set user rights and audit policies. In this example, you ignore the version of the Active Directory schema so that the **dcgpofix** command is not limited to same schema as the Windows version in which the command was shipped.

```
dcgpofix /ignoreschema /target:DC
```

## Additional references

-   [Group Policy TechCenter](http://go.microsoft.com/fwlink/?LinkID=145531)

-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)


