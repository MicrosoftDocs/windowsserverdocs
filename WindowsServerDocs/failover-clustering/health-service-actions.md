---
title: Health Service actions
ms.prod: windows-server-threshold
manager: eldenc
ms.author: cosdar
ms.technology: storage-health-service
ms.topic: article
ms.assetid:
author: cosmosdarwin
ms.date: 08/14/2017
---
# Health Service actions

> Applies to: Windows Server 2019, Windows Server 2016

The Health Service is a new feature in Windows Server 2016 that improves the day-to-day monitoring and operational experience for clusters running Storage Spaces Direct.

## Actions  

The next section describes workflows which are automated by the Health Service. To verify that an action is indeed being taken autonomously, or to track its progress or outcome, the Health Service generates "Actions". Unlike logs, Actions disappear shortly after they have completed, and are intended primarily to provide insight into ongoing activity which may impact performance or capacity (e.g. restoring resiliency or rebalancing data).  

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

## See also

- [Health Service in Windows Server 2016](health-service-overview.md)
- [Developer documentation, sample code, and API reference on MSDN](https://msdn.microsoft.com/windowshealthservice)
