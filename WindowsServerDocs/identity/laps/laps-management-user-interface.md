---
ms.assetid: 20a12d2d-96dc-4e10-ba18-bb1d94ebce4b
title: Windows Local Administrator Password Solution User Interface
description: Windows Local Administrator Password Solution User Interface
author: jsimmons
ms.author: jsimmons
manager: jsimmons
ms.date: 07/04/2022
ms.topic: article
---

# Windows LAPS User Interface

This article describes the Windows Server Active Directory Users and Computers LAPS property page available in Windows LAPS.

## Windows Server Active Directory Users and Computers LAPS property page

The Windows Server Active Directory Users and Computers management snap-in now includes a LAPS property page available on computer objects:

:::image type="content" source="../laps/media/laps-management-user-interface/laps-management-user-interface-property-page.png" alt-text="Screenshot showing the Windows LAPS property page in the Windows Server Active Directory and Users snap-in.":::

You can use the new property page to perform the following actions:

* View the current password expiration time
* Modify the password expiration time
* Expire the password expiration time
* View the current account name and password

> [!IMPORTANT]
> The LAPS property page doesn't support view legacy LAPS passwords or password expiration times.

### Viewing the current password expiration time

When you first bring up the property page for an Active Directory computer, the date-time control will display the current password expiration time. For example:

:::image type="content" source="../laps/media/laps-management-user-interface/laps-management-user-interface-view-password-expiration.png" alt-text="Screenshot showing the current password expiration time on the  Windows LAPS property page in the Windows Server Active Directory and Users snap-in.":::

### Modify the password expiration time

The date-time control can be used to modify the password expiration time. For example:

:::image type="content" source="../laps/media/laps-management-user-interface/laps-management-user-interface-modify-password-expiration.png" alt-text="Screenshot showing a modification of the password expiration time on the  Windows LAPS property page in the Windows Server Active Directory and Users snap-in.":::

Once modified, select OK or Apply to apply the changes.

### Expire the password expiration time

If you just want to immediately expire the password, select the "Expire now" button:

:::image type="content" source="../laps/media/laps-management-user-interface/laps-management-user-interface-expire-password-now.png" alt-text="Screenshot showing the Expire now button on the  Windows LAPS property page in the Windows Server Active Directory and Users snap-in.":::

Then select OK or Apply to apply the changes.

### View the current account name and password

The Account Name and Password fields will be populated assuming you're granted permissions to read (and decrypt) the computer's current LAPS password attribute. You can copy the password to the clipboard using the Copy button, or you can display the password using the Show Password button.

:::image type="content" source="../laps/media/laps-management-user-interface/laps-management-user-interface-copy-show-password.png" alt-text="Screenshot showing the copy and show password functionality on the  Windows LAPS property page in the Windows Server Active Directory and Users snap-in.":::

A warning dialog will appear if you don't have permission to read or decrypt the current password information.

## See also

[Windows LAPS Management](..\laps\laps-management.md)
