---
title: Configure RD Connection Broker for High Availability
description: Learn to configure the Remote Desktop Connection Broker for high availability in Remote Desktop Services.
ms.topic: how-to
ai-usage: ai-assisted
ms.author: daknappe
author: dknappettmsft
ms.date: 07/02/2025
ms.custom: sfi-ropc-nochange
---

# Configure the Remote Desktop Connection Broker for high availability

To ensure the reliability and scalability of your Remote Desktop Services infrastructure, you can configure the Remote Desktop Connection Broker for high availability. This article shows you how to set up a highly available Connection Broker cluster, including prerequisites, database configuration, load balancing, and final deployment steps. By following these instructions, you can minimize downtime and optimize performance for your remote desktop environment.

## Prerequisites

Before you begin, you need to meet the following prerequisites:

- Set up a server to act as a second RD Connection Broker. This server can be either a physical server or a VM.

- Set up a database for the Connection Broker. You can use [Azure SQL Database](/azure/azure-sql/database/single-database-create-quickstart#create-a-new-aure-sql-database) instance or SQL Server in your local environment. We give an example using Azure SQL, but the steps still apply to SQL Server. You need to find the connection string for the database and make sure you have the correct ODBC driver.

## Configure the database for the Connection Broker

1. Find the connection string for the database you created - you need it both to identify the version of ODBC driver you need and later, when you're configuring the Connection Broker itself (step 3), so save the string somewhere you can reference it easily. Here's how you find the connection string for Azure SQL:

   1. In the Azure portal, select **Browse > Resource groups** and select the resource group for the deployment.
   1. Select the SQL database you created (for example, CB-DB1).
   1. Select **Settings** > **Properties** > **Show database connection strings**.
   1. Copy the connection string for **ODBC (includes Node.js)**, which should look like this. Replace the `<values>` with your values. You use this entire string, with your included password, when connecting to the database.

      ```connectionstring
      Driver={ODBC Driver 13 for SQL Server};Server=tcp:<YourHost>,<HostPort>;Database=<DatabaseName>;Uid=<UserID>;Pwd=<Password>;Encrypt=yes;TrustServerCertificate=no;Connection Timeout=30;
      ```

1. Install the ODBC driver on the new Connection Broker:

    1. If you're using a VM for the Connection Broker, create a public IP address for the first RD Connection Broker. (You only have to do this step if the RDMS virtual machine doesn't already have a public IP address to allow RDP connections.)

        1. In the Azure portal, select **Browse > Resource groups**, select the resource group for the deployment, and then select the first RD Connection Broker virtual machine (for example, Contoso-Cb1).
        1. Select **Settings > Network interfaces**, and then select the corresponding network interface.
        1. Select **Settings > IP address**.
        1. For **Public IP address**, select **Enabled**, and then select **IP address**.
        1. If you have an existing public IP address you want to use, select it from the list. Otherwise, select **Create new**, enter a name, and then select **OK** and then **Save**.

    1. Connect to the first RD Connection Broker:

        1. In the Azure portal, select **Browse > Resource groups**, select the resource group for the deployment, and then select the first RD Connection Broker virtual machine (for example, Contoso-Cb1).
        1. Select **Connect > Open** to open the Remote Desktop client.
        1. In the client, select **Connect**, and then select **Use another user account**. Enter the user name and password for a domain administrator account.
        1. Select **Yes** when warned about the certificate.

    1. Download the [ODBC driver for SQL Server](/sql/connect/odbc/download-odbc-driver-for-sql-server) that matches the version in the ODBC connection string. For the example string, we need to install the version 13 ODBC driver.
    1. Copy the `sqlincli.msi` file to the first RD Connection Broker server.
    1. Open the `sqlincli.msi` file and install the native client.
    1. Repeat steps 1-5 for each RD Connection Brokers (for example, Contoso-Cb2).
    1. Install the ODBC driver on each server that runs the connection broker.

## Configure load balancing on the RD Connection Brokers

