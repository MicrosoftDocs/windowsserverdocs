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

Windows Server Annual Channel for Containers is an edition of Windows Server designed for Azure Kubernetes Services and container-focused Windows Server deployments to improve efficiency and provide optimized portability for both Windows and Linux environments.

Windows Server Annual Channel for Containers is updated on a Long-Term Servicing Channel (LTSC), which means it updates every year with new features and functionality. As an added benefit for Windows on Azure Kubernetes Services customers, its Windows operating system SKU has versioning aligned to Kubernetes versions, much like the Linux upgrade process.

## Portability

Portability is an important feature introduced in Windows Server Annual Channel for Containers that lets users run workloads with different container image versions. Portability lets Windows Server 2022-based container images run on session hosts running later versions of Windows Server. This increased support helps container services like AKS to update the OSes on container hosts on a more frequent basis without requiring you to update the containers themselves. Portability doesn't only streamline the upgrade process, but also helps developers take full advantage of the enhanced flexibility and compatibility that containers offer. See [Portability in Windows Server Annual Channel for containers]() for more information on how portability works.

## Related content

- [Portability in Windows Server Annual Channel for container](.md)