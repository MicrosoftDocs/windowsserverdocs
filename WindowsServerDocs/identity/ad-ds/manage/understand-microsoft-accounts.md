---
title: Microsoft accounts
description: Learn how to create and manage a local or domain Microsoft account. 
author: dansimp
ms.author: dansimp
ms.topic: article
ms.date: 08/02/2022
---

# Microsoft accounts

> Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

Understand how a Microsoft account works to enhance security and privacy for users and how you can manage consumer account types in your organization.

## What is a Microsoft account?

Microsoft sites, services, properties, and computers running Windows 10 can use a Microsoft account as a way to identify a user. A Microsoft account previously was called a Windows Live ID. A Microsoft account has user-defined secrets and consists of a unique email address and a password.

When a user signs in with a Microsoft account, the device is connected to cloud services. The user can share many of their settings, preferences, and apps across devices.

## How a Microsoft account works

A user can use a Microsoft account to sign in to websites that support this service by using a single set of credentials. A user's credentials are validated by a Microsoft account authentication server that's associated with a website. Microsoft Store is an example of this association. When a new user signs in to a website that's enabled to use Microsoft accounts, the user is redirected to the nearest authentication server, which asks for a username and password. Windows uses the Schannel Security Support Provider to open a Transport Level Security/Secure Sockets Layer (TLS/SSL) connection for this function. Users have the option to use Credential Manager to store their credentials.

When a user signs in to a website that's enabled to use a Microsoft account, a time-limited cookie is installed on their computer. The cookie includes a triple-DES encrypted ID tag. The encrypted ID tag has been agreed upon between the authentication server and the website. The ID tag is sent to the website, and the website places another time-limited encrypted HTTP cookie on the user’s computer. While the cookie is valid, the user isn't required to enter a username and password. If a user actively signs out of their Microsoft account, these cookies are removed.

> [!NOTE]
> Local Windows account functionality is still an option you can use in a managed environment.

### How a Microsoft account is created

To prevent fraud, the Microsoft system verifies a user's IP address when the user creates a Microsoft account. A user who tries to create multiple Microsoft accounts by using the same IP address is stopped from creating more accounts. Microsoft accounts aren't designed to be created in batches, such as for a group of domain users in your enterprise.

To create a Microsoft account, a user has two options:

- **Use an existing email address**. The user can use their valid email address to sign up for a Microsoft account. The service turns the requesting user's email address into a Microsoft account. The user can choose a separate password to use for the Microsoft account.

- **Sign up for a Microsoft email address**. A user can sign up for an email account through Microsoft webmail services. The user can use the account to sign in to websites that are enabled to use Microsoft accounts.

### How Microsoft account information is safeguarded

Credential information is encrypted twice. The first encryption is based on the account password. Credentials are encrypted again when they're sent across the internet. The credential data that's stored isn't available to other Microsoft services or to non-Microsoft services.

