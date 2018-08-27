---
title: Scenarios for Host Guardian Service 
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 08/22/2018
---

# Solutions that utilize Host Guardian Service

## Guarded fabric and shielded VMs

## Privileged access workstation

A [privileged access workstation (PAW)](https://blogs.technet.microsoft.com/datacentersecurity/2017/10/13/privileged-access-workstationpaw/) is a dedicated virtual machine (VM) operating system for sensitive tasks that is protected from Interenet attacks. A PAW device is a guarded host that can perform remote health attestation agaisnt a Host Guardiuan Service (HGS).

## Always Encrypted with secure enclaves in SQL Server

Always Encrypted with secure enclaves in SQL Server is a feature designed to enable confidential computations on sensitive data stored in a database. 
The Host Guardian Service (HGS) plays an important role in keeping your data safe when a [secure VBS memory enclave](https://cloudblogs.microsoft.com/microsoftsecure/2018/06/05/virtualization-based-security-vbs-memory-enclaves-data-protection-through-isolation/) is configured for Always Encrypted. 
The security of a VBS memory enclave depends on the security of Windows Hypervisor and, more broadly, the security of the hosting machine. 
Therefore, before a database client application permits a VBS enclave used for Always Encrypted to perform computations on sensitive data, the application must attest with a trusted HGS to prove the machine hosting SQL Server (which contains the enclave) is in the correct state, and thus, it can be trusted. 



