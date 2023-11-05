---
title: Upgrade and conversion options for Windows Server
description: Upgrade or convert Windows Server to newer versions, different editions, and switch between licensing options, such as evaluation, retail, and volume licensed.
ms.date: 09/18/2023
ms.topic: conceptual
ms.assetid: 74aa1da3-7076-4a1f-ad5b-9e17bd46dba2
author: dknappettmsft
ms.author: daknappe
manager: femila
---

# Upgrade and conversion options for Windows Server

You can upgrade or convert installations of Windows Server to newer versions, different editions, or switch between licensing options, such as evaluation, retail, and volume licensed. This article helps explain what the options are to help with your planning.

The process of upgrading or converting installations of Windows Server might vary greatly depending on which version and edition you have installed, how it's licensed, and the pathway you take. We use different terms to distinguish between actions, any of which could be involved in a deployment of Windows Server: clean install, in-place upgrade, cluster operating system (OS) rolling upgrade, migration, and license conversion. You can learn more about these terms at [Install, upgrade, or migrate to Windows Server](install-upgrade-migrate.md).

## Upgrade licensed versions of Windows Server

The following general guidelines are for in-place upgrade paths where Windows Server is **already licensed**, that is, not evaluation:

- Upgrades from 32-bit to 64-bit architectures aren't supported. All releases of Windows Server since Windows Server 2008 R2 are 64-bit only.
- Upgrades from one language to another aren't supported.
- If the server is an Active Directory domain controller, you can't convert it to a retail version. See [Upgrade Domain Controllers to Windows Server](../identity/ad-ds/deploy/upgrade-domain-controllers.md) for important information.
- Upgrades from prerelease versions (previews) of Windows Server aren't supported. Perform a clean installation of Windows Server.
- Upgrades that switch from a Server Core installation to a Server with Desktop Experience installation or vice versa aren't supported.
- Upgrades from a previous Windows Server installation to an evaluation copy of Windows Server aren't supported. Evaluation versions should be installed as clean installations.
- When you upgrade from a previous version to a new version, the default is to retain the existing operating system edition. For example, the default is to upgrade from Standard (previous version) to Standard (new version), from Datacenter (previous version) to Datacenter (new version), or from Datacenter: Azure Edition (previous version) to Datacenter: Azure Edition (new version).
- Alternatively, you can change to certain other editions when upgrading. You can change from Standard to Datacenter or to Datacenter: Azure Edition, or change from Datacenter to Datacenter: Azure Edition. You can't change from Datacenter to Standard edition or from Datacenter: Azure Edition to either Standard or Datacenter editions when upgrading.

> [!NOTE]
> If your server uses NIC Teaming, disable NIC Teaming prior to upgrade, and then re-enable it after upgrade is complete. See [NIC Teaming Overview](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831648(v=ws.11)) for details.

## Convert an evaluation version to a retail version

You can convert evaluation versions and editions of Windows Server to retail versions and editions. For example, if you've installed the evaluation version of Standard (Desktop Experience) edition, you can convert it to the retail version of either the Standard (Desktop Experience) edition or the Datacenter (Desktop Experience) edition.

However, you can't convert all Windows Server evaluation versions and editions to all retail versions or editions. For example, if you've installed the evaluation Datacenter edition, you can convert it only to the retail Datacenter edition, not to the retail Standard edition.

In Windows Server versions after 2016, if you've installed Desktop Experience evaluation versions, you can't convert them to Core retail versions. If you install the Standard Core evaluation version, you can convert it only to retail Datacenter Core, not to retail Standard Core.

It's important to run the `DISM /online /Get-TargetEditions` command as instructed in the following procedure to determine which retail versions you can upgrade to. If the retail version you want isn't listed as a target version, you need to do a fresh install of the retail version you want.

> [!NOTE]
> To verify that your server is running an evaluation version, you can run either of the following commands at an elevated command prompt:
> 
> - Run `DISM /online /Get-CurrentEdition` and make sure the current edition name includes `Eval`.
> - Run `slmgr.vbs /dlv` and make sure the output includes `EVAL`.

If you haven't already activated Windows, the bottom right-hand corner of the desktop shows the time remaining in the evaluation period.

