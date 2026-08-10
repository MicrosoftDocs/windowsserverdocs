---
title: Install Network HUD for Windows Server (preview)
description: Install and enable Network HUD on Windows Server 2025 Datacenter clustered deployments.
author: robinharwood
ms.author: roharwoo
ms.reviewer: baselkablawi
ms.date: 11/17/2025
ms.topic: install-set-up-deploy
ai-usage: ai-assisted
ms.custom: references_regions
#customer intent: As a cluster administrator, I want to install and enable Network HUD so that I can surface proactive host networking health faults.
---

# Install Network HUD for Windows Server

> [!IMPORTANT]
> Network HUD for Windows Server is currently in PREVIEW.
> This information relates to a prerelease product that might be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

Network HUD is a cluster‑aware, intent‑driven host networking diagnostics tool that continuously analyzes adapters, links, and switch signals to surface actionable health faults early. This article explains how to enable Network HUD on an Azure Arc connected Windows Server 2025 Datacenter clustered deployment and how to view health faults using Windows Admin Center or PowerShell.

## Prerequisites

Before you install Network HUD, ensure you have the following prerequisites in place:

- Windows Server Failover Clustering requirements:
  - You have at least one node in the cluster.
  - Cluster nodes must be running Windows Server 2025 Datacenter.
  - Network ATC is deployed with host networking intents. To learn more about deploying Network ATC, see [Deploy host networking with Network ATC](/azure/azure-local/concepts/network-atc-overview?pivots=windows-server).
  - The cluster must have Storage Spaces Direct (S2D) enabled. To learn more about deploying Storage Spaces Direct, see [Deploy Storage Spaces Direct on Windows Server](../storage/storage-spaces/deploy-storage-spaces-direct.md).
  - Each cluster node has the `DataCenterBridging LLDP Tools` installed from the Remote Server Administration Tools feature.

- Azure Arc requirements:
  - Each cluster node must be connected to Azure Arc.
  - You must be eligible for Windows Server Management enabled by Azure Arc. To learn more about the availability of the Network HUD benefit, see [Windows Server Management enabled by Azure Arc](/azure/azure-arc/servers/windows-server-management-overview).
  - Network HUD is only available on machines in the following regions:
    - East US 2 EUAP
    - Central US EUAP
    - Central US
    - East US 2
    - East US
    - Canada Central
    - West US 2
    - North Europe
    - West Europe
    - Japan East
    - Southeast Asia
    - Australia East

- Network HUD for Windows Server has the same network switch requirements as Azure Local. When using Network HUD on Windows Server, ensure you're using validated physical switches for Azure Local and that the network switch requirements are met. To learn more, review the sections _**Network switches for Azure Local**_ and _**Network switch requirements**_ in [Physical network requirements for Azure Local](/azure/azure-local/concepts/physical-network-requirements). Other sections in the Physical network requirements for Azure Local article don't apply to Network HUD Windows. Server

## Enable the Network HUD extension in the Azure portal

To use the Azure portal to enable the Network HUD extension, follow these steps:

1. Navigate to the [Azure portal](https://portal.azure.com), then search for and select **Machines - Azure Arc**.

1. Select the machine you want to enable the Network HUD extension on.

1. Select the **Network HUD** tile.

   :::image type="content" source="media/install-network-hud/network-hud-azure-arc.png" alt-text="Screenshot of the Azure portal Machines - Azure Arc page showing the Network HUD extension tile before it's enabled.":::

1. When ready, select **Enable**.

1. Once the extension is successfully enabled, you see a confirmation message and the tile shows as **Enabled**.

## View health faults

To verify installation and view health faults, select your preferred method.

# [Windows Admin Center](#tab/windowsadmincenter)

To verify the installation and view health faults using Windows Admin Center, follow these steps:

1. Open Windows Admin Center and connect to your Windows Server 2025 Datacenter cluster.

1. In the Cluster view, either view alerts from the dashboard or select the notification bell icon on the top right corner.

   :::image type="content" source="media/install-network-hud/windows-admin-center-alerts.png" alt-text="Screenshot of Windows Admin Center cluster dashboard displaying active alerts including a Network HUD networking fault.":::

1. Look for alerts related to Network HUD. These alerts provide information about any detected host networking issues.

1. Select an alert to view more details and recommended actions for remediation.

   :::image type="content" source="media/install-network-hud/windows-admin-center-alert-detail.png" alt-text="Screenshot of Windows Admin Center fault detail pane for a Network HUD alert showing fields and recommended remediation actions.":::

Alerts automatically resolve themselves when the underlying issue is fixed.

# [PowerShell](#tab/powershell)

To verify the installation and view health faults using PowerShell, follow these steps:

1. Sign in to your administrative machine with an account that has the necessary permissions to access the Windows Server 2025 Datacenter cluster.

1. Open PowerShell and import the FailoverClusters module:

   ```powershell
   Import-Module FailoverClusters
   ```

1. Get the cluster object to connect to your cluster, replacing `<YourClusterName>` with the name of your cluster:

   ```powershell
   $cluster = Get-Cluster -Name "<YourClusterName>"
   ```

1. To get health faults related to Network HUD, run the following command:

   ```powershell
   Get-HealthFault -Cluster $cluster | Where Reason -like '*hud*'
   ```

1. The command output displays a list of Network HUD related health faults, including details about the issue and a recommended resolution. The following is an example output:

   ```powershell
   FaultId      : 1015
   
   Reason       : Network HUD detected incorrect VLAN configuration
   
   Severity     : Warning
   
   NodeName     : ClusterNode01
   
   Timestamp    : 11/04/2025 09:15:32
   
   Resolution   : Verify VLAN settings on NIC and switch ports
   ```

---
