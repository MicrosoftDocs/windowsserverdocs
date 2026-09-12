---
title: Lower AD DS Domain and Forest Functional Levels in Windows Server
description: Learn how to lower the domain or forest functional level in Active Directory Domain Services (AD DS) on Windows Server with PowerShell.
ms.topic: how-to
ms.author: roharwoo
author: robinharwood
ms.date: 07/03/2026
ai-usage: ai-assisted

#customer intent: As an AD DS administrator, I want to lower the domain or forest functional level so that I can roll back to a supported earlier level.
---
# Lower domain and forest functional levels in Active Directory Domain Services

Functional levels determine the capabilities available in an Active Directory Domain Services (AD DS) domain or forest, and which Windows Server operating systems you can run on domain controllers. You raise a functional level to enable newer capabilities. Raising a level is no longer permanent, so you can lower a domain or forest back to a supported earlier level. You might need to lower the level if you raise it before your environment is ready, or if you need to add domain controllers that run an earlier version of Windows Server.

This article shows how to lower domain and forest functional levels by using PowerShell. After you complete the steps, the domain or forest operates at the level you specify, provided it meets the prerequisites described in this article.

## Prerequisites

Before you lower a functional level, make sure your environment meets the prerequisites in this section.

### Permissions and tools

- To lower the domain functional level, you're a member of the Domain Admins group or have equivalent permissions. To lower the forest functional level, you're a member of the Enterprise Admins group or have equivalent permissions.

- You have a computer with the AD DS Remote Server Administration Tools (RSAT) installed, including the Active Directory module for Windows PowerShell.

### Supported rollback levels

- If your forest or domain contains Windows Server 2022 or earlier domain controllers, the lowest level you can roll back to is Windows Server 2008.

- If your forest or domain contains Windows Server 2025 domain controllers, the lowest level you can roll back to is Windows Server 2016.

### Forest functional level prerequisites

- Your forest doesn't use any forest-level features exclusive to the current functional level. After you enable a feature tied to a specific forest functional level, you can't roll back to a lower level.

- You have access to the domain controller that holds the Schema Operations Master flexible single master operations (FSMO) role.

### Domain functional level prerequisites

- Your domain doesn't use any features exclusive to the current domain functional level. For details about the features each level supports, see [Active Directory Domain Services functional levels](../active-directory-functional-levels.md).

- The target domain functional level isn't lower than the current forest functional level.

- You have network connectivity to the domain controller that holds the Primary Domain Controller (PDC) emulator FSMO role.

## Lower the forest functional level

To lower the forest functional level by using PowerShell:

1. Sign in to a computer with RSAT installed.

1. Open PowerShell as an administrator.

1. Run the following command to lower the forest functional level. Replace *`<forest>`* with the forest name and *`<level>`* with the forest functional level you want. For example, use `Windows2016Forest` to roll back to the Windows Server 2016 level.

   ```powershell
   Set-ADForestMode -Identity <forest> -ForestMode <level>
   ```

1. When PowerShell prompts you to confirm, enter **Y**.

1. Run the following command to verify the change.

   ```powershell
   Get-ADForest | Select-Object ForestMode
   ```

1. Confirm that `ForestMode` shows the level you set.

## Lower the domain functional level

To lower the domain functional level by using PowerShell:

1. Sign in to a computer with RSAT installed.

1. Open PowerShell as an administrator.

1. Run the following command to lower the domain functional level. Replace *`<domain>`* with the domain name and *`<level>`* with the domain functional level you want. For example, use `Windows2016Domain` to roll back to the Windows Server 2016 level.

   ```powershell
   Set-ADDomainMode -Identity <domain> -DomainMode <level>
   ```

1. When PowerShell prompts you to confirm, enter **Y**.

1. Run the following command to verify the change.

   ```powershell
   Get-ADDomain | Select-Object DomainMode
   ```

1. Confirm that `DomainMode` shows the level you set.

## Related content

- [Raise domain and forest functional levels in Active Directory Domain Services](raise-domain-forest-functional-levels.md)

- [Active Directory Domain Services functional levels](../active-directory-functional-levels.md)

- [Set-ADDomainMode](/powershell/module/activedirectory/set-addomainmode)

- [Set-ADForestMode](/powershell/module/activedirectory/set-adforestmode)
