---
title: Install SQL native client on each RD Connection Broker server
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - remote-desktop-services
  - techgroup-compute
ms.author: elizapo
ms.date: 08/01/2016
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ca521c65-eab4-458e-b762-456ff043c4f7
author: lizap
manager: msswadhwa
---
# Install SQL native client on each RD Connection Broker server

>Applies To: Windows Server Technical Preview

Use the following steps to install a SQL native client on each RD COnnection Broker server:  
  
1. Create a public IP address for the first RD Connection Broker. (You only have to do this if the RDMS virtual machine does not already have a public IP address to allow RDP connections.)   
    1. In the Azure portal, click **Browse > Resource groups**, click the resource group for the deployment, and then click the first RD Connection Broker virtual machine (for example, Contoso-Cb1).  
    2. Click **Settings > Network interfaces**, and then click the corresponding network interface.   
    3. Click **Settings > IP address**.   
    4. For **Public IP address**, select **Enabled**, and then click **IP address**.   
    5. If you have an existing public IP address you want to use, select it from the list. Otherwise, click **Create new**, enter a name, and then click **OK** and then **Save**.   
2. Connect to the first RD Connection Broker:   
    1. In the Azure portal, click **Browse > Resource groups**, click the resource group for the deployment, and then click the first RD Connection Broker virtual machine (for example, Contoso-Cb1).    
    2. Click **Connect > Open** to open the Remote Desktop client.  
    3. In the client, click **Connect**, and then click **Use another user account**. Enter the user name and password for a domain administrator account.  
    4. Click **Yes** when warned about the certificate.    
3. Download the [Microsoft SQL Server 2012 Native Client x64 package](http://go.microsoft.com/fwlink/?LinkID=239648).  
4. Copy the sqlincli.msi file to the first RD Connection Broker server.   
5. Open the sqlincli.msi file and install the native client.  
6. Repeat steps 1-5 for each additional RD Connection Broker virtual machine (for example, Contoso-Cb2).


