---
title: Issues with the WSUS 3.0 SP2 Administration Console
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a7602334-3ead-425b-96b4-894c68f64b3e
author: britw
---
# Issues with the WSUS 3.0 SP2 Administration Console
If you get an error message when you use or try to access the WSUS administration console, use the following information to troubleshoot the problem.  
  
## Troubleshooting the WSUS administration console  
  
#### Cannot access the WSUS administration console and a timeout error message appears  
If you cannot access the WSUS console and a timeout error message appears, the CPU of the WSUS server may be at, or very close to, maximum utilization, which causes the database software to time out. If the database software times out, the WSUS console cannot be displayed.  
  
One way of inadvertently overtaxing your WSUS server is to have antivirus software monitor the WSUS content directory. During synchronization, the antivirus software can overload the CPU. You can work around this situation by setting the antivirus software to ignore the directory where WSUS content is stored.  
  
#### Get an error looking at a network load balance cluster if the "master" is unavailable  
If you are looking at a WSUS server on a network load balance cluster from a remote administration console, and the server that is currently the "master" server becomes unavailable, you may see the following error:  
  
```  
System.Net.Sockets.SocketException Message:  
No connection could be made because the target machine actively refused it  
Source: System  
Stack Trace:  
   at System.Net.Sockets.Socket.DoConnect(EndPoint endPointSnapshot, SocketAddress socketAddress)  
   at System.Net.Sockets.Socket.InternalConnect(EndPoint remoteEP)  
   at System.Net.ServicePoint.ConnectSocketInternal(Boolean connectFailure, Socket s4, Socket s6, Socket& socket, IPAddress& address, ConnectSocketState state, IAsyncResult asyncResult, Int32 timeout, Exception& exception)  
```  
  
You should wait at least 30 seconds before you click **Reset** on the error message.  
  
#### Cannot see client computers listed in the WSUS administration console  
If client computers do not appear on the **Computers** page in the WSUS administration console, there is probably a problem with computer self update, which is the mechanism that WSUS uses to update Automatic Update software. For more information about client self update, see [Issues with Client Computer Self-Update](../Topic/Issues-with-Client-Computer-Self-Update.md).  
  
#### Cannot see computers that have 100 percent installed state on the Computers page when the "Installed\/NotApplicable or No Status" filter is applied  
If there are locally published updates on the server, you may not see accurate status or counts for your computer because locally published updates interfere with the filtering mechanisms.  
  
#### Cannot connect to remote WSUS 3.0 server in a saved MMC console  
If you want to distribute an .msc file that connects to a server, you cannot create the .msc file on that server. Instead, use a console on another computer to connect to this server, and then save and distribute that .msc.  
  
#### Get error accessing WSUS 3.0 servers from the WSUS administration console because the WWW Publishing service is configured to allow interaction with the desktop  
If you attempt to access the WSUS administration console, and you fail to connect to the server, you may get the following error:  
  
```  
The WSUS administration console was unable to connect to the WSUS Server via the remote API.   
Verify that the Update Services service, IIS, and SQL are running on the server. If the problem persists, try restarting IIS, SQL, and the Update Services Service.  
The WSUS administration console has encountered an unexpected error. This may be a transient error; try restarting the administration console. If this error persists, try removing the persisted preferences for the console by deleting the wsus file under %appdata%\Microsoft\MMC\.  
System.IO.IOException -- The handshake failed due to an unexpected packet format.  
…  
```  
  
This error is probably due to the WWW Publishing service being configured to allow interaction with the desktop. To solve this problem, take the following steps:  
  
1.  Open the Services snap\-in \(click **Start**, click **Run**, and then type **services.msc**\).  
  
2.  Right\-click the World Wide Web Publishing service and select **Properties**.  
  
3.  On the **LogOn** tab, clear the **Allow service to interact with desktop** check box.  
  
4.  Click **OK**, and then close the Services snap\-in.  
  
5.  At a command prompt, type **iisreset**.  
  
6.  At this point you should be able to access the WSUS server from the administration console again.  
  
This error is caused by the issue that is described in [article 919085](http://go.microsoft.com/fwlink/?LinkId=86366)in the Microsoft Knowledge Base.  
  
#### Get other errors accessing WSUS 3.0 servers from the WSUS administration console  
In many cases, when you get a connection error, it may be helpful to run the **iisreset** command.  
  
