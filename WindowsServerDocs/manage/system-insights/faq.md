---
title: System Insights FAQ
description: "System Insights FAQ"
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
ms.date: 5/23/2018
---
# System Insights FAQ

>Applies To: Windows Server 2019

## How can you use System Insights with Azure Monitor or System Center Operations Manager?

[Azure Monitor](https://azure.microsoft.com/services/monitor/) and [System Center Operations Manager](https://docs.microsoft.com/system-center/scom/welcome?view=sc-om-1807) provide operational information across your deployments to help you manage your infrastructure. System Insights, in contrast, is a Windows Server feature that introduces local predictive analytics capabilities. Together, System Insights and Azure Monitor or SCOM can help surface the predictions across a population of devices:

 Azure Monitor or SCOM can key off the events created by System Insights, as System Insights outputs the result of each prediction to the event log. They can surface these machine-specific predictions across a fleet of Windows Servers, enabling you to have a unified view of these predictions across a group of server instances. 
 
 See the channel and event IDs for each prediction [here](https://docs.microsoft.com/windows-server/manage/system-insights/managing-capabilities#retrieving-capability-results).

## How does System Insights relate to Windows ML?

[Windows ML](https://docs.microsoft.com/windows/uwp/machine-learning/) is a platform that enables developers to import and score pre-trained machine learning models on Windows devices. These models benefit from hardware acceleration, and they can be scored locally. 

System Insights is a feature in Windows Server 2019 that offers local predictive capabilities together with a complete management experience, including PowerShell and Windows Admin Center integration. 

## Can I use System Insights for my cluster? 

Yes. System Insights can independently run on each individual failover cluster node, and the default behavior of System Insights forecasts usage across local storage, volume, CPU, and networking. **You can also enable forecasting for clustered storage**, so the storage forecasting capabilities predict usage for clustered volumes and storage. 

You can manage these settings in Windows Admin Center or PowerShell, and more detailed information about this functionality is available [here](https://blogs.technet.microsoft.com/filecab/2018/10/03/using-system-insights-to-forecast-clustered-storage-usage/).
 

## How expensive is it to run the default capabilities?

Each default capability is inexpensive to run. Each capability will take longer to run as you collect more data, but they typically should complete in a just a few seconds. 

## See also
To learn more about System Insights, use the following resources:

- [System Insights overview](overview.md)
- [Understanding capabilities](understanding-capabilities.md)
- [Managing capabilities](managing-capabilities.md)
- [Adding and developing capabilities](adding-and-developing-capabilities.md)
