---
title: Tenant configuration steps for shielded VMs
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
ms.assetid: 6742d3e0-e918-43d2-b15b-fbf076310096
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 11/15/2016
---

# Tenant configuration steps for shielded VMs

The procedures in the following topics describe how a tenant can work with shielded VMs in a guarded fabric.

1. (Optional:) [Create a template disk](guarded-fabric-tenant-creates-template-disk.md). The template disk can be created by either the tenant or the hosting service provider. 

2. [Create shielding data to define a shielded VM](guarded-fabric-tenant-creates-shielding-data.md).

    For a description and diagram of a shielding data file, see [What is shielding data and why is it necessary?](guarded-fabric-and-shielded-vms.md#what-is-shielding-data-and-why-is-it-necessary)
    
    For information about creating an answer file to include in a shielded data file, see [Shielded VMs - Generate an answer file by using the New-ShieldingDataAnswerFile function](guarded-fabric-sample-unattend-xml-file.md).

3. Create a shielded VM:
 
    - Using **Windows Azure Pack**: [Deploy a shielded VM by using Windows Azure Pack](guarded-fabric-shielded-vm-windows-azure-pack.md)

    - Using **Virtual Machine Manager**: [Deploy a shielded VM by using Virtual Machine Manager](guarded-fabric-tenant-deploys-shielded-vm-using-vmm.md)

## See also

- [Hosting service provider configuration steps for guarded hosts and shielded VMs](guarded-fabric-configuration-scenarios-for-shielded-vms-overview.md)
- [Guarded fabric and shielded VMs](guarded-fabric-and-shielded-vms-top-node.md)
