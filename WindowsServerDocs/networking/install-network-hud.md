---
title: Install Network HUD on Windows Server clusters
description: Install Network HUD on Azure Arc-enabled Windows Server 2025 Datacenter cluster nodes, verify initialization, and view active health faults.
author: robinharwood
ms.author: roharwoo
ms.reviewer: baselkablawi
ms.date: 11/17/2026
ms.topic: install-set-up-deploy
ai-usage: ai-assisted
#customer intent: As a cluster administrator, I want to install Network HUD on each cluster node and verify initialization so that I can view host networking health faults.
---

# Install Network HUD for Windows Server

Network HUD is a host networking diagnostics tool that identifies configuration and operational conditions in physical Windows Server clusters. It helps cluster administrators investigate network reliability issues by correlating host and physical network information that they otherwise need to gather separately.

In this article, you install Network HUD on each Azure Arc-enabled machine in a Windows Server 2025 Datacenter cluster, verify detection initialization, and view active cluster health faults.

## Prerequisites for installing Network HUD

- A failover cluster with at least two physical machines that meet the [Storage Spaces Direct hardware requirements](../storage/storage-spaces/storage-spaces-direct-hardware-requirements.md). Network HUD doesn't support installation on virtual machines.
- Windows Server 2025 Datacenter installed on each cluster node.
- Hyper-V role and management tools installed on each cluster node.
- Network ATC configured with host networking intents. For more information, see [Network ATC overview](/azure/azure-local/concepts/network-atc-overview?pivots=windows-server).
- Storage Spaces Direct enabled. For more information, see [Deploy Storage Spaces Direct on Windows Server](../storage/storage-spaces/deploy-storage-spaces-direct.md).
- Data Center Bridging and Link Layer Discovery Protocol (LLDP) tools installed on each cluster node.
- Each cluster node connected to Azure Arc and enrolled in Windows Server Management enabled by Azure Arc. For more information, see [Windows Server Management enabled by Azure Arc](/azure/azure-arc/servers/windows-server-management-overview). Network HUD doesn't support offline installation.
- Validated physical switches that meet the applicable **Network switches for Azure Local** and **Network switch requirements** in [Physical network requirements for Azure Local](/azure/azure-local/concepts/physical-network-requirements).
- Connected physical switch ports that advertise the LLDP information required for the cluster nodes' traffic roles. Network HUD uses these advertisements for physical-network checks.
- The Azure Connected Machine Resource Administrator role, Contributor role, or a custom role with equivalent permissions on each Azure Arc-enabled server resource.
- Administrative access to the cluster nodes for local PowerShell checks.
- Access to a Windows Admin Center instance that can manage the cluster for the Windows Admin Center procedure.

## Install Network HUD on each cluster node

The Azure Arc extension installs the Network HUD service and PowerShell module. It doesn't configure the prerequisites.

