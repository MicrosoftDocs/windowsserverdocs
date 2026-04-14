---
description: "Learn more about: Prepare Client Computers in the Account Partner"
title: Prepare Client Computers in the Account Partner
ms.date: 04/08/2025
ms.topic: concept-article
---

# Prepare Client Computers in the Account Partner

The easiest way for an administrator in an account partner organization to prepare client computers for access to Active Directory Federation Services \(AD FS\) federated applications is to use Group Policy. Group Policy provides a convenient way for you to push specific certificates and settings that are required for federation to all the client computers that will be used to access federated applications.

So that your client computers can seamlessly access federated applications without certificate prompts or trusted site–related prompts, we recommend that you first prepare each client computer before you deploy AD FS broadly in your organization. Consider using Group Policy to automatically:

-   Configure Internet Explorer on each client computer to trust the account federation server.

    For more information, see [Configure Client Computers to Trust the Account Federation Server](../../ad-fs/deployment/Configure-Client-Computers-to-Trust-the-Account-Federation-Server.md).

-   Install the appropriate account federation server, resource federation server, and Web server Secure Sockets Layer \(SSL\) certificates \(or equivalent certificates that chain to a trusted root\) on each client computer.

    For more information, see [Distribute Certificates to Client Computers by Using Group Policy](../../ad-fs/deployment/Distribute-Certificates-to-Client-Computers-by-Using-Group-Policy.md).


## See Also
[AD FS Design Guide in Windows Server 2012](AD-FS-Design-Guide-in-Windows-Server-2012.md)
