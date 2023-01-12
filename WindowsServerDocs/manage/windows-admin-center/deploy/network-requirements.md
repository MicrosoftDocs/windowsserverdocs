---
title: Windows Admin Center network requirements
description: Networking requirements to use Windows Admin Center
ms.topic: article
author: prasidharora
ms.author: praror
ms.date: 01/12/2023
---

# Windows Admin Center network requirements

>Applies to: Windows Admin Center, Windows Admin Center Preview

This article describes the networking requirements for using Windows Admin center to manage your servers and clusters.

## Networking configuration

Windows Admin Center communicates outbound securely to endpoints over TCP port 443. By default, the Windows Admin Center gateway and browser uses the default route to the internet to perform actions. You can optionally configure the gateway to use a proxy server if your network requires it.

Endpoints need to be opened on two sources:

- The gateway - this is the server or client machine where the Windows Admin Center gateway (.msi) is installed.
- The browser - this is the machine where the Windows Admin Center web service is being accessed from.

If outbound connectivity is restricted by your firewall or proxy server, make sure the URLs listed below are not blocked.

## Gateway URLs

| URL | Description | When required |
| ------------------------- |--------------- | ----- |
| `aka.ms` | Acquiring and maintaining Windows Admin Center | Always |
| `download.microsoft.com` | Acquiring and maintaining Windows Admin Center | Always |
| `pkgs.dev.azure.com` | Extension management | Always |
| `*.vsblob.vsassets.io` | Extension management | Always |
| `login.microsoftonline.com` | Azure endpoints for communication | When using Azure Hybrid Services in the Azure Public Cloud |
| `graph.microsoft.com` | Azure endpoints for communication | When using Azure Hybrid Services in the Azure Public Cloud |
| `graph.windows.net` | Azure endpoints for communication | When using Azure Hybrid Services in the Azure Public Cloud |
| `management.azure.com` | Azure endpoints for communication | When using Azure Hybrid Services in the Azure Public Cloud |
| `login.microsoftonline.us` | Azure endpoints for communication | When using Azure Hybrid Services in the Azure US Government Cloud |
| `management.usgovcloudapi.net` | Azure endpoints for communication | When using Azure Hybrid Services in the Azure US Government Cloud |
| `graph.windows.net` | Azure endpoints for communication | When using Azure Hybrid Services in the Azure US Government Cloud |
| `management.core.usgovcloudapi.net` | Azure endpoints for communication | When using Azure Hybrid Services in the Azure US Government Cloud |
| `login.partner.microsoftonline.cn` | Azure endpoints for communication | When using Azure Hybrid Services in the Azure China Cloud |
| `management.chinacloudapi.cn` | Azure endpoints for communication | When using Azure Hybrid Services in the Azure China Cloud |
| `graph.chinacloudapi.cn` | Azure endpoints for communication | When using Azure Hybrid Services in the Azure China Cloud |
| `management.core.chinacloudapi.cn` | Azure endpoints for communication | When using Azure Hybrid Services in the Azure China Cloud |

### Browser URLs

| URL | Description | When required |
| ------------------------- |--------------- | ----- |
| `winadmincenterassets.blob.core.windows.net` | Extension management | Always |
| `js.monitor.azure.com` | Extension management | Always |
| `nuget.org` | Extension management | Always |
| `announcements.blob.core.windows.net` | Extension management | Always |
| `browser.events.data.microsoft.com` | Acquiring and maintaining Windows Admin Center | Optionally |
| `login.microsoftonline.com` | Azure endpoints for communication | When using Azure Hybrid Services in the Azure Public Cloud |
| `graph.microsoft.com` | Azure endpoints for communication | When using Azure Hybrid Services in the Azure Public Cloud |
| `graph.windows.net` | Azure endpoints for communication | When using Azure Hybrid Services in the Azure Public Cloud |
| `portal.azure.com` | Azure endpoints for communication | When using Azure Hybrid Services in the Azure Public Cloud |
| `login.microsoftonline.us` | Azure endpoints for communication | When using Azure Hybrid Services in the Azure US Government Cloud |
| `management.usgovcloudapi.net` | Azure endpoints for communication | When using Azure Hybrid Services in the Azure US Government Cloud |
| `graph.windows.net` | Azure endpoints for communication | When using Azure Hybrid Services in the Azure US Government Cloud |
| `portal.azure.us` | Azure endpoints for communication | When using Azure Hybrid Services in the Azure US Government Cloud |
| `login.partner.microsoftonline.cn` | Azure endpoints for communication | When using Azure Hybrid Services in the Azure China Cloud |
| `management.chinacloudapi.cn` | Azure endpoints for communication | When using Azure Hybrid Services in the Azure China Cloud |
| `graph.chinacloudapi.cn` | Azure endpoints for communication | When using Azure Hybrid Services in the Azure China Cloud |
| `portal.azure.cn` | Azure endpoints for communication | When using Azure Hybrid Services in the Azure China Cloud |

## Next steps

- [Prepare your environment](prepare-environment.md)
- [Install Windows Admin Center](install.md)
