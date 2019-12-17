---
title: Get started with the web client
description: Describes how to sign in to the Remote Desktop web client.
ms.prod: windows-server
ms.technology: remote-desktop-services
ms.author: helohr
ms.date: 08/27/2019
ms.topic: article
author: Heidilohr
ms.localizationpriority: medium
---
# Get started with the web client

The Remote Desktop web client lets you use a compatible web browser to access your organization's remote resources (apps and desktops) published to you by your admin. You'll be able to interact with the remote apps and desktops like you would with a local PC no matter where you are, without having to switch to a different desktop PC. Once your admin sets up your remote resources, all you need are your domain, user name, password, the URL your admin sent you, and a supported web browser, and you're good to go.

>[!NOTE]
>Curious about the new releases for the web client? Check out [What's new for Remote Desktop web client?](web-client-whatsnew.md)

## What you'll need to use the web client

* For the web client, you'll need a PC running Windows, macOS, ChromeOS, or Linux. Mobile devices are not supported at this time.
* A modern browser like Microsoft Edge, Internet Explorer 11, Google Chrome, Safari, or Mozilla Firefox (v55.0 and later).
* The URL your admin sent you.

>[!NOTE]
>The Internet Explorer version of the web client does not have audio at this time.
>Safari may display a gray screen if the browser is resized or enters fullscreen multiple times.

## Start using the Remote Desktop client

To sign in to the client, go to the URL your admin sent you. At the sign in page, enter your domain and user name in the format ```DOMAIN\username```, enter your password, and then select **Sign in**.

>[!NOTE]
>By signing in to the web client, you agree that your PC complies with your organization's security policy.

After you sign in, the client will take you to the **All Resources** tab, which contains all items published to you under one or more collapsible groups, such as the "Work Resources" group. You'll see several icons representing the apps, desktops, or folders containing more apps or desktops that the admin has made available to the work group. You can come back to this tab at any time to launch additional resources.

To start using an app or desktop, select the item you want to use, enter the same user name and password you used to sign in to the web client if prompted, and then select **Submit**. You might also be shown a consent dialog to access local resources, like clipboard and printer. You can choose to not redirect either of these, or select **Allow** to use the default settings. Wait for the web client to establish the connection, and then start using the resource as you would normally.

When you're finished, you can end your session by either selecting the **Sign Out** button in the toolbar at the top of your screen or closing the browser window.

## Printing from the Remote Desktop web client

Follow these steps to print from the web client:

1. Start the printing process as you would normally for the app you want to print from.
2. When prompted to choose a printer, select **Remote Desktop Virtual Printer**.
3. After choosing your preferences, select **Print**.
4. Your browser will generate a PDF file of your print job.
5. You can choose to either open the PDF and print its contents to your local printer or save it to your PC for later use.

## Copy and paste from the Remote Desktop web client

The web client currently supports copying and pasting text only. Files can't be copied or pasted to and from the web client. Additionally, you can only use **Ctrl+C** and **Ctrl+V** to copy and paste text.

## Use an Input Method Editor (IME) in the remote session

To use an Input Method Editor to enter complex characters in the remote session, select the gear icon in the navigation bar to open the **Settings** side panel and set the **Enable Input Method Editor** switch to **On**. You must have an Input Method Editor installed and enabled in the remote session. 

## Get help with the web client

If you've encountered an issue that can't be solved by the information in this article, you can get help with the web client by emailing the address on the web client's About page.
