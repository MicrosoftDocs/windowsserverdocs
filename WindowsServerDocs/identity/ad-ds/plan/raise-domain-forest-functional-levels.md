---
title: Raise domain and forest functional levels in Active Directory Domain Services on Windows Server
description: Learn how to raise Active Directory domain and forest functional levels on Windows Server
ms.topic: how-to
ms.author: wscontent
author: gswashington
ms.date: 09/25/2024
---
# Raise domain and forest functional levels in Active Directory Domain Services

>Applies to: Windows Server 2025 (preview), Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012

> [!IMPORTANT]
> Windows Server 2025 is in PREVIEW. This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

This article describes how to raise Active Directory domain and forest functional levels in Microsoft Windows Server domain controllers. Functional levels determine the available Active Directory Domain Services (AD DS) domain or forest capabilities. They also determine which Windows Server operating systems you can run on domain controllers in the domain or forest. Level changes happen when you use later versions of your domain controller operating system, the domain, or your forest functional level.

Functional levels are an extension of the mixed mode and native mode concepts in Windows Server that activate Active Directory features. Active Directory features become available when all domain controllers run the latest version of Windows Server in a domain or forest and the administrator activates the corresponding functional level.

To activate the latest domain features, all domain controllers in the domain must run the latest version of Windows Server. If they don't meet this requirement, the administrator can't raise the domain functional level.

To activate the latest forest-wide features, all domain controllers in the forest must run the Windows Server operating system version that matches the desired forest functional level. The current domain functional level must also already be at the latest level. If the forest meets these requirements, the administrator can raise the forest functional level.

> [!WARNING]
> Changes to the domain and forest functional levels are irreversible. In order to undo the change, you must perform a forest recovery to revert to an earlier point of time.

The domain and forest functional levels only affect how the domain controllers operate together as a group. The clients that interact with the domain or with the forest are unaffected by the changes. Applications are also unaffected by these changes. However, applications can use new features found in later versions of Windows Server once the administrator raises the domain level. For more information about the functional levels, see [Active Directory Domain Services functional levels](/windows-server/identity/ad-ds/active-directory-functional-levels).

## Prerequisites

You need to complete the following things to raise the domain functional level in Windows Server:

- All domain controllers in the domain are running at least the version of Windows Server that you want to raise the domain functional level to. For example, to raise the domain functional level to Windows Server 2025, all domain controllers in the domain must be running Windows Server 2025. If you have domain controllers running earlier versions of Windows Server, you must upgrade them to Windows Server 2025 before you can raise the domain functional level.

- Before you can promote a machine running Windows Server 2025 to a domain controller in an existing domain, that domain must also be at least at the Windows Server 2016 functional level. For newly created Active Directory forests under Windows Server 2025, the minimum functional level is Windows Server 2016.

- Your Active Directory forest and domain is operational and free from replication errors. To learn more about replication errors, see [Diagnose Active Directory replication failures](/troubleshoot/windows-server/active-directory/diagnose-replication-failures).

- Identify all your DCs hosting the Global Catalog (GC) and FSMO roles. Create and verify backups of these Active Directory Domain Services domain controllers before making changes.

- You must be a member of the Enterprise Admins group or equivalent to raise the forest functional level.

> [!NOTE]
> Before you can promote a machine running Windows Server 2025 to a domain controller in an existing domain, that domain must also be at least at the Windows Server 2016 functional level.

## View the current functional level

You can use Lightweight Directory Access Protocol (LDAP) tools such as _Ldp.exe_ and _Adsiedit.msc_ to view the current domain and forest functional level settings. The most common method to upgrade the domain and forest functional levels is to use the Active Directory Domains and Trusts console, found in the Remote Server Administration Tools (RSAT). You can either configure the functional level using the console or use PowerShell cmdlets. For more information about how to use Windows PowerShell to configure the functional level, see [Set-ADDomainMode](/powershell/module/activedirectory/set-adforestmode) and [Set-ADDomainMode](/powershell/module/activedirectory/set-addomainmode).

We recommend you upgrade Active Directory and Active Directory Lightweight Directory Services servers to the latest release.

> [!IMPORTANT]
> Before you can promote a machine running Windows Server 2025 to a domain controller, you must make sure all domain controllers in the existing domain are running Windows Server 2016 or later. Earlier versions of Windows Server don't support Windows Server 2025 domain controllers.
>
> When you install Active Directory Domain Services on Windows Server 2025 (preview), it automatically runs _adprep_ on any forest or domain running earlier versions of Windows Server.

### Domain functional level

To view the current domain functional level, use _ADSI Edit_ to view the current `msDS-Behavior-Version` attribute for the domain.

1. Sign in to a domain controller.

1. Select the Start menu, then enter _ADSI Edit_ in the search box.

1. Open the **ADSI Edit** app.

1. In the navigation plane, right-click **ADSI Edit**, and then select **Connect to**.

