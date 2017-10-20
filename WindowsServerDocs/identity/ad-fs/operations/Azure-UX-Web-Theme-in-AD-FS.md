---
title: Azure AD UX Web Theme in AD FS
description: The following document describes how to change the AD FS forms sign-in so that it resembles the Azure AD user experience.
author: billmath
ms.author: billmath
manager: femila
ms.date: 10/13/2017
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: identity-adfs
---

# Using an Azure AD UX Web Theme in Active Directory Federation Services
The AD FS forms sign in currently does not mirror the Azure/O365 sign-in experience.  To provide a more uniform and seamless experience for end-users, we have released the follow cascading style sheet web theme which can be applied to your AD FS servers.  Currently, the forms sign-in for AD FS on Windows Server 2016 looks like following:

![Current sign-in](media/Azure-UX-Web-Theme-in-AD-FS/one.png)


With the new style sheet, the user experience will look more like the Azure and Office 365 sign-in experiences.

## Download the CSS style sheet
You can download the web theme from the following Github [location](https://github.com/Microsoft/adfsWebCustomization/tree/master/centeredUi).


## Enabling the new web theme
To enable the new web theme use the following procedure:

### To enable the new Azure AD UX web theme in AD FS
1.  Start PowerShell as an Administrator
2.  Create a new web theme using PowerShell:  `New-AdfsWebTheme –Name custom –StyleSheet @{path=”c:\NewTheme.css”}`
3.  Set the new theme as the active theme using PowerShell:  `Set-AdfsWebConfig -ActiveThemeName custom`
![PowerShell](media/Azure-UX-Web-Theme-in-AD-FS/two.png)
4.  Test the sign-in by going to https://<AD FS name.domain>/adfs/ls/idpinitiatedsignon.htm
![Sign-on](media/Azure-UX-Web-Theme-in-AD-FS/three.png)

>![NOTE]
>You need to ensure that idpinitiatedsignon has been enabled.  It is not enabled by default.  To enable idpinitiatedsignon use the following PowerShell command:  `Set-AdfsProperties –EnableIdpInitiatedSignonPage $True`

## Next Steps
- [AD FS Customization in Windows Server 2016](AD-FS-Customization-in-Windows-Server-2016.md)
- [Advanced Customization](Advanced-Customization-of-AD-FS-Sign-in-Pages.md)
- [Custom web themes](Custom-Web-Themes-in-AD-FS.md)