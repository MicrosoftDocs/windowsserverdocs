---
title: Use Windows Admin Center to manage operating system updates with Azure Update Management
description: Use Windows Admin Center (Project Honolulu) to set up Azure Update Management to manage OS updates.
ms.topic: article
author: IngridAtMicrosoft
ms.author: wscontent
ms.date: 10/18/2021
---
# Use Windows Admin Center to manage operating system updates with Azure Update Management

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

[Learn more about Azure integration with Windows Admin Center.](./index.md)

Azure Update Management is a solution in Azure Automation that allows you to manage updates and patches for multiple machines from a single place, rather than on a per-server basis. With Azure Update Management, you can quickly assess the status of available updates, schedule installation of required updates, and review deployment results to verify updates that apply successfully. This is possible whether your machines are Azure virtual machines (VMs), hosted by other cloud providers, or on premises. [Learn more about Azure Update Management](/azure/automation/update-management/overview).

With Windows Admin Center, you can easily set up and use Azure Update Management to keep your managed servers up to date. If you don't already have a Log Analytics workspace in your Azure subscription, Windows Admin Center will automatically configure your server and create the necessary Azure resources in the subscription and location you specify. If you have an existing Log Analytics workspace, Windows Admin Center can automatically configure your server to consume updates from Azure Update Management.

To get started, go to the Updates tool in a server connection and select “Set up now”, and provide your preferences for the related Azure resources.

Once you've configured your server to be managed by Azure Update Management, you can access Azure Update Management by using the hyperlink provided in the Updates tool.

[Learn how to stop using Azure Update Management to update your server.](azure-monitor.md#disabling-monitoring)

Note that you must [register your Windows Admin Center gateway with Azure](./azure-integration.md) before setting up Azure Update Management.
