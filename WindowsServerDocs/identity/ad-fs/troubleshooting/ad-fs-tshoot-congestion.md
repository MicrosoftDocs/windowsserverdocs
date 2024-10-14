---
title: AD FS Troubleshooting - Congestion control
description:  Learn how to troubleshoot various aspects of  AD FS load or congestion issues.
author: billmath
ms.author: billmath
manager: amycolannino
ms.date: 10/14/2024
ms.topic: article
---

# AD FS Troubleshooting - Congestion control
The following document will assist with troubleshooting AD FS congestion issues.

## Determine if you are experiencing AD FS congestion

Congestion control provides a throttling mechanism which is designed to protect the internal AD FS servers from excessive external traffic. The Web Application Proxy monitors the average round trip latency of federation requests. When the latency exceeds the configured congestion control setting, the proxy starts limiting the number of requests which are sent to the federation servers. When the latency returns to normal, the number of requests is increased. The proxy uses a sliding window algorithm, similar to TCP congestion control, to throttle the request pool.

Each time a request is rejected due to a congestion condition, the proxy will write an **event ID 230** to the AD FS admin event log. The presence of these events signifies that your AD FS farm is currently or has recently been operating in congestion mode and rejecting requests.

### Verify load balancer configuration
If you are using a hardware network load balancer between the Web Application Proxy and the AD FS servers, you should ensure that stickiness and/or cookie tracking is disabled and that the load balancing algorithm is set to round robin or least busy server. These options will allow your farm to adjust to changing traffic patterns and are the Microsoft best practice.

### Verify congestion control settings
On each proxy node, verify your congestion control settings match the recommended values.
 1. Open %windir%\ADFS\Config\microsoft.identityServer.proxyservice.exe.config in an application like Notepad
 2. Locate the Microsoft.IdentityServer.Proxy node
 3. Verify that latencyThresholdInMSec is set to 8000 and minCongestionWindowSize is set to 64
 4. Restart the adfssrv service if the configuration was modified

### BReview errors and latency in dependent services
AD FS depends on a number of external services to process token requests. These dependencies can vary based on deployment options but will usually include the enterprise Active Directory. In addition, one or more of the following dependencies can be present.
 - Remote SQL server
 - Custom attribute stores
 - Active Directory Lightweight Domain Services (ADLDS)
 - Third party LDAP servers
 - Custom MFA providers
 - Remote hardware security modules

Delays in any of these services can affect the throughput of AD FS which in turn can cause congestion control to trigger. AD FS maintains a set of multi-value performance counters which can be used to review the latency and errors between AD FS and these external services.

These counters include:
 - AD FS Attribute Store Counters for custom attribute storesAD FS Domain Connection Counters for Active Directory query times
 - AD FS External Authentication Provider Counters for external MFA module latencies
 - AD FS Local Claims Provider Connections for latencies when using third party LDAP directories
 - AD FS Inter-node communication counters for node to node artifact lookup latencies

The counters which apply to your AD FS farm configuration should be reviewed for errors and unexpected high latencies. If either of these conditions are found, the issues should be addressed.

For more information see [Scenario guide: Troubleshoot performance problems in Windows](~/performance/troubleshoot-performance-problems-in-windows.md)

### Determine if the federation server is overloaded
A federation server has a limit as to how much traffic it can handle before the request latency exceeds a reasonable limit. If the AD FS servers in your farm do not have sufficient hardware or your farm is receiving excessive traffic, this increased latency can trigger congestion control on the Web Application Proxy.

The system performance counters can be used to review the load on each AD FS server in the farm.

1. Open Performance Monitor
2. Add the "\AD FS\Token Request/Sec" counter
3. Review the Average values for Token Requests/sec and % processor time

The Average Token requests / sec should be within the expected range for your hardware and the % processor time should be less than 90%. If these values are exceeded, the farm is likely receiving more traffic than the hardware can handle. You may need to increase the farm capacity by adding additional AD FS servers to the farm or you can remove the unnecessary traffic.

### Determine if the Web Application Proxy is experiencing network issues
Network issues between the Web Application Proxy servers and the AD FS servers can cause retransmits which in turn increases the latency and can trigger congestion control. The network performance counters such as TCP v4\Segments Retransmitted should be reviewed to look for network reliability issues.

### Disable congestion control
Until the root cause is identified, the congestion issue may be mitigated by adjusting or disabling congestion control. The Request Latency counter represents the average request round trip time. The average of this counter corresponds to the latencyThresholdInMSec congestion control setting. If the average value for this counter exceeds the setting value, congestion control will be activated. Modifying the latencyThresholdInMSec to a higher value can provide congestion control relief until other issues are mitigated. The maximum value for latencyThresholdInMSec is 10000. If the latencies seen in the Request Latency Counter are greater than 10 seconds, the only short term mitigation is to disable congestion control.

## Related links

- [AD FS Troubleshooting](ad-fs-tshoot-overview.md)
