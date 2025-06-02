---
title: System Insights overview
description: Learn how System Insights uses predictive analytics in Windows Server to help you forecast and manage server resources efficiently.
ms.topic: overview
author: robinharwood
ms.author: roharwoo
ms.date: 06/02/2025
---
# System Insights overview

System Insights is a predictive analytics feature in Windows Server. The System Insights predictive capabilities - each backed by a machine-learning model - locally analyze Windows Server system data, such as performance counters and events, providing insight into the functioning of your servers and helping you reduce the operational expenses associated with reactively managing issues in your deployments.

System Insights ships with four default capabilities focused on capacity forecasting, predicting future resource for compute, networking, and storage based on your previous usage patterns. System Insights also ships with an [extensible infrastructure](adding-and-developing-capabilities.md), so Microsoft and 3rd parties can add new predictive capabilities to System Insights without updating the operating system.

You can manage System Insights through an intuitive [Windows Admin Center](../windows-admin-center/overview.md) extension or [directly through PowerShell](/powershell/module/systeminsights/), and System Insights allows you to configure each predictive capability separately according to the needs of your deployment. All prediction results are published to the event log, which allows you to use [Azure Monitor](https://azure.microsoft.com/services/monitor/) or [System Center Operations Manager](/system-center/scom/welcome?view=sc-om-1807&preserve-view=true) to easily aggregate and see predictions across a group of machines.

![System Insights extension in Windows Admin Center, showing CPU capacity forecasting capability with a graph plotting the forecast](media/cpu-forecast-2.png)

## Local functionality

System Insights runs completely locally on Windows Server. All of your data is collected, persisted, and analyzed directly on your machine, allowing you to realize predictive analytics capabilities without any cloud-connectivity.

Your system data is stored on your machine, and this data is analyzed by predictive capabilities that don't require retraining in the cloud. With System Insights, you can retain your data on your machine and still benefit from predictive analytics capabilities.

## Requirements

System Insights is available on any Windows Server 2019 and newer. It runs on both host and guest machines, on any hypervisor, and in any cloud.

System Insights is pre-installed on Windows Server.

## Related content

To learn more about System Insights, use the following resources:

- [Understanding capabilities](understanding-capabilities.md)
- [Managing capabilities](managing-capabilities.md)
- [Adding and developing capabilities](adding-and-developing-capabilities.md)
- [System Insights FAQ](faq.md)
