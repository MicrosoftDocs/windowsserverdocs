---
title: STEP 13 Test DirectAccess Connectivity from Behind a NAT Device
description: This topic is part of the Test Lab Guide - Demonstrate a DirectAccess Multisite Deployment for Windows Server 2016
manager: brianlic
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-da
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 796825c3-5e3e-4745-a921-25ab90b95ede
ms.author: lizross
author: eross-msft
---
# STEP 13 Test DirectAccess Connectivity from Behind a NAT Device

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

When a DirectAccess client is connected to the Internet from behind a NAT device or a web proxy server, the DirectAccess client uses either Teredo or IP-HTTPS to connect to the Remote Access server. If the NAT device enables outbound UDP port 3544 to the Remote Access server's public IP address, then Teredo is used. If Teredo access is not available, the DirectAccess client falls back to IP-HTTPS over outbound TCP port 443, which enables access through firewalls or web proxy servers over the traditional SSL port. If the web proxy requires authentication, the IP-HTTPS connection will fail. IP-HTTPS connections also fail if the web proxy performs outbound SSL inspection, due to the fact that the HTTPS session is terminated at the web proxy instead of the Remote Access server.  
  
The following procedures are performed on both client computers:  
  
1. Test Teredo connectivity. The first set of tests are performed when the DirectAccess client is configured to use Teredo. This is the automatic setting when the NAT device allows outbound access to UDP port 3544. First run the tests on CLIENT1 and then run the tests on CLIENT2.  
  
2. Test IP-HTTPS connectivity. The second set of tests are performed when the DirectAccess client is configured to use IP-HTTPS. In order to demonstrate IP-HTTPS connectivity, Teredo is disabled on the client computers. First run the tests on CLIENT1 and then run the tests on CLIENT2.  
  
## Prerequisites  
Start EDGE1 and 2-EDGE1 if they are not already running, and make sure they are connected to the Internet subnet.  
  
Before performing these tests, unplug CLIENT1 and CLIENT2 from the Internet switch and connect them to the Homenet switch. If asked what type of network you want to define the current network, select **Home network**.  
  
## <a name="TeredoCLIENT1"></a>Test Teredo connectivity  
  
1. On CLIENT1, open an elevated Windows PowerShell window.  
  
2. Enable the Teredo adapter, type **netsh interface teredo set state enterpriseclient**, and then press ENTER.  
  
3. In the Windows PowerShell window, type **ipconfig /all** and press ENTER.  
  
4. Examine the output of the ipconfig command.  
  
   This computer is now connected to the Internet from behind a NAT device and is assigned a private IPv4 address. When the DirectAccess client is behind a NAT device and assigned a private IPv4 address, the preferred IPv6 transition technology is Teredo. If you look at the output of the ipconfig command, you should see a section for Tunnel adapter Teredo Tunneling Pseudo-Interface and then a description Microsoft Teredo Tunneling Adapter, with an IP address that starts with 2001:0 consistent with being a Teredo address. You should see the default gateway listed for the Teredo tunnel adapter as '::'.  
  
5. In the Windows PowerShell window, type **ipconfig /flushdns** and press ENTER.  
  
   This will flush name resolution entries that may still exist in the client DNS cache from when the client computer was connected to the Internet.  
  
6. In the Windows PowerShell window, type **ping app1** and press ENTER. You should see replies from the IPv6 address of APP1, 2001:db8:1::3.  
  
7. In the Windows PowerShell window, type **ping app2** and press ENTER. You should see replies from the NAT64 address assigned by EDGE1 to APP2, which in this case is fd**c9:9f4e:eb1b**:7777::a00:4. Note that the bold values will vary due to how the address is generated.  
  
8. In the Windows PowerShell window, type **ping 2-app1** and press ENTER. You should see replies from the IPv6 address of 2-APP1, 2001:db8:2::3.  
  
9. Open Internet Explorer, in the Internet Explorer address bar, enter **https://2-app1/** and press ENTER. You will see the default IIS website on 2-APP1.  
  
10. In the Internet Explorer address bar, enter **https://app2/** and press ENTER. You will see the default website on APP2.  
  
11. On the **Start** screen, type<strong>\\\App2\Files</strong>, and then press ENTER. Double-click the New Text Document file. This demonstrates that you were able to connect to an IPv4 only server using SMB to obtain a resource on an IPv4 only host.  
  
12. Repeat this procedure on CLIENT2.  
  
## <a name="IPHTTPS_CLIENT1"></a>Test IP-HTTPS connectivity  
  
1. On CLIENT1, open an elevated Windows PowerShell window, and type **netsh interface teredo set state disabled** and press ENTER. This disables Teredo on the client computer and enables the client computer to configure itself to use IP-HTTPS. An **Ok** response appears when the command completes.  
  
2. In the Windows PowerShell window, type **ipconfig /all** and press ENTER.  
  
3. Examine the output of the ipconfig command. This computer is now connected to the Internet from behind a NAT device and is assigned a private IPv4 address. Teredo is disabled and the DirectAccess client falls back to IP-HTTPS. When you look at the output of the ipconfig command, you see a section for Tunnel adapter iphttpsinterface with an IP address that starts with 2001:db8:1:1000 or 2001:db8:2:2000 consistent with this being an IP-HTTPS address based on the prefixes that were configured when setting up DirectAccess. You will not see a default gateway listed for the IPHTTPSInterface tunnel adapter.  
  
4. In the Windows PowerShell window, type **ipconfig /flushdns** and press ENTER. This will flush name resolution entries that may still exist in the client DNS cache from when the client computer was connected to the corpnet.  
  
5. In the Windows PowerShell window, type **ping app1** and press ENTER. You should see replies from the IPv6 address of APP1, 2001:db8:1::3.  
  
6. In the Windows PowerShell window, type **ping app2** and press ENTER. You should see replies from the NAT64 address assigned by EDGE1 to APP2, which in this case is fd**c9:9f4e:eb1b**:7777::a00:4. Note that the bold values will vary due to how the address is generated.  
  
7. In the Windows PowerShell window, type **ping 2-app1** and press ENTER. You should see replies from the IPv6 address of 2-APP1, 2001:db8:2::3.  
  
8. Open Internet Explorer, in the Internet Explorer address bar, enter **https://2-app1/** and press ENTER. You will see the default IIS website on 2-APP1.  
  
9. In the Internet Explorer address bar, enter **https://app2/** and press ENTER. You will see the default website on APP2.  
  
10. On the **Start** screen, type<strong>\\\App2\Files</strong>, and then press ENTER. Double-click the New Text Document file. This demonstrates that you were able to connect to an IPv4 only server using SMB to obtain a resource on an IPv4 only host.  
  
11. Repeat this procedure on CLIENT2.  
  


