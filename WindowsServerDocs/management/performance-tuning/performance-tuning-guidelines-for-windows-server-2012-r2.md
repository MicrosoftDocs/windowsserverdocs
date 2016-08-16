---
title: Performance Tuning Guidelines for Windows Server 2012 R2
description: Performance Tuning Guidelines for Windows Server 2012 R2
---

# Performance Tuning Guidelines for Windows Server 2012 R2


A downloadable version of these guidelines are available [here](https://www.microsoft.com/download/details.aspx?id=51960).

When you run a server system in your organization, you might have business needs that are not met by using the default settings. For example, you might need the lowest possible energy consumption, or the lowest possible latency, or the maximum possible throughput on your server. This topic provides a set of guidelines that you can use to tune the server settings in Windows Server 2012 R2 and obtain incremental performance or energy efficiency gains, especially when the nature of the workload varies little over time.

To have the most impact, your tuning changes should consider the hardware, the workload, the power budgets, and the performance goals of your server. This topic describes important tuning considerations and settings that can result in improved performance or energy efficiency. It also describes each setting and its potential effect to help you make an informed decision about its relevance to your system, workload, performance, and energy usage goals.

Since the release of Windows Server 2008, customers have become increasingly concerned about energy efficiency in the datacenter. To address this need, Microsoft and its partners invested a large amount of engineering resources to develop and optimize the features, algorithms, and settings in Windows Server 2012 R2, Windows Server 2012, and Windows Server 2008 R2 to maximize energy efficiency with minimal effects on performance. Although power consumption is a more commonly used term, energy consumption is more accurate because power is an instantaneous measurement (Energy = Power \* Time). Power companies typically charge datacenters for both the energy consumed (megawatt-hours) and the peak power draw required (megawatts).

**Note**  
Registry settings and tuning parameters changed significantly from Windows Server 2003, Windows Server 2008, and Windows Server 2008 R2 to Windows Server 2012 and Windows Server 2012 R2. Be sure to use the latest tuning guidelines to avoid unexpected results.

 

This topic is split into the following sections:

-   [Performance Tuning for Server Hardware](performance-tuning-for-server-hardware.md)

-   [Performance Tuning for Subsystems](performance-tuning-for-subsystems.md)

-   [Performance Tuning for Server Roles](performance-tuning-for-server-roles.md)

-   [Performance Tuning for Workloads](performance-tuning-for-workloads.md)

-   [Additional Resources for Performance Tuning Guidelines](additional-resources-for-performance-tuning-guidelines.md)
