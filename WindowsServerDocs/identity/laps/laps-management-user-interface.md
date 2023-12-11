---
title: Set up Windows LAPS in the LAPS properties dialog
description: Learn how to use the LAPS properties dialog to configure Windows Local Administrator Password Solution (Windows LAPS) for Windows Server Active Directory.
author: jay98014
ms.author: jsimmons
ms.date: 07/04/2022
ms.topic: conceptual
---

# Set up Windows LAPS in the LAPS properties dialog

Learn how to use the LAPS properties dialog in the Windows Server Active Directory Users and Computers management snap-in to configure Windows Local Administrator Password Solution (Windows LAPS) for Windows Server Active Directory.

> [!IMPORTANT]
> For more information on specific OS updates required to use the Windows LAPS feature, and the current status of the Microsoft Entra LAPS scenario, see [Windows LAPS availability and Microsoft Entra LAPS public preview status](laps-overview.md#windows-laps-supported-platforms-and-azure-ad-laps-preview-status).

## Windows LAPS snap-in availability

The Windows LAPS-enabled Active Directory Users and Computers management snap-in is available on Windows Server platforms that have been patched with the Windows LAPS feature. The Active Directory Users and Computers management snap-in must be installed, either as part of the larger `Active Directory Domain Services` role, or as part of the `AD DS Snap-in and Command-Line Tools` individual feature.

One way to install the `AD DS Snap-Ins and Command-Line Tools` feature is from the command line as follows:

```
dism.exe /online /enable-feature:DirectoryServices-DomainController-Tools /all
```

The Windows LAPS-enabled Active Directory Users and Computers management snap-in is available on supported Windows Client platforms that have been patched with the Windows LAPS feature, via Remote Server Administration Tools (RSAT). You may install RSAT on client platforms by going to Settings, then Apps, then Optional Features, and then install RSAT (specifically search for and install "RSAT: Active Directory Domain Services and Lightweight Directory Services Tools").

The Windows LAPS-enabled Active Directory Users and Computers management snap-in isn't available on older platforms that don't support Windows LAPS. The older Remote Server Administration tools package is not updated to support the new snap-in.

## LAPS properties dialog in the management snap-in

The Windows Server Active Directory Users and Computers management snap-in includes a LAPS properties dialog that's available for computer objects:

:::image type="content" source="./media/laps-management-user-interface/laps-management-user-interface-property-page.png" alt-text="Screenshot that shows the Windows LAPS properties dialog in the Windows Server Active Directory Users and Computers snap-in.":::

You can use the properties dialog to complete the following actions:

- View the current password expiration time.
- Modify the password expiration time.
- Expire the password expiration time.
- View the current account name and password.

> [!IMPORTANT]
> The LAPS properties dialog doesn't support viewing legacy Microsoft LAPS passwords or password expiration times.

### View the current password expiration time

When you first go to the properties dialog for a Windows Server Active Directory computer, the date-time control displays the current password expiration time. For example:

:::image type="content" source="./media/laps-management-user-interface/laps-management-user-interface-view-password-expiration.png" alt-text="Screenshot that shows the current password expiration time in the Windows LAPS properties dialog in the Windows Server Active Directory Users and Computers snap-in.":::

### Modify the password expiration time

You can use the date-time control to modify the password expiration time. For example:

:::image type="content" source="./media/laps-management-user-interface/laps-management-user-interface-modify-password-expiration.png" alt-text="Screenshot that shows a modification of the password expiration time in the Windows LAPS properties dialog in the Windows Server Active Directory Users and Computers snap-in.":::

If you modify the date or time, select **Apply**, and then select **OK**.

### Manually expire the password

To immediately expire the password, select **Expire now**:

:::image type="content" source="./media/laps-management-user-interface/laps-management-user-interface-expire-password-now.png" alt-text="Screenshot that shows the Expire now button in the Windows LAPS properties dialog in the Windows Server Active Directory Users and Computers snap-in.":::

Select **Apply**, and then select **OK**.

### View the current account name and password

If you have permissions to read and decrypt the computer's current Windows LAPS password attribute, **Account Name** and **Password** have your username and password. Select **Copy password** to copy the password to the clipboard. Select **Show password** to show the password.

:::image type="content" source="./media/laps-management-user-interface/laps-management-user-interface-copy-show-password.png" alt-text="Screenshot that shows the copy and show password functionality in the Windows LAPS properties dialog in the Windows Server Active Directory Users and Computers snap-in.":::

If you don't have permissions to read or decrypt the current password information, a dialog displays a warning.

> [!IMPORTANT]
> The Active Directory Users and Computers management snap-in only supports viewing the most recently stored password. In order to query older passwords (assuming you enabled password history), you must use the `Get-LapsADPassword` PowerShell cmdlet.

## Next steps

- [Windows LAPS schema extensions reference](laps-technical-reference.md)
- [Key concepts in Windows LAPS](laps-concepts.md)
