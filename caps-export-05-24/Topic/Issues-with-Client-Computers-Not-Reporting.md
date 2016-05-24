---
title: Issues with Client Computers Not Reporting
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6bcc207a-4e3c-4063-afa4-fac6b4c620e7
author: britw
---
# Issues with Client Computers Not Reporting
If you have configured client computers for a particular WSUS server, but they have not reported over a period of days, use the following procedures to isolate and repair the problem.  
  
## Troubleshooting client computers that are not reporting issues  
  
### Check the HTTP hotfix  
Some client computers have been affected by a known issue with Windows Server 2003 http.sys and Internet Information Services \(IIS\). In some cases this transient issue will prevent client computers from checking in, because they receive incorrect responses from the server after a number of attempts. For more information about this issue, see [article 898708](http://go.microsoft.com/fwlink/?LinkId=80715) in the Microsoft Download Center.  
  
> [!NOTE]  
> Failure of clients to contact the server is not related to compression. Administrators should not disable IIS compression, because allowing noncompressed data can increase network traffic and server load, while reducing the number of client computers that can be served effectively.  
  
### Troubleshoot client computer connectivity  
Ensure that the client computer connection to the WSUS server is working properly.  
  
##### To troubleshoot client computer connectivity  
  
1.  Open a Command Prompt window.  
  
2.  Contact the WSUS server: **ping***WSUSServerName*.  
  
3.  Contact the WSUS HTTP server. Open Internet Explorer and in the address bar, type: **http:\/\/***WSUSServerName***:***portNumber* where *WSUSServerName* is the name of the WSUS server, and *portNumber* is the port that has been configured for it \(for example, 80 for HTTP, 443 for SSL, and 8530 for a custom port\).  
  
4.  Verify the existence of the self\-update tree. In an Internet Explorer address bar, type: **http:\/\/***WSUSServerName*\/**selfupdate\/wuident.cab**  
  
5.  If the WSUS server is functioning properly, you should see a **File Download** window that asks you whether to open or save the file. Close the window.  
  
> [!NOTE]  
> If you do not see the **File Download** window, make sure that the self\-update tree on the client computer has been configured properly. For more information, see [Issues with Client Computer Self-Update](../Topic/Issues-with-Client-Computer-Self-Update.md).  
  
### Troubleshoot the Automatic Update client  
Ensure that the Automatic Update client has been configured correctly.  
  
##### To troubleshoot the Automatic Update client  
  
1.  Open a Command Prompt  window.  
  
2.  Type:  
    **reg query HKLM\\SOFTWARE\\Policies\\Microsoft\\Windows\\WindowsUpdate**.  
  
    You should see output like the following if the client computer has been configured to get its updates from a WSUS server:  
  
    ```  
    HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate  
    WUServer    REG_SZ  http://WSUSServerName  
    WUStatusServer      REG_SZ  http://WSUSServerName  
    HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU  
    ```  
  
    You should see output similar to the following if Automatic Update is functioning, but the client computer has not been configured to get its updates from a WSUS server:  
  
    ```  
    HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate  
    HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU  
    ```  
  
    If the query returns the error, "The system was unable to find the specified registry key or value," Automatic Update has not been configured on this computer.  
  
    If the output from Step 2 contains values for WUServer and WUStatusServer, try to contact the WSUS server that is listed in these values.  
  
3.  Open Internet Explorer and in the address bar type **http:\/\/***WUServer*  
    where *WUServer* stands for the value in the output from Step 2.  
  
    You should see an "Under Construction" page if the *WUServer* value is valid. If it is not, you will get an HTTP error message.  
  
### Reset the Automatic Update client  
It can be a good idea to reset the Automatic Update client if you are experiencing difficulty contacting the WSUS server with the **wuauclt** utility. For more information about **wuauclt**, see [Appendix H: The wuauclt Utility &#91;SP\_2&#93;](assetId:///7cc1c5f9-5678-4bb4-a7a6-18939dcc120c).  
  
##### To reset the Automatic Update client  
  
1.  Open a Command Prompt window.  
  
2.  Type **wuauclt.exe \/resetauthorization \/detectnow**.  
  
3.  Wait 10 minutes for the detection cycle to finish.  
  
