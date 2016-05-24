---
title: Configuring authentication policies for AD FS
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d1edf0c7-08fb-44bf-b831-c0a8425b4a9c
author: femila
---
# Configuring authentication policies for AD FS
You can configure multifactor authentication \(MFA\) after you install AD FS. When you configure multifactor authentication, you can specify a primary authentication method to validate a user’s identity and additional authentication methods for more stringent access requirements. For example, you can specify Windows Integrated Authentication for primary authentication to access resources that have lower business impact and require additional authentication methods to access resources that have higher business impact, or for other types of access.  
  
The default settings and available options for primary authentication vary if the resource is located on an extranet or an intranet:  
  
-   Extranet resources require forms\-based authentication by default. You can optionally enable users to choose between using forms\-based authentication or certificate\-based authentication.  
  
-   Intranet resources require Integrated Windows Authentication by default. You can optionally enable users to choose between using Integrated Windows Authentication, forms\-based authentication, or certificate\-based authentication.  
  
The additional authentication methods can be based on factors such as the user account and device that is used to access the resource, and the location where the access request is made \(for example, intranet versus extranet\). There is also support for custom authentication providers and for setting policies that either require a certain authentication method or allow a user to choose from a set of authentication options. By default, you can select certificate authentication as an additional authentication method to access any resource.  
  
> [!NOTE]  
> If certificate authentication is also chosen for primary authentication, then AD FS might not prompt the user for the additional authentication because the user already authenticated by using the certificate authentication method.  
  
You can configure different scopes for authentication policies. A global authentication policy applies to all applications and services that are secured by AD FS. Global authentication policy settings specify which primary authentication method is used, methods for multifactor authentication, and device authentication. You can also configure an authentication policy for a specific relying party trust. Relying party trust authentication policy settings specify whether users are required to supply credentials each time that they sign on and other multifactor authentication requirements. If either a global or per\-relying party trust authentication policy requires MFA, MFA is triggered when the user tries to authenticate to this relying party trust.  
  
For more information about multifactor authentication, see [Manage Risk with Additional Multi\-Factor Authentication for Sensitive Applications](../Topic/Manage-Risk-with-Additional-Multi-Factor-Authentication-for-Sensitive-Applications.md). For step\-by\-step instructions about how to set up and verify multifactor authentication, see [Walkthrough Guide: Manage Risk with Additional Multi\-Factor Authentication for Sensitive Applications](../Topic/Walkthrough-Guide--Manage-Risk-with-Additional-Multi-Factor-Authentication-for-Sensitive-Applications.md).  
  
