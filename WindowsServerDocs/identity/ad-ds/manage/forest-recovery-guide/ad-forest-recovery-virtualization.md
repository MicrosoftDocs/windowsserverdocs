---
title: Active Directory Forest Recovery - Virtualization  
description: Virtualized domain controller (DC) cloning simplifies and expedites the process for installing additional virtualized DCs in a domain, especially in centralized locations such as datacenters where several DCs run on hypervisors. After you restore one virtual DC in each domain from backup, additional DCs in each domain can be rapidly brought online by using the virtualized DC cloning process. You can prepare the first virtualized DC that you recover, shut it down, and then copy that virtual hard disk as many times as is necessary to create cloned virtualized DCs and build out the domain.
ms.author: inhenkel
author: IngridAtMicrosoft
ms.date: 06/21/2023
ms.topic: article
---

# Active Directory Forest Recovery - Virtualization

> Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2 and 2012

## Use virtualized domain controller cloning to expedite forest recovery

Virtualized domain controller (DC) cloning simplifies and expedites the process
for installing additional virtualized DCs in a domain, especially in centralized
locations such as datacenters where several DCs run on hypervisors.

After you restore one virtual DC in each domain from backup, additional DCs in each domain
can be rapidly brought online by using the virtualized DC cloning process.

You can prepare the first virtualized DC that you recover, shut it down, and then
copy that virtual hard disk as many times as is necessary to create cloned
virtualized DCs and build out the domain.

## Requirements for virtualized DC cloning

The requirements for virtualized DC cloning are:

- The hypervisor must support `VM-GenerationID`. For example, Hyper-V supports that mechanism from Windows Server 2012, Windows 8, and newer operating systems. Check with your hypervisor vendor to find out if `VM-GenerationID` is supported.
- The virtualized DC that is used as a source for cloning must be a member of the Cloneable Domain Controllers group.

The PDC Emulator must be available during cloning operations.For step-by-step instructions for virtualized DC cloning, see [Safely virtualizing Active Directory Domain Services (AD DS)](/windows-server/identity/ad-ds/introduction-to-active-directory-domain-services-ad-ds-virtualization-level-100). For details about how virtualized DC cloning works, see [Virtualized Domain Controller Technical Reference](/windows-server/identity/ad-ds/deploy/virtual-dc/virtualized-domain-controller-technical-reference--level-300-).

## Next steps

[!INCLUDE [ad-forest-recovery-guide-links](includes/ad-forest-recovery-guide-links.md)]
