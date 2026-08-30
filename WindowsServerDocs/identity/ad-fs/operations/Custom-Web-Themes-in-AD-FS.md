---
description: "Learn more about: Custom Web Themes in AD FS"
title: Custom Web Themes in AD FS
ms.date: 04/08/2025
ms.topic: how-to
---

# Custom Web Themes in AD FS

The theme that is shipped out\-of\-the\-box is called Default. You can export the default theme and use it so that you can start quickly. You can customize the appearance and behavior, which includes the layout by modifying the .css file, import and apply this new theme, and then you can use the customized appearance and behavior. Using the .css file also makes it easier to work with your web designers.

The following cmdlet creates a custom web theme, which duplicates the default web theme.

```powershell
New-AdfsWebTheme –Name custom –SourceName default
```

You can modify the .css file and configure the new web theme by using the new .css file. To export a web theme, use the following cmdlet.

```powershell
Export-AdfsWebTheme –Name custom –DirectoryPath c:\theme
```

To apply the .css file to the new theme, use the following cmdlet.

```powershell
Set-AdfsWebTheme –TargetName custom –StyleSheet @{path="c:\NewTheme.css"}
```

The following cmdlet creates a custom web theme from a new style sheet.

```powershell
New-AdfsWebTheme –Name custom –StyleSheet @{path="c:\NewTheme.css"} –RTLStyleSheetPath c:\NewRtlTheme.css
```

To apply the custom web theme to AD FS, use the following cmdlet.

```powershell
Set-AdfsWebConfig -ActiveThemeName custom
```

To add JavaScript to AD FS, use the following cmdlet.

```powershell
Set-AdfsWebTheme -TargetName custom -AdditionalFileResource @{Uri=' /adfs/portal/script/onload.js';path="D:\inetpub\adfsassets\script\onload.js"}
```

## Additional references

[AD FS User Sign-in Customization](AD-FS-user-sign-in-customization.md)
