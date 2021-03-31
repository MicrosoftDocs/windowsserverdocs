---
title: Use PowerShell to manage Windows Admin Center settings
description: Learn how to use PowerShell to Manage Windows Admin Center Settings and Configuration
ms.topic: article
author: jwwool
ms.author: jeffrew
ms.date: 11/21/2019
ms.localizationpriority: medium
---

# Use PowerShell to manage Windows Admin Center settings

If you have a large organization with multiple Windows Admin Center servers, you can use PowerShell to configure the list of connections and extensions on multiple servers at a time.

## Use PowerShell to import or export your connections (with tags)

[!NOTE] With version 2103 there is a known bug with the included modules requiring modification to the header parameters shown in this [Gist](https://gist.github.com/Snozzberries/3ed0a64f691b262d2b5edcbfdf4d2a37).

[!INCLUDE [ps-connections](../includes/ps-connections.md)]

## Manage Windows Admin Center extensions with PowerShell

[!INCLUDE [ps-extensions](../includes/ps-extensions.md)]

### Additional References

* [Deploy a highly available Windows Admin Center gateway on a cluster](../deploy/high-availability.md)
* [Deploy a Windows Admin Center gateway in Azure using Cloud Shell](../azure/deploy-wac-in-azure.md)
