---
title: "Known issues for Windows Admin Center Virtualization Mode (preview)"
description: "Track current known issues, limitations, causes, and workarounds for Windows Admin Center Virtualization Mode during preview."
author: robinharwood
ms.author: roharwoo
ms.topic: troubleshooting-known-issue
ms.date: 11/17/2025
#customer intent: As a virtualization operator or administrator, I want to quickly identify and mitigate known issues in Windows Admin Center Virtualization Mode so that I can maintain stability while evaluating the preview.
ai-usage: ai-assisted
---

# Known issues: Windows Admin Center Virtualization Mode

> [!IMPORTANT]
> Windows Admin Center Virtualization Mode is currently in PREVIEW.
> This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

This article lists current known issues and limitations for Windows Admin Center Virtualization Mode while it's in PREVIEW. It helps you identify symptoms, understand causes, and apply workarounds when resource onboarding or VM management behaves unexpectedly.

If you encounter issues not listed here, submit feedback from the portal or on a related docs page. This list will expand as new issues are validated.

| Issue | Description| Resolution summary |
|-------|------------------------------------|-------------------------|
| [Network ATC intent failure reports success](#resource-onboarding-reports-success-when-a-network-atc-intent-fails) | If a Network ATC intent fails to be created within the add resource workflow, the workflow might still succeed. | Verify adapters, VLAN, and QoS settings; review events; redeploy intent; ensure LLDP; re-add only after prerequisites |
| [Pending reboot after feature install](#required-reboot-after-feature-installation-not-handled-automatically) | If the Windows Server feature installation requires a reboot, Windows Admin Center doesn't handle the reboot during the add resource process. The add resource workflow succeeds even if a reboot is still required for the features to take effect. To continue, reboot the resources. | Detect pending reboot; restart hosts; verify feature state; retry incomplete intent steps |
| [Cluster onboarding fails repeatedly](#cluster-resource-onboarding-fails-repeatedly) | If the resource onboarding workflow fails for a cluster, you might need to install the required Windows Server features on every cluster node, reboot the nodes, and then try onboarding the cluster again. | Align feature installs; reboot nodes; verify health; retry onboarding |

## Resource onboarding reports success when a Network ATC intent fails

If a Network ATC network intent fails to be created within the add resource workflow, the workflow might still succeed.

**Resolution steps:**

To check and recreate the Network ATC network intent, perform the following steps.

1. Sign in to the Hyper-V host where you created the intent.

1. Open Event Viewer and navigate to **Applications and Services Logs** > **Microsoft** > **Windows** > **Networking-NetworkAtc** > **Admin** to review provisioning events for failures or warnings.

1. Check the provisioning status on each node by running `Get-NetIntentStatus`.

1. Resolve any identified issues, then follow one of these options to recreate the intent:

1. Re-create or redeploy the intent if required:

   - Rerun the Add resources workflow and create the intent again using the Networking tab in the Add Host workflow. For more information about the steps to add resources, see [Add resources in Windows Admin Center Virtualization Mode](add-virtualization-mode-resources.md).

   Or

   - To manually recreate the intent:

     1. Create a new intent using the PowerShell cmdlet `Add-NetIntent`. For more information about creating network intents, see [Deploy host networking with Network ATC](../../networking/network-atc/network-atc.md).

     1. Rerun the Add resources workflow and check the intent you created appears in the Networking tab. For more information about the steps to add resources, see [Add resources in Windows Admin Center Virtualization Mode](add-virtualization-mode-resources.md).

## Required reboot after feature installation not handled automatically

If the Windows Server feature installation requires a reboot, Windows Admin Center doesn't handle the reboot during the add resource process. The add resource workflow succeeds even if a reboot is still required for the features to take effect. To continue, reboot the resources.

**Resolution steps:**

To detect and complete required reboots and activate installed features, perform the following steps on the Hyper-V host.

1. To check whether a pending reboot is required, open an elevated PowerShell session and run the following command:

   ```powershell
   if (Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending') {
      Write-Host 'Pending reboot detected. Reboot before continuing.' -ForegroundColor Yellow
   } else {
      Write-Host 'No pending reboot detected.' -ForegroundColor Green
   }
   ```

1. Reboot the affected host or hosts.

1. After the restart, re-verify the installed features and re-run the Add resources. For more information about the steps to add resources, see [Add resources in Windows Admin Center Virtualization Mode](add-virtualization-mode-resources.md).

## Cluster resource onboarding fails repeatedly

If the resource onboarding workflow fails for a cluster, you might need to install the required Windows Server features on every cluster node, reboot the nodes, and then try to onboard the cluster again.

**Resolution steps:**

To align prerequisites across cluster nodes and retry resource onboarding, perform the following steps. Sign in to each cluster node to complete these steps.

1. Run PowerShell as an administrator on each node.

1. Validate the feature state with a single command:

   ```powershell
   $params = @{
      Name = @('Hyper-V','Failover-Clustering','Data-Center-Bridging','Network-ATC')
   }

   Get-WindowsFeature @params | Select-Object -Property Name, InstallState
   ```

1. Install any missing features by running the following commands:

   ```powershell
   Install-WindowsFeature Hyper-V -IncludeManagementTools
   Install-WindowsFeature Failover-Clustering
   Install-WindowsFeature Data-Center-Bridging
   Install-WindowsFeature Network-ATC
   ```

   To learn more about configuring these features, see:

   - Network ATC. For deployment guidance, see [Deploy host networking with Network ATC](../../networking/network-atc/network-atc.md).

   - Data Center Bridging. Included in the Network ATC guidance.

   - Hyper-V. For deployment guidance, see [Install Hyper-V](../../virtualization/hyper-v/get-started/Install-Hyper-V.md).

   - Failover Clustering. For more information about creating a cluster, see [Create a failover cluster](../../failover-clustering/create-failover-cluster.md).

1. Verify that all nodes are domain joined and that time synchronization is functioning correctly.

1. Validate cluster health with `Get-Cluster` and remediate any issues.

1. Re-run the resource onboarding workflow. To learn more about the steps to add resources, see [Add resources in Windows Admin Center Virtualization Mode](add-virtualization-mode-resources.md).

## Related information

- [Add resources in Windows Admin Center Virtualization Mode](add-virtualization-mode-resources.md)
- [Virtualization Mode overview](virtualization-mode-overview.md)
- [Manage virtual machines in Virtualization Mode](manage-virtualization-mode-virtual-machines.md)

---
