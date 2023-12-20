---
title: What is Windows Server Annual Channel for Containers 
description: Learn about Windows Server Annual Channel for containers 
ms.topic: conceptual
author: gswashington
msauthor: robinharwood
ms.date: 01/07/2024

---

# Windows Server Annual Channel for containers

Applies to: Windows Server 2022 -- LTSC (Long-Term Servicing Channel) 23H2

Windows Server Annual Channel for Containers is an operating system to host Windows Server containers. The Annual Channel enables customers who are innovating quickly to take advantage of new operating system capabilities at a faster pace, focusing on containers and microservices including optimized portability for both Windows and Linux environments.

Windows Server Annual Channel for Containers means new features and functionality being released on an annual basis. The channel can only be installed with the Server Core installation option. The Annual Channel is available to volume-licensed customers with Software Assurance and loyalty programs such as Visual Studio Subscriptions. As an added benefit for Windows on Azure Kubernetes Services customers, its Windows operating system SKU has versioning aligned to Kubernetes versions, much like the Linux upgrade process.

The more frequent releases of the AC enable customers to take advantage of innovation more quickly, with a focus on containers and microservices. For a detailed comparison, see Windows Server servicing channels.To learn more about the lifecycle, see Windows Server 2022 lifecycle [](). Each release is named based on the release cycle; for example, version 23H2 is a release in the second half of the year 2023.

>Note
>To move to an Annual Channel release you must perform a clean installation.

## Portability

Portability is an important feature introduced in Windows Server Annual Channel for Containers that lets users run workloads with different container image versions. Portability lets Windows Server 2022-based container images run on session hosts running later versions of Windows Server. This increased support helps container services like AKS to update the OSes on container hosts on a more frequent basis without requiring you to update the containers themselves. Portability doesn't only streamline the upgrade process, but also helps developers take full advantage of the enhanced flexibility and compatibility that containers offer. See [Portability in Windows Server Annual Channel for containers](/.md) for more information on how portability works.

## Related content

- [Portability in Windows Server Annual Channel for container](.md)