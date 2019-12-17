---
title: Limit Web Access
description: Learn how to limit user access to the Internet in MultiPoint Services
ms.custom: na
ms.date: 07/08/2016
ms.prod: windows-server
ms.technology: multipoint-services
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 044f2fd5-5b87-42bb-ba0d-c06516ac48c8
author: lizap
manager: dongill
ms.author: elizapo
---
# Limit Web Access
In addition to monitoring user activities on individual desktops, you, as an administrative user, can limit user access to specified websites by indicating permissible websites and websites to which you want to block user access.  
  
## To limit web access on a station  
  
1. In MultiPoint Dashboard, on the **Web Limiting** tab, click **Configure**. The **Configure Web Limiting** page opens. Sites that the user can access are listed.  
  
2. Click the thumbnail image of the user station on which you want to limit web access.  
  
3. Under **Selected Item Tasks**, click **Limit web access on this station**. The **Configure Web Limiting** page opens. Sites that the user can access are listed.  
  
4. To add an allowed site, type the web address, and then click **Add**.  
  
   > [!NOTE]
   > For example, entering "Contoso.com" allows or blocks sites that are relative to www\.contoso.com (for example, www\.newpage.contoso.com). Entering "Contoso" will either allow or limit all Contoso-related sites (including contoso.com, contoso.uk, and so forth).  
  
5. To remove a web address from the list of allowed sites, click the web address you want to remove access to, and then click **Remove**.  
  
## To limit web access on all stations  
  
1. In MultiPoint Dashboard, on the **Web Limiting** tab, click the Start drop\-down menu, and then click **Limit Web Access on All Desktops**.  
  
   The **Configure Web Limiting** page opens. Sites that the user can access are listed. Do one of the following:  
  
2. To add an allowed site, click **Allow only these sites**, type the allowed web address, and then click **Add**.  
  
   To add a site you do not want users to visit, click **Disallow only these sites**, type the web address you don't want users to visit, and then click **Add**.  
  
   > [!NOTE]
   > For example, entering "Contoso.com" allows or blocks sites that are relative to www.contoso.com (for example, www\.newpage.contoso.com). Entering "Contoso" will either allow or limit all Contoso-related sites (including contoso.com, contoso.uk, and so forth).  
  
3. To remove a web address from the list of allowed or disallowed sites, select the web address, and then click **Remove**.  
  
## See Also  
[Manage User Desktops](manage-user-desktops-using-multipoint-dashboard.md)  
