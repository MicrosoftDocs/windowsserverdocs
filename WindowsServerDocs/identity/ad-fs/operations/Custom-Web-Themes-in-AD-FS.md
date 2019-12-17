---
ms.assetid: 0379abc3-25c7-46ab-9a6b-80a5152365b0
title: Custom Web Themes in AD FS
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
---

# Custom Web Themes in AD FS 

The theme that is shipped out\-of\-the\-box is called Default. You can export the default theme and use it so that you can start quickly. You can customize the appearance and behavior, which includes the layout by modifying the .css file, import and apply this new theme, and then you can use the customized appearance and behavior. Using the .css file also makes it easier to work with your web designers.  
  
The following cmdlet creates a custom web theme, which duplicates the default web theme.  
  
  
`New-AdfsWebTheme –Name custom –SourceName default ` 

  
You can modify the .css file and configure the new web theme by using the new .css file. To export a web theme, use the following cmdlet.  
  

    Export-AdfsWebTheme –Name default –DirectoryPath c:\theme  

  
To apply the .css file to the new theme, use the following cmdlet.  
  

    Set-AdfsWebTheme –TargetName custom –StyleSheet @{path=”c:\NewTheme.css”}  
  
  
The following cmdlet creates a custom web theme from a new style sheet.  
  
  
`New-AdfsWebTheme –Name custom –StyleSheet @{path=”c:\NewTheme.css”} –RTLStyleSheetPath c:\NewRtlTheme.css ` 
  
  
  
To apply the custom web theme to AD FS, use the following cmdlet.  
  

`Set-AdfsWebConfig -ActiveThemeName custom`  

  
To add JavaScript to AD FS, use the following cmdlet.  
  
 
    Set-AdfsWebTheme -TargetName custom -AdditionalFileResource @{Uri=' /adfs/portal/script/onload.js';path="D:\inetpub\adfsassets\script\onload.js"}  


## Additional references 
[AD FS User Sign-in Customization](AD-FS-user-sign-in-customization.md)  
