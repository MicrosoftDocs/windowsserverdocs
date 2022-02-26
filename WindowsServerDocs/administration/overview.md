---
title: Windows Server Management
description: Learn about more about your different Windows Server Management capabilities and solutions.
author: thomasmaurer
ms.author: thmaure
manager: rclaus
ms.reviewer: rclaus
ms.topic: overview
ms.date: 02/24/2022
---
# Windows Server Management

Lorem Ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

:::image type="content" source="media/windows-server-management-overview.png" alt-text="Windows Server Management Overview":::

| Azure Arc | Windows Admin Center | System Center |
| --------------- | --------------- | --------------- |
| [Onboard server to Azure Arc](/azure/azure-arc/servers/learn/quick-enable-hybrid-vm) | [Download Windows Admin Center](https://www.microsoft.com/evalcenter/evaluate-windows-admin-center) | [Get System Center](https://www.microsoft.com/system-center)

## Cloud-based management using Azure Arc

Azure Arc-enabled servers enables you to manage your Windows and Linux physical servers and virtual machines hosted outside of Azure, on your corporate network, or other cloud provider. This management experience is designed to be consistent with how you manage native Azure virtual machines. This allows you to manage, govern, and secure your Windows Servers with services such as Azure Policy, Microsoft Defender for Cloud, Azure Monitor, Azure Update Management, and more.

| Details | Description |
| --------------- | --------------- |
| Scope | limitless scale, Windows Server + Linux server |
| Interface | web browser, REST APIs, command line tools |
| Disconnected mode | limited support |
| Focus | at-scale governance, security, and monitoring |

### Example scenarios for Azure Arc

- You want to proactively monitor the OS and workloads running on the machine.
- Manage it using Automation runbooks or solutions like Update Management
- Secure your Windows Server using Microsoft Defender for Cloud.
- Govern your Windows Server machines using Azure Policy Guest Configuration

Learn more about Azure Arc-enabled server at [What is Azure Arc-enabled server](/azure/azure-arc/servers/overview).

## Deep Windows Server and cluster management with Windows Admin Center

Windows Admin Center is a locally-deployed, browser-based management tool set that lets you manage your Windows Servers with no Azure or cloud dependency. Windows Admin Center gives you full control over all aspects of your server infrastructure and is particularly useful for managing servers on private networks that are not connected to the Internet.

Windows Admin Center is the modern evolution of "in-box" management tools, like Server Manager and MMC, and complements other management solutions.

| Details | Description |
| --------------- | --------------- |
| Scope | single Windows Server or hyperconverged clusters |
| Interface | web browser |
| Disconnected mode | supported |
| Focus | general server management, role configuration and troubleshooting |

### Example scenarios for Windows Admin Center

- Manage your servers and clusters with modernized versions of familiar tools such as Server Manager.
- Integration with Azure helps you optionally connect your on-premises servers with relevant cloud services in combination with Azure Arc.
- Streamline management of Azure Stack HCI or Windows Server hyperconverged clusters. Use simplified workloads to create and manage VMs, Storage Spaces Direct volumes, Software-Defined Networking and more.

Learn more about Windows Admin Center at [What is Windows Admin Center](../manage/windows-admin-center/understand/what-is.md).

## Datacenter-scale management with System Center

System Center allows you to stay in control of your IT infrastructure across your environment and platforms. It allows you to simplify the deployment, configuration, management, and monitoring of your infrastructure and virtualized software-defined datacenter, while increasing agility and performance.

| Details | Description |
| --------------- | --------------- |
| Scope | entire datacenter (multi-server management) |
| Interface | GUI and command line tools |
| Disconnected mode | supported |
| Focus | day to day operations |

### Example scenarios for System Center

- Operations Manager provides infrastructure monitoring that is flexible and cost-effective, helps ensure the predictable performance and availability of vital applications, and offers comprehensive monitoring for your datacenter and private cloud.
- Data Protection Manager is a robust enterprise backup and recovery system that contributes to your BCDR strategy by facilitating the backup and recovery of enterprise data.
- Virtual Machine Manager enables you to configure, manage and transform traditional datacenters, and helping to provide a unified management experience across on-premises and service provider for your virtualization workloads.

Learn more about System Center at [System Center Documentation](/system-center).

## Local Management Tools

Windows Server includes a number of tools to help you understand your Windows Server environment, manage specific servers, fine-tune performance, troubleshooting, and eventually automate many management tasks.

| Details | Description |
| --------------- | --------------- |
| Scope | single to few servers |
| Interface | GUI and command line |
| Disconnected mode | supported |
| Focus | general server management, role configuration and troubleshooting |

### Example scenarios Local Management Tools

- Server Manager is a management console in Windows Server that helps IT professionals provision and manage both local and remote Windows-based servers.
- All supported versions of Windows and Windows Server have a set of Win32 console commands built in. This set of documentation describes the Windows Commands you can use to automate tasks by using scripts or scripting tools.
- As a scripting language, PowerShell is commonly used for automating the management of Windows Server and other systems.

Learn more about local Windows Server management tools such as:

- [Server Manager](server-manager/server-manager.md)
- [PowerShell](/powershell/scripting/overview)
- [Windows Commands](windows-commands/windows-commands.md)
- [Remote Server Administration Tools](../remote/remote-server-administration-tools.md)
