---
title: STEP 12 Test DirectAccess Connectivity
description: This topic is part of the Test Lab Guide - Demonstrate a DirectAccess Multisite Deployment for Windows Server 2016
manager: brianlic
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-da
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 65ac1c23-3a47-4e58-888d-9dde7fba1586
ms.author: lizross
author: eross-msft
---
# STEP 12 Test DirectAccess Connectivity

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

Before you can test connectivity from the client computers when they are located on the Internet or Homenet networks, you must make sure they have the correct group policy settings.  
  
- To verify clients have the correct group policy  
  
- Test DirectAccess connectivity from the Internet through EDGE1  
  
- Move CLIENT2 to the Win7_Clients_Site2 security group  
  
- Test DirectAccess connectivity from the Internet through 2-EDGE1  
  
## Prerequisites  
Connect both client computers to the Corpnet network, and then restart both client computers.  
  
## <a name="policy"></a>Verify clients have the correct group policy  
  
1.  On CLIENT1, click **Start**, type **powershell.exe**, right-click **powershell**, click **Advanced**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.  
  
2.  In the Windows PowerShell window, type **ipconfig** and press ENTER.  
  
    Make sure that the Corpnet adapter IPv4 address starts with 10.0.0.  
  
3.  In the Windows PowerShell window type **Get-DnsClientNrptPolicy** and press ENTER. The Name Resolution Policy Table (NRPT) entries for DirectAccess are displayed.  
  
    -   .corp.contoso.com-These settings indicate that all connections to corp.contoso.com should be resolved by one of the DirectAccess DNS servers, with the IPv6 address 2001:db8:1::2 or 2001:db8:2::20.  
  
    -   nls.corp.contoso.com-These settings indicate that there is an exemption for the name nls.corp.contoso.com.  
  
4.  Leave the Windows PowerShell window open for the next procedure.  
  
5.  On CLIENT2, click **Start**, click **All Programs**, click **Accessories**, click **Windows PowerShell**, right-click **Windows PowerShell**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.  
  
6.  In the Windows PowerShell window, type **ipconfig** and press ENTER.  
  
    Make sure that the Corpnet adapter IPv4 address starts with 10.0.0.  
  
7.  In the Windows PowerShell window, type **netsh namespace show policy** and press ENTER.  
  
    In the output, there should be two sections:  
  
    -   .corp.contoso.com-These settings indicate that all connections to corp.contoso.com should be resolved by the DirectAccess DNS server, with the IPv6 address 2001:db8:1::2.  
  
    -   nls.corp.contoso.com-These settings indicate that there is an exemption for the name nls.corp.contoso.com.  
  
8.  Leave the Windows PowerShell window open for the next procedure.  
  
## <a name="EDGE1"></a>Test DirectAccess connectivity from the Internet through EDGE1  
  
1. Unplug 2-EDGE1 from the Internet network.  
  
2. Unplug CLIENT1 and CLIENT2 from the corpnet switch and connect them to the Internet switch. Wait for 30 seconds.  
  
3. On CLIENT1, in the Windows PowerShell window, type **ipconfig /all** and press ENTER.  
  
4. Examine the output from the ipconfig command.  
  
   The client computer is now connected to the Internet and has a public IPv4 address. When the DirectAccess client has a public IPv4 address, it uses the Teredo or IP-HTTPS IPv6 transition technologies to tunnel the IPv6 messages over an IPv4 Internet between the DirectAccess client and Remote Access server. Note that Teredo is the preferred transition technology.  
  
5. In the Windows PowerShell window, type **ipconfig /flushdns** and press ENTER. This flushes name resolution entries that may still exist in the client DNS cache from when the client computer was connected to the corpnet.  
  
6. Disable the Teredo interface to ensure that the client computer uses IP-HTTPS to connect to corpnet with the following command:  
  
   ```  
   netsh interface teredo set state disable  
   ```  
  
