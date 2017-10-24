--- 
title: Windows Server Installation and Upgrade
description: 
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.date: 04/03/2017
ms.technology: server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 98f876bd-63ff-4c3a-95d4-a8dd8d0d119c
author: jaimeo
ms.author: jaimeo
manager: elizapo
---
# Windows Server Installation and Upgrade

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Is it time to move to a newer version of Windows Server? Depending on what you are running now, you have lots of options to get there.

## Installation
If you want to move to a newer version of Windows Server on the same hardware, one way that always works is a **clean installation**, where you just install the newer operating system directly over the old one on the same hardware, thus deleting the previous operating system. That is the simplest way, but you will need to back up your data first and plan to reinstall your applications. There are a few things to be aware of, such as system requirements, so be sure to check the details for [Windows Server 2016](https://go.microsoft.com/fwlink/?LinkID=825558), [Windows Server 2012 R2](https://technet.microsoft.com/en-us/library/dn303418), and [Windows Server 2012](https://technet.microsoft.com/en-us/library/jj134246.aspx).

Moving from any pre-release version (such as Windows Server 2016 Technical Preview) to the released version (Windows Server 2016) always requires a clean installation.

## Migration (recommended for Windows Server 2016)

Windows Server [migration] documentation helps you migrate one role or feature at a time from a source computer that is running Windows Server to another destination computer that is running Windows Server, either the same or a newer version. For these purposes, migration is defined as moving one role or feature and its data to a different computer, not upgrading the feature on the same computer. This is the recommended manner in which to move your existing workload and data to a more recent version of Windows Server. To get started, check the [server role upgrade and migration matrix](https://go.microsoft.com/fwlink/?LinkId=828595) for Windows Server 2016.

## Cluster OS Rolling Upgrade
Cluster OS Rolling Upgrade is a new feature in Windows Server 2016 that enables an administrator to upgrade the operating system of the cluster nodes from Windows Server 2012 R2 to Windows Server 2016 without stopping the Hyper-V or the Scale-Out File Server workloads. This feature allows you to avoid downtime which could impact Service Level Agreements. This new feature is discussed in more detail at [Cluster operating system rolling upgrade](https://technet.microsoft.com/en-us/windows-server-docs/failover-clustering/cluster-operating-system-rolling-upgrade).

## License Conversion
In some operating system releases, you can convert a particular edition of the release to another edition of the same release in a single step with a simple command and the appropriate license key. This is called **license conversion**. For example, if your server is running Windows Server 2016 Standard, you can convert it to Windows Server 2016 Datacenter. In some releases of Windows Server, you can also freely convert among OEM, volume-licensed, and retail versions with the same command and the appropriate key.

## Upgrade
If you want to keep the same hardware and all the server roles you have set up without flattening the server, **upgrading** is an option—and there are lots of ways to do it. In the classic upgrade, you go from an older operating system to a newer one, keeping your settings, server roles, and data intact. For example, if your server is running Windows Server 2012 R2, you can upgrade it to Windows Server 2016. However, not every older operating system has a pathway to every newer one.
 
>[!NOTE]
>Upgrade works best in virtual machines where specific OEM hardware drivers are not needed for a successful upgrade.
 
You can upgrade from an evaluation version of the operating system to a retail version, from an older retail version to a newer version, or, in some cases, from a volume-licensed edition of the operating system to an ordinary retail edition.

Before you get started with an upgrade, have a look at the tables on this page to see how to get from where you are to where you want to be.

For information about the differences between the installation options available for Windows Server 2016 Technical Preview, including the features that are installed with each option and the management options available after installation, see [Windows Server 2016](https://go.microsoft.com/fwlink/?LinkId=828598).

>[!NOTE]
>Whenever you migrate or upgrade to any version of Windows Server, you should review and understand the [support lifecycle policy](https://support.microsoft.com/lifecycle) and timeframe for that version and plan accordingly. You can [search for the lifecycle information](https://support.microsoft.com/lifecycle) for the particular Windows Server release that you are interested in.
 
 
## Upgrading to Windows Server 2016
For details, including important caveats and limitations on upgrade, license conversion between editions of Windows Server 2016, and conversion of evaluation editions to retail, see [Supported Upgrade Paths for Windows Server 2016](https://go.microsoft.com/fwlink/?LinkId=828602).
 
>[!NOTE]
>Note: Upgrades that switch from a Server Core installation to a Server with a Desktop installation (or vice versa) are not supported. If the older operating system you are upgrading or converting is a Server Core installation, the result will still be a Server Core installation of the newer operating system.
 
Quick reference table of supported upgrade paths from older Windows Server retail editions to Windows Server 2016 retail editions:


|If you are running these versions and editions:|You can upgrade to these versions and editions:|
|--------------------------------|---------------------------------------|
|Windows Server 2012 Standard|Windows Server 2016 Standard or Datacenter|
|Windows Server 2012 Datacenter|Windows Server 2016 Datacenter|
|Windows Server 2012 R2 Standard|Windows Server 2016 Standard or Datacenter|
|Windows Server 2012 R2 Datacenter|Windows Server 2016 Datacenter|
|Hyper-V Server 2012 R2|Hyper-V Server 2016 (using Cluster OS Rolling Upgrade feature)|
|Windows Server 2012 R2 Essentials|Windows Server 2016 Essentials|
|Windows Storage Server 2012 Standard|Windows Storage Server 2016 Standard|
|Windows Storage Server 2012 Workgroup|Windows Storage Server 2016 Workgroup|
|Windows Storage Server 2012 R2 Standard|Windows Storage Server 2016 Standard|
|Windows Storage Server 2012 R2 Workgroup|Windows Storage Server 2016 Workgroup|
 
### License conversion
You can convert Windows Server 2016 Standard (retail) to Windows Server 2016 Datacenter (retail).

You can convert Windows Server 2016 Essentials (retail) to Windows Server 2016 Standard (retail).

You can convert the evaluation version of Windows Server 2016 Standard to either Windows Server 2016 Standard (retail) or Datacenter (retail).

You can convert the evaluation version of Windows Server 2016 Datacenter to Windows Server 2016 Datacenter (retail).
 
## Upgrading to Windows Server 2012 R2
For details, including important caveats and limitations on upgrade, license conversion between editions of Windows Server 2012 R2, and conversion of evaluation editions to retail, see [Upgrade Options for Windows Server 2012 R2](https://technet.microsoft.com/library/dn303416.aspx).

Quick reference table of supported upgrade paths from older Windows Server retail editions to Windows Server 2012 R2 retail editions:

|If you are running:|You can upgrade to these editions:|
|-------------------------|---------------------------|
|Windows Server 2008 R2 Datacenter with SP1|Windows Server 2012 R2 Datacenter|
|Windows Server 2008 R2 Enterprise with SP1|Windows Server 2012 R2 Standard or Windows Server 2012 R2 Datacenter|
|Windows Server 2008 R2 Standard with SP1|Windows Server 2012 R2 Standard or Windows Server 2012 R2 Datacenter|
|Windows Web Server 2008 R2 with SP1|Windows Server 2012 R2 Standard|
|Windows Server 2012 Datacenter|Windows Server 2012 R2 Datacenter|
|Windows Server 2012 Standard|Windows Server 2012 R2 Standard or Windows Server 2012 R2 Datacenter|
|Hyper-V Server 2012|Hyper-V Server 2012 R2|

### License conversion
You can convert Windows Server 2012 Standard (retail) to Windows Server 2012 Datacenter (retail).

You can convert Windows Server 2012 Essentials (retail) to Windows Server 2012 Standard (retail).

You can convert the evaluation version of Windows Server 2012 Standard to either Windows Server 2012 Standard (retail) or Datacenter (retail).

## Upgrading to Windows Server 2012
For details, including important caveats and limitations on upgrade, and conversion of evaluation editions to retail, see [Evaluation Versions and Upgrade Options for Windows Server 2012](https://technet.microsoft.com/en-us/library/jj574204.aspx).
 
Quick reference table of supported upgrade paths from older Windows Server retail editions to Windows Server 2012 retail editions:

|If you are running:|You can upgrade to these editions:|
|--------------------------|--------------------------|
|Windows Server 2008 Standard with SP2 or Windows Server 2008 Enterprise with SP2|Windows Server 2012 Standard, Windows Server 2012 Datacenter|
|Windows Server 2008 Datacenter with SP2||Windows Server 2012 Datacenter|
|Windows Web Server 2008|Windows Server 2012 Standard|
|Windows Server 2008 R2 Standard with SP1 or Windows Server 2008 R2 Enterprise with SP1|Windows Server 2012 Standard, Windows Server 2012 Datacenter|
|Windows Server 2008 R2 Datacenter with SP1|Windows Server 2012 Datacenter|
|Windows Web Server 2008 R2|Windows Server 2012 Standard|

### License conversion
You can convert Windows Server 2012 Standard (retail) to Windows Server 2012 Datacenter (retail).

You can convert Windows Server 2012 Essentials (retail) to Windows Server 2012 Standard (retail).

You can convert the evaluation version of Windows Server 2012 Standard to either Windows Server 2012 Standard (retail) or Datacenter (retail).

## Upgrading to Windows Server 2008 R2
For details, including important caveats and limitations, see [Windows Server 2008 R2 Upgrade Paths](https://technet.microsoft.com/en-us/library/dd979563(v=ws.10).aspx).

Quick reference table of supported upgrade paths from older Windows Server retail editions to Windows Server 2008 R2 retail editions:


|From Windows Server 2003 (SP2, R2)|Upgrade to Windows Server 2008 R2|
|----------------------------------|---------------------------------|
|Datacenter|Datacenter|
|Enterprise|Enterprise, Datacenter|
|Standard|Standard, Enterprise|
 


|From Windows Server 2008 (RTM-SP1, SP2)|Upgrade to Windows Server 2008 R2|
|--------------------------------------|--------------------------------|
|Datacenter|Datacenter|
|Enterprise|Enterprise, Datacenter|
|Foundation (SP2 only)|Standard|
|Standard|Standard, Enterprise|
|Web|Standard, Web|

 


|From Windows Server 2008 (RC, IDS, RTM)|Upgrade to Windows Server 2008 R2|
|------------------------------------|------------------------------------|
|Datacenter|Datacenter|
|Enterprise|Enterprise or Datacenter|
|Foundation|Standard or Foundation|
|Standard|Standard or Enterprise|
|Web|Standard or Web|
