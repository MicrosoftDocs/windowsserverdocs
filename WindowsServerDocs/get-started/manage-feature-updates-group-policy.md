---
title: Manage Feature Updates with Group Policy on Windows Server
description: Learn how to manage the offer feature updates with Group Policy on Windows Server 2022 and Windows Server 2019.
author: robinharwood
ms.author: roharwoo
ms.topic: how-to
ms.date: 03/13/2025
appliesto: "✅ <a href=\"https://learn.microsoft.com/windows-server/get-started/windows-server-release-info\" target=\"_blank\">Windows Server 2022</a>, ✅ <a href=\"https://learn.microsoft.com/windows-server/get-started/windows-server-release-info\" target=\"_blank\">Windows Server 2019</a>"
#CustomerIntent: As a Windows Server administrator, I want to manage feature updates with Group Policy so that I can control when Windows Server 2025 is offered to my devices.
---



# Manage Feature Updates with Group Policy on Windows Server

Beginning with Windows Server 2025, Microsoft offers an optional in-place upgrade capability through Windows Update, known as a feature update. The feature update allows organizations to easily perform an in-place upgrade to Windows Server 2025 using Windows Update. The feature update is available to Windows Server 2019 and Windows Server 2022 devices.

In some cases, you might wish to delay this optional update until you evaluate Windows Server 2025 in your test environment. In this article, you learn how to disable the Windows Server 2025 optional feature update using the Targeted Release Vehicle (TRV) settings in Group Policy. To learn more about configuring Group Policy for updates, see [Configure Windows Update for Business via Group Policy](/windows/deployment/update/waas-wufb-group-policy) and [Update Policy CSP](/windows/client-management/mdm/policy-csp-update#targetreleaseversion).

> [!NOTE]
> Feature Update from the Windows Server Setting Dialog in Windows Server 2019 and Windows Server 2022 is temporarily paused.

## Prerequisites

Before you can manage feature updates with Group Policy, you must have following prerequisites in place.

- Your target devices must be running Windows Server 2019 or Windows Server 2022.

- You must have administrative rights to the target device unless you're using Group Policy from an Active Directory Domain Services domain.

If you're applying Group Policy from an Active Directory Domain Services domain, you also need to complete the following prerequisites.

- You must be a member of the Group Policy Administrators group or equivalent.

- You have rights to the target organizational unit (OU) where the Group Policy Object (GPO) will be applied.

- You have a machine with the Active Directory Remote Server Administration Tools (RSAT) installed.

> [!IMPORTANT]
> In some cases Windows Updates can be installed by non-administrative users. To learn more about blocking users from scanning and applying Windows Updates, see [Allow non-administrators to receive update notifications](/windows-server/administration/windows-server-update-services/deploy/4-configure-group-policy-settings-for-automatic-updates#allow-non-administrators-to-receive-update-notifications).

## Disable the Windows Server 2025 Feature Update

To disable the Windows Server 2025 feature update, follow these steps:

1. Sign in to your target device or a machine with the Active Directory Remote Server Administration Tools (RSAT) installed.

1. Open the Group Policy Management Console (GPMC). If you're applying this policy directly to your target device, select **Start**, then type `gpedit.msc`.

1. In the console tree, navigate to **Computer Configuration > Administrative Templates > Windows Components > Windows Updates > Manage updates offered from Windows Update**. If you're applying this policy in an Active Directory environment, the path is **Computer Configuration > Policies > Administrative Templates > Windows Components > Windows Updates > Manage updates offered from Windows Update**.

1. For the policy setting, right-click **Select the target Feature Update version** and select **Edit**. To learn more about the _Select the target Feature Update version_ policy setting, see [GPS: Select the target Feature Update version](https://gpsearch.azurewebsites.net/Default.aspx?PolicyID=15143).

1. Select the **Enabled** radio button.

1. Leave the **Which Windows product version would you like to receive feature updates for?** field blank (empty).

1. Type `hold` into the Target Version for Feature Update field.

1. Select **Apply**, then **OK**.

You have now disabled the Windows Server 2025 feature update on your target devices. If you've created this as a Group Policy Object (GPO), link it to the appropriate organization unit in Active Directory and confirm the policy has been applied.

## Enable the Windows Server 2025 Feature Update

Once you're ready to start rolling out Windows Server 2025, configure policy as follows:

1. Sign in to your target device or a machine with the Active Directory Remote Server Administration Tools (RSAT) installed.

1. Open the Group Policy Management Console (GPMC). If you're applying this policy directly on your target device, select **Start**, then type `gpedit.msc`.

1. In the console tree, navigate to **Computer Configuration > Administrative Templates > Windows Components > Windows Updates > Manage updates offered from Windows Update**. If you're applying this policy in an Active Directory environment, the path is **Computer Configuration > Policies > Administrative Templates > Windows Components > Windows Updates > Manage updates offered from Windows Update**.

1. For the policy setting, right-click **Select the target Feature Update version** and select **Edit**. To learn more about the _Select the target Feature Update version_ policy setting, see [GPS: Select the target Feature Update version](https://gpsearch.azurewebsites.net/Default.aspx?PolicyID=15143).

1. Select the **Enabled** radio button.

1. Leave the **Which Windows product version would you like to receive feature updates for?** field blank (empty).

1. Type `2025` into the Target Version for Feature Update field.

1. Select **Apply**, then **OK**.

You have now enabled the Windows Server 2025 optional feature update on your target devices. If you've created this policy as a Group Policy Object (GPO), link it to the appropriate organization unit in Active Directory and confirm the policy has been applied.

## Related content

Learn more about upgrading to Windows Server 2025 and the policy setting available in the following articles:

- [In-place OS upgrade (feature update)](install-upgrade-migrate.md#in-place-os-upgrade-feature-update)

- [Configure Windows Update for Business via Group Policy](/windows/deployment/update/waas-wufb-group-policy)

- [Update Policy CSP](/windows/client-management/mdm/policy-csp-update#targetreleaseversion)

- [GPS: Select the target Feature Update version](https://gpsearch.azurewebsites.net/Default.aspx?PolicyID=15143)
