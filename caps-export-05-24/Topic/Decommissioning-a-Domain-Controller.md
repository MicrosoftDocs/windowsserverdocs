---
title: Decommissioning a Domain Controller
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 1f934c60-cde1-4b91-9c7d-4b8d40896837
author: Femila
---
# Decommissioning a Domain Controller
  Decommissioning a domain controller removes all Active Directory components and related components and returns the domain controller to a member server role.  
  
 This task provides procedures for removing a domain controller from a domain that has other domain controllers.  
  
## Removing a domain or a forest  
 The following topics contain information about removing a domain or a forest:  
  
-   To remove a domain, see Removing the Last Windows Server 2008 Domain Controller in a Domain \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=93208](http://go.microsoft.com/fwlink/?LinkId=93208)\).  
  
-   To remove a forest, see Removing the Last Windows Server 2008 Domain Controller in a Forest \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=93209](http://go.microsoft.com/fwlink/?LinkId=93209)\).  
  
## Protecting EFS\-encrypted files  
 If the domain controller to be decommissioned hosts any Encrypting File System \(EFS\)–encrypted files, you must take precautions to protect the private key for the recovery agent for the local EFS\-encrypted documents. This might be lost during Active Directory removal when the Security Accounts Manager \(SAM\) is recreated on the computer. In this case, you are unable to recover encrypted documents on this computer unless you unencrypt all the files and the recovery agent is changed to an existing domain account before re\-encryption. To prevent loss of the private key, you must back up \(export\) the recovery agent private key before you decommission the domain controller. After you remove Active Directory Domain Services \(AD DS\), import the private key again.  
  
 You must be able to ensure that the domain account that is serving as the recovery agent for the certificate remains the same after you remove AD DS. If you cannot guarantee that the account will remain the same after the domain controller is decommissioned or if you removed AD DS without backing up the certificate and you cannot recover EFS\-encrypted files, see article 276239 in the Microsoft Knowledge Base \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=117370](http://go.microsoft.com/fwlink/?LinkID=117370)\).  
  
 **Task requirements**  
  
 The following tools are required to perform the procedures for this task:  
  
-   Dcdiag.exe  
  
-   Active Directory Schema  
  
-   Active Directory Domains and Trusts  
  
-   Active Directory Users and Computers  
  
-   Active Directory Sites and Services  
  
-   Ntdsutil.exe  
  
 If you must protect the recovery agent private key for encrypted files, the following additional tool is required:  
  
-   Certificates snap\-in  
  
 To complete this task, perform the following procedures:  
  
1.  [Verify DNS Registration and TCP - IP Connectivity](../Topic/Verify-DNS-Registration-and-TCP---IP-Connectivity.md)  
  
     The Active Directory Domain Services Installation Wizard requires both TCP\/IP connectivity and Domain Name System \(DNS\) to locate another domain controller in the domain.  
  
     During the removal of AD DS, contact with other domain controllers is required to ensure the following:  
  
    -   Any unreplicated changes are replicated to another domain controller.  
  
    -   Removal of the domain controller from the directory.  
  
    -   Transfer of any remaining operations master roles.  
  
     If the domain controller cannot contact another domain controller during Active Directory removal, the decommissioning operation fails. As with the installation process, test the communication infrastructure before you run the installation wizard. Before you remove AD DS, use the same connectivity tests that you used before you installed AD DS.  
  
2.  [View the Current Operations Master Role Holders](../Topic/View-the-Current-Operations-Master-Role-Holders.md)  
  
     To avoid problems for client computers in the domain and forest, transfer any operations master \(also known as flexible single master operations or FSMO\) roles before you run the Active Directory Domain Services Installation Wizard to decommission a domain controller so that you can control the operations master role placement. If you need to transfer any operations master roles from a domain controller, review all the recommendations for role placement before you perform the transfer, as described in [Introduction to Administering Operations Master Roles](../Topic/Introduction-to-Administering-Operations-Master-Roles.md). Identify the domain controllers to which you will transfer each role before you perform the transfer procedures.  
  
    > [!CAUTION]  
    >  During the decommissioning process, the Active Directory Domain Services Installation Wizard checks for the presence of operations master roles. If the domain controller being decommissioned holds any operations master \(also known as flexible single master operations or FSMO\) role, the wizard provides a warning and attempts to transfer the role or roles to another domain controller without any user interaction. You do not have control over which domain controller receives the operations master roles that are transferred, and the wizard does not indicate which domain controller receives them. If the wizard cannot transfer an operations master role, you can override the warnings and the wizard will continue to uninstall AD DS and leave your domain or forest without the role. In this case, you must seize the operations master role to another domain controller.  
  
     If the domain controller holds any operations master roles, use the following procedures to transfer the role or roles:  
  
    -   [Transfer the Schema Master](../Topic/Transfer-the-Schema-Master.md)  
  
    -   [Transfer the Domain Naming Master](../Topic/Transfer-the-Domain-Naming-Master.md)  
  
    -   [Transfer the Domain-Level Operations Master Roles](../Topic/Transfer-the-Domain-Level-Operations-Master-Roles.md)  
  
3.  [Determine Whether a Domain Controller Is a Global Catalog Server](../Topic/Determine-Whether-a-Domain-Controller-Is-a-Global-Catalog-Server.md)  
  
     If you remove AD DS from a domain controller that hosts the global catalog, the Active Directory Domain Services Installation Wizard confirms that you want to continue with removing AD DS. This confirmation ensures that you are aware that you are removing a global catalog server from your environment. Do not remove the last global catalog server from your environment because users cannot log on without an available global catalog server. If you are not sure, do not proceed with removing AD DS until you know that at least one other global catalog server is available.  
  
4.  [Verify the Availability of the Operations Masters](../Topic/Verify-the-Availability-of-the-Operations-Masters.md)  
  
     Verify that the operations master role holders are online and responding.  
  
    > [!IMPORTANT]  
    >  If any verification test fails, do not continue until you determine the problems and fixthem. If these tests fail, the uninstallation is also likely to fail.  
  
5.  If the domain controller hosts encrypted documents, perform the following procedure before you remove AD DS to ensure that the encrypted files can be recovered after AD DS is removed:  
  
     Back Up A Certificate With Its Private Key \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=122856](http://go.microsoft.com/fwlink/?LinkId=122856)\).  
  
6.  [Removing a Domain Controller from a Domain](../Topic/Removing-a-Domain-Controller-from-a-Domain.md)  
  
     You can remove AD DS by using the Windows interface, an answer file, or the command line.  
  
7.  If the domain controller hosts encrypted documents and you backed up the certificate and private key before you removed AD DS, perform the following procedure to import the certificate to the server again:  
  
     Import a Certificate \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=108290](http://go.microsoft.com/fwlink/?LinkID=108290)\).  
  
8.  [Determine Whether a Server Object Has Child Objects](../Topic/Determine-Whether-a-Server-Object-Has-Child-Objects.md)  
  
9. [Delete a Server Object from a Site](../Topic/Delete-a-Server-Object-from-a-Site.md)  
  
    > [!NOTE]  
    >  You may not want to remove the server object if it hosts something in addition to AD DS, for example, Microsoft Exchange.  
  
## See Also  
 [Introduction to Administering Operations Master Roles](../Topic/Introduction-to-Administering-Operations-Master-Roles.md)  
  
  