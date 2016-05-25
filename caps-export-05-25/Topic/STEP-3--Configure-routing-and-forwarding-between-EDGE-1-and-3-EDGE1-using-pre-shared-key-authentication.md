---
title: STEP 3: Configure routing and forwarding between EDGE-1 and 3-EDGE1 using pre-shared key authentication
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e4406251-1d42-4a5c-bc58-2134018b32fb
author: vhorne
---
# STEP 3: Configure routing and forwarding between EDGE-1 and 3-EDGE1 using pre-shared key authentication
  
## STEP 3: Configure routing and forwarding between EDGE1 and 3\-EDGE1 using EAP and \(optionally\) preshared key authentication  
To create an IKE\-V2\-based site\-to\-site connection, perform the following tasks:  
  
1.  Configure site\-to\-site on the fabrikam \(hoster\) RRAS Server, 3\-EDGE1.  
  
2.  Configure the demand\-dial interface on 3\-EDGE1.  
  
3.  Configure site\-to\-site on the contoso \(corporate\) RRAS Server, EDGE1.  
  
4.  Configure the demand\-dial interface on EDGE1.  
  
5.  Confirm remote access policy configuration on EDGE1 and 3\-EDGE1.  
  
6.  Initiate the site\-to\-site connection.  
  
7.  Test the site\-to\-site connection.  
  
#### Configure site\-to\-site on the **Corpnet** router \(3\-EDGE1\)  
  
1.  On **3\-EDGE1**, click **Start**, and then click **Routing and Remote Access**.  
  
2.  In Routing and Remote Access, right\-click **3\-EDGE1 \(local\)** in the console tree, and then click **Configure and Enable Routing and Remote Access**.  
  
3.  The **Routing and Remote Access Server Setup Wizard** appears. Click **Next**.  
  
4.  On the **Configuration** page, select **Secure connection between two private networks. Connect this network to a remote network such as a branch office.**, and then click **Next**.  
  
5.  On the **Demand\-Dial Connections** page, verify that **Yes** is checked and then click **Next**.  
  
6.  Click **Next**. On the **IP Address Assignment** page, select **Automatically**.  
  
7.  Click **Finish**  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]  
  
```  
ipmo remoteaccess  
install-remoteaccess -vpntype vpns2s  
  
```  
  
#### Configure the demand\-dial interface on the fabrikam \(hoster\) router \(3\-EDGE1\)  
  
1.  The Demand\-Dial Interface Wizard will start. To complete the Demand\-Dial Interface Wizard, click Next.  
  
2.  On the **Interface Name** page, type **3\-EDGE1**. The interface name must match the user account name of the calling router.  
  
3.  Click **Next**. On the **Connection Type** page, select **Connect using virtual private networking \(VPN\)**.  
  
4.  Click **Next**. On the **VPN Type** page, select **IKEv2**.  
  
5.  Click **Next**. On the **Destination Address** page, type  **131.107.0.2** in the **Host name or IP address** box.  
  
6.  Click **Next**. On the **Protocols and Security** page, do the following:  
  
    1.  Select **Route IP packets on this interface**.  
  
    2.  Select **Add a user account so a remote router can dial in**.  
  
7.  Click **Next**. On the **Static Routes for Remote Networks** page, click **Add**.  
  
8.  In the **Static Route** dialog box, do the following:  
  
    1.  In the **Destination** box, type **10.0.0.0**.  
  
    2.  In the **Network Mask** box, type **255.255.255.0**.  
  
    3.  In the **Metric** box type **1**.  
  
9. Click **OK**. On the **Static Routes for Remote Networks** page, click **Next**.  
  
10. Click **Next**. On the **Dial In Credentials** page, type **Pass@word1** for the **EDGE1** user account, and then retype **Pass@word1** in the **Confirm password** box. The **User name** box is pre\-populated with the value **3\-EDGE1**.  
  
    > [!NOTE]  
    > The username for dial\-In credentials should be the same as the name of the site to site interface if the peer is Windows server site\-to\-site VPN.  
  
11. Click **Next**. On the **Dial Out Credentials** page, do the following:  
  
    1.  In the **User name** box, type **3\-EDGE1**.  
  
    2.  In the **Domain** box, type **corp.contoso.com**.  
  
    3.  In the **Password** box, type **Pass@word1** for the fabrikam user account that will be created on 3\-EDGE1.  
  
    4.  In the **Confirm password** box, retype the password for the **fabrikam** user account.  
  
        > [!NOTE]  
        > The username for dial\-out credentials should be the same as the name of the site to site interface if the peer is Windows server site\-to\-site VPN.  
  
12. Click **Next**. On the last **Demand\-Dial Interface Wizard** page, click **Finish**.  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]  
  
```  
Add-VpnS2SInterface  EDGE1  131.107.0.2 -Protocol IKEv2 -AuthenticationMethod EAP -UserName Contoso\3-EDGE1 -password Pass@word1 -IPv4Subnet 10.0.0.0/24:1  
  
```  
  
Optionally you can change the authentication method to preshared key. However, if you change the authentication method on 3\-EDGE1, you will also have to change it correspondingly on EDGE1.  
  
#### \(Optional\) Change the authentication method to preshared key  
  
1.  In the Routing and Remote Access snap\-in, expand **3\-EDGE1**, and then click **Network Interfaces**.  
  
