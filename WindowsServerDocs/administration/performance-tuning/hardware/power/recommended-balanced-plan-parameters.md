---
title: Recommended Balanced Power Plan Parameters for Quick Response Times
description: Recommended Balanced Power Plan Parameters for Quick Response Time
ms.prod: windows-server-threshold
ms.technology: performance-tuning-guide
ms.topic: article
ms.author:  Qizha;TristanB
author: phstee
ms.date: 10/16/2017
---

# Recommended Balanced Power Plan Parameters for Workloads Requiring Quick Response Times

The default **Balanced** power plan uses **throughput** as the performance metric for tuning. During the steady state, **throughput** does not change with varying utilizations till the system is totally overloaded (~100% utilization).  As a result, the **Balanced** power plan favors power quite a lot with minimizing processor frequency and maximizing utilization.

However **response time** could exponentially increase with utilization increases. Nowadays, the requirement of quick response time has dramatically increased. Even though Microsoft suggested the users to switch to the **High Performance** power plan when they need quick response time, some users do not want to lose the power benefit during light to medium load levels. Hence, Microsoft provides the following set of suggested parameter changes for the workloads requiring quick response time.


| Parameter | Description | Default Value | Proposed Value |
|------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------|
| Processor performance increase threshold | Utilization threshold above which the frequency is to increase | 90 | 60 |
| Processor performance decrease threshold | Utilization threshold below which the frequency is to decrease | 80 | 40 |
| Processor performance increase time | Number of PPM check windows before the frequency is to increase | 3 | 1 |
| Processor performance increase policy | How fast the frequency is to increase | Single | Ideal |

To set the proposed values, the users can run the following commands in a window with administrator:

``` syntax
Powercfg -setacvalueindex scheme_balanced sub_processor PERFINCTHRESHOLD 60
Powercfg -setacvalueindex scheme_balanced sub_processor PERFDECTHRESHOLD 40
Powercfg -setacvalueindex scheme_balanced sub_processor PERFINCTIME 1
Powercfg -setacvalueindex scheme_balanced sub_processor PERFINCPOL 0
Powercfg -setactive scheme_balanced
```

This change is based on the performance and power tradeoff analysis using the following workloads. For the users who want to further fine tune the power efficiency with certain SLA requirements, please refer to [Server Hardware Performance Considerations](../power.md).

>[!Note]
> For additional recommendations and insight on leveraging power plans to tune virtualized workloads, read [Hyper-v Configuration](../../role/hyper-v-server/configuration.md)

## SPECpower – JAVA workload

[SPECpower\_ssj2008](http://spec.org/power_ssj2008/), the most popular industry-standard SPEC benchmark for server power and performance characteristics, is used to check the power impact. Since it only uses **throughput** as performance metric, the default **Balanced** power plan provides the best power efficiency.

The proposed parameter change consumes slightly higher power at the light (i.e., <= 20%) load levels. But with the higher load level, the difference increases, and it starts to consume same power as the **High Performance** power plan after the 60% load level. To use the proposed change parameters, the users should be aware of the power cost at medium to high load levels during their rack capacity planning.

## GeekBench 3

[GeekBench 3](http://www.geekbench.com/geekbench3/) is a cross-platform processor benchmark that separates the scores for single-core and multi-core performance. It simulates a set of workloads including integer workloads (encryptions, compressions, image processing, etc.), floating point workloads (modeling, fractal, image sharpening, image blurring, etc.) and memory workloads (streaming).

**Response time** is a major measure in its score calculation. In our tested system, the default **Balanced** power plan has ~18% regression in single-core tests and ~40% regression in multi-core tests compared to the **High Performance** power plan. The proposed change removes these regressions.

## DiskSpd

[Diskspd](https://en.wikipedia.org/wiki/Diskspd) is a command-line tool for storage benchmarking developed by Microsoft. It is widely used to generate a variety of requests against storage systems for the storage performance analysis.

We set up a [Failover Cluster], and used Diskspd to generate random and sequential, and read and write IOs to the local and remote storage systems with different IO sizes. Our tests show that the IO response time is very sensitive to processor frequency under different power plans. The **Balanced** power plan could double the response time of that from the **High Performance** power plan under certain workloads. The proposed change removes most of the regressions.

>[!Important]
>Starting from Intel [Broadwell] processors running Windows Server 2016, most of the processor power management decisions are made in the processor instead of OS level to achieve quicker adaption to the workload changes. The legacy PPM parameters used by OS have minimal impact on the actual frequency decisions, except telling the processor if it should favor power or performance, or capping the minimal and maximum frequencies. Hence, the proposed PPM parameter change is only targeting to the pre-Broadwell systems.

## See Also
- [Server Hardware Performance Considerations](../index.md)
- [Server Hardware Power Considerations](../power.md)
- [Power and Performance Tuning](power-performance-tuning.md)
- [Processor Power Management Tuning](processor-power-management-tuning.md)
- [Failover Cluster](https://technet.microsoft.com/library/cc725923.aspx)
