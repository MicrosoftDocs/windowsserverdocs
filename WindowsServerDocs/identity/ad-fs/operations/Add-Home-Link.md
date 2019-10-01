---
ms.assetid: da035189-e87f-4597-9933-49bf391a8d5d
title: Add Home Link 
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
---

# Add Home Link 

To add the home link that is displayed on the sign\-in page, use the following Windows PowerShell cmdlet and syntax. 


![add home link](media/AD-FS-user-sign-in-customization/ADFS_Blue_Custom2.png) 
  

`Set-AdfsGlobalWebContent -HomeLink https://fs1.contoso.com/home/ -HomeLinkText Home ` 
 
  
> [!IMPORTANT]  
> The `linkText` parameter in this cmdlet is not required unless you use another value than the default, which is *Home*. The advantage of using the default is that they are localized to all client locales. after the sign\-in page is customized, the customization takes precedence; therefore, you should customize for all languages that you want to support.

## Additional references 
[AD FS User Sign-in Customization](AD-FS-user-sign-in-customization.md)  
