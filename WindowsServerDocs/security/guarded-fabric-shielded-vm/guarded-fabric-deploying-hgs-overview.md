---
title: Deploying the Host Guardian Service for guarded hosts and shielded VMs
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
ms.assetid: 310b63d9-5ac7-4961-98ef-103af45d706a
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
---

# Deploying the Host Guardian Service for guarded hosts and shielded VMs

>Applies To: Windows Server 2016

One of the most important goals of providing a hosted environment is to guarantee the security of the virtual machines running in the environment.  As a cloud service provider or enterprise private cloud administrator, you can use a guarded fabric to provide a more secure environment for VMs. A guarded fabric consists of one Host Guardian Service (HGS)—typically, a cluster of three nodes—plus one or more guarded hosts, and a set of shielded virtual machines (VMs).

For a diagram of HGS that shows how it works with hosts, see [Guarded fabric and shielded VMs overview](Guarded-Fabric-and-Shielded-VMs.md).

The following topics tell how to set up a guarded fabric.

- [Prerequisites for deploying Host Guardian Service and guarded hosts](guarded-fabric-deployment-prerequisites.md)
- [Setting up the Host Guardian Service - HGS](guarded-fabric-setting-up-the-host-guardian-service-hgs.md)

## See also

- [Guarded fabric and shielded VMs](guarded-fabric-and-shielded-vms-top-node.md)
