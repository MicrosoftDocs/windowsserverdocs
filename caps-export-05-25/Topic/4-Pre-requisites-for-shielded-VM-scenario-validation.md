---
title: 4 Pre-requisites for shielded VM scenario validation
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0efd6669-2830-4361-97ed-b8057e811af0
robots: noindex,nofollow
---
# 4 Pre-requisites for shielded VM scenario validation
The following pre-requisites are assumed in the environment.  
  
  
### 4.1 For the Host Guardian Service (HGS) infrastructure  
The Host Guardian Service running Windows Server Technical Preview Standard or Datacenter edition Technical Preview 3 (build \#10514). This can be either physical or virtual; however physical is recommended. The HGS service must run in its own Active Directory domain and must be isolated from the current fabric AD infrastructure.  
  
HGS can validate status of the Hyper-V hosts in either one of the modes. Depending on your validation plan, you need the following (and should plan for network/firewall connectivity between HGS and fabric domain accordingly):  
  
1.  Hardware-rooted attestation    
    1.  Name resolution between the fabric domain and the HGS domain.    
        ***(In this mode, the Hyper-V physical host that will run a shielded VM must have TPM 2.0 and UEFI 2.3.1 with secure boot enabled)***.    
2.  Administrative-based attestation    
    1.  Name resolution between the fabric domain and the HGS domain, and vice versa.    
    2.  Administrative-based attestation is based on the Active Directory Security group and requires trust between HGS forest and fabric forest. Please consult the diagram in the Overview section for more information. Please note that when opting for hardware-rooted attestation, no AD trust is needed between fabric domain and the HGS domain.  
  
  
### 4.2 For hosting provider/enterprise fabric infrastructure  
![Hosting Provider/Enterprise Fabric Infrastructure](../Image/ShieldVM_Enterprise_Fabric_Structure.PNG)    
>*Note: You must have Windows Server 2016 Technical Preview 3 and System Center 2016 Technical Preview 3 stack, (i.e. VMM 2016 Technical Preview 3 + Service Provider Foundation 2016 Technical Preview 3) for shielded VM support in Windows Azure Pack UR7.1+.<sup>1</sup> You can install all components on the same server for evaluation purposes.*  
  
1.  A fabric controller: VMM 2016 Technical Preview 3 build (either physical or virtual). A VMM 2016 VHD is available as a download on the [TechNet Evaluation Center site](http://www.microsoft.com/en-us/download/details.aspx?id=48693). Please see Appendix A for instructions on importing this VHD into your environment.    
2.  Configure Virtual Machine Manager (VMM) with following:    
    1.  Host group for guarded hosts    
    2.  Private cloud from the host group    
    3.  Tenant administrator user role with the tenant as a member    
    4.  Physical hosts running Windows Server Technical Preview 3 (build \#10514).    
3.  Install Service Provider Foundation 2016 Technical Preview 3 on the VMM server and latest version of Windows Azure Pack.    
4.  At least one physical host running Windows Server Technical Preview Datacenter or Enterprise edition Technical Preview 3 (build \#10514), which becomes guarded and will host shielded VMs. Two hosts are needed to test the Hyper-V live migration for shielded VM.    
    1.  For hardware-based attestation, you need a physical host with TPM 2.0 and UEFI 2.3.1 with secure boot enabled.  
  
  
### 4.3 For tenants  
To create virtual machines for use in the Guarded Fabric, you will need the following configuration in your environment.  
  
For Scenario \#1  
  
1.  A physical server running Windows Server Technical Preview 3 (build \#10514) with the following roles and features installed:    
    1.  Role    
        1.  Hyper-V    
    2.  Features    
        1.  Remote Server Administration Tools\\Shielded VM Tools  
  
For Scenarios \#2 & \#3  
  
You can have physical or virtual machine running Windows 10 client or Windows Server 2016 Technical Preview 3.  
  
If you are using Windows Server 2016 Technical Preview 3, you need to add Feature\\Remote Server Administration Tools\\Shielded VM Tools in Server Manager.  
  
OR  
  
If you are using the Windows 10 client operating system, you can download the Remote Server Administration Tools for Windows Server 2016. This will install the Shielding Data File Wizard to create the PDK file on the client machine.  
