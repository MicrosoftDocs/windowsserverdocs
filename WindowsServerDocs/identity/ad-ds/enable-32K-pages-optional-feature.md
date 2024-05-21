---
title: Enable 32K pages in Active Directory Domain Services on Windows Server
description: Learn how-to enable 32K pages in Active Directory Domain Services and how to enable the optional feature using PowerShell.
author: gswashington
ms.author: wscontent
ms.date: 05/21/2024
ms.topic: how-to
#customer intent: As an Active Directory administrator, I want to enable the 32K pages feature in Active Directory Domain Services, so that I can improve scalability.
---

# Enable 32K pages in Active Directory Domain Services (preview)

Applies to: Windows Server 2025 (preview), Windows Server 2022, Windows Server 2019, Windows Server 2016

> [!IMPORTANT]
> Windows Server 2025 is in PREVIEW. This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

The 32K database page format is an optional Active Directory feature offering a huge improvement in scalability, including multi-valued attributes able to hold approximately 3,200 values. Beginning with Windows Server 2025, new Active Directory domain controllers are installed with a 32K page, by default these new domain controllers use an 8k page mode to support previous versions. An upgraded DC continues to use an 8K database format and pages. Moving to a 32k database page-size is a forest-wide operation and requires that all domain controllers in the forest have a 32k page capable database. Enabling database for 32k pages enables the database to use 64-bit Long Value IDs (LIDs). For more information about using 32K pages in Active Directory, see [32k pages in Active Directory Domain Services](32K-pages-optional-feature.md).

> [!WARNING]
> Once you have enabled the 32k database page feature, you can't revert back to the previous 8k page mode. As a result, any 8k-page backup media created prior to enabling the feature will be unusable unless a complete authoritative forest recovery is performed.

In this article, you learn how to enable the 32k page feature in Active Directory Domain Services using PowerShell.

## Prerequisites

Before you can enable 32k pages in Active Directory Domain Services, you need to complete the following prerequisites.

- Review the article [32K pages in Active Directory Domain Services and Active Directory Lightweight Domain Services](32K-pages-optional-feature.md) for other considerations before enabling the 32k page feature.
- Your Active Directory domain is operational and free from replication errors. To learn more about replication errors, see [Diagnose Active Directory replication failures](/troubleshoot/windows-server/active-directory/diagnose-replication-failures).
- All domain controllers must be upgraded to Windows Server 2025 or later.
- Domain and forest functional levels must be upgraded to Windows Server 2025 or later. To learn more about raising the functional levels, see the article [Raise Active Directory domain and forest functional levels](/troubleshoot/windows-server/active-directory/raise-active-directory-domain-forest-functional-levels).
- Identify all your domain controllers hosting the Global Catalog (GC) and FSMO roles. Create and verify backups of theses Active Directory Domain Server domain controllers before making changes.
- All the applications and services that interact with Active Directory must be compatible with the 32K pages feature.
- Your account must be a member of the Domain Admins group or have equivalent permissions.

## Enable the 32k page feature using PowerShell

The 32k database page size is an optional feature in AD and isn't enabled by default. To enable the 32k page feature in your forest or domain, follow the steps.

1. Sign in to a domain controller with an account that is a member of the Domain Admins group or has equivalent permissions.

1. Open an elevated PowerShell prompt.

1. To enable the 32k page feature in PowerShell, use the `Enable-ADOptionalFeature` cmdlet from an elevated prompt. In this example, the command enables this feature for the device named DC1 in the `contoso.com` domain. Make sure to replace the values for the `Server` and `Target` parameters with your own values.

   ```powershell
   $params = @{
   Identity = 'Database 32K pages feature'
   Scope = 'ForestOrConfigurationSet'
   Server = 'DC1'
   Target = 'contoso.com'
   }
   Enable-ADOptionalFeature $params
   ```

1. When you run the command, you're prompted to confirm the action. Enter **Yes** or **Yes to All** to proceed.

1. After the 32k Page feature is enabled, monitor the replication traffic after the change; the initial replication might be larger than usual.

1. Verify for your scripts or applications continue to work as expected.
