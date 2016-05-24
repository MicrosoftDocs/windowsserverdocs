---
title: Performing a Full Server Recovery of a Domain Controller
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: fd79a503-dfe7-483a-9de1-a7b39dae76aa
author: Femila
---
# Performing a Full Server Recovery of a Domain Controller
When you perform a full server recovery, you recover all volumes from the backup set to the server. The procedure to perform full server recovery of a domain controller is the same as for any server running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. Whenever you perform a full server recovery of a domain controller, you perform a nonauthoritative restore of Active Directory Domain Services \(AD DS\).  
  
You can use these procedures to perform full server recovery of a domain controller by using Windows Complete PC Restore \(a graphical user interface \(GUI\) tool\) and Wbadmin.exe from the command line.  
  
## Requirements for performing a full server recovery of a domain controller  
Full server recovery of a domain controller has the following requirements:  
  
-   You must have a full server backup available. This type of backup contains all volumes that were on the server at the time that you made the backup.  
  
-   You can store the backup on a separate, internal or external hard drive or a DVD. If you performed a manual backup, you can perform a full server recovery from a network shared folder.  
  
    > [!NOTE]  
    > Windows Server Backup does not enumerate drives that are not attached or turned on when you start the Recovery Wizard. If you attach or turn on a drive after you start the wizard, and you do not see it in the list of backup locations that you can restore from, close, and then restart Windows Server Backup.  
  
-   You must have the [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] operating system DVD or have Windows RE installed on a different partition than the critical partitions that are used by the domain controller that you are restoring.  
  
-   If you are recovering to new hardware, the new hardware must provide enough storage capacity to recover all volumes. In other words, the hard drives that you are recovering data to must be as large as—or larger than—the drives that are included in the backup set.  
  
## Performing a full server recovery of a domain controller by using the GUI  
You can use this procedure to perform full server recovery of a domain controller with Windows Complete PC Restore.  
  
There are no administrative credential requirements. No authentication is performed when you start in Windows RE.  
  
#### To perform full server recovery of a domain controller \(a nonauthoritative restore\) by using the GUI  
  
1.  Insert the [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] installation DVD into the disk drive, and then restart the domain controller.  
  
2.  When you are prompted, press a key to start from the DVD.  
  
3.  At the initial **Windows** screen, accept or select language options, the time and currency format, and a keyboard layout, and then click **Next**.  
  
4.  At the **Install now** screen, click **Repair your computer**.  
  
5.  In the **System Recovery Options** dialog box, click anywhere to clear any operating systems that are selected for repair, and then click **Next**.  
  
6.  Under **Choose a recovery tool**, click **Windows Complete PC Restore**.  
  
7.  If the backup is stored on a remote server, a message indicates that Windows cannot find a backup on the hard disks or DVDs on this computer. Click **Cancel** to close the message.  
  
8.  Click **Restore a different backup**, and then click **Next**.  
  
9. On the **Select the location of the backup** page, perform either set of the following steps, depending on whether the backup is stored locally or on a network shared folder:  
  
    1.  If the backup is stored on the local computer, select the location of the backup, and then click **Next**.  
  
        Or  
  
    2.  If the backup is stored on a network shared folder, click **Advanced**, and then click **Search for a backup on the network**.  
  
    3.  Click **Yes** to confirm that you want to connect to the network.  
  
    4.  In **Network Folder**, type the Universal Naming Convention \(UNC\) name for the network share, and then click **OK**.  
  
    5.  Type credentials for a user account that has sufficient permissions to restore the backup, and then click **OK**.  
  
    6.  On the **Select the location of the backup** page, click the location of the backup, and then click **Next**.  
  
10. Click the backup to restore, and then click **Next**.  
  
11. If you want to replace all data on all volumes, regardless of whether they are included in the backup, on the **Choose how to restore the backup** page, select the **Format and repartition disks** check box.  
  
12. To prevent volumes that are not included in the restore from being deleted and re\-created, click **Exclude Disks**, select the check box for the disks that you want to exclude, and then click **OK**.  
  
13. Click **Next**, and then click **Finish**.  
  
14. Select the **I confirm that I want to format the disks and restore the backup** check box, and then click **OK**.  
  
