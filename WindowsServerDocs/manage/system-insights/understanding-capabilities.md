---
title: Understanding capabilities
description: "This topic defines the concept of capabilities in System Insights and introduces the default capabilities available in Windows Server 2019."
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
# Understanding capabilities

>Applies To: Windows Server 2019

This topic defines the concept of capabilities in System Insights and introduces the default capabilities available in Windows Server 2019. 

This topic also describes the data sources, prediction timelines, and prediction statuses used for the default capabilities. 

## Capability overview
A System Insights capability is a machine learning or statistics model that analyzes system data to help give you increased insight into the functioning of your deployment. System Insights introduces an initial set of default capabilities, and it allows you to add new capabilities dynamically, without needing to update the operating system. 

>[!NOTE]
>Detailed documentation explaining how to create, add, and update capabilities is available [here](adding-and-developing-capabilities.md), and [the managing capabilities document](managing-capabilities.md) provides more high-level information about this functionality.

Additionally, each capability runs locally on a Windows Server instance, and each capability can be managed individually.

### Capability outputs
When a capability is invoked, it provides an output to help explain the result of its analysis or prediction. Each output must contain a **Status** and a **Status Description** to describe the prediction, and each result can optionally contain capability-specific data associated with the prediction. The **Status Description** helps provides a contextual explaination for the **Status**, and the capability reports either an **OK**, **Warning**, or **Critical** status. Additionally, a capability can use an **Error** or **None** status if no prediction was made. Together, here are the capability statuses and their basic meanings: 

- **Ok** - Everything looks good.
- **Warning** - No immediate attention required, but you should take a look. 
- **Critical** - You should take a look soon. 
- **Error** - An unknown problem caused the capability to fail. 
- **None** - No prediction was made. This could be due to a lack of data or any other capability-specific reason for not making a prediction. 

Additionally, any capability-specific data contained in the result will be placed in a user-accessible JSON file, and the file path [can be found using PowerShell](https://docs.microsoft.com/windows-server/manage/system-insights/managing-capabilities#retrieving-capability-results). 

## Default capabilities
In Windows Server 2019, System Insights introduces four default capabilities focused on capacity forecasting:

- **CPU capacity forecasting** - Forecasts CPU usage. 
- **Networking capacity forecasting** - Forecasts network usage for each network adapter. 
- **Total storage consumption forecasting** - Forecasts total storage consumption across all local drives. 
- **Volume consumption forecasting** - Forecasts storage consumption for each volume.

Each capability analyzes past historical data to predict future usage, and **all of the forecasting capabilities are designed to forecast long-term trends rather than short-term behavior**, helping administrators correctly provision hardware and tune their workloads to avoid future resource contention. Because these capabilities focus on long-term usage, these capabilities analyze daily data. 

### Forecasting model
The default capabilities use a forecasting model to predict future usage, and for each prediction, the model is trained locally on your machine's data. This model is designed to help detect longer term trends, and retraining on each Windows Server instance enables the capability to adapt to the specific behavior and nuances of each machine's usage.

>[!NOTE]
>Determining what type of model to use required testing many models using a dataset containing tens of thousands of machines. After analyzing and tweaking these models, we decided to use an auto-regressive forecasting model, as it produces highly-accurate and visually intuitive predictions while not requiring too much time to train. This model, however, requires three weeks of training data, so each capability uses a basic linear trend until three weeks of data are available.

### Forecasting timelines
The default capabilities forecast a certain number of days into the future based on the number of days for which data has been collected. The following table shows the prediction timelines of these capabilities:

| Input data size | Forecast length |
| --------------- | --------------- |
| 0-5 days | No prediction is made. |
| 6-180 days | 1/3 * size of input data |
| 180-365 days | 60 days | 

### Forecasting data
Each capability analyzes daily data to forecast future usage. CPU, networking, and even storage usage, however, can frequently change throughout the day, dynamically adjusting to the workloads on the machine. Because usage isn't constant throughout the day, it's important to properly represent daily usage in a single data point. The table below details the specific data points and how the data is processed:


| Capability name | Data source(s) | Filtering logic |
| --------------- | -------------- | ---------------- |
 Volume consumption forecasting          | Volume size                    | Maximum daily usage              
 Total storage consumption forecasting   | Sum of volume sizes, sum of disk sizes              | Maximum daily usage             
 CPU capacity forecasting                | % Processor Time  | Maximum 2-hour average per day   
 Networking capacity forecasting         | Bytes Total/sec         | Maximum 2-hour average per day  

When evaluating the filtering logic above, it’s important to note that each capability seeks to inform administrators when future usage will meaningfully exceed the available capacity – even though CPU momentarily hit 100% utilization, CPU usage may not have caused meaningful performance degradation or resource contention. For CPU and networking, then, there should be sustained high usage rather than momentary spikes. Averaging CPU and networking usage throughout the whole day, however, would lose important usage information, as a few hours of high CPU or networking usage could meaningfully impact the performance of your critical workloads. The maximum 2-hour average during each day avoids these extremes and still produces meaningful data for each capability to analyze.

For volume and total storage usage, however, storage usage can't exceed the available capacity, even momentarily, so the maximum daily usage is used for these capabilities. 

### Forecasting statuses
All System Insights capabilities must output a status associated with each prediction. Each default capability uses the following logic to define each prediction status:
- **OK**: The forecast does not exceed the available capacity.
- **Warning**: The forecast exceeds the available capacity in the next 30 days. 
- **Critical**: The forecast exceeds the available capacity in the next 7 days. 
- **Error**: The capability ran into an unexpected error. 
- **None**: There isn’t enough data to make a prediction. This could be due to a lack of data or because no data has been reported recently.

>[!NOTE]
>If a capability forecasts on multiple instances - such as multiple volumes or network adapters - the status reflects the most severe status across all instances. Individual statuses for each volume or network adapter are visible in Windows Admin Center or within the data contained in the output of each capability. For instructions on how to parse the JSON output of the default capabilities, visit [this blog](https://aka.ms/systeminsights-mitigationscripts). 


## See also
To learn more about System Insights, use the following resources:

- [System Insights overview](overview.md)
- [Managing capabilities](managing-capabilities.md)
- [Adding and developing capabilities](adding-and-developing-capabilities.md)
- [System Insights FAQ](faq.md)
