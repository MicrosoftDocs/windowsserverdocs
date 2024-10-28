---
title: How to configure best practices assessment for Arc-enabled Windows servers (preview)
description: Learn how to deploy the best practices assessment tool to  evaluate your servers by identifying and providing guidance on areas for improvement for Arc-enabled Windows Servers and Azure VMs.
ms.topic: how-to
ms.author: alalve
author: trungtran
ms.date: 10/29/2024
---

# Configure best practices assessment for Arc-enabled Windows servers

The Best Practices Assessment (preview) tool continually scans your Windows Server to evaluate its configurations against Windows best practices. These assessments can be scheduled to run automatically or initiated manually as needed. The assessment evaluates several aspects of the Server environment, including server baselines, server security, Hyper-V, failover clusters, and Internet Information Services (IIS). It also collects and analyzes server data to generate a list of issues that require remediation guidance and best practices for improving the performance of your server infrastructure, including deploying applications, software updates, and operating systems.

The Best Practices Assessment (preview) tool installs the following three extensions on your device:

1. **Assessment Platform** - Deploys the Best Practices Assessment platform onto your machine. This extension serves as the platform for future development as new best practices assessment scenarios are introduced.

1. **Windows Server Assessment** - Contains all the necessary information about the validation checks that need to be run on your device to provide you with the recommendations you see in the Azure portal. Once the assessment is complete, the results are saved to a local log file.

1. **Azure Monitor Agent (AMA)** - Collects and uploads the log file to your log analytics workspace in the cloud, providing you with all the information in the Azure portal. Workbooks are used to visualize the results and provide you with an easier reading experience.

> [!NOTE]
>
> - Currently, there's no cost associated with using disaster recovery while in preview.
>
> - Best Practices Assessment tool handles security by running all checks locally on your server. The results are only uploaded to your designated Azure storage account, ensuring that everything happens within the context of your account.
>
> - The best practices assessment tool has to be installed on every server you desire to run it on.
>
> - Installing the required extensions on an Arc server via PowerShell isn't currently supported.

## Prerequisites

- Your device must be running an Arc-enabled on-premises Windows Server 2016 or later operating system with a minimum of 4 GB of memory.
- If you’re new to Azure Arc, see [Quickstart: Connect hybrid machines with Azure Arc-enabled servers](/azure/azure-arc/servers/learn/quick-enable-hybrid-vm) to onboard your device.

### Deploy Best Practices Assessment (preview)

To deploy disaster recovery, the Azure Site Recovery agent needs to be installed on your device. This involves creating or using a vault, a Hyper-V site, and a replication policy to prepare the infrastructure. Once these items are in place, the Azure Site Recovery agent is installed and associates the replication policy with the cluster node. To set disaster recovery in your environment, perform the following steps:

1. Navigate to [aka.ms/bpademo](https://aka.ms/bpademo) as this takes you to the landing page of the Azure portal with this feature flag enabled.
  
   > [!NOTE]
   > During the public preview phase, be aware that this functionality can only be accessed in the public cloud.

1. Navigate to a Windows Server 2016 or later Arc-enabled Windows Server resource. This virtual machine (VM) should be the Hyper-V host.
1. In the left pane, navigate to **Windows management**, then select **Best Practices Assessment (preview)**.
1. Select **Get Started** to access the **Best practices assessment configuration**.
1. Provide the **Resource group** and **Log Analytics Workspace** where results of the assessment are saved and then select **Set up**. Reminder that charges apply for the data that is stored in your log analytics workspace.

   > [!NOTE]
   > Installation times vary and might take up to 15 minutes. You can refresh the status by selecting the **Refresh** button on this page.

1. Once deployment is complete, select **Go to resource** and then select **Best Practices Assessment (preview)**.

Setting up Best Practices Assessment (preview) for the first time takes upward to 4 hours for the assessment to run and provide results.

Throughout the duration of the public preview, we're providing updates to enhance the experience. To update **Best Practices Assessment (preview)**, follow these steps:

1. Navigate to your resource.
1. In the left pane, expand **Settings** and select **Extensions**.
1. Select the **Update** button for any of the three available extensions:
   1. `AzureMonitorWindowsAgent`
   1. `assessmentplatform`
   1. `windowsserverassessment`

## Troubleshoot deployment

In the event where your deployment fails, **Your deployment failed** is displayed. If this error occurs, your extension needs to be reenabled. To correct this issue, follow these troubleshooting steps:

1. Navigate to your resource.
1. In the left pane, expand **Settings** and select **Extensions**.
1. In the **Name** column, where **windowsserverassessment** is displayed, follow this line to locate your version number under the **Version** row.
1. Remote into your server device and run the following command as admin:

   ```powershell
   cd C:\Packages\Plugics\microsoft.serviceshub.windowsserverassessment\<VersionNumber>

   scripts\\RunPs1.cmd Enable-Assessment
   ```

1. Once the script is complete, go to your Azure portal. Open your resource, select ***Best Practices Assessment (preview)**, and then select **Run assessment**.

## Submit tooling feedback

To report app feedback for the best practices assessment tool or if other issues are encountered, let us know via the Feedback Hub. To learn more, see [Submit tooling feedback](azure-arc-disaster-recovery-for-windows-server.md#submit-tooling-feedback). Under **Summerize your feedback**, type **Azure Arc BPA (preview)** and proceed with the remaining steps.
