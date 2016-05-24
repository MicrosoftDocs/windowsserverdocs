---
title: Scenarios for Installing AD DS
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 708da9f7-aaad-4fa1-bccb-76ea8569da50
author: Femila
---
# Scenarios for Installing AD DS
  The following installation scenarios for Active Directory Domain Services \(AD DS\) are described in this guide. In these scenarios, the new domain controllers can be running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and existing domain controllers can be running Windows Server 2003 or Windows 2000 Server.  
  
-   [Install a new forest](#BKMK_NewForestScenario)  
  
-   [Install a new domain in an existing forest](#BKMK_NewDomainScenario)  
  
-   [Install a new domain controller in an existing domain](#BKMK_NewDCScenario)  
  
-   [Perform a staged RODC installation](#BKMK_performing_RODC)  
  
-   [Install AD DS from media](#BKMK_IFMScenario)  
  
-   [Verify AD DS installations](#BKMK_VerifyScenario)  
  
##  <a name="BKMK_NewForestScenario"></a> Install a new forest  
 When you install AD DS to create the first domain controller in a new  forest, keep the following considerations in mind:  
  
-   You must make forest and domain functional level decisions that determine whether your forest and domain can contain domain controllers that run Microsoft Windows® 2000 Server, Windows Server 2003, [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
-   Domain controllers running the Microsoft Windows NT® Server 4.0 operating system are not supported with [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
-   Servers running Windows NT Server 4.0 are not supported by domain controllers that are running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
-   The first domain controller in a forest must be a global catalog server and it cannot be an RODC.  
  
##  <a name="BKMK_NewDomainScenario"></a> Install a new domain in an existing forest  
 When you install AD DS to create the first domain controller in a new domain, keep the following considerations in mind:  
  
-   Before you create a new [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain in a Windows 2000 Server or Windows Server 2003 forest, you must prepare the forest for [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] by extending the schema \(that is, by running **adprep \/forestprep**\).  
  
    > [!NOTE]  
    >  In [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], Adprep.exe is available in the \/sources\/adprep folder of the installation DVD. In [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], Adprep.exe is located in the \/support\/adprep folder.  
  
-   You must make domain functional level decisions that determine whether your domain can contain domain controllers that run Windows 2000 Server, Windows Server 2003, [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].  
  
 We recommend that you host the primary domain controller \(PDC\) emulator operations master role in the forest root domain on a domain controller that runs [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].  
  
 For procedures to install a new domain, see [Installing a New Child Domain](../Topic/Installing-a-New-Child-Domain.md).  
  
##  <a name="BKMK_NewDCScenario"></a> Install a new domain controller in an existing domain  
 When you install a new [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controller in an existing Windows 2000 Server or Windows Server 2003 domain, keep the following considerations in mind:  
  
-   If this domain controller is the first [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controller in the forest, you must prepare the forest for [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] by extending the schema \(that is, by running **adprep \/forestprep**\) on the schema operations master if this has not already been done.  
  
    > [!NOTE]  
    >  In [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], Adprep.exe is available in the \/sources\/adprep folder of the installation DVD. In [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], Adprep.exe is located in the \/support\/adprep folder.  
  
-   If this domain controller is the first [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controller in a Windows 2000 Server domain, you must first prepare the domain by running **adprep \/domainprep \/gpprep** on the infrastructure master.  
  
    > [!NOTE]  
    >  If you prepare a Windows Server 2003 domain by running **adprep \/domainprep \/gpprep**, you can safely disregard the error message that indicates that domain updates were not necessary.  
  
-   If this domain controller is the first [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controller in a Windows Server 2003 domain, you must prepare the domain by running **adprep \/domainprep** on the infrastructure master.  
  
-   Before you can install an RODC in a Windows 2000 Server or Windows Server 2003 forest, you must prepare the forest by running **adprep \/rodcprep**. You can run **adprep \/rodcprep** on any computer in the forest. You can run it multiple times if necessary. If the operation is unable to reach all the application partitions that must be updated to allow RODC installation, you receive a message that says that not all application partitions have been updated. In this case, rerun the **adprep \/rodcprep** command.  
  
-   The first [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controller in an existing Windows 2000 Server or Windows Server 2003 domain cannot be created as an RODC. After a [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controller exists in the domain, additional [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controllers can be created as RODCs.  
  
 After you have prepared the forest and the domain, you can install AD DS to create a new [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] domain controller.  
  
 For procedures to install a new domain controller, see [Installing an Additional Domain Controller](../Topic/Installing-an-Additional-Domain-Controller.md).  
  
##  <a name="BKMK_performing_RODC"></a> Perform a staged RODC installation  
 AD DS provides a way for you to install an RODC in a branch office in two stages. First, you create an account for the RODC. When you create the account, you can choose who will install and administer the RODC. The delegated RODC administrator can complete the installation by attaching a server to the RODC account you created for it. This eliminates the need to use a staging site for building branch office domain controllers and also eliminates the need to use domain administrator credentials to build the RODC in the branch office.  
  
 When you install an RODC, keep the following considerations in mind:  
  
-   The RODC must replicate domain data from a writeable domain controller that runs [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
-   By default, the RODC does not cache the passwords of any domain users. This means that by default, user and computer authentications that are handled by an RODC still require connectivity to a writeable domain controller that runs [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. You must modify the default Password Replication Policy \(PRP\) for the RODC to allow the RODC to authenticate users and their computers when the wide area network \(WAN\) link to the writeable domain controller is offline.  
  
     For more information about how the authentication process works with an RODC, see Appendix A: Technical Reference Topics \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=128273](http://go.microsoft.com/fwlink/?LinkID=128273)\). For more information about how to modify the PRP, see Administering the Password Replication Policy \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=137087](http://go.microsoft.com/fwlink/?LinkId=137087)\).  
  
##  <a name="BKMK_IFMScenario"></a> Install AD DS from media  
 You can use the install from media \(IFM\) option to install an additional domain controller in an existing domain and minimize replication traffic during the installation. [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] include an improved version of Ntdsutil.exe that you can use to create the installation media.  
  
 You can also create installation media by using the Windows Server Backup tool in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. In this case, you need to use the **wbadmin** command\-line tool option to create the system state backup and then you need to restore system state backup to an alternate location.  
  
 However, you should use Ntdsutil.exe because the system state backup includes data, such as the registry, that is not required for AD DS installation.  
  
 For the procedure to install a new domain controller from media that is created by using Ntdsutil.exe, see [Installing AD DS from Media_deleted](../Topic/Installing-AD-DS-from-Media_deleted.md).  
  
##  <a name="BKMK_VerifyScenario"></a> Verify AD DS installations  
 After you install a domain controller, you can take the following steps to verify the AD DS installation:  
  
-   Check the Directory Service log in Event Viewer for errors.  
  
-   Make sure that the SYSVOL folder is accessible to clients.  
  
-   Verify DNS functionality.  
  
-   Verify replication.  
  
  