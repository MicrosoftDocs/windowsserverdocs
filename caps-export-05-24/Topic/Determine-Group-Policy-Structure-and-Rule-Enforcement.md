---
title: Determine Group Policy Structure and Rule Enforcement
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 58fd62a5-4878-4b31-9957-f209f18f8a69
---
# Determine Group Policy Structure and Rule Enforcement
This overview topic describes the process to follow when you are planning to deploy AppLocker rules.  
  
You should review the following topics to learn how to structure AppLocker rules for the targeted business groups in your organization:  
  
-   [Understand AppLocker Enforcement Settings](../Topic/Understand-AppLocker-Enforcement-Settings.md)  
  
    This topic describes the AppLocker enforcement settings for rule collections.  
  
-   [Understand AppLocker Rules and Enforcement Setting Inheritance in Group Policy](../Topic/Understand-AppLocker-Rules-and-Enforcement-Setting-Inheritance-in-Group-Policy.md)  
  
    This topic describes what you need to investigate, determine, and record in your application control policies plan.  
  
When you are determining how many Group Policy Objects \(GPOs\) to create when you apply an AppLocker policy in your organization, you should consider the following:  
  
-   Whether you are creating new GPOs or using existing GPOs  
  
-   Whether you are implementing Software Restriction Policies \(SRP\) policies and AppLocker policies in the same GPO  
  
-   GPO naming conventions  
  
-   GPO size limits  
  
> [!NOTE]  
> There is no default limit on the number of AppLocker rules that you can create. However, in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], GPOs have a 2 MB size limit for performance. In subsequent versions, that limit is raised to 100 MB.  
  
After you have determined your Group Policy structure and rule enforcement, record your findings as explained in [Document Group Policy Structure and AppLocker Rule Enforcement](../Topic/Document-Group-Policy-Structure-and-AppLocker-Rule-Enforcement.md).  
  