1. In the **Connection Settings** dialog box, select **OK** to using the defaults to connect to the Default naming context for the current domain.

1. Expand the **Default naming context** node then right-click the domain node, and then select **Properties**.

1. In the **Properties** dialog box, locate the **msDS-Behavior-Version** attribute. This attribute contains the current domain functional level.

The `msDS-Behavior-Version` attribute represents the highest possible functional level for this domain controller. The values for this attribute are:

- Windows Server 2000: `0` or `Windows2000Domain`

- Windows Server 2003 Interim Domain: `1` or `Windows2003InterimDomain`

- Windows Server 2003: `2` or `Windows2003Domain`

- Windows Server 2008: `3` or `Windows2008Domain`

- Windows Server 2008 R2: `4` or `Windows2008R2Domain`

- Windows Server 2012: `5` or `Windows2012Domain`

- Windows Server 2012 R2: `6` or `Windows2012R2Domain`

- Windows Server 2016: `7` or `WinThreshold`

- Windows Server 2025: `10` or `Windows2025Domain`

### Mixed mode and native mode

The `ntMixedDomain` attribute, also located in the default naming context properties, shows the domain mode.

The following are the values for this attribute:

- `0` = Native level domain

- `1` = Mixed level domain

### Forest level

To view the current forest functional level, use _ADSI Edit_ to view the current `msDS-Behavior-Version` attribute for the forest. Follow the steps to view the `msDS-Behavior-Version` attribute in the CN=Partitions object found in the Configuration naming context (NC).

1. From ADSI Edit, right-click the **ADSI Edit** node, and then select **Connect to**.

1. In the **Connection Settings** dialog box, select **Configuration** from the **Select a well known Naming Context**, then select **OK**.

1. Expand the **Configuration** node, then the configuration container. The container is in the form of `CN=Configuration,DC=<domain name>,DC=<top level domain>`.

1. Right-click the **CN=Partitions** container, and then select **Properties**.

1. In the **Properties** dialog box, locate the **msDS-Behavior-Version** attribute. This attribute contains the current forest functional level.

The `msDS-Behavior-Version` attribute represents the highest possible functional level for this forest. The values for this attribut eare:

- Windows Server 2000: `0` or `Windows2000Forest`

- Windows Server 2003 Interim Forest: `1` or `Windows2003InterimForest`

- Windows Server 2003: `2` or `Windows2003Forest`

- Windows Server 2008: `3` or `Windows2008Forest`

- Windows Server 2008 R2: `4` or `Windows2008R2Forest`

- Windows Server 2012: `5` or `Windows2012Forest`

- Windows Server 2012 R2: `6` or `Windows2012R2Forest`

- Windows Server 2016: `7` or `WinThreshold`

- Windows Server 2025: `10` or `Windows2025Forest`

## Raise the functional level

To raise the domain and forest functional levels, you can use the Active Directory Domains and Trusts console or Windows PowerShell. The following sections describe how to raise the functional levels using these methods.

> [!WARNING]
> Changes to the domain and forest functional levels are irreversible. In order to undo the change, you must perform a forest recovery to revert to an earlier point of time.

### [Desktop](#tab/desktop)

To raise the domain or forest functional level using the Active Directory Domains and Trusts console, follow these steps.

1. Sign in to a domain controller.

1. Select the Start menu, then enter _Active Directory Domains and Trusts_ in the search box.

1. Open the **Active Directory Domains and Trusts** app.

1. In the console tree, right-click the domain node, and then select **Raise Domain Functional Level**.

1. In **Select an available domain functional level**, select the value and then select **Raise**.

1. When prompted, select **OK** to confirm the change.

1. Once the domain functional level is raised, raise the forest functional level. In the console tree, right-click **Active Directory Domains and Trusts** , and then select **Raise Forest Functional Level**.

1. In **Select an available forest functional level**, select the value and then select **Raise**.

You've now raised the domain and forest functional level.

### [PowerShell](#tab/PowerShell)

To raise the domain or forest functional level using PowerShell, follow these steps.

1. Sign in to a domain controller.

1. Open PowerShell as an administrator.

1. Run the following command to raise the domain functional level, replacing `<domain>` with the domain name and `<level>` with the desired domain functional level.
  
      ```powershell
      Set-ADDomainMode -Identity <domain> -DomainMode <level>
      ```

1. To confirm the change, select **Y**.

1. Once the domain functional level is raised, run the following command to raise the forest functional level, replacing `<level>` with the desired forest functional level.

      ```powershell
      Set-ADForestMode -Identity <forest> -ForestMode <level>
      ```

1. To confirm the change, select **Y**.

You've now raised the domain and forest functional level.

---

## Related content

- [Forest and Domain Functional Levels](../active-directory-functional-levels.md)

- [Identifying Your Functional Level Upgrade](Identifying-Your-Functional-Level-Upgrade.md)