7. Ensure you are connected through EDGE1. Type **netsh interface httpstunnel show interfaces** and press ENTER.  
  
   The output should contain URL : https://edge1.contoso.com:443/IPHTTPS.  
  
   > [!TIP]  
   > On CLIENT1, you can also run the following Windows PowerShell command: **Get-NetIPHTTPSConfiguration**. The output shows the available server URL connections and the currently active profile.  
  
8. In the Windows PowerShell window, type **ping app1** and press ENTER. You should see replies from the IPv6 address assigned to APP1, which in this case is 2001:db8:1::3.  
  
9. In the Windows PowerShell window, type **ping 2-app1** and press ENTER. You should see replies from the IPv6 address assigned to 2-APP1, which in this case is 2001:db8:2::3.  
  
10. In the Windows PowerShell window, type **ping app2** and press ENTER. You should see replies from the NAT64 address assigned by EDGE1 to APP2, which in this case is fd**c9:9f4e:eb1b**:7777::a00:4. Note that the bold values will vary due to how the address is generated.  
  
    The ability to ping APP2 is important, because success indicates that you were able to establish a connection using NAT64/DNS64, as APP2 is an IPv4 only resource.  
  
11. Open Internet Explorer, in the Internet Explorer address bar, enter **https://app1/** and press ENTER. You will see the default IIS website on APP1.  
  
12. In the Internet Explorer address bar, enter **https://2-app1/** and press ENTER. You will see the default website on 2-APP1.  
  
13. In the Internet Explorer address bar, enter **https://app2/** and press ENTER. You will see the default website on APP2.  
  
14. On the **Start** screen, type<strong>\\\2-App1\Files</strong>, and then press ENTER. Double-click the example text file.  
  
    This demonstrates that you were able to connect to the file server in the corp2.corp.contoso.com domain when connected through EDGE1.  
  
15. On the **Start** screen, type<strong>\\\App2\Files</strong>, and then press ENTER. Double-click the New Text Document file.  
  
    This demonstrates that you were able to connect to an IPv4 only server using SMB to obtain a resource in the resource domain.  
  
16. On the **Start** screen, type**wf.msc**, and then press ENTER.  
  
17. In the **Windows Firewall with Advanced Security** console, notice that only the **Public Profile** is active. The Windows Firewall must be enabled for DirectAccess to work correctly. If the Windows Firewall is disabled, DirectAccess connectivity does not work.  
  
18. In the left pane of the console, expand the **Monitoring** node, and click the **Connection Security Rules** node. You should see the active connection security rules: **DirectAccess Policy-ClientToCorp**, **DirectAccess Policy-ClientToDNS64NAT64PrefixExemption**, **DirectAccess Policy-ClientToInfra**, and **DirectAccess Policy-ClientToNlaExempt**. Scroll the middle pane to the right to show the **1st Authentication Methods** and **2nd Authentication Methods** columns. Notice that the first rule (ClientToCorp) uses Kerberos V5 to establish the intranet tunnel and the third rule (ClientToInfra) uses NTLMv2 to establish the infrastructure tunnel.  
  
19. In the left pane of the console, expand the **Security Associations** node, and click the **Main Mode** node. Notice the infrastructure tunnel security associations using NTLMv2 and the intranet tunnel security association using Kerberos V5. Right-click the entry that shows **User (Kerberos V5)** as the **2nd Authentication Method** and click **Properties**. On the **General** tab, notice the **Second authentication Local ID** is **CORP\User1**, indicating that User1 was able to successfully authenticate to the CORP domain using Kerberos.  
  
20. Repeat this procedure from step 3 on CLIENT2.  
  
## <a name="secgroup"></a>Move CLIENT2 to the Win7_Clients_Site2 security group  
  
1.  On DC1, click **Start**, type **dsa.msc**, and then press ENTER.  
  
2.  In the Active Directory Users and Computers console, open **corp.contoso.com/Users** and double-click **Win7_Clients_Site1**.  
  
