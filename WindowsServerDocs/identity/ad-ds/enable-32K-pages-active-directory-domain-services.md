---
title: Enable 32K pages in Acrtive Directory Domain Services
description: 
author: gswashington
ms.author: robinharwood
ms.date: 05/25/2024
ms.topic: how-to
---

# Enable 32K pages in Acrtive Directory Domain Services

Applies to: Windows Server 2025 (preview), Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012

## 32K database page size option

The latest enhancements to Active Directory Domain Services (AD DS) and Active Directory Lightweight Domain Services (AD LDS) introduce a range of new functionalities and capabilities aimed at optimizing your domain management experience. Among these is the 32k database page size optional feature - AD uses an Extensible Storage Engine (ESE) database since its introduction in Windows 2000 that uses an 8k database page size. The 8k architectural design decision resulted in limitations throughout AD that are documented in AD Maximum Limits Scalability. An example of this limitation is a single record AD object, which can't exceed 8k bytes in size. Moving to a 32k database page format offers a huge improvement in areas affected by legacy restrictions, including multi-valued attributes are now able to hold up to approximately 3,200 values, an increase by a factor of 2.6.

## Prerequisites

Before you can enable 32k pages in your Active Directory Domain Services, you'll need to make sure of the following:

- All Domain Controllers must be upgraded to Windows Server 2025 (preview)
- Domain and forest functional levels must be upgraded accordingly
- Verified backup of Active Directory should be taken before making changes
- All applications and services that interact with Active Directory must are compatible with the 32K pages feature

## Enable 32K pages in Active Directory Domain Services using PowerShell

The 32k database page size is an optional feature in Active Directory; it is not enabled by default in Windows Server. The exception is in Windows Server 2025 (preview) domains and forests, where the 32k database page size feature is enabled by default.

You can enable the 32k Pages optional feature using the `Enable-ADOptionalFeature` PowerShell command. 

Before starting this procedure, you must make sure that all domain controllers in the existing forest are upgraded to Windows Server 2025 (preview) and the domain and functional levels also have been upgraded.

New doman controllerss can be installed with a 32k page database that uses 64-bit Long Value IDs (LIDs) and runs in an "8k page mode" for compatibility with previous versions. An upgraded domain controller continues to use its current database format and 8k pages. Moving to 32k database pages is done on a forest-wide basis and requires that all domain controllers in the forest have a 32k page-capable database.

> [!NOTE]
> Increased memory usage due to larger page sizes can impact server performance.

> [!NOTE]
> You can't go back to 8k-page mode after you have enabled 32k-page mode.

# [PowerShell](#tab/powershell)

From an elevated PowerShell prompt, run the following command:

```powershell
Enable-ADOptoponalFeature
    [-Whatif]
    [-Confirm]   
    [-AuthType <ADAuthType>]
    [-Credential <PSCredential>]
    [-Identity] <ADOptionalFeature>
    [-PassThru]
    [-Scope] <ADOptionalFeatureScope>
    [-Server <String>]
    [-Target] <ADEntity>
    [-<CommonParameters>]
    
```

---

You will be prompted to confirm that you want to enable the 32k Page feature. Select Yes or Yes to All to proceed.

:::image type="content" source="media/enable-32k-pages-active-directory-domain-services/feature-checks.jpg" alt-text="Screenshot showing confirmation before proceeding with enabling of 32k page feature on sample target database contoso":::

After the 32k Page feature is enabled, monitor the replication traffic after the change; the initial replication may be larger than usual.

You also must check for any hardcoded scripts or applications that assume a specific page size and update them accordingly.

## Related reading

- [What's new in Windows Server 2025 (preview)](https://learn.microsoft.com/windows-server/get-started/whats-new-windows-server-2025#active-directory-domain-services)