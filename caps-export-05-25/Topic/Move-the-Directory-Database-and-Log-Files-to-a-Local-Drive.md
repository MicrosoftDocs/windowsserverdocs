---
title: Move the Directory Database and Log Files to a Local Drive
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 3bfcc111-3996-48d5-8494-72452ab53342
author: Femila
---
# Move the Directory Database and Log Files to a Local Drive
  You can use this procedure to move Active Directory database and log files to a local drive.  
  
 When you move the files to a folder on the local domain controller, you can move them permanently or temporarily. Move the files to a temporary destination if you need to reformat the original location, or move the files to a permanent location if you have additional disk space. If you reformat the original drive, use the same procedure to move the files back after the reformat is complete. Ntdsutil.exe updates the registry when you move files locally. Even if you are moving the files only temporarily, use Ntdsutil.exe so that the registry is always current.  
  
 If you do not have space on the local domain controller to move the files temporarily, you can copy files to a remote share. For information about copying files to a remote share, see [Copy the Directory Database and Log Files to a Remote Share](../Topic/Copy-the-Directory-Database-and-Log-Files-to-a-Remote-Share.md).  
  
 On a domain controller that is running Windows Server 2008, you do not have to restart the domain controller in Directory Services Restore Mode \(DSRM\) to move database files. You can stop the Active Directory Domain Services \(AD DS\) service and then restart the service after you move the files to their permanent location. For information about restartable AD DS, see the [Windows Server 2008 Restartable AD DS Step\-by\-Step Guide](http://go.microsoft.com/fwlink/?LinkId=88649) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=88649\).  
  
 Membership in **Builtin Administrators**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To move the directory database and log files to a local drive  
  
1.  Open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, provide credentials, if required, and then click **Continue**.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
     `net stop ntds`  
  
     Type `Y` to agree to stop additional services, and then press ENTER.  
  
3.  At the command prompt, change directories to the current location of the directory database file \(Ntds.dit\) or the log files, whichever you are moving.  
  
4.  Run the `dir` command, and make a note of the current size and location of the Ntds.dit file.  
  
5.  At the command prompt, type `ntdsutil`, and then press ENTER.  
  
6.  At the `ntdsutil` prompt, type `activate instance ntds`, and then press ENTER.  
  
7.  At the `ntdsutil` prompt, type `files`, and then press ENTER.  
  
8.  To move the database file, at the `file maintenance:` prompt, use the following commands:  
  
    -   To move the Ntds.dit file, type the following command, and then press ENTER:  
  
         `move db to` `<drive>:\<directory>`  
  
    -   To move the log files, type the following command, and then press ENTER:  
  
         `move logs to` `<drive>:\<directory>`  
  
     where `<drive>:\<directory>` specifies the path to the new location. If the directory does not exist, Ntdsutil.exe creates it.  
  
    > [!NOTE]  
    >  If the directory path contains any spaces, the entire path must be surrounded by quotation marks, for example, `move db to``"g:\new folder"`.  
  
9. After the move completes, at the `file maintenance`: prompt, type `quit`, and then press ENTER. Type `quit` again, and then press ENTER to quit Ntdsutil.exe.  
  
10. Change to the destination directory, and then run the `dir` command to confirm the presence of the files. If you have moved the database file, check the size of the Ntds.dit file against the file size that you noted in step 4 to be sure that you are focused on the correct file.  
  
11. If you are moving the database file or log files permanently, go to step 12.  
  
     If you are moving the database file or log files temporarily, you can now perform any required updates to the original drive. After you update the drive, repeat steps 3 through 9 to move the files back to the original location.  
  
     If the path to the database file or log files has not changed, go to step 13.  
  
12. If the path to the database file or log files has changed from the original location, check permissions on the database folder or logs folder, as follows:  
  
    1.  In Windows Explorer, right\-click the folder to which you have moved the database file or log files, and then click **Properties**.  
  
    2.  Click the **Security** tab, and then click **Advanced**. Verify that the permissions are as follows:  
  
         **Administrators** group has **Allow Full Control**.  
  
         **SYSTEM** has **Allow Full Control**.  
  
         The **Include inheritable permissions from this object’s parent** check box is cleared.  
  
         **No Deny permissions** are selected.  
  
    3.  If the permissions in step 12b are in effect, go to step 13. If permissions other than the permissions described in step 12b are in effect, perform steps 12d through 12k.  
  
    4.  If **Include inheritable permissions from this object’s parent** is selected, click **Edit**, click to clear the setting, and then click **OK**.  
  
         When you are prompted, click **Copy** to copy previously inherited permissions to this object.  
  
    5.  If **Administrators** or **SYSTEM**, or both, are not in the **Name** list, click **OK**, click **Edit**, and then click **Add**.  
  
    6.  In **From this location**, be sure that the name of the domain is selected.  
  
    7.  In **Enter the object names to select**, type **System**, if necessary, and then click **OK**. Repeat to add **Administrators**, if necessary, and then click **OK**.  
  
    8.  On the **Security** tab, click **System**, and then, in the **Allow** column, click **Full Control**. Repeat for **Administrators**.  
  
    9. In the **Group or user names** box, click any name that is not **SYSTEM** \(SID: S\-1\-5\-18\) or **Administrators** \(SID: S\-1\-5\-32\-544\), and then click **Remove**. Repeat until the only remaining accounts are **Administrators** and **SYSTEM**, and then click **OK**.  
  
        > [!NOTE]  
        >  Some accounts might appear in the form of security identifiers \(SIDs\). For more information, see [article 243330](http://go.microsoft.com/fwlink/?LinkId=182319) in the Microsoft Knowledge Base \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=182319\).  
  
    10. Click **OK** to close **Properties**.  
  
13. At the command prompt, type `ntdsutil`, and then press ENTER.  
  
14. At the `ntdsutil` prompt, type `activate instance ntds`, and then press ENTER.  
  
15. At the `ntdsutil` prompt, type `files`, and then press ENTER.  
  
16. At the `file maintenance:` prompt, type `integrity`, and then press ENTER.  
  
     If you receive an error “JET\_errOutOfSessions \-1101” when you attempt to perform the integrity check, see [article 2121690](http://go.microsoft.com/fwlink/?LinkId=205688) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=205688\) in the Microsoft Knowledge Base. If the integrity check fails, see [If the Database Integrity Check Fails, Perform Semantic Database Analysis with Fixup](../Topic/If-the-Database-Integrity-Check-Fails,-Perform-Semantic-Database-Analysis-with-Fixup.md).  
  
17. If the integrity check succeeds, type `quit`, and then press ENTER to quit the `file maintenance` prompt. Type `quit` again, and then press ENTER to quit Ntdsutil.exe.  
  
18. At the command prompt, type the following command, and then press ENTER:  
  
     `net start ntds`  
  
19. Open Event Viewer, and check the Directory Service log for errors.  
  
20. If the following events are logged in the Directory Service log in Event Viewer when you restart AD DS, stop AD DS, and then resolve the event issues as follows:  
  
    -   Event ID 1046. “The Active Directory database engine caused an exception with the following parameters.” In this case, AD DS cannot recover from this error and you must restore AD DS from backup.  
  
    -   Event ID 1168. “Internal error: An Active Directory error has occurred.” In this case, information is missing from the registry and you must restore AD DS from backup.  
  
## See Also  
 [If the Database Integrity Check Fails, Perform Semantic Database Analysis with Fixup](../Topic/If-the-Database-Integrity-Check-Fails,-Perform-Semantic-Database-Analysis-with-Fixup.md)   
 [Copy the Directory Database and Log Files to a Remote Share](../Topic/Copy-the-Directory-Database-and-Log-Files-to-a-Remote-Share.md)   
 [Recovering Active Directory Domain Services](../Topic/Recovering-Active-Directory-Domain-Services.md)  
  
  