3.  On the **Win7_Clients_Site1 Properties** dialog box, click the **Members** tab, click **CLIENT2**, click **Remove**, click **Yes**, and then click **OK**.  
  
4.  Double-click **Win7_Clients_Site2**, and then on the **Win7_Clients_Site2 Properties** dialog box, click the **Members** tab.  
  
5.  Click **Add**, and on the **Select Users, Contacts, Computers, or Service Accounts** dialog box, click **Object Types**, select **Computers**, and then click **OK**.  
  
6.  In **Enter the object names to select**, type **CLIENT2**, and then click **OK**.  
  
7.  Restart CLIENT2 and log on using the corp/User1 account.  
  
8.  On CLIENT2, open an elevated Windows PowerShell window, type **netsh namespace show policy** and press ENTER.  
  
    In the output, there should be two sections:  
  
    -   .corp.contoso.com-These settings indicate that all connections to corp.contoso.com should be resolved by the DirectAccess DNS server, with the IPv6 address 2001:db8:2::20.  
  
    -   nls.corp.contoso.com-These settings indicate that there is an exemption for the name nls.corp.contoso.com.  
  
## <a name="DAConnect"></a>Test DirectAccess connectivity from the Internet through 2-EDGE1  
  
1. Connect 2-EDGE1 to the Internet network.  
  
2. Unplug EDGE1 from the Internet network.  
  
3. On CLIENT1, open an elevated Windows PowerShell window.  
  
4. In the Windows PowerShell window, type **ipconfig /flushdns** and press ENTER. This flushes name resolution entries that may still exist in the client DNS cache from when the client computer was connected to the corpnet.  
  
5. Ensure you are connected through 2-EDGE1. Type **netsh interface httpstunnel show interfaces** and press ENTER.  
  
   The output should contain URL : https://2-edge1.contoso.com:443/IPHTTPS.  
  
   > [!TIP]  
   > On CLIENT1, you can also run the following command: **Get-NetIPHTTPSConfiguration**. The output shows the available server URL connections and the currently active profile.  
  
   > [!NOTE]  
   > CLIENT1 automatically changes the server through which it connects to corporate resources. If the output of the command shows a connection to EDGE1, wait for approximately five minutes and then try again.  
  
6. In the Windows PowerShell window, type **ping app1** and press ENTER. You should see replies from the IPv6 address assigned to APP1, which in this case is 2001:db8:1::3.  
  
7. In the Windows PowerShell window, type **ping 2-app1** and press ENTER. You should see replies from the IPv6 address assigned to 2-APP1, which in this case is 2001:db8:2::3.  
  
8. In the Windows PowerShell window, type **ping app2** and press ENTER. You should see replies from the NAT64 address assigned by EDGE1 to APP2, which in this case is fd**c9:9f4e:eb1b**:7777::a00:4. Note that the bold values will vary due to how the address is generated.  
  
   The ability to ping APP2 is important, because success indicates that you were able to establish a connection using NAT64/DNS64, as APP2 is an IPv4 only resource.  
  
9. Open Internet Explorer, in the Internet Explorer address bar, enter **https://app1/** and press ENTER. You will see the default IIS website on APP1.  
  
10. In the Internet Explorer address bar, enter **https://2-app1/** and press ENTER. You will see the default website on APP2.  
  
11. In the Internet Explorer address bar, enter **https://app2/** and press ENTER. You will see the default website on APP3.  
  
12. On the **Start** screen, type<strong>\\\App1\Files</strong>, and then press ENTER. Double-click the example text file.  
  
    This demonstrates that you were able to connect to the file server in the corp.contoso.com domain when connected through 2-EDGE1.  
  
13. On the **Start** screen, type<strong>\\\App2\Files</strong>, and then press ENTER. Double-click the New Text Document file.  
  
    This demonstrates that you were able to connect to an IPv4 only server using SMB to obtain a resource in the resource domain.  
  
14. Repeat this procedure on CLIENT2 from step 3.  
  


