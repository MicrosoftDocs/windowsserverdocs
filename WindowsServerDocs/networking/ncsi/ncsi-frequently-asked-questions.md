---
title: Network Connectivity Status Indicator FAQ for Windows
description: 'Frequently asked questions surrounding the Network Connectivity Status Indicator (NCSI) in Windows.'
ms.topic: article
ms.date: 06/23/2023
ms.author: wscontent
author: xelu86
ms.contributors: rnitsch
---

# Answers To common questions about NCSI

The following section is to provide a quick FAQ surrounding the Network Connectivity Status Indicator (NCSI) in Windows.

> [!IMPORTANT]
> The public NCSI probe servers formerly hosted by Azure Front Door are now being hosted by Akamai. This change occurred on June 20, 2023.
>
> Microsoft recommends as best practices that firewall rules be used to allow NCSI traffic and should not be based on IP addresses. If you have observed failed NCSI probes, first check that the client probes are not being blocked by enterprise firewalls or proxies. If the probes used to work prior to the mentioned date, rules added to allow outbound HTTP requests to 13.107.4.52 is the issue.
>
> - You can modify your outbound rules in the **Windows Defender Firewall with Advanced Security** by clicking **Start** &gt; type **wf.msc** &gt; and hit **Enter**. An outbound rule should be created based on originating service.
>
> - NLS (Network List Service) applies to:
>   - Windows Server 2022 and future iterations
>   - Windows 11
>
> - NLA (Network Location Awareness) service applies to:
>   - Windows Server 2019 and previous iterations
>   - Windows 10 and previous iterations
>
> For users behind an external hardware-based firewall, we recommend that customers work with their hardware vendors to build the appropriate rules for their environment as each have different controls and configurations in implementation. NCSI probes follow the same requirement as Windows Updates regarding allowing the hostnames through and not mapping to specific IP addresses.

## When are active probes sent?

Active probes are triggered by the following events that the NCSI monitors indicating that the network state may need to be refreshed:

- General interface or network condition changes.
- Proxy detection or changes.
- Hotspot detection or changes.

When new network conditions are met, either wired, wireless, or behind a VPN, the network interface becomes ready for use and the active probe tests for network connectivity. An example of this is when a wireless connection is established:

```
[Microsoft-Windows-NCSI/Analytic ] Transitioning to State: Interface NetReady
Interface Luid: 0x47008000000000
```

## What happens after an active probe succeeds?

A successful probe provides the following output:

```
[Microsoft-Windows-NCSI/Analytic ] Active Internet Probe finished on interface {426b6867-b0e4-4ff9-a14b-dd6a4345c24e} (true) {426b6867-b0e4-4ff9-a14b-dd6a4345c24e}, true, true, false, true, false
```

- If the probe didn’t traverse through a proxy, NCSI makes note of this.
- The network interface icon changes to reflect that Internet connectivity is accessible.
- If behind a captive portal where credentials weren't provided or doesn't allow internet access by default without further input, it's set to local capability. For more information, see [Captive portals](ncsi-overview.md#captive-portals).

## What can stop an active probe from succeeding?

Many things can prevent an active probe from reaching the internet probe server or receiving a response from a server reaching the client successfully. They are as follows:

- Proxy errors, misconfiguration, intermittent environmental conditions.
- PAC file issues that prevent packets from going to the correct proxy or even the client not being aware that a proxy exists that it must send the probe through.
- VPN configuration, setup processing delays, and misrouting of the probe to a place where it can't easily reach the internet due to connectivity time out.
- DNS server resolution issues for the well-known NCSI lookup names. These are most often intermittent problems and not missing records.

## How does passive probing determine connectivity?

