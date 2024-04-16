---
description: Learn more about identifying your functional level upgrade in Windows and Windows Server
title: Identifying your functional level upgrade
author: iainfoulds
ms.author: daveba
ms.date: 04/25/2024
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

After you assess your current environment, you have to identify the functional level upgrade that applies to your organization. These options are available:

- Windows 2000 native-mode environment to Windows Server 2008 or Windows Server 2008 R2

- Windows Server 2003 forest to Windows Server 2008 or Windows Server 2008 R2

- New Windows Server 2008 forest

- New Windows Server 2008 R2 forest

- Windows Server 2016 forest to Windows Server 2022 or Windows Server 2025 (preview)

## Upgrading functional levels to Windows Server 2025 (preview)

Functional level upgrade for Windows Server 2025 (preview) includes the following requirements:

- For new Active Directory forests, the minimum functional level must be set to Server 2016.

- Existing domains must be at least at the 2016 functional level to promote a Windows Server 2025 to a domain controller.

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

- The Active Directory forest functional level must be at least Windows Server 2003.

- All applications and services must be compatible with the new functional level.

There are two upgrade options to choose from, as follows: 

- In-place upgrade of existing domain controllers

- Migration to new domain controllers running Windows Server 2016

   > [!IMPORTANT]
   > You must check for deprecated features prior to upgrade to make certain that none are being used. Also verify that all domain controllers are correctly replicated both before and after the upgrade.  

## Upgrading functional levels in a native Windows 2000 Active Directory forest

In a Windows 2000 native environment that consists only of Windows 2000-based domain controllers, the functional levels are set by default to the following levels, and they remain at these levels until you raise them manually:

- Windows 2000 native domain functional level

- Windows 2000 forest functional level

- Windows native-mode environment to Windows Server 2016. Windows Server 2019, Windows Server 2022 or Windows Server 2025 (preview)

To use all the forest-level and domain-level features in Windows Server 2008 or Windows Server 2008 R2, you have to upgrade this Windows 2000 environment to Windows Server 2008 or Windows Server 2008 R2. You can perform this upgrade in either of the following ways:

- Upgrade your Windows Server forest to Windows Server 2016, Windows Server 2019, Windows Server 2022, or Windows Server 2025 (preview).

- Introduce newly installed Windows Server 2008 -based or Windows Server 2008 R2 -based domain controllers into the forest, and then retire all domain controllers running Windows 2000.

- Perform an in-place upgrade of all existing domain controllers running Windows 2000 in the forest to domain controllers running Windows Server 2003. Then, perform an in-place upgrade of those domain controllers to Windows Server 2008 or Windows Server 2008 R2. For more information, see [Upgrading Active Directory Domains to Windows Server 2008 and Windows Server 2008 R2 AD DS Domains](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc731188(v=ws.10)).

    > [!IMPORTANT]
    >  Windows Server 2008 R2 is an x64-based operating system. If your server is running an x64-based version of Windows Server 2003, you can successfully perform an in-place upgrade of this computer's operating system to Windows Server 2008 R2. If your server is running an x86-based version of Windows Server 2003, you cannot upgrade this computer to Windows Server 2008 R2.

To use the Windows Server 2008 or Windows Server 2008 R2 domain-level features without upgrading your entire Windows 2000 forest to Windows Server 2008 or Windows Server 2008 R2 , raise only the domain functional level to Windows Server 2008 or Windows Server 2008 R2.

> [!NOTE]
> Before you raise the domain functional level, you must upgrade all Windows 2000-based domain controllers in that domain to Windows Server 2008 or Windows Server 2008 R2.

After you replace all the Windows 2000-based domain controllers in the forest with domain controllers that run Windows Server 2008 or Windows Server 2008 R2 , you can raise the forest functional level to Windows Server 2008 or Windows Server 2008 R2. Doing so automatically raises the functional level of all domains in the forest that are set to Windows 2000 native or higher to Windows Server 2008 or Windows Server 2008 R2.

For more information about raising forest and domain functional levels, and for procedures to perform those tasks, see [Deploying a Windows Server 2008 Forest Root Domain](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc731174(v=ws.10)).

## Upgrading functional levels in a Windows Server 2003 Active Directory forest

In a Windows native environment that consists only of Windows-based domain controllers, the functional levels are set by default and remain at those levels until you raise them manually.

- Windows 2000 native domain functional level

- Windows 2000 forest functional level

To use all the forest-level and domain-level features in Windows Server, your Windows native environment must run Windows Server 2016.

