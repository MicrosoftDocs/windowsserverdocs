---
ms.assetid: 2bac7744-9de3-491a-b0a2-4e843cec7344
title: Add Help Desk Link 
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# Add Help Desk Link 


## To Add a Help Desk Link  
To add the help desk link that is displayed on the sign\-in page, use the following Windows PowerShell cmdlet and syntax.  

![add help desk](media/AD-FS-user-sign-in-customization/ADFS_Blue_Custom2.png)
  

`Set-AdfsGlobalWebContent -HelpDeskLink https://fs1.contoso.com/help/ -HelpDeskLinkText Help`  
 
  
> [!IMPORTANT]  
> The `linkText` parameter in this cmdlet is not required unless you use another value than the default, which is *Help*. The advantage of using the default is that they are localized to all client locales. After the page is customized, the customization takes precedence; therefore, you should customize for all languages that you want to support.  


## Additional references 
[AD FS User Sign-in Customization](AD-FS-user-sign-in-customization.md)  
