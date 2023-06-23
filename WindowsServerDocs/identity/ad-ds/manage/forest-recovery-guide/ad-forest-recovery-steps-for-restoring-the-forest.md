---
title: AD Forest Recovery - Steps for Restoring the forest
description: This section provides an overview of the recommended path for recovering a forest. The forest recovery steps are described in detail later.
ms.author: inhenkel
author: IngridAtMicrosoft
ms.date: 06/21/2023
ms.topic: article
---

# Active Directory Forest Recovery - Steps to restore the forest

> Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2 and 2012

This section provides an overview of the recommended path for recovering a forest. The forest recovery steps are described in detail later.

We recommend you run through a forest recovery on a regular basis to:

- Practice the recovery.
- Ensure the custom steps you defined for your environment are still working.
- If steps don't work, you notice and update the existing plan to adopt for a new kind of potential failure.
- Verify the defaults you have for selecting the DCs to restore in each of the domains is still a good choice.

The following list summarizes the recovery steps at a high level:

1. [Identify the problem](ad-forest-recovery-identify-the-problem.md)
    Work with IT and Microsoft Support to determine the scope of the problem and
    potential causes, and evaluate possible remedies with all business
    stakeholders. In many cases, total forest recovery should be the last option.
1. [Determine how to recover the forest](ad-forest-recovery-determine-how-to-recover.md)
    After you determine that forest recovery is necessary, complete preliminary
    steps to prepare for it.
1. [Perform initial recovery](ad-forest-recovery-perform-initial-recovery.md)
    In isolation, recover one DC for each domain, clean it, and reconnect the
    domains. Reset privileged accounts, and rectify problems caused by security
    breaches in this phase.
1. [Redeploy remaining DCs](ad-forest-recovery-restore-additional-dcs.md)
    Redeploy the forest to return it to its state before the failure. Adapt this step to your specific design and requirements. Virtualized domain controller cloning can help expedite this process.
1. [Cleanup](ad-forest-recovery-cleanup.md)
    After functionality has been restored, reconfigure name resolution as
    needed, and get LOB applications working.

The steps in this guide are designed to minimize the possibility of
reintroducing dangerous data into the recovered forest. You may have to modify
these steps to account for such factors as:

- Scalability
- Remote manageability
- Speed of recovery

## Next steps

[!INCLUDE [ad-forest-recovery-guide-links](includes/ad-forest-recovery-guide-links.md)]