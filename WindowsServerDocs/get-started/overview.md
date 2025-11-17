---
title: What is Windows Server?
description: Learn about Windows Server capabilities, deployment options, and key features that help you modernize your infrastructure while maintaining security and performance.
ms.topic: overview
ms.date: 07/28/2025
ai-usage: ai-generated
author: robinharwood
ms.author: roharwoo
---

# What is Windows Server?

> [!TIP]
> Already familiar with Windows Server? Jump to [What's new in Windows Server 2025](whats-new-windows-server-2025.md) to learn about the latest features and enhancements.

Windows Server is Microsoft's enterprise server platform that enables organizations to run and secure applications, services, and workloads across on-premises, hybrid, and cloud environments.

Whether you're running a small business or managing enterprise infrastructure, Windows Server provides the foundation for secure, scalable, and high-performance computing that grows with your organization. Built on decades of Windows innovation, it serves as the backbone for millions of organizations worldwide, powering everything from file servers and web applications to complex enterprise workloads and AI-driven solutions.

</br>

> [!VIDEO 715f723f-0644-4b9d-b7df-6e708da43242]

## Why choose Windows Server?

Windows Server delivers comprehensive capabilities that help organizations modernize their infrastructure while maintaining security, performance, and reliability.

Use Windows Server for:

- **Mixed environments**: Unified management of Windows, Linux, and container workloads.
- **Enterprise integration**: Seamless integration with SQL Server, System Center, Exchange,  SharePoint, Project, and existing Windows infrastructure.
- **Commercial support**: Enterprise-grade support with an active tech community.
- **Compliance scenarios**: Built-in features for regulated industries (healthcare, finance, government).
- **Flexible licensing**: Choose between pay-as-you-go, perpetual, or subscription-based licensing.

Windows Server builds on this foundation with new features that enhance security, performance, and cloud integration. The following sections highlight some of the key benefits and features of Windows Server.

### Advanced, multi-layered security

Improved protections against ever-evolving threats, multilayered safeguards, and improved resilience.

- **Advanced identity protection**: Enterprise directory services (Active Directory) that provide centralized authentication, authorization, and policy management across Windows, Linux, and Mac systems.
- **Virtualization-based security**: Enhanced Hyper-V security with VBS enclaves and key protection for confidential computing.
- **Secure networking**: TLS 1.3 encryption, SMB over QUIC, and advanced micro-segmentation to prevent lateral attack spread.

### Cloud agility anywhere

Get the power of Azure delivered to your edge and hybrid cloud environment with Azure Arc. Deploy with complete flexibility - in the cloud, in your datacenter, or hybrid at the edge.

- **Deployment flexibility**: Consistent Windows Server experience whether you deploy on-premises, hybrid, or in Azure with unified management.
- **Hotpatching**: Apply security updates without reboots - reducing from 12 required reboots per year to just 4 for enhanced productivity.
- **Azure Arc integration**: Azure Arc extends Azure's management capabilities to your on-premises servers, giving you cloud-style governance, security policies, and monitoring without moving your data whether they're in Azure, your datacenter, or other clouds.
- **Pay-as-you-go licensing**: Flexible, subscription-based pricing with Azure Arc.

### High-performance, future-ready infrastructure

Leaps ahead in scalability, performance, storage, and capabilities to support AI and ML.

- **AI and ML ready**: GPU partitioning across VMs with live migration support and enhanced performance for AI workloads and edge inferencing.
- **Massive scale**: Use Hyper-V to virtualize your workloads with support for up to 240-TB RAM and 2,048 virtual processors per VM for the most demanding workloads.
- **Storage optimization**: Enhanced ReFS with optimized deduplication and compression for software-defined storage.

For complete details on new features, see [What's new in Windows Server 2025](whats-new-windows-server-2025.md).

## Where can you deploy Windows Server?

Windows Server gives you the flexibility to choose where your applications and data live based on your business needs. Each deployment option offers unique advantages to help power your organization's growth and innovation. You can deploy Windows Server in the cloud, in your datacenter, or as a hybrid solution at the edge across different environments.

:::image type="content" source="media/overview/deploy.png" alt-text="A diagram showing three deployment options for Windows Server: cloud deployment with Azure VMs, on-premises datacenter deployment, and hybrid edge deployment with Azure Arc connectivity.":::

Deploy Windows Server:

- **☁️ In the cloud**

   Deploy Windows Server virtual machines in Azure for maximum scalability and global reach. Perfect for new applications, development environments, or when you need to scale quickly.

   **Best for**: New projects, variable workloads, global applications, and disaster recovery scenarios.

- **🏢 In your datacenter**

   Upgrade your existing infrastructure to Windows Server for complete control over your environment. Ideal when you have specific compliance requirements, existing hardware investments, or need air-gapped environments.

   **Best for**: Regulated industries, existing infrastructure, specialized hardware requirements, and complete data control.

- **🌐 Hybrid at the edge**

   Extend your datacenter to Azure with Azure Arc while keeping workloads running locally. Get the best of both worlds - local performance with cloud management and services.

   Keep sensitive workloads on-premises for compliance, performance, or cost reasons while gaining cloud management, monitoring, and services through Azure Arc. Perfect for organizations that need cloud benefits without full cloud commitment or data residency concerns.

   **Best for**: Gradual cloud adoption, distributed locations, edge computing scenarios, and using existing investments while gaining cloud capabilities.

## Editions

Windows Server offers two editions designed for different scales and virtualization needs:

| Edition | Standard | Datacenter |
|---------|----------|------------|
| **Environments** | Physical servers or environments with limited virtualization needs | Highly virtualized environments and cloud scenarios |
| **Virtualization rights** | 2 virtual machines plus one Hyper-V host per license | Unlimited virtual machines plus one Hyper-V host per license |
| **Best for** | Small to medium deployments, specific workloads, cost-conscious environments | Large datacenters, cloud deployments, extensive virtualization |

Both editions include many of the same features and capabilites. For a detailed comparison, see:

- [Comparison of Windows Server editions](editions-comparison.md)
- [Comparison of locks and limits in Windows Server](locks-limits.md)

## Deployment approaches

Choose the right approach for implementing Windows Server based on your current environment and requirements:

| Approach | Description | Best For |
|----------|-------------|----------|
| **Clean install** | Install on new hardware or completely replace existing OS | New deployments, maximum performance, complex configurations |
| **In-place upgrade** | Upgrade while keeping settings, roles, and data | VMs, stable configurations, minimal downtime |
| **Migration** | Gradually move roles and features to new installations | Complex environments, mission-critical systems |
| **Cluster rolling upgrade** | Upgrade cluster nodes one at a time | Hyper-V clusters, Scale-Out File Server, strict SLAs |

For detailed step-by-step guidance on each approach, see [Installation, upgrade, and migration options](install-upgrade-migrate.md).

## Installation options

When installing Windows Server, choose between two options based on how you plan to manage your server:

| Installation Option | Server Core | Server with Desktop Experience |
|-------------------|---------------------------|-------------------------------|
| **Description** | Minimal installation without graphical interface. Managed via PowerShell, SConfig, or remote tools. Offers smaller footprint, reduced attack surface, and better performance. | Full installation with standard Windows desktop and all GUI management tools. Provides familiar interface and local graphical management. |
| **Best For** | Most server workloads, especially when using remote management | Servers requiring local GUI access or desktop-dependent applications |

Learn more about the differences and detailed guidance at [Server Core vs Server with Desktop Experience](install-options-server-core-desktop-experience.md).

## Manage Windows Server

Windows Server provides multiple management tools that scale from single servers to enterprise datacenters.

:::image type="content" source="media/overview/windows-admin-center.png" alt-text="A screenshot showing the Windows Admin Center management dashboard.":::

You can manage Windows Server using one or more of the following approaches:

**🌐 Windows Admin Center**: Modern, browser-based management for day-to-day server administration. Works locally or integrates with Azure portal for hybrid scenarios.

**☁️ Azure Arc**: Cloud-based management that extends Azure governance, security, and monitoring to servers anywhere - in your datacenter, other clouds, or edge locations.

**🔧 Local tools**: Traditional management including Server Manager (GUI administration), PowerShell (object-oriented command shell and scripting language), and Remote Server Administration Tools for direct server access and automation.

**🏢 System Center**: Enterprise-scale management for large datacenters requiring comprehensive monitoring, deployment, and configuration management.

Choose your management approach based on your environment size and cloud strategy. For detailed guidance, see [Windows Server management overview](../administration/overview.md).

## Windows Insider Program

The Windows Insider Program for Windows Server provides preview builds of Windows Server allowing you early access to learn, test, and help shape the future of Windows Server. To learn more, you can get started with the [Windows Insider Program for Windows Server](https://www.microsoft.com/windowsinsider/for-business-getting-started-server) and participate in the [Windows Server Insiders Community](https://techcommunity.microsoft.com/t5/windows-server-insiders/bd-p/WindowsServerInsiders).

## Get started with Windows Server

Ready to begin your Windows Server journey? Start with a free evaluation to test in your environment:

- [Download Windows Server 2025 evaluation](https://aka.ms/TryWS2025)
- [View system requirements](system-requirements.md)
- [Get upgrade guidance](https://aka.ms/HowToUpgradeWS)
- [Browse learning paths for Windows Server](/training/browse/?source=learn&terms=Windows%20Server&resource_type=learning%20path) to help learn new skills and accelerate your deployment with step-by-step guidance.

For the latest news on Windows Server, visit the [Windows Server blog](https://www.microsoft.com/windows-server/blog) to stay up to date on announcements, features, events, and other information from the Windows Server engineering teams. You can also visit the [Windows Server Community](https://techcommunity.microsoft.com/t5/windows-server/ct-p/Windows-Server) to share best practices, get the latest news, and learn from experts about Windows Server.
