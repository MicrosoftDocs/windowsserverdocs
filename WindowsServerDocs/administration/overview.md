---
title: Windows Server management overview
description: Learn about more about the different capabilities and solutions to manage Windows Server.
author: thomasmaurer
ms.author: thmaure
manager: carmencr
ms.reviewer: carmencr
ms.topic: overview
ms.date: 02/24/2022
---
# Windows Server management overview

Windows Server is the platform for building an infrastructure of connected applications, networks, and web services. As a Windows Server administrator, you've probably used many of the native Windows Server Microsoft Management Consoles (MMC) to keep your infrastructure secure and available. As the foundation of many on-premises, hybrid, and cloud native applications, the Windows Server teams have continued to invest in making the management and administration of your Windows Server instances easier by offering management tools like Azure Arc, Azure Automanage, Windows Admin Center, and System Center. These tools are designed to work together, and each have capabilities to meet you where you are in your server management needs.

<!--I don't think front-loading a summary into an image is the most accesible thing we can do, especially since the table beneath it is tied to it.-->

<!--Was this image somebody's attempt at creating a landing page? It looks like the links in the table beneath it were meant to be attached to each component of the diagram, which are styled to look like links you'd find on the landing pages.-->

:::image type="content" source="media/windows-server-management-overview.png" alt-text="Windows Server Management Overview":::

| Azure Arc + Azure Automanage | Windows Admin Center | System Center |
| --------------- | --------------- | --------------- |
| [Onboard server to Azure Arc](/azure/azure-arc/servers/learn/quick-enable-hybrid-vm) | [Download Windows Admin Center](https://www.microsoft.com/evalcenter/evaluate-windows-admin-center) | [Get System Center](https://www.microsoft.com/system-center)

## Cloud-based management using Azure Arc + Azure Automanage

Azure Arc-enabled servers let you manage your Windows and Linux physical servers and virtual machines (VMs) hosted outside of Azure on your corporate network or other cloud provider. We've designed this management experience to feel like managing native Azure virtual machines. You can manage, govern, and secure your Windows Servers with services such as Azure Policy, Microsoft Defender for Cloud, Azure Monitor, Azure Update Management, and more. When you use Azure Arc-enabled servers with Azure Automanage, you eliminate the need for service discovery, enrollment, configuration and monitoring of Azure services that follow server management guidelines.

| Details | Description |
| --------------- | --------------- |
| Scope | Limitless scale, Windows Server + Linux server |
| Interface | Web browser, REST APIs, command line tools |
| Disconnected mode | Limited support |
| Focus | At-scale governance, security, and monitoring as well OpEx reduction. |

### Example scenarios for Azure Arc and Azure Automanage

- You want to proactively monitor the OS and workloads running on the machine.
- Manage it using Automation runbooks or solutions like Update Management
- Secure your Windows Server using Microsoft Defender for Cloud.
- Govern your Windows Server machines using Azure Policy Guest Configuration
- Use Azure Automanage to automatically, enroll, configure and monitor Azure services that conform to server management best practices.

Learn more about Azure Arc-enabled server at [What is Azure Arc-enabled server](/azure/azure-arc/servers/overview) and Azure Automanage at [Azure Automanage machine best practices](/azure/automanage/automanage-virtual-machines).

## Deep Windows Server and cluster administration with Windows Admin Center

Windows Admin Center is a browser-based server administration tool set that lets you manage your Windows Servers. It can be locally deployed with no Azure or cloud dependency, or can be used directly integrated within the Azure portal. Windows Admin Center gives you full control over all aspects of your server infrastructure and is particularly useful for managing servers on private networks that are not connected to the Internet.

Windows Admin Center is the modern evolution of "in-box" management tools, like Server Manager and MMC, and complements other management solutions.

| Details | Description |
| --------------- | --------------- |
| Scope | Single Windows Server or hyperconverged clusters |
| Interface | Web browser |
| Disconnected mode | Supported |
| Focus | General server management, role configuration and troubleshooting |

### Example scenarios for Windows Admin Center

- Manage your servers and clusters with modernized versions of familiar tools such as Server Manager.
- Integration with Azure helps you optionally connect your on-premises servers with relevant cloud services in combination with Azure Arc.
- Streamline management of Azure Stack HCI or Windows Server hyperconverged clusters. Use simplified workloads to create and manage VMs, Storage Spaces Direct volumes, Software-Defined Networking and more.

Learn more about Windows Admin Center at [What is Windows Admin Center](../manage/windows-admin-center/understand/what-is.md).

## Datacenter-scale management with System Center

System Center allows you to stay in control of your IT infrastructure across your environment and platforms. It allows you to simplify the deployment, configuration, management, and monitoring of your infrastructure and virtualized software-defined datacenter, while increasing agility and performance.

| Details | Description |
| --------------- | --------------- |
| Scope | Entire datacenter (multi-server management) |
| Interface | GUI and command line tools |
| Disconnected mode | Supported |
| Focus | Day to day operations |

### Example scenarios for System Center

- Operations Manager provides infrastructure monitoring that is flexible and cost-effective, helps ensure the predictable performance and availability of vital applications, and offers comprehensive monitoring for your datacenter and private cloud.
- Data Protection Manager is a robust enterprise backup and recovery system that contributes to your Business Continuity/Disaster Recovery (BCDR) strategy by facilitating the backup and recovery of enterprise data.
- Virtual Machine Manager enables you to configure, manage and transform traditional datacenters, and helping to provide a unified management experience across on-premises and service provider for your virtualization workloads.

Learn more about System Center at [System Center Documentation](/system-center).

## Local management tools

Windows Server includes a number of tools to help you understand your Windows Server environment, manage specific servers, fine-tune performance, troubleshooting, and eventually automate many management tasks.

| Details | Description |
| --------------- | --------------- |
| Scope | Single to few servers |
| Interface | GUI and command line |
| Disconnected mode | Supported |
| Focus | General server management, role configuration and troubleshooting |

### Example scenarios of local management tools

- Server Manager is a management console in Windows Server that helps IT professionals provision and manage both local and remote Windows-based servers.
- All supported versions of Windows and Windows Server have a set of Win32 console commands built in. You can use these to automate tasks by using scripts or scripting tools.
- As a scripting language, PowerShell is commonly used for automating the management of Windows Server and other systems.
- Using Sconfig to manage Windows Server Core.

Learn more about local Windows Server management tools such as:

- [Server Manager](server-manager/server-manager.md)
- [PowerShell](/powershell/scripting/overview)
- [Windows Commands](windows-commands/windows-commands.md)
- [Remote Server Administration Tools](../remote/remote-server-administration-tools.md)
