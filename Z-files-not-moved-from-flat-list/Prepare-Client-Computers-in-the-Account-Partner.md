---
title: Prepare Client Computers in the Account Partner
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ea500dce-4953-4d79-a62f-0ce7af601f40
author: billmath
---
# Prepare Client Computers in the Account Partner
The easiest way for an administrator in an account partner organization to prepare client computers for access to [!INCLUDE[firstref_adfs2](includes/firstref_adfs2_md.md)] federated applications is to use Group Policy. Group Policy provides a convenient way for you to push specific certificates and settings that are required for federation to all the client computers that will be used to access federated applications.  
  
So that your client computers can seamlessly access federated applications without certificate prompts or trusted site–related prompts, we recommend that you first prepare each client computer before you deploy [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] broadly in your organization. Consider using Group Policy to automatically:  
  
-   Configure Internet Explorer on each client computer to trust the account [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)].  
  
    For more information, see [Configure Client Computers to Trust the Account Federation Server](Configure-Client-Computers-to-Trust-the-Account-Federation-Server.md).  
  
-   Install the appropriate account [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)], resource [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)], and Web server Secure Sockets Layer (SSL) certificates (or equivalent certificates that chain to a trusted root) on each client computer.  
  
    For more information, see [Distribute Certificates to Client Computers by Using Group Policy](Distribute-Certificates-to-Client-Computers-by-Using-Group-Policy.md).  
  

