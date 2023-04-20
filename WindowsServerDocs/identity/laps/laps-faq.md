---
title: Windows LAPS FAQ
description: Get answers to frequently asked questions about Windows LAPS.
author: jay98014
ms.author: jsimmons
ms.date: 04/20/2023
ms.topic: faq
---

# Windows LAPS frequently asked questions

This section provides answers to many commonly asked questions about Windows LAPS.

## I only want to use legacy Microsoft LAPS - how can I uninstall Windows LAPS?

Windows LAPS is considered a Windows baseline security feature and can't be uninstalled. To prevent any chance of conflict between the two features, you should first avoid configuring or applying any new Windows LAPS policies, and also [Disable legacy LAPS emulation mode](/windows-server/identity/laps/laps-scenarios-legacy#disabling-legacy-microsoft-laps-emulation-mode).

## Is it supported to run legacy Microsoft LAPS side-by-side with Windows LAPS?

Yes this scenario is supported with the following conditions. A new Windows LAPS policy must be configured, and you must take care to configure Windows LAPS and the legacy LAPS to manage different local accounts.

## Is it supported to run 3rd-party local account password manager products side-by-side with Windows LAPS?

Yes this scenario is supported with the following condition. You must take care to configure Windows LAPS and the 3rd-party product to manage different local accounts. If you mistakenly configure both to manage the same account, Windows LAPS rejects attempts by the 3rd-party product to modify the account's password with a STATUS_POLICY_CONTROLLED_ACCOUNT\ERROR_POLICY_CONTROLLED_ACCOUNT error. Each such rejection is noted with a 10031 event in the Windows LAPS event log channel.

## Why isn't the Windows LAPS PowerShell module hosted on GitHub, PowerShell Gallery, or similar?

The Windows LAPS PowerShell module is a native part of Windows and not available outside of Windows. Many of the Windows LAPS PowerShell cmdlets are tightly integrated with Windows and such an effort doesn't make sense.

## How can I copy the Windows LAPS PowerShell module to an older operating system?

This scenario isn't supported.

## How can I copy the Windows LAPS-enabled Active Directory User and Computers snap-in to an older operating system?

This scenario isn't supported.

## Microsoft promotes a password-less strategy and direction. Why was a password-based feature like Windows LAPS built?

All Windows LAPS scenarios involve the management of a Windows local account's password for use in help desk, device recovery, and other scenarios. Since Windows only supports password-based authentication for local accounts, password management is necessary.

## See also

[Legacy Microsoft LAPS](https://www.microsoft.com/download/details.aspx?id=46899)

## Next steps

If you have a Windows LAPS question that isn't answered here, submit a Feedback item - thank you!
