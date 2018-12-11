---
title: System Insights data sources 
description: "When writing a new capability in System Insights, you can specify existing or new data sources to collect locally and analyze. This topic describes the data sources that you can choose when registering a new capability."
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

# System Insights data sources

>Applies To: Windows Server 2019

System Insights introduces extensible data collection functionality. When writing a new capability, you can specify existing or new data sources to collect locally and analyze. This topic describes the data sources that you can choose when registering a new capability.

## Data sources
When writing a new capability, you must identify the specific data sources to collect for each capability. The data sources that you specify will be collected and persisted directly on your machine, and you can choose from three types of data sources:

- **Performance counters**: 
    - Specify the counter path, name, and instances, and System Insights collects the relevant data reported by these performance counters. 

- **System events**:
    - Specify the channel name and event ID, and System Insights will record how many times that event has occurred.

- **Well-known series**
    - System Insights collects some basic information on your machine for a few, well-defined resources. These series are used for the default capabilities, but they can also be used by any custom capability. These collect the following information:

        - **Disk**: 
            - *Properties*: Guid
            - *Data*: Size
        - **Volume**:
            - *Properties*: UniqueId, DriveLetter, FileSystemLabel, Size
            - *Data*: Used Size
        - **Network Adapter**:
            - *Properties*: InterfaceGuid, InterfaceDescription, Speed
            - *Data*: Bytes Received/sec, Bytes Sent/sec, Bytes Total/sec
        - **CPU**: 
            - *Properties*: -
            - *Data*: % Processor Time

    - Specify a well-known series, and System Insights will return the data collected by that series. 


## Retention timelines and collection intervals
The data sources above have different retention timelines and collection intervals. The table below reveals how long and how often each data source is collected:

| Data source | Retention timeline | Collection interval |
| --------------- | --------------- | ----------- |
| Performance counters | 3 months | 15 minutes |
| System events | 3 months | 15 minutes |
| Well-known series | 1 year | 1 hour |


### Aggregation types
Because each series record only one data point for each collection interval, each series has an aggregation type assocated it. The table below describes the data source and the corresponding aggregation type:

>[!NOTE]
>For performance counters, you can choose from a few different aggregation types.

| Data source | Aggregation types |
| --------------- | --------------- |
| Performance counters | Sum, average, max, min |
| System events | Count |
| Disk well-known series | Last (latest value in the collection interval) |
| Volume well-known series | Last (latest value in the collection interval) |
| CPU well-known series | Average |
| Network well-known series | Average |

## Data footprint

System Insights collects all data locally on your C drive (C:). In general, the System Insights data footprint is modest. It depends directly on the type and number of data sources each capability specifies, and the table below details the storage usage for each data type:

| Data source | Maximum footprint |
| --------------- | --------------- |
| Performance counters | 240 KB |
| System events | 200 KB |
| Disk well-known series | 200 KB per disk |
| Volume well-known series | 300 KB per volume |
| CPU well-known series | 100 KB |
| Network well-known series | 300 KB per network adapter |

>[!NOTE]
>**For the default forecasting capabilities, the maximum footprint should be less than 10 MB for most stand alone machines.** 

## See also
To learn more about System Insights, use the following resources:

- [System Insights overview](overview.md)
- [Understanding capabilities](understanding-capabilities.md)
- [Managing capabilities](managing-capabilities.md)
- [Adding and developing capabilities](adding-and-developing-capabilities.md)
- [System Insights FAQ](faq.md)
