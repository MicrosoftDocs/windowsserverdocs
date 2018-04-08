---
title: User access options with Windows Admin Center
description: User access options and identity providers with Windows Admin Center (Project Honolulu)
ms.technology: manage
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.date: 04/05/2018
ms.localizationpriority: low
ms.prod: windows-server-threshold
---

# User access options with Windows Admin Center

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

When deployed as a service on Windows Server, Windows Admin Center provides a centralized point of management for your server envrionment. By controlling access to Windows Admin Center, you can improve the security of your management landscape.

## Gateway access roles

Windows Admin Center defines two roles for access to the gateway service: gateway users and gateway administrators. 

**Gateway users** can connect to the Windows Admin Center gateway service in order to manage servers through that gateway, but they cannot change access permissions nor the authentication mechanism used to authenticate to the gateway.

**Gateway administrators** can configure who gets access as well as how users will authenticate to the gateway. 

[Configure gateway user and adminstrator access in Windows Admin Center.](../configure/user-access-control.md)

> [!NOTE] 
> Access to the gateway does not imply access to the target servers visible by the gateway. To manage a target server, a user must connect with credentials that have administrative privileges on the target server.

## Identity provider options

Gateway administrators can choose Active Directory/local machine groups or Azure Active Directory as the identity provider for Windows Admin Center. 
[Configure the identity provider used in Windows Admin Center.](../configure/user-access-control.md#choose-the-identity-provider)

### Smartcard authentication
When using Active Directory or local machine groups as the identity provider, you can enforce smartcard authentication by requiring users who access Windows Admin Center to be a member of additional smartcard-based security groups. [Configure smartcard authentication in Windows Admin Center.](../configure/user-access-control.md#active-directory-or-local-machine-groups)

### Conditional access and multi-factor authentication
By choosing Azure AD authentication for the gateway, you can leverage additional security features like conditional access and multi-factor authentication provided by Azure AD. [Learn more about configuring conditional access with Azure Active Directory.](https://docs.microsoft.com/azure/active-directory/active-directory-conditional-access-azure-portal-get-started)


