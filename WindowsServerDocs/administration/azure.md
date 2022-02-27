---
title: Windows Server and Azure Management
description: Learn how Microsoft Azure can extend Windows Server Management
author: thomasmaurer
ms.author: thmaure
manager: rclaus
ms.reviewer: rclaus
ms.topic: overview
ms.date: 02/27/2022
---
# Better together Windows Server and Azure Management

Windows Server together with Microsoft Azure cloud management capabilities allows you to get even more out of your Windows Server investments.

:::image type="content" source="media/windows-server-azure.png" alt-text="Windows Server Management Overview":::

## Cloud operations for Windows Server in a hybrid and multicloud environment

When you connect your machine to Azure, it enables the ability for you to perform the following operational functions as described in the following table.

|Operations function |Description | 
|--------------------|------------|
|**Govern** ||
| Azure Policy |Assign [Azure Policy guest configurations](../../governance/policy/concepts/guest-configuration.md) to audit settings inside the machine. To understand the cost of using Azure Policy Guest Configuration policies with Arc-enabled servers, see Azure Policy [pricing guide](https://azure.microsoft.com/pricing/details/azure-policy/)|
| Azure Tags |Use [tags](/azure/azure-resource-manager/management/tag-resources) to organize your Windows Servers and Azure resources and management hierarchy|
|**Protect** ||
| Microsoft Defender for Cloud | Protect non-Azure servers with [Microsoft Defender for Endpoint](/microsoft-365/security/defender-endpoint), included through [Microsoft Defender for Cloud](../../security-center/defender-for-servers-introduction.md), for threat detection, for vulnerability management, and to proactively monitor for potential security threats. Microsoft Defender for Cloud presents the alerts and remediation suggestions from the threats detected. |
| Microsoft Sentinel | Machines connected to Arc-enabled servers can be [configured with Microsoft Sentinel](scenario-onboard-azure-sentinel.md) to collect security-related events and correlate them with other data sources. |
| Azure Backup| Backup |
| Azure Site Recovery| DR |
|**Configure** ||
| Azure Automation |Automate frequent and time-consuming management tasks using PowerShell and Python [runbooks](../../automation/automation-runbook-execution.md).<br> Assess configuration changes about installed software, Microsoft services, Windows registry and files, and Linux daemons using [Change Tracking and Inventory](../../automation/change-tracking/overview.md).<br> Use [Update Management](../../automation/update-management/overview.md) to manage operating system updates for your Windows and Linux servers. |
| Azure Automanage (preview) | Automate onboarding and configuration of a set of Azure services when you use [Automanage Machine for Arc-enabled servers](../../automanage/automanage-arc.md).|
| VM extensions | Provides post-deployment configuration and automation tasks using supported [Arc-enabled servers VM extensions](manage-vm-extensions.md) for your non-Azure Windows or Linux machine. |
|**Monitor**|
| Azure Monitor | Monitor the connected machine guest operating system performance, and discover application components to monitor their processes and dependencies with other resources using [VM insights](../../azure-monitor/vm/vminsights-overview.md). Collect other log data, such as performance data and events, from the operating system or workload(s) running on the machine with the [Log Analytics agent](../../azure-monitor/agents/agents-overview.md#log-analytics-agent). This data is stored in a [Log Analytics workspace](../../azure-monitor/logs/design-logs-deployment.md). |
|**Extend and connect**|
| Azure Active Directory | Azure AD + Managed Identity |
| Azure Extended Network | . |
| Azure Network Adapter | . |
| Azure File Sync | . |
| Storage Replica | . |

Learn more about Azure Arc-enabled server at [What is Azure Arc-enabled server](/azure/azure-arc/servers/overview) and how to connect Windows Server to [Azure hybrid services using Windows Admin Center](../manage/windows-admin-center/azure/index.md).

## Cloud operations for Windows Server on Azure

When you run your machine in Azure, it enables the ability for you to perform the following operational functions as described in the following table.

|Operations function |Description | 
|--------------------|------------|
|**Govern** ||
| Azure Policy |Assign [Azure Policy guest configurations](../../governance/policy/concepts/guest-configuration.md) to audit settings inside the machine. To understand the cost of using Azure Policy Guest Configuration policies with Arc-enabled servers, see Azure Policy [pricing guide](https://azure.microsoft.com/pricing/details/azure-policy/)|
| Azure Tags |Use [tags](/azure/azure-resource-manager/management/tag-resources) to organize your Windows Servers and Azure resources and management hierarchy|
|**Protect** ||
| Microsoft Defender for Cloud | Protect non-Azure servers with [Microsoft Defender for Endpoint](/microsoft-365/security/defender-endpoint), included through [Microsoft Defender for Cloud](../../security-center/defender-for-servers-introduction.md), for threat detection, for vulnerability management, and to proactively monitor for potential security threats. Microsoft Defender for Cloud presents the alerts and remediation suggestions from the threats detected. |
| Microsoft Sentinel | Machines connected to Arc-enabled servers can be [configured with Microsoft Sentinel](scenario-onboard-azure-sentinel.md) to collect security-related events and correlate them with other data sources. |
| Azure Backup| Backup |
| Azure Site Recovery| DR |
| Azure confidential computing| CC |
|**Configure** ||
| Azure Automation |Automate frequent and time-consuming management tasks using PowerShell and Python [runbooks](../../automation/automation-runbook-execution.md).<br> Assess configuration changes about installed software, Microsoft services, Windows registry and files, and Linux daemons using [Change Tracking and Inventory](../../automation/change-tracking/overview.md).<br> Use [Update Management](../../automation/update-management/overview.md) to manage operating system updates for your Windows and Linux servers. |
| Azure Automanage (preview) | Automate onboarding and configuration of a set of Azure services when you use [Automanage Machine for Arc-enabled servers](../../automanage/automanage-arc.md). <br> Hotpatching is a new way to install updates on supported Windows Server Azure Edition virtual machines (VMs) that doesn’t require a reboot after installation <br> SMB over QUIC offers an "SMB VPN" for telecommuters, mobile device users, and branch offices, providing secure, reliable connectivity to edge file servers over untrusted networks like the Internet. To learn more about SMB over QUIC and how to configure SMB over QUIC, see SMB over QUIC.|
| VM extensions | Provides post-deployment configuration and automation tasks using supported [Arc-enabled servers VM extensions](manage-vm-extensions.md) for your non-Azure Windows or Linux machine. |
| Windows Admin Center in the Azure Portal | Windows Admin Center in the Azure Portal |
| VM Run Command | The Run Command feature uses the virtual machine (VM) agent to run PowerShell scripts within an Azure Windows VM.  |
|**Monitor**|
| Azure Monitor | Monitor the connected machine guest operating system performance, and discover application components to monitor their processes and dependencies with other resources using [VM insights](../../azure-monitor/vm/vminsights-overview.md). Collect other log data, such as performance data and events, from the operating system or workload(s) running on the machine with the [Log Analytics agent](../../azure-monitor/agents/agents-overview.md#log-analytics-agent). This data is stored in a [Log Analytics workspace](../../azure-monitor/logs/design-logs-deployment.md). |
|**Extend and connect**|
| Azure Active Directory | Azure AD + Managed Identity + Login|

Learn more about Windows Server on Azure at [Windows virtual machines in Azure](/azure/virtual-machines/windows/overview) and how to migrate Windows Server to Azure at [Azure Migrate](/azure/migrate/migrate-services-overview).
