---
ms.assetid: 882abec8-0189-4f73-99c5-792987168080
title: Advanced Customization of AD FS Sign-in Pages
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 01/16/2019
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
---



# Advanced Customization of AD FS Sign-in Pages

  
## Advanced Customization of AD FS Sign\-in Pages  
AD FS in Windows Server 2012 R2 provides built\-in support for customizing the sign\-in experience. For a majority of these scenarios, the built\-in Windows PowerShell cmdlets are all that is required.  It is recommended that you use the built\-in Windows PowerShell commands to customize standard elements for AD FS sign\-in experience whenever possible.  See [AD-FS user sign-in customization](AD-FS-user-sign-in-customization.md) for more information.  
  
In some cases, AD FS administrators may want to provide additional sign\-in experiences that are not possible through the existing PowerShell commands that ship in\-box with AD FS. In certain instances, it is feasible \(within the guidelines provided below\) for administrators to customize the sign\-in experience further by adding additional logic to **onload.js** that is provided by AD FS and will be executed on all the AD FS pages.  
  
## Things to know before you start  
  
-   Any change that impacts the redirect flows or modifies protocol parameters that AD FS works with is not supported.
  
-   The original onload.js, the one that comes with the default web theme, contains code that handles page rendering for different form factors. It is recommended not to modify the original onload.js content but only append your code to the existing onload.js that handles custom logic.  
  
-   AD FS ships with a built\-in web theme which is called Default. You cannot modify the onload.js of the Default web theme. To update onload.js, you have to create and use a custom web theme for AD FS sign\-in pages.  See [AD-FS user sign-in customization](AD-FS-user-sign-in-customization.md) for information on how to create a custom web theme.  
  
-   The same onload.js will execute on all ADFS pages \(ex. form\-based logon page, home realm discovery page and etc.\). You need to make sure the code in your script only gets executed as it is designed and does not get executed unexpectedly.  
  
-   When referencing any HTML element, ensure that you always check for the existence of the element prior to acting on the element. This provides robustness and ensures that the custom logic would not be executed on pages that do not contain this element. You can simply view the HTML source on the AD FS sign\-in pages to view the existing elements.  
  
-   It is strongly recommended to validate your customizations in an alternate environment and test them prior to rolling it out onto production AD FS servers. This reduces the chances of end users being exposed to these customizations prior to validation.  
  
## Customizing the AD FS sign\-in experience by using onload.js  
Use the following steps when customizing the onload.js for the AD FS service.  
  
#### Customizing onload.js for the AD FS Service  
  
1.  To add your custom logic to onload.js, you need to first create a custom web theme. The theme that is shipped out\-of\-the\-box is called Default. You can export the default theme and use it so that you can start quickly. The following cmdlet creates a custom web theme, which duplicates the default web theme:  
  
    ```  
    New-AdfsWebTheme –Name custom –SourceName default  
  
    ```  
  
2.  You can then export the custom or default web theme to get onload.js file. To export a web theme, use the following cmdlet:  
  
    ```  
    Export-AdfsWebTheme –Name default –DirectoryPath c:\theme  
  
    ```  
  
    You will find onload.js under the script folder in the directory that you specify in the export cmdlet above and add your custom logic to the script \(see use cases in the Example section below\).  
  
3.  Make the necessary modification to customize onload.js based on your need.  
  
4.  Update the theme with the modified onload.js. Use the following cmdlet to apply the update onload.js to custom web theme:  

     For AD FS on Windows Server 2012 R2:  

    ```  
    Set-AdfsWebTheme -TargetName custom -AdditionalFileResource @{Uri='/adfs/portal/script/onload.js';path="c:\theme\script\onload.js"}  
  
    ```  
    For AD FS on Windows Server 2016:

     ```  
    Set-AdfsWebTheme -TargetName custom -OnLoadScriptPath "c:\ADFStheme\script\onload.js"   
  
    ```  
  
5.  To apply the custom web theme to AD FS, use the following cmdlet:  
  
    ```  
    Set-AdfsWebConfig -ActiveThemeName custom  
    ```  
  
## Additional Customization Examples  
The following are the examples of custom code added to onload.js for different fine\-tune purposes. When adding the custom code, please always append your custom code to the bottom of the onload.js.  
  
### Example 1: change “Sign in with organizational account” string  
The default AD FS form\-based sign\-in page has a title of “Sign in with your organizational account” above user input boxes.  
  
If you want to replace this string with your own string, you can add the following code to onload.js.  
  
```  
// Sample code to change “Sign in with organizational account” string.  
  
// Check whether the loginMessage element is present on this page.  
var loginMessage = document.getElementById('loginMessage');  
if (loginMessage)  
{  
       // loginMessage element is present, modify its properties.  
       loginMessage.innerHTML = 'Your company description text';  
}  
  
```  
  
### Example 2: accept SAM\-account name as a login format on an AD FS form\-based sign\-in page  
The default AD FS form\-based sign\-in page supports login format of User Principal Names \(UPNs\) \(for example, <strong>johndoe@contoso.com</strong>\) or domain qualified sam\-account names \(**contoso\\johndoe** or **contoso.com\\johndoe**\). In case all of your users come from the same domain and they only know about sam\-account names, you may want to support the scenario where the users can sign in using them sam\-account names only. You can add the following code to onload.js to support this scenario, just replace the domain “contoso.com” in the example below with the domain that you want to use.  
  
```  
if (typeof Login != 'undefined'){  
    Login.submitLoginRequest = function () {   
    var u = new InputUtil();  
    var e = new LoginErrors();  
    var userName = document.getElementById(Login.userNameInput);  
    var password = document.getElementById(Login.passwordInput);  
    if (userName.value && !userName.value.match('[@\\\\]'))   
    {  
        var userNameValue = 'contoso.com\\' + userName.value;  
        document.forms['loginForm'].UserName.value = userNameValue;  
    }  
  
    if (!userName.value) {  
       u.setError(userName, e.userNameFormatError);  
       return false;  
    }  
  
    if (!password.value)   
    {  
        u.setError(password, e.passwordEmpty);  
        return false;  
    }  
    document.forms['loginForm'].submit();  
    return false;  
};  
}  
  
```  
  
## Additional references 
[AD FS User Sign-in Customization](AD-FS-user-sign-in-customization.md)  
  

