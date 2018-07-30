---
title: System Insights data sources 
description: "System Insights data sources"
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
ms.date: 7/23/2018
---

# System Insights data sources

System Insights introduces extensible, local data collection functionality. When writing a new capability, you can specify existing or new data sources to collect and analyze. 

This topic describes the data sources that you can choose when registering a new capability.

## Data sources
When writing a new capability, you must identify the specific data sources to collect for each capability. The data sources that you specify will be collected and persisted directly on your machine, and you can choose from three types of data sources:


- **Performance counters**: 
    - Specify the counter path, name, and instances, and System Insights collects the relevant data reported by these performance counters. 

- **System events**:
    - Specify the channel name and event ID, and System Insights will record how many times that event has occurred.

- **Well-known series**
    - System Insights collects some basic information on your machine for a few, well-defined resources. These series are used for the default capabilities, but they can also be used by any custom capability. These collect the following information:

        - **PhysicalDisk**:
            - *Properties*: Guid
            - *Data*: Size
        - **Volume**:
            - *Properties*: UniqueId, Drive Letter, File System Label, Size
            - *Data*: Used Size
        - **Network**:
            - *Properties*: Guid, Name, Max Speed
            - *Data*: Bytes Received/sec, Bytes Sent/sec, Bytes Total/sec
        - **CPU**: 
            - *Properties*: -
            - *Data*: \Processor(_Total)\\% Processor Time

    - Choose one of these four well-known series, and System Insights will return all data collected by those series. 


## Retention timelines and collection intervals
The three data sources above have different retention timelines and collection intervals. The table below reveals how long and how often each data source is collected:

| Data source | Retention timeline | Collection interval |
| --------------- | --------------- | ----------- |
| Performance counters | 3 months | 15 minutes |
| System events | 3 months | 15 minutes |
| Disk well-known series | 1 year | Hourly |
| Volume well-known series | 1 year | Hourly |
| Network well-known series | 1 year | Hourly |
| CPU well-known series | 1 year | Hourly |


#### Aggregation types
Each series has an aggregation type assocated it. For the performance counter data, you can specify multiple different aggregation types: 

| Data source | Aggregation types |
| --------------- | --------------- |
| Performance counters | Sum, average, max, min |
| System events | Count |
| Disk | Last (latest value in the collection interval) |
| Volume | Last (latest value in the collection interval) |
| CPU | Average |
| Network | Average |

## See also
To learn more about System Insights, use the following resources:

- [System Insights overview](overview.md)
- [Understanding capabilities](understanding-capabilities.md)
- [Managing capabilities](managing-capabilities.md)
- [Adding and developing capabilities](adding-and-developing-capabilities.md)
- [System Insights FAQ](faq.md)