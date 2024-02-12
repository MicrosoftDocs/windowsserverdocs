---
manager: amycolannino
description: Learn more about multi-factor authentication and external authentication providers customization.
title: Multi-factor authentication and external authentication providers customization
ms.topic: article
author: billmath
ms.author: billmath
ms.date: 08/15/2023
---

# Multi-factor authentication and external authentication providers customization

Applies to: Windows Server (All supported versions)

In AD FS, support for multi-factor authentication is included out of the box. For example, you can configure AD FS to use built in Certificate Authentication as the second factor authentication. You can also use external authentication providers. This approach can enable AD FS to integrate with other services, such as Azure Multi-factor Authentication, or you can develop your own provider. See [Solution Guide: Manage Risk with Multi\-factor Access Control](./manage-risk-with-conditional-access-control.md) for more information about how to register external authentication provider by using AD FS.

An external authentication provider should use the classes that are defined in the .css file that AD FS provides to author the authentication UI. You can use the following cmdlet to export the default web theme and inspect the user interface classes and elements that are defined in the .css file. The .css file can be used in the development of the sign\-in user interface of an external authentication provider.

```powershell
Export-AdfsWebTheme -Name default -DirectoryPath C:\theme
```

The following example shows a sign-in user interface, which is highlighted in RED, by an external authentication provider. The user interface uses the UI classes in the AD FS .css file.

![Screenshot that shows an example of the sign-in user interface.](media/AD-FS-user-sign-in-customization/ADFS_Blue_Custom8.png)

Before you write a new custom authentication method, study the AD FS theme and style definitions to understand the content authoring requirements.

- A custom authentication method only authors an HTML segment on the AD FS sign\-in page and not the full page. Use the AD FS style definition to get the consistent appearance and behavior.

![AD FS and MFA](media/AD-FS-user-sign-in-customization/ADFS_Blue_Custom9.png)

- AD FS administrators can customize the AD FS styles. Don't hardcode your own styles. Instead, try using AD FS styles whenever possible.

- Out of the box, AD FS styles are authored with one left-to-right \(LTR\) style and one right-to-left \(RTL\). Administrators can customize both and can provide language-specific styles through the web theme definition. Each stylesheet has three sections with respective comments:

- **theme styles** - These styles shouldn't and can't be used. These styles are meant to define the theme across all pages. They're defined with an element ID purposely so that they aren't reused.

- **common styles** - These styles are the styles that should be used for your content.

- **form factor styles** - These styles for different form factors. You should understand this section to ensure that your content works with different form factors, for example, phones and tablets.

For more information, see [Solution Guide: Manage Risk with Multi\-factor Access Control](./manage-risk-with-conditional-access-control.md) and [Walkthrough Guide: Manage Risk with Additional Multi-Factor Authentication for Sensitive Applications](/windows-server/identity/ad-fs/operations/walkthrough-guide--manage-risk-with-additional-multi-factor-authentication-for-sensitive-applications)).

## Related links

[AD FS User Sign-in Customization](AD-FS-user-sign-in-customization.md)
