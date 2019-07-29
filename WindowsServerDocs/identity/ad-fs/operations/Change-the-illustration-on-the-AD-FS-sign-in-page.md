---
ms.assetid: a4526500-24b3-423d-805c-24b0d8061aba
title: Change the illustration on the AD FS sign-in page
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---
# Change the illustration on the AD FS sign-in page

## Change the Illustration  


To change the illustration, the graphic on the left, which is displayed on the sign\-in page, use the following Windows PowerShell cmdlet and syntax.  

![change illustration](media/AD-FS-user-sign-in-customization/ADFS_Blue_Custom2.png)
  
> [!IMPORTANT]  
> We recommend the dimensions for the illustration to be 1420x1080 pixels @ 96 DPI with a file size of no greater than 200 KB.  
  
 
    Set-AdfsWebTheme -TargetName default -Illustration @{path="c:\Contoso\illustration.png"}  

## Additional references 
[AD FS User Sign-in Customization](AD-FS-user-sign-in-customization.md)  
  
  
