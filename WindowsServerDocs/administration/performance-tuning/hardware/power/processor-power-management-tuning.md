---
title: Processor Power Management (PPM) Tuning for the Windows Server Balanced Power Plan
description: Processor Power Management (PPM) Tuning for the Windows Server Balanced Power Plan
ms.prod: windows-server
ms.technology: performance-tuning-guide
ms.topic: article
ms.author:  Qizha;TristanB
author: phstee
ms.date: 10/16/2017
---

# Processor Power Management (PPM) Tuning for the Windows Server Balanced Power Plan

Starting with Windows Server 2008, Windows Server provides three power plans: **Balanced**, **High Performance**, and **Power Saver**. The **Balanced** power plan is the default choice that aims to give the best energy efficiency for a set of typical server workloads. This topic describes the workloads that have been used to determine the default settings for the **Balanced** scheme for the past several releases of Windows.

If you run a server system that has dramatically different workload characteristics or performance and power requirements than these workloads, you might want to consider tuning the default power settings (i.e., create a custom power plan). One source of useful tuning information is the [Server Hardware Power Considerations](../power.md). Alternately, you may decide that the **High Performance** power plan is the right choice for your environment, recognizing that you will likely take a significant energy hit in exchange for some level of increased responsiveness.

> [!IMPORTANT]
> You should leverage the power policies that are included with Windows Server unless you have a specific need to create a custom one and have a very good understanding that your results will vary depending on the characteristics of your workload.

## Windows Processor Power Tuning Methodology


### Tested workloads

Workloads are selected to cover a best-effort set of "typical" Windows Server workloads. Obviously this set is not intended to be representative of the entire breadth of real-world server environments.

The tuning in each power policy is data driven by the following five workloads:

-   **IIS Web Server workload**

    A Microsoft internal benchmark called Web Fundamentals is used to optimize the energy efficiency of platforms running IIS Web Server. The setup contains a web server and multiple clients that simulate the web access traffic. The distribution of dynamic, static hot (in-memory), and static cold (disk access required) web pages is based on statistical studies of production servers. To push the server's CPU cores to full utilization (one end of the tested spectrum), the setup needs sufficiently fast network and disk resources.

