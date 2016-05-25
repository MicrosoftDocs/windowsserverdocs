---
title: Issues with Update Storage
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4615d075-9566-40b4-8336-7389d4cc0c41
author: britw
---
# Issues with Update Storage
Updates can be stored on the local WSUS server or on Microsoft Update. Use this section to troubleshoot problems with update storage.  
  
## Troubleshooting update storage  
  
#### The updates listed in the WSUS administrative console do not match the updates listed in your local folder  
This can happen under different circumstances. For example, if updates are stored on a disk separate from the one on which WSUS is installed, and that disk fails, when you replace the failed disk with a new \(empty\) disk, the WSUS application will still show all of the updates as downloaded.  
  
To have WSUS resynchronize the updates in local storage with the updates in the database, you must run the **wsusutil reset** command. For more information about the **wsusutil** tool, see [Manage WSUS 3.0 SP2 from the Command Line](../Topic/Manage-WSUS-3.0-SP2-from-the-Command-Line.md).  
  
> [!NOTE]  
> Resetting the WSUS server causes it to be unresponsive for up to five minutes.  
  
###### To have WSUS verify locally stored updates  
  
1.  Open a Command Prompt window.  
  
2.  The **wsusutil** tool is located in the *WSUSInstallDrive:\\WSUSInstallDirectory***\\Tools** folder on WSUS servers.  
  
3.  Type **wsusutil reset**.  
  
#### Downloads from a WSUS server are failing  
There may be problems with the permissions on the WSUS server's local content directory. Permissions are set correctly by WSUS setup when the directory is created, but subsequent changes may have reset these permissions. One indication of this problem may be event ID 10012 in the Application log file.  
  
The following permissions are necessary:  
  
-   The root folder of the local content directory must have at least Read permissions for the Users security group and the NT Authority\\Network Service account. For example, if the WSUS content directory is C:\\Updates\\WSUSContent, the Updates directory must have the correct permissions. The BITS service will fail if these permissions are not set.  
  
-   The content directory \(in the above example, the WSUSContent directory\) must have Full Control permissions for the NT Authority\\Network Service account.  
  
-   The temporary ASP.NET directory \(*%windir%\\*Microsoft.NET\\Framework\\v2.0.50727\\Temporary ASP.NET Files\) must have Full Control permissions for the NT Authority\\Network Service account.  
  
-   The %TEMP% directory \(usually %windir%\\TEMP\) must have Full Control permissions for the NT Authority\\Network Service account.  
  
#### The local content directory is running out of disk space  
Synchronization may fail if the local WSUS content directory does not have sufficient disk space. It is recommended that you monitor disk space carefully to keep this problem from arising. Low disk space is indicated by event ID 10041 and event ID 10042.  
  
The following procedures will help you overcome low disk space problems:  
  
-   Using Disk Cleanup to remove unneeded files on the hard drive.  
  
-   Using the Server Cleanup Wizard to remove unneeded content. For more information about this wizard, see [Using the Server Cleanup Wizard](assetId:///82c7c6ab-f877-4f85-8afe-0b36f5a2e0d4).  
  
-   Moving the content directory to another hard drive.  
  
-   Moving the SQL Server database to another hard drive.  
  
###### To use Disk Cleanup to remove unneeded files on the hard drive  
  
1.  Click **Start**, click **All Programs**, click **Accessories**, click **System Tools**, and then click **Disk Cleanup**.  
  
2.  Select the Windows components, applications, and files that can be removed, and then click **OK**.  
  
###### To move the content directory to another hard drive  
  
1.  Create a new content directory on another hard drive.  
  
2.  Locate the WSUSUtil.exe utility in the Tools directory of your WSUS installation \(typically C:\\Program Files\\Update Services\\Tools\).  
  
3.  Open a Command Prompt window, navigate to the Tools directory, and type the following:  
  
    **wsusutil movecontent** *NewContentPath* *MoveLog*  
  
where *NewContentPath* is the new content directory, and *MoveLog* is the path and filename of the log for this operation.  
  
> [!NOTE]  
> For more information about using the **wsusutil** tool, see [Manage WSUS 3.0 SP2 from the Command Line](../Topic/Manage-WSUS-3.0-SP2-from-the-Command-Line.md).  
  
Before you move the SQL Server installation to another hard drive, you should make sure that the WSUS administration console is not open. If you have problems with the move, make sure that the WSUS web services have been stopped. Occasionally, a move will fail if the client computers are communicating with the server.  
  
###### To move the SQL Server installation to another hard drive  
  
1.  Open a Command Prompt window.  
  
2.  Type **net stop wsusservice**.  
  
3.  Detach the SUSDB database.  
  
4.  Copy SUSDB.mdf and SUSDB\_log.ldf to the new location.  
  
5.  Attach the SUSDB database from the new location.  
  
    > [!NOTE]  
    > Consult your SQL Server documentation to find out how to detach and attach databases.  
  
6.  Type **net start wsusservice**.  
  
7.  When the system is working properly, delete SUSDB.mdf and SUSDB\_log.ldf from the old location.  
  
