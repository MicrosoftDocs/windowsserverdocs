---
title: Removing the Last Domain Controller in a Domain
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 899ca439-1742-4522-b994-fbcc403926a2
author: Femila
---
# Removing the Last Domain Controller in a Domain
  The procedures in this section describe the following methods for removing the last domain controller in the domain. The domain can be a child domain or a domain tree. These procedures apply to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]:  
  
-   [Removing the last domain controller in a domain by using the Windows interface](#BKMK_remove_domain_interface)  
  
-   [Removing the last domain controller in a domain by using an answer file](#BKMK_remove_domain_answer)  
  
-   [Removing the last domain controller in a domain by entering unattended demotion parameters at the command line](#BKMK_remove_domain_unattended)  
  
##  <a name="BKMK_remove_domain_interface"></a> Removing the last domain controller in a domain by using the Windows interface  
 The Active Directory Domain Services Installation Wizard provides all the steps that you need to remove the domain. During domain removal, the Active Directory Domain Services Installation Wizard displays a list of all the application directory partitions that are stored on the domain controller. If the application directory partitions were created by an application other than Active Directory Domain Services \(AD DS\), first try to use an appropriate tool that is provided by the application to remove these directory partitions. If the application does not provide such a tool, you can let the Active Directory Domain Services Installation Wizard remove the directory partitions.  
  
 Application directory partitions that are created by AD DS, such as the DomainDNSZones application directory partition, cannot be retained if you remove AD DS.  
  
 If the domain controller hosts any Active Directory–integrated DNS zones, the wizard removes those zones. By default, the wizard also attempts to remove the Domain Name System \(DNS\) delegations for those zones that point to the domain controller.  
  
 **Administrative credentials**  
  
 To complete this procedure, you must be a member of the Enterprise Admins group in the forest.  
  
#### To remove the last domain controller in a domain by using the Windows interface  
  
1.  Click **Start**, click **Run**, type **dcpromo**, and then press ENTER.  
  
2.  On the **Welcome to the Active Directory Domain Services Installation Wizard** page, click **Next**.  
  
3.  On the **Delete the Domain** page, select the option to delete the domain. Before you continue, read the instructions for managing the removal of cryptographic keys and the decryption of Encrypting File System \(EFS\)–encrypted files, and perform these actions, if necessary. When you are sure that you have completed all security tasks, click **Next**.  
  
4.  If the domain controller has application directory partitions, on the **Application Directory Partitions** page, view the application directory partitions in the list and remove or retain application directory partitions, as follows:  
  
    -   If you do not want to retain any application directory partitions that are stored on the domain controller, click **Next**.  
  
    -   If you want to retain any application directory partition that an application has created on the domain controller, use the application that created the partition to remove it to another domain controller, and then click **Update List** to update the list.  
  
5.  On the **Confirm Deletion** page, select the option to delete all application directory partitions on the domain controller, and then click **Next**.  
  
6.  On the **Remove DNS Delegation** page, verify that the **Delete the DNS delegations pointing to this server** check box is selected, and then click **Next**.  
  
7.  If necessary, enter administrative credentials for the server that hosts the DNS zones that contain the DNS delegation for this server, and then click **OK**.  
  
8.  On the **Network Credentials** page:  
  
    -   If you are currently logged on as a member of the Enterprise Admins, click **Next**.  
  
    -   If you are logged on with a different account, click **Alternate credentials**, click **Set**, type the name and password of an account that is a member of the Enterprise Admins group, and then click **Next**.  
  
9. On the **Administrator Password** page, type and confirm a secure password for the local Administrator account, and then click **Next**.  
  
10. On the **Summary** page, to save the settings that you selected to an answer file that you can use to automate subsequent operations in AD DS, click **Export settings**. Type a name for your answer file, and then click **Save**. Review your selections, and then click **Next** to remove AD DS.  
  
11. On the **Completing the Active Directory Domain Services Installation Wizard** page, click **Finish**.  
  
12. You can either select the **Reboot on completion** check box to have the server restart automatically or you can restart the server to complete the removal of AD DS when you are prompted to do so.  
  
13. [!INCLUDE[rmt_proc](../Token/rmt_proc_md.md)]  
  
14. In **Roles Summary**, click **Remove Roles**.  
  
15. If necessary, review the information on the **Before You Begin** page, and then click **Next**.  
  
16. On the **Remove Server Roles** page, clear the **Active Directory Domain Services** check box, and then click **Next**.  
  
17. On the **Confirm Removal Selections** page, click **Remove**.  
  
18. On the  **Removal Results** page, click **Close**, and then click **Yes** to restart the server.  
  
 For information about cryptographic keys and certificate management, see the Windows Server 2003 PKI Operations Guide \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=68752](http://go.microsoft.com/fwlink/?LinkId=68752)\). For information about EFS, see the Encrypting File System Technical Reference \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=68751](http://go.microsoft.com/fwlink/?LinkId=68751)\).  
  
##  <a name="BKMK_remove_domain_answer"></a> Removing the last domain controller in a domain by using an answer file  
 The answer file that specifies that you are removing the last domain controller in the domain must include that instruction, and it must specify the parent domain.  
  
 **Administrative credentials**  
  
 To complete this procedure, you must be a member of the Domain Admins group in the parent domain or a member of the Enterprise Admins group in the forest.  
  
#### To create an answer file for removing the last domain controller in a domain  
  
1.  On the first line, type \[DCINSTALL\], and then press ENTER.  
  
2.  Create the following entries, one entry on each line. For a complete list of parameters for removing AD DS, see [Demotion Operation](../Topic/Demotion-Operation.md) or type **dcpromo \/?:Demotion** at a command line.  
  
     UserName\=\<administrative account in parent domain\>  
  
     UserDomain\=\<domain name of the account in UserName\>  
  
     Password\=\<password for the account in UserName or type \* to have the user be prompted to provide a password\>  
  
     IsLastDCInDomain\=yes  
  
     DemoteFSMO\=yes  
  
     AdministratorPassword\=\<local administrator password for the server\>  
  
     RemoveApplicationPartitions\=\<yes if you want to remove the partitions. If you want to retain them, do not use this entry.\>  
  
     RemoveDNSDelegation\=yes  
  
     DNSDelegationUserName\=\<DNS server administrative account for the DNS zone that contains the DNS delegation\>  
  
     DNSDelegationPassword\=\<Password for the DNS server administrative account\>  
  
3.  Save the answer file to the location on the installation server from which it is to be called by Dcpromo, or save the file to a network share or removable media for distribution.  
  
4.  The Dcpromo command to use an answer file is the same for both removing and installing a domain controller. Use the procedure "To install a new domain controller by using an answer file" to remove the domain controller.  
  
##  <a name="BKMK_remove_domain_unattended"></a> Removing the last domain controller in a domain by entering unattended demotion parameters at the command line  
 Use the following procedure to perform an unattended removal \(demotion\) of the last domain controller in a domain from the command line. For a complete list of unattended demotion options, including default values, allowed values, and descriptions, type **dcpromo \/?:Demotion** at a command prompt, or see [Demotion Operation](../Topic/Demotion-Operation.md).  
  
 If you are removing AD DS permanently, uninstall the AD DS server role binaries from the server. To remove the AD DS server role binaries, use the **dcpromo \/uninstallbinaries** command.  
  
 **Administrative credentials**  
  
 To perform this procedure, you must be a member of the Enterprise Admins group.  
  
#### To remove the last domain controller in a domain by entering unattended demotion parameters at the command line  
  
1.  At a command prompt, type the following command, and then press ENTER:  
  
     `dcpromo /unattend /uninstallbinaries /<unattendOption>:<value> /<unattendOption>:<value> ...`  
  
     Where:  
  
    -   `<unattendOption>` is an option in the [Promotion Operation](../Topic/Promotion-Operation.md) table. Separate each `option:value` pair with a space.  
  
    -   `value` is the configuration instruction for the option.  
  
     The following example removes the last domain controller in a domain named contoso.com and uninstalls the AD DS server role binaries:  
  
     `dcpromo /unattend /uninstallbinaries /demotefsmo:yes /islastdcindomain:yes /username:EnterpriseAdmin userdomain:contoso.com/password:Tq&09H,Ly/AdministratorPassword:FH#3573.cK /rebootOnCompletion:yes /uninstallbinaries`  
  
2.  When you have typed all the options that are required to remove the last domain controller in the domain, press ENTER.  
  
  