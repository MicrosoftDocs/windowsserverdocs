---
title: Network Connectivity Status Indicator overview for Windows
description: The Network Connectivity Status Indicator (NCSI) helps to detect network connectivity and troubleshoot via network probing and passive polling.
ms.topic: article
ms.date: 06/23/2023
ms.author: wscontent
author: xelu86
ms.contributors: rnitsch
---

# NCSI overview

> [!IMPORTANT]
> The public NCSI probe servers formerly hosted by Azure Front Door are now being hosted by Akamai. This change occurred on June 20, 2023. To better understand how this affects users, see our [NCSI FAQ](ncsi-frequently-asked-questions.md) page.

The Network Connectivity Status Indicator (NCSI) is a feature that helps to provide a visual display of the current network connection status. The NCSI icon is found on the bottom-right of the taskbar by default. Depending on how your device is connected to the network and what operating system you're running will determine its appearance.

|Icon|Description|
|--|--|
|:::image type="icon" source="../media/ncsi/ncsi-overview/ncsi-icon-connected-wired.jpg":::| Connected (Wired) |
|:::image type="icon" source="../media/ncsi/ncsi-overview/ncsi-icon-connected-wireless.jpg":::| Connected (Wireless) |
|:::image type="icon" source="../media/ncsi/ncsi-overview/ncsi-icon-connected-no-internet.jpg":::| Connected (No internet) |

The network status can be viewed by clicking this icon and further network adapter details can be seen by following the **Network and Internet settings** link. Depending on the version of Windows you're running, the taskbar options for the NCSI icon may vary.

## NCSI functionality

NCSI uses network probes that are network requests sent to an endpoint followed by a response. NCSI’s probe, referred to as an “active probe”, is an HTTP request/response. It also uses passive polling, referred to as "passive probe", which examines network traffic passively to determine connectivity.

### What is the purpose of NCSI in Windows?

NCSI is the component responsible for determining network connectivity exists and if it's Internet or local-only. The reason NCSI was developed to save applications the complex task of determining network configuration on its own. Every attempt to perform a task over the network would require constant attention to whether the network was still accessible. In a network outage, even intermittently, the application would time out the operation and tests the network continuously until the connection is stable.

This seems trivial until you consider that it must perform checks for a multitude of environmental factors such as being behind a proxy, hotspot, or captive portal. NCSI must know if the network it detects is one that can satisfy its requests. Does it need full internet or private corporate access? Users must wait for NCSI to either complete or time out while the application determines how to handle restrictive or no network connectivity scenarios.

### Active probing

An active probe is an http request sent to a web probe server for a specific NCSI address. The server is hosted by Microsoft on the internet but can also be an enterprise’s own private probe server, which is a more uncommon scenario. When NCSI sends the probe and receives a valid response, it considers the client device to have internet connectivity.

When NCSI doesn’t detect internet connectivity, it's either that the probe isn't completing, or the probe is completing with failure. Some reasons for not completing can be device, network configuration, or other environmental issues. An example of completing with a failure is receiving an **HTTP 403 Forbidden** response, usually indicating a proxy blocked the outbound probe.

> [!WARNING]
> Do not disable active probing as a resolution to a NCSI issue as passive polling alone is unable to determine all network connectivity issues.

The HTTP probe hosts and contents are predefined and found in the following registry path:

```registry
HKLM\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet
```

NCSI sends separate IPv4 and IPv6 active probes in parallel. If either probe succeeds, NCSI determines that the device has internet connectivity.

### Passive probing

Similar to active probing, passive probing uses learned information from received packets to determine network status. Both probing methods complement one another as they determine intermittent network conditions differently. Certain conditions prevent active probes from functioning correctly, such as, a temporary router having intermittent connectivity issue where a client device doesn't experience any change in the interface state. In case of such intermittent connectivity issues, which can cause active probing to have false negative results, passive polling can determine the connectivity status due to network traffic and keep internet connectivity.

> [!NOTE]
> As of Windows 11, NCSI is hosted within the Network List Manager service, also known as the Network Profile Manager. Previous OS iterations were hosted in the Network Location Awareness (NLA) service.

The main goal of the passive probe is to update NCSI’s connectivity status for all active network interfaces based on packet data received. For each active interface, the probe can update the status to either internet or local by constantly inspecting inbound packets for the number of hops traversed from the sender.

Both active and passive probing may encounter issues. To learn more, see [reasons for network probe failure](ncsi-frequently-asked-questions.md#reasons-for-network-probe-failure).

### Proxies

NCSI works together with proxies by using stored proxy information in the execution of active probes. The most common problems with active probes not leaving enterprise network spaces to the internet are due to:

- A proxy exists but isn't yet discovered.
- A proxy was discovered but the client device can't reach it at the time of the probe.
- The Proxy Auto-Config (PAC) file is misconfigured and hasn't mapped `www.msftconnecttest.com` to the correct proxy.
- The proxy is misconfigured.

NCSI will detect a manually provisioned proxy address from the following registry path:

```registry
HKLM\SYSTEM\CurrentControlSet\Services\NlaSvc\Parameters\Internet\ManualProxies
```

> [!TIP]
> In Windows 10, users can perform manual proxy configuration by navigating to **Start** > **Settings** > **Network & Internet** > **Proxy** > **Manual proxy setup**.

### Captive portals

In the same way that NCSI detects proxies inside an enterprise in order to successfully navigate a probe to the internet, it also determines hindrances outside of an enterprise environment for consumers on mobile devices. Captive portals are largely found in public environments such as airports, hospitals, coffee shops, etc. but can also be gateways in satellite extensions of enterprise networks.

Captive portals may send an HTTP redirect or an empty response to the probe instead of allowing it through to the internet. This is how NCSI is able to determine if it’s behind a captive portal as long as the conditions below are true:

- An active HTTP probe was sent but not via a known proxy.
- The probe got a response.
- The response payload didn't match the expected content: “Microsoft Connect Test”.

## Additional references

- [NCSI Troubleshooting Guide](ncsi-troubleshooting-guide.md)
- [NCSI FAQ](ncsi-frequently-asked-questions.md)
