---
title: Enable 32K pages in Acrtive Directory Domain Services
description: 
author: gswashington
ms.author: robinharwood
ms.date: 05/xx/2024
ms.topic: how-to
---

# Enable 32K pages in Active Directory Domain Services

Applies to: Windows Server 2025 (preview), Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 

## 32K database page size feature

The latest enhancements to Active Directory Domain Services (AD DS) and Active Directory Lightweight Domain Services (AD LDS) introduce a range of new functionalities and capabilities aimed at optimizing your domain management experience. Among these is the 32k database page size optional feature. See [32K pages in Active Directory Domain Services](/32K-page-feature-ad-domain-services.md) for more information.

## Prerequisites

Before you can enable 32k pages in your Active Directory Domain Services, you'll need to make sure of the following:

- All domain controllers must be upgraded to Windows Server 2025 (preview)
- Domain and forest functional levels must be upgraded accordingly
- Verified backup of Active Directory should be taken before making changes
- All applications and services that interact with Active Directory must are compatible with the 32K pages feature

To enable the 32k page size feature, the following are required:

- The AD DS server role must be installed. To learn more, see [Install or Uninstall Roles, Role Services, or Features](/windows-server/administration/server-manager/install-or-uninstall-roles-role-services-or-features).
- Your device must be promoted to a domain controller (DC).
- The domain and forest functional levels of the DC must be set to Windows Server 2025 (preview).

## Enable 32k page feature using PowerShell

The 32k database page size is an optional feature in AD and isn't enabled by default in Windows Server, with the exception of Windows Server 2025 (preview).

New DCs can be installed with a 32k page database that uses 64-bit Long Value IDs (LIDs) and runs in an "8k page mode" for compatibility with previous versions. An upgraded DC continues to use its current database format and 8k pages. Moving to 32k database pages is done on a forest-wide basis and requires that all DCs in the forest have a 32k page-capable database.

> [!NOTE]
> Increased memory usage due to larger page sizes can impact server performance.

> [!WARNING]
> Once you have enabled the 32k database page feature, you can't revert back to the previous 8k page mode.

# [PowerShell](#tab/powershell)

To enable the 32k page feature in PowerShell, users can run the Enable-ADOptionalFeature cmdlet from an elevated prompt. In this example, we are enabling this feature for the device named DC1 in the contoso domain:

```powershell
$params = @{
Identity = 'Database 32 pages feature'
Scope = 'ForestOrConfiguration'
Server = 'DC1'
Target = 'contoso.com'
}
Enable-ADOptionalFeature $params
    
```

---

Select **Yes** or **Yes to All** to proceed. >> Select [Y] Yes or [A] Yes to All to proceed.

After the 32k Page feature is enabled, monitor the replication traffic after the change; the initial replication may be larger than usual.

You also must check for any hardcoded scripts or applications that assume a specific page size and update them accordingly.

## Considerations enabling 32k page feature

When creating a backup of an AD database, the page size of the database is preserved on a backup media. Prior to Windows Server 2025, all backup media was limited to 8k-page databases, which was the only page size supported. However, a Windows Server 2025 machine may have either an 8k or 32k-page database, depending on whether it was:

- Upgraded from a previous operating system version
- Promoted to a DC over-the-wire
- Restored from a 32k-page backup image

Before enabling the 32k-page feature, either 8k or 32k page backup media can be used to restore a Windows Server 2025 DC. After enabling the 32k-page feature, only 32k page backup media can be used to restore a Windows Server 2025 DC. It's important to note that enabling the 32k-page feature is irreversible. As a result, any 8k-page backup media created prior to enabling the feature will be unusable unless a complete forest recovery is performed.

## Related reading

- [What's new in Windows Server 2025 (preview)](/windows-server/get-started/whats-new-windows-server-2025#active-directory-domain-services)