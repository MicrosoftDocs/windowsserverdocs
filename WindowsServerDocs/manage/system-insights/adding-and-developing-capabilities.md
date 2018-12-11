---
title: Adding and developing capabilities
description: "System Insights enables you to add new predictive capabilities to System Insights, without requiring any OS updates. This enables developers, including Microsoft and third parties, to create and deliver new capabilities mid-release to address the scenarios you care about. New capabilities can specify custom data to collect and analyze, and they also integrate with the existing System Insights management planes."
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
ms.date: 7/31/2018
---

# Adding and developing new capabilities

>Applies To: Windows Server 2019

System Insights enables you to add new predictive capabilities to System Insights, without requiring any OS updates. This enables developers, including Microsoft and third parties, to create and deliver new capabilities mid-release to address the scenarios you care about. 

Any new capability can integrate with and extend the existing System Insights infrastructure:

- New capabilities can **specify any performance counter or system event**, which will be collected, persisted locally, and returned to the capability for analysis when the capability is invoked.  
- New capabilities can **leverage the existing Windows Admin Center and PowerShell management planes**. Not only will new capabilities be discoverable in System Insights, they also benefit from custom schedules and remediation actions. 

## Manage new capabilities
- [Learn](add-remove-update-capabilities.md) how to add, remove, and update capabilities using PowerShell. 

## Develop a capability
Use the following resources to help you get started writing your own custom capabilities:
- [Learn](data-sources.md) about the data sources you can collect.
- [Download](https://www.nuget.org/packages/Microsoft.WindowsServer.SystemInsights/) the System Insights NuGet package, which contains the classes and interfaces you need to write a capability.
- [Visit](https://aka.ms/systeminsights-api) the API documentation to learn about the System Insights classes and interfaces. 
- [Use](https://aka.ms/systeminsights-samplecapability) the System Insights sample capability to help you get started. This shows you how to register a capability, specify the data sources to collect, and start analyzing system data.

>[!NOTE]
>This is prerelease functionality. It's subject to change, as we add new functionality and incorporate feedback.

## See also
To learn more about System Insights, use the following resources:

- [System Insights overview](overview.md)
- [Understanding capabilities](understanding-capabilities.md)
- [Managing capabilities](managing-capabilities.md)
- [Adding, removing, and updating capabilities](add-remove-update-capabilities.md)
- [System Insights FAQ](faq.md)