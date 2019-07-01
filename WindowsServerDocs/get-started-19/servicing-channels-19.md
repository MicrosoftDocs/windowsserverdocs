---
title: Servicing Channels
description: "Explanation of Windows Server service channels: LTSC and SAC"
ms.prod: windows-server-threshold
ms.technology: server-general
ms.topic: article
author: jasongerend
ms.author: jgerend
ms.localizationpriority: high
ms.date: 05/21/2019
---
# Windows Server servicing channels: LTSC and SAC

>Applies to: Windows Server 2019, Windows Server 2016, Windows Server (Semi-Annual Channel)

There are two primary release channels available to Windows Server customers, the Long-Term Servicing Channel and the Semi-Annual Channel.

You can keep servers on the Long-Term Servicing Channel (LTSC), move them to the Semi-Annual Channel, or have some servers on either track, depending on what works best for your needs.

## Long-Term Servicing Channel (LTSC)

This is the release model you’re already familiar with (formerly called the “Long-Term Servicing *Branch*”) where a new major version of Windows Server is released every 2-3 years. Users are entitled to 5 years of mainstream support and 5 years of extended support. This channel is appropriate for systems that require a longer servicing option and functional stability. Deployments of Windows Server 2016 and earlier versions of Windows Server will not be affected by the new Semi-Annual Channel releases. The Long-Term Servicing Channel will continue to receive security and non-security updates, but it will not receive the new features and functionality.

> [!Note]  
> **The current LTSC product is Windows Server 2019**. If you want to stay in this channel, you should install (or continue using) Windows Server 2019, which can be installed in Server Core installation option or Server with Desktop Experience installation option.

## Semi-Annual Channel

The Semi-Annual Channel is perfect for customers who are innovating quickly to take advantage of new operating system capabilities at a faster pace, both in applications – particularly those built on containers and microservices, as well as in the software-defined hybrid datacenter. Windows Server products in the Semi-Annual Channel will have new releases available twice a year, in spring and fall. Each release in this channel will be supported for 18 months from the initial release.

Most of the features introduced in the Semi-Annual Channel will be rolled up into the next Long-Term Servicing Channel release of Windows Server. The editions, functionality, and supporting content might vary from release to release depending on customer feedback.

