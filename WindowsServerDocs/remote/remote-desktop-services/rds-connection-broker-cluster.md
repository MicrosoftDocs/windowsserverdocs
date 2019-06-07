---
title: Add an RD Connection Broker server to configure high availability in RDS
description: Learn how to add an RD Connection Broker to an RDS deployment for high availability.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: elizapo
ms.date: 04/10/2017
ms.tgt_pltfrm: na
ms.topic: article
author: lizap
manager: dongill
---
# Add the RD Connection Broker server to the deployment and configure high availability

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016

You can deploy a Remote Desktop Connection Broker (RD Connection Broker) cluster to improve the availability and scale of your Remote Desktop Services infrastructure. 

## Pre-requisites

Set up a server to act as a second RD Connection Broker—this can be either a physical server or a VM.

Set up a database for the Connection Broker. You can use [Azure SQL Database](https://azure.microsoft.com/documentation/articles/sql-database-get-started/#create-a-new-aure-sql-database) instance or SQL Server in your local environment. We talk about using Azure SQL below, but the steps still apply to SQL Server. You'll need to find the connection string for the database and make sure you have the correct ODBC driver.

## Step 1: Configure the database for the Connection Broker

1. Find the connection string for the database you created - you need it both to identify the version of ODBC driver you need and later, when you're configuring the Connection Broker itself (step 3), so save the string someplace where you can reference it easily. Here's how you find the connection string for Azure SQL:  
    1. In the Azure portal, click **Browse > Resource groups** and click the resource group for the deployment.   
    2. Select the SQL database you just created (for example, CB-DB1).   
    3. Click **Settings** > **Properties** > **Show database connection strings**.   
    4. Copy the connection string for **ODBC (includes Node.js)**, which should look like this:   
      
        ```
        Driver={SQL Server Native Client 13.0};Server=tcp:cb-sqls1.database.windows.net,1433;Database=CB-DB1;Uid=sqladmin@contoso;Pwd={your_password_here};Encrypt=yes;TrustServerCertificate=no;Connection Timeout=30;
        ```
  
    5. Replace "your_password_here" with the actual password. You'll use this entire string, with your included password, when connecting to the database. 
2. Install the ODBC driver on the new Connection Broker: 
   1. If you are using a VM for the Connection Broker, create a public IP address for the first RD Connection Broker. (You only have to do this if the RDMS virtual machine does not already have a public IP address to allow RDP connections.)
       1. In the Azure portal, click **Browse** > **Resource groups**, click the resource group for the deployment, and then click the first RD Connection Broker virtual machine (for example, Contoso-Cb1).
       2. Click **Settings > Network interfaces**, and then click the corresponding network interface.
       3. Click **Settings > IP address**.
       4. For **Public IP address**, select **Enabled**, and then click **IP address**.
       5. If you have an existing public IP address you want to use, select it from the list. Otherwise, click **Create new**, enter a name, and then click **OK** and then **Save**.
   2. Connect to the first RD Connection Broker:
       1. In the Azure portal, click **Browse** > **Resource groups**, click the resource group for the deployment, and then click the first RD Connection Broker virtual machine (for example, Contoso-Cb1).
       2. Click **Connect > Open** to open the Remote Desktop client.
       3. In the client, click **Connect**, and then click **Use another user account**. Enter the user name and password for a domain administrator account.
       4. Click **Yes** when warned about the certificate.
   3. Download the [ODBC driver for SQL Server](https://www.microsoft.com/download/confirmation.aspx?id=50420) that matches the version in the ODBC connection string. For the example string above, we need to install the version 13 ODBC driver.
   4. Copy the sqlincli.msi file to the first RD Connection Broker server.   
   5. Open the sqlincli.msi file and install the native client.  
   6. Repeat steps 1-5 for each additional RD Connection Brokers (for example, Contoso-Cb2).
   7. Install the ODBC driver on each server that will run the connection broker.

## Step 2: Configure load balancing on the RD Connection Brokers 

If you are using Azure infrastructure, you can create an [Azure load balancer](#create-a-load-balancer); if not, you can set up [DNS round-robin](#configure-dns-round-robin).

### Create a load balancer  
1. Create an Azure Load Balancer   
      1. In the Azure portal click **Browse > Load balancers > Add**.   
      2. Enter a name for the new load balancer (for example, hacb).   
      3. Select **Internal** for the **Scheme**, **Virtual Network** for your deployment (for example, Contoso-VNet), and the **Subnet** with all of your resources (for example, default).   
      4. Select **Static** for the **IP address assignment** and enter a **Private IP address** that is not currently in use (for example, 10.0.0.32).   
      5. Select the appropriate **Subscription**, the **Resource group** with all of your resources, and the appropriate **Location**.   
      6. Select **Create**.   
2. Create a [probe](https://azure.microsoft.com/documentation/articles/load-balancer-custom-probe-overview/) to monitor which servers are active:   
      1. In Azure portal, click **Browse > Load Balancers**, and then click the load balancer you just created, (for example, CBLB). Click **Settings**.   
      2. Click **Probes > Add**.   
      3. Enter a name for the probe (for example, **RDP**), select **TCP** as the **Protocol**, enter **3389** for the **Port**, and then click **OK**.   
3. Create the backend pool of the Connection Brokers:   
      1. In **Settings**, Click **Backend address pools > Add**.   
      2. Enter a name (for example, CBBackendPool), then click **Add a virtual machine**.  
      3. Choose an availability set (for example, CbAvSet), and then click **OK**.   
      3. Click **Choose the virtual machines**, select each virtual machine, and then click **Select > OK > OK**.   
4. Create the RDP load balancing rule:   
      1. In **Settings**, click **Load balancing rules**, and then click **Add**.   
      2. Enter a name (for example, RDP), select **TCP** for the **Protocol**, enter **3389** for both **Port** and **Backend port**, and click **OK**.   
5. Add a DNS record for the Load Balancer:   
      1. Connect to the RDMS server virtual machine (for example, Contoso-CB1). Check out the [Prepare the RD Connection Broker VM](Prepare-the-RD-Connection-Broker-VM-for-Remote-Desktop.md) article for steps on how you connect to the VM.   
      2. In Server Manager, click **Tools > DNS**.   
      3. In the left-hand pane, expand **DNS**, click the DNS machine, click **Forward Lookup Zones**, and then click your domain name (for example, Contoso.com). (It might take a few seconds to process the query to the DNS server for the information.)  
      4. Click **Action > New Host (A or AAAA)**.   
      9. Enter the name (for example, hacb) and the IP address specified earlier (for example, 10.0.0.32).   

### Configure DNS round-robin  
  
The following steps are an alternative to creating an Azure Internal Load Balancer.   
  
1. Connect to the RDMS server in the Azure portal. using Remote Desktop Connection client   
2. Create DNS records:   
      1. In Server Manager, click **Tools > DNS**.   
      2. In the left-hand pane, expand **DNS**, click the DNS machine, click **Forward Lookup Zones**, and then click your domain name (for example, Contoso.com). (It might take a few seconds to process the query to the DNS server for the information.)  
      3. Click **Action** and **New Host (A or AAAA)**.   
      4. Enter the **DNS Name** for the RD Connection Broker cluster (for example, hacb), and then enter the **IP address** of the first RD Connection Broker.   
      5. Repeat steps 3-4 for each additional RD Connection Broker, providing each unique IP address for each additional record.


For example, if the IP addresses for the two RD Connection Broker virtual machines are 10.0.0.8 and 10.0.0.9, you would create two DNS host records:
 - Host name: hacb.contoso.com , IP address: 10.0.0.8
 - Host name: hacb.contoso.com , IP address: 10.0.0.9

## Step 3: Configure the Connection Brokers for high availability

1. Add the new RD Connection Broker server to Server Manager:
   1. In Server Manager, click **Manage > Add Servers**.
   2. Click **Find Now**.
   3. Click the newly created RD Connection Broker server (for example, Contoso-Cb2) and click **OK**.
2. Configure high availability for the RD Connection Broker:
   1. In Server Manager, click **Remote Desktop Services > Overview**.
   2. Right-click **RD Connection Broker**, and then click **Configure High Availability**.
   3. Page through the wizard until you get to the Configuration type section. Select **Shared database server**, and then click **Next**.
   4. Enter the DNS name for the RD Connection Broker cluster.
   5. Enter the connection string for the SQL DB, and then page through the wizard to establish high availability.
3. Add the new RD Connection Broker to the deployment
   1. In Server Manager, click **Remote Desktop Services > Overview**.
   2. Right-click the RD Connection Broker, and then click **Add RD Connection Broker Server**.
   3. Page through wizard until you get to Server Selection, then select the newly created RD Connection Broker server (for example, Contoso-CB2).
   4. Complete the wizard, accepting the default values.
4. Configure trusted certificates on RD Connection Broker servers and clients.

