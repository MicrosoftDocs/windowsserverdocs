---
description: Learn more about identifying your functional level upgrade in Windows and Windows Server
title: Identifying your functional level upgrade
author: iainfoulds
ms.author: daveba
ms.date: 05/25/2024
ms.topic: how-to
---

# Identifying your functional level upgrade

>Applies to: Windows Server 2025 (preview), Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012

Before you can raise domain and forest functional levels, you have to evaluate your current environment and identify the functional level requirement that best meets the needs of your organization. Assess your current environment by identifying the domains in your forest, the domain controllers that are located in each domain, the operating system and service packs that each domain controller is running, and the date that you plan to upgrade the domain controllers. If you plan to retire a domain controller, make sure that you understand the full impact that doing so will have on your environment.

The following circumstances might prevent you from upgrading Windows Server functional level:

- Insufficient hardware

- A domain controller running an antivirus program that is incompatible with newer versions of Windows Server

- Use of a version-specific program that isn't compatible with newer versions of Windows Server

- The need to upgrade a program with the latest service pack

Documenting this information can help you identify the steps to take to ensure that you have a fully functional Windows Server environment.

After you assess your current environment, you have to identify the functional level upgrade that applies to your organization. This article discusses the following option:

- Windows Server 2016 forest to Windows Server 2025 (preview)

## Upgrading functional levels to Windows Server 2025 (preview)

Functional level upgrade for Windows Server 2025 (preview) includes the following requirements:

- For new Active Directory forests, the minimum functional level must be set to Server 2016.

- Existing domains must be at the 2016 functional level to promote a Windows Server 2025 to a domain controller.

> [!NOTE]
> Windows Server 2022 used Windows Server 2016 as the most recent functional levels prior to Windows Server 2025.

Upgrade methods include the following options:

- Set up a new Active Directory domain with the new Domain Functional Level (DFL) and Forest Functional Level (FFL) when promoting the first Domain Controller for the new domain

- Install Active Directory Domain Services on the new Windows Server to automatically run adprep on the previous version forest and domain

   > [!IMPORTANT]
   > A Windows Server 2025 (preview) domain controller can only be added to an existing domain that is running Windows Server 2016 Domain Functional Level or newer version. You must also ensure that all hardware and software requirements for Windows Server 2025 (preview) are met.

## Upgrading functional levels in a Windows 2016 Active Directory forest

In a Windows 2016 native environment that consists only of Windows 2016-based domain controllers, the functional levels are set by default to the following levels, and they remain at these levels until you raise them manually:

- Windows 2016 native domain functional level

- Windows 2016 forest functional level

In addition, the following must be true prior to upgrade:

- All domain controllers must be running Windows Server 2016, Windows Server 2019, or Windows Server 2022.

- The Active Directory forest functional level must be at least Windows Server 2012.

- All applications and services must be compatible with the new functional level.

There are two upgrade options to choose from, as follows: 

- In-place upgrade of existing domain controllers

- Migration to new domain controllers running Windows Server 2016

   > [!IMPORTANT]
   > You must check for deprecated features prior to upgrade to make certain that none are being used. Also verify that all domain controllers are correctly replicated both before and after the upgrade.

> [!NOTE]
   > If you are looking to identify functional levels for a previous version of Windows Server, see [Identifying your functional level upgrade]()https://learn.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc754209(v=ws.10).