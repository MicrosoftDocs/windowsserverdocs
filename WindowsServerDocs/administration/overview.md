---
title: Windows Server management overview
description: Learn about the various tools and solutions available to manage Windows Server effectively, including Azure Arc and Windows Admin Center.
author: meaghanlewis
ms.author: mosagie
manager: carmencr
ms.reviewer: carmencr
ms.topic: overview
ms.date: 04/16/2025
#customer intent: As an IT administrator, I want to understand Windows Server management tools so that I can choose the best solution for my organization.
---

# Windows Server management overview

Windows Server has many tools that let administrators connect applications, networks, and web services into an infrastructure. You should already be familiar with some of these tools, like the Windows Server Microsoft Management Console (MMC). However, it's important to be familiar with all the management tools Windows Server offers so you can choose which one is right for your organization.

On-premises, hybrid, and cloud-native infrastructures have complex and interconnected needs when it comes to management and administration. Windows Server has four management tools designed to meet the need of any infrastructure setup. The four main options for managing your Windows Server infrastructure are:

- [Azure Arc](#azure-arc)
- [Windows Admin Center](#windows-admin-center)
- [System Center](#system-center)
- [Local management tools](#local-management-tools)

This article walks you through each one, describing their capabilities, and gives you resources to download and configure them.

## Azure Arc

Azure Arc provides cloud-based management for servers. When you enable Azure Arc, you can manage physical servers running Windows, or Linux and virtual machines (VMs) even if they're hosted outside of Azure on your corporate network or another cloud provider. The management experience is seamless, so it feels like managing native Azure virtual machines. You can manage, govern, and secure your Windows Servers with services such as Azure Policy, Microsoft Defender for Cloud, Azure Monitor, and Azure Update Management.

Azure Automanage offers a unified solution to simplify IT management of Windows Server and Linux servers in Azure or in hybrid environments enabled by Azure Arc.

Here's a brief summary of the capabilities of Azure Arc and Azure Automanage:

- Scale across Windows and Linux servers.
- Provide web-based browser interface, REST API, and command-line tools.
- Offer limited support for disconnected mode.
- Focused on at-scale governance, security, monitoring, and reducing operating expenses.

### When to use Azure Arc

You can use Azure Arc and Azure Automanage when you want to:

- Monitor the operating system (OS) and workloads running on your machines.
- Manage your system using Automation runbooks or solutions like Update Management.
- Secure your Windows Server using Microsoft Defender for Cloud.
- Use Azure Policy Guest Configuration to govern your Windows Server machines.

### Azure Arc resources

Start setting up Azure Arc for your servers at [Connect hybrid machines with Azure Arc-enabled servers](/azure/azure-arc/servers/learn/quick-enable-hybrid-vm).

Otherwise, learn more about Azure Arc at [What is an Azure Arc-enabled server](/azure/azure-arc/servers/overview).

## Windows Admin Center

Windows Admin Center is a set of browser-based server administration tools that gives you full control over all aspects of your server infrastructure. It lets you configure deeper and more advanced administration features for your Windows Server and cluster deployments. You can locally deploy Windows Admin Center without using Azure or the cloud, or you can directly integrate it into the Azure portal. It's also useful for managing servers on private networks that aren't connected to the Internet.

Windows Admin Center is the modern evolution of in-box management tools, such as Server Manager and Microsoft Management Consoles (MMC), that complements other management solutions.

Here's a brief summary of the capabilities of Windows Admin Center:

- Covers single Windows Server deployments or hyperconverged clusters.
- Includes a web browser-based interface.
- Supports disconnected mode.
- Focused on general server management, role configuration, and troubleshooting.

### When to use Windows Admin Center

You can use Windows Admin Center when you want to:

- Manage your servers and clusters with modernized versions of familiar tools, such as Server Manager.
- Integrate your system with Azure to connect your on-premises servers with relevant cloud services with Azure Arc.
- Streamline management of Azure Local or Windows Server hyperconverged clusters.
- Use simplified workloads to create and manage VMs, Storage Spaces Direct volumes, Software-Defined Networking, and so on.

### More resources for Windows Admin Center

If you're interested in learning more about Windows Admin Center, see [What is Windows Admin Center](../manage/windows-admin-center/understand/what-is.md).

To get started using Windows Admin Center, [download Windows Admin Center](https://www.microsoft.com/evalcenter/evaluate-windows-admin-center), then follow [the installation instructions](../manage/windows-admin-center/deploy/install.md). Once you're set up, learn how to start using Windows Admin Center at [Get started with Windows Admin Center](../manage/windows-admin-center/use/get-started.md).

## System Center

System Center is for datacenter-scale management, and lets you control IT infrastructure across your environment and platforms. You can simplify deployment, configuration, management, and monitoring for infrastructure and virtualized software-defined datacenters. Using System Center can also increase your system's overall agility and performance.

Here's a brief summary of the capabilities of System Center:

- Covers the entire datacenter, or multi-server management.
- Includes both a GUI and command-line tools.
- Supports disconnected mode.
- Focused on day-to-day operations.

### When to use System Center

You can use System Center when you want to:

- Use Operations Manager for flexible, cost-effective, and comprehensive infrastructure monitoring for your datacenters and private cloud.
- Use Data Protection Manager for your enterprise's disaster recovery strategy.
- Use Virtual Machine Manager to create a unified management experience across both your on-premises datacenters and virtualized workloads.

### More resources for System Center

To get started using System Center, visit [the System Center website](https://www.microsoft.com/system-center). After that, start learning how to use its various features at our [System Center documentation](/system-center).

## Local management tools

Windows Server comes with many local tools that let you manage your environment. These tools include:

- Server Manager
- PowerShell
- Windows commands
- Remote Server Administration Tools (RSAT)

Use these tools to analyze your Windows Server environment, manage specific servers, fine-tune performance, troubleshoot issues, and automate management tasks.

Here's a brief summary of what the local management tools for your Windows Server environment can do:

- Covers single-server deployments and deployments with fewer servers.
- Includes a GUI and command-line interface.
- Support for disconnected mode.
- Focused on general server management, role configuration, and troubleshooting.

### When to use local management tools

You can use local management tools for Windows Server in the following situations:

- You're an IT professional who wants a straightforward management console to manage local and remote Windows servers.
- You want to use Win32 console commands to run scripts or scripting tools to automate tasks.
- You want to use PowerShell to automate management for Windows Server and other systems.
- You want to use SConfig to manage Windows Server Core.

### Related content

You can learn more about the various tools that comprise local management tools at the following articles:

- [Server Manager](server-manager/server-manager.md)
- [PowerShell](/powershell/scripting/overview)
- [Windows Commands](windows-commands/windows-commands.md)
- [Remote Server Administration Tools](../remote/remote-server-administration-tools.md)
