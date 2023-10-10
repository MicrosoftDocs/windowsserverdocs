---
title: AD Forest Recovery - Backing up a full server 
description: A Bare Metal Recovery (BMR) backup is recommended to prepare for a forest recovery because it can be restored to different hardware or a different operating system instance. Using Windows Server Backup you can perform a Bare-Metal Recovery (BMR) backup of your server. 
ms.author: inhenkel
author: IngridAtMicrosoft
ms.date: 06/21/2023
ms.topic: article
---

# Active Directory Forest Recovery - Back up a full server

> Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2 and 2012

A Bare Metal Recovery (BMR) backup is recommended to prepare for a forest recovery because it can be restored to different hardware or a different operating system instance. Using Windows Server Backup you can perform a Bare-Metal Recovery (BMR) backup of your server.

## Windows Server Backup

Windows Server Backup isn't installed by default. In Windows Server 2012 R2, Windows Server 2016 and newer, install it by following the steps below.

> [!NOTE]
> Please be aware that the steps may vary slightly between Windows Server 2012 R2 and Windows Server 2016+.

## Install Windows Server Backup

1. Open **Server Manager** and select **Add roles and features**.
1. On the **Add Roles and Features Wizard** select **Next**.
1. On the **Installation Type** screen, leave the default **Role-based or feature-based installation** and select **Next**.
1. On the **Server Selection** screen, select **Next**.
1. On the Server Roles screen, select **Next**.
1. On the **Features** screen, select **Windows Server Backup** and select **Next**
    :::image type="content" source="media/a31518eb8f4ce532c957c9f4b61db202.png" alt-text="Screenshot that highlights the selected Windows Server Backup option.":::
1. Select **Install**.
1. Once the installation is complete, select **Close**.

## Perform a backup with Windows Server Backup

1. Open **Server Manager**, select **Tools**, and then select **Windows Server Backup**.
    :::image type="content" source="media/33f3c23bfe300f86cedcbf3f11c2c665.png" alt-text="Screenshot that shows where to point to Administrative Tools and then select Windows Server Backup.":::
1. If you're prompted, in the **User Account Control** dialog box, provide Backup Operator credentials, and then select **OK**.
1. Select **Local Backup**.
1. On the **Action** menu, select **Backup once**.
1. In the Backup Once Wizard, on the **Backup options** page, select **Different options**, and then select **Next**.
    :::image type="content" source="media/3346c8870177678d27fdb4bffc1b9458.png" alt-text="Screenshot that shows the Different Options option selected.":::
1. On the **Select backup configuration** page, select **Full server (recommended)**, and then select **Next**.  Or when you select “Custom”, make sure to select “Bare metal recovery” and the items is selected automatically:  
    :::image type="content" source="media/b88fe62fbfad14dbf54c0ef306b46dfc.png" alt-text="Graphical user interface, text, application, email Description automatically generated":::
1. On the **Specify destination type** page, select **Local drives** or **Remote
    shared folder**, and then select **Next**.
1. On the **Select Backup Destination** page, choose the backup location. If you selected local drive choose a local drive or if you selected remote share choose a network share.
1. On the confirmation screen, select **Backup**.
    :::image type="content" source="media/16c2dff09f580d43a4b3d845a7b039f4.png" alt-text="Screenshot that shows the Backup Progress screen.":::
1. Once this has completed select **Close**.
1. Close Windows Server Backup.

> [!NOTE]
> If you get an error stating that no backup storage location is available, you will need to either exclude one of the volumes that has been selected or add a new volume or remote share. If you get a warning stating that the selected volume is also included in the list of items to backup, determine whether or not to remove and click **OK**.

## Use `wbadmin.exe` to back up a Windows Server

`Wbadmin.exe` is a command-line utility that enables you to back up and restore your operating system, volumes, files, folders, and applications from a command prompt.

## Perform a full server backup using `wbadmin.exe`

- Open an elevated command prompt, type the following command and press ENTER:

    For bare-metal backup:

    `wbadmin start backup -allCritical -backuptarget:\<Drive_letter_to_store_backup\>:`

    For full server backup:

    `wbadmin start backup -backuptarget:\<Drive_letter_to_store_backup\>: -include:\<Drive_letter_to_include\>:`

    :::image type="content" source="media/87bd3e26c885838443090c4ce7b7a04e.png" alt-text="Install backup":::

## Next steps

[!INCLUDE [ad-forest-recovery-guide-links](includes/ad-forest-recovery-guide-links.md)]