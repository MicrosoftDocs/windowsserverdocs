---
title: Upgrade and Conversion Options for Windows Server
description: Explains how to upgrade or convert Windows Server to newer versions, different editions, or switch between licensing options, such as evaluation, retail, and volume licensed.
ms.date: 11/25/2021
ms.topic: conceptual
ms.assetid: 74aa1da3-7076-4a1f-ad5b-9e17bd46dba2
author: dknappettmsft
ms.author: daknappe
manager: femila
ms.localizationpriority: medium
---
# Upgrade and conversion options for Windows Server

You can upgrade or convert installations of Windows Server to newer versions, different editions, or switch between licensing options, such as evaluation, retail, and volume licensed. This article helps explain what the options are to help with your planning.

The process of upgrading or converting installations of Windows Server might vary greatly depending on which version and edition you have installed, how it is licensed, and the pathway you take. We use the following terms to distinguish between different actions, any of which could be involved in a new deployment of Windows Server.

- **Clean install** is simplest way to install Windows Server, where you install on a blank server or overwrite an existing operating system, but you will need to back up your data first and plan to reinstall your applications. There are a few things to be aware of, such as [hardware requirements](hardware-requirements.md), so be sure to check the details for Windows Server.

- **In-place upgrade** enables you to keep the same hardware and all the server roles you have set up without wiping and reinstalling the operating system, by which you go from an older operating system to a newer one, keeping your settings, server roles and features, and data intact. For example, if your server is running Windows Server 2019, you can upgrade it to Windows Server 2022. However, not every older operating system has a pathway to every newer one and some roles or features don't support this or need you to take extra steps.  In-place upgrade works best in virtual machines where specific OEM hardware drivers are not needed for a successful upgrade.

  For step-by-step guidance and more information on upgrading, review the [Windows Server upgrade content](../upgrade/upgrade-overview.md) and [Upgrade and migrate roles and features in Windows Server](upgrade-migrate-roles-features.md).

- **Cluster Operating System (OS) rolling upgrade** gives an administrator the ability to upgrade the operating system of the cluster nodes without stopping the Hyper-V or the Scale-Out File Server workloads. For example, if nodes in your cluster are running Windows Server 2019 you can install Windows Server 2022 on them avoiding downtime to the cluster, which would otherwise impact Service Level Agreements. This feature is discussed in more detail at [Cluster OS rolling upgrade](../failover-clustering/cluster-operating-system-rolling-upgrade.md).

- **Migration** of Windows Server is when you move one role or feature at a time from a source computer that is running Windows Server to another destination computer that is running Windows Server, either the same or a newer version. For these purposes, migration is defined as moving one role or feature and its data to a different computer, not upgrading the feature on the same computer.

- **License conversion** enables you to convert a particular edition of the release to another edition of the same release in a single step with a simple command and the appropriate license key for some Windows Server releases. For example, if your server is running Windows Server 2022 Standard, you can convert it to Windows Server 2022 Datacenter. Keep in mind that while you can move up from Windows Server 2022 Standard to Windows Server 2022 Datacenter, you are unable to reverse the process and go from Datacenter edition to Standard edition. In some releases of Windows Server, you can also freely convert between OEM, volume-licensed, and retail versions with the same command and the appropriate key.

## Upgrading licensed versions of Windows Server

Below are general guidelines for in-place upgrade paths where Windows Server is **already licensed** (that is, not evaluation):

- Upgrades from 32-bit to 64-bit architectures are not supported. All releases of Windows Server since Windows Server 2016 are 64-bit only.
- Upgrades from one language to another are not supported.
- If the server is an Active Directory domain controller, you cannot convert it to a retail version. See [Upgrade Domain Controllers to Windows Server 2012 R2 and Windows Server 2012](../identity/ad-ds/deploy/upgrade-domain-controllers-to-windows-server-2012-r2-and-windows-server-2012.md) for important information.
- Upgrades from pre-release versions (previews) of Windows Server are not supported. Perform a clean installation of Windows Server.
- Upgrades that switch from a Server Core installation to a Server with Desktop Experience installation (or vice versa) are not supported.
- Upgrades from a previous Windows Server installation to an evaluation copy of Windows Server are not supported. Evaluation versions should be installed as a clean installation.
- You can only change from Standard edition to Datacenter edition when upgrading. Changing from Datacenter edition to Standard edition is not supported.

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
   > You can convert from the evaluation version of Windows Server Standard to the retail version of Windows Server Datacenter in one step by using the appropriate product key

   ```
   DISM /online /Set-Edition:\<edition ID\> /ProductKey:XXXXX-XXXXX-XXXXX-XXXXX-XXXXX /AcceptEula
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
   slmgr.vbs /ipk \<XXXXX-XXXXX-XXXXX-XXXXX-XXXXX\>
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
slmgr.vbs /ipk \<XXXXX-XXXXX-XXXXX-XXXXX-XXXXX\>
```
