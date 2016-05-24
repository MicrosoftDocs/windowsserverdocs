---
title: STEP 6: Test DirectAccess Connectivity from the Homenet Subnet
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ba1652a6-0692-4add-91ca-34a84956ba14
---
# STEP 6: Test DirectAccess Connectivity from the Homenet Subnet
The DirectAccess one\-time password \(OTP\) deployment is now complete and you can start to test connectivity from the Homenet subnet.  
  
### To test OTP functionality from the Homenet subnet on CLIENT1  
  
1.  On CLIENT1, make sure that you are logged on as **User1**.  
  
2.  [!INCLUDE[clickstart](../Token/clickstart_md.md)]**powershell.exe**, right\-click **powershell**, click **Advanced**, and then click **Run as administrator**. [!INCLUDE[uac_confirm_action](../Token/uac_confirm_action_md.md)]  
  
3.  In the [!INCLUDE[wps_2](../Token/wps_2_md.md)] window, type **gpupdate \/force**, and press ENTER.  
  
4.  Unplug CLIENT1 from the Corpnet subnet and connect it to the Homenet subnet.  
  
5.  On CLIENT1, open Internet Explorer, and in the address bar, type **http:\/\/app1.corp.contoso.com\/** and press ENTER. Press F5.  
  
    The site should not open.  
  
6.  [!INCLUDE[clickstart](../Token/clickstart_md.md)]**RSA**, and click **RSA SecurID Token**.  
  
7.  Wait until the RSA SecurID token changes the One\-time password, and then click **Copy**.  
  
8.  Click the **Network connections** icon in the notification area to access the DA Media Manager.  
  
9. Click **Contoso DirectAccess Connection**, and click **Continue**.  
  
10. Press Control\+Alt\+Delete, and click the **One\-time password \(OTP\)** tile.  
  
11. Paste the previously copied eight digit tokencode, and click **OK**. Wait for authentication to complete. The DirectAccess Workplace Connection status will now be **Connected**.  
  
12. In Internet Explorer, in the address bar, type **http:\/\/app1.corp.contoso.com\/** and press ENTER. Press F5. You will see the default IIS website on APP1.  
  
13. In the Internet Explorer address bar, type **http:\/\/app2.corp.contoso.com\/** and press ENTER. Press F5. You will see the default IIS website on APP2.  
  
14. [!INCLUDE[clickstart](../Token/clickstart_md.md)]**\\\\app1\\files**, and press ENTER.  
  
15. In the **Files** shared folder window, double\-click the **Example.txt** file. You will see the contents of the Example.txt file.  
  
16. [!INCLUDE[clickstart](../Token/clickstart_md.md)]**\\\\app2\\files**, and press ENTER.  
  
17. In the **Files** shared folder window, double\-click the **New Text Document.txt** file. You will see the contents of the New Text Document.txt file.  
  
