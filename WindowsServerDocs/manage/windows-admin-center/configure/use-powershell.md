---
title: Use PowerShell to Manage Windows Admin Center Settings and Configuration 
description: Learn how to use PowerShell to Manage Windows Admin Center Settings and Configuration 
ms.technology: manage
ms.topic: article
author: jwwool
ms.author: jeffrew
ms.date: 11/21/2019
ms.localizationpriority: medium
ms.prod: windows-server
---

# Use PowerShell to Manage Windows Admin Center Settings and Configuration

If you have a large organization with multiple Windows Admin Center gateways, you may want to use automation to configure those gateways. Using PowerShell, you can programatically configure the connection lists and extensions.

> [!NOTE]
> Modifying the shared connections or extensions is limited to gateway administrators - any user can use PowerShell to modify their personal connection list.


## Use PowerShell to import or export your connections (with tags)

[!INCLUDE [ps-connections](../includes/ps-connections.md)]

## Manage Windows Admin Center extensions with PowerShell

[!INCLUDE [ps-extensions](../includes/ps-extensions.md)]

### See also

* [Deploy a highly available Windows Admin Center gateway on a cluster](../deploy/high-availability.md)
* [Deploy a Windows Admin Center gateway in Azure using Cloud Shell](../azure/deploy-wac-in-azure.md)
