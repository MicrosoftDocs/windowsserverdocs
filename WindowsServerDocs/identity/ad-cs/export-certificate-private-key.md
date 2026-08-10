---
title: Export a certificate with its private key in Windows Server
description: Learn how to export a certificate with its private key.
ms.topic: how-to
author: robinharwood
ms.author: roharwoo
ms.date: 5/14/2025
---

# Export a certificate with its private key

If you already have a certificate installed on a Windows device and you want to install the same certificate on a Windows device that requires a private key, you can export the certificate with the private key. This article describes how to export a certificate from the Windows certificate stores of the local computer with the private key.

## Prerequisites

Before you begin, you need:

- A certificate installed with the private key to a certificate store of the local computer.

- An Active Directory domain with an account that is a member of the **Domain Admins** or **Enterprise Admins** domain security group. For more information about using the appropriate accounts and group memberships, see [Active Directory security groups](/windows-server/identity/ad-ds/manage/understand-security-groups).

## Export a certificate from the Windows certificate stores with the private key

To export a certificate from the Windows certificate stores with the private key:

1. Open the certificate management console for the local computer by running the following command. Some methods of running this command are from the *Start menu*, the Windows *Run* prompt, PowerShell prompt, or command prompt.

   ```cmd
   certlm.msc
   ```

1. In the console tree, navigate to the certificate you want to export.

1. Right-click the certificate, select **All Tasks**, and then select **Export**.

1. On the screen **Welcome to the Certificate Export Wizard**, select **Next**.

1. To export the private key, select **Yes, export the private key**, then select **Next**.

1. For the file format, select **Personal Information Exchange - PKCS #12 (.PFX)**. Check the box for **Include all certificates in the certification path if possible**, to include the whole certificate chain, then select **Next**.

1. Check the box to enter and confirm a password to protect the private key, and select **AES256-SHA256** for the encryption method, then select **Next**. It's important to guard the security of the private key.

1. Enter or browse to the file path, then select **Next**.

1. Review the summary, then select **Finish**.

Once the certificate is exported, you can import it to another device that requires the certificate with private key.

## Related content

- [Distribute certificates to Windows devices by using Group Policy](distribute-certificates-group-policy.md)

