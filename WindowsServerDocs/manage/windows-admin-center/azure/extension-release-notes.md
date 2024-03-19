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

## Version 0.0.0.332 - December 2023

### New features
- Updated the build of Windows Admin Center to v2311. For a full summary of new features, visit [our blog post](https://aka.ms/wac2311)
- Added support for installation when TLS 1.3 is enabled

### Fixed
- Fixed an issue where momentarily losing access to IMDS/HIMDS does not result in Windows Admin Center installation failure

## Version 0.0.0.329 - November 2023

### Fixed
- Removed the "Unrestricted" execution policy when Windows Admin Center scripts are executed
- Added more logging when proxies are used for better debugging

## Version 0.0.0.324 - September 2023

### Fixed
- Fixed an issue where Windows Admin Center's certificate validation would not cause Windows Admin Center to fail if a valid certificate is already available. This issue would show up during server reboots when the "Enable" operation is run.

## Version 0.0.0.323 - August 2023

### Fixed
- Fixed an issue where an additional URL was required when using proxies
- Updated the build of Windows Admin Center to the latest preview version.

## Version 0.0.0.322 - July 2023

### New features
- Introduced support for proxies. You can now configure a proxy to monitor/filter all outbound traffic from the AdminCenter extension.
- Updated the build of Windows Admin Center to v2306. For a full summary of new features, visit [our blog post](https://aka.ms/wac2306)
- Introduced new management capabilities for Azure Stack HCI - Remote Support and Diagnostics

## Version 0.0.0.313 - April 2023

### New features
- Introduced Microsoft Entra authentication for Azure Stack HCI. Note that this functionality is in preview. Please create a support ticket for all issues.
- Introduced a **Network** tool
- Introduced Virtual Machine Live Storage Migration
- Introduced new security experiences for Azure Stack HCI clusters with the supplemental package

### Fixed
- If a prior installation of Windows Admin Center exists on your machine, the extension will first uninstall it before installing Windows Admin Center in Azure
- Fixed the infinite loading of the Remote Desktop tool

## Version 0.0.0.228 - January 2023

### New features
- Updated the build of Windows Admin Center to v2211. A few highlights are listed. For a full summary, visit [our blog post](https://aka.ms/wac2211).
    - Support for WDAC-enforced infrastructure
    - Support for 400% zoom
    - Search settings with smart keywords
    - Azure Stack HCI management improvements

## Version 0.0.0.224 - December 2022

### Fixed

- Fixed Microsoft Entra authentication when managing domain controllers. Microsoft Entra authentication isn't supported on domain controllers and users must enter local administrator credentials.

## Version 0.0.0.221 - October 2022

### New features

- Introduced Microsoft Entra authentication for Windows Server Azure Virtual Machines and Arc-enabled Servers. Azure Stack HCI doesn't support Microsoft Entra authentication yet.
- Windows Admin Center for Azure Virtual Machines is now generally available. Windows Admin Center for Arc-enabled servers and Azure Stack HCI remains in Public Preview.
