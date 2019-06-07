---
title: Remote Desktop clients FAQ
description: Frequently asked questions about the Remote Desktop clients
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 785a18cf-a5d0-4bc2-95e4-9ef53ee8f65a 
author: lizap
manager: dongill
ms.author: elizapo
ms.date: 07/16/2018
ms.localizationpriority: medium
---
# Frequently asked questions about the Remote Desktop clients

>Applies to: Windows 10, Windows 8.1, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2

Now that you've set up the Remote Desktop client on your device (Android, Mac, iOS, or Windows), you may have questions. Here are answers to the most commonly asked questions about the Remote Desktop clients. 

- [Setting up](#setting-up)
- [Connections, gateway, and networks](#connection-gateway-and-networks)
- [Web client](#web-client)
- [Monitors, audio, and mouse](#monitors-audio-and-mouse)
- [Mac hardware](#mac-client---hardware-questions)
- [Specific error messages](#specific-errors)

The majority of these questions apply to all of the clients, but there are a few client specific items.

If you have additional questions that you'd like us to answer, leave them as feedback on this article.

## Setting up

### Which PCs can I connect to?

Check out the [supported configuration](remote-desktop-supported-config.md) article for information about what PCs you can connect to.

### How do I set up a PC for Remote Desktop?

I have my device set up, but I don't think the PC's ready. Help?

First, have you seen the Remote Desktop Setup Wizard? It walks you through getting your PC ready for remote access. Download and run that tool on your PC to get everything set. 

Otherwise, if you prefer to do things manually, read on.

For Windows 10, do the following:

1. On the device you want to connect to, open **Settings**.
2. Select **System** and then **Remote Desktop**.
3. Use the slider to enable Remote Desktop.
4. In general, it's best to keep the PC awake and discoverable to facilitate connections. Click **Show settings** to go to the power settings for your PC, where you can change this setting.
   > [!NOTE]
   > You can’t connect to a PC that's asleep or hibernating, so make sure the settings for sleep and hibernation on the remote PC are set to **Never**. (Hibernation isn't available on all PCs.)


Make note of the name of this PC under **How to connect to this PC**. You'll need this to configure the clients.

You can grant permission for specific users to access this PC - to do that, click **Select users that can remotely access this PC**.
Members of the Administrators group automatically have access.

For Windows 8.1, follow the instructions to allow remote connections in [Connect to another desktop using Remote Desktop Connections](https://support.microsoft.com/en-us/help/17463/windows-7-connect-to-another-computer-remote-desktop-connection#1TC=windows-8).



## Connection, gateway, and networks

### Why can’t I connect using Remote Desktop?

Here are some possible solutions to common problems you might encounter when trying to connect to a remote PC. If these solutions don’t work, you can find more help on the [Microsoft Community website](https://go.microsoft.com/fwlink/p/?LinkId=242079).

- **The remote PC can’t be found.** Make sure you have the right PC name, and then check to see if you entered that name correctly. If you still can't connect, try using the IP address of the remote PC instead of the PC name.
- **There’s a problem with the network.** Make sure you have internet connection. 
- **The Remote Desktop port might be blocked by a firewall.** If you're using Windows Firewall, follow these steps:

  1. Open Windows Firewall. 
  2. Click **Allow an app or feature through Windows Firewall**. 
  3. Click **Change settings**. You might be asked for an admin password or to confirm your choice.
  4. Under **Allowed apps and features**, select **Remote Desktop**, and then tap or click **OK**.

     If you're using a different firewall, make sure the port for Remote Desktop (usually 3389) is open.
- **Remote connections might not be set up on the remote PC.** To fix this, scroll back up to [How do I set up a PC for Remote Desktop?](#how-do-i-set-up-a-pc-for-remote-desktop) question in this topic.
- **The remote PC might only allow PCs to connect that have Network Level Authentication set up.** 
- **The remote PC might be turned off.** You can’t connect to a PC that's turned off, asleep, or hibernating, so make sure the settings for sleep and hibernation on the remote PC are set to **Never** (hibernation isn't available on all PCs.).

### Why can't I find or connect to my PC?

Check the following:

- Is the PC on and awake?
- Did you enter the right name or IP address?

   > [!IMPORTANT]
   > Using the PC name requires your network to resolve the name correctly through DNS. In many home networks, you have to use the IP address instead of the host name to connect.
- Is the PC on a different network? Did you configure the PC to let outside connections through?  Check out [Allow access to your PC from outside your network](remote-desktop-allow-outside-access.md) for help.
- Are you connecting to a supported Windows version? 

   > [!NOTE]
   > Windows XP Home, Windows Media Center Edition, Windows Vista Home and Windows 7 Home or Starter are not supported without 3rd party software.

### Why can't I sign in to a remote PC?

If you can see the sign-in screen of the remote PC but you can't sign in, you might not have been added to the Remote Desktop Users Group or to any group with administrator rights on the remote PC. Ask your system admin to do this for you.

### Which connection methods are supported for company networks?

If you want to access your office desktop from outside your company network, your company must provide you with a means of remote access. The RD Client currently supports the following:

- Terminal Server Gateway or Remote Desktop Gateway
- Remote Desktop Web Access
- VPN (through iOS built-in VPN options)

### VPN doesn't work

VPN issues can have several causes. The first step is to verify that the VPN works on the same network as your PC or Mac computer. If you can't test with a PC or Mac, you can try to access a company intranet web page with your device's browser.

Other things to check:
- **The 3G network blocks or corrupts VPN.** There are several 3G providers in the world who seem to block or corrupt 3G traffic. Verify VPN connectivity works correctly for over a minute.
- **L2TP or PPTP VPNs.** If you are using L2TP or PPTP in your VPN, please set Send All Traffic to ON in the VPN configuration.
- **VPN is misconfigured.** A misconfigured VPN server can be the reason why the VPN connections never worked or stopped working after some time. Ensure testing with the iOS device's web browser or a PC or Mac on the same network if this happens.

### How can I test if VPN is working properly?

Verify that VPN is enabled on your device. You can test your VPN connection by going to a webpage on your internal network or using a web service which is only available via the VPN.

### How do I configure L2TP or PPTP VPN connections?

If you are using L2TP or PPTP in your VPN, make sure to set **Send all traffic** to **ON** in the VPN configuration.

## Web client

### Which browsers can I use?

The web client supports Microsoft Edge, Internet Explorer 11, Mozilla Firefox (v55.0 and later), Safari, and Google Chrome.

### What PCs can I use to access the web client?

The web client supports Windows, macOS, Linux, and ChromeOS. Mobile devices are not supported at this time.

### Can I use the web client in a Remote Desktop deployment without a gateway?

No. The client requires a Remote Desktop Gateway to connect. Don't know what that means? Ask your admin about it.

### Does the Remote Desktop web client replace the Remote Desktop Web Access page?

No. The Remote Desktop web client is hosted at a different URL than the Remote Desktop Web Access page. You can use either the web client or the Web Access page to view the remote resources in a browser.

### Can I embed the web client in another web page?

This feature is not supported at the moment.

## Monitors, audio, and mouse

### How do I use all of my monitors?
To use two or more screens, do the following:

1. Right-click the remote desktop that you want to enable multiple screens for, and then click **Edit**.
2. Enable **Use all monitors** and **Full screen**.

### Is bi-directional sound supported?
Sound upstream (from client to server, for microphones) is not supported by the Remote Desktop Client.

### What can I do if the sound won't play?
Sign out of the session (don't just disconnect, sign all the way out), and then sign in again.

## Mac client - hardware questions
### Is retina resolution supported?
Yes, the remote desktop client supports retina resolution.

### How do I enable secondary right-click?
In order to make use of the right-click inside an open session you have three options:

- Standard PC two button USB mouse
- Apple Magic Mouse: To enable right-click, click **System Preferences** in the dock, click **Mouse**, and then enable **Secondary click**.
- Apple Magic Trackpad or MacBook Trackpad: To enable right-click, click **System Preferences** in the dock, click **Mouse**, and then enable **Secondary click**.

### Is AirPrint supported?
No, the Remote Desktop client doesn't support AirPrint. (This is true for both Mac and iOS clients.)

### Why do incorrect characters appear in the session?
If you are using an international keyboard, you might see an issue where the characters that appear in the session do match the characters you typed on the Mac keyboard.

This can occur in the following scenarios:

- You are using a keyboard that the remote session does not recognize. When Remote Desktop doesn't recognize the keyboard, it defaults to the language last used with the remote PC.
- You are connecting to a previously disconnected session on a remote PC and that remote PC uses a different keyboard language than the language you are currently trying to use.

You can fix this issue by manually setting the keyboard language for the remote session. See the steps in the next section.

### How do language settings affect keyboards in a remote session?
There are many types of Mac keyboard layouts. Some of these are Mac specific layouts or custom layouts for which an exact match may not be available on the version of Windows you are remoting into. The remote session maps your keyboard to the best matching keyboard language available on the remote PC. 

If your Mac keyboard layout is set to the PC version of the language keyboard (for example, French – PC) all your keys should be mapped correctly and your keyboard should just work.

If your Mac keyboard layout is set to the Mac version of a keyboard (for example, French) the remote session will map you to the PC version of the French language. Some of the Mac keyboard shortcuts you are used to using on OSX will not work in the remote Windows session.

If your keyboard layout is set to a variation of a language (for example, Canadian-French) and if the remote session cannot map you to that exact variation, the remote session will map you to the closest language (for example, French). Some of the Mac keyboard shortcuts you are used to using on OSX will not work in the remote Windows session.

If your keyboard layout is set to a layout the remote session cannot match at all, your remote session will default to give you the language you last used with that PC. In this case, or in cases where you need to change the language of your remote session to match your Mac keyboard, you can manually set the keyboard language in the remote session to the language that is the closest match to the one you wish to use as follows.

Use the following instructions to change the keyboard layout inside the remote desktop session:

**On Windows 10 or Windows 8:**

1. From inside the remote session, open Region and Language. Click **Start > Settings > Time and Language**. Open **Region and Language**.
2. Add the language you want to use. Then close the Region and Language window.
3. Now, in the remote session, you'll see the ability to switch between languages. (In the right side of the remote session, near the clock.) Click the language you want to switch to (such as **Eng**).

You might need to close and restart the application you are currently using for the keyboard changes to take effect.


## Specific errors

### Why do I get an "Insufficient privileges" error?
You are not allowed to access the session you want to connect to. The most likely cause is that you are trying to connect to an admin session. Only administrators are allowed to connect to the console. Verify that the console switch is off in the advanced settings of the remote desktop. If this is not the source of the problem, please contact your system administrator for further assistance.

### Why does the client say that there is no CAL?
When a remote desktop client connects to a Remote Desktop server, the server issues a Remote Desktop Services Client Access License (RDS CAL) stored by the client. Whenever the client connects again it will use its RDS CAL and the server will not issue another license. The server will issue another license if the RDS CAL on the device is missing or corrupt. When the maximum number of licensed devices is reached the server will not issue new RDS CALs. Contact your network administrator for assistance.

### Why did I get an "Access Denied" error?
The "Access Denied" error is a generated by the Remote Desktop Gateway and the result of incorrect credentials during the connection attempt. Verify your username and password. If the connection worked before and the error occurred recently, you possibly changed your Windows user account password and haven't updated it yet in the remote desktop settings.

### What does "RPC Error 23014" or "Error 0x59e6" mean?
In case of an **RPC error 23014** or **Error 0x59E6 try again after waiting a few minutes**, the RD Gateway server has reached the maximum number of active connections. Depending on the Windows version running on the RD Gateway the maximum number of connections differs: The Windows Server 2008 R2 Standard implementation limits the number of connections to 250. The Windows Server 2008 R2 Foundation implementation limits the number of connections to 50. All other Windows implementations allow an unlimited number of connections.

### What does the "Failed to parse NTLM challenge" error mean?
This error is caused by a misconfiguration on the remote PC. Make sure the RDP security level setting on the remote PC is set to "Client Compatible." (Talk to your system admin if you need help doing this.)

### What does "TS_RAP You are not allowed to connect to the given host" mean?
This error happens when a Resource Authorization Policy on the gateway server stops your user name from connecting to the remote PC. This can happen in the following instances:

- The remote PC name is the same as the name of the gateway. Then, when you try to connect to the remote PC, the connection goes to the gateway instead, which you probably don't have permission to access. If you need to connect to the gateway, do not use the external gateway name as PC name. Instead use "localhost" or the IP address (127.0.0.1), or the internal server name.
- Your user account isn't a member of the user group for remote access.