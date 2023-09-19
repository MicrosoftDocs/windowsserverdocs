---
title: Upgrade and conversion options for Windows Server
description: Explains how to upgrade or convert Windows Server to newer versions, different editions, and switch between licensing options, such as evaluation, retail, and volume licensed.
ms.date: 11/25/2021
ms.topic: conceptual
ms.assetid: 74aa1da3-7076-4a1f-ad5b-9e17bd46dba2
author: dknappettmsft
ms.author: daknappe
manager: femila
---

# Upgrade and conversion options for Windows Server

You can upgrade or convert installations of Windows Server to newer versions, different editions, or switch between licensing options, such as evaluation, retail, and volume licensed. This article helps explain what the options are to help with your planning.

The process of upgrading or converting installations of Windows Server might vary greatly depending on which version and edition you have installed, how it is licensed, and the pathway you take. We use different terms to distinguish between actions, any of which could be involved in a deployment of Windows Server: clean install, in-place upgrade, cluster operating system (OS) rolling upgrade, migration, and license conversion. You can learn more about these terms at [Install, upgrade, or migrate](install-upgrade-migrate.md).

## Upgrading licensed versions of Windows Server

Below are general guidelines for in-place upgrade paths where Windows Server is **already licensed** (that is, not evaluation):

- Upgrades from 32-bit to 64-bit architectures are not supported. All releases of Windows Server since Windows Server 2008 R2 are 64-bit only.
- Upgrades from one language to another are not supported.
- If the server is an Active Directory domain controller, you cannot convert it to a retail version. See [Upgrade Domain Controllers to Windows Server 2012 R2 and Windows Server 2012](../identity/ad-ds/deploy/upgrade-domain-controllers-to-windows-server-2012-r2-and-windows-server-2012.md) for important information.
- Upgrades from pre-release versions (previews) of Windows Server are not supported. Perform a clean installation of Windows Server.
- Upgrades that switch from a Server Core installation to a Server with Desktop Experience installation (or vice versa) are not supported.
- Upgrades from a previous Windows Server installation to an evaluation copy of Windows Server are not supported. Evaluation versions should be installed as a clean installation.
- When upgrading from a previous version to a new version, by default, you retain the existing operating system edition. You upgrade from Standard (previous version) to Standard (new version), from Datacenter (previous version) to Datacenter (new version), or from Datacenter: Azure Edition (previous version) to Datacenter: Azure Edition (new version).
- Alternatively, you can change from Standard to Datacenter, or to Datacenter: Azure Edition when upgrading. You can also change from Datacenter to Datacenter: Azure Edition. Changing from Datacenter to Standard, or from Datacenter: Azure Edition to either Standard or Datacenter is not supported.

> [!IMPORTANT]
> If your server uses NIC Teaming, disable NIC Teaming prior to upgrade, and then re-enable it after upgrade is complete. See [NIC Teaming Overview](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831648(v=ws.11)) for details.

## Converting an evaluation version to a retail version

You can convert the evaluation version of Windows Server to the retail version. If you have installed the evaluation of Standard edition, you can convert it to the retail version of either the Standard edition or Datacenter edition. Similarly, if you have installed the evaluation of the Datacenter edition, you can only convert it to the retail version of the Datacenter edition.

If you haven't already activated Windows, the bottom right-hand corner of the desktop shows the time remaining in the evaluation period.

> [!IMPORTANT]
> For releases of Windows Server 2016 prior to 14393.0.161119-1705.RS1_REFRESH, you can only convert from evaluation to retail when Windows Server has been installed with the Server with Desktop Experience installation option (not Server Core). Starting with version 14393.0.161119-1705.RS1_REFRESH and later releases, you can convert evaluation editions to retail regardless of the installation option used.

> [!NOTE]
> Before you attempt to convert from evaluation to retail, verify that your server is actually running an evaluation version. To do this, launch an elevated command prompt and run the command `slmgr.vbs /dlv`; evaluation versions will include **EVAL** in the output.

### Windows Server Standard or Datacenter

If the server is running an evaluation version of Windows Server Standard edition or Windows Server Datacenter edition, you can convert it to a retail version as follows:

