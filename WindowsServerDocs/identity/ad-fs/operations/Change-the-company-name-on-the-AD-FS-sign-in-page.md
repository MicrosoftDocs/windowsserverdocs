---
description: "Learn more about: Change the company name on the AD FS sign-in page"
title: Change the  company name on the AD FS sign-in page
ms.date: 02/13/2024
ms.topic: how-to
---
# Change the company name on the AD FS sign-in page

To change the name of the company that is displayed on the sign\-in page, use the following Windows PowerShell cmdlet and syntax. This value is set by default by using the value from the Federation Service display name that you entered during setup.

![change name](media/AD-FS-user-sign-in-customization/ADFS_Blue_Custom1.png)

```powershell
    Set-AdfsGlobalWebContent –CompanyName "Contoso Corp"
```

> [!NOTE]
> You can also use the Windows PowerShell Integrated Scripting Environment \(ISE\) to change the company name. By using the Windows PowerShell ISE, you can display content in a Unicode\-compliant environment. For additional information, see [Introducing the Windows PowerShell ISE](/previous-versions/mt707506(v=msdn.10)).

## Additional references

- [AD FS User Sign-in Customization](AD-FS-user-sign-in-customization.md)
