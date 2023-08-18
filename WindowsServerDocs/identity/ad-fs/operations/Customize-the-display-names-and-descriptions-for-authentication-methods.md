---
description: "Learn more about: Customize the display names and descriptions for authentication methods"
ms.assetid: 309d6358-777d-496a-856d-728246c7d9a1
title: Customize the display names and descriptions for authentication methods
author: billmath
ms.author: billmath
manager: amycolannino
ms.date: 08/15/2023
ms.topic: article
---
# Customize the display names and descriptions for authentication methods

To customize the display names and descriptions for authentication methods you can use the `Set-AdfsAuthenticationProviderWebContent` PowerShell cmdlet.  In order to use this cmdlet, you must first obtain the name of the authentication method you wish to customize.  This can be done using `Get-AdfsGlobalAuthenticationPolicy`.  In the example below we see that, on our sign\-in page, the following is displayed:  "Sign in using an X.509 certificate".  We want to simplify this for our users.

![customize displayname](media/AD-FS-user-sign-in-customization/ADFS_Customize_Update1.PNG)

So first we get the name of the authentication method and then we edit the displayed text.

```powershell
Get-AdfsGlobalAuthenticationPolicy

AdditionalAuthenticationProvider  : {}
DeviceAuthenticationEnabled   : False
PrimaryIntranetAuthenticationProvider : {FormsAuthentication, CertificateAuthentication}
PrimaryExtranetAuthenticationProvider : {FormsAuthentication, CertificateAuthentication}
WindowsIntegratedFallbackEnabled  : True

Set-AdfsAuthenticationProviderWebContent -Name CertificateAuthentication -DisplayName "Sign in with a certificate"
 ```

![Screenshot that shows how to get the name of the authentication method and edit the displayed text.](media/AD-FS-user-sign-in-customization/ADFS_Customize_Update2.PNG)

Now we see that our display message has changed.

![Screenshot that shows that the display message has changed.](media/AD-FS-user-sign-in-customization/ADFS_Customize_Update3.PNG)

## Additional references

[AD FS User Sign-in Customization](AD-FS-user-sign-in-customization.md)
