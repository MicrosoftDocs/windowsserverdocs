---
title: Remote Desktop client FAQ for iOS
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2322701c-8cf5-411a-8a09-98aacd49be2a 
author: lizap
manager: dongill
ms.author: elizapo
---
# Frequently asked questions about the iOS Remote Desktop client

>Applies To: Windows 10, Windows 8.1, Windows Server 2012 R2, Windows Server 2016

You can use the Remote Desktop client to connect to a remote PC and your work resources from almost anywhere. Experience rich interactivity using a remote desktop client designed to help you get your work done wherever you are. For example, you can connect to your work PC and have access to all of your apps, files, and network resources as if you were sitting right in front of your work PC. You can leave apps open at work and then see those same apps using the RD client.

The following information provides answer to frequently asked questions about the iOS client.

## How do I set up a PC for Remote Desktop Connection?

For Windows 10, do the following:

1. From the **Start** menu, type **System** in the search bar. You can also open the settings app and then click **System.**
2. Search for "remote" and then click **Allow remote access to your computer**.
3. In the System Properties, on the Remote tab, under **Remote Desktop**, select **Allow remote connections to this computer**.
4. Click **Select Users**.
5. Make sure your user name has access.
6. You can add other users by clicking **Add**, and then specifying the users to add. Click **OK** when you're done adding users.
7. Click **OK**.

For Windows 8.1, follow the instructions to allow remote connections in [Connect to another desktop using Remote Desktop Connections](https://support.microsoft.com/en-us/help/17463/windows-7-connect-to-another-computer-remote-desktop-connection#1TC=windows-8).

> [!NOTE]
> You can’t connect to a PC that's asleep or hibernating, so make sure the settings for sleep and hibernation on the remote PC are set to **Never** (hibernation isn't available on all PCs.).

When you want to connect to a PC, you need the full name. You can find this information in the **System** settings.

## Which PCs can I connect to?

Check out the [supported configuration](remote-desktop-supported-config.md) article for information about what PCs you can connect to.

## Why can’t I connect using Remote Desktop Connection?

