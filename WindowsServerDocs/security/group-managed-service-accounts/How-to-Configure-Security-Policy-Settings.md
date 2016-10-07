---
title: How to Configure Security Policy Settings
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 88404e6d-218a-41fe-8687-a453fc066624
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# How to Configure Security Policy Settings

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This procedural topic for the IT professional describes steps to configure a security policy setting on the local computer, on a domain-joined computer, and on a domain controller.

This topic pertains to the versions of Windows designated in the **Applies To** list above. Some of the user interface elements that are described in this topic might differ from version to version.

You must have Administrators rights on the local computer, or you must have the appropriate permissions to update a Group Policy Object (GPO) on the domain controller to perform these procedures.

When a local setting is inaccessible, it indicates that a GPO currently controls that setting.

**In this topic**

-   [Configure a setting for your local computer](#BKMK_Local)

-   [Configure a setting for a computer that is joined to a domain](#BKMK_Domain)

-   [Configure a setting for a domain controller](#BKMK_DC)

#### <a name="BKMK_Local"></a>To configure a setting for your local computer

1.  To open Local Security Policy, on the **Start** screen, type,   **secpol.msc**.

2.  Navigate the console tree to Local Computer Policy\Windows Settings\Security Settings

3.  Under **Security Settings** of the console tree, do one of the following:

    -   Click **Account Policies** to edit the **Password Policy** or **Account Lockout Policy**.

    -   Click **Local Policies** to edit an **Audit Policy**, a **User Rights Assignment**, or **Security Options**.

4.  When you find the policy setting in the details pane, double-click the security policy that you want to modify.

5.  Modify the security policy setting, and then click **OK**.

    > [!NOTE]
    > -   Some security policy settings require that the computer be restarted before the setting takes effect.
    > -   Any change to the user rights assignment for an account becomes effective the next time the owner of the account logs on.

#### <a name="BKMK_Domain"></a>To configure a setting for computer that is joined to a domain
The following procedure describes how to configure a security policy setting for a Group Policy Object when you are on a workstation or server that is joined to a domain.

You must have the appropriate permissions to install and use the Microsoft Management Console (MMC), and to update a Group Policy Object (GPO) on the domain controller to perform these procedures.

1.  To open the MMC and add the Group Policy Object Editor, on the **Start** screen, type**mmc.msc**.

2.  On the **File** menu of the MMC, click **Add/Remove snap-in**, and then click **Add**.

3.  In **Add Standalone Snap-in**, double-click **Group Policy Object Editor**.

4.  In **Select Group Policy Object**, click **Browse**, browse to the GPO you would like to modify, and then click **Finish**.

5.  Click **Close**, and then click **OK**.

    This procedure added the snap-in to the MMC.

6.  In the console tree, locate *GroupPolicyObject [ComputerName]* Policy, click **Computer Configuration**, click **Windows Settings**, and then click **Security Settings**.

7.  Do one of the following:

    -   Click **Account Policies** to edit the **Password Policy** or **Account Lockout Policy**.

    -   Click **Local Policies** to edit an **Audit Policy**, a **User Rights Assignment**, or **Security Options**.

    -   Click **Event Log** to edit event log settings.

8.  In the details pane, double-click the security policy setting that you want to modify.

    > [!NOTE]
    > If this security policy has not yet been defined, select the **Define these policy settings** check box.

9. Modify the security policy setting and then click **OK**.

#### <a name="BKMK_DC"></a>To configure a setting for a domain controller
The following procedure describes how to configure a security policy setting for only a domain controller (from the domain controller).

1.  To open the domain controller security policy, in the console tree, locate *GroupPolicyObject [ComputerName]* Policy, click **Computer Configuration**, click **Windows Settings**, and then click **Security Settings**.

2.  Do one of the following:

    -   Double-click **Account Policies** to edit the **Password Policy**, **Account Lockout Policy**, or **Kerberos Policy**.

    -   Click **Local Policies** to edit the **Audit Policy**, a **User Rights Assignment**, or **Security Options**.

    -   Click **Event Log** to edit event log settings.

3.  In the details pane, double-click the security policy that you want to modify.

    > [!NOTE]
    > If this security policy has not yet been defined, select the **Define these policy settings** check box.

4.  Modify the security policy setting, and then click **OK**.

> [!IMPORTANT]
> -   Always test a newly created policy in a test organizational unit before you apply it to your network.
> -   When you change a security setting through a GPO and click **OK**, that setting will take effect the next time you refresh the settings.

## See also
[Security Policy Settings Reference](Security-Policy-Settings-Reference.md)


