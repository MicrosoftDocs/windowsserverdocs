---
title: Install the ODBC driver for SQL on each RD Connection Broker server
description: Learn how to install the ODBC driver for SQL Server on an RD Connection Broker
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: elizapo
ms.date: 11/14/2016
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ca521c65-eab4-458e-b762-456ff043c4f7
author: lizap
manager: dongill
---
# Install the ODBC driver for SQL on each RD Connection Broker server 

>Applies To: Windows Server 2016

Remote Desktop Services uses an ODBC driver to access Azure SQL. Use the following steps to install an ODBC driver on each RD Connection Broker server:  
  
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
3. Download the [ODBC driver for SQL Server](https://www.microsoft.com/download/confirmation.aspx?id=50420) that matches the version in the ODBC connection string.

   >[!NOTE]
   > You got the ODBC connection string in Step 2 of [Create an Azure SQL database for the RD Connection Broker](create-an-azure-sql-database-for-the-rd-connection-broker.md).
   
4. Copy the sqlincli.msi file to the first RD Connection Broker server.   
5. Open the sqlincli.msi file and install the native client.  
6. Repeat steps 1-5 for each additional RD Connection Broker virtual machine (for example, Contoso-Cb2).
