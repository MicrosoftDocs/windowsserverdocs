---
title: 3 Scenario Validation - Overview
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 026396da-08e1-48e1-904a-360a9784e9b2
robots: noindex,nofollow
---
# 3 Scenario Validation - Overview
To help you understand the test environment that we’re going to build out here, let’s look at the scenario behind the lab deployment.  
  
The cloud service provider or enterprise private cloud operator is represented by Fabrikam, Inc. They have the following infrastructure:  
  
1.  Fabrikam.com has a domain controller, DHCP server, DNS server, Hyper-V hosts, VMM 2016, and other supporting infrastructure services.    
2.  Relecloud.com is the Active Directory domain for the Host Guardian Service (HGS) infrastructure. HGS uses its own dedicated Active Directory forest, and access to this isolated environment is very restrictive and granted to only very few *trusted administrators*. It is important to note that the Fabrikam.com administrators (in the fabric infrastructure) do not have any access to the HGS infrastructure. This creates a trust boundary between the fabric infrastructure and the HGS environment.  
  
Logical representation of the deployment topology for Technical Preview 3 (build \#10514) is as follows:    
![Guarded Fabric Infrastructure](../Image/ShieldVM_Guarded_Fabric_Infrastructure.png)  
  
> [!Note] *If you are planning for tenants to use VMM (see Scenario \#2) and/or Windows Azure Pack (see Scenario \#3) to create and manage shielded VMs, you are not required to provide a physical server for the tenant’s use; it can be a VM that is running Windows 10 client or WS 2016 Technical Preview 3.*  
  
In the context of this document, tenants are defined as the owners of the virtual machines. Tenants could be third-party customers who want to host VMs with a cloud service provider, or enterprise users who wants to leverage shielded VMs for their enterprise workloads (first-party workloads). Tenants will interact with hosting service providers or private cloud operators in the following ways:  
  
1.  Tenants will create new VMs or use existing VMs (Generation 2) and enable the shielded VM feature on-premises (in the case of a host/tenant model) or on a secure trusted host (in the case of enterprise private cloud model). The owner of the VMs (the tenants) will grant permission to run this VM in designated fabric (“guardian”) infrastructure. Tenants will export the VM and provide it to the host/fabric administrator, who can then run this VM only on designated trusted hosts in their environment. Exported VMs are encrypted and offer data-at-rest encryption, and only designated guardian hosts have the ability to decrypt and start the VM.    
2.  Tenants can create a new VM (Generation 2) directly in the host/private cloud environment from “gold images” provided and signed by the host/private cloud operators. This guarantees tenants that the VHDX file comes from a trusted source and was not modified by rogue users or malware along the way. Tenants provide information such as the computer name, administrator passwords, product key, etc., in an encrypted package at the time of VM creation. Tenants are fully ensured that this sensitive information and the VM are safe and shielded from fabric administrators at all times.    
3.  Hosts/service providers can enable shielded VM capabilities in their cloud and make it available using the Windows Azure Pack portal for their tenants. Tenants can use the Web portal to create and manage shielded VMs in following manner:    
    1.  Tenants can create new shielded VMs” for a shielded template    
    2.  Tenants can create a new VM from the standard VM template and “shield” the VM immediately after provisioning it    
    3.  Tenants can convert any exiting Generation 2 VM to a shielded VM using the Windows Azure Pack portal.  
  
The following table summarizes important terminology used throughout the rest of this document.  
  
| Term                                     | Definition                                                                                                                                                                                                                                                                                                            |  
|------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|  
| Guarded Fabric                           | A public or private cloud that has the ability to manage and run shielded VMs.                                                                                                                                                                                                                                        |  
| hosting service provider                 | A service provider that offers shared or dedicated space on servers for websites, in data centers, etc.                                                                                                                                                                                                               |  
| tenant administrator                     | A user role that allows the user to create and manage self-service users and VM networks, specify which tasks the self-service users can perform on their virtual machines and services, and place quotas on computing resources and virtual machines.                                                                |  
| shielded virtual machine (shielded VM)   | An encrypted virtual machine that can only run on guarded hosts.                                                                                                                                                                                                                                                      |  
| guarded host                             | A host in the fabric on which shielded VMs can run. Guarded hosts must be identified prior to being trusted, and must be configured appropriately in order to pass attestation.                                                                                                                                       |  
| Host Guardian Service                    | A Windows Server Technical Preview role that you install on a secured physical computer to implement the hardened fabric. The Host Guardian Service (HGS) provides attestation and key distribution services so that guarded hosts can run shielded VMs. The trusted administrator manages the Host Guardian Service. |  
| Host Guardian Service remote attestation | Also referred to as *attestation*. The process of the Host Guardian Service verifying that a host is part of the fabric—a guarded host—and the state of its configuration.                                                                                                                                            |  
| Host Guardian Service key distribution   | The operation of delivering a key to a guarded host so that it can unlock and run shielded VMs.                                                                                                                                                                                                                       |  
| trusted administrator                    | An administrator in the public or private cloud that has the authority to manage the policies and cryptographic material for determining on which hosts a shielded VM can run.                                                                                                                                        |  
| fabric administrator                     | A public or private cloud administrator that can manage virtual machines. A fabric administrator does not have access to shielded VMs, or the policies that determine on which hosts shielded VM can run.                                                                                                             |  
| fabric controller                        | The management role within the fabric that provides fabric administration tools and utilities to manage and run virtual machines (both shielded and normal). An example of a fabric controller is System Center Virtual Machine Manager.                                                                              |  
| virtual TPM                              | In Windows Server Technical Preview Hyper-V, you can enable a virtual TPM 2.0 device to guest VMs. This gives you the ability to encrypt the VM.                                                                                                                                                                      |  
| virtual secure mode                      | A Hyper-V based processing and storage environment on Windows Server Technical Preview that is protected from administrators. You can use the Virtual Secure Mode to store operating system keys that are not visible to an operating system administrator.      