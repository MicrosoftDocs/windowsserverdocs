---
title: AD FS Troubleshooting - Congestion Control
description: Learn how to troubleshoot various aspects of Active Directory Federation Services load or congestion issues.
ms.date: 10/14/2024
ms.topic: troubleshooting-general
---

# AD FS troubleshooting: Congestion control

This article assists you with troubleshooting Active Directory Federation Services (AD FS) congestion issues.

## Determine if you're experiencing AD FS congestion

Congestion control provides a throttling mechanism that's designed to protect the internal AD FS servers from excessive external traffic. Web Application Proxy (WAP) monitors the average round-trip latency of federation requests. When the latency exceeds the configured congestion control setting, the proxy starts limiting the number of requests that are sent to the federation servers. When the latency returns to normal, the number of requests is increased. The proxy uses a sliding window algorithm, similar to Transmission Control Protocol (TCP) congestion control, to throttle the request pool.

Each time a request is rejected because of a congestion condition, the proxy writes an **event ID 230** to the AD FS admin event log. The presence of these events signifies that your AD FS farm is currently or was recently operating in congestion mode and rejecting requests.

### Verify load balancer configuration

If you use a hardware network load balancer between the WAP and the AD FS servers, ensure that stickiness and/or cookie tracking is disabled and that the load-balancing algorithm is set to round robin or least busy server. These options allow your farm to adjust to changing traffic patterns and are a Microsoft best practice.

### Verify congestion control settings

On each proxy node, verify that your congestion control settings match the recommended values:

 1. Open `%windir%\ADFS\Config\microsoft.identityServer.proxyservice.exe.config` in an application like Notepad.
 1. Locate the `Microsoft.IdentityServer.Proxy` node.
 1. Verify that `latencyThresholdInMSec` is set to `8000` and `minCongestionWindowSize` is set to `64`.
 1. Restart the `adfssrv` service if the configuration was modified.

### Review errors and latency in dependent services

AD FS depends on many external services to process token requests. These dependencies can vary based on deployment options, but they usually include the enterprise Active Directory. One or more of the following dependencies can also be present:

 - Remote SQL server
 - Custom attribute stores
 - Active Directory Lightweight Domain Services (AD LDS)
 - Third-party Lightweight Directory Access Protocol (LDAP) servers
 - Custom multifactor authentication (MFA) providers
 - Remote hardware security modules

Delays in any of these services can affect the throughput of AD FS, which in turn can cause congestion control to trigger. AD FS maintains a set of multivalue performance counters which can be used to review the latency and errors between AD FS and these external services.

These counters include:

 - AD FS Attribute Store Counters for custom attribute stores
 - AD FS Domain Connection Counters for Active Directory query times
 - AD FS External Authentication Provider Counters for external MFA module latencies
 - AD FS Local Claims Provider Connections for latencies when using third-party LDAP directories
 - AD FS Inter-node Communication Counters for node-to-node artifact lookup latencies

Review the counters that apply to your AD FS farm configuration for errors and unexpected high latencies. If either of these conditions are found, address the issues.

For more information, see [Scenario guide: Troubleshoot performance problems in Windows](/troubleshoot/windows-server/performance/troubleshoot-performance-problems-in-windows).

### Determine if the federation server is overloaded

A federation server has a limit as to how much traffic it can handle before the request latency exceeds a reasonable limit. If the AD FS servers in your farm don't have sufficient hardware or your farm is receiving excessive traffic, this increased latency can trigger congestion control on WAP.

You can use the system performance counters to review the load on each AD FS server in the farm:

1. Open Performance Monitor.
1. Add the `\AD FS\Token Request/Sec` counter.
1. Review **Average values for Token Requests/sec** and **% Processor Time**.

The **Average values for Token requests/sec** values should be within the expected range for your hardware. The **% Processor Time** value should be less than 90%. If these values are exceeded, the farm is likely receiving more traffic than the hardware can handle. You might need to increase the farm capacity by adding more AD FS servers to the farm. You can also remove the unnecessary traffic.

### Determine if WAP is experiencing network issues

Network issues between the WAP servers and the AD FS servers can cause retransmits, which in turn increases the latency and can trigger congestion control. Review the network performance counters such as `TCP v4\Segments Retransmitted` to look for network reliability issues.

### Disable congestion control

Until the root cause is identified, the congestion issue might be mitigated by adjusting or disabling congestion control. The **Request Latency Counter** represents the average request round-trip time. The average of this counter corresponds to the `latencyThresholdInMSec` congestion control setting. If the average value for this counter exceeds the setting value, congestion control is activated. Modifying the `latencyThresholdInMSec` to a higher value can provide congestion control relief until other issues are mitigated. The maximum value for `latencyThresholdInMSec` is 10,000. If the latencies seen in the **Request Latency Counter** are greater than 10 seconds, the only short-term mitigation is to disable congestion control.

## Related content

- [AD FS troubleshooting](ad-fs-tshoot-overview.md)
