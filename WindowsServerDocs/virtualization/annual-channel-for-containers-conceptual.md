---
title: What is Windows Server Annual Channel for Containers 
description: Learn about Windows Server Annual Channel for containers 
ms.topic: conceptual
author: gswashington
msauthor: robinharwood
ms.date: 11/30/2023

---

# Windows Server Annual Channel for containers

Applies To: Windows Server 2022 -- LTSC (Long-Term Servicing Channel) 23H2
<!-- Need to clarify with Heidi or Robin on how to stipulate applicable versions of Windows Server here; the LTSC versions as I understand it apply to Windows 10 Enterprise OS  -->

Windows Server Annual Channel for Containers is an edition of Windows Server for Azure Kubernetes Services and container-focused Windows Server implemtations that focuses on innovation, efficiencies, and providing optimized portability compatible with either Windows or Linux operating environments.

Windows Server Annual Channel for Containers features a Long-Term Servicing Channel (LTSC) and yearly product updates with new functionality options. Windows on Azure Kubernetes Services (AKS) customers can benefit through a new Windows operating system SKU with versioning aligned to Kubernetes versions, creating a parallel to the Linux upgrade process.

## Portability

Portability is a central feature of Windows Server Annual Channel for containers. Portability addresses a key difference between Windows and Linux containers that can 7delay customers’ accessing the latest Windows Server features due to the fact that Windows containers previously required that workloads have matching container image versions. For example, Windows Server 2019 process-isolated containers cannot run on a Windows Server 2022 host.

The new portability functionality enables Windows Server 2022-based container image operating systems to run on newer versions of Windows Server host operating systems such as the new annual channel release. This support enables container services like AKS to provide updated container host versions of Windows Server on a frequent basis without requiring you to update their containers, much like Linux does already. Portability for Windows containers not only streamlines the upgrade process but empowers developers to leverage the benefits of container technology with enhanced flexibility and compatibility.

Developers and operations teams can opt into the new annual channel by updating their container host to Annual channel version 23H2 without being required to rebuild Windows Server 2022 LTSC container images. To ensure the reliability of the annual channelOnce the new container host is released, you can deploy and test your Window Server 2022 LTSC container images to validate. Note Window Server 2022 is the only supported image on the 23H2 host.

All container images (Nano Server, Server Core, Windows Server) ship with Windows Server LTSCs such as Windows Server 2019 and Windows Server 2022. Container image portability enables you to upgrade your container hosts at a faster cadence without having to in-tandem update your container images, aligning more to the Linux container model.

Azure Kubernetes Services is supported by Windows Server 2019 and Windows Server 2022 hosts. Windows Server Annual Channel for Containers is an additional operating system option (along with Kubernetes 1.28). You can create new node-pools based on the annual channel and keep deploying your Windows Server 2022 container images on those nodes. Microsoft will update the annual channel version automatically, annualy, along with new Kubernetes releases (similar to how Ubuntu updates are managed). Follow LTSC for image releases and update your operating system images appropriately.

## See also

[](.md)

[](.md)