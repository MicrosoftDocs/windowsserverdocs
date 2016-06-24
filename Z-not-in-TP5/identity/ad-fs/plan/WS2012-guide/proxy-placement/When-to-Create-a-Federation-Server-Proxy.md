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
Creating a federation server proxy in your organization adds additional security layers to your Active Directory Federation Services (AD FS) deployment. Consider deploying a federation server proxy in your organization's perimeter network when you want to:  
  
-   Prevent external client computers from directly accessing your federation servers. By deploying a federation server proxy in your perimeter network, you effectively isolate your federation servers so that they can be accessed only by client computers that are logged in to the corporate network through federation server proxies, which act on behalf of the external client computers. Federation server proxies do not have access to the private keys that are used to produce tokens. For more information, see [Where to Place a Federation Server Proxy](../../../../ad-fs/plan/WS2012-guide/proxy-placement/Where-to-Place-a-Federation-Server-Proxy.md).  
  
-   Provide a convenient way to differentiate the sign-in experience for users who are coming from the Internet as opposed to users who are coming from your corporate network using Windows Integrated Authentication. A federation server proxy collects credentials or home realm details from Internet client computers by using the logon, logout, and identity provider discovery (homerealmdiscovery.aspx) pages that are stored on the federation server proxy.  
  
    In contrast, client computers that come from the corporate network encounter a different experience, based on the configuration of the federation server. The corporate network federation server is often configured for Windows Integrated Authentication, which provides a seamless sign-in experience for users on the corporate network.  
  
The role that a federation server proxy plays in your organization depends on whether you place the federation server proxy in the account partner organization or in the resource partner organization. For example, when a federation server proxy is placed in the perimeter network of the account partner, its role is to collect the user credential information from browser clients. When a federation server proxy is placed in the perimeter network of the resource partner, it relays security token requests to a resource federation server and produces organizational security tokens in response to the security tokens that are provided by its account partners.  
  
For more information, see [Review the Role of the Federation Server Proxy in the Account Partner](Review-the-Role-of-the-Federation-Server-Proxy-in-the-Account-Partner.md) and [Review the Role of the Federation Server Proxy in the Resource Partner](Review-the-Role-of-the-Federation-Server-Proxy-in-the-Resource-Partner.md)  
  
## How to create a federation server proxy  
You can create a federation server proxy using either the AD FS Federation Server Proxy Configuration Wizard or the Fsconfig.exe command-line tool. For instructions about how to do this, see [Configure a Computer for the Federation Server Proxy Role](Configure-a-Computer-for-the-Federation-Server-Proxy-Role.md).  
  
For general information about how to set up all the prerequisites necessary to deploy a federation server proxy, see [Checklist: Setting Up a Federation Server Proxy](Checklist--Setting-Up-a-Federation-Server-Proxy.md).  
  

