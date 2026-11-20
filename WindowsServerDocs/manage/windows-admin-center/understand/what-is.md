---
title: What is Windows Admin Center
description: Learn what Windows Admin Center is, how its Administration and Virtualization modes work, and how it helps you manage Windows servers, clients, and clusters.
ms.topic: concept-article
author: davannaw-msft
ms.author: dawhite
ms.date: 08/07/2025
ai-usage: ai-assisted
---
# What is Windows Admin Center?

Windows Admin Center is a browser-based platform for managing Windows clients, servers, clusters, and virtualization infrastructure. It gives you a unified management experience for systems across on-premises, disconnected, and hybrid environments while complementing tools such as System Center.

Windows Admin Center provides two modes that share a platform core: **Administration Mode** for general system management and **Virtualization Mode** for centralized management of Hyper-V infrastructure at scale. You install each mode separately. This article explains how the modes work, where each mode fits, and how Windows Admin Center can improve your management environment.

![Diagram of Windows Admin Center working with other solutions](../media/wac-complements.png)

<a id="how-do-windows-admin-center-modes-work"></a>

## How Windows Admin Center Administration Mode works

In Administration Mode, Windows Admin Center runs in a web browser and connects directly to one managed system at a time through the **Windows Admin Center gateway**. Administration Mode manages Windows Server 2016 and later, Windows 11, Windows 10, and more. You can install its gateway on Windows Server or domain-joined Windows 10 or 11. The gateway manages servers by using Remote PowerShell and Windows Management Instrumentation (WMI) over Windows Remote Management (WinRM). A single lightweight .msi package, available from the [Windows Admin Center overview](../overview.md), includes the Administration Mode gateway.

After you publish the Administration Mode gateway to DNS and configure the corresponding corporate firewall rules, you can securely connect to and manage your servers from anywhere with Microsoft Edge or Google Chrome.

The **Administration Mode gateway** uses a .NET 10 backend for improved performance, security, and cryptography. It also includes support for HTTP/2, reducing latency and enhancing the responsiveness of Windows Admin Center.

:::image type="complex" source="../media/architecture.png" alt-text="Diagram of the Windows Admin Center Administration Mode gateway connecting a browser to managed nodes." lightbox="../media/architecture.png" border="false":::
Diagram of an on-premises Windows Admin Center Administration Mode deployment. A client connects from a modern browser to the Windows Admin Center web server and gateway over HTTPS. The gateway connects to managed nodes by using PowerShell and Windows Management Instrumentation (WMI) over Windows Remote Management (WinRM), and the managed nodes require no agent installation. The deployment doesn't require an internet connection. To access the gateway over the internet, publish it to DNS and configure the firewall. The diagram labels the installer as about 60 MB and says it installs in minutes.
:::image-end:::

<a id="administration-mode-architecture"></a>

## How the Windows Admin Center Administration Mode gateway works

The modernized Administration Mode gateway uses microservice architecture. Before this upgrade, the gateway performed all tasks in a single process. With this new model, one process starts with Administration Mode and serves as a process manager. As you use Administration Mode, the process manager starts more subprocesses to perform specific tasks.

Gateway plug-ins that are compatible with the modernized Administration Mode gateway also run their own collection of subprocesses under the Windows Admin Center service manager to perform their functions.

Changing from a monolithic service to a microservice model helps the modernized gateway be more flexible, scalable, and resilient.

<a id="kestrel-http-web-server"></a>

### Kestrel HTTP web server in the Administration Mode gateway

Previously, the Administration Mode gateway utilized [Katana](/aspnet/aspnet/overview/owin-and-katana) components, including a web server, on the backend. The modernized gateway uses an ASP.NET Core Kestrel web server.
[Kestrel](/aspnet/core/fundamentals/servers/kestrel) is the recommended web server for ASP.NET Core applications. Kestrel supports the HTTP/2 web protocol, where the Administration Mode gateway previously supported only HTTP/1.1 with the Katana components. The upgrade from HTTP/1.1 to HTTP/2 brings reduced latency to the application and increased responsiveness through features like multiplexing and server push.

<a id="virtualization-mode-architecture"></a>

## How the Windows Admin Center Virtualization Mode gateway works

Virtualization Mode uses a separate, centralized gateway and a stateful architecture. The gateway maintains a database, and local agents on managed Hyper-V hosts collect data and perform operations. This architecture supports persistent connections and parallel operations across virtualization infrastructure instead of the direct, per-session WinRM connections that Administration Mode uses. For more information, see [How Virtualization Mode works](../virtualization-mode-overview.md#how-it-works).

<a id="learn-how-windows-admin-center-improves-your-management-environment"></a>

## Windows Admin Center capabilities and integrations

### Familiar functionality

Windows Admin Center is the evolution of long-standing, well known management platforms like Microsoft Management Console (MMC), built from the ground up for the way systems are built and managed today. Windows Admin Center contains many of the familiar tools you currently use to manage Windows Servers and clients.

### Easy to install and use

[Install Administration Mode](../deploy/install.md) on a Windows computer to begin managing it locally, or install it on Windows Server as a gateway so that people in your organization can manage computers from their web browsers.

### Complements existing solutions

Windows Admin Center works with solutions like System Center and Azure management and security, adding to their capabilities to perform detailed, single-machine management tasks.

### Manage from anywhere

Publish your Administration Mode gateway server to the public Internet to securely connect to and manage your servers from anywhere.

### Enhanced security for your management platform

Administration Mode has many [security and user access options](../plan/user-access-options.md) that make your management platform more secure. Role-based access control lets you fine-tune which administrators have access to which management features. Administration Mode gateway authentication options include local groups, local domain-based Active Directory, and cloud-based Microsoft Entra ID. Also, [review event logs](../use/logging.md) to learn about management actions in your environment.

### Azure integration for on-premises and hybrid machines

Windows Admin Center has many points of [integration with Azure services](../azure/index.md), including Microsoft Entra ID, Azure Backup, Azure Site Recovery, and more.

### Windows Admin Center in Azure

By using Windows Admin Center in the Azure portal, you can manage the Windows Server operating system of your Azure Arc-enabled servers and Azure VMs.

You can securely manage your machines from anywhere–without needing a VPN, public IP address, or other inbound connectivity to your machine.

### Deploy hyper-converged and failover clusters

Windows Admin Center provides a wizard for deploying [hyperconverged infrastructure](../use/deploy-hyperconverged-infrastructure.md) and failover clusters.

### Manage hyper-converged clusters

Windows Admin Center offers the best experience for [managing hyper-converged clusters](../use/manage-hyper-converged.md) - including virtualized compute, storage, and networking components.

### Extensibility

Windows Admin Center was built with extensibility in mind from the beginning, with the ability for Microsoft and third party developers to build tools and solutions beyond the current  offerings. Microsoft offers an [SDK](../extend/extensibility-overview.md) that enables developers to build their own tools for Windows Admin Center.

> [!TIP]
> To install Windows Admin Center, [download Windows Admin Center](../overview.md).
