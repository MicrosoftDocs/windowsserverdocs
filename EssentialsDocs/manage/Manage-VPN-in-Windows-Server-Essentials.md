---
title: "Manage VPN in Windows Server Essentials"
ms.custom: na
ms.date: 01/12/2014
ms.prod: windows-server-2012-r2-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
applies_to: 
  - Windows Server 2012 Essentials
  - Windows Server 2012 R2 Essentials
ms.assetid: cc2b264a-b9a8-4114-9f7b-8604f77096e5
caps.latest.revision: 10
author: DonGill
manager: stevenka
translation.priority.ht: 
  - de-de
  - es-es
  - fr-fr
  - it-it
  - ja-jp
  - ko-kr
  - pt-br
  - ru-ru
  - zh-cn
  - zh-tw
---
# Manage VPN in Windows Server Essentials
--- translation.priority.ht:    - cs-cz   - de-at   - de-de   - es-es   - fr-be   - fr-fr   - hu-hu   - it-ch   - it-it   - ja-jp   - ko-kr   - nl-be   - nl-nl   - pl-pl   - pt-br   - pt-pt   - ru-ru   - sv-se   - tr-tr   - zh-cn   - zh-tw --- This topic applies to a server running Windows Server 2012 Essentials or Windows Server 2012 R2 Essentials, or to a server running Windows Server 2012 R2 Standard or Windows Server 2012 R2 Datacenter with the Windows Server Essentials Experience role installed.  
  
 Virtual private network (VPN) connections enable users working at home or on the road to access a server on a private network by using the infrastructure provided by a public network, such as the Internet. To use VPN for accessing server resources, you must complete the following:  
  
-   [Enable VPN for remote access on the server](../windows-server-essentials-manage/Manage-VPN-in-Windows-Server-Essentials.md#BKMK_1)  
  
-   [Set VPN permissions for network users](../windows-server-essentials-manage/Manage-VPN-in-Windows-Server-Essentials.md#BKMK_2)  
  
-   [Connect client computers to the server](../windows-server-essentials-manage/Manage-VPN-in-Windows-Server-Essentials.md#BKMK_Connect)  
  
-   [Use VPN to connect to Windows Server Essentials](../windows-server-essentials-manage/Manage-VPN-in-Windows-Server-Essentials.md#BKMK_3)  
  
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
  
3.  In the list of user accounts, select the user account that you want to grant permissions to to access the desktop remotely.  
  
4.  In the **<User Account\> Tasks** pane, click **Properties**.  
  
5.  In the **<User Account\> Properties**, click the **Anywhere Access** tab.  
  
6.  On the **Anywhere Access** tab, to allow a user to connect to the server by using VPN, select the **Allow Virtual Private Network (VPN)**  check box.  
  
7.  Click **Apply**, and then click **OK**.  
  
##  <a name="BKMK_Connect"></a> Connect client computers to the server  
 After VPN is enabled on a server running Windows Server Essentials for remote access, you can use a VPN connection to connect to and access all your resources that are stored on the server. However, you must first connect the computer to the server. When you connect a computer to the server by using the Connect My Computer to the Server Wizard, a VPN network connection is automatically generated on the client computer and can be used to access server resources while working at home or on the road. For step-by-step instructions about connecting your computer to the server, see [Connect computers to the server](../Topic/Get%20Connected%20in%20Windows%20Server%20Essentials.md#BKMK_9).  
  
##  <a name="BKMK_3"></a> Use VPN to connect to Windows Server Essentials  
 If you have a client computer that is set up with network accounts that can be used to connect to a hosted server running Windows Server Essentials through a VPN connection, all the newly created user accounts on the hosted server must use VPN to log on to the client computer for the first time. Complete the following procedure from the client computer that is connected to the server.  
  
#### To use VPN to remotely access server resources  
  
1.  Press Ctrl + Alt + Delete on the client computer.  
  
2.  Click **Switch User** on the logon screen.  
  
3.  Click the network logon icon on the bottom right corner of the screen.  
  
4.  Log on to the Windows Server Essentials network by using your network user name and password.  
  
## See also  
  
-   [Work Remotely](../Topic/Work%20Remotely%20in%20Windows%20Server%20Essentials.md)  
  
-   [Manage Anywhere Access](../windows-server-essentials-manage/Manage-Anywhere-Access-in-Windows-Server-Essentials.md)  
  
-   [Manage Windows Server Essentials](../windows-server-essentials-manage/Manage-Windows-Server-Essentials.md)
