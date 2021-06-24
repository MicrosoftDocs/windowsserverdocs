---
title: STEP 7 Test DirectAccess Connectivity from the Internet
description: Learn how to start to test connectivity from the internet.
manager: brianlic
ms.topic: article
ms.assetid: ed2a1616-30c6-482a-9a02-4a5023621f58
ms.author: jgerend
author: JasonGerend
ms.date: 08/07/2020
---
# STEP 7 Test DirectAccess Connectivity from the Internet

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

The DirectAccess one-time password (OTP) deployment has been tested from the Homenet subnet, and can now be tested from the Internet.

### To test OTP functionality from the Internet on CLIENT1

1. On CLIENT1 make sure that you are logged on as **User1**. Connect CLIENT1 to the Corpnet subnet.

2. On the **Start** screen, type**powershell.exe**, right-click **powershell**, click **Advanced**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.

3. In the Windows PowerShell window, type **gpupdate /force** and press ENTER.

4. Unplug CLIENT1 from the Homenet subnet, connect it to the Internet, and restart the computer.

5. On CLIENT1, open Internet Explorer, and in the address bar, type **https://app1.corp.contoso.com/** and press ENTER. Press F5.

   The site should not open.

6. On the **Start** screen, type**RSA**, and click **RSA SecurID Token**.

7. Wait until the RSA SecurID token changes the One-time password, and then click **Copy**.

8. Click the **Network connections** icon in the notification area to access the DA Media Manager.

9. Click **Workplace Connection**, and click **Continue**.

10. Press Control+Alt+Delete, and click the **One-time password (OTP)** tile.

11. Paste the previously copied eight digit tokencode, and click **OK**. Wait for authentication to complete. The DirectAccess Workplace Connection status will now be **Connected**.

12. In Internet Explorer, in the address bar, type **https://app1.corp.contoso.com/** and press ENTER. Press F5. You will see the default IIS website on APP1.

13. In the Internet Explorer address bar, type **https://app2.corp.contoso.com/** and press ENTER. Press F5. You will see the default IIS website on APP2.

14. On the **Start** screen, type<strong>\\\app1\files</strong>, and press ENTER.

15. In the **Files** shared folder window, double-click the **Example.txt** file. You will see the contents of the Example.txt file.

16. On the **Start** screen, type<strong>\\\app2\files</strong>, and press ENTER.

17. In the **Files** shared folder window, double-click the **New Text Document.txt** file. You will see the contents of the New Text Document.txt file.



