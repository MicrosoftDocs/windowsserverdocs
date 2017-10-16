---
title: Create a security group for guarded hosts
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
ms.assetid: a12c8494-388c-4523-8d70-df9400bbc2c0
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 08/28/2017
---

# Create a security group for guarded hosts

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

>[!div class="step-by-step"]
[« Review prerequisites](guarded-fabric-guarded-host-prerequisites.md)
[Confirm attestation »](guarded-fabric-confirm-hosts-can-attest-successfully.md)

This topic describes the intermediate steps that a fabric administrator takes to prepare Hyper-V hosts to become guarded hosts using Admin-trusted attestation (AD mode). Before taking these steps, complete the steps in [Configuring the fabric DNS for hosts that will become guarded hosts](guarded-fabric-configuring-fabric-dns.md).

For a video that illustrates the deployment process, see [Guarded fabric deployment using AD mode](https://channel9.msdn.com/Shows/Guarded-fabric-deployment-AD-mode/Guarded-fabric-deployment-AD-mode/).

## Create a security group and add hosts

1. Create a new **GLOBAL** security group in the fabric domain and add Hyper-V hosts that will run shielded VMs. Restart the hosts to update their group membership.

2. Use Get-ADGroup to obtain the security identifier (SID) of the security group and provide it to the HGS administrator. 

    ```powershell
    Get-ADGroup "Guarded Hosts"
    ```

    ![Get-AdGroup command with output](../media/Guarded-Fabric-Shielded-VM/guarded-host-get-adgroup.png)

## Next step

[Confirm hosts can attest successfully](guarded-fabric-confirm-hosts-can-attest-successfully.md)

## See also

- [Deploying the Host Guardian Service for guarded hosts and shielded VMs](guarded-fabric-deploying-hgs-overview.md)
