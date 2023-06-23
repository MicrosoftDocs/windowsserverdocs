---
description: "Learn more about: AD Forest Recovery - Backing up the System State data"
title: AD Forest Recovery - Backing up the System State data
ms.author: daveba
author: iainfoulds
manager: daveba
ms.date: 06/21/2023
ms.topic: article
ms.custom: 9238cb27-0020-42f7-90d6-fcebf7e3c0bc, inhenkel
---

# Active Directory Forest Recovery - Back up the System State data

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 and 2012 R2, Windows Server 2008 and 2008 R2

Use the following procedure to perform a system state backup on a DC by using Windows Server Backup or wbadmin.exe.

## Perform a system state backup using Windows Server Backup

1. Open **Server Manager**, select **Tools**, and then select **Windows Server Backup**.
   - In Windows Server 2008 R2 and Windows Server 2008, select **Start**, point to **Administrative Tools**, and then select **Windows Server Backup**.
   :::image type="content" source="media/fullbackup1.png" alt-text="Screenshot that highlights the Windows Server Backup menu option.":::
1. If you're prompted, in the **User Account Control** dialog box, provide Backup Operator credentials, and then select **OK**.
1. Select **Local Backup**.
1. On the **Action** menu, select **Backup once**.
1. In the Backup Once Wizard, on the **Backup options** page, select **Different options**, and then select **Next**.
    :::image type="content" source="media/fullbackup3.png" alt-text="Screenshot that shows the Backup Options page with the Different Options option selected.":::
1. On the **Select backup configuration** page, select **Custom**, and then select **Next**.
1. On the **Select Items for Backup** screen, select **Add Items** and select **System State** and select **Ok**.
   - In Windows Server 2008 R2 and Windows Server 2008, select the volumes to include in the backup. If you select the **Enable system recovery** check box, all critical volumes are selected.
    :::image type="content" source="media/systemstatebackup.png" alt-text="Screenshot that shows the System State check box selected.":::
1. On the **Specify destination type** page, select **Local drives** or **Remote shared folder**, and then select **Next**.  If you're backing up to a remote shared folder, do the following:
   - Type the path to the shared folder.
   - Under **Access Control**, select **Do not inherit** or **Inherit** to determine access to the backup, and then select **Next**.
   - In the **Provide user credentials for Backup** dialog box, provide the user name and password for a user who has write access to the shared folder, and then select **OK**.
1. For Windows Server 2008 R2 and Windows Server 2008, on the **Specify advanced option** page, select **VSS copy backup** and then select **Next**.
1. On the **Select Backup Destination** page, choose the backup location.  If you selected local drive choose a local drive or if you selected remote share choose a network share.
1. On the confirmation screen, select **Backup**.
1. Once this has completed select **Close**.
1. Close Windows Server Backup.

## Perform a system state backup using Wbadmin.exe

Open an elevated command prompt, type the following command and press ENTER:

   ```cli
   wbadmin start systemstatebackup -backuptarget:<targetDrive>:
   ```

   :::image type="content" source="media/systemstatebackup2.png" alt-text="Install backup":::

## Next steps

[!INCLUDE [ad-forest-recovery-guide-links](includes/ad-forest-recovery-guide-links.md)]