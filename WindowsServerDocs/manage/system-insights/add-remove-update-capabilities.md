---
title: Adding, removing, and updating capabilities
description: "System Insights enables you to create new capabilities that leverage the existing data collection and management functionality. It's important that you also have the platform support to manage the addition, removal, and updates of these capabilities. This topic describes the high-level functionality to add, remove, and update capabilities in System Insights."
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

# Adding, removing, and updating capabilities

>Applies To: Windows Server 2019

System Insights enables you to create new capabilities that leverage the existing data collection and management functionality. Once these capabilities are created, however, it's equally important that you also have the platform support to manage the addition, removal, and updates of these capabilities. 

This topic describes the high-level functionality to add, remove, and update capabilities in System Insights. 

## Adding a capability
System Insights allows you to add new capabilities anytime using the **Add-InsightsCapability** cmdlet. The **Add-InsightsCapability** requires you to specify a capability name and the capability library. The capability library contains the capability description, data sources, and prediction logic.

```PowerShell
Add-InsightsCapability -Name "Sample capability" -Library "C:\SampleCapability.dll"
```

After a capability has been added to System Insights, you can immediately invoke and manage the capability using PowerShell or Windows Admin Center. 

## Updating a capability
System Insights also enables you to update a capability using the **Update-InsightsCapability** cmdlet.

```PowerShell
Update-InsightsCapability -Name "Sample capability" -Library "C:\SampleCapabilityv2.dll"
```

Updating a capability allows you to specify a new capability library, which allows you to change the capability description, the data sources, and the prediction logic associated with that capability. Importantly, updating a capability preserves all configuration and historical information about that capability, including custom schedules, actions, and historical prediction results. 

## Removing a capability
You can also remove capabilities in System Insights using the **Remove-InsightsCapability** cmdlet. 

```PowerShell
Remove-InsightsCapability -Name "Sample capability" 
```
>[!NOTE]
>The default forecasting capabilities can't be removed.

Removing a capability permanently deletes the capability and all associated information, including the schedule, any remediation actions, and past prediction results. 

>[!TIP]
>Consider disabling a capability rather than removing it if you are worried about permanently deleting all information associated with the capability. 

## See also
To learn more about System Insights, use the following resources:

- [System Insights overview](overview.md)
- [Understanding capabilities](understanding-capabilities.md)
- [Managing capabilities](managing-capabilities.md)
- [Adding and developing capabilities](adding-and-developing-capabilities.md)
- [System Insights FAQ](faq.md)