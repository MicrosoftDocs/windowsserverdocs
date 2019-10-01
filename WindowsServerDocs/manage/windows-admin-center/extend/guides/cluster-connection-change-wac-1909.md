---
title: Cluster connection type changes in Windows Admin Center v1909
description: Cluster connection type changes in Windows Admin Center v1909
ms.technology: manage
ms.topic: article
author: daniellee-msft
ms.author: jol
ms.date: 10/01/2019
ms.localizationpriority: medium
ms.prod: windows-server-threshold
---

# Cluster connection type changes in Windows Admin Center v1909

>Applies To: Windows Admin Center, Windows Admin Center Preview

> [!IMPORTANT]
> This document describes the changes required by Windows Admin Center extension developers that are developing Windows Admin Center tools for failover cluster and hyper-converged cluster (HCI) solutions. This is a mandatory change required for your extension to be compatible with Windows Admin Center v1909 Preview release and future GA releases.

In Windows Admin Center v1909, we have unified the two different cluster connection types (failover cluster and hyper-converged cluster connections) into a single cluster connection type. Users will no longer need to identify a cluster’s configuration ahead of time to decide which connection type to add the cluster as, nor add the cluster twice as different connection types to get access to the different tool sets. Clusters can now be added as a “Windows Server cluster” and the appropriate tools will be loaded, primarily based on whether Storage Spaces Direct is enabled or not.

Since this required a change in the connection type definition and how cluster-related tools decide when to be loaded, extensions that provide tools for clusters (either HCI or non-HCI clusters, or both) will require the changes in the implementation as described below.

## manifest.json - solutionsIds and connectionTypes

Previously, to make your tool be displayed for a failover cluster or HCI cluster connection type, you would have used one of the following definitions in the ```manifest.json``` file.

For failover clusters:
``` json
{
    "entryPointType": "tool",
    "name": "MyToolName",
    "urlName": "MyToolUrl",
    "displayName": "MyToolDisplayName",
    "description": "MyToolDescription",
    "icon": "MyToolIcon",
    "path": "MyToolPath",
    "iframeId": "MyToolIframeId",
    "requirements": [
    {
        "solutionIds": [
            "msft.sme.failover-cluster!failover-cluster"
        ],
        "connectionTypes": [
            "msft.sme.connection-type.cluster"
        ]
    }
    ]
}
```

