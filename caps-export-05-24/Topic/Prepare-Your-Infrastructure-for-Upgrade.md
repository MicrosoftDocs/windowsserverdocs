---
title: Prepare Your Infrastructure for Upgrade
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 7120ec57-ad86-4369-af22-773ed9b097fc
author: Femila
---
# Prepare Your Infrastructure for Upgrade
Preparing your Active Directory infrastructure for upgrade includes the following tasks. For more information about running Adprep.exe, see [Run Adprep commands](assetId:///255b83fa-5f20-455a-b6b0-bef198979268#BKMK_RunAdprep). If you are preparing for [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and your existing domain controllers run 32\-bit version of Windows Server, use Adprep32.exe in the support\/adprep folder of the operating installation disk. By default, [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] runs a 64\-bit version of Adprep.exe. If you are preparing for [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], there is only one version of adprep.exe, located in the sources\/adprep folder.  
  
-   Prepare the forest schema by running **adprep \/forestprep**.  
  
-   Prepare each domain where you want to install a domain controller that runs [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] by running **adprep \/domainprep \/gpprep**.  
  
-   Prepare the forest for read\-only domain controllers \(RODCs\), if you plan to install them, by running **adprep \/rodcprep**.  
  
> [!IMPORTANT]  
> Review the list of operations that Adprep.exe performs in Windows Server 2008, and test the schema updates in a lab environment to ensure that they will not conflict with any applications that run in your environment. There should not be any conflicts if your applications use RFC\-compliant object and attribute definitions. For a list of specific operations that are performed when you update the Active Directory schema, see [Windows Server 2008: Appendix of Changes to Adprep.exe to Support AD DS](http://go.microsoft.com/fwlink/?LinkId=177829) and [Windows Server 2008 R2: Appendix of Changes to Adprep.exe to Support AD DS](http://go.microsoft.com/fwlink/?LinkId=177828).  
  
