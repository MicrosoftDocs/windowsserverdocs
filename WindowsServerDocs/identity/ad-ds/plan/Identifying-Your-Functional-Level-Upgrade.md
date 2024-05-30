---
description: Upgrade your domain and forest functional level in Active Director Domain Services for Windows Server
title: Learn about upgrading your domain and forest functional levels in Active Directory Domain Services.
author: robinharwood
ms.author: wscontent
ms.date: 05/29/2024
ms.topic: conceptual
---

# Identifying your functional level upgrade

>Applies to: Windows Server 2025 (preview), Windows Server 2022, Windows Server 2019, Windows Server 2016

Before you can raise domain and forest functional levels, you have to evaluate your current environment and identify the functional level requirement that best meets the needs of your organization. Assess your current environment by identifying the domains in your forest, the domain controllers that are located in each domain, the operating system and updates that each domain controller is running, and when you plan to upgrade the domain controllers. If you plan to retire a domain controller, make sure that you understand the full impact that doing so will have on your environment. In this article you learn about the process and prerequisites for upgrading your domain and forest functional levels in Active Directory Domain Services.

The following circumstances might prevent you from upgrading Windows Server functional level:

- Insufficient hardware

- A domain controller running an antivirus or backup programs that are incompatible with newer versions of Windows Server

- Use of a version-specific program that isn't compatible with newer versions of Windows Server

- The need to upgrade a program with the latest update

Documenting this information can help you identify the steps to take to ensure that you have a fully functional Windows Server environment.

After you assess your current environment, you have to identify the functional level upgrade that applies to your organization. This article discusses the following options:

- Upgrade to a Windows Server 2025 (preview) forest
- Upgrade to a Windows Server 2016 forest

> [!IMPORTANT]
> Windows Server 2025 is in PREVIEW. This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

## Upgrading functional levels to Windows Server 2025

In an environment consisting of only Windows Server 2025-based domain controllers, the functional levels default to Windows Server 2025. If your Active Directory Domain Services environment contains a mix of Windows Server releases, your functional levels might be set to a lower level.

To use all the forest-level and domain-level features in Windows Server 2025, you have to upgrade to the Windows Server 2025 forest and domain functional levels. To upgrade your domain controllers to Windows Server 2025, you must meet the following prerequisites:

- For new Active Directory forests, the minimum functional level that can be set is Windows Server 2016.

- Existing domains must be at the 2016 functional level to promote a Windows Server 2025 domain controller.

 You can upgrade the functional levels by using the following options:

- Set up a new Active Directory domain with the new Domain Functional Level (DFL) and Forest Functional Level (FFL) when promoting the first Domain Controller for the new domain

- Introduce new Windows Server 2025 domain controllers into the forest, then retire or upgrade all domain controllers running an older version of Windows Server. After you've upgraded or retired all domain controllers running an older version of Windows Server, you can raise the domain and forest functional levels to Windows Server 2025.

- Perform a Feature Update of all existing domain controllers running an older version of Windows Server. To learn more about performing a Feature Update, see [Perform a Feature Update of Windows Server](../../../get-started/perform-in-place-upgrade.md). Then raise the domain and forest functional levels to Windows Server 2025.

   > [!IMPORTANT]
   > A Windows Server 2025 domain controller can only be added to an existing domain that is running Windows Server 2016 Domain Functional Level or newer version. You must also ensure that all hardware and software requirements for Windows Server 2025 are met.

## Upgrading functional levels in a Windows Server 2016 Active Directory forest

In an environment that consisting of Windows Server 2016, 2019 and 2022-based domain controllers, the functional levels are set by default to the following level, and they remain at these levels until you raise them manually after an upgrade to Windows Server 2025 or later.

- Windows Server 2016 domain functional level

- Windows Server 2016 forest functional level

> [!NOTE]
> Windows Server 2019 and 2022 used Windows Server 2016 as the most recent functional levels.

To use all the forest-level and domain-level features in Windows Server 2016, you have to upgrade to the Windows Server 2016 forest and domain functional levels. To upgrade your domain controllers to Windows Server 2016, you must meet the following prerequisites:

- All domain controllers must be running Windows Server 2016, Windows Server 2019, or Windows Server 2022.

- The Active Directory forest functional level must be at least Windows Server 2012.

There are two upgrade options to choose from, as follows:

- Set up a new Active Directory domain with the new Domain Functional Level (DFL) and Forest Functional Level (FFL) when promoting the first Domain Controller for the new domain

- Introduce new Windows Server 2016, 2019 or 2022 domain controllers into the forest, then retire or upgrade all domain controllers running an older version of Windows Server. After you've upgraded or retired all domain controllers running an older version of Windows Server, you can raise the domain and forest functional levels to Windows Server 2016.

- Perform a Feature Update of all existing domain controllers running an older version of Windows Server. To learn more about performing a Feature Update, see [Perform a Feature Update of Windows Server](../../../get-started/perform-in-place-upgrade.md). Then raise the domain and forest functional levels to Windows Server 2016.

   > [!IMPORTANT]
   > You must check for removed features prior to upgrade to make certain that none are being used. Also verify that all domain controllers are correctly replicated both before and after the upgrade. To learn more about removed features, see [Features Removed or Deprecated in  Windows Server 2016](../../../get-started/removed-deprecated-features-windows-server-2016.md).

## Upgrading functional levels in a previous versions of Windows Server

If you are looking to identify functional levels for a previous version of Windows Server, see [Identifying your functional level upgrade](previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc754209(v=ws.10)).
