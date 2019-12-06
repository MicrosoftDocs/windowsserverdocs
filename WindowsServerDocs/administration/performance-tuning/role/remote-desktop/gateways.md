---
title: Performance Tuning Remote Desktop Gateways
description: Performance tuning recommendations for Remote Desktop Gateways
ms.prod: windows-server
ms.technology: performance-tuning-guide
ms.topic: article
ms.author: HammadBu; VladmiS
author: phstee
ms.date: 10/16/2017
---

# Performance Tuning Remote Desktop Gateways

> [!NOTE]
> In Windows 8+ and Windows Server 2012 R2+, Remote Desktop Gateway (RD Gateway) supports TCP, UDP, and the legacy RPC transports. Most of the following data is regarding the legacy RPC transport. If the legacy RPC transport is not being used, this section is not applicable.

This topic describes the performance-related parameters that help improve the performance of a customer deployment and the tunings that rely on the customer's network usage patterns.

At its core, RD Gateway performs many packet forwarding operations between Remote Desktop Connection instances and the RD Session Host server instances within the customer's network.

> [!NOTE]
> The following parameters apply to RPC transport only.

Internet Information Services (IIS) and RD Gateway export the following registry parameters to help improve system performance in the RD Gateway.

**Thread tunings**

-   **Maxiothreads**

    ``` syntax
    HKLM\Software\Microsoft\Terminal Server Gateway\Maxiothreads (REG_DWORD)
    ```

    This app-specific thread pool specifies the number of threads that RD Gateway creates to handle incoming requests. If this registry setting is present, it takes effect. The number of threads equals the number of logical processes. If the number of logical processors is less than 5, the default is 5 threads.

-   **MaxPoolThreads**

    ``` syntax
    HKLM\System\CurrentControlSet\Services\InetInfo\Parameters\MaxPoolThreads (REG_DWORD)
    ```

    This parameter specifies the number of IIS pool threads to create per logical processor. The IIS pool threads watch the network for requests and process all incoming requests. The **MaxPoolThreads** count does not include threads that RD Gateway consumes. The default value is 4.

**Remote procedure call tunings for RD Gateway**

The following parameters can help tune the remote procedure calls (RPC) that are received by Remote Desktop Connection and RD Gateway computers. Changing the windows helps throttle how much data is flowing through each connection and can improve performance for RPC over HTTP v2 scenarios.

-   **ServerReceiveWindow**

    ``` syntax
    HKLM\Software\Microsoft\Rpc\ServerReceiveWindow (REG_DWORD)
    ```

    The default value is 64 KB. This value specifies the window that the server uses for data that is received from the RPC proxy. The minimum value is set to 8 KB, and the maximum value is set at 1 GB. If a value is not present, the default value is used. When changes are made to this value, IIS must be restarted for the change to take effect.

-   **ServerReceiveWindow**

    ``` syntax
    HKLM\Software\Microsoft\Rpc\ServerReceiveWindow (REG_DWORD)
    ```

    The default value is 64 KB. This value specifies the window that the client uses for data that is received from the RPC proxy. The minimum value is 8 KB, and the maximum value is 1 GB. If a value is not present, the default value is used.

## Monitoring and data collection

The following list of performance counters is considered a base set of counters when you monitor the resource usage on the RD Gateway:

-   \\Terminal Service Gateway\\\*

-   \\RPC/HTTP Proxy\\\*

-   \\RPC/HTTP Proxy Per Server\\\*

-   \\Web Service\\\*

-   \\W3SVC\_W3WP\\\*

-   \\IPv4\\\*

-   \\Memory\\\*

-   \\Network Interface(\*)\\\*

-   \\Process(\*)\\\*

-   \\Processor Information(\*)\\\*

-   \\Synchronization(\*)\\\*

-   \\System\\\*

-   \\TCPv4\\\*

The following performance counters are applicable only for legacy RPC transport:

-   \\RPC/HTTP Proxy\\\* RPC

-   \\RPC/HTTP Proxy Per Server\\\* RPC

-   \\Web Service\\\* RPC

-   \\W3SVC\_W3WP\\\* RPC

> [!NOTE]
> If applicable, add the \\IPv6\\\* and \\TCPv6\\\* objects.ReplaceThisText

