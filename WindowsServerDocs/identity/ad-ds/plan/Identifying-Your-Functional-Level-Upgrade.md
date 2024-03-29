---
description: Learn more about identifying your functional level upgrade in Windows and Windows Server
title: Identifying your functional level upgrade
author: iainfoulds
ms.author: daveba
ms.date: 04/05/2024
ms.topic: how-to
---

# Identifying your functional level upgrade

>Applies to: Windows Server 2025 (Preview), Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012
<!-- I could not locate archived content for 2000, 2003, 2008 R2; a separate article will need to be created. This version removes the content for 2000, 2003, 2008 R2  -->
Before you can raise domain and forest functional levels, you have to evaluate your current environment and identify the functional level requirement that best meets the needs of your organization. Assess your current environment by identifying the domains in your forest, the domain controllers that are located in each domain, the operating system and service packs that each domain controller is running, and the date that you plan to upgrade the domain controllers. If you plan to retire a domain controller, make sure that you understand the full impact that doing so will have on your environment.

The following circumstances might prevent you from upgrading an earlier version of the Windows Server operating system to your desired version of Windows Server:

- Insufficient hardware

- A domain controller running an antivirus program that is incompatible with later versions of Windows Server

- Use of a version-specific program that does not run on later versions of Windows Server

- The need to upgrade a program with the latest service pack

Documenting this information can help you identify the steps to take to ensure that you have a fully functional Windows Server environment.

After you assess your current environment, you have to identify the functional level upgrade that applies to your organization. These options are available:

- Windows native-mode environment to Windows Server 2016. Windows Server 2019, Windows Server 2022 or Windows Server 2025 (Preview)

- Windows Server forest to Windows Server 2016, Windows Server 2019, Windows Server 2022, or Windows Server 2025 (Preview)

## Upgrading functional levels in a native Windows Active Directory forest

In a Windows native environment that consists only of Windows-based domain controllers, the functional levels are set by default and they remain at thoselevels until you raise them manually.

- Windows 2000 native domain functional level

- Windows 2000 forest functional level

To use all the forest-level and domain-level features in Windows Server, your Windows native environment must be Windows Server 2016.

> [!NOTE]
> Before you raise the domain functional level, you must upgrade all Windows domain controllers in that domain to Windows Server 2016.

After you replace all the Windows domain controllers in the forest with domain controllers that run Windows Server 2016, you can raise the forest functional level to Windows Server 2016. Doing so automatically raises the functional level of all domains in the forest that are set to Windows 2000 native or higher to Windows Server 2016.

For more information about raising forest and domain functional levels, and for procedures to perform those tasks, see [Deploying a Windows Server 2008 Forest Root Domain](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc731174(v=ws.10)).

For more information about raising forest and domain functional levels, and for procedures to perform those tasks, see [Deploying a Windows Server 2008 Forest Root Domain](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc731174(v=ws.10)).

For more information about raising forest and domain functional levels, and for procedures to perform those tasks, see [Deploying a Windows Server 2008 Forest Root Domain](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc731174(v=ws.10)).

For more information about raising forest and domain functional levels, and for procedures to perform those tasks, see [Deploying a Windows Server 2008 Forest Root Domain](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc731174(v=ws.10)).