---
title: Windows Defender Overview for Windows Server
description: Windows Server Security
ms.topic: article
ms.assetid: 751efb33-a08e-4e90-9208-6f2bc319e029
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/12/2016
---
# Windows Defender Antivirus for Windows Server

>Applies To: Windows Server 2016

Windows Server 2016 now includes Windows Defender Antivirus. Windows Defender AV is malware protection that immediately and actively protects Windows Server 2016 against known malware and can regularly update antimalware definitions through Windows Update.

See the [Windows Defender Antivirus in Windows 10](/windows/threat-protection/windows-defender-antivirus/windows-defender-antivirus-in-windows-10) documentation library for more information.


While the functionality, configuration, and management is largely the same for Windows Defender AV either on Windows 10 or Windows Server 2016, there are a few key differences:

- In Windows Server 2016, [automatic exclusions](/windows/threat-protection/windows-defender-antivirus/configure-server-exclusions-windows-defender-antivirus) are applied based on your defined Server Role.
- In Windows Server 2016, Windows Defender AV will not disable itself if you are running another antivirus product.

The [Windows Defender Antivirus on Windows Server 2016](/windows/threat-protection/windows-defender-antivirus/windows-defender-antivirus-on-windows-server-2016) topic contains set up and configuration information specific to Windows Server 2016, including how to:

-   [Enable the interface](/windows/threat-protection/windows-defender-antivirus/windows-defender-antivirus-on-windows-server-2016#BKMK_UsingDef)

-   [Verify Windows Defender AV is running]( /windows/threat-protection/windows-defender-antivirus/windows-defender-antivirus-on-windows-server-2016#BKMK_DefRun)

-   [Update antimalware definitions]( /windows/threat-protection/windows-defender-antivirus/windows-defender-antivirus-on-windows-server-2016#BKMK_UpdateDef)

-   [Submit Samples]( /windows/threat-protection/windows-defender-antivirus/windows-defender-antivirus-on-windows-server-2016#BKMK_DefSamples)

-   [Configure automatic exclusions]( /windows/threat-protection/windows-defender-antivirus/windows-defender-antivirus-on-windows-server-2016#BKMK_DefExclusions)