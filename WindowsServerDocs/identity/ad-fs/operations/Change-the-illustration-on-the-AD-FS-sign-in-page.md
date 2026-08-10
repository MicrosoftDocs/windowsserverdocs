---
description: "Learn more about: Change the illustration on the AD FS sign-in page"
title: Change the illustration on the AD FS sign-in page
ms.date: 02/13/2024
ms.topic: how-to
---
# Change the illustration on the AD FS sign-in page

To change the illustration, the graphic on the left, which is displayed on the sign\-in page, use the following Windows PowerShell cmdlet and syntax.

![change illustration](media/AD-FS-user-sign-in-customization/ADFS_Blue_Custom2.png)

> [!IMPORTANT]
> We recommend the dimensions for the illustration to be 1420x1080 pixels @ 96 DPI for displays with 1080p resolution in **jpg** or **png** format. A file size of no greater than 200 KB to 500 KB to improve load times.

```powershell
Set-AdfsWebTheme -TargetName default -Illustration @{path="c:\Contoso\illustration.png"}
```

## Additional references

[AD FS User Sign-in Customization](AD-FS-user-sign-in-customization.md)
