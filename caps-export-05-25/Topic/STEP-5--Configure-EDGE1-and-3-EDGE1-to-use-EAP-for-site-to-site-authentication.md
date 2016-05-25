---
title: STEP 5: Configure EDGE1 and 3-EDGE1 to use EAP for site-to-site authentication
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8f22b0d6-6d71-438a-85f5-33d7468a7aed
author: coreyp
---
# STEP 5: Configure EDGE1 and 3-EDGE1 to use EAP for site-to-site authentication
  
#### Change the authentication method to EAP in EDGE1  
  
1.  On EDGE1, In the **Routing and Remote Access** snap\-in, expand **EDGE1**, and then click **Network Interfaces**.  
  
2.  Right\-click **EDGE1@corp.contoso.com** and then click **Properties**.  
  
3.  Click the **Security** tab and then select **Use Extensible Authentication Protocol \(EAP\)**.  
  
4.  Right\-click the **IPsec** template in the list, and then click **Duplicate Template**.  
  
5.  Select **EAP\-MSCHAP V2** in the dropdown menu  
  
6.  Click Ok.  
  
7.  When prompted for username\\password, enter **3\-EDGE1**, **Pass@word1**  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]. Use the **ipconfig \/all** command to list all the interfaces.  
  
```  
Set-VpnS2SInterface  EDGE1  -Protocol IKEv2 –AuthenticationMethod –EAP –UserName "3edge1" –Password Pass@word1  
```  
  
#### Change the authentication method to EAP in 3\-EDGE1  
  
1.  On EDGE1, In the **Routing and Remote Access** snap\-in, expand **EDGE1**, and then click **Network Interfaces**.  
  
2.  Right\-click **EDGE1@corp.fabrikam.com** and then click **Properties**  
  
3.  Click the **Security** tab and then select **Use Extensible Authentication Protocol \(EAP\)**.  
  
4.  Select **EAP\-MSCHAP V2** in the dropdown menu.  
  
5.  Click **Ok**.  
  
6.  When prompted for username\\password, enter **edge1**, **Pass@word1**  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]. Use the **ipconfig \/all** command to list all the interfaces.  
  
```  
Set-VpnS2SInterface  EDGE1  -Protocol IKEv2 –AuthenticationMethod –EAP –UserName "edge1" –Password Pass@word1  
```  
  
#### Initiate the site\-to\-site connection  
  
1.  **On 3\-EDGE1**, in the console tree of the **Routing and Remote Access** snap\-in, click **Network Interfaces**.  
  
2.  In the **Details** pane, right\-click **edge1@corp.fabrikam.com**, and then click **Connect**.  
  
3.  Confirm that the connection state of **VPN\_Corpnet** is connected.  
  
#### Test the site\-to\-site connection  
  
1.  On **DC1** at the **Start** menu, type **cmd** and then hit **Enter**. At the command prompt, type **ping 10.6.0.2**. Verify that there are four replies from 10.6.0.2. On 3\-EDGE1, in the **Internet Explorer** address bar, type **http:\/\/localhost\/certsrv**, and then press **ENTER**.  
  
