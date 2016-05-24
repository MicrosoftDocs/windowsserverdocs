---
title: Forcing the Removal of a Domain Controller
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: ae4dd0e3-2019-4278-8efd-61c36ba9e1c0
author: Femila
---
# Forcing the Removal of a Domain Controller
  The procedures in this section describe how you can forcefully remove a domain controller running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. In [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], you can forcefully remove a domain controller when it is started in Directory Services Restore Mode \(DSRM\).  
  
 Typically, you force the removal of a domain controller only if the domain controller has no connectivity with other domain controllers. Because the domain controller cannot contact other domain controllers during the operation, the Active Directory forest metadata is not updated automatically as it is when a domain controller is removed normally. Instead, you must update the forest metadata manually after you remove the domain controller. If you use the version of the Active Directory Users and Computers snap\-in that is included with [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. or the Microsoft Remote Server Administration Tools for Windows Vista \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=115118](http://go.microsoft.com/fwlink/?LinkID=115118)\), you can clean up the metadata automatically by deleting the domain controller object.  
  
 The procedures in this section describe the following methods that you can use to forcefully remove a domain controller:  
  
-   [Forcing the removal of a domain controller by using the Windows interface](../Topic/Forcing-the-Removal-of-a-Domain-Controller.md#BKMK_GUI)  
  
     To use the Windows interface, you must start the Active Directory Domain Services Installation Wizard at the command line by running the **dcpromo \/forceremoval** command.  
  
-   [Forcing the removal of a domain controller by using the command line](../Topic/Forcing-the-Removal-of-a-Domain-Controller.md#BKMK_CMD)  
  
-   [Forcing the removal of a domain controller by using an answer file](../Topic/Forcing-the-Removal-of-a-Domain-Controller.md#BKMK_ANSW)  
  
##  <a name="BKMK_GUI"></a> Forcing the removal of a domain controller by using the Windows interface  
 **Administrative credentials**  
  
 To forcefully remove a domain controller, you must be a member of the Domain Admins group.  
  
#### To force the removal of a domain controller by using the Windows interface  
  
1.  At a command prompt, type the following command, and then press ENTER:  
  
     `dcpromo /forceremoval`  
  
     If the domain controller hosts any operations master \(also known as flexible single master operations or FSMO\) roles, or if it is a Domain Name System \(DNS\) server or a global catalog server, warnings appear that explain how the forced removal will affect the rest of the environment. After you read each warning, click **Yes**. If you want to suppress the warnings in advance of the removal operation, you must force the removal of Active Directory Domain Services \(AD DS\) by using an answer file. In the answer file, specify the parameter **demotefsmo\=yes**.  
  
2.  On the **Welcome to the Active Directory Domain Services Installation Wizard** page, click **Next**.  
  
3.  On the **Force the Removal of Active Directory Domain Services** page, review the information about forcing the removal of AD DS and metadata cleanup requirements, and then click **Next**.  
  
4.  On the **Administrator Password** page, type and confirm a secure password for the local Administrator account, and then click **Next**.  
  
5.  On the **Summary** page, review your selections. Click **Back** to change any selections, if necessary.  
  
     To save the settings that you selected to an answer file that you can use to automate subsequent AD DS operations, click **Export settings**. Type a name for your answer file, and then click **Save**.  
  
     When you are sure that your selections are accurate, click **Next** to remove AD DS.  
  
6.  You can either select the **Reboot on completion** check box to have the server restart automatically or you can restart the server to complete the removal of AD DS when you are prompted to do so.  
  
7.  [!INCLUDE[rmt_proc](../Token/rmt_proc_md.md)]  
  
8.  In **Roles Summary**, click **Remove Roles**.  
  
9. If necessary, review the information on the **Before You Begin** page, and then click **Next**.  
  
10. On the **Remove Server Roles** page, clear the **Active Directory Domain Services** check box, and then click **Next**.  
  
11. On the **Confirm Removal Selections** page, click **Remove**.  
  
12. On the  **Removal Results** page, click **Close**, and then click **Yes** to restart the server.  
  
##  <a name="BKMK_CMD"></a> Forcing the removal of a domain controller by using the command line  
 Use the following procedure to forcefully remove a domain controller by using the command line. You must use the command line or an answer file if the domain controller is running the Server Core installation option of the Windows Server 2008 operating system. When you forcefully remove the domain controller by using the command line, you must specify the **\/demotefsmo:yes** parameter even if the domain controller does not host any operations master roles.  
  
 If you are removing AD DS permanently, uninstall the AD DS server role binaries from the server. To remove the AD DS server role binaries, use the **dcpromo \/uninstallbinaries** command.  
  
 **Administrative credentials**  
  
 To forcefully remove a domain controller, you must be a member of the Domain Admins group.  
  
#### To force the removal of a domain controller by using the command line  
  
-   At an elevated command prompt, type the following command, and then press ENTER:  
  
     `dcpromo /unattend /uninstallbinaries /forceremoval /demotefsmo:yes /username:<domain admin> /userdomain:<domain> /password:<DA password> /administratorpassword:<local admin password>`  
  
     Where:  
  
    -   `<domain admin>` is the name of an account that is a member of the Domain Admins group.  
  
    -   `<domain>` is the name of the domain for the domain controller.  
  
    -   `<DA password>` is the password for the account that is a member of the Domain Admins group.  
  
    -   `<local admin password>` is the password that will be used for the local administrator account on the server after AD DS is removed.  
  
     The following example forcefully removes a domain controller from a domain named contoso.com, removes the AD DS server role binaries, and sets the local administrator password to p@$$w0rd:  
  
     `dcpromo /unattend /uninstallbinaries /forceremoval /demotefsmo:yes /username:DA1 /userdomain: contoso.com /password: DA1_password /administratorpassword: p@$$w0rd`  
  
##  <a name="BKMK_ANSW"></a> Forcing the removal of a domain controller by using an answer file  
 You can automate the forced removal of a domain controller by using an answer file. You must first prepare an answer file that contains the correct configuration values.  
  
 **Administrative credentials**  
  
 To perform this procedure, you can use any account that has Read and Write credentials for the text editor application.  
  
#### To create an answer file for forcing the removal of a domain controller  
  
1.  Open Notepad or any text editor.  
  
2.  On the first line, type **\[DCINSTALL\]**, and then press ENTER.  
  
3.  Create the following entries, one entry on each line. These options are the minimum options that are required for forced removal of a domain controller. For a complete list of unattended demotion options, including default values, allowed values, and descriptions, see [Demotion Operation](../Topic/Demotion-Operation.md).  
  
     UserDomain\=*domain*  
  
     UserName\=*domain admin*  
  
     password\=*DA password*  
  
     AdministratorPassword\=*local admin password*  
  
     demotefsmo\=yes  
  
4.  Save the answer file to the location on the domain controller from which it is to be called by Dcpromo, or save the file to a network shared folder or removable media for distribution.  
  
 **Administrative credentials**  
  
 To forcefully remove a domain controller, you must be a member of the Domain Admins group.  
  
#### To force the removal of a domain controller by using an answer file  
  
-   At an elevated command prompt, type the following command, and then press ENTER:  
  
     `dcpromo /unattend:"<path to the answer file>"`  
  
  