---
title: How to configure disaster recovery for Arc-enabled Windows Servers (preview)
description: Learn how to deploy the disaster recovery tool to manage and orchestrate replication, failover, and failback for on-premises Arc-enabled Windows Servers and Azure VMs.
ms.topic: how-to
ms.author: alalve
author: trungtran
ms.date: 10/26/2024
---

# How to configure disaster recovery for Arc-enabled Windows Servers (preview)

The disaster recovery tool is designed to manage and coordinate the replication, failover, and failback processes for on-premises and Azure virtual machines (VMs) running on Arc-enabled Windows Server operating system (OS). During this public preview, the tool is only compatible with Hyper-V enabled machines. This ensures that your on-premises workloads remain operational during outages by replicating them to Azure as a secondary location.

With this feature, you won't need to manually install the agent or link it to the Recovery Service Vault, Hyper-V site, or replication policy as this tool takes care of these tasks.

> [!NOTE]
> This experience does not include an Azure storage account by default. You're required to either create a new Azure storage account or use an existing one under your Azure subscription.

The key benefits of using the disaster recovery tool are:

- Currently, there is no cost associated with using disaster recovery while in preview.

- Handles security by running all checks locally on your server. The results are only uploaded to your designated Azure storage account, ensuring that everything happens within the context of your account.

> [!NOTE]
>
> - The disaster recovery tool has to be installed on every server you desire to use it on.
> - Installing the Azure Site Recovery (ASR) agent extension on an Arc server via PowerShell isn't currently supported.

## Prerequisites

- Your device must be running Windows Server 2016 or later with a minimum of 4 GB of memory.
- Azure Arc must be installed and configured on your device.
- The Windows Server **Hyper-V** role must be installed. To learn more, see [Install or Uninstall Roles, Role Services, or Features](/windows-server/administration/server-manager/install-or-uninstall-roles-role-services-or-features).

  *Alternatively*, users can run the following command in an elevated PowerShell window:

  ```powershell
  Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
  ```

### Deploy disaster recovery (preview)

To deploy disaster recovery, the ASR agent needs to be installed on your device. This involves creating or using a vault, a Hyper-V site, and a replication policy to prepare the infrastructure. Once these items are in place, the ASR agent will be installed and associates the replication policy with the cluster node. To set disaster recovery in your environment, perform the following steps:

1. Navigate to [aka.ms/drpreview](aka.ms/drpreview) as this will take you to the landing page of the Azure Portal with this feature flag set to enabled.
  
   > [!NOTE]
   > During the public preview phase, be aware that this functionality can only be accessed in the public cloud.

1. Navigate to a Windows Server 2016 or later Arc-enabled Windows Server resource. This VM should be the Hyper-V host.
1. In the left pane, navigate to **Windows management**, then select **Disaster recovery (preview)**.
1. Select **Protect VM workloads** to access the **Replicate VMs to Azure** page.
1. Under **Step 1: Prepare infrastructure**, select **Prepare infrastructure**.
1. On the **Prepare infrastructure** page, the following needs to created unless they already exist:
   1. A vault for the infrastructure.
   1. A Hyper-V site.
   1. A replication policy.
1. Once infrastructure preparations are complete, and the ASR extension is successfully installed on the node, you'll see the **Status: Infrastructure prepared successfully** pop up notification.
1. Lastly, select **Enable replication**.

> [!NOTE]
> Preparing and installing the infrastructure agent can take up to 7 minutes. You can refresh the status by selecting the **Refresh** button on this page. Refreshing will navigate you back to the **Replicate VMs to Azure** page.

## Known issues

As disaster recovery is in preview, users may experience technical issues during the deployment process. To mitigate certain issue's, perform the following:

- **Issue**: You encounter the error:

  ```error
  Installing ASR extension...

  Could not complete the operation.
  undefined: undefined
  ```

- **Solution**: This is a transient error. Navigate to **Windows management > Disaster recovery (preview) > Protect VM workloads** and check the status of your infrastructure under **Step 1: Prepare infrastructure**.

- **Issue**: You encounter the following PowerShell error:

  ```error
  Extension failed to install. Extension returned non-zero exit code for Install: 1. Extension error output: std error: C:\Packages\Plugins\Microsoft.SiteRecovery.Dra.Windows\1.0.0.6\script\InstallAsr.ps1 : Hyper-V is not installed.
    + CategoryInfo          : NotSpecified: (:) [Write-Error], WriteErrorException
    + FullyQualifiedErrorId : Microsoft.PowerShell.Commands.WriteErrorException,InstallAsr.ps1

  Extension Error: C:\Packages\Plugins\Microsoft.SiteRecovery.Dra.Windows\1.0.0.6\script\InstallAsr.ps1 : Hyper-V is not installed.
    + CategoryInfo          : NotSpecified: (:) [Write-Error], WriteErrorException
    + FullyQualifiedErrorId : Microsoft.PowerShell.Commands.WriteErrorException,InstallAsr.ps1
  ```

- **Solution**: This error indicates that Hyper-V may not be installed on your VM. Run the following PowerShell command with admin rights:

  ```powershell
  Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
  ```

## Submit additional feedback

To report app feedback for disaster recovery or if other issues are encountered, let us know via the Feedback Hub by performing the following actions:

1. Run the following PowerShell command as admin on your device to collect error logs in `.zip` format:

   ```powershell
   azcmagent logs -o "C:\ArcDisasterRecovery\azcmagent-logs.zip"
   ```

1. Open the [Feedback Hub](aka.ms/feedbackhub) on your device.

1. Under **Summerize your feedback**, type **Azure Arc disaster recovery (preview)**.

1. Under **Explain in more detail (optional)**, provide us:

   1. The Windows Server OS and edition you're managing.

   1. Detailed instructions on how to reproduce the error encountered.

1. Under **Choose a category**, select **Problem**, select **Windows Server** from the drop-down list, select **Management** from the secondary drop-down list, then select **OK**.

1. Under **Find similar feedback**, see if other users have submitted a similar issue. Then select **Next**.

1. Under **Add more details** and **Which of the following best describes your problem?**, select the most appropriate option per your case.

1. Under **Attachments (optional)**, provide us:

   1. A screenshot of the issue.

   1. Attach the **azcmagent-logs.zip** file.

1. Lastly, select **Submit** and we'll review your feedback.
