---
title: Convert Windows Server editions and license types
description: Learn how to convert Windows Server evaluation versions to retail, upgrade Standard to Datacenter edition, and switch between retail, volume-licensed, and OEM licenses using DISM and slmgr commands.
ms.author: roharwoo
author: robinharwood
ms.date: 03/23/2026
ms.topic: how-to
# customer intent: As a Windows Server administrator, I want to convert my Windows Server edition or license type so I can switch to the right edition or licensing model for my environment.
---

# Convert Windows Server editions and license types

After installing Windows Server, you can convert between editions (for example, evaluation to retail, or Standard to Datacenter) and switch between licensing types (retail, volume-licensed, and OEM). This article provides the step-by-step procedures for each conversion scenario.

For information about supported in-place upgrade paths and restrictions, see [Plan your Windows Server upgrade](install-upgrade-migrate.md).

## Prerequisites

Before you convert your Windows Server edition or license type, make sure you have:

- The product key for the target edition or license type.
- An elevated command prompt or PowerShell session on the server you want to convert.
- Administrative access to the server.

## Convert an evaluation version to a retail version

You can convert evaluation versions and editions of Windows Server to retail versions and editions. For example, if you install the evaluation version of Standard (Desktop Experience) edition, you can convert it to the retail version of either the Standard (Desktop Experience) edition or the Datacenter (Desktop Experience) edition.

However, you can't convert all Windows Server evaluation versions and editions to all retail versions or editions. For example, if you install the evaluation Datacenter edition, you can only convert it to the retail Datacenter edition, not to the retail Standard edition.

Since Windows Server 2016, you can't convert Desktop Experience evaluation versions to Core retail versions. If you install the Standard Core evaluation version, you can convert it only to retail Datacenter Core, not to retail Standard Core.

It's important to run the `DISM /online /Get-TargetEditions` command as instructed in the following procedure to determine which retail versions you can convert to. If the retail version you want isn't listed as a target version, you need to do a fresh install of the retail version you want.

> [!NOTE]
> To verify that your server is running an evaluation version, you can run either of the following commands at an elevated command prompt:
>
> - Run `DISM /online /Get-CurrentEdition` and make sure the current edition name includes `Eval`.
> - Run `slmgr.vbs /dlv` and make sure the output includes `EVAL`.

If Windows isn't activated, the bottom right-hand corner of the desktop shows the time remaining in the evaluation period.

### Windows Server Standard or Datacenter

If your server is running an evaluation version of Windows Server Standard or Datacenter edition, you can convert it to an available retail version. Run the following commands in an elevated command prompt or PowerShell session.

1. Determine the current edition name by running the following command. The output is an abbreviated form of the edition name. For example, Windows Server Datacenter (Desktop Experience) Evaluation edition is `ServerDatacenterEval`.

   ```cmd
   DISM /online /Get-CurrentEdition
   ```

1. Verify which editions the current installation can be converted to by running the following command. From the output, make a note of the edition name you want to convert to.

   ```cmd
   DISM /online /Get-TargetEditions
   ```

1. Run the following command to save the Microsoft Software License Terms for Windows Server, which you can then review. Replace the `<target edition>` placeholder with the edition name you noted from the previous step.

   ```cmd
   DISM /online /Set-Edition:<target edition> /GetEula:C:\license.rtf
   ```

1. Enter the new edition name and corresponding retail product key in the following command. The set edition process requires you to accept the Microsoft Software License Terms for Windows Server that you saved previously.

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
> You can't convert an Active Directory domain controller from an evaluation to a retail version. In this case, install another domain controller on a server that runs a retail version. Then migrate any FSMO roles that are held by the evaluation domain controller. Finally, remove Active Directory Domain Services (AD DS) from the domain controller that runs on the evaluation version. For more information, see [Upgrade Domain Controllers to Windows Server](../identity/ad-ds/deploy/upgrade-domain-controllers.md).

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

## Related content

- [Plan your Windows Server upgrade](install-upgrade-migrate.md)
- [Perform an in-place upgrade of Windows Server](perform-in-place-upgrade.md)
- [Server Core vs Server with Desktop Experience install options](install-options-server-core-desktop-experience.md)
- [In-place upgrade for VMs running Windows Server in Azure](/azure/virtual-machines/windows-in-place-upgrade)
