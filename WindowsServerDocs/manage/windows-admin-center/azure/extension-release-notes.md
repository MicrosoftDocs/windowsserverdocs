---
title: What's new with the Windows Admin Center Azure extension
description: This article has release notes for the Windows Admin Center agent for Windows Admin Center in Azure.
ms.topic: overview
author: prasidharora
ms.author: praror
ms.date: 01/23/2023
---

# What's new with Windows Admin Center Azure extension

The Windows Admin Center Azure extension (seen as "AdminCenter" in Azure) receives improvements on an ongoing basis. To stay up to date with the most recent developments, this article provides you with information about:

- The latest releases
- Known issues
- Bug fixes

This page is updated monthly, so revisit it regularly.

> [!NOTE]
> This article is only for Windows Admin Center in Azure. For release notes on Windows Admin Center on-premises, navigate to [release history](/windows-server/manage/windows-admin-center/support/release-history).

## Version 0.0.0.228 - January 2023

### New features

- Updated the build of Windows Admin Center to the v2211. A few highlights are listed below. For a full summary, visit [our blog post](https://aka.ms/wac2211).
    - Support for WDAC-enforced infrastructure
    - Support for 400% zoom
    - Search settings with smart keywords
    - Azure Stack HCI management improvements

## Version 0.0.0.224 - December 2022

### Fixed

- Fixed AAD authentication when managing domain controllers. AAD authentication is not supported on domain controllers and users must enter local administrator credentials

## Version 0.0.0.221 - October 2022

### New features

- Introduced AAD authentication for Windows Server Azure Virtual Machines and Arc-enabled Servers. Azure Stack HCI does not support AAD authentication yet.
- Windows Admin Center for Azure Virtual Machines is now generally available. Windows Admin Center for Arc-enabled servers and Azure Stack HCI remains in Public Preview.