- **A strong password is required**. Blank passwords aren't allowed.

    For more information, see [How to help keep your Microsoft account safe and secure](https://support.microsoft.com/account-billing/how-to-help-keep-your-microsoft-account-safe-and-secure-628538c2-7006-33bb-5ef4-c917657362b9).

- **Secondary proof of identity is required**. Before a user can access user profile information and settings on a second supported Windows computer for the first time, trust must be established for that device. To establish trust, the user must provide secondary proof of identity. The user can prove their identity by entering a code that's sent to a mobile phone number or by following the instructions that are sent to an alternate email address that a user specifies in the account settings.

- **All user profile data is encrypted on the client before it's transmitted to the cloud**. User data doesn't roam over a wireless wide area network by default so that profile data is protected. All data and settings that leave a device are transmitted through the TLS/SSL protocol.

### Microsoft account security information

A user can add security information to their Microsoft account through the Accounts interface on computers running supported versions of Windows. In Accounts, the user can update the security information that they provided when they created their account. This security information includes an alternate email address or phone number so that if their password is compromised or forgotten, a verification code can be sent to verify their identity. A user can potentially use their Microsoft account to store corporate data on a personal OneDrive or email app. A safe practice is for the account owner to keep this security information up-to-date.

## Microsoft accounts in the enterprise

Although the Microsoft account was designed to serve consumers, you might have situations in which your domain users might benefit by using their personal Microsoft account in your enterprise. The following list describes some advantages:

- **Download Microsoft Store apps**. If your enterprise chooses to distribute apps or software through Microsoft Store, an enterprise user can use a Microsoft account to download and use the apps on up to five devices running any version of Windows 10, Windows 8.1, Windows 8, or Windows RT.

- **Single sign-on**. An enterprise user can use Microsoft account credentials to sign in to devices running Windows 10, Windows 8.1, Windows 8, or Windows RT. In this scenario, Windows works with your Microsoft Store app to provide an authenticated experience in the app. A user can associate a Microsoft account with their sign-in credentials for Microsoft Store apps or websites so that these credentials roam across any devices that run these supported versions.

- **Personalized settings synchronization**. A user can associate their most commonly used operating system settings with a Microsoft account. These settings are available whenever a user signs in with that account on any device that's running a supported version of Windows and connected to the cloud. After a user signs in, the device automatically attempts to get the user's settings from the cloud and apply them to the device.

- **App synchronization**. Microsoft Store apps can store user-specific settings so that these settings are available to any device. As with operating system settings, these user-specific app settings are available whenever the user signs in with the same Microsoft account on any device that's running a supported version of Windows and connected to the cloud. After the user signs in, that device automatically downloads the settings from the cloud and applies them when the app is installed.

- **Integrated social media services**. Contact information and status for a user's friends and associates automatically stay up-to-date from sites such as Outlook, Facebook, Twitter, and LinkedIn. A user also can access and share photos, documents, and other files from sites like OneDrive, Facebook, and Flickr.

### Manage Microsoft accounts in the domain

Depending on your IT and business models, introducing Microsoft accounts into your enterprise might add complexity or it might provide solutions. You should address the following considerations before you allow the use of these account types in your enterprise:

- [Restrict the use of Microsoft accounts](#restrict-the-use-of-microsoft-accounts)

- [Configure connected accounts](#configure-connected-accounts)

- [Provision Microsoft accounts in the enterprise](#provision-microsoft-accounts-in-the-enterprise)

- [Audit account activity](#audit-account-activity)

- [Reset a password](#reset-a-password)

- [Restrict app installation and usage](#restrict-app-installation-and-usage)

### Restrict the use of Microsoft accounts

The following Group Policy settings help control the use of Microsoft accounts in the enterprise:

- [Apps and services: Block Microsoft account user authentication](#apps-and-services-block-microsoft-account-user-authentication)

- [Accounts: Block Microsoft accounts](#accounts-block-microsoft-accounts)

#### Apps and services: Block Microsoft account user authentication

This setting controls whether a user can provide a Microsoft account for authentication for an app or service.

If this setting is enabled, all apps and services on a device are prevented from using a Microsoft account for authentication. This setting applies both to existing device users and to any new users.

Any app or service that has already authenticated a user who used a Microsoft account isn't affected by enabling this setting until the authentication cache expires. We recommend that you enable this setting before any user signs in to a device to prevent cached tokens from authenticating a Microsoft account.

If this setting is disabled or not configured, apps and services can use a Microsoft account for authentication. This setting is disabled by default.

This setting doesn't affect whether a user can sign in to a device by using a Microsoft account or the ability of a user to provide a Microsoft account via the browser for authentication with a web-based app.

The path to this setting is *Computer Configuration\Administrative Templates\Windows Components\Microsoft account*.

#### Accounts: Block Microsoft accounts

This setting prevents using the Settings app to add a Microsoft account for single sign-on authentication for Microsoft services and some background services or using a Microsoft account for single sign-on to other apps or services.

If this setting is enabled, a user has two options:

- **The user can't add a Microsoft account**. Existing connected accounts can still sign in to the device (and they appear on the **Sign in** page). However, a user can't use the Settings app to add a new connected account or to connect a local account to a Microsoft account.

- **The user can’t add or sign in with a Microsoft account**. A user can't add a new connected account (or connect a local account to a Microsoft account) or use an existing connected account through Settings.

This setting doesn't affect adding a Microsoft account for app authentication. For example, if this setting is enabled, a user can still provide a Microsoft account for authentication with an app like Mail, but the user can't use the Microsoft account for single sign-on authentication for other apps or services. For other apps and services, the user is prompted to authenticate.

This setting isn't configured by default.

The path to this setting is *Computer Configuration\Windows Settings\Security Settings\Local Policies\Security Options*.

### Configure connected accounts

A user can connect a Microsoft account to their domain account and sync the settings and preferences between the accounts. By syncing settings and preferences between accounts, the user sees the same desktop background, app settings, browser history and favorites, and other Microsoft account settings on their other devices.

### Disconnect a connected account

A user can disconnect a Microsoft account from their domain account at any time: In **PC settings**, select **Users** > **Disconnect** > **Finish**.

> [!NOTE]
> Connecting a Microsoft account to a domain account might limit access to some high-privileged tasks in Windows. For example, Task Scheduler  evaluates the connected Microsoft account for access and fails. In this scenario, the account owner should disconnect the account.

### Provision Microsoft accounts in the enterprise

A Microsoft account is a private user account. Microsoft doesn't provide a way to provision Microsoft accounts for an enterprise. Enterprises should use domain accounts.

### Audit account activity

Because a Microsoft account is internet-based, Windows doesn't have a way to audit a Microsoft account unless the account is associated with a domain account. You can't audit the activity of accounts that aren't associated with your domain because a user can disconnect the account or leave the domain at any time.

### Reset a password

Only the owner of a Microsoft account can change the password that's associated with the account. A user can change the password for their Microsoft account in the [Microsoft account sign-in portal](https://login.live.com).

### Restrict app installation and usage

Within your organization, you can set application control policies to regulate app installation and usage for Microsoft accounts. For more information, see [AppLocker](/windows/device-security/applocker/applocker-overview) and [Packaged apps and packaged app installer rules in AppLocker](/windows/device-security/applocker/packaged-apps-and-packaged-app-installer-rules-in-applocker).

## See also

- [Manage privacy: Using a Microsoft account to sign in and resulting internet communication](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj884082(v=ws.11))

- [Access control overview](/windows/security/identity-protection/access-control/access-control)
