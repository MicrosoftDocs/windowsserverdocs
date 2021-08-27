---
title: Windows Server servicing channels
description: Explanation of Windows Server Long-Term Servicing Channel (LTSC) and Semi-Annual Channel (SAC)
ms.topic: article
author: jasongerend
ms.author: jgerend
manager: femila
ms.date: 8/16/2021
ms.prod: windows-server
ms.localizationpriority: high
---

# Windows Server servicing channels

Previously with Windows Server 2016 and Windows Server 2019 there have been two primary release channels available, the Long-Term Servicing Channel and the Semi-Annual Channel. The Long-Term Servicing Channel (LTSC) provides a longer term option focusing on stability, whereas the Semi-Annual Channel (SAC) provided more frequent releases enabling customers to take advantage of innovation more quickly.

Starting with Windows Server 2022, there is one primary release channel available, the Long-Term Servicing Channel. The Semi-Annual Channel in previous versions of Windows Server focused on containers and microservices, and that innovation will continue with [Azure Stack HCI](/azure-stack/hci/).

## Long-Term Servicing Channel (LTSC)

With the Long-Term Servicing Channel, a new major version of Windows Server is released every 2-3 years. Users are entitled to 5 years of mainstream support and 5 years of extended support. This channel provides systems with a long servicing option and functional stability, and can be installed with Server Core or Server with Desktop Experience installation options. Deployments of the LTSC of Windows Server are not affected by Semi-Annual Channel releases. The Long-Term Servicing Channel will continue to receive security and non-security updates, but it will not receive the new features and functionality.

## Semi-Annual Channel

The Semi-Annual Channel enabled customers who are innovating quickly to take advantage of new operating system capabilities at a faster pace, focused in on containers and microservices. Each release in this channel is supported for 18 months from the initial release.

> [!NOTE]
> There will be no future Semi-Annual Channel releases of Windows Server. Customers using the SAC should move to [Azure Stack HCI](/azure-stack/hci/) where the same release cadence and rapid innovation continues with features such as [Azure Kubernetes Service on Azure Stack HCI](/azure-stack/aks-hci/). Alternatively, use the Long-Term Servicing Channel of Windows Server.

