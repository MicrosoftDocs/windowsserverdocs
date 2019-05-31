---
title: AD Forest Recovery - Windows Server 2003 Recovery
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 07/07/2017
ms.topic: article
ms.prod: windows-server-threshold
ms.assetid: 5a291f65-794e-4fc3-996e-094c5845a383
ms.technology: identity-adds
---
# AD Forest Recovery - Windows Server 2003 Recovery

>Applies To: Windows Server 2003

This topic includes forest recovery procedures for domain controllers (DCs) that run Windows Server 2003. The general process for forest recovery is no different with Windows Server 2003 DCs, but specific procedures can differ because of different tools. For example, Ntdsutil.exe can be used to backup and restore DCs that run Windows Server 2003 DCs, whereas Windows Server Backup or Wbadmin.exe is used for DCs that run Windows Server 2008 or later.  
  
- [Backing up the System State data](#backing-up-the-system-state-data)  
- [Performing a nonauthoritative restore](#performing-a-nonauthoritative-restore)  
- [Install and configure the DNS Server service](#install-and-configure-the-dns-server-service)

## Backing up the System State data
Use the following procedure to back up the System State data, along with any other data you have selected for the current backup operation, of a DC that runs Windows Server 2003. Windows Server 2003 includes the Ntbackup tool, which you can use to back up System State data.  
  
Membership in **Administrators** or **Backup Operators**, or equivalent, is the minimum required to back up files and folders.   
  
If you are backing up the System State data to a tape, and the Backup program indicates that there is no unused media available, you might have to use Removable Storage. This adds your tape to the free media pool so that Backup can use it.  
  
You can only back up the System State data on a local computer. You cannot back it up on a remote computer.  
  
### To back up the System State data on a domain controller that runs Windows Server 2003  
  
1. Click **Start**, point to **All Programs**, point to **Accessories**, point to **System Tools**, and then click **Backup**.  
2. On the **Welcome** page, click **Advanced Mode**.  
3. On the **Backup** tab, select the check box for any drive, folder, or file that you want to back up.  
4. Select the **System State** check box.  
5. Click **Start Backup**.  
  
## Performing a nonauthoritative restore  

Use the following procedure to perform a nonauthoritative restore of a DC that runs Windows Server 2003. By performing a nonauthoritative restore on Active Directory in Windows Server 2003, you automatically perform a nonauthoritative restore of SYSVOL. No additional steps are required.  
  
> [!NOTE]
> If you are also reinstalling the Windows Server 2003 operating system, you might or might not join the computer to the domain and you can give any name to the computer during setup of the operating system. Do not install Active Directory. After reinstalling the operating system, go directly to step 4.  
  
On Windows Server 2003 domain controllers where you have restored only system state data, you need to also reinstall any software applications that were running on DCs before recovery. Restoring AD DS on the first DC in the domain also restores the registry because they both are part of System State data. Keep this in mind if you had any applications running on these DCs and if they had any information stored in the registry.  
  
To save time required to re-install software, determine if applications that need to be installed on the DCs are compatible with virtual DC cloning. Such applications can be installed on the source DC prior to cloning in order to save the time and effort required to install them on the cloned virtual DCs.  
  
### To perform a nonauthoritative restore
  
1. After you start the DC, press F8 to restart the computer in Directory Services Restore Mode (DSRM).  
2. Select **Directory Services Restore Mode (Windows domain controllers only)**.  
3. Select the operating system that you want to start in restore mode.  
4. Log on as an administrator (you can only use a local computer account, no domain logon option is available).  
5. At a command prompt, type **ntbackup**, and then press ENTER.  
6. On the **Welcome** page, click **Advanced Mode**, and then select the **Restore and Manage Media** tab. (Do not select **Restore Wizard**.)  
7. Select the appropriate backup file to restore from and ensure that the **System disk** and **System State** check boxes are selected.  
8. Click **Start Restore**.  
9. When the restore operation is complete, restart the computer.  
  
Use the following procedure to perform an authoritative (also known as primary) restore of SYSVOL on a DC that runs Windows Server 2003. Perform this procedure only on the first Windows Server 2003 DC that is restored in the domain.  
  
### To perform an authoritative restore of SYSVOL  
  
1. Perform steps 1 through 8 in the previous procedure.  
2. In the **Confirm Restore** dialog box, click **Advanced**.  
3. To perform an authoritative restore of SYSVOL, select the check box **When restoring replicated data sets, mark the restored data as the primary data for all replicas**.  

   > [!NOTE]
   > Marking the restored data as the primary data in the Backup is equivalent to setting the **BurFlags** entry to D4 under the following registry subkey:  
   >   
   > **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NtFrs\Parameters\Cumulative Replica Sets\\** *GUID*  

4. When the restore operation is complete, restart the computer.  
  
## Install and configure the DNS Server service

If the DC that you restored from backup is running Windows Server 2003, you can install DNS server without connecting the DC to any network.  
  
### To install and configure the DNS Server service  
  
1. Open Windows Components Wizard. To open the wizard:  

   - Click **Start**, click **Control Panel**, and then click **Add or Remove Programs**.  
   - Click **Add/Remove Windows Components**.  

2. In **Components**, select the **Networking Services** check box, and then click **Details**.  
3. In **Subcomponents of Networking Services**, select the **Domain Name System (DNS)** check box, click **OK**, and then click **Next**.  
4. If you are prompted, in **Copy files from**, type the full path of the distribution files, and then click **OK**.  

   After the installation, complete the following steps to configure the DNS server.  

5. Click **Start**, point to **All Programs**, point to **Administrative Tools**, and then click **DNS**.  
6. Create DNS zones for the same DNS domain names that were hosted on the DNS servers before the critical malfunction. For more information, see Add a Forward Lookup Zone ([https://go.microsoft.com/fwlink/?LinkId=74574](https://go.microsoft.com/fwlink/?LinkId=74574)).  
7. Configure the DNS data as it existed before the critical malfunction. For example:  

   - Configure DNS zones to be stored in AD DS. For more information, see Change the Zone Type ([https://go.microsoft.com/fwlink/?LinkId=74579](https://go.microsoft.com/fwlink/?LinkId=74579)).  
   - Configure the DNS zone that is authoritative for domain controller locator (DC Locator) resource records to allow secure dynamic update. For more information, see Allow Only Secure Dynamic Updates ([https://go.microsoft.com/fwlink/?LinkId=74580](https://go.microsoft.com/fwlink/?LinkId=74580)).  

8. Ensure that the parent DNS zone contains delegation resource records (name server (NS) and glue host (A) resource records) for the child zone that is hosted on this DNS server. For more information, see Create a Zone Delegation ([https://go.microsoft.com/fwlink/?LinkId=74562](https://go.microsoft.com/fwlink/?LinkId=74562)).  
9. After you configure DNS, at the command prompt, type the following command, and then press ENTER:  

   **net stop netlogon**

10. Type the following command, and then press ENTER:  

    **net start netlogon**

    > [!NOTE]
    > Net Logon will register the DC Locator resource records in DNS for this DC. If you are installing the DNS Server service on a server in the child domain, this DC will not be able to register its records immediately. This is because it is currently isolated as part of the recovery process, and its primary DNS server is the forest root DNS server. Configure this computer with the same IP address as it had before the disaster to avoid DC service lookup failures.

## Next Steps

- [AD Forest Recovery - Prerequisites](AD-Forest-Recovery-Prerequisties.md)  
- [AD Forest Recovery - Devising a custom forest recovery plan](AD-Forest-Recovery-Devising-a-Plan.md)  
- [AD Forest Recovery - Identify the problem](AD-Forest-Recovery-Identify-the-Problem.md)
- [AD Forest Recovery - Determine how to recover](AD-Forest-Recovery-Determine-how-to-Recover.md)
- [AD Forest Recovery - Perform initial recovery](AD-Forest-Recovery-Perform-initial-recovery.md)  
- [AD Forest Recovery - Procedures](AD-Forest-Recovery-Procedures.md)  
- [AD Forest Recovery - Frequently Asked Questions](AD-Forest-Recovery-FAQ.md)  
- [AD Forest Recovery - Recovering a Single Domain within a Multidomain Forest](AD-Forest-Recovery-Single-Domain-in-Multidomain-Recovery.md)  
- [AD Forest Recovery - Forest Recovery with Windows Server 2003 Domain Controllers](AD-Forest-Recovery-Windows-Server-2003.md) 
