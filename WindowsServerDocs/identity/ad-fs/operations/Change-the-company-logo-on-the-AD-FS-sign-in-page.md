---
ms.assetid: f7f6bac2-1100-4b00-a248-4ca3eb3cdbe9
title: Changing the company logo on the AD FS sign-in page
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 03/08/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
---
# Changing the company logo on the AD FS sign-in page

#### Change company logo  
To change the logo of the company that is displayed on the sign\-in page, use the following PowerShell Windows PowerShell cmdlet and syntax.  

![change logo](media/AD-FS-user-sign-in-customization/ADFS_Blue_Custom2.png)
  
> [!IMPORTANT]  
> We recommend the dimensions for the logo to be 260x35 @ 96 dpi with a file size of no greater than 10 KB.  
  
    
    Set-AdfsWebTheme -TargetName default -Logo @{path="c:\Contoso\logo.png"}  

  
> [!NOTE]  
> The `TargetName` parameter is required. The default theme that is released with AD FS is named *default*.  

## Additional references 
[AD FS User Sign-in Customization](AD-FS-user-sign-in-customization.md)  