Most of the features introduced in the Semi-Annual Channel have been rolled up into the next Long-Term Servicing Channel release of Windows Server. The Semi-Annual Channel is available to volume-licensed customers with [Software Assurance](https://www.microsoft.com/licensing/licensing-programs/software-assurance-default.aspx), as well as via the Azure Marketplace or other cloud/hosting service providers and loyalty programs such as Visual Studio Subscriptions.

> [!NOTE]
> **The current Semi-Annual Channel release is Windows Server, version 20H2**. If you want to put servers in this channel, you should install Windows Server, version 20H2, which can be installed in Server Core mode or as Nano Server run in a container. In-place upgrades from a Long-Term Servicing Channel release aren't supported because they are in **different release channels**. This applies vice versa. You cannot upgrade or change from Semi-Annual Channel to Long-Term Servicing Channel without a clean installation.
>
> A Semi-Annual Channel release isn't an update – it's the next Windows Server release in the Semi-Annual Channel.
> In-place upgrades from one Semi-Annual Channel release to a later Semi-Annual Channel release are possible. This makes it easier to keep up with the relatively short release cadence.

In this model, Windows Server releases were identified by the year and month of release: for example, in 2017, a release in the 9th month (September) would be identified as **version 1709**. Fresh releases of Windows Server in the Semi-Annual Channel occurred twice each year. The support lifecycle for each release is 18 months. Starting with fall 2020 (20H2) releases, we changed the identification. Instead of a month, the release is named based on the release cycle. For example: **version 20H2**, for a release in the second half of the year 2020.

## Key differences

The following table summarizes the key differences between the channels:

| Description | Long-Term Servicing Channel (Windows Server 2019) | Semi-Annual Channel (Windows Server) |
| -----------------------|--|--|
| Recommended scenarios | General purpose file servers, Microsoft and non-Microsoft workloads, traditional apps, infrastructure roles, software-defined Datacenter, and hyper-converged infrastructure | Containerized applications, container hosts, and application scenarios benefiting from faster innovation |
| New releases | Every 2–3 years | Every 6 months |
| Support | 5 years of mainstream support, plus 5 years of extended support | 18 months |
| Editions | All available Windows Server editions | Standard and Datacenter editions |
| Who can use it? | All customers through all channels | Software Assurance and cloud customers only |
| Installation options | Server Core and Server with Desktop Experience | Server Core for container host and image and Nano Server container image |

> [!IMPORTANT]
> Please understand that the set of roles and features in Windows Server SAC, only available as Server Core installation option, differs from Windows Server LTSC installed with the Server Core installation option.
> For example, you cannot use Windows Server SAC as a foundation for services like Storage Spaces Direct.

## Device compatibility

Unless otherwise communicated, the minimum hardware requirements to run the Semi-Annual Channel releases are the same as the most recent Long-Term Servicing Channel release of Windows Server. Most hardware drivers will continue to function in these releases.

## Servicing

Both the Long-Term Servicing Channel and the Semi-Annual Channel releases will be supported with security updates and non-security updates up to the dates listed in the [Microsoft Lifecycle](/lifecycle/products/) pages. The difference is the length of time that the release is supported, as described above.

### Servicing tools

There are many tools with which IT pros can service Windows Server. Each option has its pros and cons, ranging from capabilities and control to simplicity and low administrative requirements. The following are examples of the servicing tools available to manage servicing updates:

- **Windows Update (stand-alone)**: This option is only available for servers that are connected to the Internet and have Windows Update enabled.
- **Windows Server Update Services (WSUS)** provides extensive control over Windows Server and Windows client updates and is natively available in the Windows Server operating system. In addition to the ability to defer updates, organizations can add an approval layer for updates and choose to deploy them to specific computers or groups of computers whenever ready.
- **Microsoft Endpoint Configuration Manager** provides the greatest control over servicing. IT pros can defer updates, approve them, and have multiple options for targeting deployments and managing bandwidth usage and deployment times.

You've likely already chosen to use at least one of these options based on your resources, staff, and expertise. You can continue using the same process for Semi-Annual Channel Releases: for example, if you already use Configuration Manager to manage updates, you can continue to use it. Similarly, if you are using WSUS, you can continue to use that.

## Where to obtain Semi-Annual Channel releases

Semi-Annual Channel releases should be installed as a clean installation. It is possible to use in-place upgrade via ISO from one SAC to a later version.

- Volume Licensing Service Center (VLSC): Volume-licensed customers with [Software Assurance](https://www.microsoft.com/licensing/licensing-programs/software-assurance-default.aspx) can obtain this release by going to the [Volume Licensing Service Center](https://www.microsoft.com/Licensing/servicecenter/default.aspx) and clicking **Sign In**. Then click **Downloads and Keys** and search for this release.

- Semi-Annual Channel releases are also available in [Microsoft Azure](https://azuremarketplace.microsoft.com/marketplace/apps/microsoftwindowsserver.windowsserver?tab=Overview).

- Visual Studio Subscriptions: Visual Studio Subscribers can obtain Semi-Annual Channel releases by downloading them from the [Visual Studio Subscriber download page](https://my.visualstudio.com/Downloads?q=Windows%20Server,%20version). If you are not already a subscriber, go to [Visual Studio Subscriptions](https://www.visualstudio.com/subscriptions/) to sign up, and then visit the [Visual Studio Subscriber download page](https://my.visualstudio.com/Downloads?q=Windows%20Server,%20version) as above. Releases obtained through Visual Studio Subscriptions are for development and testing only.

## Activating Semi-Annual Channel releases

- If you're using Microsoft Azure, Semi-Annual Channel releases should be activated automatically.
- If you've obtained this release from the Volume Licensing Service Center or Visual Studio Subscriptions, you can activate it by using your Windows Server Customer Specific Volume License Key (CSVLK, also known as the KMS host key) with your Key Management System (KMS) environment. For more information, see [KMS client setup keys](../get-started/kmsclientkeys.md).

> [!Note]
> For easier maintenance and management of activation, you can use ADBA (Active Directory-based activation) for Windows Server 2012 or later, including Windows Server SAC.
> In addition, you can manage your licenses using VAMT 3.x (Volume Activation Management Tool), which is part of the latest ADK.

Semi-Annual Channel releases that were released with or after Windows Server 2019 use the Windows Server 2019 CSVLK. Semi-Annual Channel releases that were released before Windows Server 2019 use the Windows Server 2016 CSVLK.

## Why do Semi-Annual Channel releases offer only the Server Core installation option?

One of the most important steps we take in planning each release of Windows Server is listening to customer feedback – how are you using Windows Server? What new features will have the greatest impact on your Windows Server deployments, and by extension, your day-to-day business? Your feedback tells us that delivering new innovation as quickly and efficiently as possible is a key priority. At the same time, for those customers innovating most quickly, you've told us that you're primarily using command line scripting with PowerShell to manage your data centers, and as such don't have a strong need for the desktop GUI available in the installation of Windows Server with Desktop Experience, especially now that [Windows Admin Center](../manage/windows-admin-center/overview.md) is available to remotely manage your servers.

By focusing on the Server Core installation option, we're able to dedicate more resources toward those new innovations, while also maintaining traditional Windows Server platform functionality and application compatibility.

Starting with Windows Server, version 1809 and Windows Server 2019, [Server Core App Compatibility FOD](../get-started-19/install-fod-19.md) is an optional feature package that significantly improves the app compatibility of the Windows Server Core installation option by including a subset of binaries and packages from Windows Server with Desktop Experience, without adding the Windows Server Desktop Experience graphical environment.

## What about Nano Server?

Nano Server is available as a container operating system in the Semi-Annual Channel. See [Changes to Nano Server in Windows Server Semi-Annual Channel](../get-started/nano-in-semi-annual-channel.md) for details.

## How to tell whether a server is running an LTSC or SAC release

Previously, Long-Term Servicing Channel releases such as Windows Server 2019 were released at the same time as a new version of the Semi-Annual Channel, for example, Windows Server, version 1809 was released at the same time as Windows Server 2019. This can make it a little tricky to determine whether a server is running Semi-Annual Channel release. Instead of looking at the build number, you must look at the product name: Semi-Annual Channel releases use the Windows Server Standard or Windows Server Datacenter product name, without a version number, while Long-Term Servicing Channel releases include the version number, for example, Windows Server 2019 Datacenter.

> [!Note]
> The below guidance is intended to help identify and differentiate between LTSC and SAC for lifecycle and general inventory purposes only. It is not intended for application compatibility or to represent a specific API surface. App developers should use guidance elsewhere to properly ensure compatibility as components, APIs, and functionality can be added over the life of a system, or not yet be added. [Operating System Version](/windows/win32/sysinfo/operating-system-version) is a better starting point for App Developers.

Open PowerShell and use the `Get-ItemProperty` cmdlet, or the `Get-ComputerInfo` cmdlet, to check these properties in the registry. Along with build number, this will indicate LTSC or SAC by the presence, or lack thereof, of the branded year, i.e. 2019 - LTSC has this, SAC does not. This will also return the timing of the release with ReleaseId or WindowsVersion, i.e. 1809, as well as whether the installation is Server Core or Server with Desktop Experience.

**Windows Server 2019 Datacenter Edition (LTSC) with Desktop Experience example:**

```PowerShell
Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion" | Select ProductName, ReleaseId, InstallationType, CurrentMajorVersionNumber,CurrentMinorVersionNumber,CurrentBuild
```

```
ProductName               : Windows Server 2019 Datacenter
ReleaseId                 : 1809
InstallationType          : Server
CurrentMajorVersionNumber : 10
CurrentMinorVersionNumber : 0
CurrentBuild              : 17763
```

**Windows Server, version 1809 (SAC) Standard Edition Server Core example:**

```PowerShell
Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion" | Select ProductName, ReleaseId, InstallationType, CurrentMajorVersionNumber,CurrentMinorVersionNumber,CurrentBuild
```

```
ProductName               : Windows Server Standard
ReleaseId                 : 1809
InstallationType          : Server Core
CurrentMajorVersionNumber : 10
CurrentMinorVersionNumber : 0
CurrentBuild              : 17763
````

**Windows Server 2019 Standard Edition (LTSC) Server Core example:**

```PowerShell
Get-ComputerInfo | Select WindowsProductName, WindowsVersion, WindowsInstallationType, OsServerLevel, OsVersion, OsHardwareAbstractionLayer
```

```
WindowsProductName            : Windows Server 2019 Standard
WindowsVersion                : 1809
WindowsInstallationType       : Server Core
OsServerLevel                 : ServerCore
OsVersion                     : 10.0.17763
OsHardwareAbstractionLayer    : 10.0.17763.107
```

To query if the new [Server Core App Compatibility FOD](../get-started-19/install-fod-19.md) is present on a server, use the [Get-WindowsCapability](/powershell/module/dism/get-windowscapability) cmdlet and look for:

```
Name    :     ServerCore.AppCompatibility~~~~0.0.1.0
State   :     Installed
```
