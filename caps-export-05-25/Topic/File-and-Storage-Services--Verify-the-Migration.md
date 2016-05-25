---
title: File and Storage Services: Verify the Migration
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 64e59201-6e75-49e0-9671-603afeb4c616
author: JasonGerend
---
# File and Storage Services: Verify the Migration
To verify that the migration was successful, follow the appropriate verification steps based on the File and Storage Services role services that have been migrated.  
  
The following overview describes the steps to verify the migration.  
  
## <a name="BKMK_BranchCache"></a>Verify the File and Storage Services migration  
Perform the following tasks to verify the File and Storage Services role migration.  
  
-   [Verify migration of BranchCache for Network File Services server key](#BKMK_BranchCache) \(only if running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]\)  
  
-   [Verify migration of local users and groups](#BKMK_VerifyMigrationofLocalUsersandGroups)  
  
-   [Verify data and shared folder migration](#BKMK_VerifyDataandShareMigration)  
  
-   [Verify migration of DFS Namespaces](#BKMK_VerifyMigrationofDFSNamespaces)  
  
-   [Verify configuration on other computers](#BKMK_VerifyconfigurationonotherComputers)  
  
-   [Verify the File Server Resource Manager migration](../Topic/File-and-Storage-Services--Verify-the-Migration.md#BKMK_VerifytheFSRMmigration)  
  
### Verify migration of BranchCache for Network File Services server key  
Perform this step only if the source server is running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]:  
  
Verify that the server key was migrated correctly by checking the key value, and ensure that the key values are identical on the source server and destination server, as shown in the following example:  
  
```  
Key: HKLM\Software\Microsoft\WindowsNT\CurrentVersion\PeerDist\SecurityManager\Restricted Value: Seed  
```  
  
### <a name="BKMK_VerifyMigrationofLocalUsersandGroups"></a>Verify migration of local users and groups  
Check that all the local users and groups you expected to migrate are present on the destination server by comparing the list of users and groups on the Local Users and Groups snap\-in on the source server with the list on the destination server.  
  
##### To open the Local Users and Groups  
  
1.  In Server Manager, click **Tools**, and then click **Computer Management**.  
  
Alternatively, you can compare the list of users and groups on the source server and destination server by typing **net** commands in a Command Prompt window.  
  
-   To get the list of all local users and save it in a text file, type the following command:  
  
    ```  
    net user > localusers.txt  
    ```  
  
-   To get the list of all local groups and save it in a text file, type the following command:  
  
    ```  
    net localgroup > localgroups.txt  
    ```  
  
### <a name="BKMK_VerifyDataandShareMigration"></a>Verify data and shared folder migration  
  
1.  Check that all the data you expected to migrate is present at the correct location on the destination server and that the data has the correct permissions associated with it.  
  
    To list files and folders with their permissions, type the following command in a Command Prompt window or in a Windows PowerShell session opened with elevated user rights:  
  
    ```  
    icacls <path>  
    ```  
  
2.  Verify that all the expected shared folders have migrated and that they have the correct permissions associated with them. To list all shared folders and their permissions, type the following command in a Windows PowerShell session opened with elevated user rights:  
  
    ```  
    gwmi win32_share | %{net share $_.name}  
    ```  
  
### <a name="BKMK_VerifyMigrationofDFSNamespaces"></a>Verify the migration of DFS Namespaces  
The procedure that you use to verify the migration of DFS Namespaces depends on whether your namespaces are stand\-alone or domain\-based.  
  
##### To verify the migration of a stand\-alone namespace  
  
1.  Open DFS Management on the destination server.  
  
2.  Right\-click **Namespaces**, or click the **Action** menu.  
  
3.  Click **Add Namespaces to Display**.  
  
4.  Type the name of the destination server, and then click the **Show Namespaces** button. Select the namespace that you migrated, and then click **OK**.  
  
5.  In the namespaces tree, click the namespace that you migrated.  
  
6.  Click the **Namespace** tab, and check that all the namespace links are present.  
  
7.  Click the **Namespace server** tab, and check that the destination server is listed.  
  
8.  Right\-click the destination server name, and then click **Open in Windows Explorer**. All namespace links should be visible in the new window.  
  
9. Using DFSUtil.exe on the destination server, type the following command for each stand\-alone namespace:  
  
    ```  
    Dfsutil.exe root \\DestinationServer\Namespace  
    ```  
  
    The information displayed should contain the destination server and all the namespace links.  
  
##### To verify the migration of a domain\-based namespace  
  
1.  Open DFS Management, and then right\-click **Namespaces** or click the **Action** menu.  
  
2.  Click **Add Namespaces to Display**.  
  
3.  Type the name of the domain where the namespace is located, and then click the **Show Namespaces** button. Select the namespace that you migrated, and click **OK**.  
  
4.  In the namespaces tree, click the namespace that you migrated.  
  
5.  Click the **Namespace** tab, and check that all the namespace links are present.  
  
6.  Click the **Namespace** server tab, and check that all the namespace servers are listed.  
  
7.  Right\-click the destination server name, and then click **Open in Windows Explorer**. All namespace links should be visible in the new window.  
  
8.  Using DFSUtil.exe on the destination server, type the following command in a Command Prompt window, where *\\\\Domain\\Namespace* is the name of the appropriate domain and namespace that you migrated.  
  
    ```  
    Dfsutil.exe root <\\Domain\Namespace>  
    ```  
  
    The information displayed should contain all namespace servers and namespace links.  
  
### <a name="BKMK_VerifyconfigurationonotherComputers"></a>Verify the configuration on other computers  
To verify that File and Storage Services migration completed successfully on other computers, you must test the configuration on the client computers in your enterprise.  
  
##### To verify DFS Namespaces on a client computer  
  
1.  Log on to a client computer with the credentials of a user who has access to the migrated namespace.  
  
2.  Verify that you can access the namespace by using File Explorer, a command prompt window, or another application, by entering the same name that you used before the migration.  
  
### <a name="BKMK_VerifytheFSRMmigration"></a>Verify the File Server Resource Manager migration  
Follow these steps to ensure that File Server Resource Manager migrated:  
  
1.  If any custom actions are configured for quota notification or file management tasks, the user should ensure that the folders that contain the executable files configured for the actions and the working folders have the correct access control lists.  
  
2.  As a best practice, ensure that all email message text for notifications, reports, and other purposes migrated correctly.  
  
3.  Administrators should send a test email message through the File Server Resource Manager console to verify that the Simple Mail Transfer Protocol \(SMTP\) server is configured correctly for the destination server.  
  
4.  Ensure that expiration folders that are used by File Management Tasks are reachable on the destination server.  
  
5.  Ensure that executable files that are used by custom actions \(such as quota notifications and file management tasks\) are accessible or executable on the destination server.  
  
## See Also  
[Migrate File and Storage Services to Windows Server 2012 R2](../Topic/Migrate-File-and-Storage-Services-to-Windows-Server-2012-R2.md)  
[File and Storage Services: Prepare to Migrate](../Topic/File-and-Storage-Services--Prepare-to-Migrate.md)  
[File and Storage Services: Migrate the File and Storage Services Role](../Topic/File-and-Storage-Services--Migrate-the-File-and-Storage-Services-Role.md)  
[File and Storage Services: Post-Migration Tasks](../Topic/File-and-Storage-Services--Post-Migration-Tasks.md)  
[File and Storage Services: Appendix A: Optional Procedures](../Topic/File-and-Storage-Services--Appendix-A--Optional-Procedures.md)  
[File and Storage Services: Appendix B: Migration Data Collection Worksheets](../Topic/File-and-Storage-Services--Appendix-B--Migration-Data-Collection-Worksheets.md)  
  
