---
title: Performing a Staged RODC Installation
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 13e1cd36-9e89-4d3b-aaf1-b9c91a4fe15c
author: Femila
---
# Performing a Staged RODC Installation
  You can perform an installation of a read\-only domain controller \(RODC\) in which the installation is completed in two stages by different individuals. The first stage of the installation, which requires Domain Admin credentials, creates an account for the RODC in Active Directory Domain Services \(AD DS\). The second stage of the installation attaches the actual server that will be the RODC in a remote location, such as a branch office, to the account that was previously created for it. You can delegate the ability to attach the server to a nonadministrative group or user.  
  
 During this first stage, the Active Directory Domain Services Installation Wizard records all data about the RODC that will be stored in the distributed Active Directory database, such as its domain controller account name and the site in which it will be placed. This stage must be performed by a member of the Domain Admins group.  
  
 The administrator who creates the RODC account can also specify at that time which users or groups can complete the next stage of the installation. The next stage of the installation can be performed in the branch office by any user or group who was delegated the right to complete the installation when the account was created. This stage does not require any membership in built\-in groups, such as the Domain Admins group. If the user who creates the RODC account does not specify any delegate to complete the installation \(and administer the RODC\), only a member of the Domain Admins or Enterprise Admins groups can complete the installation.  
  
 During the second stage, the wizard installs AD DS on the server that will become the RODC and it attaches the server to the domain account that was previously created for it. This stage typically occurs in the branch office where the RODC is deployed. During this stage, all Active Directory data that resides locally, such as the database, log files, and so on, is created on the RODC itself. The installation source files can be replicated to the RODC from another domain controller over the network, or you can use the install from media \(IFM\) feature. To use IFM, use Ntdsutil.exe to create the installation media.  
  
 The server that will become the RODC must not be joined to the domain before you try to attach it to the RODC account. As part of the installation, the wizard automatically detects whether the name of the server matches the names of any RODC accounts that have been created in advance for the domain. When the wizard finds a matching account name, it prompts the user to use that account to complete the RODC installation.  
  
 You can complete each stage of the installation by using any of the following methods:  
  
> [!NOTE]  
>  Before you can install an RODC, the prerequisites must be completed. For more information, see Prerequisites for Deploying an RODC \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=133514](http://go.microsoft.com/fwlink/?LinkID=133514)\).  
  
-   [Performing a Staged RODC Installation by Using the Graphical User Interface &#40;GUI&#41;](../Topic/Performing-a-Staged-RODC-Installation-by-Using-the-Graphical-User-Interface--GUI-.md)  
  
-   [Performing a Staged RODC Installation by Using the Command Line](../Topic/Performing-a-Staged-RODC-Installation-by-Using-the-Command-Line.md)  
  
-   [Performing a Staged RODC Installation by Using an Answer File](../Topic/Performing-a-Staged-RODC-Installation-by-Using-an-Answer-File.md)  
  
  