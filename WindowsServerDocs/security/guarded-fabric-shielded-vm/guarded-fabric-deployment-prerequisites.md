---
title: Prerequisites for deploying Host Guardian Service and guarded hosts
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
ms.assetid: 2379ca26-b32d-4055-8b4b-99d1f2df37e1
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
---
# Prerequisites for deploying Host Guardian Service and guarded hosts 

>Applies To: Windows Server 2016

This topic lists the following:

- [Supported upgrade scenarios](#supported-upgrade-scenarios)
- [Prerequisites for the Host Guardian Service](#prerequisites-for-the-host-guardian-service)
- [Prerequisites for Hyper-V hosts that will become guarded hosts](#prerequisites-for-hyper-v-hosts-that-will-become-guarded-hosts)
- [Prerequisites for management and access tools for hosts](#prerequisites-for-management-and-access-tools-for-hosts)
- [Prerequisites for completing the tenant scenarios for a guarded fabric](#prerequisites-for-completing-the-tenant-scenarios-for-a-guarded-fabric)

## Supported upgrade scenarios

On an HGS server or a guarded host (or a VMM server where applicable), an in-place upgrade from a previous Technical Preview release to Windows Server 2016 is supported. However, on the upgraded servers, you must create a new guarded fabric configuration and security artifacts, such as code integrity policies, template disks, and shielding data files. We recommend that all the servers run the same operating system patch level, although it is not required.

Shielded VMs that ran on a guarded host with an earlier operating system version, such as TP5, can still run after the host is upgraded to Windows Server 2016. New shielded VMs cannot be created from template disks that were prepared using the template disk wizard from a Technical Preview build.

## Prerequisites for the Host Guardian Service

-   **Hardware**: HGS can be run on physical or virtual machines, but physical machines are recommended.

    If you want to run HGS as a three-node physical cluster (for availability), you must have three physical servers. (As a best practice for clustering, the three servers should have very similar hardware.)
  
-   **Operating system**: Windows Server 2016, Standard or Datacenter edition.

-   **Role and features**: Details about installing the role and features for HGS are included in the procedure, [Setting up the Host Guardian Service (HGS)](guarded-fabric-setting-up-the-host-guardian-service-hgs.md).

-   **Configuration permissions/privileges for the fabric (host) domain**: You will need to be able to configure DNS forwarding between the fabric (host) domain and the HGS domain. If you are using Admin-trusted attestation, you will need to be able to configure Active Directory trusts between the fabric domain the HGS domain. Admin-trusted attestation is one of the two mutually-exclusive attestation modes that HGS uses, with the other mode being TPM-trusted attestation. For information about the two modes, including the hardware and firmware requirements for TPM-trusted attestation, see [Attestation modes in the Guarded Fabric solution](Guarded-Fabric-and-Shielded-VMs.md#attestation-modes-in-the-guarded-fabric-solution).
    
    As noted, a guarded fabric cannot contain a mix of admin- and TPM-trusted attestation. However, you can change from one attestation mode to the other. In other words, even though you must choose one mode for your initial deployment, you can change to the other mode later. 

    >**Important**&nbsp;&nbsp;By default, when you set up HGS, it creates its own forest. However, you can choose to add HGS to an existing forest. The forest used by HGS is sensitive because its administrators have access to the keys that control shielded VMs. For this reason, we strongly recommend that HGS either create its own forest during initial installation, or use an existing bastion forest???one that is isolated from traditional fabric or CORP-forest administrators. For more information, see [Choose whether to install HGS in its own new forest or in an existing bastion forest](guarded-fabric-setting-up-the-host-guardian-service-hgs.md#choose-whether-to-install-hgs-in-its-own-new-forest-or-in-an-existing-bastion-forest).

<!- When a link is available, add the following sentence after the sentence (a couple paragraphs up) that ends in "you can change to the other mode later": 
    For information about changing modes, see the Guarded Fabric Operations Guide.
->

## Prerequisites for Hyper-V hosts that will become guarded hosts

Hyper-V hosts that will become guarded hosts must meet the following prerequisites:

-   **Hardware**: One host is required for initial deployment. However, to test Hyper-V live migration for shielded VMs, you must have at least two hosts.

    -   **Hardware for Admin-trusted attestation:** For this attestation mode, hosts only need hardware capable of running Hyper-V in Windows Server 2016. Procedures for this type of host begin at [Admin-trusted attestation: Creating a security group and placing hosts in the group](guarded-fabric-setting-up-the-host-guardian-service-hgs.md#admin-trusted-attestation-creating-a-security).

    -   **Hardware for TPM-trusted attestation:** For this attestation mode, hosts must have:
        - IOMMU and Second Level Address Translation (SLAT)
        - TPM 2.0
        - UEFI 2.3.1 or later
        - Configured to boot using UEFI (not BIOS or ???legacy??? mode)
        - Secure boot enabled
        
        For TPM-trusted attestation, we recommend that you elect a ???reference host??? to represent each unique class of hardware configuration within your datacenter. You will use the reference host to capture the necessary information for TPM-trusted attestation. Procedures for this type of host begin at [TPM-trusted attestation: capturing hardware and software information that HGS uses in attestation](guarded-fabric-setting-up-the-host-guardian-service-hgs.md#tpm-trusted-attestation-capturing-hardware-and-software-information-that-hgs-uses-in-attestation).

-   **Operating system**: Windows Server 2016 Datacenter edition

-   **Role and features**: Hyper-V role and the Host Guardian Hyper-V Support feature. The Host Guardian Hyper-V Support feature is necessary to let the Hyper-V host communicate with HGS to attest to its health and request keys for shielded VMs. This feature is only available on Datacenter editions of Windows Server 2016. Verify in a lab that the Host Guardian Hyper-V Support feature can run on the reference host. 

>**Important**&nbsp;&nbsp;If you are using the Nano Server installation option of Windows Server 2016, see [Appendix A - Configure Nano server as TPM attested guarded host](guarded-fabric-configure-nano-server-as-tpm-guarded-host.md).

## Prerequisites for management and access tools for hosts

If you choose one of the following scenarios, management servers (physical or virtual) in your infrastructure must meet the corresponding requirements:

<!- Watch the link to the evaluation VHD and make sure it's up-to-date.  ->

-   [Scenario 1 - Deploy guarded hosts and shielded virtual machines in VMM](https://technet.microsoft.com/system-center-docs/vmm/scenario/guarded-overview)

    -   **Operating system**: Windows Server 2016

    -   **VMM software**: System Center 2016 - Virtual Machine Manager (VMM)

    To simplify the setup and configuration, you can deploy a VMM management server as a virtual machine by downloading the evaluation VHD for VMM from [System Center 2016 Virtual Machine Manager ??? Evaluation VHD](https://www.microsoft.com/download/details.aspx?id=53886). Documentation is also available at that site.

-   [Scenario 2 - Deploy a shielded VM by using Windows Azure Pack](guarded-fabric-shielded-vm-windows-azure-pack.md)

    -   **Operating system**: Windows Server 2016

    -   **Management software (all installed on the same system)**:<br>
        System Center 2016 - Virtual Machine Manager<br>
        System Center 2016 - Service Provider Foundation<br>
        Windows Azure Pack Update Rollup 10+<br>

    To simplify the setup and configuration, you can deploy a VMM management server as a virtual machine by downloading the evaluation VHD for VMM from [System Center 2016 Virtual Machine Manager ??? Evaluation VHD](https://www.microsoft.com/download/details.aspx?id=53886). Documentation is also available at that site.

The configuration elements to create in VMM for managment of guarded hosts include the following:

-   A VMM host group for guarded hosts (and, when appropriate, the hosts added to the host group)
-   A private cloud that includes the host group and has other characteristics
-   A tenant administrator role, so that the tenant can be added as a member

For information about how to configure guarded hosts in VMM, see [Provision guarded hosts in VMM](https://technet.microsoft.com/system-center-docs/vmm/scenario/guarded-hosts).

## Prerequisites for completing the tenant scenarios for a guarded fabric

A tenant must perform certain administrative tasks when initially deploying shielded VMs within a public cloud that offers guarded fabric functionality. The tenant must meet the following prerequisites before they can begin those tasks.

-   [Scenario 1 - Provision shielded virtual machines in the VMM fabric](https://technet.microsoft.com/system-center-docs/vmm/scenario/guarded-vms) or <br>[Scenario 2 - Deploy a shielded VM by using Windows Azure Pack](guarded-fabric-shielded-vm-windows-azure-pack.md)<br>For either of these scenarios, the requirements are:

    -   **Operating system**: One or more physical or virtual machines running either Windows 10 client or Windows Server 2016

    -   **Feature**: The following table shows the feature to install, depending on the operating system (server or client)

        <table>
        <colgroup>
        <col width="20%" />
        <col width="80%" />
        </colgroup>
        <thead>
        <tr class="header">
        <th>Operating system option</th>
        <th>Corresponding feature to install</th>
        </tr>
        </thead>
        <tbody>
        <tr class="odd">
        <td><p>Server</p></td>
        <td><p>**Feature**: Remote Server Administration Tools\\Shielded VM Tools</p></td>
        </tr>
        <tr class="even">
        <td><p>Client</p></td>
        <td><p>**Feature**: This is a downloadable feature, the Remote Server Administration Tools for Windows Server 2016. <br>This download includes the Shielding Data File Wizard, needed for creating the shielding data file, which is sometimes called a provisioning data file or PDK file.</p></td>
        </tr>
        </tbody>
        </table>

-   For the scenario covered in [Create a new shielded VM on-premises and move it to a guarded fabric](guarded-fabric-create-vm-move-to-guarded-fabric.md):

    -   **Operating system**: A physical server running Windows Server 2016 with the following roles and features installed.

    -   **Role**: Hyper-V

    -   **Feature**: Remote Server Administration Tools\\Shielded VM Tools

## See also

- [Deploying the Host Guardian Service for guarded hosts and shielded VMs](guarded-fabric-deploying-hgs-overview.md)
