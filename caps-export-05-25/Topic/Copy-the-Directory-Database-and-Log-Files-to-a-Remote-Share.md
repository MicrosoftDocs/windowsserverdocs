---
title: Copy the Directory Database and Log Files to a Remote Share
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 710856d1-a17f-49c1-86ce-f7a311f7f560
author: Femila
---
# Copy the Directory Database and Log Files to a Remote Share
  You can use this procedure to copy the Active Directory directory database and log files to a remote shared folder.  
  
 If you need to move the database file or the log files while you reconfigure the drive on which they are currently stored and you do not have enough space to move the files locally, you can use the **xcopy** command to copy the files to a remote shared folder temporarily and then use the same procedure to copy them back to the original drive. Use this method only if the path to the files does not change.  
  
> [!IMPORTANT]  
>  When you relocate any database files \(the database file or the log files\) off the local computer, always copy both the database file and the log files so that all the files that are necessary to restore the directory service are maintained.  
  
 If you have enough space locally on the domain controller and you do not want to copy database files to a remote share, you can use Ntdsutil to move the files to a local folder. For information about moving the database files, see [Move the Directory Database and Log Files to a Local Drive](../Topic/Move-the-Directory-Database-and-Log-Files-to-a-Local-Drive.md).  
  
 On a domain controller that is running Windows Server 2008, you do not have to restart the domain controller in Directory Services Restore Mode \(DSRM\) to copy database files. You can stop the Active Directory Domain Services \(AD DS\) service and then restart the service after you copy the files to their permanent location. For information about restartable AD DS, see the Windows Server 2008 Restartable AD DS Step\-by\-Step Guide \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=88649](http://go.microsoft.com/fwlink/?LinkId=88649)\).  
  
 Membership in **Builtin Administrators**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To copy the directory database and log files to a remote share and back to the local computer  
  
1.  Before you stop AD DS, prepare a shared directory on a remote server in the domain. Create separate subdirectories for the database files and log files. Allow access only to the Builtin Administrators group.  
  
2.  Open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, provide credentials, if required, and then click **Continue**.  
  
3.  At the command prompt, type the following command, and then press ENTER:  
  
     `net stop ntds`  
  
     Type `Y` to agree to stop additional services, and then press ENTER.  
  
4.  At the command prompt, change directories to the current location of the database file \(Ntds.dit\) or the log files. If the database file and log files are in different locations, perform step 4 for each directory.  
  
5.  Run the `dir` command, and make a note of the current size and location of the Ntds.dit file and the log files.  
  
6.  Establish a network connection to the shared folder. After you type the following command and press ENTER, you are prompted for the password for the specified account. Type the password, and then press ENTER.  
  
     `net use <NetworkDrive>: \\<ServerName>\<SharedFolderName> /user:<domainName>\<userName> *`  
  
    |Value|Description|  
    |-----------|-----------------|  
    |net use \<NetworkDrive\>:|Specifies the drive letter to use for connecting to the shared folder.|  
    |\\\\\<ServerName\>\\\<SharedFolderName\>|The universal naming convention \(UNC\) name of the shared folder location, specifying the server that stores the shared folder and the name of the shared folder, separated by a backslash.|  
    |\/user:\<domainName\>\\\<userName\>|Specifies the domain name and user name, separated by a backslash, for a user who has permissions to perform operations in AD DS.|  
    |\*|Provides a **Type the password for \\\\\<ServerName\>\\\<SharedFolderName\>:** prompt when you press ENTER.|  
  
     For example, if you shared the \\TempCopy directory on the server named SERVER1, the following command maps network drive G: to the shared location and provides the domain and user name for user tonip5:  
  
     `net use G: \\server1\tempcopy /user:contoso\tonip5 *`  
  
7.  Use the `xcopy` command to copy the database files to the location that you established in step 6. Type the following command, and then press ENTER:  
  
     `xcopy \<PathToDatabaseFiles> <NetworkDrive>:\<DatabaseSubdirectory>`  
  
     This command copies the contents of the local folder for the database to the named subfolder in the remote shared folder. For example, the following command copies the database files from their location on the domain controller to the DB subdirectory on the mapped drive G:  
  
     `xcopy \windows\ntds G:\DB`  
  
8.  Repeat step 7 to copy the log files. For example, the following command copies the log files to the Logs subdirectory on the mapped drive G:  
  
     `xcopy \windows\ntds\*.log G:\Logs`  
  
9. Change drives to the remote directory and run the `dir` command in each subdirectory to compare the file sizes to the file sizes that are listed in step 5. Use this step to ensure that you copy the correct set of files back to the local computer.  
  
10. At this point, you can safely destroy data on the original local drive.  
  
11. After the destination drive is prepared, re\-establish a connection to the network drive as described in step 6, if necessary.  
  
12. Use the method in step 7 to copy the database and log files from the remote shared folder back to the original location on the domain controller.  
  
13. At the command prompt, type `ntdsutil`, and then press ENTER.  
  
14. At the `ntdsutil` prompt, type `activate instance ntds`, and then press ENTER.  
  
15. At the `ntdsutil` prompt, type `files`, and then press ENTER.  
  
16. At the `file maintenance:` prompt, type `integrity`, and then press ENTER.  
  
     If the integrity check fails, see [If the Database Integrity Check Fails, Perform Semantic Database Analysis with Fixup](../Topic/If-the-Database-Integrity-Check-Fails,-Perform-Semantic-Database-Analysis-with-Fixup.md).  
  
17. If the integrity check succeeds, type `quit`, and then press ENTER to quit the `file maintenance:` prompt. Type `quit` again, and then press ENTER to quit Ntdsutil.exe.  
  
18. At the command prompt, type the following command, and then press ENTER:  
  
     `net start ntds`  
  
19. Open Event Viewer, and check the Directory Service log for errors.  
  
20. If the following events are logged in the Directory Service log in Event Viewer when AD DS restarts, resolve the events as follows:  
  
    -   Event ID 1046. “The Active Directory database engine caused an exception with the following parameters.” In this case, AD DS cannot recover from this error and you must restore AD DS from backup.  
  
    -   Event ID 1168. “Internal error: An Active Directory error has occurred.” In this case, information is missing from the registry and you must restore AD DS from backup.  
  
## See Also  
 [If the Database Integrity Check Fails, Perform Semantic Database Analysis with Fixup](../Topic/If-the-Database-Integrity-Check-Fails,-Perform-Semantic-Database-Analysis-with-Fixup.md)   
 [Move the Directory Database and Log Files to a Local Drive](../Topic/Move-the-Directory-Database-and-Log-Files-to-a-Local-Drive.md)   
 [Recovering Active Directory Domain Services](../Topic/Recovering-Active-Directory-Domain-Services.md)  
  
  