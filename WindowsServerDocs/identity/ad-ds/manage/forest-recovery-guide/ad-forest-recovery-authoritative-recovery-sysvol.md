---
title: AD Forest Recovery - Performing an authoritative synchronization of DFSR-replicated SYSVOL
description: There are different ways to perform an authoritative restore of SYSVOL. You can either edit the **msDFSR-Options** attribute or perform a system state restore using wbadmin –authsysvol. If you have the option to restore a system state backup (that is, you're restoring AD DS to the same hardware and operating system instance) then using wbadmin –authsysvol is simpler. But if you need to perform a bare metal restore, then you need to edit the **msDFSR-Options** attribute.
ms.author: inhenkel
author: IngridAtMicrosoft
ms.date: 06/21/2023
ms.topic: article
---

# Active Directory Forest Recovery - Perform an authoritative synchronization of DFSR-replicated SYSVOL

> Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2 and 2012

There are different ways to perform an authoritative restore of SYSVOL. You can
either edit the **msDFSR-Options** attribute or perform a system state restore
using wbadmin –authsysvol. If you have the option to restore a system state
backup (that is, you're restoring AD DS to the same hardware and operating
system instance) then using wbadmin –authsysvol is simpler. But if you need to
perform a bare metal restore, then you need to edit the **msDFSR-Options**
attribute.

Use the following steps to perform an authoritative synchronization of SYSVOL
(if it's replicated using DFSR) by editing the **msDFSR-Options** attribute.
Note it can also be done using PowerShell.

**To perform an authoritative synchronization of DFSR-replicated SYSVOL using
Active Directory Users and Computers**

1. Open Active Directory Users and Computers.
1. Select **View**, and then select **Users, Contacts, Groups, and Computers as
    containers** and **Advanced Features**.
    :::image type="content" source="media/2a596a72680c054e00119332adab55d8.png" alt-text="Screenshot that shows the Advanced Features option and Users, Contacts, Groups, and Computers option selected.":::
1. In the tree-view, select **Domain Controllers**, the name of the DC you
    restored, **DFSR-LocalSettings**, and then **Domain System Volume**.
    :::image type="content" source="media/ce6e4c2fa09ce87da6eab16028af486b.png" alt-text="Screenshot that highlights the Domain System Volume folder.":::
1. In the Details pane, right-click **SYSVOL Subscription**, select
    **Properties**, and select **Attribute Editor**.
    :::image type="content" source="media/3433980453db8591e0b34f9cb3c93d1c.png" alt-text="Screenshot that shows the Attribute Editor tab in the SYSVOL Subscriptions Properties dialog box.":::
1. Select **msDFSR-Options**, select **Edit**, type **1**, and select **OK**.
    <!-- can't find this image :::image type="content" source="media/ad4b6bd016052f8e5f7bd416.png" alt-text="SYSVOL."::: -->

1. Select **OK** to close the Attribute Editor.

## Verify if the authoritative restore is successful using PowerShell

1. After the previous operation, restart the DFSR service:  

    **Restart-Service DFSR -PassThru**
    :::image type="content" source="media/18334b3759684f7f38a711e2a5c59337.png" alt-text="Restart the DFSR service.":::

2. Verify the presence if Event ID 4602  

    **Get-WinEvent -LogName 'DFS Replication' \| Where-Object ID -EQ 4602 \|
    Format-Table -AutoSize -Wrap**
    :::image type="content" source="media/2352605524b280902670023231454ca6.png" alt-text="Verify the present of Event ID":::

## Next steps

[!INCLUDE [ad-forest-recovery-guide-links](includes/ad-forest-recovery-guide-links.md)]
