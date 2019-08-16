---
title: Shielded VMs  for tenants - Deploying a shielded VM by using Windows Azure Pack
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
ms.assetid: 095315e4-c4a7-4b80-91d8-528119b62c4c
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 08/29/2018
---

# Shielded VMs  for tenants - Deploying a shielded VM by using Windows Azure Pack

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016

If your hosting service provider supports it, you can use Windows Azure Pack to deploy a shielded VM.

Complete the following steps:

1. Subscribe to one or more plans offered in Windows Azure Pack.

2. Create a shielded VM by using Windows Azure Pack.

    [Use shielded virtual machines](https://technet.microsoft.com/library/mt720674.aspx), which is described in the following topics:

   - [Create shielding data](https://technet.microsoft.com/library/mt720672.aspx) (and upload the shielding data file, as described in the second procedure in the topic).
    
     > [!NOTE]
     > As part of creating shielding data, you will download your guardian key file, which will be an XML file in UTF-8 format. Do not change the file to UTF-16.
    
   - [Create a shielded virtual machine](https://technet.microsoft.com/library/mt720673.aspx) - with **Quick Create**, through a shielded template, or through a regular template.
    
       > [!WARNING]
       > If you [Create a shielded virtual machine by using a regular template](https://technet.microsoft.com/library/mt720673.aspx#Anchor_2), it is important to note that the VM is provisioned *unshielded*. This means that the template disk is not verified against the list of trusted disks in your shielding data file, nor are the secrets in your shielding data file used to provision the VM. If a shielded template is available, it is preferable to deploy a shielded VM with a shielded template to provide end-to-end protection of your secrets.
    
   - [Convert a Generation 2 virtual machine to a shielded virtual machine](https://technet.microsoft.com/library/mt720670.aspx)
    
       > [!NOTE]
       > If you convert a virtual machine to a shielded virtual machine, existing checkpoints and backups are not encrypted. You should delete old checkpoints when possible to prevent access to your old, decrypted data.

## See also

- [Hosting service provider configuration steps for guarded hosts and shielded VMs](guarded-fabric-configuration-scenarios-for-shielded-vms-overview.md)
- [Guarded fabric and shielded VMs](guarded-fabric-and-shielded-vms-top-node.md)
