---
title: System Insights FAQ
description: System Insights FAQ
ms.topic: faq
author: robinharwood
ms.author: roharwoo
ms.date: 06/09/2025
---
# System Insights FAQ

## How can you use System Insights with Azure Monitor or System Center Operations Manager?

[Azure Monitor](https://azure.microsoft.com/services/monitor/) and [System Center Operations Manager](/system-center/scom/welcome?view=sc-om-1807&preserve-view=true) provide operational information across your deployments to help you manage your infrastructure. System Insights, in contrast, is a Windows Server feature that introduces local predictive analytics capabilities. Together, System Insights and Azure Monitor or SCOM can help surface the predictions across a population of devices:

 Azure Monitor or SCOM can key off the events created by System Insights, as System Insights outputs the result of each prediction to the event log. They can surface these machine-specific predictions across a fleet of Windows Servers, enabling you to have a unified view of these predictions across a group of server instances.

 See the channel and event IDs for each prediction in [retrieve capability results](./managing-capabilities.md#retrieve-capability-results).

## How does System Insights relate to Windows ML?

[Windows ML](/windows/uwp/machine-learning/) is a platform that enables developers to import and score pre-trained machine learning models on Windows devices. These models benefit from hardware acceleration, and they can be scored locally.

System Insights is a feature in Windows Server 2019 that offers local predictive capabilities together with a complete management experience, including PowerShell and Windows Admin Center integration.

## Can I use System Insights for my cluster?

Yes. System Insights can independently run on each individual failover cluster node, and the default behavior of System Insights forecasts usage across local storage, volume, CPU, and networking. **You can also enable forecasting for clustered storage**, so the storage forecasting capabilities predict usage for clustered volumes and storage. You can manage these settings in Windows Admin Center or PowerShell.

## How expensive is it to run the default capabilities?

Each default capability is inexpensive to run. Each capability takes longer to run as you collect more data, but they typically should complete in a few seconds.

## Related content

To learn more about System Insights, use the following resources:

- [System Insights overview](overview.md)
- [Understanding capabilities](understanding-capabilities.md)
- [Managing capabilities](managing-capabilities.md)
- [Adding and developing capabilities](adding-and-developing-capabilities.md)
