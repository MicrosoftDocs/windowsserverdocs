---
title: Network Connectivity Status Indicator Overview
description: 'The Network Connectivity Status Indicator (NCSI) helps troubleshoot connectivity issues via network probing methods.'
ms.topic: article
ms.date: 04/06/2023
ms.author: alalve
author: rnitsch
---

# NCSI overview

Network Connectivity Status Indicator (NCSI) is a departure from traditional workflows in that it attempts to do a lot more than just teach how to troubleshoot the affected component. This overview explains how NCSI functions when probing the network for internet connectivity.

## NCSI functionality

NCSI uses network probes that are network requests sent to an endpoint followed by a response. There are many different types of probes including active, passive, corporate, proxy, default gateway, and others. In addition, some probes are performed via HTTP, DNS, or both.

### What is the purpose of NCSI in Windows?

NCSI is the component responsible for determining network connectivity exists and if it's Internet or local-only. The reason NCSI was developed to save applications the complex task of determining network configuration on its own. Every attempt to perform a task over the network would require constant attention to whether the network was still accessible. In a network outage, even intermittently, the application would time out the operation and tests the network continuously until the connection is stable.

This seems trivial until you consider that it must perform checks for a multitude of environmental factors such as being behind a proxy or hotspot/captive portal. NCSI must know if the network it detects is one that can satisfy its requests. Does it need full internet or private corporate access? Users must wait for their actions to either complete or time out while the application makes this determination when deciding how to handle restrictive or no network connectivity scenarios.

### Active probing

An active probe can either be a request sent to a web probe server or a DNS lookup for a specific NCSI address. The server is hosted by Microsoft on the internet but can also be an enterprise’s own private probe server, which is a more uncommon scenario. When NCSI sends the probe and receives a valid response, it considers the client machine to have internet connectivity. If a user connects to a new wireless network that has no internet connectivity NCSI shouldn't wait for a passive probe to trend received packets during a network change event and triggers an active probe.

When NCSI doesn’t detect internet connectivity, it doesn’t necessarily mean that there's an issue with active probing. It's more likely that the probe isn't completing due to the device, network configuration, or other environmental issue.

> [!WARNING]
> Do not disable active probing as a resolution to a NCSI issue as passive probing alone is unable to determine all network connectivity issues.

The HTTP probe hosts and contents are predefined and found in the following registry path: "**HKLM\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet**".

NCSI sends separate IPv4 and IPv6 active probes in parallel. During network connectivity, it's rare that the IPv6 probe is of concern. It's primarily the IPv4 probe that needs to succeed, although it's true that an IPv4 probe can fail and the IPv6 succeeds resulting in internet connectivity.

### Passive probing

Similar to active probing, passive probing uses learned information from received packets to determine network status. Both probing methods complement one another as they determine intermittent network conditions differently. Certain conditions prevent active probes from functioning correctly, such as, a temporary router having intermittent connectivity issue where a client machine doesn't experience any change in the interface state. No additional active probes are sent until the client machine changes to passive probing which can determine the connectivity status due to lack of inbound packets from the internet.

> [!NOTE]
> As of Windows 11, NCSI is hosted within the Network List Service (aka the Network Profile Manager). Previous OS iterations were hosted in the Network Location Awareness (NLA) service.

The main goal of the passive probe is to update NCSI’s connectivity status for all active network interfaces based on packet data received. For each active interface, the probe can update the status to either internet or local by constantly inspecting inbound packets for the number of hops traversed from the sender.

Both active and passive probing may encounter issue's. To learn more, see [reasons for network probe failure](ncsi-frequently-asked-questions.md#reasons-for-network-probe-failure).

### Proxies

NCSI works together with proxies in two main ways:

1. Discovering proxies and storing proxy information.
1. Using stored proxy information in the execution of active probes.

 The most common problems with active probes not leaving enterprise network spaces to the internet are due to proxies:

- A proxy exists but isn't yet discovered by NCSI.
- A proxy was discovered by NCSI but the client machine can't reach it at the time of the probe.
- The Proxy Auto-Config (PAC) file is misconfigured and hasn't mapped `www.msftconnecttest.com` to the correct proxy.
- The proxy is misconfigured.

NCSI will detect a manually provisioned proxy address from the following registry path: "**HKLM\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet\ManualProxies**".

NCSI performs an active probe if the above fails including if there aren't any stored proxy information. To learn about additional reasons for proxy failures, see [when are proxy detection requests triggered?](ncsi-frequently-asked-questions.md#when-are-proxy-detection-requests-triggered) and [how are proxies detected?](ncsi-frequently-asked-questions.md#how-are-proxies-detected).

> [!TIP]
> In Windows 10, users can perform manual proxy configuration by navigating to **Start** > **Settings** > **Network & Internet** > **Proxy** > **Manual proxy setup**.

### Hotspots

In the same way that NCSI detects proxies inside an enterprise in order to successfully navigate a probe to the internet, it also determines hindrances outside of an enterprise environment for consumers on mobile devices. Hotspots and captive portals are largely found in public environments such as airports, hospitals, coffee shops, etc. but can also be gateways in satellite extensions of enterprise networks.

Because most captive portals send an HTTP redirect in response to the probe instead of allowing it through to the internet, this is how NCSI is able to determine if it’s behind a hotspot as long as the conditions below are true:

- An active HTTP probe was sent but not via a known proxy.
- The probe got a response.
- The response payload didn't match the expected content: “Microsoft Connect Test”.

Whenever NCSI is behind a known hotspot, it moves into “hotspot mode” during which it ignores receipt of passive probed internet packets. Hotspot mode also exits after a default of 60 hotspot polls.

## Additional references

[NCSI Troubleshooting Guide](ncsi-troubleshooting-guide.md)
[NCSI FAQ](ncsi-frequently-asked-questions.md)
