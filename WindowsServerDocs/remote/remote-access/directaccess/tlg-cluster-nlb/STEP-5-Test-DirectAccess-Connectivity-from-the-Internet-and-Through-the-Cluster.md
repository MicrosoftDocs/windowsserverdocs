---
title: STEP 5 Test DirectAccess Connectivity from the Internet and Through the Cluster
description: This topic is part of the Test Lab Guide - Demonstrate DirectAccess in a Cluster with Windows NLB for Windows Server 2016
manager: brianlic
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-da
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8399bdfa-809a-45e4-9963-f9b6a631007f
ms.author: lizross
author: eross-msft
---
# STEP 5 Test DirectAccess Connectivity from the Internet and Through the Cluster

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

CLIENT1 is now ready for DirectAccess testing.  
  
- Test DirectAccess connectivity from the Internet. Connect CLIENT1 to the simulated Internet. When connected to the simulated Internet, the client is assigned public IPv4 addresses. When a DirectAccess client is assigned a public IPv4 address, it tries to establish a connection to the Remote Access server using an IPv6 transition technology.  
  
- Test DirectAccess client connectivity through the cluster. Test cluster functionality. Before you begin testing, we recommend that you shut down both EDGE1 and EDGE2 for at least five minutes. There are a number of reasons for this, which include ARP cache timeouts and changes related to NLB. When validating NLB configuration in a test lab, you will need to be patient as changes in configuration will not be immediately reflected in connectivity until after a period of time has elapsed. This is important to keep in mind when you carry out the following tasks.  
  
    > [!TIP]  
    > We recommend that you clear the Internet Explorer cache before performing this procedure and each time you test the connection through a different Remote Access server to make sure that you are testing the connection and not retrieving the webpages from the cache.  
  
## Test DirectAccess connectivity from the Internet  
  
1. Unplug CLIENT1 from the corpnet switch and connect it to the Internet switch. Wait for 30 seconds.  
  
2. In an elevated Windows PowerShell window, type **ipconfig /flushdns** and press ENTER. This flushes name resolution entries that may still exist in the client DNS cache from when the client computer was connected to the corpnet.  
  
3. In the Windows PowerShell window, type **Get-DnsClientNrptPolicy** and press ENTER.  
  
   The output shows the current settings for the Name Resolution Policy Table (NRPT). These settings indicate that all connections to .corp.contoso.com should be resolved by the Remote Access DNS server, with the IPv6 address 2001:db8:1::2. Also, note the NRPT entry indicating that there is an exemption for the name nls.corp.contoso.com; names on the exemption list are not answered by the Remote Access DNS server. You can ping the Remote Access DNS server IP address to confirm connectivity to the Remote Access server; for example, you can ping 2001:db8:1::2.  
  
4. In the Windows PowerShell window, type **ping app1** and press ENTER. You should see replies from the IPv6 address for APP1, which in this case is 2001:db8:1::3.  
  
5. In the Windows PowerShell window, type **ping app2** and press ENTER. You should see replies from the NAT64 address assigned by EDGE1 to APP2, which in this case is fdc9:9f4e:eb1b:7777::a00:4.  
  
   The ability to ping APP2 is important, because success indicates that you were able to establish a connection using NAT64/DNS64, as APP2 is an IPv4 only resource.  
  
6. Leave the Windows PowerShell window open for the next procedure.  
  
7. Open Internet Explorer, in the Internet Explorer address bar, enter **https://app1/** and press ENTER. You will see the default IIS website on APP1.  
  
8. In the Internet Explorer address bar, enter **https://app2/** and press ENTER. You will see the default website on APP2.  
  
9. On the **Start** screen, type<strong>\\\App2\Files</strong>, and then press ENTER. Double-click the New Text Document file.  
  
    This demonstrates that you were able to connect to an IPv4 only server using SMB to obtain a resource in the resource domain.  
  
10. On the **Start** screen, type**wf.msc**, and then press ENTER.  
  
11. In the **Windows Firewall with Advanced Security** console, notice that only the **Private** or **Public Profile** is active. The Windows Firewall must be enabled for DirectAccess to work correctly. If the Windows Firewall is disabled, DirectAccess connectivity does not work.  
  
12. In the left pane of the console, expand the **Monitoring** node, and click the **Connection Security Rules** node. You should see the active connection security rules: **DirectAccess Policy-ClientToCorp**, **DirectAccess Policy-ClientToDNS64NAT64PrefixExemption**, **DirectAccess Policy-ClientToInfra**, and **DirectAccess Policy-ClientToNlaExempt**. Scroll the middle pane to the right to show the **1st Authentication Methods** and **2nd Authentication Methods** columns. Notice that the first rule (ClientToCorp) uses Kerberos V5 to establish the intranet tunnel and the third rule (ClientToInfra) uses NTLMv2 to establish the infrastructure tunnel.  
  
13. In the left pane of the console, expand the **Security Associations** node, and click the **Main Mode** node. Notice the infrastructure tunnel security associations using NTLMv2 and the intranet tunnel security association using Kerberos V5. Right-click the entry that shows **User (Kerberos V5)** as the **2nd Authentication Method** and click **Properties**. On the **General** tab, notice the **Second authentication Local ID** is **CORP\User1**, indicating that User1 was able to successfully authenticate to the CORP domain using Kerberos.  
  
## Test DirectAccess client connectivity through the cluster  
  
1. Perform a graceful shutdown on EDGE2.  
  
   You can use the Network Load Balancing Manager to view the status of the servers when running these tests.  
  
2. On CLIENT1, in the Windows PowerShell window, type **ipconfig /flushdns** and press ENTER. This flushes name resolution entries that may still exist in the client DNS cache.  
  
3. In the Windows PowerShell window, ping APP1, and APP2. You should receive replies from both of these resources.  
  
4. On the **Start** screen, type<strong>\\\app2\files</strong>. You should see the shared folder on the APP2 computer. The ability to open the file share on APP2 indicates that the second tunnel, which requires Kerberos authentication for the user, is working correctly.  
  
5. Open Internet Explorer, and then open the websites https://app1/ and https://app2/. The ability to open both websites confirms that both the first and second tunnels are up and functioning. Close Internet Explorer.  
  
6. Start the EDGE2 computer.  
  
7. On EDGE1 perform a graceful shutdown.  
  
8. Wait for 5 minutes, and then return to CLIENT1. Perform steps 2-5. This confirms that CLIENT1 was able to transparently fail over to EDGE2 after EDGE1 became unavailable.