Here are some possible solutions to common problems you might encounter when trying to connect to a remote PC. If these solutions don’t work, you can find more help on the [Microsoft Community website](http://go.microsoft.com/fwlink/p/?LinkId=242079).

- **The remote PC can’t be found.** If you see this error, talk to the system admin of the remote PC to make sure you have the right PC name, and then check to see if you entered the name correctly. If you still can't connect, try entering the IP address of the remote PC instead of the PC name.
- **There’s a problem with the network.** Make sure that:
   - Your router is turned on (home networks only).
   - The Ethernet cable is plugged into your network adapter (wired networks only).
   - Your PC’s wireless switch is turned on (laptops on wireless networks only).
   - Your network adapter is working.

   If the problem keeps happening, talk to the person who set up your network.
- **The Remote Desktop port might be blocked by a firewall.** If you're using Windows Firewall, follow these steps:

   1. Open Windows Firewall. (If you don't know where to find Windows Firewall, you can search for it in the search box in the **Start** menu.)
   2. Tap or click **Allow an app or feature through Windows Firewall**. 
   3. Tap or click **Change settings**. You might be asked for an admin password or to confirm your choice.
   4. Under **Allowed apps and features**, select **Remote Desktop**, and then tap or click **OK**.

   If you're using a different firewall, make sure the port for Remote Desktop (usually 3389) is open.
- **Remote connections might not be set up on the remote PC.** To fix this, see the "How do I set up a PC for Remote Desktop Connection?" question in this topic.
- **The remote PC might only allow PCs to connect that have Network Level Authentication set up.** 
- **The remote PC might be turned off.** You can’t connect to a PC that's turned off, asleep, or hibernating, so make sure the settings for sleep and hibernation on the remote PC are set to **Never** (hibernation isn't available on all PCs.).

## Why can't I sign in to a remote PC?
If you can see the sign-in screen of the remote PC but you can't sign in, you might not have been added to the Remote Desktop Users Group or to any group with administrator rights on the remote PC. Ask your system admin to do this for you.

## Why do I get an "Insufficient privileges" error?
You are not allowed to access the session you want to connect to. The most likely cause is that you are trying to connect to an admin session. Only administrators are allowed to connect to the console. Verify that the console switch is off in the advanced settings of the remote desktop. If this is not the source of the problem, please contact your system administrator for further assistance.


## How do I configure L2TP or PPTP VPN connections?
If you are using L2TP or PPTP in your VPN, make sure to set **Send all traffic** to **ON** in the VPN configuration.

## What do I need to connect to an office computer using a Remote Desktop gateway?

You need three things:

1. The server name of the Remote Desktop Gateway. For example, rdgw.contoso.com.
2. The name of your computer or workstation at the office. 
3. Your user name, domain, and password.

## I can't find or connect to my PC
Check the following:
- Verify that your computer is on.
- Make sure you are entering the correct IP address or host name.
> [!IMPORTANT]
> Using the host name requires your network to resolve the host name correctly through DNS. In many home networks, you have to use the IP address instead of the host name to connect.
- Verify that you are connecting to a supported Windows version

   > [!NOTE]
   > Windows XP Home, Windows Media Center Edition, Windows Vista Home and Windows 7 Home or Starter are not supported without 3rd party software.

## VPN doesn't work

VPN issues can have several causes. The first step is to verify that the VPN works on the same network as your PC or Mac computer. If you can't test with a PC or Mac, you can try to access a company intranet web page with your device's browser.

Other things to check:
- **The 3G network blocks or corrupts VPN.** There are several 3G providers in the world who seem to block or corrupt 3G traffic. Verify VPN connectivity works correctly for over a minute.
- **L2TP or PPTP VPNs.** If you are using L2TP or PPTP in your VPN, please set Send All Traffic to ON in the VPN configuration.
- **VPN is misconfigured.** A misconfigured VPN server can be the reason why the VPN connections never worked or stopped working after some time. Ensure testing with the iOS device's web browser or a PC or Mac on the same network if this happens.

## What can I do when the app doesn't start anymore?
To resolve this issue please open the multi-tasking menu on your iOS device by double-pressing the home button. Then navigate to the RD Client icon and tap and hold your finger on the icon until the icon shows a red circle. Press this red circle to kill the app and then try to restart it.

If this does not work, it could be that settings have been corrupted which prevent the Remote Desktop app for iOS to start properly. To resolve this, delete the application and reinstall.

## Which connection methods are supported for company networks?
If you want to access your office desktop from outside your company network, your company must provide you with a means of remote access. The RD Client currently supports the following:

- Terminal Server Gateway or Remote Desktop Gateway
- Remote Desktop Web Access
- VPN (through iOS built-in VPN options)

## What does the STOP error in Windows XP mean?
This is a bug in Windows XP SP2 and SP3 and has been addressed by Microsoft. You need to open a support ticket with Microsoft to officially download the patch. 

## Is AirPrint supported?
No, the Remote Desktop client does not support AirPrint.

## Is bi-directional sound supported?
Sound upstream (from client to server, for microphones) is not supported by the Remote Desktop Client.

## Why are the characters mixed up in the session?
This issue can occur if the keyboard language has been switched on the remote PC while running a remote desktop session.

>[!IMPORTANT]
> The remote PC selects the system language of the device running the remote desktop client and not the keyboard language. When switching the keyboard language on your device, you need to manually switch the keyboard language on the remote PC.

Use the following steps to switch to a different keyboard language:

1. Open the settings on your device.
2. Tap **General**, and then tap **International**.
4. Open the Remote Desktop client and connect to the remote PC. Check if the Windows keyboard language matches the language you selected.
## How can I test if VPN is working properly?
Verify that VPN is enabled on your device. You can test your VPN connection by going to a webpage on your internal network or using a web service which is only available via the VPN.

## Why don't special keys work on a Bluetooth keyboard?
On Bluetooth keyboards modifier keys such as Ctrl, Alt, Shift F-keys do not work as expected. This is a limitation of iOS. You can work around this by using the on-screen keyboard within the remote desktop session that you can activate by a tap on the keyboard icon in the connection bar.

## Why do I get a "Failed to parse NTLM challenge" error?
This error can be caused by a misconfiguration on the remote PC. Verify the RDP security level setting in the remote PC options is set to Client Compatible.

## What can I do if the sound won't play?
Sign out of the session (don't just disconnect, sign all the way out), and then sign in again.

## Why did I get a "TS_RAP 'You are not allowed to connect to the given host'" error?
The error message “You are not allowed to connect to the given host through the gateway server because of a Resource Authorization Policy (TS_RAP)” means that a Resource Authorization Policy on the Gateway server prevents your username from connecting to the remote PC. This could be the case:

- You have provided the same name for the remote PC as for the gateway.
- You are then trying to connect to the RD Gateway server itself which is probably not allowed for your username.
- Your Windows user account is not a member of the user groups for remote access on the Remote Desktop server.

If you indeed want to connect to the gateway server itself via the gateway, do not use the external gateway name as PC name, use “localhost” or “127.0.0.1” or the internal server name for the remote desktop. If the entries are correct, ask your system administrator to view the event log on the Terminal server and to check if your user account is a member of the required user groups.

## Why does the client say that there is no CAL?
When a remote desktop client connects to a Remote Desktop server, the server issues a Remote Desktop Services Client Access License (RDS CAL) stored by the client. Whenever the client connects again it will use its RDS CAL and the server will not issue another license. The server will issue another license if the RDS CAL on the device is missing or corrupt. When the maximum number of licensed devices is reached the server will not issue new RDS CALs. Contact your network administrator for assistance.

## Why did I get an "Access Denied" error?
The "Access Denied" error is a generated by the Remote Desktop Gateway and the result of incorrect credentials during the connection attempt. Verify your username and password. If the connection worked before and the error occurred recently, you possibly changed your Windows user account password and haven't updated it yet in the remote desktop settings.

## What does "RPC Error 23014" or "Error 0x59e6" mean?
In case of an **RPC error 23014** or **Error 0x59E6 try again after waiting a few minutes**, the RD Gateway server has reached the maximum number of active connections. Depending on the Windows version running on the RD Gateway the maximum number of connections differs: The Windows Server 2008 R2 Standard implementation limits the number of connections to 250. The Windows Server 2008 R2 Foundation implementation limits the number of connections to 50. All other Windows implementations allow an unlimited number of connections.