---
title: Cluster connection type changes in Windows Admin Center v1909
description: Cluster connection type changes in Windows Admin Center v1909
ms.technology: manage
ms.topic: article
author: daniellee-msft
ms.author: jol
ms.date: 10/01/2019
ms.localizationpriority: medium
ms.prod: windows-server
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

For HCI clusters, the highlighted section above would have been replaced with the following:
``` json
    "requirements": [
    {
        "solutionIds": [
            "msft.sme.software-defined-data-center!SDDC"
        ],
        "connectionTypes": [
            "msft.sme.connection-type.hyper-converged-cluster"
        ]
    }
    ]
```

In Windows Admin Center 1909 and above, the two solutionIds and connectionTypes have been replaced with the following:
``` json
    "requirements": [
    {
        "solutionIds": [
            "msft.sme.software-defined-data-center!cluster"
        ],
        "connectionTypes": [
            "msft.sme.connection-type.cluster"
        ]
    }
    ]
```

This is the only cluster-related solutionIds and connectionTypes type supported from now on. If your tool is only defined with this solutionIds and connectionTypes type, it will be loaded for any failover cluster connection, regardless of whether it is an HCI cluster or not. If you would like to limit your tool to only be available for HCI clusters or non-HCI clusters, you will need to additionally use the new inventory properties described in the following section.

## manifest.json – inventory properties
When connecting to a server or cluster, Windows Admin Center will query a set of inventory properties that you can use to build conditions to determine when your tool should be available or not (See the “Inventory properties” section in the [Control your tool’s visibility](dynamic-tool-display.md) document for more info). In Windows Admin Center v1909, we have added two new properties to this list that can be used to determine whether a cluster is a hyper-converged cluster or not. 

### isS2dEnabled
Technically, a hyper-converged cluster is defined as a failover cluster with Storage Spaces Direct (S2D) enabled. If you want your tool to be only available for hyper-converged clusters, i.e., when S2D is enabled, add the following inventory condition:
``` json
    "requirements": [
    {
        "solutionIds": [
            "msft.sme.software-defined-data-center!cluster"
        ],
        "connectionTypes": [
            "msft.sme.connection-type.cluster"
        ],
        "conditions": [
        {
            "inventory": {
                "isS2dEnabled": {
                    "type": "boolean",
                    "operator": "is"
                }
            }
        }
        ]
    }
    ]
```
> [!TIP] 
> If you want your tool to be available only when S2D is not enabled, change the “operator” value to “not”.

### isBritannicaEnabled
Additionally, if you are dependent on the SDDC Management cluster resource and use the SDDC object model, you can check the following condition:
``` json
    "conditions": [
        {
            "inventory": {
                "isS2dEnabled": {
                    "type": "boolean",
                    "operator": "is"
                },
                "isBritannicaEnabled": {
                    "type": "boolean",
                    "operator": "is"
                }
            }
        }
    ]
```

## Backward compatibility to support previous versions of Windows Admin Center
To ensure that your extension continues to work with older versions of Windows Admin Center such as the v1904 GA release, the previous solutionIds and connectionTypes definition can be used together with the new definition. See the example below for displaying your tool only for HCI clusters in all versions of Windows Admin Center.
``` json
    "requirements": [
    {
        "solutionIds": [
            "msft.sme.software-defined-data-center!SDDC"
        ],
        "connectionTypes": [
            "msft.sme.connection-type.hyper-converged-cluster"
        ]
    },
    {
        "solutionIds": [
            "msft.sme.software-defined-data-center!SDDC",
            "msft.sme.software-defined-data-center!cluster"
        ],
        "connectionTypes": [
            "msft.sme.connection-type.hyper-converged-cluster",
            "msft.sme.connection-type.cluster"
        ],
        "conditions": [
            {
                "inventory": {
                    "isS2dEnabled": {
                        "type": "boolean",
                        "operator": "is"
                    }
                }
            }
        ]
    }
    ]
```

## Known issue: AppContextService.activeConnection.isHyperConvergedCluster/isFailoverCluster is not set properly in Windows Admin Center v1909
A regression from recent changes is that the ```AppContextService.activeConnection.isHyperConvergedCluster/isFailoverCluster``` properties are not set properly in Windows Admin Center v1909 and will always be false. This will be fixed in the next release, v1910, but will also be deprecated and no longer available in the following GA release in 2020. In the future, you can replace this with the code below and use ```this.connectHCI```.
```
    import { ClusterInventoryCache } from '@msft-sme/core';

    constructor(
        ...
        private appContextService: AppContextService,
        ...
    ) {
        ...
        this.clusterInventoryCache = new ClusterInventoryCache(
            this.appContextService,
            <SharedCacheOptions>{ expiration: Constants.sharedCacheExpiration }
        );

         this.isBritannicEnabled().subscribe(result => this.connectHCI = result);
    }

    private isBritannicEnabled(): Observable<boolean> {
        return this.clusterInventoryCache.query(this.getClusterInventoryQueryParameters())
        .pipe(
            map(inventory => {
                return inventory.instance.isBritannicaEnabled;
        }));
    }

    private getClusterInventoryQueryParameters(): ClusterInventoryParams {
        const nodeName = this.appContextService.activeConnection.validNodeName;
        const endpoint = this.appContextService.authorizationManager.getJeaEndpoint(nodeName);
        const options = { powerShellEndpoint: endpoint };
        return {
            name: nodeName,
            requestOptions: options
        };
    }
```