1. From an elevated command prompt or PowerShell session, run the following command to save the Microsoft Software License Terms for Windows Server, which you can then review:

   ```
   DISM /online /Set-Edition:ServerDatacenter /GetEula:C:\eula.rtf
   ```

1. Determine the current edition name by running the command below. The output is an abbreviated form of the edition name, for example Windows Server Datacenter edition is **ServerDatacenter**:

   ```
   DISM /online /Get-CurrentEdition
   ```

1. Verify which editions the current installation can be converted to by running the command below. The evaluation version of Windows Server Standard can be converted to the retail version of either the Standard or Datacenter editions of Windows Server, whereas the evaluation version of Windows Server Datacenter can only be converted to the retail version Windows Server Datacenter:

   ```
   DISM /online /Get-TargetEditions
   ```

1. Make note of the target edition name you want to convert to, and enter this and your retail product key in the command below. This process requires you to accept the Microsoft Software License Terms for Windows Server you saved previously.

   > [!TIP]
   > You can convert from the evaluation version of Windows Server Standard to the retail version of Windows Server Datacenter in one step by using the appropriate product key and edition ID.

   ```
   DISM /online /Set-Edition:<edition ID> /ProductKey:XXXXX-XXXXX-XXXXX-XXXXX-XXXXX /AcceptEula
   ```

   For example:

   ```
   DISM /online /Set-Edition:ServerDatacenter /ProductKey:ABCDE-12345-ABCDE-12345-ABCDE /AcceptEula
   ```

> [!TIP]
> For more information about Dism.exe, see [DISM Command-line options](/previous-versions/orphan-topics/ws.10/dd772580(v=ws.10)).

> [!IMPORTANT]
> If the server is an Active Directory domain controller, you cannot convert it to a retail version. In this case, install an additional domain controller on a server that runs a retail version, migrate any FSMO roles held, and remove Active Directory Domain Services (AD DS) from the domain controller that runs on the evaluation version. For more information, see [Upgrade Domain Controllers to Windows Server 2012 R2 and Windows Server 2012](../identity/ad-ds/deploy/upgrade-domain-controllers-to-windows-server-2012-r2-and-windows-server-2012.md).

### Windows Server Essentials

If the server is running Windows Server Essentials, you can convert it to the full retail version by entering a retail, volume license, or OEM key by launching an elevated command prompt and entering it as part of the following command:

   ```
   slmgr.vbs /ipk XXXXX-XXXXX-XXXXX-XXXXX-XXXXX
   ```

## Converting Windows Server Standard edition to Datacenter edition

At any time after installing Windows Server, you can convert Windows Server Standard edition to Datacenter edition. You can also run `setup.exe` from the installation media to upgrade or repair the installation (sometimes called in-place repair). If you run `setup.exe` to upgrade or repair in-place on any edition of Windows Server, the result will be the same edition you started with.

You can convert the Standard edition of Windows Server to the Datacenter edition as follows:

1. Determine that Windows Server Standard is the current edition name by running the command below. The output is an abbreviated form of the edition name, for example Windows Server Standard edition is **ServerStandard**:

   ```
   DISM /online /Get-CurrentEdition
   ```

1. Verify that Windows Server Datacenter is a valid option to convert to by running the following command:

   ```
   DISM /online /Get-TargetEditions
   ```

1. Enter **ServerDatacenter** and your retail product key in the command below:

   ```
   DISM /online /Set-Edition:ServerDatacenter /ProductKey:XXXXX-XXXXX-XXXXX-XXXXX-XXXXX /AcceptEula
   ```

## Converting between retail, volume-licensed, and OEM licenses

At any time after installing Windows Server, you can freely convert between a retail license, a volume-licensed license, or an OEM license. The edition (Standard or Datacenter) remains the same during this conversion. If you are starting with an evaluation version, [convert it to the retail version first](#converting-an-evaluation-version-to-a-retail-version), then you can convert between the versions.

To do this, run the following command from an elevated command prompt, including providing your volume-license, retail, or OEM product key:

```
slmgr.vbs /ipk XXXXX-XXXXX-XXXXX-XXXXX-XXXXX
```
