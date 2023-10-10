---
description: "Learn more about: AD Forest Recovery - Cleanup"
title: AD Forest Recovery - Cleanup
ms.author: daveba
author: iainfoulds
manager: daveba
ms.date: 06/21/2023
ms.topic: article
ms.custom: 5a291f65-794e-4fc3-996e-094c5845a383, inhenkel
---

# Active Directory Forest Recovery - Cleanup

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 and 2012 R2

Perform the following post recovery steps as needed:

## Revert to the original DNS configuration

After the entire forest is recovered, you can revert to the original DNS configuration, including configuration of the preferred and alternate DNS servers on each of the DCs. After the DNS servers are configured as they were before the malfunction, their previous name resolution capabilities will be restored. Delete any DNS records for DCs that haven't been recovered.

## Delete Windows Internet Name Service (WINS) records

Delete Windows Internet Name Service (WINS) records for all DCs that haven't been recovered.

## Transfer operations master roles to other DCs

You can transfer the operations master roles to other DCs in the domain or forest and add more global catalog servers based on the configuration before the failure.

## Recreate missing objects

Because the entire forest is restored to a previous state, any objects (such as users and computers) that were added and all updates (such as password changes) that were made to existing objects after this point are lost. Therefore, you should recreate these missing objects and reapply the missing updates as appropriate.

## Restore outgoing domains and trusts
You might also need to restore outgoing trusts with external domains and forests, because these external trust relationships aren't restored automatically from backups.

## Next steps

[!INCLUDE [ad-forest-recovery-guide-links](includes/ad-forest-recovery-guide-links.md)]
