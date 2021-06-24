---
description: "Learn more about: Health Service actions"
title: Health Service actions
manager: eldenc
ms.author: cosdar
ms.topic: article
author: cosmosdarwin
ms.date: 06/18/2021
---
# Health Service actions

> Applies to: Azure Stack HCI, version 20H2; Windows Server 2019, Windows Server 2016

The Health Service is a new feature in Windows Server 2016 that improves the day-to-day monitoring and operational experience for clusters running Storage Spaces Direct.

## Actions

The next section describes workflows that are automated by the Health Service. To verify that an action is indeed being taken autonomously, or to track its progress or outcome, the Health Service generates "Actions". Unlike logs, Actions disappear shortly after they have completed, and are intended primarily to provide insight into ongoing activity that may impact performance or capacity (for example restoring resiliency or rebalancing data).

### Usage

One new PowerShell cmdlet displays all Actions:

```PowerShell
Get-StorageHealthAction
```

### Coverage

In Windows Server 2016, the **Get-StorageHealthAction** cmdlet can return any of the following information:

-   Retiring failed, lost connectivity, or unresponsive physical disk

-   Switching storage pool to use replacement physical disk

-   Restoring full resiliency to data

-   Rebalancing storage pool

## Additional References

- [Health Service in Windows Server 2016](health-service-overview.md)
- [Developer documentation, sample code, and API reference on MSDN](https://msdn.microsoft.com/windowshealthservice)
