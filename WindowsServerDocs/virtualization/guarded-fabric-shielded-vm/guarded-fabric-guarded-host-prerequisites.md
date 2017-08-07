---
title: Guarded host prerequisites
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 07/05/2017
---

# Prerequisites for guarded hosts

Review the host prerequisites for the mode of attestation you've chosen, then click on the next step to add guarded hosts.

## TPM-trusted attestation

>[!div class="step-by-step"]
[« Deploy guarded hosts](guarded-fabric-install-hgs-default.md)
[Capture TPM mode info for HGS »](guarded-fabric-tpm-trusted-attestation-capturing-hardware.md)

Guarded hosts using TPM mode must meet the following prerequisites:

-   **Hardware**: One host is required for initial deployment. To test Hyper-V live migration for shielded VMs, you must have at least two hosts.

    Hosts must have:
    
    - IOMMU and Second Level Address Translation (SLAT)
    - TPM 2.0
    - UEFI 2.3.1 or later
    - Configured to boot using UEFI (not BIOS or "legacy" mode)
    - Secure boot enabled
        
-   **Operating system**: Windows Server 2016 Datacenter edition

    > [!IMPORTANT]
    > Make sure you install the [latest cumulative update](https://support.microsoft.com/help/4000825/windows-10-and-windows-server-2016-update-history).  

-   **Role and features**: Hyper-V role and the Host Guardian Hyper-V Support feature. The Host Guardian Hyper-V Support feature is only available on Datacenter editions of Windows Server 2016. 

> [!WARNING]
> The Host Guardian Hyper-V Support feature enables Virtualization-based protection of code integrity that may be incompatible with some devices. 
> We strongly recommend testing this configuration in your lab before enabling this feature. 
> Failure to do so may result in unexpected failures up to and including data loss or a blue screen error (also called a stop error). 
> For more information, see [Compatible hardware with Windows Server 2016 Virtualization-based protection of Code Integrity](guarded-fabric-compatible-hardware-with-virtualization-based-protection-of-code-integrity.md).

## Admin-trusted attestation

>[!div class="step-by-step"]
[« Deploy guarded hosts](guarded-fabric-install-hgs-default.md)
[Place hosts in a security group »](guarded-fabric-admin-trusted-attestation-creating-a-security-group.md)

Hyper-V hosts must meet the following prerequisites for AD mode:

-   **Hardware**: Any server capable of running Hyper-V in Windows Server 2016. One host is required for initial deployment. To test Hyper-V live migration for shielded VMs, you need at least two hosts.

-   **Operating system**: Windows Server 2016 Datacenter edition

   > [!IMPORTANT]
   > Install the [latest cumulative update](https://support.microsoft.com/help/4000825/windows-10-and-windows-server-2016-update-history).

-   **Role and features**: Hyper-V role and the Host Guardian Hyper-V Support feature, which is only available in Windows Server 2016 Datacenter edition. 

> [!WARNING]
> The Host Guardian Hyper-V Support feature enables Virtualization-based protection of code integrity that may be incompatible with some devices. 
> We strongly recommend testing this configuration in your lab before enabling this feature. 
> Failure to do so may result in unexpected failures up to and including data loss or a blue screen error (also called a stop error). 
> For more information, see [Compatible hardware with Windows Server 2016 Virtualization-based protection of Code Integrity](guarded-fabric-compatible-hardware-with-virtualization-based-protection-of-code-integrity.md).

