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

Gateway administrators can use Windows Admin Center PowerShell modules to manage connection lists and extensions across multiple Windows Admin Center servers running in Administration Mode. This approach helps you apply consistent configuration without updating each server individually. These commands don't provide general automation for Windows Admin Center in Virtualization Mode.

In this article, you use PowerShell to import and export connections and tags, and to manage extension feeds and packages.

## Import or export Windows Admin Center connections and tags with PowerShell

[!INCLUDE [ps-connections](../includes/ps-connections.md)]

## Manage Windows Admin Center extensions with PowerShell

[!INCLUDE [ps-extensions](../includes/ps-extensions.md)]

### Additional References

* [Deploy a highly available Windows Admin Center gateway on a cluster](../deploy/high-availability.md)
* [Deploy a Windows Admin Center gateway in Azure using Cloud Shell](../azure/deploy-wac-in-azure.md)

