---
title: AD FS paginated sign-in
description: This article describes new sign-in experience for AD FS.
author: billmath
ms.author: billmath
ms.date: 08/15/2023
ms.topic: article
---
# AD FS paginated sign-in

Applies to: Windows Server 2019

The user interface for sign-in is updated in Windows Server 2019 to feature a look and feel identical to Microsoft Entra ID. This update provides users with a more consistent sign-in experience that incorporates a centered and paginated user flow.

## What's new

In AD FS in Windows Server 2012 R2 and 2016, your sign-in screen looked something like this:

![Screenshot of the old Sign in screen.](media/AD-FS-paginated-sign-in/signin1.png)

Instead of displaying a single form located on the right side of the screen, Windows Server 2019 sign-in features several design updates, including:

- **Centered UI**. In earlier versions, the sign-in UI displays on the right side of the screen, as shown in the previous screenshot. The UI is now positioned front and center to modernize the experience.
- **Pagination**. Instead of a long form to fill out, a new flow takes you through the sign-in experience step-by-step. Our research shows that with this approach, our customers have more successful sign-ins. It also enables more flexibility for incorporating various authentication methods, such us phone factor authentication.

![Screenshot of the new Sign in screen.](media/AD-FS-paginated-sign-in/signin2.png)

On the first page, you're asked to enter your username. You can also select the option to “Keep me signed in” to reduce the frequency of sign-in prompts and remain signed in when it's safe to do so. (This option is disabled by default.)

![Screenshot of the first page of the new Sign in screen.](media/AD-FS-paginated-sign-in/signin3.png)

On the second page, you're presented with authentication options, configured by your administrator. If allowing external authentication as primary is enabled, that is also included.

![Screenshot of the second page of the new Sign in screen.](media/AD-FS-paginated-sign-in/signin4.png)

On the third page, you're asked to enter your password (assuming you selected “Password” as your authentication option).

### Upgrading to paginated sign-in

New installations of AD FS receive the new sign-in UI by default.

If you're an existing customer using AD FS 2012 R2 or 2016, there are two ways to receive the new UI design after upgrading servers to AD FS 2019 and enabling the FBL to 2019.

- Allow the new sign-in via PowerShell. Run the following command to enable pagination:

 ``Set-AdfsGlobalAuthenticationPolicy -EnablePaginatedAuthenticationPages $true``

 - Enable external authentication as primary, either via PowerShell or through the AD FS Server Manager. The new paginated sign-in pages are enabled when this feature is enabled.

If you're a new customer to AD FS, you receive the new design by default. However, if you're using AD FS 2012 R2 or 2016, there are several steps you need to take to receive the new design:

``Set-AdfsGlobalAuthenticationPolicy -AllowAdditionalAuthenticationAsPrimary $true``

## Customization

Options for customization still work in AD FS 2019.

## Related links

- If you don't plan to upgrade your servers to AD FS 2019, but still want to enjoy the new sign-in design: [Using a Microsoft Entra UX Web Theme in Active Directory Federation Services](azure-ux-web-theme-in-ad-fs.md)
- Customization guidance: [AD FS user sign-in customization](ad-fs-user-sign-in-customization.md)