The Semi-Annual Channel is available to volume-licensed customers with [Software Assurance](https://www.microsoft.com/en-us/licensing/licensing-programs/software-assurance-default.aspx), as well as via the Azure Marketplace or other cloud/hosting service providers and loyalty programs such as Visual Studio Subscriptions.

> [!Note]  
> **The current Semi-Annual Channel release is Windows Server, version 1903**. If you want to put servers in this channel, you should install Windows Server, version 1903, which can be installed in Server Core mode or as Nano Server run in a container. In-place upgrades from a long-term servicing channel release aren't supported because they are in **different release channels**. Semi-Annual Channel releases aren't updates – it's the next Windows Server release in the Semi-Annual Channel.

In this model, Windows Server releases are identified by the year and month of release: for example, in 2017, a release in the 9th month (September) would be identified as **version 1709**. Fresh releases of Windows Server in the Semi-Annual Channel will occur twice each year. The support lifecycle for each release is 18 months.

## Should you keep servers on the LTSC or move them to the Semi-Annual Channel?

These are the key differences to take into account:

- Do you need to innovate rapidly? Do you need early access to the newest Windows Server features? Do you need to support fast-cadence hybrid applications, dev-ops, and Hyper-V fabrics? If so, you should consider **joining the Semi-Annual Channel** by installing **Windows Server, version 1903**. As described in this topic, you will receive new versions twice a year, with 18 months of mainstream production support per release. You get it through volume licensing, Azure, or Visual Studio Subscription Services. Currently, releases in the Semi-Annual Channel require volume licensing and Software Assurance if you intend to run the product in production.
- Do you need stability and predictability? Do you need to run virtual machines and traditional workloads on physical servers? If so, you should consider **keeping those servers on the Long-Term Servicing Channel**. The current LTSC release is **Windows Server 2019**. As described in this topic, you'll have access to new versions every 2-3 years, with 5 years of mainstream support followed by 5 years of extended support per release. LTSC releases are available through all release mechanisms. Releases in the LTSC are available to anyone regardless of the licensing model they are using. 

The following table summarizes the key differences between the channels:


|                       |                                                              Long-Term Servicing Channel (Windows Server 2019)                                                               |                                   Semi-Annual Channel (Windows Server)                                   |
|-----------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------|
| Recommended scenarios | General purpose file servers, Microsoft and non-Microsoft workloads, traditional apps, infrastructure roles, software-defined Datacenter, and hyper-converged infrastructure | Containerized applications, container hosts, and application scenarios benefiting from faster innovation |
|     New releases      |                                                                               Every 2–3 years                                                                                |                                              Every 6 months                                              |
|        Support        |                                                       5 years of mainstream support, plus 5 years of extended support                                                        |                                                18 months                                                 |
|       Editions        |                                                                    All available Windows Server editions                                                                     |                                     Standard and Datacenter editions                                     |
|      Who can use      |                                                                      All customers through all channels                                                                      |                               Software Assurance and cloud customers only                                |
| Installation options  |                                                                Server Core and Server with Desktop Experience                                                                |                 Server Core for container host and image and Nano Server container image                 |

## Device compatibility

Unless otherwise communicated, the minimum hardware requirements to run the Semi-Annual Channel releases will be the same as the most recent Long-Term Servicing Channel release of Windows Server. For example, **the current Long-Term Servicing Channel release is Windows Server 2019**. Most hardware drivers will continue to function in these releases.

## Servicing

Both the Long-Term Servicing Channel and the Semi-Annual Channel releases will be supported with security updates and non-security updates. The difference is the length of time that the release is supported, as described above.

### Servicing tools

There are many tools with which IT pros can service Windows Server. Each option has its pros and cons, ranging from capabilities and control to simplicity and low administrative requirements. The following are examples of the servicing tools available to manage servicing updates:

- **Windows Update (stand-alone)**: This option is only available for servers that are connected to the Internet and have Windows Update enabled.
- **Windows Server Update Services (WSUS)** provides extensive control over Windows 10 and Windows Server updates and is natively available in the Windows Server operating system. In addition to the ability to defer updates, organizations can add an approval layer for updates and choose to deploy them to specific computers or groups of computers whenever ready.
- **System Center Configuration Manager** provides the greatest control over servicing. IT pros can defer updates, approve them, and have multiple options for targeting deployments and managing bandwidth usage and deployment times.

You’ve likely already chosen to use at least one of these options based on your resources, staff, and expertise. You can continue using the same process for Semi-Annual Channel Releases: for example, if you already use System Center Configuration Manager to manage updates, you can continue to use it. Similarly, if you are using WSUS, you can continue to use that.

## Where to obtain Semi-Annual Channel releases

Semi-Annual Channel releases should be installed as a clean installation.

- Volume Licensing Service Center (VLSC): Volume-licensed customers with [Software Assurance](https://www.microsoft.com/en-us/licensing/licensing-programs/software-assurance-default.aspx) can obtain this release by going to the [Volume Licensing Service Center](https://www.microsoft.com/Licensing/servicecenter/default.aspx) and clicking **Sign In**. Then click **Downloads and Keys** and search for this release. 

- Semi-Annual Channel releases are also available in [Microsoft Azure](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/Microsoft.WindowsServer?tab=Overview).

- Visual Studio Subscriptions: Visual Studio Subscribers can obtain Semi-Annual Channel releases by downloading them from the [Visual Studio Subscriber download page](https://my.visualstudio.com/downloads?pid=2347). If you are not already a subscriber, go to [Visual Studio Subscriptions](https://www.visualstudio.com/subscriptions/) to sign up, and then visit the [Visual Studio Subscriber download page](https://my.visualstudio.com/downloads?pid=2347) as above. Releases obtained through Visual Studio Subscriptions are for development and testing only.

- Obtain preview releases through the Windows Insider Program: Testing the early builds of Windows Server helps both Microsoft and its customers because of the opportunity to discover possible issues before release. It also gives customers a unique opportunity to directly influence the functionality in the product.   
Microsoft depends on receiving feedback throughout the development process so that adjustments may be made as quickly as possible. Early testing and feedback is essential to the rapid release model. To get involved with the Windows Insider Program, see the [Windows Insider Program for Server docs](https://docs.microsoft.com/windows-insider/at-work/).

## Activating Semi-Annual Channel releases

- If you're using Microsoft Azure, this release should automatically be activated.
- If you've obtained this release from the Volume Licensing Service Center or Visual Studio Subscriptions, you can activate it by using your Windows Server 2019 CSVLK with your Key Management System (KMS) environment. For more info, see [KMS client setup keys](../get-started/kmsclientkeys.md).

Semi-Annual Channel releases that were released before Windows Server 2019 use the Windows Server 2016 CSVLK.

## Why do Semi-Annual Channel releases offer only the Server Core installation option?

One of the most important steps we take in planning each release of Windows Server is listening to customer feedback – how are you using Windows Server? What new features will have the greatest impact on your Windows Server deployments, and by extension, your day-to-day business? Your feedback tells us that delivering new innovation as quickly and efficiently as possible is a key priority. At the same time, for those customers innovating most quickly, you’ve told us that you’re primarily using command line scripting with PowerShell to manage your datacenters, and as such don’t have a strong need for the desktop GUI available in the installation of Windows Server with Desktop Experience, especially now that [Windows Admin Center](../manage/windows-admin-center/overview.md) is available to remotely manage your servers.

By focusing on the Server Core installation option, we’re able to dedicate more resources toward those new innovations, while also maintaining traditional Windows Server platform functionality and application compatibility. If you have feedback about this or other issues concerning Windows Server and our future releases, you can make suggestions and comments through the [Feedback Hub](https://support.microsoft.com/help/4021566/windows-10-send-feedback-to-microsoft-with-feedback-hub-app).

## What about Nano Server?

Nano Server is available as a container operating system in the Semi-Annual Channel. See [Changes to Nano Server in Windows Server Semi-Annual Channel](../get-started/nano-in-semi-annual-channel.md) for details.

## How to tell whether a server is running an LTSC or SAC release

Generally speaking, Long-Term Servicing Channel releases such as Windows Server 2019 are released at the same time as a new version of the Semi-Annual Channel, for example, Windows Server, version 1809. This can make it a little tricky to determine whether a server is running Semi-Annual Channel release. Instead of looking at the build number, you must look at the product name: Semi-Annual Channel releases use the "Windows Server Standard" or "Windows Server Datacenter" product name, without a version number, while Long-Term Servicing Channel releases include the version number, for example, "Windows Server 2019 Datacenter".

>[!Note]  
> The below guidance is intended to help identify and differentiate between LTSC and SAC for lifecycle and general inventory purposes only.  It is not intended for application compatibility or to represent a specific API surface.  App developers should use guidance elsewhere to properly ensure compatibility as components, APIs, and functionality can be added over the life of a system, or not yet be added. [Operating System Version](https://docs.microsoft.com/windows/desktop/SysInfo/operating-system-version) is a better starting point for App Developers.

Open Powershell and use the Get-ItemProperty Cmdlet, or the Get-ComputerInfo Cmdlet, to check these properties in the registry.  Along with build number, this will indicate LTSC or SAC by the presence, or lack thereof, of the branded year, i.e. 2019.  LTSC has this, SAC does not.  This will also return the timing of the release with ReleaseId or WindowsVersion, i.e. 1809, as well as whether the installation is Server Core or Server with Desktop Experience. 

**Windows Server 2019 Datacenter Edition (LTSC) with Desktop Experience example:**

````PowerShell
Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion" | Select ProductName, ReleaseId, InstallationType, CurrentMajorVersionNumber,CurrentMinorVersionNumber,CurrentBuild
````

````
ProductName               : Windows Server 2019 Datacenter
ReleaseId                 : 1809
InstallationType          : Server
CurrentMajorVersionNumber : 10
CurrentMinorVersionNumber : 0
CurrentBuild              : 17763
````

**Windows Server, version 1809 (SAC) Standard Edition Server Core example:**

````PowerShell
Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion" | Select ProductName, ReleaseId, InstallationType, CurrentMajorVersionNumber,CurrentMinorVersionNumber,CurrentBuild
````

````
ProductName               : Windows Server Standard
ReleaseId                 : 1809
InstallationType          : Server Core
CurrentMajorVersionNumber : 10
CurrentMinorVersionNumber : 0
CurrentBuild              : 17763
````

**Windows Server 2019 Standard Edition (LTSC) Server Core example:**


````PowerShell
Get-ComputerInfo | Select WindowsProductName, WindowsVersion, WindowsInstallationType, OsServerLevel, OsVersion, OsHardwareAbstractionLayer
````

````
WindowsProductName            : Windows Server 2019 Standard
WindowsVersion                : 1809
WindowsInstallationType       : Server Core
OsServerLevel                 : ServerCore
OsVersion                     : 10.0.17763
OsHardwareAbstractionLayer    : 10.0.17763.107
````

To query if the new [Server Core App Compatibility FOD](https://docs.microsoft.com/windows-server/get-started-19/install-fod-19) is present on a server, use [Get-WindowsCapability](https://docs.microsoft.com/powershell/module/dism/get-windowscapability?view=win10-ps) Cmdlet and look for:
````
Name    :     ServerCore.AppCompatibility~~~~0.0.1.0
State   :     Installed
````

## See also

[Changes to Nano Server in Windows Server Semi-Annual Channel](../get-started/nano-in-semi-annual-channel.md)

[Windows Server support lifecycle](https://support.microsoft.com/lifecycle)

[Determining whether Server Core is running](https://msdn.microsoft.com/library/hh846315%28v=vs.85%29.aspx?f=255&MSPPError=-2147217396)

[GetProductInfo function](https://docs.microsoft.com/windows/desktop/api/sysinfoapi/nf-sysinfoapi-getproductinfo)

[Software Inventory Logging Cmdlets](https://docs.microsoft.com/powershell/module/softwareinventorylogging/?view=winserver2012R2-ps)
