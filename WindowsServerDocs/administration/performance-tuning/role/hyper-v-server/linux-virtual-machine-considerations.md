---
title: Linux Virtual Machine Considerations
description: Linux and BSD virtual machine 
ms.prod: windows-server
ms.technology: performance-tuning-guide
ms.topic: article
ms.author: Asmahi; SandySp; JoPoulso
author: phstee
ms.date: 10/16/2017
---

# Linux Virtual Machine Considerations

Linux and BSD virtual machines have additional considerations compared to Windows virtual machines in Hyper-V.

The first consideration is whether Integration Services are present or if the VM is running merely on emulated hardware with no enlightenment. A table of Linux and BSD releases that have built-in or downloadable Integration Services is available in [Supported Linux and FreeBSD virtual machines for Hyper-V on Windows](https://technet.microsoft.com/windows-server-docs/compute/hyper-v/supported-linux-and-freebsd-virtual-machines-for-hyper-v-on-windows). These pages have grids of available Hyper-V features available to Linux distribution releases, and notes on those features where applicable.

Even when the guest is running Integration Services, it can be configured with legacy hardware which does not exhibit the best performance. For example, configure and use a virtual ethernet adapter for the guest instead of using a legacy network adapter. With Windows Server 2016, advanced networking like SR-IOV are available as well.

## Linux Network Performance

Linux by default enables hardware acceleration and offloads by default. If vRSS is enabled in the properties of a NIC on the host and the Linux guest has the capability to use vRSS the capability will be enabled. In Powershell this same parameter can be changed with the `EnableNetAdapterRSS` command.

Similarly, the VMMQ (Virtual Switch RSS) feature can be enabled on the physical NIC used by the guest **Properties** > **Configure...** > **Advanced** tab > set **Virtual Switch RSS** to **Enabled** or enable VMMQ in Powershell using the following:

```PowerShell
 Set-VMNetworkAdapter -VMName **$VMName** -VmmqEnabled $True
 ```

In the guest additional TCP tuning can be performed by increasing limits. For the best performance spreading workload over multiple CPUs and having deep workloads produces the best throughput, as virtualized workloads will have higher latency than "bare metal" ones.

Some example tuning parameters that have been useful in network benchmarks include:

```PowerShell
net.core.netdev_max_backlog = 30000
net.core.rmem_max = 67108864
net.core.wmem_max = 67108864
net.ipv4.tcp_wmem = 4096 12582912 33554432
net.ipv4.tcp_rmem = 4096 12582912 33554432
net.ipv4.tcp_max_syn_backlog = 80960
net.ipv4.tcp_slow_start_after_idle = 0
net.ipv4.tcp_tw_reuse = 1
net.ipv4.ip_local_port_range = 10240 65535
net.ipv4.tcp_abort_on_overflow = 1
```

A useful tool for network microbenchmarks is ntttcp, which is available on both Linux and Windows. The Linux version is open source and available from [ntttcp-for-linux on github.com](https://github.com/Microsoft/ntttcp-for-linux). The Windows version can be found in the [download center](https://gallery.technet.microsoft.com/NTttcp-Version-528-Now-f8b12769). When tuning workloads it is best to use as many streams as necessary to get the best throughput. Using ntttcp to model traffic, the `-P` parameter sets the number of parallel connections used.

## Linux Storage Performance

Some best practices, like the following, are listed on [Best Practices for Running Linux on Hyper-V](https://technet.microsoft.com/windows-server-docs/compute/hyper-v/best-practices-for-running-linux-on-hyper-v). The Linux kernel has different I/O schedulers to reorder requests with different algorithms. NOOP is a first-in first-out queue that passes the schedule decision to be made by the hypervisor. It is recommended to use NOOP as the scheduler when running Linux virtual machine on Hyper-V. To change the scheduler for a specific device, in the boot loader's configuration (/etc/grub.conf, for example), add `elevator=noop` to the kernel parameters, and then restart.

Similar to networking, Linux guest performance with storage benefits the most from multiple queues with enough depth to keep the host busy. Microbenchmarking storage performance is probably best with the fio benchmark tool with the libaio engine.

## See also

-   [Hyper-V terminology](terminology.md)

-   [Hyper-V architecture](architecture.md)

-   [Hyper-V server configuration](configuration.md)

-   [Hyper-V processor performance](processor-performance.md)

-   [Hyper-V memory performance](memory-performance.md)

-   [Hyper-V storage I/O performance](storage-io-performance.md)

-   [Hyper-V network I/O performance](network-io-performance.md)

-   [Detecting bottlenecks in a virtualized environment](detecting-virtualized-environment-bottlenecks.md)