If the hop count recorded for the interface is at least the system minimum, it updates the interface capability to internet. No more active probes are done for this interface unless one of the events described in “[When are active probes sent?](#when-are-active-probes-sent)” occurs.

If NCSI sees that the connectivity is local-only, the following conditions are true:

- The hop count doesn’t meet the system minimum.
- The hop count data wasn’t able to be retrieved for the specific interface.
- The routing table has no entry for the interface with a next hop to a root server on the internet.
- Active probes are enabled but no active probe has completed successfully since the interface became connected.

## What is the default system minimum hop count?

The default hop count is **8** but this isn't always optimal for enterprises. A value of **3** is suitable for most enterprise infrastructures.

> [!NOTE]
> Microsoft doesn't recommend non-enterprise users changing this hop count value as they are subject to change.

## When and how often does the passive probe run?

There are various factors that determine if a passive probe should be ran based on the passive poll information. The following must be true:

- Allowed by group policy. When group policy isn't configured, by default it’s allowed. This can be verified in group policy by navigating to **Computer Configuration\Administrative Templates\Network\Network Connectivity Status Indicator\Specify passive polling**.
- A user is logged in or has been logged in within the last 30 seconds.

If the passive probe is allowed to run, it does so every 15 seconds. This can be overridden by editing the following registry key:

```registry
HKLM\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet\PassivePollPeriod
```

## Where is the HTTP web probe server path found in the registry?

Probe content along with the predefined DNS probe host is found in the following path:

```registry
HKLM\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet
```

> [!NOTE]
> Starting with Windows 10 build 14393 (1607), web probe (HTTP) requests are sent to `www.msftconnecttest.com/connecttest.txt`.

The expected response for HTTP 200 OK should contain the payload “Microsoft Connect Test” as seen below:

```
HTTP:Request, GET /connecttest.txt
HTTP:Response, Status: Ok, URL: /connecttest.txt
```

Prior to that `www.msftncsi.com/ncsi.txt` was used, and the expected response is HTTP 200 OK with payload containing “Microsoft NCSI”.

For a DNS probe, the query is sent to "dns.msftncsi.com" as seen below:

```
Query for dns.msftncsi.com of type A on class Internet
Response - Success, 131.107.255.255
```

> [!NOTE]
> **4-c-0003.c-msedge.net** is typically recognizable as the entry point to MSFT’s services network which includes Microsoft’s hosted internet probe servers. The “4” is for IPv4. **6-c-0003.c-msedge.net** is for IPv6.

## How does NCSI know whether to use an HTTP or DNS probe?

Starting in Windows 11, HTTP is always used. You may see DNS activity but its purpose is to identify where to send the HTTP probe. Prior to this, if no proxy exists, NCSI probes using DNS. Example:

```
[Microsoft-Windows-NCSI/Analytic ] Active Internet Probe (DNS) started on interface {426b6867-b0e4-4ff9-a14b-dd6a4345c24e}
```

## Reasons for network probe failure

There are several reasons as to why a network probe may fail as seen in the table below. For any failures encountered, it's logged in the Event Viewer for investigation.

|Output|Description|
|--|--|
|ActiveDnsProbeFailed|The DNS probe failed.<br><br>**Verify via a packet capture.**|
|ActiveHttpProbeFailed|The DNS name for the probe server wasn’t resolved. NSCI failed before attempting to send the web probe request. This could be due to DNS failure, failure to connect to the proxy server, etc.<br><br>**Verify via a packet capture.**|
|ActiveHttpProbeFailedButDnsSucceeded|The probe server DNS name was resolved but the HTTP probe to that resolved IP address failed.<br><br>**Use a packet capture application and verify the data capture.**|
|ActiveHttpProbeFailedHotspotDetected|The HTTP probe didn’t get past a hotspot or captive portal.  This is typically determined when an HTTP response 200 is received but doesn’t have the text file _connecttest.txt_ in the response payload, or a non-200 HTTP status code (such as 302, 304) is received.<br><br>**This status code will normally be observed when handling issues where the wireless connection cannot be established. Verify via a packet capture. The user may need to authenticate the hotspot or the hotspot configuration may need to be modified.**|
|NoAddress|The target adapter has no preferred IP address assigned.<br><br>**There is a bigger issue involved that can't be resolved through NSCI.**|
|NoGlobalAddress|Same as NoAddress but specific to IPV6 interfaces.|
|NoRoute|The interface that the probe is being sent on has no route to the internet in the routing table.<br><br>**Some scenarios where this can happen is when a newly connected VPN hasn’t yet changed the routing table with new routes, or in forced tunnel VPN scenarios in which after the VPN interface is connected, the physical interface drops to local connectivity as the route table was modified.**|
|PassivePacketHops|**Not a failure.**<br><br>Received packets indicate some level of connectivity. This change reason is used when capability is being **raised**, not lowered.|

Here's an output of a probe failure:

```
[Microsoft-Windows-NCSI/Analytic ] Active Internet Probe finished on interface {426b6867-b0e4-4ff9-a14b-dd6a4345c24e} (false) {426b6867-b0e4-4ff9-a14b-dd6a4345c24e}, false, true, false, false, false

[Microsoft-Windows-NCSI/Operational ] Capability change on {426b6867-b0e4-4ff9-a14b-dd6a4345c24e} (0x6008001000000 Family: V4 Capability: Local ChangeReason: SuspectDnsProbeFailed) {426b6867-b0e4-4ff9-a14b-dd6a4345c24e}
```

> [!NOTE]
> If the probe failure was due to traversing a proxy NCSI will set the connectivity state to None. If the failed probe did not traverse (went direct), NCSI will set the connectivity state to Local.

## When does NCSI exit hotspot mode?

When NCSI is able to get an active probe with matching expected content “Microsoft Connect Test”. There’s nothing NCSI can do about being behind a hotspot other than detecting and reporting it. It's up to the user to authenticate with the hotspot so traffic will be allowed out to the internet.

NCSI’s responsibility to the system to accurately report connectivity as local when its' probes are being redirected. Only the internet hosted probe server should return the expected content proving internet connectivity.

An example of a probe failure may relay the following:

```
[Microsoft-Windows-NCSI/Analytic ] Active Internet Probe finished on interface {426b6867-b0e4-4ff9-a14b-dd6a4345c24e} (false)
{426b6867-b0e4-4ff9-a14b-dd6a4345c24e}, false, true, false, false, false

[Microsoft-Windows-NCSI/Operational ] Capability change on {426b6867-b0e4-4ff9-a14b-dd6a4345c24e}
(0x6008001000000 Family: V4 Capability: Local ChangeReason: SuspectDnsProbeFailed){426b6867-b0e4-4ff9-a14b-dd6a4345c24e}
```

## Why does Windows sometimes open a browser when I connect to a network?

This behavior is by design. Windows wants users to know when they connect to a network that requires captive portal authentication. Windows used to display a small popup for a short duration encouraging users to select it to open a browser. Users would often miss this not knowing it would open a browser for authentication. For more, see [a browser opens when connecting to a corporate or public network](/troubleshoot/windows-client/networking/internet-explorer-edge-open-connect-corporate-public-network).

## Where can I find public documentation stating msftconnecttest.com must be in the allowlist?

The following list of URLs mention or imply `msftconnecttext.com`:

- [Network Connection Status Indicator](/windows/privacy/manage-connections-from-windows-operating-system-components-to-microsoft-services#14-network-connection-status-indicator)
- [Windows 11 Enterprise connection endpoints](/windows/privacy/manage-windows-11-endpoints#windows-11-enterprise-connection-endpoints)
- [Connection endpoints for non-Enterprise editions of Windows](/windows/privacy/windows-endpoints-21h1-non-enterprise-editions)
- [NCSI active probes and the network status alert](/troubleshoot/windows-client/networking/internet-explorer-edge-open-connect-corporate-public-network#ncsi-active-probes-and-the-network-status-alert)

## How does Microsoft Office use NCSI to determine internet connectivity?

This is done by Microsoft Office making an API call to [**get_IsConnectedToInternet**](/windows/win32/api/netlistmgr/nf-netlistmgr-inetworklistmanager-get_isconnectedtointernet). If applications such as Microsoft Office is able to indicate no internet connectivity, but you're able to browse websites, this indicates an NCSI problem. If you can't browse or perform other basic network operations, this may be a general network issue, and NCSI troubleshooting wouldn't apply.

The taskbar network icon relies on NCSI and the same rule above applies even if it indicates no network activity. This could be due to a more generic network issue other than NCSI.

## Does Linux have its own NCSI?

Linux doesn't have built-in APIs (Application Programming Interface) for applications to check for continuous internet connectivity changes. They must implement their own network checks from the ground up, or use various Linux utilities to continuously check over time for changing network conditions.

Additionally, some Linux applications don't perform connectivity checks. They send the packets and handle errors after the fact whereas NCSI allows applications to alert the user of immediate connectivity problems.

> [!NOTE]
> The enterprise must ensure their infrastructure doesn't block a simple HTTP or DNS active probe. This can happen if any of the following are misconfigured:
>
> - Blocked firewalls
> - DNS servers
> - Forced VPN tunneling
> - Proxy servers
> - Routers
> - Third-party software intercepting the probe
>
> For general consumers, there are less potential hindrances that do not require user configuration out of the box. Issues occur when VPNs or third-party software are introduced which can intercept, misroute, or delay NCSI active probes.

## Additional references

- [NCSI Overview](ncsi-overview.md)
- [NCSI Troubleshooting Guide](ncsi-troubleshooting-guide.md)
