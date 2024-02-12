---
title: Advanced customization of AD FS sign-in pages
description: Learn how to make advanced customizations of the Active Directory Federation Services (ADFS) sign-in pages in Windows Server.
author: billmath
ms.author: billmath
manager: amycolannino
ms.date: 08/15/2023
ms.topic: article
ms.assetid: 882abec8-0189-4f73-99c5-792987168080
---

# Advanced customization of AD FS sign-in pages

Active Directory Federation Services (AD FS) in Windows Server 2012 R2 and later supports customization of the user sign-in experience. For most scenarios, you can use the built-in Windows PowerShell cmdlets to configure the AD FS sign-in pages. The recommended approach is to use the built-in Windows PowerShell commands for customization whenever possible. For more information, see [AD-FS user sign-in customization](AD-FS-user-sign-in-customization.md).

Sometimes, you might need to provide a sign-in experience that can't be enabled by using the PowerShell commands that come with AD FS. You can configure the sign-in experience by adding custom code to the **onload.js** file provided with AD FS. The file code is executed on all AD FS pages.

## Considerations

Before you start customizing AD FS sign-in pages, review the following important considerations.

> [!IMPORTANT]
> Any customization change that impacts redirect flows or modifies protocol parameters used by AD FS isn't supported.

- The onload.js file is executed on all AD FS pages, including form-based sign-in pages, home realm discovery pages, and so on. Always ensure your custom code executes only as intended and not unexpectedly.

- AD FS comes with a built-in web theme called **default**. You can't modify the onload.js content that creates the default web theme. To update the onload.js file, create and use a custom web theme for AD FS sign-in pages. For more information, see [AD-FS user sign-in customization](AD-FS-user-sign-in-customization.md).

- The original onload.js file for the default web theme also contains code to handle page rendering for different form factors. The recommended customization approach is to append your custom logic code to the existing onload.js file. Don't modify the original onload.js file content.

- When you reference HTML elements, always check for the existence of the element prior to acting on the element. This step provides robustness and ensures custom logic isn't executed on pages that don't contain this element. To identify existing HTML elements, view the HTML source on the AD FS sign-in pages.

- It's recommended to validate your customizations in an alternate environment and run tests prior to moving your customizations onto production AD FS servers. This step reduces the chances of exposing end users to customizations prior to validation.

## Customization steps

The following sections provide the steps to customize the onload.js file content for AD FS sign-in pages.

### Create custom web theme

To add your custom logic to the onload.js file, the first step is to create a custom web theme. A quick method is to export the Default web theme and then use the original code as the basis for your customizations.

Run the following cmdlet to create a custom web theme by duplicating the default web theme:

```powershell
New-AdfsWebTheme –Name custom –SourceName default
```

### Generate onload.js file

The next step is to export your custom web theme so you have an onload.js file that you can update.

Run the following cmdlet to export your custom web theme and generate an onload.js file:

```powershell
Export-AdfsWebTheme –Name default –DirectoryPath c:\theme
```

The onload.js file is placed in the **script** folder in the directory specified in the cmdlet. In the example, the specified folder is `c:\theme`.

### Add customizations

Now you're ready to modify the onload.js content and add custom logic code for your scenarios. As mentioned, be sure to add your custom code to the end of the onload.js file.

See the following [Examples](#examples) section for code snippets that demonstrate common customizations.

### Change target onload.js file

After you add your customizations, you need to update the AD FS web theme to use your onload.js file rather than the original onload.js file.

Run the following cmdlet to set your onload.js file as the target for web theme definitions:

- **For AD FS on Windows Server 2016 and later**:

   ```powershell
   Set-AdfsWebTheme -TargetName custom -OnLoadScriptPath "c:\theme\script\onload.js"
   ```

- **For AD FS on Windows Server 2012 R2**:

   ```powershell
   Set-AdfsWebTheme -TargetName custom -AdditionalFileResource @{Uri='/adfs/portal/script/onload.js';path="c:\theme\script\onload.js"}
   ```

### Apply customizations to AD FS

The last step is to apply your customizations to the AD FS sign-in pages.

Run the following cmdlet to update AD FS with your customizations:

```powershell
Set-AdfsWebConfig -ActiveThemeName custom
```

## Examples

The following examples provide custom code that you can add to the onload.js file to configure AD FS sign-in pages.

> [!NOTE]
> Always append custom code to the end of the onload.js file.

### Change sign-in page title string

The AD FS form-based sign-in page displays a title above the user input fields. The default title value is "Sign in with your organizational account."

Replace the default string value with a custom string by adding the following code to the onload.js file. In the code, set the value of the `loginMessage.innerHTML` parameter to the custom string to use for the title.

```javascript
// Sample code to change page title string

// Check if loginMessage element is present
var loginMessage = document.getElementById('loginMessage');
if (loginMessage)
{
       // If loginMessage element is present, change title to custom value
       loginMessage.innerHTML = 'Custom title string value';
}
```

### Accept SAM account name sign in

The AD FS form-based sign-in page supports two sign in methods by default:

-  `userPrincipalName": A user principal name (UPN), such as `user@contoso.com`.
-  `samAccountName`: A domain qualified Security Account Manager (SAM) account name, such as `contoso\user` or `contoso.com\user`.

Consider a scenario where all users are in the same domain and the users know only their SAM account name. You can update the sign-page to allow the users to sign in by using their SAM account name only.

Enable sign in from SAM accounts only by adding the following code to the onload.js file. In the code, set the value of the `userNameValue` parameter to the desired domain.

```javascript
// Sample code to enable user login from SAM account name only

if (typeof Login != 'undefined'){

    Login.submitLoginRequest = function () {
    
    var u = new InputUtil();
    var e = new LoginErrors();
    var userName = document.getElementById(Login.userNameInput);
    var password = document.getElementById(Login.passwordInput);

    // Update login method with desired domain value
    if (userName.value && !userName.value.match('[@\\\\]'))
    {
        var userNameValue = 'contoso.com\\' + userName.value;
        document.forms['loginForm'].UserName.value = userNameValue;
    }
    
    // Check for user name errors
    if (!userName.value) {
       u.setError(userName, e.userNameFormatError);
       return false;
    }

    // Check for password errors
    if (!password.value)
    {
        u.setError(password, e.passwordEmpty);
        return false;
    }

    // Update the form page 
    document.forms['loginForm'].submit();
    return false;
    };

}
```

## Related links

- [AD FS user sign-in customization](AD-FS-user-sign-in-customization.md)
