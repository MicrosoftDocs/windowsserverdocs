---
ms.assetid: 1df78c2a-5054-4b54-8310-c48ea62e6e0b
title: Custom error messages for AD FS sign-in page 
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# Custom error messages for AD FS sign-in page  


You can configure custom error messages that can be tailored to your organization. The following illustration shows a customized error page description and a generic error message. Use the following Windows PowerShell cmdlets to customize your error messages.  
  
![custom error](media/AD-FS-user-sign-in-customization/ADFS_Blue_Custom3.png)  
  
## Customize the error page description  
To customize the error page description, use the following Windows PowerShell cmdlet and syntax.  
  

`Set-AdfsGlobalWebContent -ErrorPageDescriptionText "This is Contoso's error page description" ` 

  
## Customize a generic error message  
To customize the generic error message, use the following Windows PowerShell cmdlet and syntax.  
  
 
`Set-AdfsGlobalWebContent -ErrorPageGenericErrorMessage "This is a generic error message.  Contact Contoso IT for assistance." ` 

  
## Customize an authorization error message  
To customize the authorization error message, use the following Windows PowerShell cmdlet and syntax.  
  

    Set-AdfsGlobalWebContent -ErrorPageAuthorizationErrorMessage "You have received an Authorization error.  Contact Contoso IT for assistance."  

  
## Customize a device authentication error message  
To customize the device authentication error message, use the following Windows PowerShell cmdlet and syntax.  
  
 
`Set-AdfsGlobalWebContent -ErrorPageDeviceAuthenticationErrorMessage "Your device is not authorized.  Contact Contoso IT for assistance."`  
 
  
## Customize a support email error message  
You can configure a support email address in AD FS. If configured, AD FS automatically shows a link for end users to email the error details.  
  
To customize the support email error message, use the following Windows PowerShell cmdlet and syntax.  
  

    Set-AdfsGlobalWebContent -ErrorPageSupportEmail  "admin@contoso.com"  

  
## Customize a relying party authorization message  
You can configure a relying party authorization error message in AD FS.  
  
To customize the relying party error message, use the following Windows PowerShell cmdlet and syntax.  

    Set-AdfsRelyingPartyWebContent -Name fedpassive -ErrorPageAuthorizationErrorMessage "<p> You need to be a member of Security Auditors to access this site. Click <A href='http://accessrequest/'>here</A> for more information.</p>“  


## Additional references 
[AD FS User Sign-in Customization](AD-FS-user-sign-in-customization.md)    
