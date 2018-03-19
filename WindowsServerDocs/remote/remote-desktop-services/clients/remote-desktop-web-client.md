---
title: Access the Remote Desktop web client
description: Describes how to sign in to the Remote Desktop web client.
ms.prod: windows-server-threshold
ms.technology: remote-desktop-services
ms.author: helohr
ms.date: 2/16/2018
ms.topic: article
author: Heidilohr
---
# Access the Remote Desktop web client

The Remote Desktop client lets you access your organization's remote desktop workstation through a compatible internet browser. You'll be able to interact with apps on your remote machine like you would with a local PC no matter where you are, without having to switch to a different desktop PC. Once your admin sets up your Remote Desktop group, all you need are your domain, credentials, the URL your admin sent you, and a supported web browser, and you're good to go.

>[!NOTE]
>You may have heard people call this client the HTML5 client. Both names refer to the same client.

## What you'll need to use the web client

* For the web client, you'll need a PC running Windows, Mac, or Linux. Mobile devices are not supported at this time.
* The client currently supports Edge, IE 11, Google Chrome, and Safari. Firefox support is still in progress.
* The URL your admin sent you.

## Start using the Remote Desktop client

To sign in to the client, go to the URL your admin sent you. At the sign in page, enter your domain and user name in the format ```DOMAIN\username```, enter your password, and then select **Sign in**.

>[!NOTE]
>By signing in to the web client, you agree that your PC complies with your organization's security policy.

After you sign in, the client will take you to the **Resources** page. Under the **Work Resources** menu, you'll see several icons for the apps the admin has made available to the work group. To start using an app, select the icon for the app you want to use, enter the same user name and password you used to sign in to the web client when prompted, and then select **Connect**. Wait for the remote desktop to load, and then start using the app as you would normally.

When you're finished with your session, select the **Sign Out** button in the **Options** toolbar.

>[!NOTE]
>Your Remote Desktop web client session will automatically time out after a period of inactivity. If your session ends before you're ready due to timing out, just refresh your browser and sign in again.