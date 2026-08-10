---
title: Windows Admin Center Network Requirements
description: Networking requirements to use Windows Admin Center.
ms.topic: concept-article
author: robinharwood
ms.author: roharwoo
ms.date: 01/12/2023
---

# Windows Admin Center network requirements

This article describes the networking requirements for using Windows Admin Center to manage your servers and clusters.

## Networking configuration

Windows Admin Center communicates outbound securely to endpoints over TCP port 443. By default, the Windows Admin Center gateway and browser use the default route to the internet to perform actions. You can optionally configure the gateway to use a proxy server if your network requires it.

You need to open endpoints on two sources:

- **Gateway**: This server or client machine is where you install the Windows Admin Center gateway (.exe).
- **Browser**: This machine is where you access the Windows Admin Center web service.

If your firewall or proxy server restricts outbound connectivity, make sure that it doesn't block the URLs listed in the following section.

## Gateway URLs

| URL | Description | When required |
| ------------------------- |--------------- | ----- |
| `aka.ms` | Acquire and maintain Windows Admin Center | Always. |
| `download.microsoft.com` | Acquire and maintain Windows Admin Center | Always. |
| `pkgs.dev.azure.com` | Extension management | Always. |
| `*.vsblob.visualstudio.com` | Extension management | Always. |
| `login.microsoftonline.com` | Azure endpoints for communication | When you use Azure Hybrid Services in the Azure public cloud. |
| `graph.microsoft.com` | Azure endpoints for communication | When you use Azure Hybrid Services in the Azure public cloud. |
| `graph.windows.net` | Azure endpoints for communication | When you use Azure Hybrid Services in the Azure public cloud. |
| `management.azure.com` | Azure endpoints for communication | When you use Azure Hybrid Services in the Azure public cloud. |
| `login.microsoftonline.us` | Azure endpoints for communication | When you use Azure Hybrid Services in the Azure US Government cloud. |
| `management.usgovcloudapi.net` | Azure endpoints for communication | When you use Azure Hybrid Services in the Azure US Government cloud. |
| `graph.windows.net` | Azure endpoints for communication | When you use Azure Hybrid Services in the Azure US Government cloud. |
| `management.core.usgovcloudapi.net` | Azure endpoints for communication | When you use Azure Hybrid Services in the Azure US Government cloud. |
| `login.partner.microsoftonline.cn` | Azure endpoints for communication | When you use Azure Hybrid Services in Azure operated by 21Vianet. |
| `management.chinacloudapi.cn` | Azure endpoints for communication | When you use Azure Hybrid Services in Azure operated by 21Vianet. |
| `graph.chinacloudapi.cn` | Azure endpoints for communication | When you use Azure Hybrid Services in Azure operated by 21Vianet. |
| `management.core.chinacloudapi.cn` | Azure endpoints for communication | When you use Azure Hybrid Services in Azure operated by 21Vianet. |

### Browser URLs

| URL | Description | When required |
| ------------------------- |--------------- | ----- |
| `winadmincenterassets.blob.core.windows.net` | Extension management | Always. |
| `js.monitor.azure.com` | Extension management | Always. |
| `nuget.org` | Extension management | Always. |
| `announcements.blob.core.windows.net` | Extension management | Always. |
| `browser.events.data.microsoft.com` | Acquire and maintain Windows Admin Center | Optionally. |
| `login.microsoftonline.com` | Azure endpoints for communication | When you use Azure Hybrid Services in the Azure public cloud. |
| `graph.microsoft.com` | Azure endpoints for communication | When you use Azure Hybrid Services in the Azure public cloud. |
| `graph.windows.net` | Azure endpoints for communication | When you use Azure Hybrid Services in the Azure public cloud. |
| `portal.azure.com` | Azure endpoints for communication | When you use Azure Hybrid Services in the Azure public cloud. |
| `login.microsoftonline.us` | Azure endpoints for communication | When you use Azure Hybrid Services in the Azure US Government cloud. |
| `management.usgovcloudapi.net` | Azure endpoints for communication | When you use Azure Hybrid Services in the Azure US Government cloud. |
| `graph.windows.net` | Azure endpoints for communication | When you use Azure Hybrid Services in the Azure US Government cloud. |
| `portal.azure.us` | Azure endpoints for communication | When you use Azure Hybrid Services in the Azure US Government cloud. |
| `login.partner.microsoftonline.cn` | Azure endpoints for communication | When you use Azure Hybrid Services in Azure operated by 21Vianet. |
| `management.chinacloudapi.cn` | Azure endpoints for communication | When you use Azure Hybrid Services in Azure operated by 21Vianet. |
| `graph.chinacloudapi.cn` | Azure endpoints for communication | When you use Azure Hybrid Services in Azure operated by 21Vianet. |
| `portal.azure.cn` | Azure endpoints for communication | When you use Azure Hybrid Services in Azure operated by 21Vianet. |

## Related content

- [Prepare your environment](prepare-environment.md)
- [Install Windows Admin Center](install.md)