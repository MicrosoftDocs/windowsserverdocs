---
title: Settings
description: Learn about settings in Windows Admin Center (Project Honolulu). User settings let users change their language/region and other preferences. Gateway settings let administrators configure the gateway.
ms.topic: article
author: IngridAtMicrosoft
ms.author: wscontent
ms.date: 04/12/2018
---

# Windows Admin Center Settings

>Applies to: Windows Admin Center

Windows Admin Center settings consist of user-level and gateway-level settings. A change to a user-level setting only affects the current user's profile, while a change to a gateway-level setting affects all users on that Windows Admin Center gateway.

## User settings

User-level settings consist of the following sections:

- Account
- Language/Region
- Personalization
- Suggestions

In the **Account** tab, users can review the credentials they have used to authenticate to Windows Admin Center. If Microsoft Entra ID is configured to be the identity provider, the user can log out of their Microsoft Entra account from this tab.

In the **Language/Region** tab, users can change the language and region formats displayed by Windows Admin Center.

In the **Personalization** tab, users can toggle to a dark UI theme.

In the **Suggestions** tab, users can toggle suggestions about Azure services and new features.

## Development settings
Development settings in Windows Admin Center consist of the following sections:

- Advanced
- Performance profile

The **Advanced** tab gives Windows Admin Center extension developers additional capabilities.

The **Performance profile** tab lets you collect performance data about your Windows Admin Center session.

## Gateway settings

Gateway-level settings consist of the following sections:

- Access
- Diagnostics & feedback
- Extensions
- General
- Internet Access
- Proxy
- Register
- Updates
- Shared Connections
- WebSocket validation

Only gateway administrators are able to see and change these settings. Changes to these settings change the configuration of the gateway and affect all users of the Windows Admin Center gateway.

The **Access** tab lets administrators configure who can access the Windows Admin Center gateway, as well as the identity provider used to authenticate users. [Learn more about controlling access to the gateway.](user-access-control.md)

In the **Diagnostics & feedback** tab, users can choose how much diagnostic data they want to send to Microsoft.

In the **Extensions** tab, administrators can install, uninstall, or update gateway extensions. [Learn more about extensions.](using-extensions.md)

In the **General** tab, users can select to have their UI session of Windows Admin Center expire after some period of inactivity.

The **Internet Access** tab lets administrators configure who can access the Windows Admin Center gateway, as well as the identity provider used to authenticate users. [Learn more about controlling access to the gateway.](user-access-control.md)

The **Proxy** tab allows users to configure a proxy server to redirect all Windows Admin Center outbound traffic.

From the **Register** tab, administrators can register the gateway with Azure to enable [Azure integration features](../azure/azure-integration.md) in Windows Admin Center.

Using the **Updates** tab, users can see which version of Windows Admin Center is running and if this version is up to date.

Using the **Shared Connections** tab, administrators can configure a single list of connections to be shared across all users of the Windows Admin Center gateway. [Learn more about configuring connections once for all users of a gateway.](shared-connections.md)

For **WebSocket validation**, administrators can now validate their WebSocket connections and customize these settings to various conditions. [Learn more about WebSocket validation](websocket-validation.md)
