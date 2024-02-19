---
title: Distribute certificates to Windows devices by using Group Policy
description: Learn how to distribute certificates to Windows devices by using Group Policy.
ms.topic: how-to
author: dknappettmsft
ms.author: wscontent
ms.date: 02/16/2024
---

# Distribute certificates to Windows devices by using Group Policy

You can distribute certificates that chain to a trusted root in an Active Directory domain to Windows devices by using Group Policy.

## Prerequisites

Before you begin, you need:

- A certificate with the private key. If you need to export a certificate, see [Export a certificate with the private key](export-certificate-private-key.md).

- An Active Directory domain with an account that is a member of the **Domain Admins** or **Enterprise Admins** domain security group. For more information about using the appropriate accounts and group memberships, see [Local and Domain Default Groups](/previous-versions/orphan-topics/ws.10/dd728026(v=ws.10)).

## Import certificates to Group Policy

1. On a domain controller, start the **Group Policy Management** snap-in.

1. Find an existing Group Policy Object (GPO) or create a new GPO for the certificate settings. Ensure that the GPO is associated with the domain, site, or organizational unit (OU) where the appropriate user and computer accounts reside.

1. Right-click the GPO, then select **Edit**.

1. In the console tree, open **Computer Configuration > Policies > Windows Settings > Security Settings > Public Key Policies**, right-click **Trusted Root Certification Authorities**, then select **Import**.

1. On the **Welcome to the Certificate Import Wizard** page, select **Next**.

1. On the **File to Import** page, type the path to the appropriate certificate files, for example `\\fs1\c$\fs1.cer`, then select **Next**.

1. On the **Certificate Store** page, select **Place all certificates in the following store**, then select **Next**.

1. On the **Completing the Certificate Import Wizard** page, verify that the information you provided is accurate, then select **Finish**.

1. If you need to Repeat steps 2 through 6 to add more certificates for each of the federation servers in the farm.

1. Once you import one or more certificates, apply the policy to your devices, then restart them for the settings to take effect.
