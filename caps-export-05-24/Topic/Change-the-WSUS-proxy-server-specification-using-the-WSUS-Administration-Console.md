---
title: Change the WSUS proxy server specification using the WSUS Administration Console
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 49d6a618-dd6a-46a6-b81f-bfc49803cf35
author: britw
---
# Change the WSUS proxy server specification using the WSUS Administration Console
When you install the [!INCLUDE[wsus_firstref_30SP2](../Token/wsus_firstref_30SP2_md.md)] 3.0 SP2 server software, you are prompted to specify proxy server information. This topic describes how to change the proxy server information by using the WSUS Administration Console.  
  
For more information about how to configure a proxy server to work with WSUS, see [Configure the proxy server](../Topic/Prepare-the-Network-and-Server-for-WSUS-3.0-SP2.md#proxy) located in the [Prepare the Network and Server for WSUS 3.0 SP2](../Topic/Prepare-the-Network-and-Server-for-WSUS-3.0-SP2.md) topic of this deployment guide.  
  
### To change the proxy server information  
  
1.  Open the WSUS Administration Console.  
  
2.  In the left pane of the WSUS Administration Console, expand the server name, and then click **Options**.  
  
3.  In the **Options** pane, click **Update Source and Update Server**, and then click the **Proxy Server** tab.  
  
4.  Use the following options to modify the existing proxy server configuration:  
  
    -   To remove a proxy server from the WSUS configuration, clear the check box for **Use a proxy server when synchronizing**, and then click **OK**.  
  
    -   To change or add a proxy server to the WSUS configuration:  
  
        1.  Select the check box for **Use a proxy server when synchronizing**.  
  
        2.  In the **Proxy server name** text box, type the name of the proxy server.  
  
        3.  In the **Proxy port number** text box, type the port number of the proxy server. The default port number is 80.  
  
        4.  If the proxy server requires that you use a specific user account, select the **Use user credentials to connect to the proxy server** check box. Type the required user name, domain, and password into the corresponding text boxes.  
  
        5.  If the proxy server supports basic authentication, select the **Allow basic authentication \(password is sent in cleartext\)** check box.  
  
        6.  Click **OK**.  
  