You can use a load balancer, such as [Azure load balancer](#create-a-load-balancer); if not, you can set up [DNS round-robin](#configure-dns-round-robin).

### Create a load balancer

1. Create an Azure Load Balancer

    1. In the Azure portal, select **Browse > Load balancers > Add**.
    1. Enter a name for the new load balancer (for example, `hacb`).
    1. Select **Internal** for the **Scheme**, **Virtual Network** for your deployment (for example, Contoso-VNet), and the **Subnet** with all of your resources (for example, default).
    1. Select **Static** for the **IP address assignment** and enter a **Private IP address** that isn't currently in use (for example, 10.0.0.32).
    1. Select the appropriate **Subscription**, the **Resource group** with all of your resources, and the appropriate **Location**.
    1. Select **Create**.

1. Create a [probe](/azure/load-balancer/load-balancer-custom-probe-overview) to monitor which servers are active:

    1. In Azure portal, select **Browse > Load Balancers**, and then select the load balancer you created, for example, `CBLB`. Select **Settings**.
    1. Select **Probes > Add**.
    1. Enter a name for the probe (for example, **RDP**), select **TCP** as the **Protocol**, enter **3389** for the **Port**, and then select **OK**.

1. Create the backend pool of the Connection Brokers:

    1. In **Settings**, select **Backend address pools > Add**.
    1. Enter a name (for example, CBBackendPool), then select **Add a virtual machine**.
    1. Choose an availability set (for example, CbAvSet), and then select **OK**.
    1. Select **Choose the virtual machines**, select each virtual machine, and then select **Select > OK > OK**.

1. Create the RDP load balancing rule:

    1. In **Settings**, select **Load balancing rules**, and then select **Add**.
    1. Enter a name (for example, RDP), select **TCP** for the **Protocol**, enter **3389** for both **Port** and **Backend port**, and select **OK**.

1. Add a DNS record for the Load Balancer:

    1. Connect to the RDMS server virtual machine (for example, Contoso-CB1). Check out the [Prepare the RD Connection Broker VM](./rds-prepare-vms.md) article for steps on how you connect to the VM.
    1. In Server Manager, select **Tools > DNS**.
    1. In the left-hand pane, expand **DNS**, select the DNS machine, select **Forward Lookup Zones**, and then select your domain name (for example, Contoso.com). (It might take a few seconds to process the query to the DNS server for the information.)
    1. Select **Action > New Host (A or AAAA)**.
    1. Enter the name (for example, `hacb`) and the IP address specified earlier (for example, 10.0.0.32).

### Configure DNS round-robin

The following steps are an alternative to creating an Azure Internal Load Balancer.

1. Connect to the RDMS server in the Azure portal. using Remote Desktop Connection client
1. Create DNS records:

    1. In Server Manager, select **Tools > DNS**.
    1. In the left-hand pane, expand **DNS**, select the DNS machine, select **Forward Lookup Zones**, and then select your domain name (for example, Contoso.com). (It might take a few seconds to process the query to the DNS server for the information.)
    1. Select **Action** and **New Host (A or AAAA)**.
    1. Enter the **DNS Name** for the RD Connection Broker cluster (for example, `hacb`), and then enter the **IP address** of the first RD Connection Broker.
    1. Repeat steps 3-4 for each  RD Connection Broker, providing each unique IP address for each record.

For example, if the IP addresses for the two RD Connection Broker virtual machines are 10.0.0.8 and 10.0.0.9, you would create two DNS host records:

- Host name: `hacb.contoso.com`, IP address: `10.0.0.8`
- Host name: `hacb.contoso.com`, IP address: `10.0.0.9`

## Configure the Connection Brokers for high availability

1. Add the new RD Connection Broker server to Server Manager:

    1. In Server Manager, select **Manage > Add Servers**.
    1. Select **Find Now**.
    1. Select the newly created RD Connection Broker server (for example, Contoso-Cb2) and select **OK**.

1. Configure high availability for the RD Connection Broker:

    1. In Server Manager, select **Remote Desktop Services > Overview**.
    1. Right-click **RD Connection Broker**, and then select **Configure High Availability**.
    1. Page through the wizard until you get to the Configuration type section. Select **Shared database server**, and then select **Next**.
    1. Enter the DNS name for the RD Connection Broker cluster.
    1. Enter the connection string for the SQL DB, and then page through the wizard to establish high availability.

1. Add the new RD Connection Broker to the deployment

    1. In Server Manager, select **Remote Desktop Services > Overview**.
    1. Right-click the RD Connection Broker, and then select **Add RD Connection Broker Server**.
    1. Page through wizard until you get to Server Selection, then select the newly created RD Connection Broker server (for example, Contoso-CB2).
    1. Complete the wizard, accepting the default values.

1. Configure trusted certificates on RD Connection Broker servers and clients.
