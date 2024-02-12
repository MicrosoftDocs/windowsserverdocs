---
title: Network guidelines
description: Bandwidth recommendations for Remote Desktop deployments.
ms.author: helohr
ms.date: 12/12/2019
ms.topic: article
author: Heidilohr
manager: femila
---
# Network guidelines

When using a remote Windows session, your network's available bandwidth greatly impacts the quality of your experience. Different applications and display resolutions require different network configurations, so it's important to make sure your network is configured to meet your needs.

>[!NOTE]
>The following recommendations apply to networks with less than 0.1% loss. These recommendations apply regardless of how many sessions you're hosting on your virtual machines (VMs).

## Applications

The following table lists the minimum recommended bandwidths for a smooth user experience. These recommendations are based on the guidelines in [Remote Desktop workloads](remote-desktop-workloads.md).

| Workload type   | Recommended bandwidth |
|-----------------|-----------------------|
| Light           | 1.5 Mbps              |
| Medium          | 3 Mbps                |
| Heavy           | 5 Mbps                |
| Power           | 15 Mbps               |

Keep in mind that the stress put on your network depends on both your app workload's output frame rate and your display resolution. If either the frame rate or display resolution increases, the bandwidth requirement will also rise. For example, a light workload with a high-resolution display requires more available bandwidth than a light workload with regular or low resolution.

Other scenarios can have their bandwidth requirements change depending on how you use them, such as:

- Voice or video conferencing
- Real-time communication
- Streaming 4K video

Make sure to load test these scenarios in your deployment using simulation tools like Login VSI. Vary the load size, run stress tests, and test common user scenarios in remote sessions to better understand your network's requirements.

## Display resolutions

Different display resolutions require different available bandwidths. The following table lists the bandwidths we recommend for a smooth user experience at typical display resolutions with a frame rate of 30 frames per second (fps). These recommendations apply to single and multiple user scenarios. Keep in mind that scenarios involving a frame rate under 30 fps, such as reading static text, require less available bandwidth.

| Typical display resolutions at 30 fps    | Recommended bandwidth |
|------------------------------------------|-----------------------|
| About 1024 × 768 px                      | 1.5 Mbps              |
| About 1280 × 720 px                      | 3 Mbps                |
| About 1920 × 1080 px                     | 5 Mbps                |
| About 3840 × 2160 px (4K)                | 15 Mbps               |

## Azure Virtual Desktop experience estimator

The Azure region you're in can affect user experience as much as network conditions. Check out the [Azure Virtual Desktop experience estimator](https://azure.microsoft.com/services/virtual-desktop/assessment/) to learn more.

## Assistive technologies

Assistive technology workloads, like using Narrator in the remote session, require connections with a connection round trip time (RTT) of 20 milliseconds (ms) or better for the best user experience.
