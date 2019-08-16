---
title: Upgrade and Conversion Options for Windows Server 2016
description: "Explains all supported upgrade paths to Windows Server 2016."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.date: 01/18/2017
ms.technology: server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 74aa1da3-7076-4a1f-ad5b-9e17bd46dba2
author: jaimeo
ms.author: jaimeo
manager: dongill
ms.localizationpriority: medium
---
# Upgrade and conversion options for Windows Server 2016

>Applies To: Windows Server 2019, Windows Server 2016

This topic includes information about upgrading to Windows Server® 2016 from a variety of previous operating systems using a variety of methods.

The process of moving to Windows Server 2016 might vary greatly depending on which operating system you are starting with and the pathway you take. We use the following terms to distinguish among different actions, any of which could be involved in a new Windows Server 2016 deployment.

- **Installation** is the basic concept of getting the new operating system on your hardware. Specifically, a **clean installation** requires deleting the previous operating system. For information about installing Windows Server 2016, see [System Requirements and Installation Information for Windows Server 2016](https://technet.microsoft.com/windows-server-docs/get-started/system-requirements--and-installation). For information about installing other versions of Windows Server, see [Windows Server Installation and Upgrade](https://technet.microsoft.com//windowsserver/dn527667).

- **Migration** means moving from your existing operating system to Windows Server 2016 by transferring to a different set of hardware or virtual machine. Migration, which might vary considerably depending on the server roles you have installed, is discussed in detail at [Windows Server Installation, Upgrade,
and Migration](https://technet.microsoft.com/windowsserver/dn458795).

- **Cluster OS Rolling Upgrade** is a new feature in Windows Server 2016 that enables an administrator to upgrade the operating system of the cluster nodes from Windows Server 2012 R2 to Windows Server 2016 without stopping the Hyper-V or the Scale-Out File Server workloads. This feature allows you to avoid downtime which could impact Service Level Agreements. This new feature is discussed in more detail at [Cluster operating system rolling upgrade](https://technet.microsoft.com/windows-server-docs/failover-clustering/cluster-operating-system-rolling-upgrade).

- **License conversion** In some operating system releases, you can convert a particular edition of the release to another edition of the same release in a single step with a simple command and the appropriate license key. We call this “license conversion.” For example, if you are running Windows Server 2016 Standard, you can convert it to Windows Server 2016 Datacenter.

- **Upgrade** means moving from your existing operating system release to a more recent release while staying on the same hardware. (This is sometimes called "in-place" upgrade.) For example, if your server is running Windows Server 2012, or Windows Server 2012 R2, you can upgrade it to Windows Server 2016. You can upgrade from an evaluation version of the operating system to a retail version, from an older retail version to a newer version, or, in some cases, from a volume-licensed edition of the operating system to an ordinary retail edition.

> [!IMPORTANT]  
> Upgrade works best in virtual machines where specific OEM hardware drivers are not needed for a successful upgrade.  

> [!IMPORTANT]  
> For releases of Windows Server 2016 prior to 14393.0.161119-1705.RS1_REFRESH, **you can only perform conversion from evaluation to retail** with Windows Server 2016 that has been installed by using the Desktop Experience option (not the Server Core option). Starting with version 14393.0.161119-1705.RS1_REFRESH and later releases, you can convert evaluation editions to retail regardless of the installation option used.

> [!IMPORTANT]  
> If your server uses NIC Teaming, disable NIC Teaming prior to upgrade, and then re-enable it after upgrade is complete. See [NIC Teaming Overview](https://technet.microsoft.com/library/hh831648(v=ws.11).aspx) for details.

## Upgrading previous retail versions of Windows Server to Windows Server 2016

The table below briefly summarizes which **already licensed** (that is, not evaluation) Windows operating systems can be upgraded to which editions of Windows Server 2016.

Note the following general guidelines for supported paths:

- Upgrades from 32-bit to 64-bit architectures are not supported. All editions of Windows Server 2016 are 64-bit only.
- Upgrades from one language to another are not supported.
- If the server is a domain controller, see [Upgrade Domain Controllers to Windows Server 2012 R2 and Windows Server 2012](https://technet.microsoft.com/library/hh994618.aspx) for important information.
- Upgrades from pre-release versions (previews) of Windows Server 2016 are not supported. Perform a clean installation to Windows Server 2016.
- Upgrades that switch from a Server Core installation to a Server with a Desktop installation (or vice versa) are not supported.
- Upgrades from a previous Windows Server installation to an evaluation copy of Windows Server are not supported. Evaluation versions should be installed as a clean installation.

If you do not see your current version in the left column, upgrading to this release of Windows Server 2016 is not supported.

If you see more than one edition in the right column, upgrading to **either** edition from the same starting version is supported.

|If you are running this edition:|You can upgrade to these editions:|  
|-------------------|----------|  
|Windows Server 2012 Standard|Windows Server 2016 Standard or Datacenter|
|Windows Server 2012 Datacenter|Windows Server 2016 Datacenter|
|Windows Server 2012 R2 Standard|Windows Server 2016 Standard or Datacenter|
|Windows Server 2012 R2 Datacenter|Windows Server 2016 Datacenter|
|Windows Server 2012 R2 Essentials|Windows Server 2016 Essentials|
|Windows Storage Server 2012 Standard|Windows Storage Server 2016 Standard|
|Windows Storage Server 2012 Workgroup|Windows Storage Server 2016 Workgroup|
|Windows Storage Server 2012 R2 Standard|Windows Storage Server 2016 Standard|
|Windows Storage Server 2012 R2 Workgroup|Windows Storage Server 2016 Workgroup|


## Per-server-role considerations for upgrading

Even in supported upgrade paths from previous retail versions to Windows Server 2016, certain server roles that are already installed might require additional preparation or actions for the role to continue functioning after the upgrade. Consult the specific TechNet Library topics for each server role you intend to upgrade for details of additional steps that might be required.

## Converting a current evaluation version to a current retail version

You can convert the evaluation version of Windows Server 2016 Standard to either Windows Server 2016 Standard (retail) or Datacenter (retail). Similarly, you can convert the evaluation version of Windows Server 2016 Datacenter to the retail version.

> [!IMPORTANT]  
> For releases of Windows Server 2016 prior to 14393.0.161119-1705.RS1_REFRESH, you can only perform this conversion from evaluation to retail with Windows Server 2016 that has been installed by using the Desktop Experience option (not the Server Core option). Starting with version 14393.0.161119-1705.RS1_REFRESH and later releases, you can convert evaluation editions to retail regardless of the installation option used.

Before you attempt to convert from evaluation to retail, verify that your server is actually running an evaluation version. To do this, do either of the following:

- From an elevated command prompt, run **slmgr.vbs /dlv**; evaluation versions will include “EVAL” in the output.

- From the Start screen, open **Control Panel**. Open **System and Security**, and then **System**. View Windows activation status in the Windows activation area of the **System** page. Click **View details** in Windows activation for more information about your Windows activation status.

If you have already activated Windows, the Desktop shows the time remaining in the evaluation period.

If the server is running a retail version instead of an evaluation version, see the “Upgrading previous retail versions of Windows Server to Windows Server 2016” section of this topic for instructions to upgrade to Windows Server 2016.

For **Windows Server 2016 Essentials**: You can convert to the full retail version by entering a retail, volume license, or OEM key in the command **slmgr.vbs**.

If the server is running an evaluation version of Windows Server 2016 Standard or Windows Server 2016 Datacenter, you can convert it to a retail version as follows:

1.	If the server is a **domain controller**, you cannot convert it to a retail version. In this case, install an additional domain controller on a server that runs a retail version and remove AD DS from the domain controller that runs on the evaluation version. For more information, see [Upgrade Domain Controllers to Windows Server 2012 R2 and Windows Server 2012](https://technet.microsoft.com/library/hh994618.aspx).
2.	Read the license terms.
3.	From an elevated command prompt, determine the current edition name with the command **DISM /online /Get-CurrentEdition**. Make note of the edition ID, an abbreviated form of the edition name. Then run **DISM /online /Set-Edition:\<edition ID\> /ProductKey:XXXXX-XXXXX-XXXXX-XXXXX-XXXXX /AcceptEula**, providing the edition ID and a retail product key. The server will restart twice.

For the evaluation version of Windows Server 2016 Standard, you can also convert to the retail version of Windows Server 2016 Datacenter in one step using this same command and the appropriate product key.

> [!TIP] 
> For more information about Dism.exe, see [DISM Command-line options](https://go.microsoft.com/fwlink/?LinkId=192466).

## Converting a current retail edition to a different current retail edition

At any time after installing Windows Server 2016, you can run Setup to repair the installation (sometimes called “repair in place”) or, in certain cases, to convert to a different edition.
You can run Setup to perform a “repair in place” on any edition of Windows Server 2016; the result will be the same edition you started with.

For Windows Server 2016 Standard, you can convert the system to Windows Server 2016 Datacenter as follows: From an elevated command prompt, determine the current edition name with the command **DISM /online /Get-CurrentEdition**. For Windows Server 2016 Standard this will be `ServerStandard`. Run the command **DISM /online /Get-TargetEditions** to get the ID of the edition you can upgrade to. Make note of this edition ID, an abbreviated form of the edition name. Then run **DISM /online /Set-Edition:\<edition ID\> /ProductKey:XXXXX-XXXXX-XXXXX-XXXXX-XXXXX /AcceptEula**, providing the edition ID of your target and its retail product key. The server will restart twice.

## Converting a current retail version to a current volume-licensed version

At any time after installing Windows Server 2016, you can freely convert it between a retail version, a volume-licensed version, or an OEM version. The edition remains the same during this conversion. If you are starting with an evaluation version, convert it to the retail version first, and then you can inter-convert as described here.

To do this, from an elevated command prompt, run:
**slmgr /ipk \<key\>**

Where \<key\> is the appropriate volume-license, retail, or OEM product key.
