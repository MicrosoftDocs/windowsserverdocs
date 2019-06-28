---
title: What type of installation is right for you
description: This topic describes the different installation options for Windows Admin Center, including installing on a Windows 10 PC or a Windows server for use by multiple admins. 
ms.technology: manage
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.localizationpriority: medium
ms.prod: windows-server-threshold
ms.date: 06/07/2019
---
# What type of installation is right for you?

>Applies To: Windows Admin Center, Windows Admin Center Preview

This topic describes the different installation options for Windows Admin Center, including installing on a Windows 10 PC or a Windows server for use by multiple admins. To install Windows Admin Center on a VM in Azure, see [Deploy Windows Admin Center in Azure](../azure/deploy-wac-in-azure.md).

## Supported operating systems: Installation

You can **install** Windows Admin Center on the following Windows operating systems:

| **Version**  | **Installation mode** |
| -------------| -----------------------|
| Windows 10, version 1709 or newer | Desktop mode |
| Windows Server Semi-Annual Channel | Gateway mode |
| Windows Server 2016 | Gateway mode |
| Windows Server 2019 | Gateway mode |

**Desktop mode:** Launch from the Start Menu and connect to the Windows Admin Center gateway from the same computer on which it's installed (i.e. `https://localhost:6516`)

**Gateway mode:** Connect to the Windows Admin Center gateway from a client browser on a different machine (i.e. `https://servername.contoso.com`) 

> [!WARNING]
> Installing Windows Admin Center on a Domain controller is not supported. [Read more about Domain controller security best practices](https://docs.microsoft.com/windows-server/identity/ad-ds/plan/security-best-practices/securing-domain-controllers-against-attack). 

> [!IMPORTANT]
> You can't use Internet Explorer to manage Windows Admin Center - instead you need to use a [supported browser](../understand/faq.md#which-web-browsers-are-supported-by-windows-admin-center
).  If you are installing Windows Admin Center on Windows Server, we recommend managing by connecting remotely with Windows 10 and Edge.  Alternatively, you can manage locally on Windows Server if you have installed a supported browser.

## Supported operating systems: Management

You can **manage** the following Windows operating systems using Windows Admin Center:

| Version | Manage *node* via *Server Manager* | Manage *cluster* via *Failover Cluster Manager* | Manage *HCI* via *HCI Cluster Manager* |
| ------------------------- |--------------- | ----- | ------------------------ |
| Windows 10, version 1709 or newer | Yes (via Computer Management) | N/A | N/A |
| Windows Server Semi-Annual Channel | Yes | Yes | N/A |
| Windows Server 2019 | Yes | Yes | Yes |
| Windows Server 2016 | Yes | Yes | Yes, with [latest cumulative update](../use/manage-hyper-converged.md#prepare-your-windows-server-2016-cluster-for-windows-admin-center) |
| Microsoft Hyper-V Server 2016 | Yes | Yes | N/A |
| Windows Server 2012 R2 | Yes | Yes | N/A |
| Microsoft Hyper-V Server 2012 R2 | Yes | Yes | N/A |
| Windows Server 2012 | Yes | Yes | N/A |
| Windows Server 2008 R2 | Yes, limited functionality | N/A | N/A |

> [!NOTE]
> Windows Admin Center requires PowerShell features that are not included in Windows Server 2008 R2, 2012, and 2012 R2. If you will manage these with Windows Admin Center, you will need to install Windows Management Framework (WMF) version 5.1 or higher on those servers.
> 
> Type `$PSVersiontable` in PowerShell to verify that WMF is installed,
> and that the version is 5.1 or higher. 
> 
> If WMF is not installed, you can [download WMF 5.1](https://www.microsoft.com/en-us/download/details.aspx?id=54616).

## Deployment options

| ![img](../media/deployment-options/W10.png) | ![img](../media/deployment-options/gateway.png) | ![img](../media/deployment-options/node.png) | ![img](../media/deployment-options/HA.png) |
| --------------------------------------------- | ------------------------------------------------- |----------------------------------------------|-------------------------------------------- |
|                                             |                                                 |                                              |                                            |

| Local Client | Gateway Server | Managed Server | Failover Cluster |
| --- | --- | --- | --- |
| Install on a local Windows 10 client that has connectivity to the managed servers.  Great for quick start, testing, ad-hoc or small scale scenarios. |Install on a designated gateway server and access from any client browser with connectivity to the gateway server.  Great for large-scale scenarios. | Install directly on a managed server for the purpose of managing itself or a cluster in which it's a member node.  Great for distributed scenarios. | Deploy in a failover cluster to enable high availability of the gateway service. Great for production environments to ensure resiliency of your management service. |

## High availability

You can enable high availability of the gateway service by deploying Windows Admin Center in a active-passive model on a failover cluster. If one of the nodes in the cluster fails, Windows Admin Center gracefully fails over to another node, letting you continue managing the servers in your environment seamlessly.

[Learn how to deploy Windows Admin Center with high availability.](../deploy/high-availability.md)

> [!Tip]
> Ready to install Windows Admin Center? [Download now](https://aka.ms/windowsadmincenter)
