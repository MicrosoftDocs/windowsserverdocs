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

## Overview

This article describes the Active Directory Users and Computers LAPS property page available in Windows LAPS.

## Active Directory Users and Computers LAPS property page

The Active Directory Users and Computers management snap-in now includes a LAPS property page available on AD computer objects:

:::image type="content" source="../laps/laps-management-userinterface-aduc-proppage.png" alt-text="Active Directory and Users LAPS property page.":::

You can use the new property page to perform the following actions:

* View the current password expiration time
* Modify the password expiration time
* Expire the password expiration time
* View the current account name and password

> [!IMPORTANT]
> The LAPS property page doesn't support view legacy LAPS passwords or password expiration times.

### Viewing the current password expiration time

When you first bring up the property page for an Active Directory computer, the date-time control will display the current password expiration time. For example:

:::image type="content" source="../laps/laps-management-userinterface-aduc-view_password-expiration.png" alt-text="Active Directory and Users LAPS property page viewing the password expiration time":::

### Modify the password expiration time

The date-time control can be used to modify the password expiration time. For example:

:::image type="content" source="../laps/laps-management-userinterface-aduc-modify-password-expiration.png" alt-text="Active Directory and Users LAPS property page modifying the password expiration time":::

Once modified, select OK or Apply to apply the changes.

### Expire the password expiration time

If you just want to immediately expire the password, select the "Expire now" button:

:::image type="content" source="../laps/laps-management-userinterface-aduc-expire-password-now.png" alt-text="Active Directory and Users LAPS property page immediately expiring the password expiration time":::

Then select OK or Apply to apply the changes.

### View the current account name and password

The Account Name and Password fields will be populated assuming you're granted permissions to read (and decrypt) the computer's current LAPS password attribute. You can copy the password to the clipboard using the Copy button, or you can display the password using the Show Password button.

:::image type="content" source="../laps/laps-management-userinterface-aduc-copy-show-password.PNG" alt-text="Active Directory and Users LAPS property page copy or view passwords":::

A warning dialog will appear if you don't have permission to read or decrypt the current password information.

## Related articles

[Windows LAPS Management](..\laps\laps-management.md)
