---
title: Managing System Insights
description: "Managing System Insights"
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
ms.date: 6/05/2018
---
# Managing System Insights

>Applies To: Windows Server Insider Preview build 17692 and later

In Windows Server 2019, System Insights exposes a variety of settings that can be configured for each capability, and these settings can be tuned to address the specific needs of your deployment. This topic describes how to manage the various settings for each capability through Windows Admin Center or PowerShell, providing basic PowerShell examples and Windows Admin Center screenshots to demonstrate how to adjust these settings. 


Though this section provides PowerShell examples, you can use the [System Insights PowerShell documentation](https://aka.ms/systeminsightspowershell) to see all of the cmdlets, parameters, and parameter sets within System Insights. 

## Viewing capabilities

To get started, you can list all of the available capabilities using the **Get-InsightsCapability** cmdlet: 

```PowerShell
Get-InsightsCapability
``` 
These capabilities are also visible in System Insights extension:

![Overview page of System Insights listing available capabilities](media/overview-page.png)

## Enabling and disabling a capability
Each capability can be enabled or disabled. Disabling a capability prevents that capability from being invoked, and for non-default capabilities, disabling a capability stops all data collection for that capability. By default, all capabilities are enabled, and you can check the state of a capability using the **Get-InsightsCapability** cmdlet. 

To enable or disable a capability, use the **Enable-InsightsCapability** and the **Disable-InsightsCapability** cmdlets:

```PowerShell
Enable-InsightsCapability -Name "CPU capacity forecasting"
Disable-InsightsCapability -Name "Networking capacity forecasting"
``` 
These settings can also be toggled by selected a capability in Windows Admin Center clicking the **Enable** or **Disable** buttons.

### Invoking a capability
Invoking a capability immediately runs the capability to retrieve a prediction, and administrators can invoke a capability any time by clicking the **Invoke** button in Windows Admin Center or by using the **Invoke-InsightsCapability** cmdlet:

```PowerShell
Invoke-InsightsCapability -Name "CPU capacity forecasting"
```

>[!TIP]
>To make sure invoking a capability doesn't conflict with critical operations on your machine, consider scheduling predictions during off-business hours.

## Retrieving capability results
Once a capability has been invoked, the most recent results are visible using **Get-InsightsCapability** or **Get-InsightsCapabilityResult**. These cmdlets output the most recent **Status** and **Status Description** of each capability, which describe the result of each prediction. The **Status** and **Status Description** fields are further described in the [System Insights capability page](system-insights-capabilities.md). 

Additionally, you can use the **Get-InsightsCapabilityResult** cmdlet to view the last 30 prediction results and to retrieve the data associated with the prediction: 

```PowerShell
# Specify the History parameter to see the last 30 prediction results.
Get-InsightsCapabilityResult -Name "CPU capacity forecasting" -History

# Use the Output field to locate and then show the results of "CPU capacity forecasting."
$Output = Get-Content (Get-InsightsCapabilityResult -Name "CPU capacity forecasting").Output | ConvertFrom-Json
$Output.ForecastingResults
```
The System Insights extension automatically shows the prediction history and parses the results of the JSON result, giving you an intuitive, high-fidelity graph of each forecast:

![Single capability page showing a forecasting graph and the prediction history](media/cpu-forecasting.png)

## Setting a capability schedule
In addition to on-demand predictions, you can configure periodic predictions for each capability so that the specified capability is automatically invoked on a predefined schedule. Use the **Get-InsightsCapabilitySchedule** cmdlet to see capability schedules: 

>[!TIP]
>Use the pipeline operator in PowerShell to see information for all capabilities returned by the **Get-InsightsCapability** cmdlet.

```PowerShell
Get-InsightsCapability | Get-InsightsCapabilitySchedule
```

Periodic predictions are enabled by default though they can be disabled at any time using the **Enable-InsightsCapabilitySchedule** and **Disable-InsightsCapabilitySchedule** cmdlets:

```PowerShell
Enable-InsightsCapabilitySchedule -Name "Total storage consumption forecasting"
Disable-InsightsCapabilitySchedule -Name "Volume consumption forecasting"
```

Each default capability is scheduled to run every day at 3am. You can, however, create custom schedules for each capability, and System Insights supports a variety of schedule types, which can be configured using the **Set-InsightsCapabilitySchedule** cmdlet: 

```PowerShell
Set-InsightsCapabilitySchedule -Name "CPU capacity forecasting" -Daily -DaysInterval 2 -At 4:00PM
Set-InsightsCapabilitySchedule -Name "Networking capacity forecasting" -Daily -DaysOfWeek Saturday, Sunday -At 2:30AM
Set-InsightsCapabilitySchedule -Name "Total storage consumption forecasting" -Hourly -HoursInterval 2 -DaysOfWeek Monday, Wednesday, Friday
Set-InsightsCapabilitySchedule -Name "Volume consumption forecasting" -Minute -MinutesInterval 30 
```
>[!NOTE]
>Because the default capabilities analyze daily data, it's recommended to use daily schedules for these capabilities. Learn more about the default capabilities [here](system-insights-capabilities.md).

You can also use Windows Admin Center to view and set schedules for each capability by clicking **Settings**. The current schedule is shown on the **Schedule** tab, and you can use the GUI tools to create a new schedule:

![Settings page showing current schedule](media/schedule-page.png)

## Creating remediation actions
System Insights enables you to configure custom remediation scripts to automatically react to and remediate the issues detected by each capability. For each capability, you can configure a custom PowerShell script for each prediction status. Once a capability returns a prediction status, System Insights automatically invokes the associated script to help address the issue reported by the capability, allowing administrators to take corrective action automatically, rather than requiring manual intervention. 

The diagram below provides examples of sample remediation scripts for the total storage consumption forecasting capability, which helps you understand when your data will exceed your available disk space:

![Sample remediation actions for total storage consumption forecasting](media/remediation-actions.png)

You can see the actions for each capability using the **Get-InsightsCapabilityAction** cmdlet:

```PowerShell
Get-InsightsCapability | Get-InsightsCapabilityAction
```

You can create new actions or delete existing actions using the **Set-InsightsCapabilityAction** and **Remove-InsightsCapabilityAction** cmdlets. Each action is run using credentials that are specified in the **ActionCredential** parameter.

>[!NOTE]
>In the initial System Insights release, you must specify remediation scripts outside of user directories. This will be fixed in an upcoming release.

```PowerShell
$Cred = Get-Credential
Set-InsightsCapabilityAction -Name "CPU capacity forecasting" -Type Warning -Action "C:\Users\Public\WarningScript.ps1" -ActionCredential $Cred
Set-InsightsCapabilityAction -Name "CPU capacity forecasting" -Type Critical -Action "C:\Users\Public\CriticalScript.ps1" -ActionCredential $Cred

Remove-InsightsCapabilityAction -Name "CPU capacity forecasting" -Type Warning
```

You can also use Windows Admin Center to set remediation actions by using the **Actions** tab within the **Settings** page:

![Settings page where user can specify remediation actions](media/actions-page.png)


## Adding a new capability
In addition to the four default capabilities, System Insights also has an extensible platform that allows you to add new capabilities anytime using the **Add-InsightsCapability** cmdlet. 

Creating the default capabilities and the associated management interfaces required implementing new, valuable infrastructure in Windows Server, including local data collection and the capability management functionality described above. System Insights exposes this functionality directly to new capabilities, enabling these capabilities to:

- **Specify custom performance counters to collect and analyze.** This data can be any performance counter or ETW event, which will be collected, persisted locally, and returned to the capability for analysis when the capability is invoked. 
- **Leverage the existing System Insights PowerShell and Windows Admin Center management planes.** This includes using the custom scheduling and remediation actions functionality described above.

By exposing the existing data collection and management infrastructure, System Insights allows you to add your own capabilities that help you address the scenarios you care about.

>[!NOTE]
>Detailed developer documentation and sample capabilities will be available soon.

## See also
- [System Insights overview](system-insights-overview.md)
- [System Insights capabilities](system-insights-capabilities.md)
- [System Insights FAQ](system-insights-faq.md)
- [System Insights known issues](system-insights-known-issues.md)