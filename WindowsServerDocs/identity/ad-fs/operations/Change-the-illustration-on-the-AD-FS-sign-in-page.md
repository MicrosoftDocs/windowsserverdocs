---
title: Change the illustration on the AD FS sign-in page
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 08/31/2016
ms.topic: article
ms.prod: windows-server-threshold
ms.service: active-directory
ms.technology: identity-adfs
---
# Change the illustration on the AD FS sign-in page

>Applies To: Windows Server 2016, Windows Server 2012 R2

## Change the Illustration  


To change the illustration, the graphic on the left, which is displayed on the sign\-in page, use the following Windows PowerShell PowerShell cmdlet and syntax.  

![](media/AD-FS-user-sign-in-customization/ADFS_Blue_Custom2.png)
  
> [!IMPORTANT]  
> We recommend the dimensions for the illustration to be 1420x1080 pixels @ 96 DPI with a file size of no greater than 200 KB.  
  
 
    Set-AdfsWebTheme -TargetName default -Illustration @{path="c:\Contoso\illustration.png"}  

## Additional references 
[AD FS User Sign-in Customization](AD-FS-user-sign-in-customization.md)  
  
  
