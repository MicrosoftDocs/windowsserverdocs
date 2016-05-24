---
title: Removing a Domain Controller from a Domain
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 8bd44358-bd81-4ea5-9e1e-c959a2608545
author: Femila
---
# Removing a Domain Controller from a Domain
  The procedures in this section describe the methods for removing a Windows Server 2008 or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controller from a domain:  
  
-   [Removing a domain controller by using the Windows interface](#BKMK_remove_domain_interface)  
  
-   [Removing a domain controller by using an answer file](#BKMK_remove_domain_answer)  
  
-   [Removing a domain controller by entering unattended installation parameters at the command line](#BKMK_remove_domain_unattended)  
  
 After AD DS is removed, the DNS server role remains installed and running if it was previously installed on the domain controller. But any Active Directory–integrated DNS zones that were installed are removed. By default, the AD DS removal process also attempts to remove the Domain Name System \(DNS\) delegations for the zones that point to the domain controller.  
  
 If the DNS server no longer serves any purpose after you remove AD DS, use Remove Roles Wizard to remove DNS server role. If you remove the DNS server role, you must reconfigure any DHCP scopes and DNS clients that resolved against this DNS server to use a suitable alternative \(typically, another DNS server running on a domain controller within the same domain\).  
  
##  <a name="BKMK_remove_domain_interface"></a> Removing a domain controller by using the Windows interface  
 You can use the Active Directory Domain Services Installation Wizard to remove a domain controller from an existing domain.  
  
 **Administrative credentials**  
  
 To perform this procedure, you must be a member of the Domain Admins group in the domain.  
  
#### To remove a domain controller by using the Windows interface  
  
1.  Click **Start**, click **Run**, type **dcpromo**, and then press ENTER.  
  
2.  On the **Welcome to the Active Directory Domain Services Installation Wizard** page, click **Next**.  
  
3.  If the domain controller is a global catalog server, a message appears to warn you about the effect of removing a global catalog server from the environment. Click **OK** to continue.  
  
4.  On the **Delete the Domain** page, make no selection, and then click **Next**.  
  
5.  If the domain controller has application directory partitions, on the **Application Directory Partitions** page, view the application directory partitions in the list, and then remove or retain application directory partitions, as follows:  
  
    -   If you do not want to retain any application directory partitions that are stored on the domain controller, click **Next**.  
  
    -   If you want to retain an application directory partition that an application has created on the domain controller, use the application that created the partition to remove it, and then click **Refresh** to update the list.  
  
6.  If the **Confirm Deletion** page appears, select the option to delete all application directory partitions on the domain controller, and then click **Next**.  
  
7.  On the **Remove DNS Delegation** page, verify that the **Delete the DNS delegations pointing to this server** check box is selected, and then click **Next**.  
  
8.  If necessary, enter administrative credentials for the server that hosts the DNS zones that contain the DNS delegation for this server, and then click **OK**.  
  
9. On the **Administrator Password** page, type and confirm a secure password for the local Administrator account, and then click **Next**.  
  
10. On the **Summary** page, to save the settings that you selected to an answer file that you can use to automate subsequent operations in Active Directory Domain Services \(AD DS\), click **Export settings**. Type a name for your answer file, and then click **Save**. Review your selections, and then click **Next** to remove AD DS.  
  
11. On the **Completing the Active Directory Domain Services Installation Wizard** page, click **Finish**.  
  
12. You can either select the **Reboot on completion** check box to have the server restart automatically or you can restart the server to complete the AD DS removal when you are prompted to do so.  
  
13. [!INCLUDE[rmt_proc](../Token/rmt_proc_md.md)]  
  
14. In **Roles Summary**, click **Remove Roles**.  
  
15. If necessary, review the information on the **Before You Begin** page, and then click **Next**.  
  
16. On the **Remove Server Roles** page, clear the **Active Directory Domain Services** check box, and then click **Next**.  
  
17. On the **Confirm Removal Selections** page, click **Remove**.  
  
18. On the  **Removal Results** page, click **Close**, and then click **Yes** to restart the server.  
  
##  <a name="BKMK_remove_domain_answer"></a> Removing a domain controller by using an answer file  
 To remove a domain controller in a domain where other domain controllers exist requires only Domain Admin credentials. You can also create the password for the local Administrator account for the member server. If you do not specify the password in the answer file, the administrator password is blank.  
  
 If you are removing AD DS permanently, uninstall the AD DS server role binaries from the server after you remove AD DS from the domain controller. To remove the AD DS server role binaries, use the **dcpromo \/uninstallbinaries** command.  
  
 **Administrative credentials**  
  
 To perform this procedure, you can use any account that has Read and Write credentials for the text editor application.  
  
#### To create an answer file for removing a domain controller  
  
1.  Open Notepad or any text editor.  
  
2.  On the first line, type \[DCINSTALL\], and then press ENTER.  
  
3.  Create the following entries, one entry on each line. For a complete list of parameters for removing AD DS, see [Demotion Operation](http://go.microsoft.com/fwlink/?LinkID=120996) or type **dcpromo \/?:Demotion** at a command line.  
  
     username\=\<administrative account in the domain\>  
  
     userdomain\=\<domain name of the administrative account\>  
  
     password\=\<password for the account in UserName\>  
  
     administratorpassword\=\<local administrator password for the server\>  
  
     removeapplicationpartitions\=yes  
  
     removeDNSDelegation\=yes  
  
     DNSDelegationUserName\=\<DNS server administrative account for the DNS zone that contains the DNS delegation\>  
  
     DNSDelegationPassword\=\<Password for the DNS server administrative account\>  
  
4.  Save the answer file to the location on the installation server from which it is to be called by **dcpromo**, or save the file to a network shared folder or removable media for distribution.  
  
 **Administrative credentials**  
  
 To remove a domain controller, you must be a member of the Domain Admins group.  
  
#### To remove a domain controller by using an answer file  
  
-   At an elevated command prompt, type the following command, and then press ENTER:  
  
     `dcpromo /unattend:"<path to the answer file>"`  
  
##  <a name="BKMK_remove_domain_unattended"></a> Removing a domain controller by entering unattended installation parameters at the command line  
 You can run **dcpromo \/unattend** command on a domain controller to perform an unattended removal of AD DS. If you are removing AD DS permanently, uninstall the AD DS server role binaries from the server after you remove AD DS from the domain controller. To remove the AD DS server role binaries, use the **dcpromo \/uninstallbinaries** command.  
  
 For a complete list of parameters for removing AD DS, see [Demotion Operation](http://go.microsoft.com/fwlink/?LinkID=120996)or type **dcpromo \/?:Demotion** at a command line.  
  
#### To remove a domain controller by using the command line  
  
-   At an elevated command prompt, type the following command, and then press ENTER:  
  
     `dcpromo /unattend /username:<domain admin> /userdomain:<domain> /password:<DA password> /administratorpassword:<local admin password>`  
  
     Where:  
  
    -   `domain admin` is the name of an account that is a member of the Domain Admins group.  
  
    -   `domain` is the name of the domain for the domain controller.  
  
    -   `DA password` is the password for the account that is a member of the Domain Admins group.  
  
    -   `local admin password` is the password that will be used for the local administrator account on the server after AD DS is removed.  
  
     The following example removes a domain controller from a domain named contoso.com, removes the AD DS server role binaries, and sets the local administrator password to p@$$w0rd:  
  
     `dcpromo /unattend /username:DA1 /userdomain: contoso.com /password: DA1_password /administratorpassword: p@$$w0rd`  
  
  