- Introduce a newly installed Windows Server 2008 -based or Windows Server 2008 R2 -based domain controller into the forest, and then retire all domain controllers running Windows Server 2003 or upgrade them to Windows Server 2008 or Windows Server 2008 R2.

- Perform an in-place upgrade of all existing domain controllers running Windows Server 2003 to domain controllers running Windows Server 2008 or Windows Server 2008 R2. For more information, see [Upgrading Active Directory Domains to Windows Server 2008 and Windows Server 2008 R2 AD DS Domains](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc731188(v=ws.10)).

> [!IMPORTANT]
> Windows Server 2008 R2 is an x64-based operating system. If your server is running an x64-based version of Windows Server 2003, you can successfully perform an in-place upgrade of this computer's operating system to Windows Server 2008 R2. If your server is running an x86-based version of Windows Server 2003, you cannot upgrade this computer to run Windows Server 2008 R2.

To use all the Windows Server 2008 or Windows Server 2008 R2 domain-level features without upgrading your entire Windows Server 2003 forest to Windows Server 2008 or Windows Server 2008 R2 , raise only the domain functional level to Windows Server 2008 or Windows Server 2008 R2.

> [!NOTE]
> Before you raise the domain functional level, you must upgrade all Windows Server 2003-based domain controllers in that domain to Windows Server 2008 or Windows Server 2008 R2.

After you replace all the Windows domain controllers in the forest with domain controllers that run Windows Server 2016, you can raise the forest functional level to Windows Server 2016. Doing so automatically raises the functional level of all domains in the forest that are set to Windows 2000 native or higher to Windows Server 2016.

For more information about raising forest and domain functional levels, and for procedures to perform those tasks, see [Deploying a Windows Server 2008 Forest Root Domain](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc731174(v=ws.10)).

## Upgrading functional levels in a new Windows Server 2008 forest

When you install the first domain controller in a new Windows Server 2008 forest, functional levels are set by default to the following levels, and they remain at these levels until you raise them manually:

- Windows 2000 native domain functional level

- Windows 2000 forest functional level

Functional levels are set at these default levels to give you the option of adding Windows 2000 or Windows Server 2003-based domain controllers to your new Windows Server 2008 forest. After you create a forest root domain, the domain functional level for each domain that you add to the Windows Server 2008 forest is set to Windows 2000 native. However, if you want all domain controllers in your new Windows Server 2008 environment to run Windows Server 2008, set the forest functional level, and then the domain functional level, to Windows Server 2008 when you install the first domain controller in your forest. Doing this saves time and enables all the forest-level and domain-level features in Windows Server 2008.

> [!IMPORTANT]
> If the forest operates at the Windows Server 2008 functional level and you attempt to install Active Directory on a Windows Server 2003-based member server or a Windows 2000-based member server, the installation fails.

For more information about raising forest and domain functional levels, and for procedures to perform those tasks, see [Deploying a Windows Server 2008 Forest Root Domain](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc731174(v=ws.10)).

## Upgrading functional levels in a new Windows Server 2008 R2 forest

When you install the first domain controller in a new Windows Server 2008 R2 forest, functional levels are set by default to the following levels, and they remain at these levels until you raise them manually:

- Windows Server 2003 domain functional level

- Windows Server 2003 forest functional level

Functional levels are set at these default levels to give you the option of adding Windows Server 2003-based domain controllers to your new Windows Server 2008 R2 forest. After you create a forest root domain, the domain functional level for each domain that you add to the Windows Server 2008 R2 forest is set to Windows Server 2003. However, if you want all domain controllers in your new Windows Server 2008 R2 environment to run Windows Server 2008 R2 , set the forest functional level, and then the domain functional level, to Windows Server 2008 R2 when you install the first domain controller in your forest. Doing this saves time and enables all forest-level and domain-level features in Windows Server 2008 R2.

> [!IMPORTANT]
> If the forest operates at the Windows Server 2008 R2 functional level and you attempt to install Active Directory on a Windows Server 2008 -based or Windows Server 2003-based member server, or on a Windows 2000-based member server, the installation fails.

For more information about raising forest and domain functional levels, and for procedures to perform those tasks, see [Deploying a Windows Server 2008 Forest Root Domain](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc731174(v=ws.10)).

> [!NOTE]
> Although ADMT v3.1 must be installed on Windows Server 2008, you can use ADMT v3.1 to migrate objects to a domain that is hosted by one or more Windows Server 2008 R2 domain controllers. For more information, see article 976659 in the Microsoft Knowledge Base, [Known issues that may occur when you use ADMT 3.1 to migrate to a domain that contains Windows Server 2008 R2 domain controllers](https://support.microsoft.com/help/97665)