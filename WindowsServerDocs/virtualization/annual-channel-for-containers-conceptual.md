---
title: What is Windows Server Annual Channel for Containers 
description: Learn about Windows Server Annual Channel for containers 
ms.topic: conceptual
author: gswashington
msauthor: robinharwood
ms.date: 12/17/2023

---

# Windows Server Annual Channel for containers

Applies to: Windows Server 2022
<!-- alternately ... Applies To: Windows Server 2022 -- LTSC (Long-Term Servicing Channel) 23H2 -->

Windows Server Annual Channel for Containers is an edition of Windows Server designed for Azure Kubernetes Services and container-focused Windows Server deployments to improve efficiency and provide optimized portability for both Windows and Linux environments.

Windows Server Annual Channel for Containers is updated on a Long-Term Servicing Channel (LTSC), which means it updates every year with new features and functionality. As an added benefit for Windows on Azure Kubernetes Services customers, its Windows operating system SKU has versioning aligned to Kubernetes versions, much like the Linux upgrade process.

## Portability

Portability is a feature introduced in Windows Server Annual Channel for Containers that lets users run workloads with different container image versions. Previously, users could only run workloads with matching image versions. For example, a user running a Windows Server 2022 host couldn't run Windows Server 2019 process-isolated containers.

Portability lets Windows Server 2022-based container images to run on session hosts running later versions of Windows Server. This increased support helps container services like AKS to update the OSes on container hosts on a more frequent basis without requiring you to update the containers themselves. Portability doesn't only streamline the upgrade process, but also helps developers take full advantage of the enhanced flexibility and compatibility that containers offer.

Developers and operations teams can opt into the new annual channel by updating their container host to Annual Channel Version 23H2 without being required to rebuild their existing Windows Server 2022 LTSC container images. Once you've set up the annual channel, make sure to validate your container images by deploying and testing them.

>[!NOTE]
>Hosts running Annual Channel 23H2 currently only support Window Server 2022 containers.

Nano Server, Server Core, and Windows Server container images come with Long-Term Servicing Channels (LTSCs) for containers running Windows Server 2019 and Windows Server 2022. Built-in portability allows these containers to upgrade at a faster cadence instead of needing in-tandem updates, making them align more closely with the Linux container model.

Azure Kubernetes Services currently support Windows Server 2019 and Windows Server 2022 hosts. Windows Server Annual Channel for Containers is another container OS option that Microsoft offers along with Kubernetes 1.28. You can create new node pools based on the annual channel and keep deploying your Windows Server 2022 container images on those nodes. Microsoft updates the annual channel version and any new Kubernetes releases on an annual basis automatically, much like Ubuntu updates. However, it's also a good idea to follow the latest LTSC releases to make sure your containers are up to date.

## Related content

- [](.md)
- [](.md)