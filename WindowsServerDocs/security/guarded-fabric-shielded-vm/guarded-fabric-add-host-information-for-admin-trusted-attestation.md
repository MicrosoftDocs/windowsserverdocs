---
title: Add host information for Admin-trusted attestation
ms.custom: na
ms.prod: windows-server
ms.topic: article
ms.assetid: 87089ebc-b953-4aa3-96b5-966cf91acb02
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 08/29/2018
---

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

# Authorize Hyper-V hosts using Admin-trusted attestation

>[!IMPORTANT]
>Admin-trusted attestation (AD mode) is deprecated beginning with Windows Server 2019. For environments where TPM attestation is not possible, configure [host key attestation](guarded-fabric-initialize-hgs-key-mode.md). Host key attestation provides similar assurance to AD mode and is simpler to set up. 


To authorize a guarded host in AD mode: 

1. In the fabric domain, add the Hyper-V hosts to a security group.
2. In the HGS domain, register the SID of the security group with HGS. 

## Add the Hyper-V host to a security group and reboot the host

1. Create a **GLOBAL** security group in the fabric domain and add Hyper-V hosts that will run shielded VMs. 
   Restart the hosts to update their group membership.

2. Use Get-ADGroup to obtain the security identifier (SID) of the security group and provide it to the HGS administrator. 

   ```powershell
   Get-ADGroup "Guarded Hosts"
   ```

   ![Get-AdGroup command with output](../media/Guarded-Fabric-Shielded-VM/guarded-host-get-adgroup.png)

## Register the SID of the security group with HGS  

1. Obtain the SID of the security group for guarded hosts from the fabric administrator and run the following command to register the security group with HGS. 
   Re-run the command if necessary for additional groups. 
   Provide a friendly name for the group. 
   It does not need to match the Active Directory security group name. 

   ```powershell
   Add-HgsAttestationHostGroup -Name "<GuardedHostGroup>" -Identifier "<SID>"
   ```

2. To verify the group was added, run [Get-HgsAttestationHostGroup](https://technet.microsoft.com/library/mt652172.aspx). 


