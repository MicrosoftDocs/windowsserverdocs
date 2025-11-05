---
title: Install the Certification Authority on Windows Server
description: Learn how to install Active Directory Certificate Services so that you can enroll a server certificate to servers.
ms.topic: install-set-up-deploy
author: robinharwood
ms.author: roharwoo
ms.date: 04/15/2025
#customer intent: As a system administrator, I want to install and configure a Certification Authority so that I can issue server certificates for secure communication.
---
# Install the Certification Authority on Windows Server

Follow these steps to set up Active Directory Certificate Services (AD CS). This allows you to issue server certificates for servers running Network Policy Server (NPS), Routing and Remote Access Service (RRAS), or both.

## Prerequisites

- Membership in both the **Enterprise Admins** and the root domain's **Domain Admins** group is the minimum requirement to complete this procedure.

- Before you install Active Directory Certificate Services, **you must name the computer, configure the computer with a static IP address, and join the computer to the domain**.
  - For more information on how to accomplish these tasks, see the Windows Server [Core network components](/windows-server/networking/core-network-guide/core-network-guide).
  - To perform this procedure, the computer on which you're installing AD CS must be joined to a domain where Active Directory Domain Services (AD DS) is installed.

## Install Active Directory Certificate Services using PowerShell

To use Windows PowerShell to install Active Directory Certificate Services, complete the following steps.

1. Open Windows PowerShell and type the following command, and then press ENTER.

    ```powershell
    Install-WindowsFeature -Name ADCS-Cert-Authority -IncludeManagementTools
    ```

1. After AD CS is installed, type the following command and press ENTER.

    ```powershell
    Install-AdcsCertificationAuthority -CAType EnterpriseRootCA  
    ```

For more information about this cmdlet, and its available parameters, see [Install-AdcsCertificationAuthority](/powershell/module/adcsdeployment/install-adcscertificationauthority).

## Install Active Directory Certificate Services using Server Manager

To use Server Manager to install Active Directory Certificate Services, complete the following steps.

1. Log on as a member of both the Enterprise Admins group and the root domain's Domain Admins group.

1. In Server Manager, select **Manage**, and then select **Add Roles and Features** to open the Add Roles and Features Wizard.

1. In **Before You Begin**, select **Next**.

    > [!NOTE]
    > The **Before You Begin** page of the Add Roles and Features Wizard isn't displayed if you have previously selected **Skip this page by default**.

1. In **Select Installation Type**, ensure that **Role-Based or feature-based installation** is selected, and then select **Next**.

1. In **Select destination server**, ensure that **Select a server from the server pool** is selected. In **Server Pool**, ensure that the local computer is selected. Select **Next**.

1. In **Select Server Roles**, in **Roles**, select **Active Directory Certificate Services**. When you're prompted to add required features, select **Add Features**, and then select **Next**.

1. In **Select features**, select **Next**.

1. In **Active Directory Certificate Services**, read the provided information, and then select **Next**.

1. In **Confirm installation selections**, select **Install**. Don't close the wizard during the installation process. When installation is complete, select **Configure Active Directory Certificate Services on the destination server**. The AD CS Configuration wizard opens. Read the credentials information and, if needed, provide the credentials for an account that is a member of the Enterprise Admins group. Select **Next**.

1. In **Role Services**, select **Certification Authority**, and then select **Next**.

1. On the **Setup Type** page, verify that **Enterprise CA** is selected, and then select **Next**.

1. On the **Specify the type of the CA** page, verify that **Root CA** is selected, and then select **Next**.

1. On the **Specify the type of the private key** page, verify that **Create a new private key** is selected, and then select **Next**.

1. On the **Cryptography for CA** page, keep the default settings for CSP (**RSA#Microsoft Software Key Storage Provider**) and hash algorithm (**SHA2**), and determine the best key character length for your deployment. Large key character lengths provide optimal security; however, they can impact server performance and might not be compatible with legacy applications. It's recommended that you keep the default setting of 2048. Select **Next**.

1. On the **CA Name** page, keep the suggested common name for the CA or change the name according to your requirements. Ensure that you're certain the CA name is compatible with your naming conventions and purposes, because you can't change the CA name after you have installed AD CS. Select **Next**.

1. On the **Validity Period** page, in **Specify the validity period**, type the number and select a time value (Years, Months, Weeks, or Days). The default setting of five years is recommended. Select **Next**.

1. On the **CA Database** page, in **Specify the database locations**, specify the folder location for the certificate database and the certificate database log. If you specify locations other than the default locations, ensure that the folders are secured with access control lists (ACLs) that prevent unauthorized users or computers from accessing the CA database and log files. Select **Next**.

1. In **Confirmation**, select **Configure** to apply your selections, and then select **Close**.


