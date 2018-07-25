---
title: Adding and developing capabilities
description: "Adding and developing capabilities"
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: system-insights
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 
author: gawatu
ms.author: gawatu
manager: mallikarjun.chadalapaka
ms.date: 7/23/2018
---

# Adding and developing new capabilities

>Applies To: Windows Server Insider Preview build 17692 and later

System Insights enables you to add or create new predictive capabilities that can integrate with and extend the existing System Insights infrastructure. Any new capability can:

- **Specify custom system data to collect and analyze.** This data can be any performance counter or ETW event, which will be collected, persisted locally, and returned to the capability for analysis when the capability is invoked. 
- **Leverage the existing System Insights Windows Admin Center and PowerShell management planes.** Not only will new capabilities be discoverable in System Insights, they also benefit from custom schedules and remediation actions.

>[!IMPORTANT]
>Adding a new capability doesn't require any OS changes. **This means you can create or download new capabilities outside of Windows Server releases.** This functionality not only allows us to ship you new capabilities mid-release, but it also means you can create new capabilities that address the scenarios important to you.

## Manage new capabilities
- [Learn](add-remove-update-capabilities.md) how to add, remove, and update capabilities using PowerShell. 

## Develop a capability
Use the following resources to help you get started writing your own custom capabilities:
- [Learn](choosing-data-to-collect.md) about the data sources you can collect.
- [Download](https://www.nuget.org/packages/Microsoft.WindowsServer.SystemInsights/) the System Insights NuGet package, which contains the classes and interfaces you need to write a capability.
- Visit the API documentation to learn about the System Insights classes and interfaces. 
- [Use](https://microsoft.visualstudio.com/DefaultCollection/OS.Samples/_git/collections.classic) the System Insights sample capability to help you get started. This shows you how to register a capability, specify the data sources to collect, and start analyzing system data.

## See also

- [System Insights overview](system-insights-overview.md)
- [System Insights capabilities](system-insights-capabilities.md)
- [Managing System Insights](managing-system-insights.md)
- [System Insights FAQ](system-insights-faq.md)
- [System Insights known issues](system-insights-known-issues.md)