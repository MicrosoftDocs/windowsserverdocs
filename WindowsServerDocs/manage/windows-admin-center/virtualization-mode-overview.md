---
title: What is Windows Admin Center Virtualization Mode (preview)?
description: Learn what Windows Admin Center Virtualization Mode is. See how it differs from administration mode, the scale it supports, setup needs, upkeep, and built-in tools for large environments.
author: robinharwood
ms.author: roharwoo
ms.topic: overview
ms.date: 11/17/2025
ai-usage: ai-assisted
#customer intent: As a virtualization operator, I want to understand what Windows Admin Center Virtualization Mode is, so that I can efficiently administer distributed Hyper-V resources at scale.
---

# What is Windows Admin Center Virtualization Mode?

> [!IMPORTANT]
> Windows Admin Center Virtualization Mode is currently in PREVIEW.
> This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

Windows Admin Center Virtualization Mode is a purpose-built management experience for virtualization infrastructure. It enables IT professionals to centrally administer Hyper-V hosts, clusters, storage, and networking at scale.

Unlike administration mode, which focuses on general system management, Virtualization Mode focuses on fabric management. It supports parallel operations and contextual views for compute, storage, and network resources. This mode is optimized for large-scale, cluster-based environments and integrates lifecycle management, global search, and role-based access control.

Virtualization Mode offers the following key capabilities:

- Search across navigation objects with contextual filtering.
- Support for SAN, NAS, hyperconverged, and scale-out file server architectures.
- VM templates, integrated disaster recovery with Hyper-V Replica, and onboarding of Arc-enabled resources (future capability).
- Software-defined storage and networking (not available at this time).

## Operational modes

Windows Admin Center has two independent modes:

- **Administration mode**: The Windows Admin Center experience you're already familiar with. Administration mode focuses on general server administration with tools and features that help you perform general server administration tasks.

- **Virtualization mode**: Manage the infrastructure required to host virtual machines. The tools and experiences are more focused on these specific goals.

For example, in administration mode, you have tools like Device Manager and Registry Editor, while virtualization mode features SDN tools, among other things specific to virtualization.

The following table summarizes the key differences between administration mode and virtualization mode:

| Area | Administration Mode | Virtualization Mode |
|--------|---------------------|---------------------|
| Used for | General system administration (Device Manager, Remote Desktop, Registry, Roles & Features). | Virtualization fabric management (Hyper-V hosts/clusters, VM lifecycle, Storage Spaces Direct, Network ATC, SDN, volumes). |
| Scenario Focus | Single-server and cluster management tasks and troubleshooting. | Large-scale, distributed cluster and resource lifecycle management. |
| Connection | Stateless, per-session direct connections (WinRM/PowerShell) to individual servers. | Stateful with database and agents enabling parallel, persistent cluster connections. |
| View | Component-centric (processes, services, registry, events, features). | Resource-centric (compute, storage, networking, VMs) with contextual navigation and search. |
| Scale | Typically 1–50 hosts for general server management. | Up to 1,000 hosts and 25,000 VMs per instance. |
| Operations | Remote PowerShell at runtime | Parallel operations using a local agent. |

You must install Windows Admin Center Administration Mode and Windows Admin Center Virtualization mode on separate systems.

### Tools and features

Virtualization Mode includes the following tools and features:

| Host profile | Tools and features |
|-------------|-----------------------|
| Compute (hosts) | - Overview dashboard<br>- Settings<br>- Updates<br>- Virtual Machines<br>- Servers<br>- Volumes<br>- VM Conversion<br>- Hyper-V Replica<br>- GPU-P |
| Compute (servers) | - Dashboard<br>- Settings<br>- Events<br>- Firewall<br>- Updates<br>- Virtual Machines<br>- Networks<br>- Storage |
| Storage | Profile not available at this time. |
| Networking | Profile not available at this time. |

To learn about the tools available to Administration Mode for non-virtualization scenarios, see [Manage Servers with Windows Admin Center](use/manage-servers.md).

## How it works

Virtualization Mode deploys as an appliance on physical or virtual machines. For more information about the installation requirements, see [Install Windows Admin Center Virtualization Mode](install-virtualization-mode.md).

This mode uses a client-server architecture with a web-based gateway and local agents on managed Hyper-V hosts. The gateway handles user authentication, request routing, and maintains a stateful database, while agents perform operations on hosts. TLS secures communication between the gateway and agents.

The following diagram illustrates the architecture of Windows Admin Center Virtualization Mode:

:::image type="content" source="media/virtualization-mode-overview/architecture.png" alt-text="Diagram that shows a client browser connecting to a Virtualization Mode gateway, which orchestrates three Hyper-V hosts in parallel." lightbox="media/virtualization-mode-overview/architecture.png":::

The architecture efficiently orchestrates large-scale virtualization environments, so it doesn't affect the availability or performance of the managed Hyper-V hosts and clusters during normal operations.

Virtualization Mode introduces the concepts of resource groups and host profiles to help organize and manage virtualization resources at scale.

### Resource groups

A resource group is a logical container in Virtualization Mode that you use to organize virtualization resources. Resource groups don't nest. Each host belongs to exactly one resource group for organization and profile-based management.

Use resource groups to:

- Segregate hosts by environment (production, lab, staging).
- Simplify navigation by scoping search and operations.

### Host profiles

Host profiles indicate the service a system provides to virtual machines within Virtualization Mode. A profile classifies each added system by its primary role so Virtualization Mode can present it in the correct navigation view and role-aware workflows.

Profile types:

- Compute: Hosts provide compute virtualization.
- Storage: Storage systems for virtual machines (SAN, NAS, or hyperconverged using Storage Spaces Direct). The storage profile isn't available at this time.
- Networking: Software Defined Networking (SDN) services for virtual machines. The networking profile isn't available at this time.

### Network intent templates

Windows Admin Center vMode introduces a new concept called a _Network intent template_, which is an abstracted, predefined intent that you didn't yet apply to a network adapter or associate with a cluster or standalone host. A Network Intent Template essentially serves as a blueprint that you can use to create intents after you specify which NICs the template should apply to.

Currently, you apply Network intent templates to the specific nodes in the Add Resource workflow but the template isn't saved after exiting the workflow. To onboard other nodes in the Add Resource workflow, you need to recreate the template.

## Next steps

> [!div class="nextstepaction"]
> [Install Windows Admin Center Virtualization Mode](install-virtualization-mode.md)