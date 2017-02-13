---
ms.assetid: 7e804590-6d6c-4cca-ac14-02d4dff06cec
title: Update password customization 
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 02/09/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# Update password customization 

>Applies To: Windows Server 2016, Windows Server 2012 R2

In some instances, users might not be able to connect to the corporate network to change their account password. This factor can be problematic especially for remote employees who might live far from the nearest corporate office. For these specific cases, the update password page can be used by only connecting to the Internet.  
  
You can customize the update password page by providing your own description for the page. This feature is only available for a workplace\-joined device.  
  
> [!WARNING]  
> The update password page is only available for Workplace Joined devices and is disabled by default. For more information about Workplace Join and configuring a federation server with Device Registration Service, see [Overview: Join to Workplace from Any Device for SSO and Seamless Second Factor Authentication Across Company Applications](http://technet.microsoft.com/library/dn280945.aspx).  
>   
> To enable the password update page, go to AD FS Management under Endpoints. The endpoint for update password is located at the bottom under Other - /adfs/portal/updatepassword/. Once you have enabled the endpoint, you must restart the AD FS service. This must be done manually. You can then navigate to https://<fqdn>/adfs/portal/updatepassword/ on a workplace joined device and you should see the update password page.  
  
![update](media/AD-FS-user-sign-in-customization/ADFS_Blue_Custom5.png)  
  
## Customize the Update Password page description  
To customize the update password page description, use the following Windows PowerShell cmdlet and syntax.  
  

    Set-AdfsGlobalWebContent -UpdatePasswordPageDescriptionText "This is the Contoso Update Password page."  

## Additional references 
[AD FS User Sign-in Customization](AD-FS-user-sign-in-customization.md)  