2.  Right\-click **Remote Router** and then click **Properties**.  
  
3.  Click the **Security** tab and then select **Use preshared key for authentication**.  
  
4.  Type **abc** in **Key:**, and then click **OK**.  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]  
  
```  
Add-VpnS2SInterface 3-EDGE1  -Protocol IKEv2 –AuthenticationMethod –SharedSecret “abc”  
  
```  
  
#### Configure site\-to\-site on the VPN\-Corpnet router \(EDGE1\)  
  
1.  On **EDGE1**, click **Start**, and then click **Routing and Remote Access**.  
  
2.  In Routing and Remote Access, right\-click **EDGE1 \(local\)** in the console tree, and then click **Configure and Enable Routing and Remote Access**.  
  
3.  The Routing and Remote Access Server Setup Wizard appears. Click **Next**.  
  
4.  On the **Configuration** page, select **Secure connection between two private networks. Connect this network to a remote network such as a branch office.**, and then click **Next**.  
  
5.  On the **Demand\-Dial Connections** page, verify that **Yes** is checked and then click **Next**.  
  
6.  Click **Next**. On the **IP Address Assignment** page, select **Automatically**.  
  
7.  Click **Finish**  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]  
  
```  
ipmo servermanager  
add-windowsFeature -name  routing -IncludeManagementTools  
ipmo remoteaccess  
install-remoteaccess -vpntype vpns2s –IPv6Prefix 2001:db8:1:200::/64 -  
  
```  
  
#### Configure the demand\-dial interface on the VPN\-Corpnet router \(EDGE1\)  
  
1.  The Demand\-Dial Interface Wizard will start. To complete the Demand\-Dial Interface Wizard, click Next.  
  
2.  On the **Interface Name** page, type **EDGE1**. The interface name must match the user account name of the calling router.  
  
3.  Click **Next**. On the **Connection Type** page, select **Connect using virtual private networking \(VPN\)**.  
  
4.  Click **Next**. On the **VPN Type** page, select **IKEv2**.  
  
5.  Click **Next**. On the **Destination Address** page, type  **131.107.0.4** in the **Host name or IP address** box.  
  
6.  Click **Next**. On the **Protocols and Security** page, do the following:  
  
    1.  Select **Route IP packets on this interface**.  
  
    2.  Select **Add a user account so a remote router can dial in**.  
  
7.  Click **Next**. On the **Static Routes for Remote Networks** page, click **Add**.  
  
8.  In the **Static Route** dialog box, do the following:  
  
    1.  In the **Destination** box, type **192.168.1.0**.  
  
    2.  In the **Network Mask** box, type **255.255.255.0**.  
  
    3.  In the **Metric** box type **1**.  
  
9. Click **OK**. On the **Static Routes for Remote Networks** page, click **Next**.  
  
10. Click **Next**. On the **Dial In Credentials** page, type **Pass@word1** for the **EDGE1** user account, and then retype **Pass@word1** in the **Confirm password** box. The **User name** box is pre\-populated with the value **EDGE1**.  
  
11. Click **Next**. On the **Dial Out Credentials** page, do the following:  
  
    1.  In the **User name** box, type **3\-EDGE1**.  
  
    2.  In the **Domain** box, type **corp.fabrikam.com**.  
  
    3.  In the **Password** box, type **Pass@word1** for the VPN\_Corpnet user account that will be created on 3\-EDGE1.  
  
    4.  In the **Confirm password** box, retype the password for the VPN\_Corpnet user account.  
  
12. Click **Next**. On the last **Demand\-Dial Interface Wizard** page, click **Finish**.  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]  
  
```  
Add-VpnS2SInterface  3-EDGE1 131.107.0.4 -Protocol IKEv2 -AuthenticationMethod EAP -UsecName Fabrikam\EDGE1 -password Pass@word1 -IPv4Subnet 192.168.1.0 /24:1  
  
```  
  
Optionally you can change the authentication method to preshared key. However, if you change the authentication method on EDGE1, you should have also changed it correspondingly on 3\-EDGE1.  
  
#### \(Optional\) Change the authentication method to preshared key  
  
1.  In the Routing and Remote Access snap\-in, expand **3\-EDGE1**, and then click **Network Interfaces**.  
  
2.  Right\-click **Remote Router** and then click **Properties**.  
  
3.  Click the **Security** tab and then select **Use preshared key for authentication**.  
  
4.  Type **abc** in **Key:**, and then click **OK**.  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]  
  
```  
Add-VpnS2SInterface  EDGE1  -Protocol IKEv2 –AuthenticationMethod –SharedSecret “abc”  
  
```  
  
Initiate the VPN connection by performing the following steps on 3\-EDGE1.  
  
#### Initiate the site\-to\-site connection  
  
1.  On **3\-EDGE1**, in the console tree of the Routing and Remote Access snap\-in, click **Network Interfaces**.  
  
2.  In the details pane, right\-click **contoso**, and then click **Connect**.  
  
3.  Confirm that the connection state of **VPN\_Corpnet** is connected.  
  
#### Test the site\-to\-site connection  
  
1.  On **DC1** at the **Start** menu, type **cmd** and then hit **Enter**. At the command prompt, type **ping 10.6.0.2**. Verify that there are four replies from 10.6.0.2  
  
