---
title: Create Installation Media by Using Ntdsutil
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 002351e7-68d3-475e-97ac-436832092024
author: Femila
---
# Create Installation Media by Using Ntdsutil
  You can use the procedures in this topic to complete the following tasks for creating installation media to install Active Directory Domain Services \(AD DS\):  
  
-   [Create installation media for IFM](../Topic/Create-Installation-Media-by-Using-Ntdsutil.md#BKMK_CreateIFM)  
  
-   [Install a performance counter to verify how many files in the SYSVOL shared folder are obtained from the installation media](../Topic/Create-Installation-Media-by-Using-Ntdsutil.md#BKMK_Counter)  
  
     This step is optional. It is necessary only if you want to verify that the files in SYSVOL on the installation media are used to install an additional [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controller instead of replicating the files over the network during the installation.  
  
-   [Copy the installation media with SYSVOL to a destination domain controller](../Topic/Create-Installation-Media-by-Using-Ntdsutil.md#BKMK_CopyIFM)  
  
     This step is required only if SYSVOL is included in the installation media. To preseed SYSVOL data, the source domain controller and the destination domain controller must run [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
 After you create the installation media, you can refer to the shared folder or removable media container where you stored the installation media when you created additional domain controllers in the domain, as follows:  
  
-   In the Active Directory Domain Services Installation Wizard, on the **Install from Media** page  
  
-   In an unattended installation answer file, in the **\/ReplicationSourcePath** parameter  
  
 For more information, see [Installing an Additional Domain Controller by Using IFM](../Topic/Installing-an-Additional-Domain-Controller-by-Using-IFM.md).  
  
##  <a name="BKMK_CreateIFM"></a> Create installation media for IFM  
 This task uses the Install from Media \(IFM\) option. Create the media on a domain controller in the domain where you are installing one or more new domain controllers.  
  
 The following procedure uses the Ntdsutil tool to create the installation media. You can also create the installation media by restoring a critical\-volume backup to an alternate location. That method is not recommended because it takes significantly longer than using Ntdsutil. It also requires more space for the installation media, which contain more data than is required for installing AD DS. For more information, see Restoring a Critical\-Volume Backup to an Alternate Location \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=120612](http://go.microsoft.com/fwlink/?LinkID=120612)\).  
  
 The ability to log on to a domain controller locally and to back up a domain controller is the minimum required to complete this procedure. Members of **Builtin Administrators**, **Enterprise Admins**, **Domain Admins**, **Backup Operators**, and **Server Operators** have these rights by default. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
 On a read\-only domain controller \(RODC\), you can have a delegated user create the installation media. However, that user can create only the RODC installation media \(not the installation media for a writable domain controller\) on an RODC.  
  
#### To create installation media for IFM  
  
1.  Open a command prompt \(cmd.exe\) as an administrator. To open a command prompt as an administrator, click **Start**. In **Start Search**, type **Command Prompt**. At the top of the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, enter the appropriate credentials \(if requested\) and confirm that the action it displays is what you want, and then click **Continue**.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
    ```  
    ntdsutil  
    ```  
  
3.  At the `ntdsutil` prompt, type the following command, and then press ENTER:  
  
    ```  
    activate instance ntds  
    ```  
  
4.  At the `ntdsutil` prompt, type the following command, and then press ENTER:  
  
    ```  
    ifm  
    ```  
  
5.  At the `ifm` prompt, type the command for the type of installation media that you want to create, and then press ENTER. For example, to create installation media for a writable domain controller with SYSVOL, type the following command:  
  
    ```  
    create sysvol full <Drive>:\<InstallationMediaFolder>  
    ```  
  
     Where `<Drive>:\<InstallationMediaFolder>` is the path to the folder where you want the installation media to be created. You can save the installation media to a network shared folder or to removable media. The IFM process creates a temp database in the %TMP% folder. You need at least 110% of the size of the AD DS or AD LDS database free on the drive where the %TMP% folder is in order for the operation to succeed. You can redirect the %TMP% folder to another disk on the server in order to use more space.  
  
    > [!IMPORTANT]  
    >  If you create installation media with SYSVOL, use Robocopy.exe to copy the installation media from where it is saved to the destination domain controller that you want to add to the domain.  
  
##  <a name="BKMK_Counter"></a> Install a performance counter to verify how many files in the SYSVOL shared folder are obtained from the installation media  
 If you install the Distributed File System \(DFS\) Replication performance counter **Total Files Received** and scope it to the SYSVOL replicated folder on the destination domain controller, you can determine how many files it received from its replication partner \(an existing domain controller that is already advertising SYSVOL\) during initial synchronization versus how many files were obtained from the installation media. If you have successfully preseeded SYSVOL data from media, this number should be low.  
  
 You must install the performance counter on the destination domain controller before you install AD DS on it.  
  
 You must be an Administrator on the destination server to complete this procedure.  
  
#### To install the Total Files Received DFS Replication performance counter  
  
1.  Open Server Manager. To open Server Manager, click **Start**. Click **Administrative Tools**. Click **Server Manager \(servermanager.msc\)**. If the **User Account Control** dialog box appears, enter the appropriate credentials \(if requested\) and confirm that the action it displays is what you want, and then click Continue.  
  
2.  Double\-click **Diagnostics**, double\-click **Performance**, double\-click **Data Collector Sets**, right\-click **User Defined**, point to **New**, and then click **Data Collector Set**.  
  
3.  Type a name for the data collector set, and then click **Next**.  
  
4.  Click **Basic**, and then click **Next**.  
  
5.  Type a location where you want to save the new data collector set, and then click **Next**.  
  
6.  Click **Start this data collector set now**, and then click **Finish**.  
  
7.  In the console tree, click the new data collector set.  
  
8.  In the details pane, right\-click **Performance Counter**, and then click **Properties**.  
  
9. Click **Add**.  
  
10. Double\-click **DFS Replicated Folders**, click **Total Files Received**, click **SYSVOL Share {C116FC7E\-1CE1\-4F62\-A63F\-210204C47BA6}**, click **Add**, and then click **OK** twice.  
  
11. Right\-click the new data collector set, and then click **Start**.  
  
12. At this point, the destination server is ready to capture the total number of files that will be replicated from a partner domain controller during the AD DS installation. The next steps explain how to read the report that is generated.  
  
13. In Server Manager, double\-click **Diagnostics**, double\-click **Performance**, double\-click **Reports**, double\-click **User Defined**, double\-click the name of the data collector set, and then double\-click the report that corresponds to the time that you ran Performance Monitor.  
  
14. Click **View**, and then click **Performance Monitor**.  
  
15. By default, the report generates a line graph. Click the **Change graph type** pull\-down menu, and then click **Report** \(or click Ctrl\+G twice\).  
  
16. The **Total Files Received** row indicates how many files of the SYSVOL folder were replicated from a partner domain controller during the AD DS installation.  
  
##  <a name="BKMK_CopyIFM"></a> Copy the installation media with SYSVOL to a destination domain controller  
 Use the following procedure to copy the installation media to the destination domain controller. Use Robocopy.exe to complete these steps so that you can preserve the access control list \(ACL\) on the SYSVOL shared folder.  
  
 You must be able to log on to the source domain controller and you must have permission to write to the destination folder to complete this procedure.  
  
#### To copy the installation media with SYSVOL to a destination domain controller  
  
1.  Open a command prompt \(cmd.exe\) as an administrator. To open a command prompt as an administrator, click **Start**. In **Start Search**, type **Command Prompt**. At the top of the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, enter the appropriate credentials \(if requested\) and confirm that the action it displays is what you want, and then click **Continue**.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
    ```  
    robocopy.exe /E /COPYALL <source location> <destination location>  
    ```  
  
     For example, if the source location is folder named InstallationMediaFolder on the C:\\ drive of the source domain controller, and the destination location is a shared folder named IFM on a destination server named RODC01, type the following command, and then press ENTER:  
  
    ```  
    robocopy.exe /E /COPYALL c:\InstallationMediaFolder \\RODC01\IFM  
    ```  
  
    > [!IMPORTANT]  
    >  The next steps are required to change the SYSVOL folder security settings. These steps change the file hash, which will become the same file hash as in the IFM. If youi use DFS Replication, SYSVOL will keep the preseeded data only if the file hash on the source domain controller and the destination server are the same.  
  
3.  On the destination server, right\-click the SYSVOL folder, and then click **Properties**.  
  
4.  Click the **Security** tab, and then click **Advanced**.  
  
5.  Click the **Auditing** tab, and then click **Edit**.  
  
6.  Clear the **Include inheritable auditing entries from this object’s parent** check box, and then select it again.  
  
7.  Click **Apply**, and then click **OK**.  
  
## See Also  
 [Create an Answer File for Unattended Domain Controller Installation](../Topic/Create-an-Answer-File-for-Unattended-Domain-Controller-Installation.md)   
 [Installing an Additional Domain Controller by Using IFM](../Topic/Installing-an-Additional-Domain-Controller-by-Using-IFM.md)  
  
  