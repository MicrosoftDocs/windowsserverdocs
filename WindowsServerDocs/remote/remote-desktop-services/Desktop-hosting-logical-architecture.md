---
title: Remote Desktop Services Architecture in Azure - Deployment Patterns and Best Practices
description: Explore proven Remote Desktop Services architecture patterns for Azure deployments. Learn basic and highly available RDS configurations with Azure PaaS integration.
ms.topic: concept-article
ai-usage: ai-assisted
ms.author: daknappe
author: dknappettmsft
ms.date: 07/07/2025
---

# Remote Desktop Services architecture

Remote Desktop Services (RDS) provides a flexible platform for hosting Windows applications and desktops in the cloud or on-premises. This article describes common RDS deployment architectures and shows how to integrate RDS with Azure services to meet your organization's needs.

Use these architecture diagrams to understand:

- How RDS roles work together in different deployment scenarios.
- Options for basic and highly available RDS configurations.
- Integration patterns with Azure Platform as a Service (PaaS) offerings.

Whether you're planning a new RDS deployment or modernizing an existing one, these architectures provide proven patterns to help you design a solution that meets your requirements for performance, availability, and security.

The architecture diagrams in this article show using RDS in Azure. However, as Remote Desktop Services is a role in Windows Server, you can deploy it on-premises and on other clouds. These diagrams are primarily intended to illustrate how the RDS roles are colocated and use other services.

## Standard RDS deployment architectures

Remote Desktop Services has two standard architectures:

- **Basic deployment**: contains the minimum number of servers to create a fully effective RDS environment, but with no redundancy.

- **Highly available deployment**: contains all necessary components to have the highest guaranteed uptime for your RDS environment.

The following sections show the components of each architecture and how they work together. The diagrams also show how the RDS roles are colocated on the servers, which is a common practice to reduce costs and complexity.

### Basic deployment

This architecture illustrates a foundational Remote Desktop Services deployment in Azure that provides remote access to desktops and applications through a single Azure region. The deployment uses an external load balancer to distribute incoming connections from the public internet across the RDS infrastructure.

The core RDS roles are distributed across multiple virtual machines within a single resource group. The RD Connection Broker (RDCB) and RD Licensing Server (RDLS) share one virtual machine, while the RD Gateway (RDGW) and RD Web Access (RDWeb) components are deployed on a separate VM. Supporting infrastructure includes an Active Directory domain controller and a file server for user profile disks and shared storage. The RD Session Host (RDSH) server, deployed on its own virtual machine, provides the actual desktop sessions and hosted applications to end users.

All virtual machines communicate through an Azure Virtual Network, which provides secure network connectivity between the RDS components while isolating the deployment from other Azure resources. This architecture provides a cost-effective starting point for organizations looking to migrate their desktop hosting to Azure, with the flexibility to scale individual components as usage grows.

:::image type="content" source="media/basic-rds.png" alt-text="Diagram showing a basic Remote Desktop Services deployment in Azure, with RDS roles distributed across virtual machines, an external load balancer, Active Directory domain controller, file server, and Azure Virtual Network connectivity.":::

### Highly available deployment

This architecture demonstrates a Remote Desktop Services deployment that integrates Azure Platform as a Service (PaaS) offerings to improve scalability and reduce management overhead. The key difference from a basic RDS deployment is the replacement of a traditional SQL Server virtual machine with Azure SQL Database for storing RDS configuration and user session data.

The RDS roles maintain the same distribution pattern, but with multiple instances of each; the RD Connection Broker (RDCB) and RD Licensing Server (RDLS) sharing one set of virtual machines, while the RD Gateway (RDGW) and RD Web Access (RDWeb) components are deployed on a separate set of VMs. The RD Session Hosts (RDSH) continue to provide desktop sessions and applications from their dedicated virtual machines. Supporting infrastructure includes an Active Directory domain controller and a file server for user profiles and shared storage.

By using Azure SQL Database instead of a self-managed SQL Server instance, this architecture provides built-in high availability, automatic backups, and simplified database management. The Azure SQL Database handles the RDS Connection Broker database requirements while eliminating the need to maintain, patch, and monitor a separate database server. This hybrid approach combines the flexibility of Infrastructure as a Service (IaaS) for the RDS roles with the managed benefits of PaaS for the database tier, resulting in reduced operational complexity and improved reliability.

:::image type="content" source="media/ha-rds.png" alt-text="Diagram showing a highly available Remote Desktop Services deployment in Azure, with multiple instances of RDS roles, Azure SQL Database for high availability, Active Directory domain controller, file server, and Azure Virtual Network connectivity.":::

## RDS architectures with unique Azure PaaS roles

Though the standard RDS deployment architectures fit most scenarios, Azure continues to invest in first-party PaaS solutions that drive customer value. The following architectures show how they incorporate with RDS.

### RDS deployment with Microsoft Entra Domain Services

The two standard architecture diagrams are based on a traditional Active Directory (AD) deployed on a Windows Server VM. However, if you don't have a traditional AD and only have a Microsoft Entra tenant, for example through services like Microsoft 365, but still want to use RDS, you can use [Microsoft Entra Domain Services](/azure/active-directory-domain-services/active-directory-ds-overview) to create a fully managed domain in your Azure IaaS environment that uses the same users that exist in your Microsoft Entra tenant. This option removes the complexity of manually syncing users and managing more virtual machines. Microsoft Entra Domain Services can work in either deployment: basic or highly available.

:::image type="content" source="media/aadds-rds.png" alt-text="Diagram showing a Remote Desktop Services deployment in Azure using Microsoft Entra Domain Services, with RDS roles distributed across virtual machines, managed domain services, Active Directory integration, and Azure Virtual Network connectivity.":::

### RDS deployment with Microsoft Entra application proxy

The two standard architecture diagrams use the RD Web/Gateway servers as the Internet-facing entry point into the RDS system. For some environments, administrators would prefer to remove their own servers from the perimeter and instead use technologies that also provide extra security through reverse proxy technologies. The [Microsoft Entra application proxy](/entra/identity/app-proxy/overview-what-is-app-proxy) PaaS role fits nicely with this scenario.

For supported configurations and how to create this setup, see [Publish Remote Desktop with Microsoft Entra application proxy](/azure/active-directory/application-proxy-publish-remote-desktop).

:::image type="content" source="media/aadappproxy-rds.png" alt-text="Diagram showing a Remote Desktop Services deployment in Azure using Microsoft Entra application proxy, with RDS roles distributed across virtual machines, application proxy integration, and Azure Virtual Network connectivity.":::
