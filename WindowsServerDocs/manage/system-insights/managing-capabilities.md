---
title: Manage System Insights capabilities in Windows Admin Center
description: Learn how to manage System Insights capabilities in Windows Admin Center or PowerShell. Adjust settings for each capability to optimize your deployment.
ms.topic: how-to
author: robinharwood
ms.author: roharwoo
ms.date: 06/04/2025
---
# Manage System Insights capabilities in Windows Admin Center

System Insights capabilities can be managed and configured to meet your deployment needs. This article explains how to adjust settings for each capability using Windows Admin Center or PowerShell, with step-by-step examples and screenshots.

This article provides some PowerShell examples, you can use the [System Insights PowerShell documentation](/powershell/module/systeminsights/) to see all of the cmdlets, parameters, and parameter sets within System Insights.

## View capabilities

### [PowerShell](#tab/PowerShell)

You can list all of the available capabilities using the **Get-InsightsCapability** cmdlet:

```PowerShell
Get-InsightsCapability
```

![Screenshot of using the Get-InsightsCapability cmdlet in PowerShell.](media/get-insights-capability.png)

### [Windows Admin Center](#tab/windows-admin-center)

These capabilities are also visible in System Insights extension:

[ ![Screenshot of System Insights extension and the available capabilities in Windows Admin Center.](media/system-insights-overview.png) ](media/system-insights-overview.png#lightbox)

---

## Enable and disable a capability

Each capability can be enabled or disabled. Disabling a capability prevents that capability from being invoked, and for non-default capabilities, disabling a capability stops all data collection for that capability. By default, all capabilities are enabled, and you can check the state of a capability before changing it.

### [PowerShell](#tab/PowerShell)

To enable a capability, use the **Enable-InsightsCapability** cmdlet:

```PowerShell
Enable-InsightsCapability -Name "CPU capacity forecasting"
```

To disable a capability, use the **Disable-InsightsCapability** cmdlet:

```PowerShell
Disable-InsightsCapability -Name "Networking capacity forecasting"
```

![Screenshot of using the Disable-InsightsCapability cmdlet in PowerShell.](media/disable-insights-capability.png)

### [Windows Admin Center](#tab/windows-admin-center)

These settings can also be toggled by selected a capability in Windows Admin Center clicking the **Enable** or **Disable** buttons.

---

### Invoke a capability

Invoking a capability immediately runs the capability to retrieve a prediction, and administrators can invoke a capability any time in Windows Admin Center, or by using the **Invoke-InsightsCapability** cmdlet:

### [PowerShell](#tab/PowerShell)

```PowerShell
Invoke-InsightsCapability -Name "CPU capacity forecasting"
```

![Screenshot of using the Invoke-InsightsCapability cmdlet in PowerShell.](media/invoke-insights-capability.png)

To make sure invoking a capability doesn't conflict with critical operations on your machine, consider scheduling predictions during off-business hours.

### [Windows Admin Center](#tab/windows-admin-center)

Invoke a capability any time by clicking the **Invoke** button in Windows Admin Center.

---

## Retrieve capability results

### [PowerShell](#tab/PowerShell)

Once a capability has been invoked, the most recent results are visible using **Get-InsightsCapability** or **Get-InsightsCapabilityResult**. These cmdlets output the most recent **Status** and **Status Description** of each capability, which describe the result of each prediction. The **Status** and **Status Description** fields are further described in the [understanding capabilities document](understanding-capabilities.md).

Additionally, you can use the **Get-InsightsCapabilityResult** cmdlet to view the last 30 prediction results and to retrieve the data associated with the prediction:

```PowerShell
# Specify the History parameter to see the last 30 prediction results.
Get-InsightsCapabilityResult -Name "CPU capacity forecasting" -History

# Use the Output field to locate and then show the results of "CPU capacity forecasting."
# Specify the encoding as UTF8, so that Get-Content correctly parses non-English characters.
$Output = Get-Content (Get-InsightsCapabilityResult -Name "CPU capacity forecasting").Output -Encoding UTF8 | ConvertFrom-Json
$Output.ForecastingResults
```

### [Windows Admin Center](#tab/windows-admin-center)

The System Insights extension automatically shows the prediction history and parses the results of the JSON result, giving you an intuitive, high-fidelity graph of each forecast:

![Single capability page showing a forecasting graph and the prediction history](media/cpu-forecast-2.png)

---

### Use the event log to retrieve capability results

System Insights logs an event each time a capability finishes a prediction. These events are visible in the **Microsoft-Windows-System-Insights/Admin** channel, and System Insights publishes a different event ID for each status:

| Prediction status | Event ID |
| --------------- | --------------- |
| Ok | 151 |
| Warning | 148 |
| Critical | 150 |
| Error | 149 |
| None | 132 |

Use [Azure Monitor](https://azure.microsoft.com/services/monitor/) or [System Center Operations Manager](/system-center/scom/welcome) to aggregate these events and see prediction results across a group of machines.

## Set a capability schedule

In addition to on-demand predictions, you can configure periodic predictions for each capability so that the specified capability is automatically invoked on a predefined schedule. Each default capability is scheduled to run every day at 3am. You can, however, create custom schedules for each capability, and System Insights supports a variety of schedule types.

### [PowerShell](#tab/PowerShell)

Use the **Get-InsightsCapabilitySchedule** cmdlet to see capability schedules:

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

You can create custom schedules for each capability using the **Set-InsightsCapabilitySchedule** cmdlet:

```PowerShell
Set-InsightsCapabilitySchedule -Name "CPU capacity forecasting" -Daily -DaysInterval 2 -At 4:00PM
Set-InsightsCapabilitySchedule -Name "Networking capacity forecasting" -Daily -DaysOfWeek Saturday, Sunday -At 2:30AM
Set-InsightsCapabilitySchedule -Name "Total storage consumption forecasting" -Hourly -HoursInterval 2 -DaysOfWeek Monday, Wednesday, Friday
Set-InsightsCapabilitySchedule -Name "Volume consumption forecasting" -Minute -MinutesInterval 30
```

Because the default capabilities analyze daily data, it's recommended to use daily schedules for these capabilities. Learn more about the [default capabilities](understanding-capabilities.md).

### [Windows Admin Center](#tab/windows-admin-center)

You can also use Windows Admin Center to view and set schedules for each capability by clicking **Settings**. The current schedule is shown on the **Schedule** tab, and you can use the GUI tools to create a new schedule:

![Settings page showing current schedule](media/schedule-page-contoso.png)

---

## Create remediation actions

System Insights enables you to kick off custom remediation scripts based on the result of a capability. For each capability, you can configure a custom PowerShell script for each prediction status, allowing administrators to take corrective action automatically, rather than requiring manual intervention.

Sample remediation actions include running disk cleanup, extending a volume, running deduplication, live migrating VMs, and setting up Azure File Sync.

### [PowerShell](#tab/PowerShell)

You can see the actions for each capability using the **Get-InsightsCapabilityAction** cmdlet:

```PowerShell
Get-InsightsCapability | Get-InsightsCapabilityAction
```

You can create new actions or delete existing actions using the **Set-InsightsCapabilityAction** and **Remove-InsightsCapabilityAction** cmdlets. Each action is run using credentials that are specified in the **ActionCredential** parameter.

```PowerShell
$Cred = Get-Credential
Set-InsightsCapabilityAction -Name "CPU capacity forecasting" -Type Warning -Action "C:\Users\Public\WarningScript.ps1" -ActionCredential $Cred
Set-InsightsCapabilityAction -Name "CPU capacity forecasting" -Type Critical -Action "C:\Users\Public\CriticalScript.ps1" -ActionCredential $Cred

Remove-InsightsCapabilityAction -Name "CPU capacity forecasting" -Type Warning
```

### [Windows Admin Center](#tab/windows-admin-center)

You can also use Windows Admin Center to set remediation actions by using the **Actions** tab within the **Settings** page:

![Settings page where user can specify remediation actions](media/actions-page-contoso.png)

---

## Related content

To learn more about System Insights, use the following resources:

- [System Insights overview](overview.md)
- [Understanding capabilities](understanding-capabilities.md)
- [Adding and developing capabilities](adding-and-developing-capabilities.md)
- [System Insights FAQ](faq.md)
