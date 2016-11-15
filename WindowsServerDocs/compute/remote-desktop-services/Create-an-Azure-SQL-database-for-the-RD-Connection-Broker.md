---
title: Create an Azure SQL database for the RD Connection Broker
description: Learn how to use Azure SQL with RDS.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: elizapo
ms.date: 11/14/2016
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d04ba634-19bf-4f74-a834-138b738bc86c
author: lizap
manager: dongill
---
# Create an Azure SQL database for the RD Connection Broker

>Applies To: Windows Server 2016

This article provides steps to deploy an Azure SQL Database instance for Remote Desktop. Alternatively, you could deploy a SQL server AlwaysOn Availability Group in multiple virtual machines or use a database in an existing SQL server deployment. For more details, see [Create a SQL AlwaysOn Availability Group in Microsoft Azure End-to-End](https://blogs.msdn.microsoft.com/sqlalwayson/2013/01/23/test-lab-create-an-alwayson-availability-group-in-windows-azure-end-to-end/).   

> [!NOTE] 
> You can only use Azure SQL for a *Windows Server 2016* Connection Broker. This feature is not available for previous releases of Windows Server.

1. [Create an Azure SQL Database](https://azure.microsoft.com/en-us/documentation/articles/sql-database-get-started/#create-a-new-aure-sql-database) instance.   
2. Copy the connection string for the database you created. You'll need this in the next step.    
    1. In the Azure portal, click **Browse > Resource groups** and click the resource group for the deployment.   
    2. Select the SQL database you just created (for example, CB-DB1).   
    3. Click **Settings > Properties > Show database connection strings**.   
    4. Copy the connection string for **ODBC (includes Node.js)**, which should look like this:   
      
        Driver={SQL Server Native Client 13.0};Server=tcp:cb-sqls1.database.windows.net,1433;Database=CB-DB1;Uid=sqladmin@contoso;Pwd={your_password_here};Encrypt=yes;TrustServerCertificate=no;Connection Timeout=30;   
  
    5. Replace "your_password_here" with the actual password. You'll use this entire string, with your included password, when connecting to the database.   