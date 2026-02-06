---
title: Troubleshoot DNS over HTTPS in DNS Server on Windows Server
description: Learn how to troubleshoot DNS over HTTPS (DoH) issues on Windows DNS Server including service configuration, certificate binding, client connectivity, and query processing problems.
ms.topic: troubleshooting-general
ms.author: roharwoo
ms.date: 02/03/2026
author: robinharwood
ms.reviewer: canasjorge,sruthytv
#customer intent: As a DNS administrator, I want to troubleshoot DNS over HTTPS issues so that I can resolve DoH configuration and encrypted DNS query problems.
ai-usage: ai-assisted
---

# Troubleshoot DNS over HTTPS in DNS Server (Preview)

> [!IMPORTANT]
> DNS over HTTPS (DoH) for DNS Server on Windows Server is currently in PREVIEW.
> This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

Are your clients unable to connect to your DNS server using DoH, or are encrypted DNS queries failing without a clear reason? This article helps you identify and fix common DNS over HTTPS (DoH) problems on Windows DNS Server. Whether you're dealing with certificate binding errors, port conflicts, or performance issues, you'll find step-by-step guidance to get DoH working correctly.

Start with the troubleshooting checklist to quickly pinpoint your problem, then follow the symptom-specific sections for detailed resolution steps. This article applies to Windows Server 2025 and later versions with the DoH preview feature enabled.

## Prerequisites

Before you troubleshoot DoH problems, make sure that you have:

