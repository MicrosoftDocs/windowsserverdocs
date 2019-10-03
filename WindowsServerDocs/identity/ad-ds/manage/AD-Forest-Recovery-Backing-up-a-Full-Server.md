---
title: AD Forest Recovery - Backing up a full server 
description:
ms.author: joflore
author: MicrosoftGuyJFlo
manager: mtillman
ms.date: 08/09/2018
ms.topic: article
ms.prod: windows-server
ms.assetid: 398918dc-c8ab-41a6-a377-95681ec0b543
ms.technology: identity-adds
---
# AD Forest Recovery - Backing up a full server  

>Applies To: Windows Server 2016, Windows Server 2012 and 2012 R2, Windows Server 2008 and 2008 R2

A full server backup is recommended to prepare for a forest recovery because it can be restored to different hardware or a different operating system instance.  Using Windows Server Backup you can perform a full backup of your server. 

## Windows Server Backup

Windows Server Backup is not installed by default. In Windows Server 2016 and Windows Server 2012 R2, install it by following the steps below.

>[!NOTE]
>Please be aware that the steps may vary slightly between Windows Server 2016 and Windows Server 2012 R2.

For steps to install it in Windows Server 2008 and Windows Server 2008 R2, see [Installing Windows Server Backup](https://technet.microsoft.com/library/cc771232.aspx).  

### To install Windows Server Backup

1. Open **Server Manager** and click **Add roles and features**.
2. On the **Add Roles and Features Wizard** click **Next**.
3. On the **Installation Type** screen, leave the default **Role-based or feature-based installation** and click **Next**.
4. On the **Server Selection** screen, click **Next**.
5. On the **Server Roles** screen click **Next**.
6. On the **Features** screen, select **Windows Server Backup** and click **Next**
   ![Install Backup](media/AD-Forest-Recovery-Backing-up-a-Full-Server/fullbackup2.png)
7. Click **Install**.
8. Once the installation is complete, click **Close**.

### To perform a backup with Windows Server Backup

1. Open **Server Manager**, click **Tools**, and then click **Windows Server Backup**.
   - In Windows Server 2008 R2 and Windows Server 2008, click **Start**, point to **Administrative Tools**, and then click **Windows Server Backup**.

   ![Install Backup](media/AD-Forest-Recovery-Backing-up-a-Full-Server/fullbackup1.png) 

2. If you are prompted, in the **User Account Control** dialog box, provide Backup Operator credentials, and then click **OK**.
3. Click **Local Backup**.
4. On the **Action** menu, click **Backup once**.
5. In the Backup Once Wizard, on the **Backup options** page, click **Different options**, and then click **Next**.

   ![Install Backup](media/AD-Forest-Recovery-Backing-up-a-Full-Server/fullbackup3.png)

6. On the **Select backup configuration** page, click **Full server (recommended)**, and then click **Next**.
7. On the **Specify destination type** page, click **Local drives** or **Remote shared folder**, and then click **Next**.
8. On the **Select Backup Destination** page, choose the backup location.  If you selected local drive choose a local drive or if you selected remote share choose a network share.
9. On the confirmation screen, click **Backup**.

   ![Install Backup](media/AD-Forest-Recovery-Backing-up-a-Full-Server/fullbackup4.png)

10. Once this has completed click **Close**.
11. Close Windows Server Backup.

>[!NOTE]
>If you get an error stating that no backup storage location is available, you will need to either exclude one of the volumes that has been selected or add a new volume or remote share.
>If you get a warning stating that the selected volume is also included in the list of items to backup, determine whether or not to remove and click **Ok**.

## Using Wbadmin.exe to backup a windows server

Wbadmin.exe is a command-line utility that enables you to back up and restore your operating system, volumes, files, folders, and applications from a command prompt.

### To perform a full server backup using Wbadmin.exe
  
- Open an elevated command prompt, type the following command and press ENTER:  

   ```
   wbadmin start backup -backuptarget:<Drive_letter_to store_backup>: -include:<Drive_letter_to_include>:
   ```

   ![Install Backup](media/AD-Forest-Recovery-Backing-up-a-Full-Server/fullbackup5.png)

## Next Steps

- [AD Forest Recovery Guide](AD-Forest-Recovery-Guide.md)
- [AD Forest Recovery - Procedures](AD-Forest-Recovery-Procedures.md)