## Performing a full server recovery of a domain controller by using the command line  
Use the following procedure to perform full server recovery of a domain controller from the command line.  
  
There are no administrative credential requirements. No authentication is performed when you start in Windows RE.  
  
#### To perform full server recovery of a domain controller \(a nonauthoritative restore\) by using the command line  
  
1.  Insert the [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] installation DVD into the disk drive, and then restart the domain controller.  
  
2.  When you are prompted, press a key to start from the DVD.  
  
3.  At the initial **Windows** screen, accept or select language options, the time and currency format, and a keyboard layout, and then click **Next**.  
  
4.  At the **Install now** screen, click **Repair your computer**.  
  
5.  In the **System Recovery Options** dialog box, click anywhere to clear any operating systems that are selected for repair, and then click **Next**.  
  
6.  Under **Choose a recovery tool**, click **Command Prompt**.  
  
7.  At the `Sources` prompt, type `diskpart`, and then press ENTER.  
  
8.  At the `Diskpart` prompt, type `list vol`, and then press ENTER.  
  
9. Identify the volume from the list that corresponds to the location of the full server backup that you want to restore.  
  
    The drive letters in Windows RE do not necessarily match the volumes as they appear in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].  
  
10. Type `exit`, and then press ENTER.  
  
11. At the `Sources` prompt, type the following command, and then press ENTER:  
  
    `wbadmin get versions -backupTarget:<targetDrive>:`  
  
    `-machine:<BackupComputerName>`  
  
    Where:  
  
    -   `<targetDrive>:` is the location of the backup that you want to restore.  
  
    -   `<BackupComputerName`> is the name of the computer where you want to recover the backup. This parameter is required, if the backup is stored on a remote computer.  
  
12. Identify the version that you want to restore.  
  
    You must enter this version exactly in the next step.  
  
13. At the `Sources` prompt, type the following command, and then press ENTER:  
  
    `wbadmin start sysrecovery -version:<MM/DD/YYYY-HH:MM>`  
  
    `-backuptarget:<targetDrive>: -machine:<BackupComputerName>`  
  
    `-restoreAllVolumes`  
  
    Where:  
  
    -   `<MM/DD/YYYY-HH:MM>` is the version of the backup that you want to restore.  
  
    -   `<targetDrive>:` is the drive that contains the backup.  
  
    -   `<BackupComputerName>` is the name of the computer where you want to recover the backup. This parameter is useful when you have backed up multiple computers to the same location or you have renamed the computer since the backup was taken.  
  
14. When you are prompted, press Y to proceed with the restore process.  
  
15. After the recovery operation has completed, minimize the command window, and then, in the **System Recovery Options** dialog box, click **Restart**.  
  
## Additional considerations  
Be aware of the following issues when you perform a full server recovery of a domain controller:  
  
-   Wbadmin.exe does not require that you provide the recovery target. By specifying the backup version that you want to recover, the command proceeds to recover to the source location of the specified backup version.  
  
-   Backup files are named for the date and time of the backup. When you recover, the version must be stated in the form MM\/DD\/YYYY\-HH:MM, which specifies the name of the backup that you want to recover.  
  
-   After the restore is completed, restart the server normally, and perform basic verification. When you restart the computer normally, AD DS and Active Directory Certificate Services \(AD CS\) automatically detect that they have been recovered from a backup. They perform an integrity check and index the database again.  
  
-   After you log on to the system, browse AD DS. Verify that the following conditions are met:  
  
    -   All of the user objects and group objects that were present in the directory at the time of the backup are restored.  
  
    > [!NOTE]  
    > Active Directory replication updates the objects that you restore with any changes that have been made to them since the time that the backup was taken.  
  
    -   Files that were members of a File Replication Service \(FRS\) replica set and certificates that were issued by AD CS are present.  
  
    -   The Windows Time service \(W32time\) is synchronized correctly.  
  
    -   The NETLOGON and SYSVOL folders are properly shared.  
  
    -   The Preferred DNS server address is configured correctly.  
  
    -   Host \(A\) and service \(SRV\) resource records are registered correctly in Domain Name System \(DNS\).  
  
