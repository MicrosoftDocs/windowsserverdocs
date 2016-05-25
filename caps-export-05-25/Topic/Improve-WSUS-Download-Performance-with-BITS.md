---
title: Improve WSUS Download Performance with BITS
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e2537c5c-3bc6-4428-a70b-128d11eaa124
author: britw
---
# Improve WSUS Download Performance with BITS
Windows Update and Microsoft Update use the Background Intelligent Transfer Service \(BITS\) to download updates. You can optimize download performance by configuring BITS through Group Policy. The following table shows the differences between BITS versions.  
  
|BITS version|Included in|Can also be downloaded for|  
|----------------|---------------|------------------------------|  
|4.0|-   [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]<br />-   [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)]|-   [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] with Service Pack 2 \(SP2\)<br />-   [!INCLUDE[firstref_vista](../Token/firstref_vista_md.md)] with Service Pack 1 \(SP1\)<br />-   [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)] with Service Pack 2 \(SP2\)<br /><br />For information about downloading BITS 4.0, see [article 968929](http://go.microsoft.com/fwlink/?LinkId=210776) in the Microsoft Download Center.|  
|3.0|-   [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]<br />-   [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)]||  
|2.5|-   [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]<br />-   [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)]<br />-   [!INCLUDE[windowsxp](../Token/windowsxp_md.md)] with Service Pack 3 \(SP3\)|-   [!INCLUDE[pnWinNetServer11](../Token/pnWinNetServer11_md.md)] with Service Pack 2 \(SP2\)<br />-   [!INCLUDE[pnWinNetServer11](../Token/pnWinNetServer11_md.md)] with Service Pack 1 \(SP1\)<br />-   [!INCLUDE[windowsxp](../Token/windowsxp_md.md)] with Service Pack 2 \(SP2\)<br /><br />To download BITS 2.5, see [article 923845](http://go.microsoft.com/fwlink/?LinkId=210777) in the Microsoft Download Center.|  
|2.0|-   [!INCLUDE[windowsxp](../Token/windowsxp_md.md)] with Service Pack 2 \(SP2\)<br />-   [!INCLUDE[pnWinNetServer11](../Token/pnWinNetServer11_md.md)] with Service Pack 1 \(SP1\)|-   [!INCLUDE[pnWinNetServer11](../Token/pnWinNetServer11_md.md)]<br />-   [!INCLUDE[windowsxp](../Token/windowsxp_md.md)] with Service Pack 1 \(SP1\) **Warning:** To obtain BITS 2.0, download the latest service pack for your operating system. Do not download BITS 2.0 directly from the Microsoft Download Center.|  
  
In this topic:  
  
-   [BITS bandwidth limitations](../Topic/Improve-WSUS-Download-Performance-with-BITS.md#throttle)  
  
-   [Peer caching](../Topic/Improve-WSUS-Download-Performance-with-BITS.md#peercache)  
  
## <a name="throttle"></a>BITS bandwidth limitations  
BITS uses a computer's network adapter to measure network traffic. \(BITS 3.0 can also use the Internet gateway device to monitor traffic if the computer is correctly configured.\) In some cases, the network adapter does not provide an accurate measurement of network traffic. For example, if a computer has a fast network adapter that runs over a slow network connection, BITS will report an overly optimistic measurement.  
  
> [!NOTE]  
> BITS bandwidth limitations affect the whole computer system. You cannot limit BITS bandwidth to only selected applications.  
  
#### To set BITS bandwidth limitations  
  
1.  Log on to the computer by using an account that is a member of the local Administrators group.  
  
2.  Click **Start**, click **Run**, type **gpedit.msc**, and then press ENTER.  
  
3.  In the left pane of the Group Policy Management Console \(GPMC\), expand **Computer Configuration**, expand **Administrative Templates**, expand **Network**, and then click **Background Intelligent Transfer Service**.  
  
4.  In the **Setting** pane, double\-click **Limit the maximum network bandwidth for BITS background transfers**.  
  
5.  In the top pane of the dialog box, click **Enabled**.  
  
6.  In the **Options** pane, set the transfer rate in kilobits per second \(Kbps\) that you want BITS to use. The default value is 10 Kbps.  
  
7.  Set the times during which you want to limit bandwidth. The default setting is from 12:00 A.M. to 12:00 A.M.  
  
8.  Set the limitations to use outside the designated time. The default setting is **Use all available unused bandwidth**.  
  
9. Click **OK** to save the settings.  
  
## <a name="peercache"></a>Peer caching  
Peer caching is a feature of BITS that enables *peer computers* to share files. Peer computers are computers that have the peer caching feature enabled and that are located in the same subnet. If peer caching is enabled on a computer, Automatic Updates instructs BITS to make downloaded files available to the computer's peers.  
  
> [!IMPORTANT]  
> For more information about peer caching in BITS 4.0 and BITS 3.0, see [Peer Caching](http://go.microsoft.com/fwlink/?LinkId=210779) on MSDN.  
  
When updates are downloaded, BITS caches them. When another peer caching\-enabled computer tries to download the same update, BITS sends a multicast request to all peers. If peer computers respond to the request, BITS downloads the file from the first peer computer to respond. If the download from the peer computer fails or take too long, BITS continues the download from the WSUS server or from Microsoft Update.  
  
Peer caching can optimize bandwidth in the following ways:  
  
1.  Decreases the data that is transferred from the WSUS server to client computers because computers in the same subnet will usually download the updates from each other.  
  
2.  Decreases the data that is transferred across the WAN when some or all of the client computers of a WSUS server are located in different locations.  
  
3.  Decreases the data that is transferred across the Internet if WSUS client computers that are located in the same subnet are configured to download updates from Microsoft Update.  
  
#### To enable peer caching  
  
1.  Log on to the computer by using an account that is a member of the local Administrators group.  
  
2.  Click **Start**, click **Run**, type **gpedit.msc**, and then press ENTER.  
  
3.  In the left pane of the Group Policy Management Console \(GPMC\), expand **Computer Configuration**, expand **Administrative Templates**, expand **Network**, and then click **Background Intelligent Transfer Service**.  
  
4.  In the **Setting** pane, double\-click **Allow BITS Peercaching**.  
  
5.  In the top pane of the dialog, click **Enabled**, and then click **OK**.  
  
6.  In the **Setting** pane, double\-click **Maximum network bandwidth used for Peercaching**.  
  
7.  In the top pane of the dialog box, click **Enabled**.  
  
8.  In the **Options** pane, set the maximum bandwidth in bits per second \(the default is 1048576\), and then click **OK**.  
  
9. In the **Setting** pane, double\-click **Limit the BITS Peercache size**.  
  
10. In the top pane of the dialog box, click **Enabled**.  
  
11. In the **Options** pane, set the percentage of disk space to use for the peer cache \(the default is 5 percent\), and then click **OK**.  
  
12. In the **Setting** pane, double\-click **Limit the age of files in the BITs Peercache**.  
  
13. In the top pane of the dialog box, click **Enabled**.  
  
14. In the **Options** pane, set the number of days \(the default is 90\), and then click **OK**.  
  
## See Also  
[Background Intelligent Transfer Service](http://go.microsoft.com/fwlink/?LinkId=210761)  
[BITS Infrastructure](http://go.microsoft.com/fwlink/?LinkId=202641)  
  
