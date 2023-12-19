---
title: What is Windows Server Annual Channel for Containers 
description: Learn about Windows Server Annual Channel for containers 
ms.topic: conceptual
author: gswashington
msauthor: robinharwood
ms.date: 12/17/2023

---

# Windows Server Annual Channel for containers

Applies to: Windows Server 2022 -- LTSC (Long-Term Servicing Channel) 23H2

Windows Server Annual Channel for Containers is an operating system to host Windows Server containers. The Annual Channel enables customers who are innovating quickly to take advantage of new operating system capabilities at a faster pace, focusing on containers and microservices including optimized portability for both Windows and Linux environments.

Windows Server Annual Channel for Containers is enabled on a Long-Term Servicing Channel (LTSC), which means new features and functionality being released on an annual basis. Each release in the channel is supported for 24 months from the initial release. The channel can only be installed with the Server Core installation option. The Annual Channel is available to volume-licensed customers with Software Assurance and loyalty programs such as Visual Studio Subscriptions. As an added benefit for Windows on Azure Kubernetes Services customers, its Windows operating system SKU has versioning aligned to Kubernetes versions, much like the Linux upgrade process.

An Annual Channel release isn't an update, it's the next Windows Server release in the Annual Channel. To move to an Annual Channel release you must perform a clean installation.

Releases of Windows Server in the Annual Channel typically occur every 12 months. The 24 month support lifecycle for each release is 18 months of mainstream support, plus six months of extended support. To learn more about the lifecycle, see Windows Server 2022 lifecycle [](). Each release is named based on the release cycle; for example, version 23H2 is a release in the second half of the year 2023.

## Portability

Portability is an important feature introduced in Windows Server Annual Channel for Containers that lets users run workloads with different container image versions. Portability lets Windows Server 2022-based container images run on session hosts running later versions of Windows Server. This increased support helps container services like AKS to update the OSes on container hosts on a more frequent basis without requiring you to update the containers themselves. Portability doesn't only streamline the upgrade process, but also helps developers take full advantage of the enhanced flexibility and compatibility that containers offer. See [Portability in Windows Server Annual Channel for containers]() for more information on how portability works.

## Related content

- [Portability in Windows Server Annual Channel for container](.md)