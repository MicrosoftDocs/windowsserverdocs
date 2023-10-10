---
title: Windows Server servicing channels
description: Explanation of Windows Server Long-Term Servicing Channel (LTSC) and Annual Channel
ms.topic: article
author: robinharwood
ms.author: wscontent
manager: femila
ms.date: 8/16/2021
ms.prod: windows-server
---

# Windows Server servicing channels

Beginning in September 2023 Windows Server has two primary release channels available, the Long-Term Servicing Channel and the Annual Channel. The Long-Term Servicing Channel (LTSC) provides a longer term option focuses on providing a traditional lifecycle of quality and security updates, whereas the Annual Channel (AC) provides more frequent releases. The more frequent releases of the AC enable you to take advantage of innovation more quickly with focus on containers and microservices.

## Long-Term Servicing Channel (LTSC)

With the Long-Term Servicing Channel, a new major version of Windows Server is typically released every 2-3 years. Users are entitled to five years of mainstream support and five years of extended support. This channel provides systems with a long servicing option and consistency, and can be installed with Server Core or Server with Desktop Experience installation options.

## Annual Channel (AC)

Windows Server Annual Channel for Containers is an operating system to host Windows Server containers. The Annual Channel enables customers who are innovating quickly to take advantage of new operating system capabilities at a faster pace, focused on containers and microservices. To learn more about Windows Server Annual Channel for Containers, see our [TechCommunity announcement](https://techcommunity.microsoft.com/t5/windows-server-news-and-best/windows-server-annual-channel-for-containers/ba-p/3866248).

Each release in this channel is supported for 24 months from the initial release. This channel can only be installed with the Server Core installation option. The Annual Channel is available to volume-licensed customers with [Software Assurance](https://www.microsoft.com/licensing/licensing-programs/software-assurance-default.aspx) and loyalty programs such as Visual Studio Subscriptions.

An Annual Channel release isn't an update, it's the next Windows Server release in the Annual Channel. To move to an Annual Channel release you must perform a clean installation.

Releases of Windows Server in the Annual Channel typically occur every 12 months. The 24 month support lifecycle for each release is 18 months of mainstream support, plus 6 months of extended support. To learn more about the lifecycle, see [Windows Server 2022 lifecycle](/lifecycle/products/windows-server-2022). Each release is named based on the release cycle; for example, **version 23H2** is a release in the second half of the year 2023.

## Key differences

The following table summarizes the key differences between the channels:

| Description | Long-Term Servicing Channel | Annual Channel |
| -----------------------|--|--|
| Recommended scenarios | General purpose file servers, Microsoft and non-Microsoft workloads, traditional apps, infrastructure roles, software-defined Datacenter, and hyper-converged infrastructure | Containerized applications running on container hosts benefiting from faster innovation |
| New releases | Typically 2–3 years | Typically 12 months |
| Support | 5 years of mainstream support, plus 5 years of extended support | 18 months of mainstream support, plus 6 months of extended support |
| Activation | All Windows Server activation keys | Windows Server Datacenter activation keys |
| Licensing | [All licensing programs](https://www.microsoft.com/licensing/docs/view/Licensing-Programs) | [Software Assurance customers only](https://www.microsoft.com/licensing/licensing-programs/software-assurance-default) |
| Get media | All distribution channels | Volume Licensing Service Center (VLSC) and Visual Studio Subscriptions only |
| Installation options | Server Core and Server with Desktop Experience | Server Core for a container host only |

## Device compatibility

The minimum hardware requirements to run the Annual Channel releases are the same as the most recent Long-Term Servicing Channel release of Windows Server. Most hardware drivers continue to function in these releases.

## Servicing

Both the Long-Term Servicing Channel and the Annual Channel releases are supported with security updates and nonsecurity updates up to the dates listed in the [Microsoft Lifecycle](/lifecycle/products/) pages. The difference is the length of time that the release is supported, as described in the [Annual Channel (AC)](#annual-channel-ac) section of this article.

### Servicing tools

There are many tools with which you can service Windows Server. Each option has its pros and cons, ranging from capabilities and control to simplicity and low administrative requirements. The following are examples of the servicing tools available to manage servicing updates:

- **Windows Update (stand-alone)**: This option is only available for servers that are connected to the Internet and have Windows Update enabled.
- **Windows Server Update Services (WSUS)** provides extensive control over Windows Server and Windows client updates and is natively available in the Windows Server operating system. You can defer updates, add an approval layer, and choose to deploy them to specific computers or groups of computers whenever ready.
- **Microsoft Endpoint Configuration Manager** provides the greatest control over servicing. You can defer updates, approve them, and have multiple options for targeting deployments and managing bandwidth usage and deployment times.

You can continue using the same process for Annual Channel Releases; for example, if you already use Configuration Manager to manage updates, you can continue to use it. Similarly, if you're using WSUS, you can continue to use that.

## Where to get Annual Channel

You can obtain Annual Channel releases from the following places:

- Volume Licensing Service Center (VLSC): Volume-licensed customers with [Software Assurance](https://www.microsoft.com/licensing/licensing-programs/software-assurance-default.aspx) can obtain this release by going to the [Volume Licensing Service Center](https://www.microsoft.com/Licensing/servicecenter/default.aspx) and select **Sign In**. Finally, select **Downloads and Keys**, search for Annual Channel, then download the media.

- Visual Studio Subscriptions: Visual Studio Subscribers can obtain Annual Channel releases by downloading them from the [Visual Studio Subscriber download page](https://my.visualstudio.com/Downloads?q=Windows%20Server,%20version). If you aren't already a subscriber, go to [Visual Studio Subscriptions](https://www.visualstudio.com/subscriptions/) to sign up, and then visit the [Visual Studio Subscriber downloads page](https://my.visualstudio.com/Downloads?q=Windows%20Server,%20version). Releases obtained through Visual Studio Subscriptions are for development and testing only.

## Activating Annual Channel releases

You need to activate your installation using your activation keys obtained from the VLSC. If you're using KMS, Annual Channel releases use the same CSVLK of the last LTSC release before their release. For example, an Annual Channel released with or after Windows Server 2022 would use the Windows Server 2022 CSVLK. For more information, see [KMS client setup keys](kms-client-activation-keys.md).

## How to tell whether a server is running an LTSC or AC release

Long-Term Servicing Channel releases could be released at the same time as a new version of the Annual Channel. To determine whether a server is running Annual Channel release, you must look at the operating system version. The product name doesn't reflect the servicing channel. To determine whether a server is running an LTSC or AC release, you can run the [Get-ComputerInfo](/powershell/module/microsoft.powershell.management/get-computerinfo) PowerShell command. The following example is a computer running Windows Server 2022 Datacenter Edition (LTSC).

To determine the operating system version, run the following command:

```powershell
Get-ComputerInfo  | fl WindowsProductName,OSDisplayVersion
```

Here's an example output from a computer running Windows Server LTSC.

```output
WindowsProductName : Windows Server 2022 Datacenter
OSDisplayVersion   : 21H2
```

Here's an example output from a computer running Windows Server Annual Channel for Containers.

```output
WindowsProductName : Windows Server 2022 Datacenter
OSDisplayVersion   : 23H2
```

> [!TIP]
> `OSDisplayVersion` only applies to Windows Server 2022 and later. Annual Channel releases do not apply to Windows Server 2019 and earlier. If you're running Windows Server 2019 or earlier, you're running an LTSC release.

The following table lists the Windows Server LTSC and AC releases and their corresponding operating system versions.

| Channel | Operating system display version |
| --- | --- |
| LTSC | 21H2 |
| Annual Channel | 23H2 |

The guidance is intended to help identify and differentiate between LTSC and AC for lifecycle and general inventory purposes only. It isn't intended for application compatibility or to represent a specific API surface. App developers should use guidance elsewhere to properly ensure compatibility as components, APIs, and functionality can be added over the life of a system, or not yet be added. To learn more about using programmatically determining the version, see [Operating System Version](/windows/win32/sysinfo/operating-system-version).
