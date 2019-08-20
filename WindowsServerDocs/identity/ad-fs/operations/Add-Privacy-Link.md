---
ms.assetid: 1ca6f87f-7272-4767-b609-3e295ac7d32f
title: Add Privacy Link 
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# Add Privacy Link 


To add the privacy link that is displayed on the sign\-in page, use the following Windows PowerShell cmdlet and syntax.  

![add privacy link](media/AD-FS-user-sign-in-customization/ADFS_Blue_Custom2.png) 
  
 
`Set-AdfsGlobalWebContent -PrivacyLink https://fs1.contoso.com/privacy/ -PrivacyLinkText Privacy`  
 
  
> [!IMPORTANT]  
> The `linkText` parameter in this cmdlet is not required unless you use another value than the default, which is *Privacy*. The advantage of using the default is that the pages are localized to all client locales. After the sign\-in page is customized, the customization takes precedence; therefore, you should customize for all languages that you want to support. All customized content takes a locale parameter. When you configure localized content, you should configure it with a country\-less locale first, for example, "en", before you configure country and region\-specific locale, such as "en\-us".  

## Additional references 
[AD FS User Sign-in Customization](AD-FS-user-sign-in-customization.md)  
