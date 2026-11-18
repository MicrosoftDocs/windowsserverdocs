---
title: "Windows Admin Center: Choose an Installation"
description: Compare Windows Admin Center Administration Mode and Virtualization Mode, and choose an Administration Mode installation topology.
ms.topic: concept-article
author: davannaw-msft
ms.author: dawhite
ms.date: 07/14/2025
ai-usage: ai-assisted
---
# Windows Admin Center installation options

Windows Admin Center provides two management experiences that you install independently: Administration Mode for general server and cluster management, and Virtualization Mode for virtualization fabric management at scale. This article helps you choose an experience and, if you choose Administration Mode, select an installation topology.

The installation topologies and supported operating systems in this article apply to Administration Mode. To install Windows Admin Center on a virtual machine (VM) in Azure, see [Deploy Windows Admin Center in Azure](../azure/deploy-wac-in-azure.md).

## Choose a management experience

Choose the experience that matches the scope and type of resources you need to manage.

| Experience | Choose this experience when | Installation model |
|---|---|---|
| **Administration Mode** | You need general administration and troubleshooting tools for individual servers and clusters. | Install on a local client, gateway server, managed server, or failover cluster by using the standard Windows Admin Center installer. |
| **Virtualization Mode** | You need centralized, large-scale management of Hyper-V hosts, clusters, virtual machines, storage, and networking. | Install as a dedicated appliance on a physical or virtual Windows Server machine by using the separate Virtualization Mode installer. |

> [!IMPORTANT]
> You can't install Administration Mode and Virtualization Mode on the same system.

Virtualization Mode doesn't replace Administration Mode for general server administration. Install each mode on a separate system to use both experiences in the same environment. For more information about the capabilities and architecture of each experience, see [What is Windows Admin Center Virtualization Mode?](../virtualization-mode-overview.md) For Virtualization Mode requirements and installation guidance, see [Install Windows Admin Center Virtualization Mode](../install-virtualization-mode.md).

## Administration Mode installation topologies

For Administration Mode, choose one of the following installation topologies.

:::image type="complex" source="../media/deployment-options/install-options.PNG" alt-text="Diagram that shows local client, gateway server, managed server, and failover cluster installation topologies." border="false":::
The diagram shows four Administration Mode installation topologies. In the local client topology, you install Windows Admin Center on your local personal computer (PC) for quick access and testing, and the PC connects to managed servers. Gateway server provides a central access point that multiple administrators reach through a browser; the gateway then connects to managed servers. In the managed server topology, you install Windows Admin Center directly on the server that you connect to and manage. In the failover cluster topology, you install Windows Admin Center on a cluster to provide a highly available, resilient management service. Administrators use the failover cluster gateway to manage standalone servers and other failover clusters.
:::image-end:::

| Topology | Install location | Choose this topology when |
|---|---|---|
| Local client | [Install Windows Admin Center](../deploy/install.md) on a local Windows 11 client that has connectivity to the managed servers. | One administrator needs a quick setup for testing, ad hoc work, or small-scale management. |
| Gateway server | [Install Windows Admin Center](../deploy/install.md) on a designated gateway server that client browsers can reach. | Multiple administrators need shared access or you manage a larger environment. |
| Managed server | [Install Windows Admin Center](../deploy/install.md) directly on a managed server. | You need to remotely manage that server or a cluster in which the server is a member node, such as in a distributed environment. |
| Failover cluster | [Deploy high availability](#administration-mode-high-availability) for the gateway service on a failover cluster. | A production environment requires a highly available and resilient management service. |

We don't recommend using Administration Mode for local management of the same server on which it's installed. To manage a server, connect to it remotely from Windows Admin Center installed on a management PC or another server.

These topology choices don't apply to Virtualization Mode, which uses a dedicated appliance and has separate installation requirements.

## Installation supported operating systems

Use the following Windows operating systems to install Windows Admin Center Administration Mode:

| **Platform**                       | **Administration Mode topology** |
| -----------------------------------| --------------------- |
| Windows 11                         | Local client |
| Windows 11 ARM64 Client            | Local client |
| Windows Server Semi-Annual Channel | Gateway server, managed server, failover cluster |
| Windows Server 2025                | Gateway server, managed server, failover cluster |
| Windows Server 2022                | Gateway server, managed server, failover cluster |
| Windows Server 2019                | Gateway server, managed server, failover cluster |
| Windows Server 2016                | Gateway server, managed server, failover cluster |

To use Administration Mode:

- **Local client:** Launch the Windows Admin Center gateway from the Start menu, and connect to it from a client web browser by accessing `https://localhost:6516`.
- **Other topologies:** Connect to the Windows Admin Center gateway on a different machine from a client browser by using its URL, for example, `https://servername.contoso.com`.

> [!WARNING]
> Don't install Windows Admin Center on a domain controller because this configuration isn't supported. For more information, see [domain controller security best practices](../../../identity/ad-ds/plan/security-best-practices/securing-domain-controllers-against-attack.md).

> [!NOTE]
> Port usage and defaults for Windows Admin Center installations on the modernized gateway vary from what is mentioned above. For more information, see [what's different in the modernized gateway](../understand/modernized-gateway.md).

## Installation: Supported web browsers

Microsoft Edge (including [Microsoft Edge insider](https://www.microsoft.com/edge/download/insider)) and Google Chrome are tested and supported on Windows 10 and 11. Other web browsers, including Firefox, aren't currently part of our test matrix and are therefore not *officially* supported. These browsers might have problems running Windows Admin Center. For example, Firefox has its own certificate store, so you must import the `Windows Admin Center Client` certificate into Firefox to use Windows Admin Center on Windows 10. For more details, see [browser-specific known issues](../support/known-issues.md#browser-specific-issues).

## Administration Mode supported management targets

Use Windows Admin Center Administration Mode to manage the following Windows operating systems:

| Version | Manage *node* via *Server Manager* | Manage via *Cluster Manager* |
| ------------------------- |--------------- | ----- |
| Windows 11 | Yes (via Computer Management) | N/A |
| Windows 11 ARM64 client | Yes (via Computer Management) | N/A |
| Windows Server Semi-Annual Channel | Yes | Yes |
| Windows Server 2025 | Yes | Yes |
| Windows Server 2022 | Yes | Yes |
| Windows Server 2019 | Yes | Yes |
| Windows Server 2016 | Yes | Yes, with [latest cumulative update](../use/manage-hyper-converged.md#prepare-your-windows-server-2016-cluster-for-windows-admin-center) |
| Microsoft Hyper-V Server 2016 | Yes | Yes |

Windows Admin Center requires PowerShell features that are not included in Windows Server 2012 and 2012 R2. If you will manage these with Windows Admin Center, you will need to install Windows Management Framework (WMF) version 5.1 or higher on those servers.

Type `$PSVersiontable` in PowerShell to verify that WMF is installed, and that the version is 5.1 or higher.

If WMF isn't installed, you can [download WMF 5.1](https://www.microsoft.com/download/details.aspx?id=54616).

## Administration Mode high availability

You can enable high availability for the Administration Mode gateway service by deploying Windows Admin Center in an active-passive model on a failover cluster. If one of the nodes in the cluster fails, Windows Admin Center gracefully fails over to another node, so you can continue managing the servers in your environment without interruption.

[Deploy Windows Admin Center with high availability](../deploy/high-availability.md).

## Next steps

- To deploy Administration Mode, see [Install Windows Admin Center](../deploy/install.md).
- To deploy Virtualization Mode, see [Install Windows Admin Center Virtualization Mode](../install-virtualization-mode.md).
