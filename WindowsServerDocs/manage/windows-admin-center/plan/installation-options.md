---
title: What type of installation is right for you
description: What type of installation is right for you Windows Admin Center (Project Honolulu). Install on a failover cluster for high availability and resiliency.
ms.technology: manage
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.date: 04/23/2018
ms.localizationpriority: low
ms.prod: windows-server-threshold
---

# What type of installation is right for you?

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows 10

## Supported operating systems: Installation

You can install Windows Admin Center on the following Windows operating systems:

| **Version** | **Installation Type** |
|-------------|-----------------------|
|Windows 10 (1709) | Desktop mode |
|Windows Server, version 1709 | Gateway mode |
|Windows Server 2016 | Gateway mode |

**Desktop installation:** Connect to the Windows Admin Center gateway from the same computer on which it's installed (i.e. `https://localhost:[port]`)

**Gateway service:** Connect to the Windows Admin Center gateway from a client browser on a different machine (i.e. `https://servername`) 

## Supported operating systems: Management

You can use Windows Admin Center to manage the following Windows operating systems:

| **Version** | **Managed node** via Server Manager | **Managed cluster** via Failover Cluster Mgr | **Managed HCI cluster** via HCI Cluster Mgr (preview)|
|-------------------------|---------------|-----|------------------------|
| Windows 10 Fall Creators Update (1709) or newer | Yes (via Computer Management) | N/A | N/A |
| Windows Server 2019 (insider builds) | Yes | Yes | Yes |
| Windows Server, version 1709 | Yes | Yes | No |
| Windows Server 2016 | Yes | Yes | Yes, with [latest cumulative update](../use/manage-hyper-converged.md#prepare-your-windows-server-2016-cluster-for-windows-admin-center) |
| Windows Server 2012 R2 | Yes | Yes | N/A |
| Windows Server 2012 | Yes | Yes | N/A |

> [!NOTE]
> Windows Admin Center requires PowerShell features that are not included in Windows Server 2012 and 2012 R2. If you will manage Windows Server 2012 or 2012 R2 with Windows Admin Center, you will need to install Windows Management Framework (WMF) version 5.1 or higher on those servers.

>Type `$PSVersiontable` in PowerShell to verify that WMF is installed,
and that the version is 5.1 or higher. 

>If WMF is not installed, you can [download WMF 5.1](https://www.microsoft.com/en-us/download/details.aspx?id=54616).

## Deployment options

<table>
    <tr>
        <td style="vertical-align: top; align: center">
            <img src="../media/deployment-options-1.png" height="250" alt="Diagram of Windows 10 desktop installation"> 
        </td>
        <td style="vertical-align: top; align: center">
            <img src="../media/deployment-options-3.png" height="250" alt="Diagram of managed server installation"> 
        </td>
        <td style="vertical-align: top; align: center">
            <img src="../media/deployment-options-2.png" height="250" alt="Diagram of designated gateway server installation"> 
        </td>
        <td style="vertical-align: top; align: center">
            <img src="../media/deployment-options-4.png" height="250" alt="Diagram of high availability deployment"> 
        </td>
    </tr>
    <tr>
        <td style="vertical-align: top;">
Install on a local Windows 10 client that has connectivity to the managed servers.  Great for quick start, testing, ad-hoc or small scale scenarios.
        </td>
        <td style="vertical-align: top;">
Install directly on a managed server for the purpose of managing itself or a cluster in which it's a member node.
        </td>
        <td style="vertical-align: top;">
Install on a designated gateway server and access from any client browser with connectivity to the gateway server.
        </td>
        <td style="vertical-align: top;">
Deploy in a failover cluster to enable high availability of the gateway service. Great for production environments to ensure resiliency of your management service.
        </td>
    </tr>
</table>

## High availability
You can enable high availability of the gateway service by deploying Windows Admin Center in a active-passive model on a failover cluster. If one of the nodes in the cluster fails, Windows Admin Center gracefully fails over to another node, letting you continue managing the servers in your environment seamlessly.

[Learn how to deploy Windows Admin Center with high availability.](../deploy/high-availability.md)

> [!Tip]
> Ready to install Windows Admin Center? [Download now](https://aka.ms/WACDownload)