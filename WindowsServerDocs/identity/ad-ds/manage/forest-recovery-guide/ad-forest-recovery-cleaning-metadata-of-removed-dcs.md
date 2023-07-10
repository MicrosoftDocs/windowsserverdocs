---
title: AD Forest Recovery - Cleaning metadata of removed writable domain controllers  
description: Metadata cleanup removes Active Directory data that identifies a DC to the replication system. Note that outside of a Forest Recovery, metadata cleanup is part of the demotion process of domain controllers, however, when they aren't reachable anymore, this process also applies. Use the following procedure to delete the DC objects for DCs that you plan to add back to the network by reinstalling AD DS.
ms.author: inhenkel
author: IngridAtMicrosoft
ms.date: 06/21/2023
ms.topic: article
---

# Active Directory Forest Recovery -  Clean the metadata of removed writable domain controllers

> Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2 and 2012

Metadata cleanup removes Active Directory data that identifies a DC to the
replication system.

Note that outside of a Forest Recovery, metadata cleanup is part of the
demotion process of domain controllers, however, when they aren't reachable
anymore, this process also applies.

Use the following procedure to delete the DC objects for DCs that you plan to
add back to the network by reinstalling AD DS.

## Delete a domain controller using Active Directory Users and Computers

When you use the version of Active Directory Users and Computers or Active
Directory Administrative Center in Remote Server Administration Tools (RSAT),
metadata cleanup is performed automatically when you delete the DC object. The
server object and the computer object are also deleted automatically.

As an alternative, you can also use Active Directory Sites and Services in RSAT
to delete a DC object. If you use Active Directory Sites and Services, you must
delete the associated server object and NTDS Settings object before you can
delete the DC object. Metadata cleanup can also be done through command line,
via NTDSUtil or using PowerShell with Active Directory Module.

For information about installing RSAT, see the article [Remote Server Administration Tools](/windows-server/remote/remote-server-administration-tools).

**To delete a domain controller object using Active Directory Users and
Computers in RSAT**

1. Select **Start**, select **Administrative Tools**, and then select **Active
    Directory Users and Computers**.
1. In the console tree, double-click the domain container, and then
    double-click the **Domain Controllers** organizational unit (OU).
1. In the details pane, right-click the DC that you want to delete, and then
    select **Delete**.
    :::image type="content" source="media/86716786218562ce1d1abcdb4a22ce11.png" alt-text="Delete":::
1. Select **Yes** to confirm the deletion. Select the **This Domain Controller
    is permanently offline and can no longer be demoted using the Active
    Directory Domain Services Installation Wizard (DCPROMO)** check box and
    select **Delete**.
1. If the DC was a global catalog server, select **Yes** confirm that the
    deletion.

## Next steps

[!INCLUDE [ad-forest-recovery-guide-links](includes/ad-forest-recovery-guide-links.md)]
