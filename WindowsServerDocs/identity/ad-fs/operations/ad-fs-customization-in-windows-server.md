---
ms.assetid: 25f5aff1-6abf-4dea-b531-f1d9943bc181
title: AD FS Customization in Windows Server 2016
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---
# AD FS Customization in Windows Server 2016


In response to feedback from organizations using AD FS, we have added additional tools to customize the user sign in experience for individual applications protected by AD FS.  
In addition to specifying per-application web content such as description text and links, now you can specify entire web themes per application.  This includes logo, illustration, style sheets, or an entire onload.js file.  
  
## Global Settings    
For general global settings you can refer to [Customizing the AD FS Sign-in Pages](https://technet.microsoft.com/library/dn280950.aspx) that shipped with AD FS in Windows Server 2012 R2.  
  
## Pre-requisites  
The following pre-requisites are required before attempting the procedures outlined in this document.  
  
-   AD FS in Windows Server 2016 TP4 or later  
  
## Configure AD FS Relying parties  
Per relying party sign-in web elements and themes can be configured using the PowerShell examples below:  
  
### Customize messages  
  
```  
PS C:\>Set-AdfsRelyingPartyWebContent  
    -TargetRelyingPartyName "<RP trust Name>"  
    -CompanyName "This text appears in place of the federation service display name"  
    -OrganizationalNameDescriptionText "This text appears right below the company name"  
    -SignInPageDescription "This text appears below the credential prompt"  
```  
  
### Customize company name, logo, and image  
  
```  
PS C:\>Set-AdfsRelyingPartyWebTheme  
    -TargetRelyingPartyName "<RP trust Name>"  
    -Logo @{path="C:\Images\applogo.png"}  
    -Illustration @{path="C:\Images\appillustration.jpg"}  
```  
  
### Customize entire page  
  
```  
PS C:\>Set-AdfsRelyingPartyWebTheme  
    -TargetRelyingPartyName "<RP trust Name>"  
    -OnLoadScriptPath @{path="c:\scripts\adfstheme\onload.js"}  
```  
  
## Custom themes and advanced custom themes  
  
For custom themes refer to [Customizing the AD FS Sign-in Pages](https://technet.microsoft.com/library/dn280950.aspx) and [Advanced Customization of AD FS Sign-in Pages.](https://technet.microsoft.com/library/dn636121.aspx)  
  
## Assigning custom web themes per RP  
  
To assign a custom theme per RP use the following procedure:  
  
1. Create a new theme as a copy for the default, global theme in AD FS  
<code>New-AdfsWebTheme -Name AppSpecificTheme -SourceName default</code>  
2. Export the theme for customization  
<code>Export-AdfsWebTheme -Name AppSpecificTheme -DirectoryPath c:\appspecifictheme</code>  
3. Customize theme files (images, css, onload.js) - in your favorite editor or replace the file  
4. Import customized files from the file system to AD FS (targeting the new theme)  
<code>Set-AdfsWebTheme -TargetName AppSpecificTheme -AdditionalFileResource @{Uri='/adfs/portal/script/onload.js';Path="c:\appspecifictheme\script\onload.js"}</code>  
5. Apply the new, customized theme to the specific RP (or RP's)  
<code>Set-AdfsRelyingPartyWebTheme -TargetRelyingPartyName urn:app1 -SourceWebThemeName AppSpecificTheme</code>  
  
## Home Realm Discovery  
For home realm dicovery customization see [Customizing the AD FS Sign-in Pages](https://technet.microsoft.com/library/dn280950.aspx).  
  
## Updated password page  
For information on customizing the update password page see [Customizing the AD FS Sign-in Pages](https://technet.microsoft.com/library/dn280950.aspx).  
  
## Customizing and Alternate IDs  
Users can sign in to Active Directory Federation Services (AD FS)-enabled applications using any form of user identifier that is accepted by Active Directory Domain Services (AD DS). These include User Principal Names (UPNs) (johndoe@contoso.com) or domain qualified sam-account names (contoso\johndoe or contoso.com\johndoe).  For more information on this see [Configuring Alternate Login ID.](Configuring-Alternate-Login-ID.md)  
  
You may additionally want to customize the AD FS sign-in page to give end users some hint about the alternate login ID. You can do it by adding the customized sign-in page description for more information see [Customizing the AD FS Sign-in Pages.](https://technet.microsoft.com/library/dn280950.aspx)   
  
You can also do this by customizing "Sign in with organizational account" string above username field.  For information on this see [Advanced Customization of AD FS Sign-in Pages](https://technet.microsoft.com/library/dn636121.aspx).  

## Additional references 
[AD FS User Sign-in Customization](AD-FS-user-sign-in-customization.md)  
