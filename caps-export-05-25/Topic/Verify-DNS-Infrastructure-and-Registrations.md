---
title: Verify DNS Infrastructure and Registrations
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 58238774-96db-40c8-b9cd-91427d050c6e
author: Femila
---
# Verify DNS Infrastructure and Registrations
  You can use this procedure to verify that the existing Domain Name System \(DNS\) infrastructure is sufficient for installing Active Directory Domain Services \(AD DS\) on the installation computer in the specified domain. This test reports whether any modifications to the existing DNS infrastructure are required so that the server can dynamically register DNS records that are required for the location of the domain controller by other devices on the network. Although the Active Directory Domain Services Installation Wizard presents a warning message during Active Directory installation if it encounters DNS registration errors, failure of this test does not prevent you from running the wizard. However, failed DNS registrations will prevent the domain controller from functioning properly on the network. Therefore, resolve any problems that this test reports before you install AD DS.  
  
 Because all Dcdiag tests include a connectivity test, this procedure also tests TCP\/IP connectivity.  
  
 To complete this procedure, you must have Dcdiag.exe installed on the server. During the initial part of the installation of AD DS, you use Server Manager to add the Active Directory Domain Services server role. This part of the installation procedure installs the Dcdiag.exe command line tool. The second part of the installation process, running Dcpromo.exe, actually installs AD DS. Perform the Dcdiag test procedure after you add the Active Directory Domain Services server role but before you run Dcpromo.exe.  
  
> [!NOTE]  
>  If you do not want to install the Active Directory Domain Services server role at this time, you can install the Active Directory Domain Services Administration Tools, which include Dcdiag.exe, by using **Add Features** in Server Manager. For information about using **Add Features** to install the Active Directory Domain Services Administration Tools, see [Installing Remote Server Administration Tools for AD DS](../Topic/Installing-Remote-Server-Administration-Tools-for-AD-DS.md).  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To verify the DNS infrastructure and registrations  
  
1.  If you do not want to install AD DS at this time but you want to perform DNS verification tests, install the Active Directory Domain Services Administrative Tools, as described in [Installing Remote Server Administration Tools for AD DS](../Topic/Installing-Remote-Server-Administration-Tools-for-AD-DS.md), and then go to step 9.  
  
2.  If you want to install Dcdiag.exe during the installation of AD DS and run the DNS test before you run Dcpromo.exe, click **Start**, and then click **Server Manager**.  
  
3.  In **Roles Summary**, click **Add Roles**.  
  
4.  Review the information on the **Before You Begin** page, and then click **Next**.  
  
5.  On the **Select Server Roles** page, click **Active Directory Domain Services**, and then click **Next**.  
  
6.  Review the information on the **Active Directory Domain Services** page, and then click **Next**.  
  
7.  On the **Confirm Installation Selections** page, click **Install**.  
  
8.  On the **Installation Results** page, do not click **Close this wizard and launch the Active Directory Domain Services Installation Wizard \(dcpromo.exe\)**. First, perform steps 9 and 10. When you have completed the Dcpromo test successfully, return to the **Installation Results** page and continue with the installation of the Active Directory Domain Services server role.  
  
9. Open a Command Prompt window as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, provide Domain Admins credentials, if required, and then click **Continue**.  
  
10. At the command prompt, type the following command, and then press ENTER:  
  
     `dcdiag /test:dcpromo /DnsDomain:<DNSDomainName> /ReplicaDC`  
  
     where `<DNSDomainName>` is the DNS name of the domain, in the form `<DomainName.ForestName>`, in which you want to add a domain controller.  
  
11. If the server does not pass the Dcpromo test, fix the reported problems before you continue with the installation of AD DS.  
  
  