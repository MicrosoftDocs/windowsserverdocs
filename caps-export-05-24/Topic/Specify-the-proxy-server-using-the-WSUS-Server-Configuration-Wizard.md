---
title: Specify the proxy server using the WSUS Server Configuration Wizard
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 27df34a9-f87a-4b17-a696-32b2805c4a51
author: britw
---
# Specify the proxy server using the WSUS Server Configuration Wizard
If a proxy server exists between this WSUS server and its designated upstream WSUS server, you must provide the proxy server information to WSUS. If you do not know the proxy server configuration information, see the network administrator.  
  
For more information about how to use WSUS with a proxy server, see the [Configure the proxy server](../Topic/Prepare-the-Network-and-Server-for-WSUS-3.0-SP2.md#proxy) section in this deployment guide.  
  
## <a name="procproxy"></a>To specify the proxy server  
  
-   If a proxy server does not exist between this WSUS server and the upstream WSUS server:  
  
    1.  On the **Specify Proxy Server** page of the WSUS server configuration wizard, leave all fields blank.  
  
    2.  Click **Next**.  
  
-   If a proxy server exists between this WSUS server and the upstream WSUS server:  
  
    1.  Select the check box for **Use proxy server when synchronizing**.  
  
    2.  In the **Proxy server name** text box, type the name of the proxy server.  
  
    3.  In the **Proxy port number** text box, type the port number of the proxy server. The default port number is 80.  
  
    4.  If the proxy server requires that you use a specific user account, select the **Use user credentials to connect to the proxy server** check box. Type the required user name, domain, and password into the corresponding text boxes.  
  
    5.  If the proxy server supports basic authentication, select the **Allow basic authentication \(password is sent in cleartext\)** check box.  
  
    6.  Click **Next**.  
  
