---
title: Compact the Directory Database File (Offline Defragmentation)
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: d4a4cde3-73b4-4215-bc3d-a13804d9f68f
author: Femila
---
# Compact the Directory Database File (Offline Defragmentation)
  You can use this procedure to compact the Active Directory database offline. Offline defragmentation returns free disk space in the Active Directory database to the file system. As part of the offline defragmentation procedure, check directory database integrity.  
  
 Performing offline defragmentation creates a new, compacted version of the database file in a different location. This location can be either on the same computer or a network\-mapped drive. However, to avoid potential problems related to network issues, it is best to perform this procedure locally, if space allows. You can use locally attached external mass storage devices, such as Universal Serial Bus \(USB\), IEEE 1394, and Serial Advanced Technology Attachment \(SATA\), to provide additional disk space for defragmentation of the database.  
  
 After you compact the file to the temporary location, copy the compacted Ntds.dit file back to the original location. If space allows, maintain a copy of the original database file that you have either renamed in its current location or copied to an archival location.  
  
> [!NOTE]  
>  To perform this procedure, Active Directory Domain Services \(AD DS\) must be offline. On domain controllers that are running Windows Server 2008, you can take AD DS offline by stopping the service. Otherwise, the domain controller must be started in Directory Services Restore Mode \(DSRM\). For information about stopping the AD DS service on domain controllers that are running Windows Server 2008, see the Windows Server 2008 Restartable AD DS Step\-by\-Step Guide \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=88649](http://go.microsoft.com/fwlink/?LinkId=88649)\). For information about performing this procedure in DSRM, see Compact the directory database file \(offline defragmentation\) \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=55393](http://go.microsoft.com/fwlink/?LinkId=55393)\).  
  
 Membership in **Builtin Administrators**, or equivalent, is the minimum required to complete this procedure. If you are compacting to the database to a remote location, you must have Read and Write permissions on the destination drive and the shared folder. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
 **Disk space**  
  
-   **Current database drive**. Free space \(on the drive that contains the Active Directory database file\) equivalent of at least 15 percent of the current size of the database \(Ntds.dit\) for temporary storage during the index rebuild process.  
  
-   **Destination database drive**. Free space equivalent to at least the current size of the database for storage of the compacted database file.  
  
> [!NOTE]  
>  These disk space requirements mean that if you compress the Active Directory database on a single drive, you should have free space equivalent to at least 115 percent of the space that the current Active Directory database uses on that drive.  
  
### To perform offline defragmentation of the directory database  
  
1.  Compact the database file to a local directory or remote shared folder, as follows:  
  
    -   **Local directory:** Go to step 2.  
  
    -   **Remote directory:** If you are compacting the database file to a shared folder on a remote computer, before you stop AD DS, prepare a shared directory on a remote server in the domain. For example, create the share \\\\*ServerName*\\NTDS. Allow access to only the Builtin Administrators group. On the domain controller, map a network drive to this shared folder.  
  
    > [!IMPORTANT]  
    >  You should make a copy of the existing Ntds.dit file if at all possible, even if you have to store that copy on a network drive. If the compaction of the database does not work properly, you can then easily restore the database by copying back the copy of the Ntds.dit file that you made. Do not delete this copy of the Ntds.dit file until you have verified that the domain controller starts properly.  
  
2.  Open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, provide credentials, if required, and then click **Continue**.  
  
3.  At the command prompt, type the following command, and then press ENTER:  
  
     `net stop ntds`  
  
     Type `Y` to agree to stop additional services, and then press ENTER.  
  
4.  At the command prompt, type `ntdsutil`, and then press ENTER.  
  
5.  At the `ntdsutil` prompt, type `activate instance ntds`, and then press ENTER.  
  
6.  At the `ntdsutil` prompt, type `files`, and then press ENTER.  
  
7.  If you are compacting the database to a local drive, at the `file maintenance:` prompt, type `compact to <drive>:\ <LocalDirectoryPath>` \(where `<drive>:\ <LocalDirectoryPath>` is the path to a location on the local computer\), and then press ENTER.  
  
     If you mapped a drive to a shared folder on a remote computer, type the drive letter only, for example, `compact to K:\`.  
  
    > [!NOTE]  
    >  When you compact the database to a local drive, you must provide a path. If the path contains any spaces, enclose the entire path in quotation marks \(for example, `compact to "c:\new folder"`\). If the directory does not exist, Ntdsutil.exe creates the directory and then creates the file named Ntds.dit in that location.  
  
8.  If defragmentation completes successfully, type `quit`, and then press ENTER to quit the `file maintenance:` prompt. Type `quit` again, and then press ENTER to quit Ntdsutil.exe. Go to step 9.  
  
     If defragmentation completes with errors, go to step 12.  
  
    > [!CAUTION]  
    >  Do not overwrite the original Ntds.dit file or delete any log files.  
  
9. If defragmentation succeeds with no errors, follow the Ntdsutil.exe onscreen instructions to:  
  
    1.  To delete all the log files in the log directory, type the following command, and then press ENTER:  
  
         `del <drive>:\<pathToLogFiles>\*.log`  
  
         Ntdsutil provides the correct path to the log files in the onscreen instructions.  
  
        > [!NOTE]  
        >  You do not have to delete the Edb.chk file.  
  
    2.  You should make a copy of the existing Ntds.dit file if at all possible, even if you have to store that copy on a secured network drive. If the compaction of the database does not work properly, you can then easily restore the database by copying it back to the original location. Do not delete the copy of the Ntds.dit file until you have at least verified that the domain controller starts properly. If space allows, you can rename the original Ntds.dit file to preserve it. Avoid overwriting the original Ntds.dit file.  
  
    3.  Manually copy the compacted database file to the original location, as follows:  
  
         `copy “<temporaryDrive>:\ntds.dit” “<originalDrive>:\<pathToOriginalDatabaseFile> \ntds.dit”`  
  
         Ntdsutil provides the correct paths to the temporary and original locations of the Ntds.dit file.  
  
10. At the command prompt, type `ntdsutil`, and then press ENTER.  
  
11. At the `ntdsutil:` prompt, type `files`, and then press ENTER.  
  
12. At the `file maintenance:` prompt, type `integrity`, and then press ENTER.  
  
     If the integrity check fails, the likely cause is that an error occurred during the copy operation in step 9.c. Repeat steps 9.c through step 12. If the integrity check fails again:  
  
    -   Contact Microsoft Customer Service and Support.  
  
         Or  
  
    -   Copy the original version of the Ntds.dit file that you preserved in step 9.b. to the original database location, and repeat the offline defragmentation procedure.  
  
13. If the integrity check succeeds, proceed as follows:  
  
    -   If the initial `compact to` command failed, go back to step 7 and perform steps 7 through 12.  
  
    -   If the initial `compact to` command succeeded, type `quit` and press ENTER to quit the `file maintenance:` prompt, and then type `quit` and press ENTER again to quit Ntdsutil.exe.  
  
14. Restart AD DS. At the command prompt, type the following command, and then press ENTER:  
  
     `net start ntds`  
  
 If errors appear when you restart AD DS:  
  
1.  Stop AD DS. At the command prompt, type the following command, and then press ENTER:  
  
     `net stop ntds`  
  
     Type `Y` to agree to stop additional services, and then press ENTER.  
  
2.  Check the errors in Event Viewer.  
  
     If the following events are logged in the Directory Service log in Event Viewer when you restart AD DS, respond to the events as follows:  
  
    -   Event ID 1046. “The Active Directory database engine caused an exception with the following parameters.” In this case, AD DS cannot recover from this error and you must restore from backup media.  
  
    -   Event ID 1168. “Internal error: An Active Directory error has occurred.” In this case, information is missing from the registry and you must restore from backup media.  
  
3.  Check database integrity, and then proceed as follows:  
  
     If the integrity check fails, try repeating step 9.c through step 12 above, and then repeat the integrity check. If the integrity check fails again:  
  
    -   Contact Microsoft Customer Service and Support.  
  
         Or  
  
    -   Copy the original version of the Ntds.dit file that you preserved in step 9.b. to the original database location and repeat the offline defragmentation procedure.  
  
         If the integrity check succeeds, follow the steps in the procedure [If the Database Integrity Check Fails, Perform Semantic Database Analysis with Fixup](../Topic/If-the-Database-Integrity-Check-Fails,-Perform-Semantic-Database-Analysis-with-Fixup.md).  
  
4.  If semantic database analysis with fixup succeeds, quit Ntdsutil.exe, and then restart AD DS. At the command prompt, type the following command, and then press ENTER:  
  
     `net start ntds`  
  
 If semantic database analysis with fixup fails, contact Microsoft Customer Service and Support.  
  
## See Also  
 [If the Database Integrity Check Fails, Perform Semantic Database Analysis with Fixup](../Topic/If-the-Database-Integrity-Check-Fails,-Perform-Semantic-Database-Analysis-with-Fixup.md)  
  
  