### Windows Server Standard or Datacenter

If your server is running an evaluation version of Windows Server Standard or Datacenter edition, you can convert it to an available retail version. Run the following commands in an elevated command prompt or PowerShell session.

1. Determine the current edition name by running the following command. The output is an abbreviated form of the edition name. For example, Windows Server Datacenter (Desktop Experience) Evaluation edition is `ServerDatacenterEval`.

   ```cmd
   DISM /online /Get-CurrentEdition
   ```

1. Verify which editions the current installation can be converted to by running the following command. From the output, make a note of the edition name you want to upgrade to.

   ```cmd
   DISM /online /Get-TargetEditions
   ```

1. Run the following command to save the Microsoft Software License Terms for Windows Server, which you can then review. Replace the `<target edition>` placeholder with the edition name you noted from the previous step.

   ```cmd
   DISM /online /Set-Edition:<target edition> /GetEula:C:\license.rtf
   ```

1. Enter the new edition name and corresponding retail product key in the following command. The upgrade process requires you to accept the Microsoft Software License Terms for Windows Server that you saved previously.

   ```cmd
   DISM /online /Set-Edition:<target edition> /ProductKey:<product key> /AcceptEula
   ```

   For example:

   ```cmd
   DISM /online /Set-Edition:ServerDatacenter /ProductKey:ABCDE-12345-ABCDE-12345-ABCDE /AcceptEula
   ```

> [!TIP]
> For more information about Dism.exe, see [DISM Command-line options](/previous-versions/orphan-topics/ws.10/dd772580(v=ws.10)).

> [!IMPORTANT]
> You can't convert an Active Directory domain controller from an evaluation to a retail version. In this case, install an additional domain controller on a server that runs a retail version, migrate any FSMO roles held, and remove Active Directory Domain Services (AD DS) from the domain controller that runs on the evaluation version. For more information, see [Upgrade Domain Controllers to Windows Server](../identity/ad-ds/deploy/upgrade-domain-controllers.md).

### Windows Server Essentials

If the server is running Windows Server Essentials, you can convert it to the full retail version by entering a retail, volume license, or OEM key in the following command at an elevated command prompt:

```cmd
slmgr.vbs /ipk <license key>
```

## Convert Windows Server Standard edition to Datacenter edition

At any time after installing Windows Server, you can convert Windows Server Standard edition to Datacenter edition. You can also run `setup.exe` from the installation media to upgrade or repair the installation, sometimes called in-place repair. If you run `setup.exe` to upgrade or repair in-place on any edition of Windows Server, the result is the same edition you started with.

You can convert the Standard edition of Windows Server to the Datacenter edition as follows:

1. Determine that Windows Server Standard is the current edition name by running the following command. The output is an abbreviated form of the edition name, for example Windows Server Standard (Desktop Experience) edition is `ServerStandard`.

   ```cmd
   DISM /online /Get-CurrentEdition
   ```

1. Verify that Windows Server Datacenter is a valid option to convert to by running the following command:

   ```cmd
   DISM /online /Get-TargetEditions
   ```

1. Enter `ServerDatacenter` and your retail product key in the following command:

   ```cmd
   DISM /online /Set-Edition:ServerDatacenter /ProductKey:<product key> /AcceptEula
   ```

## Convert between retail, volume-licensed, and OEM licenses

At any time after installing Windows Server, you can freely convert between a retail license, a volume-licensed license, or an OEM license. The edition (Standard or Datacenter) remains the same during this conversion. If you're starting with an evaluation version, [convert it to the retail version first](#convert-an-evaluation-version-to-a-retail-version) and then convert between the versions by running the following command from an elevated command prompt. Provide your volume-license, retail, or OEM product key.

```cmd
slmgr.vbs /ipk <product key>
```

## See also

For more information about upgrading Windows Server, see the following articles:

- [Overview of Windows Server upgrades](upgrade-overview.md)
- [Server Core vs Server with Desktop Experience install options](install-options-server-core-desktop-experience.md)
- [Perform an in-place upgrade of Windows Server](perform-in-place-upgrade.md)
- [In-place upgrade for VMs running Windows Server in Azure](/azure/virtual-machines/windows-in-place-upgrade)
