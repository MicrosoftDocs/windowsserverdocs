---
title: System Insights capabilities in Windows Server
description: Discover System Insights capabilities in Windows Server, including default capabilities and prediction models. Optimize your server performance with predictive analytics.
ms.topic: concept-article
author: robinharwood
ms.author: roharwoo
ms.date: 06/04/2025
---

# System Insights capabilities in Windows Server

System Insights capabilities in Windows Server use predictive analytics to help administrators forecast resource usage and optimize server performance. This article explains the default capabilities, prediction models, and how to interpret their results.

This article also describes the data sources, prediction timelines, and prediction statuses used for the default capabilities.

## Overview of System Insights capabilities

A System Insights capability is a machine learning or statistics model that analyzes system data to give you more insight into your deployment. System Insights includes a set of default capabilities, and you can add new capabilities dynamically without updating the operating system.

The four default capabilities available are:

- **CPU capacity forecasting**
- **Networking capacity forecasting**
- **Total storage consumption forecasting**
- **Volume consumption forecasting**

Each capability runs locally on a Windows Server instance, and you can manage each capability individually.

Each capability analyzes past historical data to predict future usage, and **all of the forecasting capabilities are designed to forecast long-term trends rather than short-term behavior**, helping administrators correctly provision hardware and tune their workloads to avoid future resource contention. Because these capabilities focus on long-term usage, these capabilities analyze daily data.

## Capability outputs

When you run a capability, it provides an output that explains the result of its analysis or prediction. Each output includes a **Status** and a **Status Description** to describe the prediction. Each result can also include capability-specific data related to the prediction. The **Status Description** gives context for the **Status**, and the capability reports either an **OK**, **Warning**, or **Critical** status. A capability can also use an **Error** or **None** status if it doesn't make a prediction. Here are the capability statuses and their basic meanings:

- **Ok** - Everything looks good.
- **Warning** - No immediate attention required, but you should take a look.
- **Critical** - You should take a look soon.
- **Error** - An unknown problem caused the capability to fail.
- **None** - No prediction was made. This could be due to a lack of data or any other capability-specific reason for not making a prediction.

Any capability-specific data in the result is saved in a user-accessible JSON file. You can find the file path by using PowerShell. For more information, see [retrieving capability results](./managing-capabilities.md#retrieve-capability-results).

## Forecasting model

The default capabilities use a forecasting model to predict future usage, and for each prediction, the model is trained locally on your machine's data. This model is designed to help detect longer term trends, and retraining on each Windows Server instance enables the capability to adapt to the specific behavior and nuances of each machine's usage.

>[!NOTE]
>Determining what type of model to use required testing many models using a dataset containing tens of thousands of machines. After analyzing and tweaking these models, we decided to use an autoregressive forecasting model, as it produces highly accurate and visually intuitive predictions while not requiring too much time to train. This model, however, requires three weeks of training data, so each capability uses a basic linear trend until three weeks of data are available.

## Forecasting timelines

The default capabilities forecast some days into the future based on the number of days for which data has been collected. The following table shows the prediction timelines of these capabilities:

| Input data size | Forecast length |
| --------------- | --------------- |
| 0-5 days | No prediction is made. |
| 6-180 days | 1/3 * size of input data |
| 180-365 days | 60 days |

## Forecasting data

Each capability analyzes daily data to forecast future usage. CPU, networking, and even storage usage, however, can frequently change throughout the day, dynamically adjusting to the workloads on the machine. Because usage isn't constant throughout the day, it's important to properly represent daily usage in a single data point. The table below details the specific data points and how the data is processed:

| Capability name | Data sources | Filtering logic |
| --------------- | -------------- | ---------------- |
| Volume consumption forecasting        | Volume size                    | Maximum daily  |
| Total storage consumption forecasting | Sum of volume sizes, sum of disk sizes  | Maximum daily usage |
| CPU capacity forecasting              | % Processor Time  | Maximum 2-hour average per day |
| Networking capacity forecasting       | Bytes Total/sec         | Maximum 2-hour average per day |

When evaluating the filtering logic, it's important to note that each capability seeks to inform administrators when future usage will meaningfully exceed the available capacity – even though CPU momentarily hit 100% utilization, CPU usage may not cause meaningful performance degradation or resource contention. For CPU and networking, there should be sustained high usage rather than momentary spikes. A few hours of high CPU or networking usage could meaningfully impact the performance of your critical workloads. The maximum 2-hour average during each day avoids these extremes and still produces meaningful data for each capability to analyze.

For volume and total storage usage, however, storage usage can't exceed the available capacity, even momentarily, so the maximum daily usage is used for these capabilities.

## Forecasting statuses

All System Insights capabilities must output a status associated with each prediction. Each default capability uses the following logic to define each prediction status:

- **OK**: The forecast doesn't exceed the available capacity.
- **Warning**: The forecast exceeds the available capacity in the next 30 days.
- **Critical**: The forecast exceeds the available capacity in the next 7 days.
- **Error**: The capability ran into an unexpected error.
- **None**: There isn't enough data to make a prediction. This could be due to a lack of data or because no data is reported recently.

>[!NOTE]
>If a capability forecasts on multiple instances - such as multiple volumes or network adapters - the status reflects the most severe status across all instances. Individual statuses for each volume or network adapter are visible in Windows Admin Center or within the data contained in the output of each capability. For instructions on how to parse the JSON output of the default capabilities, visit [this blog](https://aka.ms/systeminsights-mitigationscripts).

## Related content

To learn more about System Insights, use the following resources:

- [View System Insights overview](overview.md)
- [Manage capabilities](managing-capabilities.md)
- [Add and develop capabilities](adding-and-developing-capabilities.md)
- [View System Insights FAQ](faq.md)
