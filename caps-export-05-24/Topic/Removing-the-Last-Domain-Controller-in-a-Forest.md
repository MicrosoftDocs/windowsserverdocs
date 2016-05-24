---
title: Removing the Last Domain Controller in a Forest
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 89867141-97c1-4641-83dd-3ae4c94447fe
author: Femila
---
# Removing the Last Domain Controller in a Forest
  The procedures in this section describe the following methods that you can use to remove the last domain controller in an Active Directory Domain Services \(AD DS\) forest. These procedures apply to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]:  
  
-   [Removing the last domain controller in a forest by using the Windows interface](#BKMK_remove_domain_interface)  
  
-   [Removing the last domain controller in a forest by using an answer file](#BKMK_remove_domain_answer)  
  
-   [Removing the last domain controller in a forest by entering unattended installation parameters at the command line](#BKMK_remove_domain_unattended)  
  
##  <a name="BKMK_remove_domain_interface"></a> Removing the last domain controller in a forest by using the Windows interface  
 Use the following procedure to remove the forest. If the domain controller hosts any Active Directory–integrated DNS zones, the wizard removes those zones. By default, it also attempts to remove the DNS delegations for those zones that point to the domain controller.  
  
 **Administrative credentials**  
  
 To complete this procedure, you must be a member of the Domain Admins group in the forest root domain or the Enterprise Admins group in the forest.  
  
#### To remove the last domain controller in a forest by using the Windows interface  
  
1.  Click **Start**, click **Run**, type **dcpromo**, and then press ENTER.  
  
2.  On the **Welcome to the Active Directory Domain Services Installation Wizard** page, click **Next**.  
  
3.  On the **Delete the Domain** page, select the option to delete the domain and forest. Before you continue, read the instructions for managing the removal of cryptographic keys and the decryption of Encrypting File System \(EFS\)–encrypted files, and perform these actions, if necessary. When you are sure that you have completed all security tasks, click **Next**.  
  
4.  If the domain controller has application directory partitions, on the **Application Directory Partitions** page, view the application directory partitions in the list, and then remove or retain application directory partitions, as follows:  
  
    -   If you do not want to retain any application directory partitions that are stored on the domain controller, click **Next**.  
  
    -   If you want to retain any application directory partition that an application has created on the domain controller, use the application that created the partition to remove it, and then click **Update List** to update the list.  
  
5.  On the **Confirm Deletion** page, select the option to delete all application directory partitions on the domain controller, and then click **Next**.  
  
6.  On the **Remove DNS Delegation** page, verify that the **Delete the DNS delegations pointing to this server** check box is selected, and then click **Next**.  
  
7.  If necessary, enter administrative credentials for the server that hosts the DNS zones that contain the DNS delegation for this server, and then click **OK**.  
  
8.  On the **Administrator Password** page, type and confirm a secure password for the local Administrator account, and then click **Next**.  
  
9. On the **Summary** page, review your selections, and then click **Next** to remove AD DS.  
  
10. When you are prompted, restart the server to complete the removal of AD DS.  
  
11. [!INCLUDE[rmt_proc](../Token/rmt_proc_md.md)]  
  
12. In **Roles Summary**, click **Remove Roles**.  
  
13. If necessary, review the information on the **Before You Begin** page and then click **Next**.  
  
14. On the **Remove Server Roles** page, clear the **Active Directory Domain Services** check box, and then click **Next**.  
  
15. On the **Confirm Removal Selections** page, click **Remove**.  
  
16. On the  **Removal Results** page, click **Close**, and then click **Yes** to restart the server.  
  
##  <a name="BKMK_remove_domain_answer"></a> Removing the last domain controller in a forest by using an answer file  
 To remove the last domain controller in a forest requires only Enterprise Admin credentials. You can also create the password for the local Administrator account for the member server. If you do not specify the password in the answer file, the administrator password is blank.  
  
 If you are removing AD DS permanently, uninstall the AD DS server role binaries from the server. To remove the AD DS server role binaries, use the **dcpromo \/uninstallbinaries** command.  
  
 **Administrative credentials**  
  
 To perform this procedure, you can use any account that has Read and Write credentials for the text editor application.  
  
#### To create an answer file for removing the last domain controller in a forest  
  
1.  Open Notepad or any text editor.  
  
2.  On the first line, type \[DCINSTALL\], and then press ENTER.  
  
3.  Create the following entries, one entry on each line. For a complete list of parameters for removing AD DS, see [Demotion Operation](http://go.microsoft.com/fwlink/?LinkID=120996) or type **dcpromo \/?:Demotion** at a command line.  
  
     username\=\<administrative account in the domain\>  
  
     userdomain\=\<domain name of the administrative account\>  
  
     password\=\<password for the account in UserName\>  
  
     administratorpassword\=\<local administrator password for the server\>  
  
     IsLastDCInDomain\=yes  
  
     removeapplicationpartitions\=yes  
  
     removeDNSDelegation\=yes  
  
     DNSDelegationUserName\=\<DNS server administrative account for the DNS zone that contains the DNS delegation\>  
  
     DNSDelegationPassword\=\<Password for the DNS server administrative account\>  
  
4.  Save the answer file to the location on the installation server from which it is to be called by **dcpromo**, or save the file to a network shared folder or removable media for distribution.  
  
 **Administrative credentials**  
  
 To remove a domain controller, you must be a member of the Domain Admins group.  
  
#### To remove the last domain controller in a forest by using an answer file  
  
-   At an elevated command prompt, type the following command, and then press ENTER:  
  
     `dcpromo /uninstallbinaries /unattend:"<path to the answer file>"`  
  
##  <a name="BKMK_remove_domain_unattended"></a> Removing the last domain controller in a forest by entering unattended installation parameters at the command line  
 Use the following procedure to perform an unattended removal \(demotion\) of the last domain controller in a forest from the command line. For a complete list of unattended demotion options, including default values, allowed values, and descriptions, type **dcpromo \/?:Demotion** at a command prompt, or see [Demotion Operation](../Topic/Demotion-Operation.md).  
  
 **Administrative credentials**  
  
 To perform this procedure, you must be a member of the Enterprise Admins group.  
  
#### To remove the last domain controller in a forest by entering unattended demotion parameters at the command line  
  
1.  At a command prompt, type the following command, and then press ENTER:  
  
     `dcpromo /unattend /<unattendOption>:<value> /<unattendOption>:<value> ...`  
  
     Where:  
  
    -   `<unattendOption>` is an option in the [Promotion Operation](../Topic/Promotion-Operation.md) table. Separate each `<option:value>` pair with a space.  
  
    -   `<value>` is the configuration instruction for the option.  
  
     The following example removes the last domain controller in a forest and uninstalls the AD DS server role binaries:  
  
     `dcpromo /unattend /demotefsmo:yes /islastdcindomain:yes /username:<EnterpriseAdmin> userdomain:<contoso.com>/password:<Tq&09H,Ly>/AdministratorPassword:<FH#3573.cK> /rebootOnCompletion:yes /uninstallbinaries`  
  
2.  When you have typed all the options that are required to remove the last domain controller in the domain, press ENTER.  
  
  