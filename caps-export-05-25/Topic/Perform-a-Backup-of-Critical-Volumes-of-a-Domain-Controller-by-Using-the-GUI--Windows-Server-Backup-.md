---
title: Perform a Backup of Critical Volumes of a Domain Controller by Using the GUI (Windows Server Backup)
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 959fc4b5-7c87-493f-a9bc-7a7db17e3f9e
author: Femila
---
# Perform a Backup of Critical Volumes of a Domain Controller by Using the GUI (Windows Server Backup)
You can use this procedure to back up critical volumes for a domain controller by using Windows Server Backup. You can also back up critical volumes by using the **wbadmin start backup** command with the **\-allCritical** parameter. For more information, see Wbadmin start backup \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=111838](http://go.microsoft.com/fwlink/?LinkId=111838)\).  
  
> [!NOTE]  
> Windows Server Backup appears on the **Administrative Tools** menu by default, even if the Windows Server Backup feature is not installed. If Windows Server Backup is not installed, when you open Windows Server Backup, a message appears, saying that the tool is not installed and providing the instructions for installing Windows Server Backup. For more information about installing Windows Server Backup, see Installing Windows Server Backup \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=96495](http://go.microsoft.com/fwlink/?LinkID=96495)\).  
  
Membership in **Builtin Administrators** or **Backup Operators**, or equivalent, is the minimum required to complete this procedure. In addition, you must have write access to the target backup location.  
  
#### To perform a critical\-volume backup for a domain controller  
  
1.  Click **Start**, point to **Administrative Tools**, and then click **Windows Server Backup**.  
  
2.  If you are prompted, in the **User Account Control** dialog box, provide Backup Operator credentials, and then click **OK**.  
  
3.  On the **Action** menu, click **Backup once**.  
  
4.  In the Backup Once Wizard, on the **Backup options** page, click **Different options**, and then click **Next**.  
  
5.  If you are creating the first backup of the domain controller, click **Next** to select **Different options**.  
  
6.  On the **Select backup configuration** page, click **Custom**, and then click **Next**.  
  
7.  On the **Select backup items** page, select the volumes to include in the backup. If you select the **Enable system recovery** check box, all critical volumes are selected.  
  
    As an alternative, you can clear that check box, select the individual volumes that you want to include, and then click **Next**.  
  
    Your selection must include the volumes that store the operating system, Ntds.dit, and SYSVOL.  
  
    > [!NOTE]  
    > If you select a volume that hosts an operating system, all volumes that store system components are also selected.  
  
8.  On the **Specify destination type** page, click **Local drives** or **Remote shared folder**, and then click **Next**.  
  
9. Choose the backup location as follows:  
  
    -   If you are backing up to a local drive, on the **Select backup location** page, in **Backup destination**, select a drive, and then click **Next**.  
  
    -   If you are backing up to a remote shared folder, do the following:  
  
        1.  Type the path to the shared folder.  
  
        2.  Under **Access Control**, select **Do not inherit** or **Inherit** to determine access to the backup, and then click **Next**.  
  
        3.  In the **Provide user credentials for Backup** dialog box, provide the user name and password for a user who has write access to the shared folder, and then click **OK**.  
  
10. On the **Specify advanced option** page, select **VSS copy backup** and then click **Next**,  
  
11. On the **Summary** page, review your selections, and then click **Backup**.  
  
12. After the Backup Once Wizard begins the backup, click **Close** at any time. The backup runs in the background and you can view backup progress at any time during the backup. The wizard closes automatically when the backup is complete.  
  
#### Additional considerations  
The target volume for a critical\-volume backup can be a local drive, but it cannot be any of the volumes that are included in the backup.  
  
