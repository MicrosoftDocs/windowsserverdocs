---
title: Plan Multifactor Authentication for Remote Desktop Services
description: Learn how to plan and deploy Multifactor Authentication (MFA) with Remote Desktop Services (RDS) to enhance security and reduce unauthorized access risks.
ms.topic: concept-article
ai-usage: ai-assisted
ms.author: daknappe
author: dknappettmsft
ms.date: 06/30/2025
---

# Plan multifactor authentication for Remote Desktop Services

Multifactor Authentication (MFA) enhances the security of Remote Desktop Services (RDS) by requiring users to verify their identity through multiple authentication methods. This added layer of protection helps safeguard sensitive resources and reduces the risk of unauthorized access. This article provides an overview of the user experience, architecture components, and security benefits of integrating MFA with RDS, along with planning considerations for deployment.

## User Experience

For your end-users connecting to their desktops and applications, the experience is similar to any other second authentication measure to connect to the desired resource. The process typically involves:

1. Launch a desktop or RemoteApp.

1. Upon connecting to the RD Gateway for secure, remote access, receive a mobile application MFA challenge.

1. Correctly authenticate and get connected to their resources.

## Architecture components

RDS can integrate with Network Policy Server in Windows Server and its extension to Microsoft Entra ID. A typical RDS MFA implementation includes:

- **RD Gateway**: Acts as the entry point for remote connections.
- **Network Policy Server (NPS)**: Processes authentication requests and enforces policies.
- **Microsoft Entra ID**: Provides cloud-based MFA services.
- **NPS Extension**: Bridges on-premises NPS with cloud-based MFA.

For more information, see [Integrate your Remote Desktop Gateway infrastructure using the Network Policy Server (NPS) extension and Microsoft Entra ID](/entra/identity/authentication/howto-mfa-nps-extension-rdg).

When planning your MFA deployment, you should consider the following components:

- **User enrollment**: Plan how users will register their MFA methods.
- **Backup authentication**: Configure alternative methods for users who lose primary devices.
- **Conditional access**: Consider implementing location-based or device-based policies.
- **Network requirements**: Ensure firewall rules allow communication with MFA service endpoints.

## Security Benefits

Implementing MFA with Remote Desktop Services provides:

- **Reduced breach risk**: Even if passwords are compromised, extra verification prevents unauthorized access.
- **Compliance support**: Helps meet regulatory requirements for secure remote access.
- **Centralized management**: Unified MFA policies across cloud and on-premises resources.
- **Audit capabilities**: Detailed logging of authentication attempts and methods used.
