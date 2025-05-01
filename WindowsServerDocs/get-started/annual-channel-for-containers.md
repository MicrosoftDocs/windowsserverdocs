---
title: What is Windows Server Annual Channel for Containers?
description: Learn about Windows Server Annual Channel for Containers 
ms.topic: concept-article
author: robinharwood
ms.author: roharwoo
ms.date: 02/29/2024

---

# What is Windows Server Annual Channel for Containers?



Windows Server Annual Channel for Containers is an operating system to host Windows Server containers. Annual Channel enables customers who are innovating quickly to take advantage of new operating system capabilities at a faster pace, focusing on containers, microservices, and portability.

Windows Server Annual Channel for Containers means new features and functionality being released on an annual basis. The more frequent releases of Annual Channel enable customers to take advantage of innovation more quickly, with a focus on containers and microservices. To learn more about the lifecycle, see the [Windows Server Annual Channel lifecycle article](/lifecycle/products/windows-server-annual-channel). To learn more about difference between servicing channels, see [Windows Server servicing channels](/windows-server/get-started/servicing-channels-comparison).

## Supported platforms

A Windows Server, version 23H2 container host only supports the Windows Server 2022 Long Term Servicing Channel (LTSC) container image.

## Portability

Portability is an important feature introduced in Windows Server Annual Channel for Containers that lets users run workloads with different container image versions. Portability lets Windows Server 2022-based container images run on session hosts running later versions of Windows Server. This increased support helps container services like AKS to update the operating systems on container hosts on a more frequent basis without requiring you to update the containers themselves. Portability doesn't only streamline the upgrade process, but also helps developers take full advantage of the enhanced flexibility and compatibility that containers offer. For more information about portability, see [Portability in Windows Server Annual Channel for containers](https://techcommunity.microsoft.com/t5/containers/portability-with-windows-server-annual-channel-for-containers/ba-p/3885911).

## Get started with Windows Server Annual Channel for Containers

To get started using Annual Channel for Containers, use your preferred method to install Windows
Server on your container host. Annual Channel is available to volume-licensed customers with Software Assurance and loyalty programs such as Visual Studio Subscriptions. You can get Annual Channel releases from:

- Volume Licensing Service Center (VLSC): Volume-licensed customers with [Software Assurance](https://www.microsoft.com/licensing/licensing-programs/software-assurance-default.aspx) can obtain this release by going to the [Volume Licensing Service Center](https://www.microsoft.com/Licensing/servicecenter/default.aspx) and select **Sign In**. Finally, select **Downloads and Keys**, search for Annual Channel, then download the media.

- Visual Studio Subscriptions: Visual Studio Subscribers can obtain Annual Channel releases by downloading them from the [Visual Studio Subscriber download page](https://my.visualstudio.com/Downloads?q=Windows%20Server,%20version). If you aren't already a subscriber, go to [Visual Studio Subscriptions](https://www.visualstudio.com/subscriptions/) to sign up, and then visit the [Visual Studio Subscriber downloads page](https://my.visualstudio.com/Downloads?q=Windows%20Server,%20version). Releases obtained through Visual Studio Subscriptions are for development and testing only.

> [!WARNING]
> Annual Channel can only be installed with the Server Core installation option. To move to an Annual Channel release from LTSC, or to upgrade an existing Annual Channel installation, you must perform a clean installation.

## Related content

- [Portability in Windows Server Annual Channel for container](https://techcommunity.microsoft.com/t5/containers/portability-with-windows-server-annual-channel-for-containers/ba-p/3885911)
