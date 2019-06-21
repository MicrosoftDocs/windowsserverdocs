---
title: Remote desktop client disconnects and cannot reconnect to the same session
description: Troubleshooting an issue in which remote desktop client disconnects and cannot reconnect to the same session.
audience: ITPro ​
ms.custom: na
ms.reviewer: rklemen; josh.bender
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: troubleshooting
ms.assetid: 
author: kaushika-msft
manager: 
ms.author: kaushika; rklemen; josh.bender; v-tea; delhan
ms.date: 06/23/2019
ms.localizationpriority: medium
---

# Remote desktop client disconnects and cannot reconnect to the same session

After remote desktop client loses its connection to the remote desktop, the client cannot immediately reconnect. The user receives error messages such as the following:

  - Because of a security error, the client could not connect to the Terminal server. After making sure that you are logged on to the network, try connecting to the server again.
  - Remote desktop disconnected. Because of a security error, the client could not connect to the remote computer. Verify that you are logged onto the network and then try connecting again.

At a later time, the remote desktop client reconnects to the remote desktop. However, instead of connecting the client to the original session, the RDSH server connects the client to a new session. Checking the RDSH server reveals that the original session did not enter a disconnected state, but instead remains active.

To work around this issue, you can enable the **Configure keep-alive connection interval** policy in the **Computer Configuration\\Administrative Templates\\Windows Components\\Remote Desktop Services\\Remote Desktop Session Host\\Connections** group policy folder. If you enable this policy, you must enter a keep-alive interval. The keep-alive interval determines how often, in minutes, the server checks the session state.

This issue can be caused by misconfiguration of your authentication and configuration settings. You can configure these settings at the server level, or by using GPOs. The group policy settings are available in the **Computer Configuration\\Administrative Templates\\Windows Components\\Remote Desktop Services\\Remote Desktop Session Host\\Security** group policy folder.

1. On the RD Session Host server, open Remote Desktop Session Host Configuration.
2. Under **Connections**, right-click the name of the connection, and then click **Properties**.
3. In the **Properties** dialog box for the connection, on the **General** tab, in **Security** layer, select a security method.
4. In **Encryption level**, click the level that you want. You can select **Low**, **Client Compatible**, **High**, or **FIPS Compliant**.

> [!NOTE]  
>  - When communications between clients and RD Session Host servers require the highest level of encryption, use FIPS Compliant encryption.
>  - Any encryption level settings that you configure in Group Policy override the configuration that you set by using the Remote Desktop Services Configuration tool. Also, if you enable the [System cryptography: Use FIPS compliant algorithms for encryption, hashing, and signing](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2003/cc780081\(v=ws.10\)) policy, this setting overrides the **Set client connection encryption level** policy. The system cryptography policy is in the **Computer Configuration\\Windows Settings\\Security Settings\\Local Policies\\Security Options** folder.
>  - When you change the encryption level, the new encryption level takes effect the next time a user logs on. If you require multiple levels of encryption on one server, install multiple network adapters and configure each adapter separately.
>  - To verify that certificate has a corresponding private key, in Remote Desktop Services Configuration, right-click the connection for which you want to view the certificate, select **General**, select **Edit**, select the certificate that you want to view, and then select **View Certificate**. At the bottom of the **General** tab, the statement, "You have a private key that corresponds to this certificate" should appear. You can also view this information by using the Certificates snap-in.
>  - FIPS-compliant encryption (the **System cryptography: Use FIPS compliant algorithms for encryption, hashing, and signing** policy or the **FIPS Compliant** setting in Remote Desktop Server Configuration) encrypts and decrypts data sent from the client to the server and from the server to the client, with the Federal Information Processing Standard (FIPS) 140-1 encryption algorithms, using Microsoft cryptographic modules. For more information, see [FIPS 140 Validation](https://docs.microsoft.com/en-us/windows/security/threat-protection/fips-140-validation).
>  - The **High** setting encrypts data sent from the client to the server and from the server to the client by using strong 128-bit encryption.
>  - The **Client Compatible** setting encrypts data sent between the client and the server at the maximum key strength supported by the client.
>  - The **Low** setting encrypts data sent from the client to the server using 56-bit encryption.
