---
title: Remote Desktop Services overview in Windows Server
description: Provides an overview of Remote Desktop Services.
ms.topic: overview
ai-usage: ai-assisted
ms.author: daknappe
author: dknappettmsft
ms.date: 10/30/2025
---

# Remote Desktop Services overview in Windows Server

Remote Desktop Services (RDS) in Windows Server is a built-in platform for securely delivering managed desktops and applications to users, whether they're in the office, working from home, or connecting from branch and partner locations. By centralizing processing in the datacenter and remoting only the UI, Remote Desktop Services helps you reduce management overhead, improve security, and give users consistent, performant access to the resources they need.

Remote Desktop Services supports both multi‑session server‑based desktops and single‑session (or pooled/personal) virtual desktops, plus publishing of individual applications (RemoteApp). You choose the right mix of models to optimize cost, performance, and user experience.

:::image type="content" source="./media/rds-overview.png" alt-text="Graphic of Remote Desktop Services overview.":::

> [!TIP]
> If you want to evaluate a broader cloud-based desktop solution, see [Azure Virtual Desktop](/azure/virtual-desktop/). You can even extend Azure Virtual Desktop to your on-premises datacenter with Azure Local.

## What is Remote Desktop Services?

Remote Desktop Services is a role-based infrastructure in Windows Server that lets authorized users connect over the network to:

- A full desktop (session-based or virtual machine based).
- Specific applications (RemoteApp programs) that appear and behave like locally installed apps.

Instead of installing and patching applications on many individual endpoints, you manage them once on centralized hosts. Endpoints simply present the remote UI by using the Remote Desktop Protocol (RDP).

### Key benefits

Remote Desktop Services centralizes application and desktop management so you patch and secure resources once rather than across many endpoints. Multi‑session density lowers per‑user cost while a mix of session hosts and VDI provides flexibility for performance or compatibility needs. Data remains in the datacenter; encrypted remote access, MFA, and auditing can strengthen your compliance posture. Users stay productive because RemoteApp windows behave like local apps, supporting taskbar pinning, multi‑monitor workflows, and standard window controls. The platform extends easily with profile management, printing, monitoring, GPU acceleration, and broad automation via PowerShell.

## Core Remote Desktop Services roles and components

Remote Desktop Services includes several roles that you can distribute and scale:

| Role | Purpose |
|------|---------|
| **RD Session Host (RDSH)** | Runs session-based user desktops and RemoteApp programs on Windows Server for multi-session efficiency. |
| **RD Virtualization Host** | Hosts Virtual Desktop Infrastructure collections (pooled or personal Windows client VMs). Integrates with Hyper-V for provisioning. |
| **RD Connection Broker** | Maintains user sessions, load balances connections, reconnects users to existing sessions, manages collections (session and VDI). Supports high availability. |
| **RD Web Access** | Provides a web portal and feeds (Web Access / RemoteApp and Desktop Connections) listing desktops and apps users are authorized to use. |
| **RD Gateway** | Enables secure, encrypted RDP access over HTTPS (TCP 443) from external networks without opening internal RDP ports. Supports MFA and conditional policies. |
| **RD Licensing** | Issues and tracks Remote Desktop Services Client Access Licenses (RDS CALs) required for legal use (User or Device). |

Supporting components often include file services for user profiles, certificate services for TLS, and monitoring solutions.

## Deployment models

You can mix and match models based on user persona and technical requirements:

| Model | Description | Typical use cases | Cost & density |
|-------|-------------|-------------------|----------------|
| **Session-based (RDSH)** | Multiple users share a Windows Server instance; each gets an isolated session. | Task workers, line-of-business apps, seasonal users. | Highest user density, lowest per-user cost. |
| **VDI pooled** | Users connect to a dynamically assigned Windows client VM from a pool. Non-persistent or resettable state. | Knowledge workers needing Windows client compatibility; app isolation. | Medium density/cost. |
| **VDI personal** | Each user is assigned a dedicated Windows client VM that retains changes. | Developers, power users, customization-heavy apps. | Lowest density, highest flexibility. |
| **Hybrid** | Combine RDSH for baseline apps + VDI for specialized needs. | Mixed persona environments. | Optimized balance. |

### Hosting locations

You can deploy Remote Desktop Services in different environments:

- **On-premises**: Full control of hardware, networking, and data locality.
- **Azure infrastructure (IaaS)**: Deploy Remote Desktop Services roles on Azure VMs for elastic capacity and simplified global access.

## Common scenarios

Organizations use Remote Desktop Services to standardize application delivery to branch offices, enable secure access for contractors or partners without exposing internal networks broadly, rapidly onboard seasonal or temporary staff, and host legacy or specialized Windows applications that are impractical to deploy on many devices. It's also common in regulated sectors (finance, healthcare) where data residency and auditability matter, and for IT administrators who need remote desktop access with constrained privileges rather than full VPN tunnels.

## Publishing options

You can publish full desktops (session‑based or VM‑based) that present a curated application set, or provide individual RemoteApp programs that integrate into the user's Start menu and taskbar, can span multiple monitors, and appear and behave like locally installed software.

## Security and compliance

Remote Desktop Services builds on Windows security: TLS protects RDP traffic (deploy valid certificates for Gateway, Broker, and Web Access), and RD Gateway encapsulates RDP in HTTPS to minimize exposed ports while enabling conditional access and MFA integration. Collections and security groups help enforce least‑privilege segmentation; centralized execution keeps data resident in the datacenter so only the UI stream leaves. Event logs and Windows auditing feed monitoring or SIEM solutions for compliance and forensic review.

## Planning considerations

Effective planning starts with user personas: estimate CPU, memory, storage I/O profiles for task, knowledge, and power users. From there, model capacity for sessions per RD Session Host and sizing for pooled or personal VDI, while designing Connection Broker high availability. Profile strategy (roaming profiles, folder redirection, or third‑party profile management) impacts logon performance and disk growth; avoid uncontrolled profile sprawl on hosts. If users need 3D or rich multimedia, plan GPU resources (Hyper‑V DDA or supported virtualization technologies). Network topology and latency drive user experience, so place RD Gateway to minimize round‑trip time and ensure sufficient bandwidth for peak concurrency. Validate application multi‑session behavior early to catch assumptions about per‑machine paths or registry keys, and script deployment, scaling, and maintenance with PowerShell to reduce manual effort.

## Management and monitoring

Daily operations blend GUI and automation: Server Manager and PowerShell handle role installation, collection creation, and application publishing; the Connection Broker manages load balancing and user assignment across hosts. Monitor sessions and resource consumption (CPU, memory, disk, GPU) and review authentication or disconnection events for trends. Maintain custom images for pooled VDI and stagger patching of session hosts to keep capacity available. Scheduled scripts streamline certificate renewal, image refresh, and scale‑out/scale‑in adjustments.

## Next steps

To get started with Remote Desktop Services, review the following articles:

- [Supported configurations](rds-supported-config.md)
- [Planning and design](rds-plan-and-design.md) for capacity, high availability, MFA, and certificates
- [Architecture models](desktop-hosting-logical-architecture.md)
