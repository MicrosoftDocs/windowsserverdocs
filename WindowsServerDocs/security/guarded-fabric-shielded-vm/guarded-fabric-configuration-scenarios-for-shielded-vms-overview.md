---
title: Deploy shielded VMs
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
ms.assetid: 5d1a06c9-24e1-4e14-9c9a-efb2adbfeddd
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 08/29/2018
---

# Deploy shielded VMs


>Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016

The following topics describe how a tenant can work with shielded VMs.

1. (Optional) [Create a Windows template disk](guarded-fabric-create-a-shielded-vm-template.md) or [create a Linux template disk](guarded-fabric-create-a-linux-shielded-vm-template.md). The template disk can be created by either the tenant or the hosting service provider. 

2. (Optional) [Convert an existing Windows VM to a shielded VM](guarded-fabric-vm-shielding-helper-vhd.md). 

3. [Create shielding data to define a shielded VM](guarded-fabric-tenant-creates-shielding-data.md).

    For a description and diagram of a shielding data file, see [What is shielding data and why is it necessary?](guarded-fabric-and-shielded-vms.md#what-is-shielding-data-and-why-is-it-necessary)
    
    For information about creating an answer file to include in a shielded data file, see [Shielded VMs - Generate an answer file by using the New-ShieldingDataAnswerFile function](guarded-fabric-sample-unattend-xml-file.md).

4. Create a shielded VM:
 
    - Using **Windows Azure Pack**: [Deploy a shielded VM by using Windows Azure Pack](guarded-fabric-shielded-vm-windows-azure-pack.md)

    - Using **Virtual Machine Manager**: [Deploy a shielded VM by using Virtual Machine Manager](guarded-fabric-tenant-deploys-shielded-vm-using-vmm.md)

## Next step

> [!div class="nextstepaction"]
> [Create a shielded VM template](guarded-fabric-create-a-shielded-vm-template.md)

## See also

- [Guarded fabric and shielded VMs](guarded-fabric-and-shielded-vms-top-node.md)
