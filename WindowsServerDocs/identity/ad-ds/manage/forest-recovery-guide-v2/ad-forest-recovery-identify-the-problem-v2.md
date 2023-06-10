---
title: Active Directory Forest Recovery - Identify the problem
description: When symptoms of a forest-wide failure appear, such as in event logs or other monitoring solutions, work with Microsoft Support to determine the cause of the failure and evaluate any possible remedies.
ms.author: inhenkel
author: IngridAtMicrosoft
ms.date: 06/09/2023
ms.topic: article
---

# Active Directory Forest Recovery - Identify the problem

> Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2 and 2012

When symptoms of a forest-wide failure appear, such as in event logs or other monitoring solutions, work with Microsoft Support to determine the cause of the failure and evaluate any possible remedies.

## Examples of forest-wide failures

- All DCs have been logically corrupted or physically damaged to a point that
    business continuity is impossible; for example, all business applications
    that depend on AD DS are nonfunctional.

- A rogue administrator has compromised the Active Directory environment.

- An attacker intentionally—or an administrator accidentally—runs a script
    that spreads data corruption across the forest.

- An attacker intentionally—or an administrator accidentally—extends the
    Active Directory schema with malicious or conflicting changes.

- The contents or a backup of a Domain Controller has been exposed to an
    external party, but leaked credentials have not been used to modify AD data.
    You may not need to restore the AD database from backup and reinstall all
    DCs in this case. You may need to reset all password of users, computers,
    trusts and (g)MSA accounts.

- An attacker has managed to install malicious software on DCs, and you have
    been advised by Microsoft Support to recover the forest from backup.

    **Important**

    This paper does not cover security recommendations about how to recover a
    forest that has been hacked or compromised. In general, it is recommended to follow [Best Practices for Securing Active Directory](/windows-server/identity/ad-ds/plan/security-best-practices/best-practices-for-securing-active-directory.md)
    and Pass-the-Hash mitigation techniques to harden the environment. For more
    information, see [Mitigating Pass-the-Hash (PtH) Attacks and Other Credential Theft Techniques](https://www.microsoft.com/download/details.aspx?id=36036).

- None of the DCs can replicate with their replication partners.

- Changes cannot be made to AD DS at any domain controller.

- New DCs cannot be installed in any domain.

## Next steps

[!INCLUDE [ad-forest-recovery-guide-links](includes/ad-forest-recovery-guide-links.md)]
