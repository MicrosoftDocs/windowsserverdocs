---
title: Setting up the Host Guardian Service for Always Encrypted in SQL Server
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 08/22/2018
---

# Setting up the Host Guardian Service for Always Encrypted in SQL Server 
 
Always Encrypted with secure enclaves in SQL Server v.Next is a feature designed to enable confidential computations on sensitive data stored in a database. 
The Host Guardian Service plays an important role in keeping your data safe when a secure enclave, configured for Always Encrypted, is a virtualization-based security (VBS) memory enclave. 
The security of a VBS memory enclave depends on the security of Windows Hypervisor and, more broadly, the security of the hosting machine. 
Therefore, before a database client application permits the VBS memory enclave used for Always Encrypted to perform computations on sensitive data, the application must attest with a trusted Host Guardian Service to prove the machine hosting SQL Server (which contains the enclave) is in the correct state, and thus, it can be trusted. 
This process can be done simply using Host Key attestation, which authorizes a host by proving it possesses a known and trusted private key, or more thoroughly with TPM attestation, which validates hardware measurements to ensure the correct binaries and security policies are in use on the machine. 
For more about the Host Guardian Service and what it can measure, see [Guarded fabric and shielded VMs overview](https://docs.microsoft.com/windows-server/virtualization/guarded-fabric-shielded-vm/guarded-fabric-and-shielded-vms). 
Note that although the documents talk about shielded VMs, the same protections, architecture and best practices apply to Always Encrypted using VBS enclaves. 
This article will help you set up the Host Guardian Service in a recommended configuration for your SQL Server Always Encrypted workloads using VBS enclaves. 

## Prerequisites 

