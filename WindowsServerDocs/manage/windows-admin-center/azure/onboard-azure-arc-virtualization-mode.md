---
title: Azure Arc Onboarding with Windows Admin Center
description: Azure Arc onboarding in Windows Admin Center Virtualization Mode lets you connect multiple managed machines to Azure at scale. Learn how to get started.
author: robinharwood
ms.author: roharwoo
ms.topic: how-to
ms.date: 11/05/2026
ai-usage: ai-generated
#customer intent: As a hybrid or virtualization administrator, I want to onboard multiple machines to Azure Arc from Windows Admin Center, so that I can connect my virtualization infrastructure to Azure at scale.
---

# Onboard machines to Azure Arc in Windows Admin Center Virtualization Mode

Azure Arc onboarding connects physical and virtual machines to Azure so you can manage them as Azure resources. In Windows Admin Center, use Virtualization Mode when you need to apply the same Azure configuration to multiple managed machines and monitor each machine's onboarding progress.

This article explains which workflow to use and shows you how to onboard multiple machines from Virtualization Mode. For Azure Arc administration after onboarding, use the Azure portal and the Azure Arc documentation.

## Choose an Azure Arc onboarding workflow in Windows Admin Center

Choose the workflow based on how you manage the target machines in Windows Admin Center.

| Windows Admin Center mode | Onboarding workflow | Use when |
| --- | --- | --- |
| Administration Mode | Start Azure Arc onboarding from the **Azure hybrid services** tool for an individual managed server. For the procedure, see [Connect hybrid machines to Azure from Windows Admin Center](/azure/azure-arc/servers/onboard-windows-admin-center). | You manage a server through an Administration Mode connection. |
| Virtualization Mode | Select multiple managed compute machines from the gateway-level **Azure Arc** tool, apply common Azure settings, and monitor a separate workflow for each machine. | You manage virtualization infrastructure and want to onboard machines in bulk. |

The Virtualization Mode workflow installs the Azure Connected Machine agent and connects each selected machine to Azure Arc. It doesn't provide general Azure Arc administration after the connection is complete.

## Prerequisites for Azure Arc onboarding in Virtualization Mode

- Windows Admin Center Virtualization Mode installed and available. For more information, see [Install Windows Admin Center Virtualization Mode](../deploy/install.md).
- Target machines added as compute resources in Virtualization Mode. For more information, see [Add resources in Windows Admin Center Virtualization Mode](../add-virtualization-mode-resources.md).
- A Windows Admin Center account with the **Gateway Administrator** role and local administrator permissions on each target machine.
- An Azure account with the [Azure Connected Machine Onboarding](/azure/role-based-access-control/built-in-roles#azure-connected-machine-onboarding) role for the Azure resource group where you want to create the machine resources.
- An Azure subscription and an existing resource group for the connected machine resources.
- Target machines that meet the [Azure Connected Machine agent prerequisites](/azure/azure-arc/servers/prerequisites), including a supported operating system, network connectivity, and Azure resource provider requirements.
- Public endpoint connectivity from the Azure Connected Machine agent on each target machine, either directly or through a proxy server. Private endpoint and Azure Arc gateway connectivity aren't available in this workflow.

## Onboard machines to Azure Arc

Select the machines and provide one set of Azure configuration values for the full selection.

1. From a web browser, open the Windows Admin Center Virtualization Mode gateway site and sign in.

1. If you aren't signed in to Azure, open the account menu, select **Sign in**, and complete the Microsoft sign-in flow.

1. Under **Gateway tools**, select **Azure Arc**.

1. In **Onboard to Azure Arc**, select each machine to onboard.

1. Select **Onboard to Azure Arc**.

1. In **Onboard machine(s) to Azure Arc**, confirm the machines and configure the following values:

   | Setting | Action |
   | --- | --- |
   | **Subscription** | Select the Azure subscription for the connected machine resources. |
   | **Azure resource group** | Select the existing resource group where you want Azure Arc to create the resources. |
   | **Region** | Select the Azure region where you want to store the resource metadata. |
   | **Cloud environment** | Select your Azure cloud environment. |
   | **Connectivity method** | Select **Public endpoint**. If the machines use a proxy, enter its URL in **Proxy server URL**. |
   | **Tags** | Optionally, add tags to the connected machine resources. |

1. Select **Onboard**.

Windows Admin Center starts an independent onboarding workflow for each selected machine. A machine might complete or fail without stopping the workflows for the other machines in the selection.

## Monitor Azure Arc onboarding status in Windows Admin Center

Use **Workflow status** to check progress and verify the result for each machine.

1. Select the **Workflow status** icon in the upper-right corner of Windows Admin Center.

1. Select a target with the **Azure Arc onboarding** action type.

   The details pane shows the status and completed or active workflow steps. A successful workflow goes through these steps:

   1. Download Azure Connected Machine agent.
   1. Install Azure Connected Machine agent.
   1. Connect machine to Azure Arc.
   1. Refresh Azure Arc status.

1. Review each selected target independently until its status is **Complete**. If a workflow fails, select that target to identify the failed step and review the available agent logs.

1. Close the **Workflow status** pane, and then select **Refresh** on the **Azure Arc** page.

   Successfully onboarded machines show a **Connected** status and their Azure resource group. You can also [verify the connected machines in the Azure portal](/azure/azure-arc/servers/onboard-windows-admin-center#verify-the-connection-with-azure-arc).

## Manage Azure Arc-enabled servers after onboarding

Azure Arc onboarding creates the connection to Azure, but it doesn't automatically enable management services on the connected machine. Choose the next task based on how you want to manage your servers:

- [Review Windows Server Management enabled by Azure Arc](/azure/azure-arc/servers/windows-server-management-overview) to check server and license eligibility and explicitly attest eligible servers for the included management benefits. Azure Arc automatically enrolls Windows Server pay-as-you-go servers.
- [Enable Hotpatch for Azure Arc-enabled servers](/windows-server/get-started/enable-hotpatch-azure-arc-enabled-servers) after you confirm that your servers meet the eligibility requirements.
- [Deploy updates on demand with Azure Update Manager](/azure/update-manager/quickstart-on-demand) to assess selected machines, install updates, and review the results.
- [Schedule recurring updates with Azure Update Manager](/azure/update-manager/scheduled-patching) to create maintenance configurations.
- [Enable Azure Change Tracking and Inventory at scale](/azure/azure-change-tracking-inventory/enable-change-tracking-at-scale-machines-blade) to monitor software, services, files, and registry changes across selected machines.
- [Plan your cloud-native server management next steps](/azure/azure-arc/servers/cloud-native/next-steps) to adopt Azure services incrementally and automate management across your environment.
