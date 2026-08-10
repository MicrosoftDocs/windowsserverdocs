---
description: "Learn more about: Add Home Link"
title: Add Home Link
ms.date: 02/13/2024
ms.topic: how-to
---

# Add Home Link

To add the home link that is displayed on the sign\-in page, use the following Windows PowerShell cmdlet and syntax.


![add home link](media/AD-FS-user-sign-in-customization/ADFS_Blue_Custom2.png)


`Set-AdfsGlobalWebContent -HomeLink https://fs1.contoso.com/home/ -HomeLinkText Home `


> [!IMPORTANT]
> The `linkText` parameter in this cmdlet is not required unless you use another value than the default, which is *Home*. The advantage of using the default is that they are localized to all client locales. after the sign\-in page is customized, the customization takes precedence; therefore, you should customize for all languages that you want to support.

## Additional references
[AD FS User Sign-in Customization](AD-FS-user-sign-in-customization.md)