- Windows Server 2025 with the 2026-02 Security Update [KB5075899](https://support.microsoft.com/help/5075899) or later installed.

- DNS over HTTPS on the DNS Server service is enabled using the instructions provided after requesting access using [DoH on Windows DNS Server: Public Preview Registration](https://aka.ms/doh-preview).

- Administrative or equivalent access to the Windows Server hosting the DNS Server service.

DoH certificates must meet the following requirements:

- **Enhanced Key Usage extension**: Must include Server Authentication (1.3.6.1.5.5.7.3.1) object identifier

- **Subject or Subject Alternative Name**: A signed certificate with a Subject Alternative Name (SAN) with the fully qualified domain name or IP address that matches your configured DoH URI template

- **Private key**: Must be present in the Local Computer's store, correctly associated with the certificate, and must not have strong private key protection enabled

- **Trust chain**: Must be issued by a CA that the DNS clients trust

## Troubleshooting checklist

Work through this checklist to identify your DoH problem. Each check links to detailed resolution steps.

### 1. Verify DoH status

✅ DoH is enabled: `Get-DnsServerEncryptionProtocol` shows `EnableDoh : True`

✅ DNS service is running: `Get-Service DNS` shows `Running`

✅ Configured port is listening: `netstat -an | findstr :<port>` shows `LISTENING`. The default port is 443.

To resolve service configuration problems, see [Symptom: DoH not configured or running](#symptom-doh-not-configured-or-running).

### 2. Verify DoH initialization

✅ Event ID 822 appears in DNS Server event log after service restart

✅ No error events (823, 825, 826) in event log

✅ Certificate is bound to your configured port: `netsh http show sslcert`

To resolve initialization failures, see [Symptom: DoH fails to initialize](#symptom-doh-fails-to-initialize).

### 3. Verify client connectivity

✅ Clients can reach DNS server on the configured DoH port (test with browser), by default 443

✅ Firewall allows inbound TCP on the configured DoH port

✅ Clients trust the server certificate (no certificate warnings)

To resolve connectivity problems, see [Symptom: Clients can't connect using DoH](#symptom-clients-cant-connect-using-doh).

### 4. Verify query processing

✅ Event ID 597 (queries received) appears in the Analytical log.

✅ Event ID 598 (responses sent) appears in the Analytical log

✅ No event ID 599 (response failures) or event ID 600 (queries rejected)

To resolve query processing problems, see [Symptom: DoH queries fail or time out](#symptom-doh-queries-fail-or-time-out).

> [!TIP]
> If event ID 597 doesn't appear, troubleshoot client connectivity first. See [Symptom: Clients can't connect using DoH](#symptom-clients-cant-connect-using-doh).

### 5. Verify performance

✅ DoH Requests Dropped/sec counter = 0

✅ DoH Responses Sent/sec ≈ DoH Requests Received/sec

✅ Query latency is acceptable

To resolve performance problems, see [Symptom: DoH performance problems](#symptom-doh-performance-problems).

## Symptom: DoH not configured or running

You attempt to use DoH but clients continue using unencrypted DNS, or you can't verify DoH is enabled on the server.

**Common causes:**

- DoH not enabled on the server

- DNS service stopped

- Configuration error in DoH settings

**How to diagnose:**

To check the DoH configuration, run the following command:

```powershell
Get-DnsServerEncryptionProtocol
```

If DoH is properly configured, you should see:

```Output
EnableDoh   : True
UriTemplate : https://dns.contoso.com:443/dns-query
```

To check the DNS service status, run the following command:

```powershell
Get-Service DNS
```

The output should show `Status: Running`.

To verify your configured port is listening, run the following command. Replace `443` with your configured port if different:

```cmd
netstat -an | findstr :443
```

You should see TCP entries in `LISTENING` state.

For detailed monitoring procedures, see  [Monitor DNS over HTTPS](monitor-dns-over-https.md).

**How to resolve:**

If `EnableDoh` is `False`, to enable DoH, run the following command:

```powershell
Set-DnsServerEncryptionProtocol -EnableDoh $true -UriTemplate "https://dns.contoso.com:443/dns-query"
```

Replace `dns.contoso.com` with your DNS server's FQDN that matches your certificate SAN.

To restart the DNS Server service, run the following command:

```powershell
Restart-Service -Name DNS
```

If DoH wasn't previously configured, see [Enable DNS over HTTPS on Windows DNS Server](enable-dns-over-https-server.md) for complete setup instructions, including certificate requirements.

---

## Symptom: DoH fails to initialize

DoH is enabled but the service doesn't initialize properly. Clients can't connect using DoH.

**Common causes:**

- Certificate binding problems (event ID 823).

- Port conflicts (event ID 825, 826).

- Invalid URI template configuration.

**How to diagnose:**

Check Windows Event Viewer for DNS Server events. Go to **Applications and Services** > **Logs** > **Microsoft** > **Windows** > **DNS-Server**.

For complete event details, see [Monitor DNS over HTTPS - Server Events](monitor-dns-over-https.md#server-events).

Check for these specific events:

- **Event ID 823 (DNS_EVENT_HTTP_SERVER_INIT_FAILED)**: HTTP server initialization failed, typically due to certificate binding problems or port conflicts.

- **Event ID 825 (DNS_EVENT_HTTP_CREATE_URL_FAILED)**: URL registration failed due to invalid URI format or port conflicts.

Look for event ID 822 (DNS_EVENT_HTTP_URL_REGISTERED), which indicates successful initialization. If this event is missing after service restart, initialization failed.

**How to resolve:**

### Certificate binding problems

If you see event ID 823, run the following command to verify certificate binding:

```cmd
netsh http show sslcert
```

Look for an entry that matches your IP address and port (for example, `0.0.0.0:443`). Confirm it shows the thumbprint of your DNS server's certificate.

If the certificate isn't bound or shows an incorrect thumbprint, see [Bind the certificate](enable-dns-over-https-server.md#bind-the-certificate) for steps to bind the correct certificate.

Ensure the certificate meets these requirements:

- Valid SSL/TLS certificate in the `LocalMachine\My store`

- Subject Alternative Name (SAN) matches the FQDN in your DoH URI

- Private key is installed

- Not expired

For detailed certificate setup, see [Enable DNS over HTTPS on Windows DNS Server](enable-dns-over-https-server.md).

### Port conflicts

If you see event ID 825 or 826, another service might be using port 443. To check what's using the port, run the following command:

```cmd
netstat -ano | findstr :443
```

If another process uses port 443, either:

- Stop the conflicting service, or
- To configure DoH to use a different port, run the following command:

```powershell
Set-DnsServerEncryptionProtocol -EnableDoh $true -UriTemplate "https://dns.contoso.com:8443/dns-query"
```

Then bind your certificate to the new port and update firewall rules accordingly.

### Configuration errors

Verify your URI template is properly formatted:

- Starts with `https://`

- Includes the FQDN that matches your certificate SAN

- Includes the path `/dns-query`

- Example: `https://dns.contoso.com:443/dns-query`

To check the current URI template configuration, run the following command:

```powershell
Get-DnsServerEncryptionProtocol | Select-Object UriTemplate
```

If the URI template is incorrect or missing, run the following command to reconfigure it:

```powershell
Set-DnsServerEncryptionProtocol -EnableDoh $true -UriTemplate "https://dns.contoso.com:443/dns-query"
```

Replace `dns.contoso.com` with your DNS server's FQDN. Ensure the FQDN matches the Subject Alternative Name (SAN) in your certificate exactly.

After resolving issues, run the following command to restart the DNS service. Check for event ID 822 to confirm successful initialization.

```powershell
Restart-Service -Name DNS
```

---

## Symptom: Clients can't connect using DoH

You configure and start DoH on the server, but clients can't connect or they get certificate errors.

**Common causes:**

- Network/firewall blocking the configured DoH port, by default 443

- Certificate trust issues

- Client using wrong URI or configuration

**How to diagnose:**

Test connectivity from a client machine by opening a web browser and navigating to your DoH URI (for example, `https://dns.contoso.com/dns-query`). You should see either:

- A blank page or minimal response indicates the server is listening and network connectivity is working.

- A certificate error indicates certificate trust issues, but confirms network connectivity and firewall rules are correct.

- A connection timeout indicates network or firewall issues preventing access to the DNS server using DoH.

To check firewall rules on the DNS server, run the following command:

```powershell
Get-NetFirewallRule | Where-Object {$_.DisplayName -like "*DNS*" -or $_.DisplayName -like "*443*"} | Format-Table DisplayName, Enabled, Direction, Action
```

Verify client certificate trust by examining certificate details in the browser. Check if the certificate chain is valid and trusted.

**How to resolve:**

### Network connectivity

First, verify network connectivity from the client to the DNS server over HTTPS. Run the following command, replacing the port if you configured a nondefault port:

```powershell
Test-NetConnection -ComputerName dns.contoso.com -Port 443
```

If `TcpTestSucceeded` returns `False`, check network routing and firewall rules between the client and server.

To create a new Windows Firewall on the server to allow inbound connections, run the following command. Replace `443` with your configured port if different:

```powershell
New-NetFirewallRule -DisplayName "DNS over HTTPS" -Direction Inbound -Protocol TCP -LocalPort 443 -Action Allow
```

If you're using a hardware firewall or network security group, make sure it allows inbound TCP traffic on your configured DoH port to the DNS server.

### Certificate trust

If you use a private certificate authority (CA):

1. Make sure your DNS clients trust that CA

1. Install the root CA certificate on client machines

1. Verify the certificate chain is complete on the server

Alternatively, use a certificate signed by a publicly trusted CA that clients already trust.

To test network connectivity to the DNS server's DoH port from a client, run the following command. Replace `443` with your configured port if different:

```powershell
Test-NetConnection -ComputerName dns.contoso.com -Port 443
```

To verify the certificate is trusted by the client, open a web browser and go to `https://dns.contoso.com/dns-query`. If the browser displays a certificate warning, the client doesn't trust the certificate chain.

For certificate deployment guidance, see [Enable DNS over HTTPS on Windows DNS Server](enable-dns-over-https-server.md).

### Client configuration

Verify the client's DoH configuration matches your server's URI exactly:

- Windows 11: Settings > Network & Internet > [Connection] > DNS settings

- The DoH template must match: `https://dns.contoso.com:443/dns-query`

- If you use a nondefault port, ensure clients specify it

If you configure clients but they still use unencrypted DNS, check that the DNS server IP address in client network settings matches your DNS server with DoH enabled.

---

## Symptom: DoH queries fail or time out

Clients connect to the DNS server, but queries fail or don't receive responses.

**Common causes:**

- Upstream DNS resolution problems (event ID 599)

- Client protocol incompatibility (event ID 600)

- Client DoH configuration issues

- DNS server configuration problems

**How to diagnose:**

Enable analytical logging to capture detailed per-query events:

1. Open Event Viewer and go to **Applications and Services** > **Logs** > **Microsoft** > **Windows** > **DNS-Server**.

1. Right-click **Analytical** and select **Enable Log**.

For detailed analytical logging procedures, see [Monitor DNS over HTTPS - Analytical Events](monitor-dns-over-https.md#dns-over-https-analytical-events).

Check these key events:

- **Event ID 597**: DoH query received - confirms encrypted DNS queries reach the server

- **Event ID 598**: DoH response sent - confirms successful responses

- **Event ID 599**: DoH response failure - indicates the server tried to answer but couldn't (likely upstream resolution problem)

- **Event ID 600**: DoH query rejected - server is actively dropping certain DoH requests

- **Event ID 601**: DoH channel failure - might accompany 600 or 599 in some error cases

Look for patterns:

- Multiple event ID 597 entries but no event ID 598 entries suggests the server can't resolve queries.

- Event ID 600 entries might indicate HTTP version incompatibility or malformed requests.

- Event ID 599 with `SERVFAIL RCODE` suggests upstream forwarder problems.

**How to resolve:**

### Upstream DNS issues (event ID 599)

If you see event ID 599 with `SERVFAIL` or similar errors, check the upstream DNS configuration on the DNS server. Run the following command:

```powershell
Get-DnsServerForwarder
```

To test connectivity to forwarders, run the following command:

```powershell
Test-NetConnection -ComputerName <forwarder-ip> -Port 53
```

If forwarders are unreachable or misconfigured, try alternative forwarders using the following command:

```powershell
Set-DnsServerForwarder -IPAddress <new-forwarder-ip>
```

To test resolution manually, run the following command:

```powershell
Resolve-DnsName -Name microsoft.com -Server localhost
```

For traditional DNS troubleshooting, see [Troubleshooting DNS servers](troubleshoot/troubleshoot-dns-server.md).

### Client compatibility (event ID 600)

Event ID 600 indicates rejected queries. Common causes include:

- **HTTP version incompatibility**: DoH requires HTTP/2. Ensure clients support HTTP/2.

- **Malformed requests**: The query doesn't conform to RFC 8484.

- **DNS policy restrictions**: A DNS policy might be dropping queries.

Check the event details for the rejection reason. If clients use incompatible HTTP versions, update the client software or use different DoH client applications.

To verify that no DNS policies are interfering, run the following command:

```powershell
Get-DnsServerQueryResolutionPolicy
```

### Client DoH configuration

If queries fail from specific clients but work from others, verify the client's DoH configuration. Common issues include:

- Incorrect DoH URI template
- DNS server IP address not matching the DNS server used for DoH
- Client not configured to use DoH

For client configuration guidance, see [Secure DNS Client over HTTPS (DoH)](doh-client-support.md).

### Server configuration

If queries fail for reasons other than those listed earlier in this article, check the general DNS server configuration:

- Verify that root hints are configured correctly.

- Check zone loading for authoritative zones.

- Review recursion settings if the server should perform recursive resolution.

For comprehensive DNS troubleshooting, see [Troubleshoot DNS servers](troubleshoot/troubleshoot-dns-server.md).

Remember to disable the Analytical log when troubleshooting is complete to avoid excessive event generation.

---

## Symptom: DoH performance problems

DoH works but you see high latency, dropped queries, or poor performance compared to unencrypted DNS.

**Common causes:**

- Server capacity limits

- TLS handshake overhead

- Network congestion or high CPU usage

**How to diagnose:**

For detailed performance monitoring procedures, see [Monitor DNS over HTTPS - Monitor Performance](monitor-dns-over-https.md#monitor-performance).

Open Performance Monitor (perfmon.exe) and add DNS performance counters:

1. Go to **Performance** > **Monitoring Tools** > **Performance Monitor**

1. Add counters from the **DNS** performance object

1. Monitor these DoH-specific counters:
   - DoH Requests Received/sec
   - DoH Responses Sent/sec
   - DoH Requests Dropped/sec

Key indicators of performance problems:

- **DoH Requests Dropped/sec > 0**: The server discards queries

- **Requests Received/sec much higher than Responses Sent/sec**: Many queries don't get answers

- **High or spiking CPU usage** during DoH query processing

Also monitor system resources:

- CPU utilization

- Memory usage

- Network throughput

If only certain queries are slow, the problem might be external to DoH. For example, slow recursion to upstream servers for specific domains. To isolate DoH overhead from general DNS delays, compare DoH and unencrypted DNS performance for the same queries. If both are slow, the problem is likely upstream resolution rather than DoH-specific.

**How to resolve:**

### Dropped queries

If `DoH Requests Dropped/sec` is greater than 0, take the following steps:

1. Correlate with event ID 600 in DNS Server logs to identify the cause of drops.

1. Check if the server is resource-constrained.

   ```powershell
   Get-Counter '\Processor(_Total)\% Processor Time'
   Get-Counter '\Memory\Available MBytes'
   ```

1. If CPU or memory is consistently high, consider:
   - Scaling up the server with more CPU or RAM resources.
   - Adding extra DNS servers to distribute the load.
   - Implementing DNS load balancing.

### High latency

TLS handshake overhead can increase query latency compared to unencrypted DNS. To diagnose latency problems:

- Compare DoH query times to unencrypted DNS baselines for the same queries.

- Use client-side tools to measure end-to-end DoH query time.

- If both DoH and unencrypted DNS are slow for the same queries, the problem is upstream resolution rather than DoH-specific.

To reduce DoH-specific latency:

1. **Verify server CPU capacity**: TLS operations are CPU-intensive. To check if CPU is a bottleneck during DoH traffic, run the following command:

   ```powershell
   Get-Counter '\Processor(_Total)\% Processor Time' -SampleInterval 1 -MaxSamples 30
   ```

   If CPU consistently exceeds 70-80% during DoH traffic, consider upgrading server resources or distributing load.

1. **Review certificate chain length**: Shorter certificate chains validate faster. Ensure intermediate certificates are properly configured to avoid extra lookups.

1. **Check network paths**: High network latency between clients and the DNS server directly affects query time. Use `Test-NetConnection` or `traceroute` to find network bottlenecks.

### Resource constraints

If the server is under-provisioned:

1. Monitor baseline resource usage during normal operations.

1. Identify peak usage times and correlate with query volume.

1. Consider:
   - Vertical scaling (larger VM or physical server).
   - Horizontal scaling (multiple DNS servers behind a load balancer).
   - Optimizing DNS zone configurations to reduce zone transfer overhead.

To monitor long-term trends and plan capacity, run the following command:

```powershell
Get-Counter '\DNS\DoH Requests Received/sec' -Continuous
```

For capacity planning guidance, see [Monitor DNS over HTTPS - Monitor Performance](monitor-dns-over-https.md#monitor-performance).

---

## Advanced diagnostics

When basic troubleshooting doesn't resolve the problem, use these advanced techniques to gather detailed diagnostic information.

### Enable analytical logging

The DNS Server Analytical log captures detailed per-query events, including DoH-specific operations. When you enable the log, it records event IDs 597-600 for each DoH query, response, failure, and rejection.

For step-by-step instructions on enabling and using analytical logging, see [Monitor DNS over HTTPS - Analytical Events](monitor-dns-over-https.md#dns-over-https-analytical-events).

> [!IMPORTANT]
> Disable analytical logging when finished, as it generates a large volume of events on busy servers.

### Detailed event analysis

When you review DoH events, examine these event fields for diagnostic clues:

- **QNAME**: The domain name queried. This field helps you identify if problems are domain-specific.

- **QTYPE**: The DNS record type, such as A, AAAA, MX, and others.

- **RCODE**: The response code, like NOERROR, SERVFAIL, NXDOMAIN, and others.

- **Reason**: For event ID 600, this field provides the rejection reason.

- **Client IP**: The source of the query. This field helps you identify problematic clients.

Correlate events over time:

- Look for patterns. Do failures happen at specific times?

- Check if multiple clients experience the same problem.

- Identify whether failures correlate with high load periods.

Cross-reference with other logs:

- System log for Schannel TLS errors.

- DNS Server operational log for zone and forwarder problems.

- Application log for service-level errors.

### Performance analysis

For deep performance analysis:

1. Establish baseline metrics during normal operations.

1. Compare current performance to baseline.

1. Identify deviations and correlate with events or configuration changes.

Key performance counters to monitor over time:

```powershell
Get-Counter -Counter @(
    '\DNS\DoH Requests Received/sec',
    '\DNS\DoH Responses Sent/sec',
    '\DNS\DoH Requests Dropped/sec',
    '\Processor(_Total)\% Processor Time',
    '\Memory\Available MBytes'
) -SampleInterval 5 -MaxSamples 60
```

This command samples counters every 5 seconds for 5 minutes, providing trending data.

Analyze trends:

- Is performance degrading over time?

- Do specific times of day show problems?

- Does performance correlate with query volume?

Use this data to:

- Plan capacity upgrades.

- Identify configuration bottlenecks.

- Optimize DNS server settings.

For comprehensive performance monitoring guidance, see [Monitor DNS over HTTPS](monitor-dns-over-https.md).

---

## Related content

- [Enable DNS over HTTPS on Windows DNS Server](enable-dns-over-https-server.md)

- [Monitor DNS over HTTPS](monitor-dns-over-https.md)

- [Troubleshoot DNS servers](troubleshoot/troubleshoot-dns-server.md)

- [DNS logging and diagnostics](dns-logging-and-diagnostics.md)
