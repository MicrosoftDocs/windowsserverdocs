---
title: Configure browsers to use Windows Integrated Authentication (WIA) with AD FS
description: This document describes how to configure browsers to use WIA with AD FS
author: billmath
ms.author: billmath
manager: femila
ms.date: 01/04/2021
ms.topic: article
---

# Configure browsers to use Windows Integrated Authentication (WIA) with AD FS

By default, Windows Integrated Authentication (WIA) is enabled in Active Directory Federation Services (AD FS) in Windows Server 2012 R2 for authentication requests that occur within the organization's internal network (intranet) for any application that uses a browser for its authentication.

AD FS 2016 now has an improved default setting that enables the Edge browser to do WIA while not also (incorrectly) catching Windows Phone as well:

```
=~Windows\s*NT.*Edg.*
```

The above means you no longer have to configure individual user agent strings to support common Edge scenarios, even though they are updated quite often.

For other browsers, configure the AD FS property **WiaSupportedUserAgents** to add the required values based on the browsers you are using.  You can use the procedures below.

### View WIASupportedUserAgent settings

The **WIASupportedUserAgents** defines the user agents which support WIA. AD FS analyzes the user agent string when performing logins in a browser or browser control.

You can view the current settings using the following PowerShell example:

```powershell
Get-AdfsProperties | select -ExpandProperty WiaSupportedUserAgents
```

![WIA Support](media/Configure-AD-FS-Browser-WIA/wiasupport.png)


### Change WIASupportedUserAgent settings
By default, a new AD FS installation has a set of user agent string matches created. However, these may be out of date based on changes to browsers and devices. Particularly, Windows devices have similar user agent strings with minor variations in the tokens. The following Windows PowerShell example provides the best guidance for the current set of devices that are on the market today that support seamless WIA:

If you have AD FS on Windows Server 2012 R2 or earlier:

```powershell
Set-AdfsProperties -WIASupportedUserAgents @("MSIE 6.0", "MSIE 7.0; Windows NT", "MSIE 8.0", "MSIE 9.0", "MSIE 10.0; Windows NT 6", "Windows NT 6.3; Trident/7.0", "Windows NT 6.3; Win64; x64; Trident/7.0", "Windows NT 6.3; WOW64; Trident/7.0", "Windows NT 6.2; Trident/7.0", "Windows NT 6.2; Win64; x64; Trident/7.0", "Windows NT 6.2; WOW64; Trident/7.0", "Windows NT 6.1; Trident/7.0", "Windows NT 6.1; Win64; x64; Trident/7.0", "Windows NT 6.1; WOW64; Trident/7.0","Windows NT 10.0; WOW64; Trident/7.0","MSIPC", "Windows Rights Management Client", "Edg/","Edge/")
```

If you have AD FS on Windows Server 2016 or later:

```powershell
Set-AdfsProperties -WIASupportedUserAgents @("MSIE 6.0", "MSIE 7.0; Windows NT", "MSIE 8.0", "MSIE 9.0", "MSIE 10.0; Windows NT 6", "Windows NT 6.3; Trident/7.0", "Windows NT 6.3; Win64; x64; Trident/7.0", "Windows NT 6.3; WOW64; Trident/7.0", "Windows NT 6.2; Trident/7.0", "Windows NT 6.2; Win64; x64; Trident/7.0", "Windows NT 6.2; WOW64; Trident/7.0", "Windows NT 6.1; Trident/7.0", "Windows NT 6.1; Win64; x64; Trident/7.0", "Windows NT 6.1; WOW64; Trident/7.0","Windows NT 10.0; WOW64; Trident/7.0", "MSIPC", "Windows Rights Management Client", "=~Windows\s*NT.*Edg.*")
```

The command above will ensure that AD FS only covers the following use cases for WIA:

|User Agents|Use cases|
|-----|-----|
|MSIE 6.0|IE 6.0|
|MSIE 7.0; Windows NT|IE 7, IE in intranet zone. The "Windows NT" fragment is sent by desktop operation system.|
|MSIE 8.0|IE 8.0 (no devices send this, so need to make more specific)|
|MSIE 9.0|IE 9.0 (no devices send this, so no need to make this more specific)|
|MSIE 10.0; Windows NT 6|IE 10.0 for Windows XP and newer versions of desktop operating system</br></br>Windows Phone 8.0 devices (with preference set to mobile) are excluded because they send</br></br>User-Agent: Mozilla/5.0 (compatible; MSIE 10.0; Windows Phone 8.0; Trident/6.0; IEMobile/10.0; ARM; Touch; NOKIA; Lumia 920)|
|Windows NT 6.3; Trident/7.0</br></br>Windows NT 6.3; Win64; x64; Trident/7.0</br></br>Windows NT 6.3; WOW64; Trident/7.0| Windows 8.1 desktop operating system, different platforms|
|Windows NT 6.2; Trident/7.0</br></br>Windows NT 6.2; Win64; x64; Trident/7.0</br></br>Windows NT 6.2; WOW64; Trident/7.0|Windows 8 desktop operating system, different platforms|
|Windows NT 6.1; Trident/7.0</br></br>Windows NT 6.1; Win64; x64; Trident/7.0</br></br>Windows NT 6.1; WOW64; Trident/7.0|Windows 7 desktop operating system, different platforms|
|Edg/ and Edge/| Microsoft Edge (Chromium) for Windows Server 2012 R2 or earlier |
|=~Windows\s*NT.*Edg.*| Microsoft Edge (Chromium) for Windows Server 2016 or later|
|MSIPC| Microsoft Information Protection and Control Client|
|Windows Rights Management Client|Windows Rights Management Client|

### Additional links

[Microsoft Edge documentation](/microsoft-edge/web-platform/user-agent-string)
