---
title: BitLocker: Use BitLocker Recovery Password Viewer
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 54d919d5-c0d3-4d51-bd61-760f745da425
---
# BitLocker: Use BitLocker Recovery Password Viewer
The BitLocker Recovery Password Viewer tool is an optional tool included with the Remote Server Administration Tools (RSAT) for  Windows Server 2012  that are available to install when you install the BitLocker feature. This tool lets you locate and view BitLocker recovery passwords that are stored in Active Directory Domain Services (AD DS). You can use this tool to help recover data that is stored on a drive that has been encrypted by using BitLocker. The BitLocker Active Directory Recovery Password Viewer tool is an extension for the Active Directory Users and Computers Microsoft Management Console (MMC) snap-in. Using this tool, you can examine a computer object's **Properties** dialog box to view the corresponding BitLocker recovery passwords. Additionally, you can right-click a domain container and then search for a BitLocker recovery password across all the domains in the Active Directory forest. You can also search for a password by password identifier (ID).

## Before you start
To complete the procedures in this scenario:

-   You must have domain administrator credentials.

-   Your test computers must be joined to the domain.

-   On the test computers, BitLocker must have been turned on after joining the domain.

The following procedures describe the most common tasks performed by using the BitLocker Recovery Password Viewer.

#### To view the recovery passwords for a computer

1.  In **Active Directory Users and Computers**, locate and then click the container in which the computer is located.

2.  Right-click the computer object, and then click **Properties**.

3.  In the **Properties** dialog box, click the **BitLocker Recovery** tab to view the BitLocker recovery passwords that are associated with the computer.

#### To copy the recovery passwords for a computer

1.  Follow the steps in the previous procedure to view the BitLocker recovery passwords.

2.  On the **BitLocker Recovery** tab of the **Properties** dialog box, right-click the BitLocker recovery password that you want to copy, and then click **Copy Details**.

3.  Press CTRL+V to paste the copied text to a destination location, such as a text file or spreadsheet.

#### To locate a recovery password by using a password ID

1.  In Active Directory Users and Computers, right-click the domain container, and then click **Find BitLocker Recovery Password**.

2.  In the **Find BitLocker Recovery Password** dialog box, type the first eight characters of the recovery password in the **Password ID (first 8 characters)** box, and then click **Search**.

By completing the procedures in this scenario, you have viewed and copied the recovery passwords for a computer and used a password ID to locate a recovery password.

## More information
[BitLocker Overview](BitLocker-Overview.md)

[Encrypted Hard Drive](../../Encrypted-Hard-Drive.md)

[BitLocker Frequently Asked Questions &#40;FAQ&#41;](BitLocker-Frequently-Asked-Questions--FAQ-.md)

[What's New in BitLocker for Windows 8 and Windows Server 2012 \[redirected\]](assetId:///2a2af536-3d99-4d86-a492-2a663dc60b4a)

[Prepare your organization for BitLocker: Planning and Policies](assetId:///94c445de-a32c-44d8-b520-1ec2e507f2f6)

[BitLocker: How to deploy on Windows Server 2012](../deploy/BitLocker--How-to-deploy-on-Windows-Server-2012.md)

[BitLocker: Use BitLocker Drive Encryption Tools to manage BitLocker](BitLocker--Use-BitLocker-Drive-Encryption-Tools-to-manage-BitLocker.md)


