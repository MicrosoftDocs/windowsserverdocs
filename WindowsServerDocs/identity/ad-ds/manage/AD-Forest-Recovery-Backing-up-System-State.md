---
title: AD Forest Recovery - Backing up a full server 
description:
ms.author: joflore
author: MicrosoftGuyJFlo
manager: mtillman
ms.date: 08/09/2018
ms.topic: article
ms.prod: windows-server
ms.assetid: 9238cb27-0020-42f7-90d6-fcebf7e3c0bc
ms.technology: identity-adds
---
# AD Forest Recovery - Backing up the System State data  

>Applies To: Windows Server 2016, Windows Server 2012 and 2012 R2, Windows Server 2008 and 2008 R2

Use the following procedure to perform a system state backup on a DC by using Windows Server Backup or wbadmin.exe.  

## To perform a system state backup using Windows Server Backup

1. Open **Server Manager**, click **Tools**, and then click **Windows Server Backup**.
   - In Windows Server 2008 R2 and Windows Server 2008, click **Start**, point to **Administrative Tools**, and then click **Windows Server Backup**. 

   ![Install Backup](media/AD-Forest-Recovery-Backing-up-a-Full-Server/fullbackup1.png)

2. If you are prompted, in the **User Account Control** dialog box, provide Backup Operator credentials, and then click **OK**.
3. Click **Local Backup**.
4. On the **Action** menu, click **Backup once**.
5. In the Backup Once Wizard, on the **Backup options** page, click **Different options**, and then click **Next**.

   ![Install Backup](media/AD-Forest-Recovery-Backing-up-a-Full-Server/fullbackup3.png)

6. On the **Select backup configuration** page, click **Custom)**, and then click **Next**.
7. On the **Select Items for Backup** screen, click **Add Items** and select **System State** and click **Ok**.
   - In Windows Server 2008 R2 and Windows Server 2008, select the volumes to include in the backup. If you select the **Enable system recovery** check box, all critical volumes are selected. 

   ![Install Backup](media/AD-Forest-Recovery-Backing-up-System-State/systemstatebackup.png)  

8. On the **Specify destination type** page, click **Local drives** or **Remote shared folder**, and then click **Next**.  If you are backing up to a remote shared folder, do the following:  
   - Type the path to the shared folder.
   - Under **Access Control**, select **Do not inherit** or **Inherit** to determine access to the backup, and then click **Next**.  
   - In the **Provide user credentials for Backup** dialog box, provide the user name and password for a user who has write access to the shared folder, and then click **OK**.

9. For Windows Server 2008 R2 and Windows Server 2008, on the **Specify advanced option** page, select **VSS copy backup** and then click **Next**.
10. On the **Select Backup Destination** page, choose the backup location.  If you selected local drive choose a local drive or if you selected remote share choose a network share.
11. On the confirmation screen, click **Backup**.
12. Once this has completed click **Close**.
13. Close Windows Server Backup.

## To perform a system state backup using Wbadmin.exe

Open an elevated command prompt, type the following command and press ENTER:  
  
   ```
   wbadmin start systemstatebackup -backuptarget:<targetDrive>:
   ```

   ![Install Backup](media/AD-Forest-Recovery-Backing-up-System-State/systemstatebackup2.png)  

## Next Steps

- [AD Forest Recovery Guide](AD-Forest-Recovery-Guide.md)
- [AD Forest Recovery - Procedures](AD-Forest-Recovery-Procedures.md)
