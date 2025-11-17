---
title: Configure the Server Certificate Template for Network Remote Access
description: Learn how to configure the server certificate template in Active Directory Certificate Services for Remote Access and Network Policy Server. 
ms.topic: how-to
ai-usage: ai-assisted
ms.author: daknappe
author: dknappettmsft
ms.date: 06/17/2025
---

# Configure the server certificate template for Remote Access and Network Policy Server

This article describes how to configure a server certificate template in Active Directory Certificate Services (AD CS) for use with Remote Access, including RAS Gateway servers, and Network Policy Server (NPS). By following these steps, you can set up automatic certificate enrollment for servers running Remote Access or NPS services, simplifying certificate management and enhancing network security.

When you configure this template, you can specify the servers by Active Directory security group that should automatically receive a server certificate from AD CS.

## Prerequisites

Before you begin, ensure the following prerequisites are met:

- Active Directory Certificate Services (AD CS) is installed and configured with at least one Enterprise Certification Authority (CA).

- A user account that is a member of both the **Enterprise Admins** and the root domain's **Domain Admins** group.

- Servers running the Remote Access service or NPS that are members of the **RAS and IAS Servers** security group in Active Directory.

## Configure the server certificate template

To configure the server certificate template for Remote Access and NPS, follow these steps:

1. On your AD CS server, in Server Manager, select **Tools**, then select **Certification Authority**. The Certification Authority Microsoft Management Console (MMC) opens.

1. In the MMC, double-click the CA name, right-click **Certificate Templates**, then select **Manage**.

1. The Certificate Templates console opens. All of the certificate templates are displayed in the details pane.

1. In the details pane, select the template **RAS and IAS Server**.

1. Select the **Action** menu, then select **Duplicate Template**. The template **Properties** dialog box opens.

1. Select the **Security** tab.

1. On the **Security** tab, for **Group or user names**, select **RAS and IAS servers**.

1. In **Permissions for RAS and IAS servers**, for **Allow**, ensure that **Enroll** is selected, then select the check box for **Autoenroll**. Select **OK**, and close the Certificate Templates MMC.

1. In the Certification Authority MMC, select **Certificate Templates**. On the **Action** menu, select **New**, then select **Certificate Template to Issue**. The **Enable Certificate Templates** dialog box opens.

1. In **Enable Certificate Templates**, select the name of the certificate template that you configured, then select **OK**. For example, if you didn't change the default certificate template name, select **Copy of RAS and IAS Server**, then select **OK**.

1. Close the Certification Authority MMC.

You configured the server certificate template for Remote Access and NPS. This template allows servers in the **RAS and IAS Servers** security group to automatically enroll for a server certificate from the AD CS.

## Next step

[Configure auto-enrollment of certificates for Network Policy Server](configure-server-certificate-auto-enrollment.md).
