---
title: Admin-trusted attestation for a guarded fabric - creating a security group
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
ms.assetid: a12c8494-388c-4523-8d70-df9400bbc2c0
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 10/14/2016
---

# Admin-trusted attestation for a guarded fabric - creating a security group

This topic describes the intermediate steps that a fabric administrator takes to prepare Hyper-V hosts to become guarded hosts, and describes Admin-trusted attestation mode only. Before taking these steps, complete the steps in [Configuring the fabric DNS for hosts that will become guarded hosts](guarded-fabric-configuring-fabric-dns.md).

If you need to prepare hosts for TPM-trusted attestation, see [TPM-trusted attestation for a guarded fabric - capturing information required by HGS](guarded-fabric-tpm-trusted-attestation-capturing-hardware.md).

For a list of the tasks for configuring a guarded fabric, see [Deployment tasks for guarded fabrics and shielded VMs](guarded-fabric-deploying-hgs-overview.md#deployment-tasks-for-guarded-fabrics-and-shielded-vms).

## Prerequisites for guarded hosts using Admin-trusted attestation

Hyper-V hosts that will become guarded hosts using Admin-trusted attestation must meet the following prerequisites:

-   **Hardware**: One host is required for initial deployment. To test Hyper-V live migration for shielded VMs, you must have at least two hosts.

    For this attestation mode, hosts only need hardware capable of running Hyper-V in Windows Server 2016.

-   **Operating system**: Windows Server 2016 Datacenter edition

    Install [Cumulative Update KB3201845](http://www.catalog.update.microsoft.com/Search.aspx?q=KB3201845) ([OS Build 14393.479](https://support.microsoft.com/help/4004253)). 
    The following earlier builds are also supported:

    - [Cumulative Update KB3200970](http://www.catalog.update.microsoft.com/Search.aspx?q=KB3200970) ([OS Build 14393.448](https://support.microsoft.com/help/4001886))
    - [Cumulative Update KB3200970](http://www.catalog.update.microsoft.com/Search.aspx?q=KB3200970) ([OS Build 14393.447](https://support.microsoft.com/help/4001885))
    - [Cumulative Update KB3197954](http://www.catalog.update.microsoft.com/Search.aspx?q=KB3197954) ([OS Build 14393.351](https://support.microsoft.com/help/4004253))
    
    No other builds are supported for a guarded fabric. If the server is running [Cumulative Update KB3206632](http://www.catalog.update.microsoft.com/Search.aspx?q=KB3206632) ([OS Build 14393.576](https://support.microsoft.com/help/4004227)) or a later build, uninstall the updates so the server runs OS Build 14393.479.
    
-   **Role and features**: Hyper-V role and the Host Guardian Hyper-V Support feature. The Host Guardian Hyper-V Support feature is necessary to let the Hyper-V host communicate with HGS to attest to its health and request keys for shielded VMs. This feature is only available on Datacenter editions of Windows Server 2016. If you are using the Nano Server installation option of Windows Server 2016, see [Appendix A - Configure Nano server as TPM attested guarded host](guarded-fabric-configure-nano-server-as-tpm-guarded-host.md). 

> [!WARNING]
> The Host Guardian Hyper-V Support feature enables Virtualization-based protection of code integrity that may be incompatible with some devices. 
> We strongly recommend testing this configuration in your lab before enabling this feature. 
> Failure to do so may result in unexpected failures up to and including data loss or a blue screen error (also called a stop error). 
> For more information, see [Compatible hardware with Windows Server 2016 Virtualization-based protection of Code Integrity](guarded-fabric-compatible-hardware-with-virtualization-based-protection-of-code-integrity.md).

## Create a security group and place hosts in the group

Admin-trusted attestation identifies legitimate hosts through a designated Active Directory security group. As a fabric administrator, you can use the following steps to create the security group and place hosts in that group.

1.  **On a computer in the fabric (host) domain**: Create a new **GLOBAL** security group in the fabric domain to identify those hosts trusted to run shielded VMs. You can create this group in Active Directory Users and Computers or by running the Active Directory PowerShell commands on a computer with the AD DS Remote Server Administration Tools (RSAT) installed.

    >**Warning**&nbsp;&nbsp;You must restart each host after adding them to this security group to update their group membership, unless using a group that the host was already a member of.

2. Obtain the security identifier (SID) of the security group that you created (so that you can provide it to the HGS administrator). To obtain the SID, use the following Windows PowerShell command in the fabric domain.

    ![Get-AdGroup command with output](../media/Guarded-Fabric-Shielded-VM/guarded-host-get-adgroup.png)

    Provide the SID to the HGS administrator so they can [register the group with HGS as an Attestation Host Group](guarded-fabric-setting-up-the-host-guardian-service-hgs.md#admin-trusted-attestation-only---adding-security-group-information-to-the-hgs-configuration).

## Next step

[Confirm hosts can attest successfully](guarded-fabric-confirm-hosts-can-attest-successfully.md)

## See also

- [Deploying the Host Guardian Service for guarded hosts and shielded VMs](guarded-fabric-deploying-hgs-overview.md)
