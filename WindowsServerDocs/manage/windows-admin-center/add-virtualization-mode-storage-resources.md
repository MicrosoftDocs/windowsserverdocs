---
title: Add Storage Resources to Windows Admin Center
description: Add storage resources in Windows Admin Center Virtualization Mode, including Windows Server clusters and non-Windows NAS or SAN systems.
author: robinharwood
ms.author: roharwoo
ms.topic: how-to
ms.date: 10/14/2026
ai-usage: ai-assisted
#customer intent: As an infrastructure operator, I want to add storage systems to Virtualization Mode so that I can manage storage resources and make them available to compute hosts.
---

# Add storage resources in Windows Admin Center Virtualization Mode

Windows Admin Center Virtualization Mode can manage storage from a Windows Server storage cluster or a non-Windows network-attached storage (NAS) or storage area network (SAN) system. Add these resources when you want to make their storage available to compute hosts through Virtualization Mode.

Use the **Storage** host profile to onboard either type of storage. For a Windows Server cluster, discover existing Scale-Out File Server roles and shares or create them during onboarding.

## Prerequisites

- Completion of [Install Windows Admin Center Virtualization Mode](deploy/install.md).
- An existing resource group. For creation steps and naming rules, see [Create a resource group](add-virtualization-mode-resources.md#create-a-resource-group).
- An account with the **Fabric Manager** role in Virtualization Mode.
- For Windows storage, a supported Windows Server failover cluster with:
  - Domain Name System (DNS) resolution for the cluster and every member node.
  - At least one online Internet Protocol version 4 (IPv4) cluster address.
  - Server Message Block (SMB) and Windows Remote Management (WinRM) connectivity from the Virtualization Mode gateway.
  - Membership in the local **Administrators** group on every cluster node.
- For existing or new Scale-Out File Server shares, Cluster Shared Volume (CSV)-backed paths that are available to the storage cluster.
- For non-Windows storage, a resolvable host name or Internet Protocol (IP) address for the NAS or SAN system.
- A resource that no other Virtualization Mode instance manages.

> [!IMPORTANT]
> A standalone Windows file server can't use the **Storage** host profile. Onboard its failover cluster instead. Don't mix Windows and non-Windows storage resources in one workflow.

## Add a Windows Server storage cluster

Onboard an existing Windows Server failover cluster to discover or create Scale-Out File Server roles and SMB shares.

1. In the resource pane, select the **ellipsis (...)** next to the resource group, and then select **Add resource**.

1. On the **Getting started** tab, complete the following actions:

   1. Select **Storage** for **Host profile**.

   1. Enter the cluster fully qualified domain name (FQDN).

   1. Select **Validate**.

      Validation discovers every cluster node, verifies the supported Windows Server configuration, checks DNS and SMB connectivity, confirms that you're an administrator on every node, and checks for an existing Virtualization Mode agent.

   1. After validation succeeds, select **Add**.

   1. Select **Next**.

1. On the **Clustering** tab, verify the discovered cluster and member nodes.

1. Select **Next**.

1. On the **Networking** tab, complete the following actions:

   1. Verify that a healthy Management intent exists or configure one.

      For Ethernet-based SMB storage, use a Storage intent. Existing intents must have a successful status and be symmetric across the cluster nodes.

   1. Select **Next**.

1. On the **Storage** tab, complete the following actions:

   1. Review the discovered **Scale-Out File Servers** and **Shares**.

   1. If you want to onboard only the existing storage configuration, continue without adding a file server or share.

   1. If you want to create a Scale-Out File Server role, complete the following actions:

      1. Select **Add file server**.

      1. Enter a unique file-server name.

      1. Add at least one share for each new file server, and then enter:

         - A unique SMB share name.
         - A CSV-backed path for the share.

         When you submit the deployment, the workflow installs the File Server feature when needed, creates the Scale-Out File Server role and SMB shares, and registers them in Virtualization Mode.

   1. If you change Scale-Out File Server roles or shares directly on the cluster, select **Refresh**.

   1. Select **Next**.

1. On the **Compute** tab, complete the following actions:

   For storage-cluster nodes, the **Compute** tab exposes only the setting that also applies to storage resources. **Remove non-essential features** removes payloads for unused Windows Server features from storage-cluster nodes.

   1. If you want to remove payloads for unused Windows Server features, select **Remove non-essential features**.

   1. Select **Next**.

1. On the **Review** tab, complete the following actions:

   1. Verify the cluster, networking, and storage configuration.

   1. Select **Submit**.

1. Open **Workflow status** to monitor agent deployment, feature installation, storage discovery, and optional Scale-Out File Server provisioning.

   If installation or updates require a restart, Virtualization Mode drains and restarts affected cluster nodes sequentially.

   If an interrupted workflow offers **Resume**, select it to continue.

   If a failed workflow offers **Retry**, select it to rerun the failed step. Retry is limited to three attempts.

1. Verify that the workflow status is **Completed** and that the storage resource appears in the navigation hierarchy.

   If you created a Scale-Out File Server role or shares, verify that they appear for the storage resource.

## Register non-Windows storage

Register a non-Windows NAS or SAN system as a standalone resource that uses the **Storage** host profile.

1. In the resource pane, select the **ellipsis (...)** next to the resource group, and then select **Add resource**.

1. On the **Getting started** tab, select **Storage** for **Host profile**.

1. Enter the resolvable host name or IP address of the storage system.

1. Select **Validate**.

1. After validation succeeds, select **Add**.

1. Verify that the **Clustering** tab lists the resource as standalone.

1. Select **Next**.

1. On the **Networking** tab, confirm that Virtualization Mode doesn't require a Network ATC intent for the resource.

1. Select **Next**.

1. On the **Storage** tab, review the registered storage resource.

1. Select **Next**.

1. On the **Compute** tab, confirm that no compute settings are available.

1. Select **Next** to open the **Review** tab.

1. Verify the configuration.

1. Select **Submit**.

1. Open **Workflow status** and monitor the registration.

1. Verify that the workflow status is **Completed** and that the storage resource appears in the navigation hierarchy.

Virtualization Mode registers non-Windows storage without installing the Windows agent. Automatic SMB permission and constrained-delegation configuration aren't available for non-Windows storage.

<a id="remove-a-storage-resource"></a>

## Clean up storage resources

Remove a storage resource when you no longer want Virtualization Mode to manage it.

1. In the resource pane, select the ellipsis (**...**) next to the resource.

1. Select **Remove resource** for a standalone non-Windows resource or **Remove cluster** for a Windows Server storage cluster.

1. Select **Remove** to confirm.

1. Open **Workflow status** and monitor the removal.

1. Verify that the workflow status is **Completed** and that the resource no longer appears in the navigation hierarchy.

For Windows storage, removal uninstalls the Virtualization Mode agents, removes their certificates and deployment files, and unregisters the storage cluster. Removing the resource from Virtualization Mode doesn't delete its Scale-Out File Server roles, shares, or stored data.

## Next step

> [!div class="nextstepaction"]
> [Add compute resources in Windows Admin Center Virtualization Mode](add-virtualization-mode-resources.md)
