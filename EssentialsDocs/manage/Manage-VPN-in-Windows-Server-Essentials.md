---
title: "Manage VPN in Windows Server Essentials"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: cc2b264a-b9a8-4114-9f7b-8604f77096e5
author: nnamuhcs
ms.author: coreyp
manager: dongill
---



# Manage VPN in Windows Server Essentials

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials 
  
 Virtual private network (VPN) connections enable users working at home or on the road to access a server on a private network by using the infrastructure provided by a public network, such as the Internet. To use VPN for accessing server resources, you must complete the following:  
  
-   [Enable VPN for remote access on the server](Manage-VPN-in-Windows-Server-Essentials.md#BKMK_1)  
  
-   [Set VPN permissions for network users](Manage-VPN-in-Windows-Server-Essentials.md#BKMK_2)  
  
-   [Connect client computers to the server](Manage-VPN-in-Windows-Server-Essentials.md#BKMK_Connect)  
  
-   [Use VPN to connect to Windows Server Essentials](Manage-VPN-in-Windows-Server-Essentials.md#BKMK_3)  
  
##  <a name="BKMK_1"></a> Enable VPN for remote access on the server  
 Complete the following procedure to configure VPN in Windows Server Essentials to enable remote access.  
  
#### To enable VPN in Windows Server Essentials  
  
1.  Open the Dashboard.  
  
2.  Click **Settings**, and then click the **Anywhere Access** tab.  
  
3.  Click **Configure**. The Set Up Anywhere Access Wizard appears.  
  
4.  On the **Choose Anywhere Access features to enable** page, select the **Virtual Private Network** check box.  
  
5.  Follow the instructions to complete the wizard.  
  
##  <a name="BKMK_2"></a> Set VPN permissions for network users  
 You can use VPN to connect to Windows Server Essentials and access all your resources that are stored on the server. This is especially useful if you have a client computer that is set up with network accounts that can be used to connect to a hosted Windows Server Essentials server through a VPN connection. All the newly created user accounts on the hosted Windows Server Essentials server must use VPN to log on to the client computer for the first time.  
  
#### To set VPN permissions for network users  
  
1.  Open the Dashboard.  
  
2.  On the navigation bar, click **USERS**.  
  
3.  In the list of user accounts, select the user account that you want to grant permissions to access the desktop remotely.  
  
4.  In the **<User Account\> Tasks** pane, click **Properties**.  
  
5.  In the **<User Account\> Properties**, click the **Anywhere Access** tab.  
  
6.  On the **Anywhere Access** tab, to allow a user to connect to the server by using VPN, select the **Allow Virtual Private Network (VPN)**  check box.  
  
7.  Click **Apply**, and then click **OK**.  
  
##  <a name="BKMK_Connect"></a> Connect client computers to the server  
 After VPN is enabled on a server running Windows Server Essentials for remote access, you can use a VPN connection to connect to and access all your resources that are stored on the server. However, you must first connect the computer to the server. When you connect a computer to the server by using the Connect My Computer to the Server Wizard, a VPN network connection is automatically generated on the client computer and can be used to access server resources while working at home or on the road. For step-by-step instructions about connecting your computer to the server, see [Connect computers to the server](../use/Get-Connected-in-Windows-Server-Essentials.md#BKMK_9).  
  
##  <a name="BKMK_3"></a> Use VPN to connect to Windows Server Essentials  
 If you have a client computer that is set up with network accounts that can be used to connect to a hosted server running Windows Server Essentials through a VPN connection, all the newly created user accounts on the hosted server must use VPN to log on to the client computer for the first time. Complete the following procedure from the client computer that is connected to the server.  
  
#### To use VPN to remotely access server resources  
  
1.  Press Ctrl + Alt + Delete on the client computer.  
  
2.  Click **Switch User** on the logon screen.  
  
3.  Click the network logon icon on the bottom right corner of the screen.  
  
4.  Log on to the Windows Server Essentials network by using your network user name and password.  
  
## See also  
  
-   [Work Remotely](../use/Work-Remotely-in-Windows-Server-Essentials.md)  
  
-   [Manage Anywhere Access](Manage-Anywhere-Access-in-Windows-Server-Essentials.md)  
  
-   [Manage Windows Server Essentials](Manage-Windows-Server-Essentials.md)
