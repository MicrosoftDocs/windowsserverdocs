
---
title: Add Home Link 
description:
author: billmath
manager: femila
ms.date: 08/31/2016
ms.topic: article
ms.prod: windows-server-threshold
ms.service: active-directory
ms.technology: active-directory-federation-services
---
# Add Help Desk Link 

>Applies To: Windows Server 2016, Windows Server 2012 R2


## To Add a Help Desk Link  
To add the help desk link that is displayed on the sign\-in page, use the following Windows PowerShell PowerShell cmdlet and syntax.  

![](media/AD-FS-user-sign-in-customization/ADFS_Blue_Custom2.png)
  

`Set-AdfsGlobalWebContent -HelpDeskLink https://fs1.contoso.com/help/ -HelpDeskLinkText Help`  
 
  
> [!IMPORTANT]  
> The `linkText` parameter in this cmdlet is not required unless you use another value than the default, which is *Help*. The advantage of using the default is that they are localized to all client locales. After the page is customized, the customization takes precedence; therefore, you should customize for all languages that you want to support.  


## Additional references 
[AD FS User Sign-in Customization](AD-FS-user-sign-in-customization.md)  