---
title: Adding nodes or drives to a Storage Spaces Direct cluster
ms.prod: windows-server-threshold
ms.author: cosdar
ms.manager: dongill
ms.technology:
  - techgroup-storage
ms.topic: article
author: cosmosdarwin
ms.date: 09/01/2016
---
# Adding nodes or drives to a Storage Spaces Direct cluster
This topic describes how to add nodes or drives to a Storage Space Direct cluster. Adding nodes can expand storage capacity, unlock greater storage efficiency, improve storage performance, and if you’re running hyper-converged, provide more compute resources for your workload.

Typical deployments are very easy to scale out. First, ensure the new node is running Windows Server 2016 Datacenter Edition, has joined the same Active Directory Domain Services domain, has all the requisite roles and features installed, and has networking properly configured. You can verify that it is suitable to join the cluster by running cluster validation again, including the new node. This should only take a few minutes.

## Adding nodes

## Adding drives

## Special cases

### Unlocking three-way mirrors when going from two nodes to three

### Unlocking dual-parity when adding a fourth nodes

### Increasing parity efficiency when adding nodes

### Adding nodes when using chassis or rack fault tolerance
