---
title: STEP 6 Test DirectAccess Connectivity from the Homenet Subnet
description: Learn how to start to test connectivity from the Homenet subnet.
ms.topic: article
ms.author: jgerend
author: JasonGerend
ms.date: 04/01/2023
---
# STEP 6 Test DirectAccess Connectivity from the Homenet Subnet

Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

The DirectAccess one-time password (OTP) deployment is now complete and you can start to test connectivity from the Homenet subnet.

## To test OTP functionality from the Homenet subnet on CLIENT1

1. On CLIENT1, make sure that you're logged on as **User1**.

1. On the **Start** screen, type `powershell.exe`, right-click **powershell**, select **Advanced**, and then select **Run as administrator**. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then select **Yes**.

1. In the Windows PowerShell window, type `gpupdate /force`, and press ENTER.

1. Unplug CLIENT1 from the Corpnet subnet and connect it to the Homenet subnet.

1. On CLIENT1, open Internet Explorer, and in the address bar, type `https://app1.corp.contoso.com/` and press ENTER. Press F5.

   The site shouldn't open.

1. On the **Start** screen, type _RSA_, and select **RSA SecurID Token**.

1. Wait until the RSA SecurID token changes the One-time password, and then select **Copy**.

1. Select the **Network connections** icon in the notification area to access the DA Media Manager.

1. Select **Contoso DirectAccess Connection**, and select **Continue**.

1. Press Control+Alt+Delete, and select the **One-time password (OTP)** tile.

1. Paste the previously copied eight digit tokencode, and select **OK**. Wait for authentication to complete. The DirectAccess Workplace Connection status is **Connected**.

1. In Internet Explorer, in the address bar, type `https://app1.corp.contoso.com/` and press ENTER. Press F5. You see the default IIS website on APP1.

1. In the Internet Explorer address bar, type `https://app2.corp.contoso.com/` and press ENTER. Press F5. You see the default IIS website on APP2.

1. On the **Start** screen, type `\\app1\files`, and press ENTER.

1. In the **Files** shared folder window, double-click the `Example.txt` file. You see the contents of the Example.txt file.

1. On the **Start** screen, type `\\app2\files`, and press ENTER.

1. In the **Files** shared folder window, double-click the `New Text Document.txt` file. You see the contents of the `New Text Document.txt` file.