1. In the [Azure portal](https://portal.azure.com), search for and select **Machines - Azure Arc**.

1. Select a cluster node.

1. On the node's **Overview** page, under **Capabilities**, select the **Network HUD** tile.

   :::image type="content" source="media/install-network-hud/network-hud-azure-arc.png" alt-text="Screenshot of an Azure Arc-enabled server Overview page in the Azure portal, with Capabilities selected and Network HUD marked Not Configured." lightbox="media/install-network-hud/network-hud-azure-arc.png" loc-scope="azure":::

1. Select **Enable**.

1. Wait until the Azure Arc extension operation succeeds and the **Network HUD** tile reports **Enabled**.

1. Repeat these steps for every cluster node. Install the extension on each Azure Arc-enabled machine, rather than once per cluster.

## Verify Network HUD extension deployment

In the Azure portal, verify the extension deployment on every cluster node.

1. Open each node's Azure Arc resource.

1. Under **Settings**, select **Extensions**, and then inspect the Network HUD extension deployment status.

1. If a deployment failed, review its error details before retrying the deployment.

## Verify Network HUD initialization

Perform these checks locally on every cluster node.

1. Open PowerShell as an administrator.

1. Verify that the `NetworkHUD` service is running:

   ```powershell
   Get-Service -Name NetworkHUD
   ```

1. Verify that the Network HUD PowerShell module is available:

   ```powershell
   Get-Module -ListAvailable -Name Az.StackHCI.NetworkHUD
   ```

1. Use `Get-WinEvent` to query events 105, 106, and 111 in the `Microsoft-Windows-Networking-NetworkHUD/Operational` log since the current service start time:

   ```powershell
   $service = Get-CimInstance -ClassName Win32_Service -Filter "Name = 'NetworkHUD'"
   $serviceStartTime = (Get-Process -Id $service.ProcessId).StartTime

   Get-WinEvent -FilterHashtable @{
       LogName      = 'Microsoft-Windows-Networking-NetworkHUD/Operational'
       ProviderName = 'Microsoft-Windows-Networking-NetworkHUD'
       Id           = 105, 106, 111
       StartTime    = $serviceStartTime
   } -MaxEvents 20 |
       Select-Object TimeCreated, Id, LevelDisplayName, Message
   ```

1. Verify that the current service startup has event 105, which confirms initialization, and event 111, which confirms that Network HUD loaded scenarios. Event 106 reports an initialization failure.

A running service confirms only that the service started. It doesn't confirm that Network HUD detections initialized.

## View active Network HUD health faults

After you confirm initialization, view active health faults by using Windows Admin Center or PowerShell.

# [Windows Admin Center](#tab/windowsadmincenter)

1. Open Windows Admin Center and connect to your Windows Server 2025 Datacenter cluster.

1. In the cluster view, view alerts on the dashboard or select the notification bell icon.

   :::image type="content" source="media/network-hud/windows-admin-center-alerts.png" alt-text="Windows Admin Center cluster dashboard displaying active alerts, including a Network HUD networking fault." lightbox="media/network-hud/windows-admin-center-alerts.png":::

1. Look for Network HUD alerts.

1. Select an alert to view its details and recommended actions.

   :::image type="content" source="media/install-network-hud/windows-admin-center-alert-detail.png" alt-text="Windows Admin Center fault detail pane for a Network HUD alert showing fields and recommended remediation actions.":::

Network HUD clears an alert after it no longer detects the underlying condition.

Clearing an alert doesn't mean that Network HUD automatically repaired the underlying issue.

# [PowerShell](#tab/powershell)

1. Open PowerShell as an administrator on a cluster node.

1. Import the Failover Clusters module:

   ```powershell
   Import-Module FailoverClusters
   ```

1. Get active cluster health faults for Network HUD:

   ```powershell
   Get-HealthFault | Where-Object Reason -like '*HUD*'
   ```

Run the command once on any cluster node. An empty result means that the query returned no active Network HUD health faults. It doesn't confirm that Network HUD detections initialized.

---

## Troubleshoot Network HUD installation and initialization failures

Troubleshoot locally on the affected node.

1. If you can't enable Network HUD, review extension errors in the Azure portal and logs on the affected node.

1. Verify that the required Windows features are installed, Network ATC intents are configured, Storage Spaces Direct is enabled, the node is connected to Azure Arc, and Windows Server Management enabled by Azure Arc enrollment is active.

1. Import the Network HUD PowerShell module:

   ```powershell
   Import-Module Az.StackHCI.NetworkHUD
   ```

1. Review recent Network HUD Operational events for service initialization and scenario loading:

   ```powershell
   Get-NetHUDLog -OperationalLog
   ```

1. Review recent Network HUD Diagnostic events for scenario results:

   ```powershell
   Get-NetHUDLog -ContentLog
   ```

   Diagnostic event 102 reports scenario success, and event 103 reports scenario failure. These diagnostic events aren't cluster health faults.

1. If you can't import the `Az.StackHCI.NetworkHUD` module, investigate the extension deployment status and Azure Arc extension logs.

1. If the extension deployment failed, follow [Troubleshoot Azure Arc-enabled servers VM extension issues](/azure/azure-arc/servers/troubleshoot-vm-extensions).

Don't treat a running service, an empty health-fault query, or missing log output as evidence that initialization succeeded. Review Operational events 105, 106, and 111 to determine initialization status.

## Next steps

- [Network HUD overview](network-hud-overview.md)