-   **SQL Server Database workload**

    The [TPC-E](http://www.tpc.org/tpce/default.asp) benchmark is a popular benchmark for database performance analysis. It is used to generate an OLTP workload for PPM tuning optimizations. This workload has significant disk I/O, and hence has a high performance requirement for the storage system and memory size.

-   **File Server workload**

    A Microsoft-developed benchmark called [FSCT](http://www.snia.org/sites/default/files2/sdc_archives/2009_presentations/tuesday/BartoszNyczkowski-JianYan_FileServerCapacityTool.pdf) is used to generate an SMB file server workload. It creates a large file set on the server and uses many client systems (actual or virtualized) to generate file open, close, read and write operations. The operation mix is based on statistical studies of production servers. It stresses CPU, disk, and network resources.

-   **SPECpower – JAVA workload**

    [SPECpower\_ssj2008](http://spec.org/power_ssj2008/) is the first industry-standard SPEC benchmark that jointly evaluates power and performance characteristics. It is a server-side Java workload with varying CPU load levels. It doesn't require many disk or network resources, but it has certain requirements for memory bandwidth. Almost all of the CPU activity is performed in user-mode; kernel-mode activity does not have much impact on the benchmarks' power and performance characteristics except for the power management decisions.

-   **Application Server workload**

    The [SAP-SD](http://global.sap.com/campaigns/benchmark/index.epx) benchmark is used to generate an application server workload. A two-tier setup is used, with the database and the application server on the same server host. This workload also utilizes response time as a performance metric, which differs from other tested workloads. Thus it is used to verify the impact of PPM parameters on responsiveness. Nevertheless, it is not intended to be representative of all latency-sensitive production workloads.

All of the benchmarks except SPECpower were originally designed for performance analysis and were therefore created to run at peak load levels. However, medium to light load levels are more common for real-world production servers and are more interesting for **Balanced** plan optimizations. We intentionally run the benchmarks at varying load levels from 100% down to 10% (in 10% steps) by using various throttling methods (e.g., by reducing the number of active users/clients).

### Hardware configurations

For each release of Windows, the most current production servers are used in the power plan analysis and optimization process. In some cases, the tests were performed on pre-production systems whose release schedule matched that of the next Windows release.

Given that most servers are sold with 1 to 4 processor sockets, and since scale-up servers are less likely to have energy efficiency as a primary concern, the power plan optimization tests are primarily run on 2-socket and 4-socket systems. The amount of RAM, disk, and network resources for each test are chosen to allow each system to run all the way up to its full capacity, while taking into account the cost restrictions that would normally be in place for real-world server environments, such as keeping the configurations reasonable.

> [!IMPORTANT]
> Even though the system can run at its peak load, we typically optimize for lower load levels, since servers that consistently run at their peak load levels would be well-advised to use the **High Performance** power plan unless energy efficiency is a high priority.

### Metrics

All of the tested benchmarks use throughput as the performance metric. Response Time is considered as an SLA requirement for these workloads (except for SAP, where it is a primary metric). For example, a benchmark run is considered "valid" if the mean or maximum response time is less than certain value.

Therefore, the PPM tuning analysis also uses throughput as its performance metric.  At the highest load level (100% CPU utilization), our goal is that the throughput should not decrease more than a few percent due to power management optimizations. But the primary consideration is to maximize the power efficiency (as defined below) at medium and low load levels.

![power efficiency formula](../../media/serverperf-ppm-formula.jpg)

Running the CPU cores at lower frequencies reduces energy consumption. However, lower frequencies typically decrease throughput and increase response time. For the **Balanced** power plan, there is an intentional tradeoff of responsiveness and power efficiency. The SAP workload tests, as well as the response time SLAs on the other workloads, make sure that the response time increase doesn't exceed certain threshold (5% as an example) for these specific workloads.

> [!NOTE]
> If the workload uses response time as the performance metric, the system should either switch to the **High Performance** power plan or change **Balanced** power plan as suggested in [Recommended Balanced Power Plan Parameters for Quick Response Time](recommended-balanced-plan-parameters.md).

### Tuning results

Starting with Windows Server 2008, Microsoft worked with Intel and AMD to optimize the PPM parameters for the most up-to-date server processors for each Windows release. A tremendous number of PPM parameter combinations were tested on each of the previously-discussed workloads to find the best power efficiency at different load levels. As software algorithms were refined and as hardware power architectures evolved, each new Windows Server always had better or equal power efficiency than its previous versions across the range of tested workloads.

The following figure gives an example of the power efficiency under different TPC-E load levels on a 4-socket production server running Windows Server 2008 R2. It shows an 8% improvement at medium load levels compared to Windows Server 2008.

![power efficiency comparison](../../media/serverperf-ppm-figure1.jpg)

## Customized Tuning Suggestions

If your primary workload characteristics differ significantly from the five workloads used for the default **Balanced** power plan PPM tuning, you can experiment by altering one or more PPM parameters to find the best fit for your environment.

Due to the number and complexity of parameters, this may be a challenging task, but if you are looking for the best tradeoff between energy consumption and workload efficacy for your particular environment, it may be worth the effort.

 The complete set of tunable PPM parameters can be found in [Processor power management tuning](https://msdn.microsoft.com/windows/hardware/gg566941.aspx). Some of the simplest power parameters to start with could be:

-   **Processor Performance Increase Threshold and Processor Performance Increase Time** – larger values slow the perf response to increased activity

-   **Processor Performance Decrease Threshold** – large values quicken the power response to idle periods

-   **Processor Performance Decrease Time** – larger values more gradually decrease perf during idle periods

-   **Processor Performance Increase Policy** – the "Single" policy slows the perf response to increased and sustained activity; the "Rocket" policy reacts quickly to increased activity

-   **Processor Performance Decrease Policy** – the "Single" policy more gradually decreases perf over longer idle periods; the "Rocket" policy drops power very quickly when entering an idle period

>[!Important]
> Before starting any experiments, you should first understand your workloads, which will help you make the right PPM parameter choices and reduce the tuning effort.

### Understand high-level performance and power requirements

If your workload is "real time" (e.g., susceptible to glitching or other visible end-user impacts) or has very tight responsiveness requirement (e.g., a stock brokerage), and if energy consumption is not a primary criteria for your environment, you should probably just switch to the **High Performance** power plan. Otherwise, you should understand the response time requirements of your workloads, and then tune the PPM parameters for the best possible power efficiency that still meets those requirements.

### Understand underlying workload characteristics

You should know your workloads and design the experiment parameter sets for tuning. For example, if frequencies of the CPU cores need to be ramped very fast (perhaps you have a bursty workload with significant idle periods, but you need very quick responsiveness when a new transaction comes along), then the processor performance increase policy might need to be set to "rocket" (which, as the name implies, shoots the CPU core frequency to its maximum value rather than stepping it up over a period of time).

If your workload is very bursty, the PPM check interval can be reduced to make the CPU frequency start stepping up sooner after a burst arrives. If your workload doesn't have high thread concurrency, then core parking can be enabled to force the workload to execute on a smaller number of cores, which could also potentially improve processor cache hit ratios.

If you just want to increase CPU frequencies at medium utilization levels (i.e., not light workload levels), then processor performance increase/decrease thresholds can be adjusted to not react until certain levels of activity are observed.

### Understand periodic behaviors

There may be different performance requirements for daytime and nighttime or over the weekends, or there may be different workloads that run at different times. In this case, one set of PPM parameters might not be optimal for all time periods. Since multiple custom power plans can be devised, it is possible to even tune for different time periods and switch between power plans through scripts or other means of dynamic system configuration.

Again, this adds to the complexity of the optimization process, so it is a question of how much value will be gained from this type of tuning, which will likely need to be repeated when there are significant hardware upgrades or workload changes.

This is why Windows provides a **Balanced** power plan in the first place, because in many cases it is probably not worth the effort of hand-tuning for a specific workload on a specific server.

## See Also
- [Server Hardware Performance Considerations](../index.md)
- [Server Hardware Power Considerations](../power.md)
- [Power and Performance Tuning](power-performance-tuning.md)
- [Processor Power Management Tuning](processor-power-management-tuning.md)
- [Recommended Balanced Plan Parameters](recommended-balanced-plan-parameters.md)
