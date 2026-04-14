---
description: "Learn more about: Add Privacy Link"
title: Add Privacy Link
ms.date: 02/13/2024
ms.topic: how-to
---

# Add Privacy Link


To add the privacy link that is displayed on the sign\-in page, use the following Windows PowerShell cmdlet and syntax.

![add privacy link](media/AD-FS-user-sign-in-customization/ADFS_Blue_Custom2.png)


`Set-AdfsGlobalWebContent -PrivacyLink https://fs1.contoso.com/privacy/ -PrivacyLinkText Privacy`


> [!IMPORTANT]
> The `linkText` parameter in this cmdlet is not required unless you use another value than the default, which is *Privacy*. The advantage of using the default is that the pages are localized to all client locales. After the sign\-in page is customized, the customization takes precedence; therefore, you should customize for all languages that you want to support. All customized content takes a locale parameter. When you configure localized content, you should configure it with a country\-less locale first, for example, "en", before you configure country and region\-specific locale, such as "en\-us".

## Additional references
[AD FS User Sign-in Customization](AD-FS-user-sign-in-customization.md)
