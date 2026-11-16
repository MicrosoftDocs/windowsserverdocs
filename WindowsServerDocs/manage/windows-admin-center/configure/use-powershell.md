---
title: Use PowerShell to manage Windows Admin Center settings
description: Learn how to use PowerShell to manage Windows Admin Center settings, including connection lists and extensions, across multiple servers in Administration Mode.
ms.topic: how-to
author: robinharwood
ms.author: roharwoo
ms.date: 11/21/2019
ai-usage: ai-assisted
---

# Use PowerShell to manage Windows Admin Center settings

If you have a large organization with multiple Windows Admin Center servers, you can use PowerShell to configure the list of connections and extensions on multiple servers at a time. The connection and extension commands in this article configure Windows Admin Center in Administration Mode. They aren't general automation guidance for Windows Admin Center in Virtualization Mode.

## Import or export Windows Admin Center connections and tags with PowerShell

[!INCLUDE [ps-connections](../includes/ps-connections.md)]

## Manage Windows Admin Center extensions with PowerShell

[!INCLUDE [ps-extensions](../includes/ps-extensions.md)]

### Additional References

* [Deploy a highly available Windows Admin Center gateway on a cluster](../deploy/high-availability.md)
* [Deploy a Windows Admin Center gateway in Azure using Cloud Shell](../azure/deploy-wac-in-azure.md)

