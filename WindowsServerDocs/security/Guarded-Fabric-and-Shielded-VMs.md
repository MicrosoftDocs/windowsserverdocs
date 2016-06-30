---
title: Guarded Fabric and Shielded VMs
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: cf257b3a-9365-42e2-a37c-327cac6028d4
manager: dongill
author: coreyp-at-msft
---
# Guarded Fabric and Shielded VMs

>Applies To: Windows Server Technical Preview

## Overview of the Guarded Fabric
Virtualization security is a major investment area in Windows Server 2016 Hyper-V. In addition to protecting hosts or other virtual machines from a virtual machine running malicious software , we also need to protect virtual machines from a compromised host. Since a virtual machine is just a file, we need to protect it from attacks via the storage system, the network, or while it is backed up. This is a fundamental need for every virtualization platform today, whether it's Hyper-V, VMware or any other. Quite simply, if a virtual machine gets out of an organization (either maliciously or accidentally) that virtual machine can be run on any other system.  Protecting high value assets in your organization such as domain controllers, sensitive file servers, and HR systems is a top priority.

To help protect against compromised fabric, Windows Server 2016 Hyper-V introduces Shielded VMs. A Shielded VM is a generation 2  (supported on Windows Server 2012 and later) that has a virtual TPM, is encrypted using BitLocker and can only run on healthy and approved hosts in the fabric.

Shielded VMs and Guarded fabric enables cloud service providers or enterprise private cloud administrators, to provide a more secure environment for tenant VMs. A guarded fabric is comprised of one Host Guardian Service (HGS) - typically, a cluster of 3 nodes: one or more guarded hosts and a set of shielded Virtual Machines. The diagram below shows how the Host Guardian Service uses "Attestation" to ensure that only known, valid hosts can start the shielded VMs, and the "Key Protection Service" to securely release the keys for shielded VMs.

![./media/guarded-fabric-and-shielded-vms/Guarded-Host-Overview-Diagram.png)
### Attestation modes in the Guarded Fabric solution
The Host Guardian Service supports two different deployments of a Guarded fabric (attestation modes): TPM-trusted attestation (Hardware based) and Admin-trusted attestation (AD based). 
TPM trusted attestation is the mode we recommend that you use because it offers stronger assurances but it requires that your Hyper-V hosts have TPM 2.0. If you currently do not have TPM 2.0, you can use Admin-trusted attestation and if you decide to move to TPM trusted attestation when you acquire new hardware, you can do so by switching the attestation mode on the Host Guardian Service with minimal to no interruption to your fabric.
The following table describes the assurances offered by each mode:
| **Attestation Mode you choose for hosts**                                            | **Host assurances**                                                                                                                                                                                                                                                                                                                                             |
|--------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Admin-trusted attestation:**   Intended to support existing host hardware where there is no TPM 2.0 available. Requires relatively few configuration steps and is compatible with commonplace server hardware. |Guarded hosts that can run Shielded VMs are approved by the Host Guardian Service based on membership in a designated Active Directory Domain Services (AD DS) security group.
|**TPM-trusted attestation:** Offers the strongest possible protections but also requires more configuration steps.Host hardware and firmware must include TPM 2.0 and UEFI 2.3.1 with secure boot enabled. | Guarded hosts that can run Shielded VMs are approved based on their TPM identity, measured boot sequence and code integrity policies so that you can ensure that these hosts are only running approved code.      
                                 
For more information about deploying and operating the Guarded Fabric solution see the following documents:

* [Shielded VMs and Guarded Fabric Deployment Guide for Windows Server 2016 TP5](https://gallery.technet.microsoft.com/Shielded-VMs-and-Guarded-98d2b045)
* [Shielded VMs and Guarded Fabric Operations Guide for Windows Server 2016](https://gallery.technet.microsoft.com/Shielded-VMs-and-Guarded-b05d8078)
* [Shielded VMs and Guarded Fabric Troubleshooting Guide for Windows Server 2016](https://gallery.technet.microsoft.com/Shielded-VMs-and-Guarded-70c5b471)


