---
title: Add and develop capabilities in System Insights
description: System Insights enables you to add new predictive capabilities to System Insights, without requiring any OS updates. This enables developers, including Microsoft and third parties, to create and deliver new capabilities mid-release to address the scenarios you care about. New capabilities can specify custom data to collect and analyze, and they also integrate with the existing System Insights management planes.
ms.topic: concept-article
author: robinharwood
ms.author: roharwoo
ms.date: 06/06/2025
---

# Add and develop capabilities in System Insights

System Insights enables you to add new predictive capabilities to System Insights, without requiring any OS updates. This enables developers, including Microsoft and third parties, to create and deliver new capabilities mid-release to address the scenarios you care about.

Any new capability can integrate with and extend the existing System Insights infrastructure:

- New capabilities can **specify any performance counter or system event**, which are collected, persisted locally, and returned to the capability for analysis when the capability is invoked.
- New capabilities can **use the existing Windows Admin Center and PowerShell management planes**. Not only are new capabilities be discoverable in System Insights, they also benefit from custom schedules and remediation actions.

## Manage new capabilities

- [Learn](add-remove-update-capabilities.md) how to add, remove, and update capabilities using PowerShell.

## Develop a capability

Use the following resources to help you get started writing your own custom capabilities:

- [Learn](data-sources.md) about the data sources you can collect.
- [Download](https://www.nuget.org/packages/Microsoft.WindowsServer.SystemInsights/) the System Insights NuGet package, which contains the classes and interfaces you need to write a capability.
- [Read](/dotnet/api/microsoft.systeminsights.capability) the API documentation to learn about the System Insights classes and interfaces.
- [Use](https://aka.ms/systeminsights-samplecapability) the System Insights sample capability to help you get started. This shows you how to register a capability, specify the data sources to collect, and start analyzing system data.

## Related content

To learn more about System Insights, use the following resources:

- [System Insights overview](overview.md)
- [Understand capabilities](understanding-capabilities.md)
- [Manage capabilities](managing-capabilities.md)
- [Add, remove, and update capabilities](add-remove-update-capabilities.md)
- [System Insights FAQ](faq.md)
