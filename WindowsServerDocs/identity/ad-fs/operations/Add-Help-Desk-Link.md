---
description: "Learn more about: Add Help Desk Link"
title: Add Help Desk Link
ms.date: 02/13/2024
ms.topic: how-to
---

# Add Help Desk Link


## To Add a Help Desk Link
To add the help desk link that is displayed on the sign\-in page, use the following Windows PowerShell cmdlet and syntax.

![add help desk](media/AD-FS-user-sign-in-customization/ADFS_Blue_Custom2.png)


`Set-AdfsGlobalWebContent -HelpDeskLink https://fs1.contoso.com/help/ -HelpDeskLinkText Help`


> [!IMPORTANT]
> The `linkText` parameter in this cmdlet is not required unless you use another value than the default, which is *Help*. The advantage of using the default is that they are localized to all client locales. After the page is customized, the customization takes precedence; therefore, you should customize for all languages that you want to support.


## Additional references
[AD FS User Sign-in Customization](AD-FS-user-sign-in-customization.md)
