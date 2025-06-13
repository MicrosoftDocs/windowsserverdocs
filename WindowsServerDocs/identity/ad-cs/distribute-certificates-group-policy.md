---
title: Distribute certificates to Windows devices by using Group Policy
description: Learn how to distribute certificates to Windows devices by using Group Policy.
ms.topic: how-to
author: robinharwood
ms.author: roharwoo
ms.date: 02/16/2024
---

# Distribute certificates to Windows devices by using Group Policy

You can distribute certificates that chain to a trusted root in an Active Directory domain to Windows devices by using Group Policy.

## Prerequisites

Before you begin, you need:

- A certificate with the private key. If you need to export a certificate, see [Export a certificate with its private key](export-certificate-private-key.md).

- An Active Directory domain controller with the **Group Policy Management** snap-in installed, or a device with Remote Server Administration Tools (RSAT) installed that can connect to a domain controller.

- An Active Directory domain with an account that is a member of the **Domain Admins** or **Enterprise Admins** domain security group. For more information about using the appropriate accounts and group memberships, see [Local and Domain Default Groups](/previous-versions/orphan-topics/ws.10/dd728026(v=ws.10)).

## Import certificates to Group Policy

1. On a domain controller or device with RSAT installed, start the **Group Policy Management** snap-in.

1. Find an existing Group Policy Object (GPO) or create a new GPO for the certificate settings. Ensure that the GPO is associated with the domain, site, or organizational unit (OU) where the appropriate user and computer accounts reside.

1. Right-click the GPO, then select **Edit**.

1. In the console tree, open **Computer Configuration > Policies > Windows Settings > Security Settings > Public Key Policies**, right-click the store you want to import the certificate to, such as **Trusted Root Certification Authorities**, then select **Import**.

1. On the screen **Welcome to the Certificate Import Wizard**, select **Next**.

1. For **File to Import**, enter or browse to the path to the appropriate certificate files, for example `\\fs1\c$\fs1.cer`, then select **Next**.

1. For **Private key protection**, enter the password for the private key and select **Include all extended properties**, then select **Next**.

1. For **Certificate Store**, select **Place all certificates in the following store** and browse to the certificate store you want to store the certificate, then select **Next**.

1. Review the summary, then select **Finish**.

1. Once you import the certificate, apply the policy to your devices, then restart them for the settings to take effect.
