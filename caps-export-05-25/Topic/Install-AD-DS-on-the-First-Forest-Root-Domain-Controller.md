---
title: Install AD DS on the First Forest Root Domain Controller
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 08884957-8c7b-4bf7-80b7-e0890ed33597
author: Femila
---
# Install AD DS on the First Forest Root Domain Controller
The Windows interface in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] provides two wizards that guide you through the Active Directory Domain Services \(AD DS\) installation process. One wizard is the Add Roles Wizard, which you can access in Server Manager. The other wizard is the Active Directory Domain Services Installation Wizard \(Dcpromo.exe\), which you can access in either of the following ways:  
  
-   When you complete the Add Roles Wizard, click the link to launch the Active Directory Domain Services Installation Wizard.  
  
-   Click **Start**, click **Run**, type **dcpromo.exe**, and then click **OK**.  
  
Membership in the local Administrator account is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
Depending on the operating system installation options that you selected for the computer, the local Administrator password might be blank or it might not be required. In this case, run the following command at a command prompt before you start to install AD DS:  
  
**net user Administrator** *<password>***\/passwordreq:yes**  
  
Replace *<password>* with a strong password.  
  
### To install AD DS by using the Windows interface  
  
1.  Click **Start**, and then click **Server Manager**.  
  
2.  In **Roles Summary**, click **Add Roles**.  
  
3.  If necessary, review the information on the **Before You Begin** page, and then click **Next**.  
  
4.  On the **Select Server Roles** page, click the **Active Directory Domain Services** check box, and then click **Next**.  
  
5.  Review the information on the **Active Directory Domain Services** page, and then click **Next**.  
  
6.  On the **Confirm Installation Selections** page, click **Install**.  
  
7.  On the **Installation Results** page, click **Close this wizard and launch the Active Directory Domain Services Installation Wizard \(dcpromo.exe\)**.  
  
8.  On the **Welcome to the Active Directory Domain Services Installation Wizard** page, click **Next**.  
  
9. On the **Choose a Deployment Configuration** page, click **Create a new domain in a new forest**, and then click **Next**.  
  
10. On the **Name the Forest Root Domain** page, type the full Domain Name System \(DNS\) name for the forest root domain, and then click **Next**.  
  
11. On the **Set Forest Functional Level** page, select the forest functional level that accommodates the domain controllers that you plan to install anywhere in the forest, and then click **Next**.  
  
    If you select any forest functional level other than [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], the **Set Domain Functional Level** page appears next.  
  
12. On the **Set Domain Functional Level** page, select the domain functional level that accommodates the domain controllers that you plan to install anywhere in the domain, and then click **Next**.  
  
    If you select [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] as the forest functional level, the wizard automatically sets the domain functional level to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and **Additional Domain Controller Options** page will appear next.  
  
13. On the **Additional Domain Controller Options** page, **DNS server** is selected by default so that AD DS can create your forest DNS infrastructure when you install AD DS. If you plan to use Active Directory–integrated DNS, click **Next**. If you have an existing DNS infrastructure and you do not want this domain controller to be a DNS server, clear the **DNS server** check box, and then click **Next**.  
  
    If you have an existing DNS infrastructure and you decide to install the DNS Server service on this domain controller, the wizard may not be able to create a delegation for the DNS server. In that case, the wizard displays a message to indicate that you have to create the delegation manually. To continue, click **Yes**.  
  
    > [!IMPORTANT]  
    > We recommend that you install DNS when you run the Active Directory Domain Services Installation Wizard. If you do this, the wizard creates the DNS zone delegation automatically.  
  
    > [!IMPORTANT]  
    > Whether or not the DNS Server service is AD DS\-integrated, you must install it on the first domain controller in the AD DS forest root domain that you deploy.  
  
14. On the **Location for Database, Log Files, and SYSVOL** page, type or browse to the volume and folder locations for the database file, the directory service log files, and the system volume \(SYSVOL\) files, and then click **Next**.  
  
    Windows Server Backup backs up the directory service by volume. For backup and recovery efficiency, store these files on separate volumes that do not contain applications or other files that are not directory files.  
  
15. On the **Directory Services Restore Mode Administrator Password** page, type and confirm the restore mode password, and then click **Next**.  
  
    You must use this password to start AD DS in Directory Service Restore Mode for tasks that must be performed offline.  
  
16. On the **Summary** page, review your selections.  
  
    Click **Back** to change any selections, if necessary.  
  
    To save the selected settings to an answer file that you can use to automate subsequent AD DS operations, click **Export settings**. Type the name for your answer file, and then click **Save**.  
  
17. When you are sure that your selections are accurate, click **Next** to install AD DS.  
  
18. When you are prompted to restart the server, you can either select the **Reboot on completion** check box to restart the server automatically or you can restart the server manually to complete the AD DS installation.  
  
For more information about other ways to install a new [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] forest, see Installing a New [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] Forest \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=101704](http://go.microsoft.com/fwlink/?LinkId=101704)\).  
  
