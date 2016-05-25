---
title: Installing a Domain Controller in an Existing Domain
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 098de65c-f0b1-4e55-a40b-a54c3ce9d711
author: Femila
---
# Installing a Domain Controller in an Existing Domain
  This section describes methods for installing Active Directory Domain Services \(AD DS\) onto a [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] server that will become a domain controller in an existing Active Directory domain. The procedures in this section provide instructions for installing AD DS by using replication to create the new domain controller or by using installation media. By using the installation from media \(IFM\) method, you can avoid replicating AD DS over the network.  
  
> [!NOTE]  
>  This section describes methods for installing writable domain controllers. For information about installing read\-only domain controllers \(RODCs\), see the Step\-by\-Step Guide for Read\-only Domain Controllers \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=92728](http://go.microsoft.com/fwlink/?LinkId=92728)\) and Planning and Deploying Read\-Only Domain Controllers \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=120840](http://go.microsoft.com/fwlink/?LinkId=120840)\).  
  
 The following methods use replication to create the new domain controller:  
  
-   Active Directory Domain Services Installation Wizard \(Dcpromo.exe\), by specifying a source domain controller or allowing the replication system to select a replication partner.  
  
-   Unattended installation, by instructing Dcpromo to use parameters in an answer file to install AD DS. The answer file either specifies a source domain controller or allows the replication system to select a replication partner.  
  
-   Command\-line installation, by using unattend parameters that either specify a source domain controller or allow the replication system to select a replication partner.  
  
 The following methods use installation media as the source for Active Directory installation, which avoids replication of AD DS:  
  
-   Active Directory Domain Services Installation Wizard \(Dcpromo.exe\), by using advanced options and specifying the location of installation media \(the IFM method\).  
  
-   Unattended installation, by instructing Dcpromo to use parameters in an answer file to install AD DS. The answer file specifies the location of installation media.  
  
-   Command\-line installation, by using unattend parameters to specify the location of installation media.  
  
 Before you perform the installation procedures, prepare the server for installation according to the instructions in [Preparing for Active Directory Installation](../Topic/Preparing-for-Active-Directory-Installation.md). To ensure successful installation of a new domain controller, verify that all critical services that AD DS depends on are configured according to Requirements for Installing AD DS \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=120603](http://go.microsoft.com/fwlink/?LinkId=120603)\).  
  
 If you are installing the first [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] domain controller in an existing Windows Server 2000 or Windows Server 2003 domain, see the domain and forest preparation information in Installing an Additional Windows Server 2008 Domain Controller \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=93254](http://go.microsoft.com/fwlink/?LinkID=93254)\).  
  
 For information about best practices for planning, testing, and deploying AD DS, see the AD DS Design Guide \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=116282](http://go.microsoft.com/fwlink/?LinkID=116282)\) and see the AD DS Deployment Guide \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=116283](http://go.microsoft.com/fwlink/?LinkId=116283)\).  
  
 This section includes the following tasks for installing a domain controller in an existing domain:  
  
-   [Installing an Additional Domain Controller by Using the Windows Interface](../Topic/Installing-an-Additional-Domain-Controller-by-Using-the-Windows-Interface.md)  
  
-   [Installing an Additional Domain Controller by Using IFM](../Topic/Installing-an-Additional-Domain-Controller-by-Using-IFM.md)  
  
-   [Installing an Additional Domain Controller by Using Unattend Parameters](../Topic/Installing-an-Additional-Domain-Controller-by-Using-Unattend-Parameters.md)  
  
> [!NOTE]  
>  By default, when a domain controller account is added to the existing Active Directory domain, it is assigned an "Account Ops\-FC" access control entry \(ACE\) that gives members of the Account Operators group full control over this domain controller account, which is not a recommended configuration. For example, members of Account Operators group will be able to reset this domain controller’s password. Because the Account Operators group has significant power in the domain, we recommend that you add members to it with caution. For a detailed description of the Account Operators group, see Default groups \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=131422](http://go.microsoft.com/fwlink/?LinkID=131422)\). To modify permissions for Account Operators on a computer account, you can use the Active Directory Users and Computers snap\-in and complete the following steps:  
>   
>  1.  To open Active Directory Users and Computers, click **Start**, click **Administrative Tools**, and then click **Active Directory Users and Computers**.  
> 2.  In the console tree, right\-click the affected domain controller account and then click **Properties**.  
> 3.  On the **Security** tab, select **Account Operators** in the **Group or user names** list, and then modify permissions according to the specifications of your environment.  
  
## See Also  
 [Preparing for Active Directory Installation](../Topic/Preparing-for-Active-Directory-Installation.md)  
  
  