---
title: Settings
description: Learn about settings in Windows Admin Center (Project Honolulu). User settings let users change their language/region and other preferences. Gateway settings let administrators configure the gateway.
ms.technology: manage
ms.topic: article
author: haley-rowland
ms.author: harowl
ms.date: 09/19/2018
ms.localizationpriority: medium
ms.prod: windows-server-threshold
---

# Settings

> Applies To: Windows Admin Center

Windows Admin Center settings consist of user-level and gateway-level settings. A change to a user-level setting only affects the current user’s profile, while a change to a gateway-level setting affects all users on that Windows Admin Center gateway.

## User settings

User-level settings consist of the following sections:

- Account
- Language/Region
- Suggestions

In the **Account** tab, users can review the credentials they have used to authenticate to Windows Admin Center. If Azure AD is configured to be the identity provider, the user can log out of their Azure AD account from this tab.

In the **Language/Region** tab, users can change the language and region formats displayed by Windows Admin Center.

In the **Suggestions** tab, users can toggle suggestions about Azure services and new features.

## Gateway settings

Gateway-level settings consist of the following sections:

- Extensions
- Access
- Azure

Only gateway administrators are able to see and change these settings. Changes to these settings change the configuration of the gateway and affect all users of the Windows Admin Center gateway.

In the **Extensions** tab, administrators can install, uninstall, or update gateway extensions. [Learn more about extensions.](using-extensions.md)

The **Access** tab lets administrators configure who can access the Windows Admin Center gateway, as well as the identity provider used to authenticate users. [Learn more about controlling access to the gateway.](user-access-control.md)

From the **Azure** tab, administrators can register the gateway with Azure to enable [Azure integration features](azure-integration.md) in Windows Admin Center.