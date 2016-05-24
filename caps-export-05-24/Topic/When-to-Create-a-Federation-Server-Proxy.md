---
title: When to Create a Federation Server Proxy
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 01e4a15e-569b-4592-acdd-2da22e27b0bc
author: billmath
---
# When to Create a Federation Server Proxy
Creating a [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)] in your organization adds additional security layers to your [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)] deployment. Consider deploying a [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)] in your organization's perimeter network when you want to:  
  
-   Prevent external client computers from directly accessing your [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)]s. By deploying a [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)] in your perimeter network, you effectively isolate your [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)]s so that they can be accessed only by client computers that are logged in to the corporate network through [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] proxies, which act on behalf of the external client computers. Federation server proxies do not have access to the private keys that are used to produce tokens. For more information, see [Where to Place a Federation Server Proxy](../Topic/Where-to-Place-a-Federation-Server-Proxy.md).  
  
-   Provide a convenient way to differentiate the sign\-in experience for users who are coming from the Internet as opposed to users who are coming from your corporate network using Windows Integrated Authentication. A [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)] collects credentials or home realm details from Internet client computers by using the logon, logout, and identity provider discovery \(homerealmdiscovery.aspx\) pages that are stored on the [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)].  
  
    In contrast, client computers that come from the corporate network encounter a different experience, based on the configuration of the [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)]. The corporate network [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] is often configured for Windows Integrated Authentication, which provides a seamless sign\-in experience for users on the corporate network.  
  
The role that a [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)] plays in your organization depends on whether you place the [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)] in the account partner organization or in the resource partner organization. For example, when a [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)] is placed in the perimeter network of the account partner, its role is to collect the user credential information from browser clients. When a [!INCLUDE[adfs2_fsp](../Token/adfs2_fsp_md.md)] is placed in the perimeter network of the resource partner, it relays security token requests to a resource [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] and produces organizational security tokens in response to the security tokens that are provided by its account partners.  
  
For more information, see [Review the Role of the Federation Server Proxy in the Account Partner](../Topic/Review-the-Role-of-the-Federation-Server-Proxy-in-the-Account-Partner.md) and [Review the Role of the Federation Server Proxy in the Resource Partner](../Topic/Review-the-Role-of-the-Federation-Server-Proxy-in-the-Resource-Partner.md)  
  
## How to create a federation server proxy  
You can create a federation server proxy using either the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] Federation Server Proxy Configuration Wizard or the Fsconfig.exe command\-line tool. For instructions about how to do this, see [Configure a Computer for the Federation Server Proxy Role](../Topic/Configure-a-Computer-for-the-Federation-Server-Proxy-Role.md).  
  
For general information about how to set up all the prerequisites necessary to deploy a federation server proxy, see [Checklist: Setting Up a Federation Server Proxy](../Topic/Checklist--Setting-Up-a-Federation-Server-Proxy.md).  
  
