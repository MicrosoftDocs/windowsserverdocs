---
title: AD FS Troubleshooting - SQL Connectivity
description:  This document describes how to troubleshoot various aspects of AD FS
author: billmath
ms.author: billmath
manager: mtillman
ms.date: 01/12/2017
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: identity-adfs
---

# AD FS Troubleshooting - SQL Connectivity
AD FS provides the ability to use remote SQL Server's for the AD FS farm data.  You will see issues if the AD FS servers in your farm cannot communicate with the backend SQL servers.  The following document will provide some basic steps to testing the communication with the backend servers.

## Acquire the SQL database connection string
The first thing to test when checking SQL connectivity is, if AD FS has the correct SQL connection information.  This can be done using PowerShell.

### To acquire the SQL connection string
1.  Open Windows PowerShell
2. Enter the following: `$adfs = gwmi -Namespace root/ADFS -Class SecurityTokenService` and hit Enter
3. Enter the following:  `$adfs.ConfigurationDatabaseConnectionString` and hit enter.
4. You should see the connect string information.
![](media/ad-fs-tshoot-sql/sql2.png)

## Create a Universal Data Link (UDL) file to test connectivity
A Universal Data Link file or UDL file is basically a text file that contains the a database connection string.  By using the information we obtained above we can test whether or not the SQL server is responding to connections.

### To create a udl file to test connectivity

1. Open Notepad and save the file as test.udl.  Make sure that you have **All Files** selected from the drop-down for **Save as type**.
2. Double-click on test.udl
3. Fill in the following information:
    a. **Select or enter a server name:**  Use the Data Source from the connection string above
    b. **Enter information to log on to the server:**  Use the AD FS service account or an account that has permissions to logon remotely.  If the account is a windows account use integrated authentication otherwise enter the username and password.
    c. **Select the database on the server:** Use the Initial Catalog from the string above.  Example:  AdfsConfigurationV3.
![Test Connection](media/ad-fs-tshoot-sql/sql4.png)
1. Click **Test Connection**.</br>
![Success](media/ad-fs-tshoot-sql/sql3.png)

## Use SQL Server Management Studio to test connectivity
You can also [download](https://go.microsoft.com/fwlink/?linkid=864329) and install SSMS to test database connectivity.

### To test connectivity with SSMS
1. Download and install SQL Server Management Studio.
![Install](media/ad-fs-tshoot-sql/sql5.png)
1. Open SSMS, enter the Server Name.  The data source from above.
2. Use the AD FS service account or an account that has permissions to logon remotely.  If the account is a windows account use integrated authentication otherwise enter the username and password.
![Connect](media/ad-fs-tshoot-sql/sql6.png)
1. You should see the left side populated.  Expand databases and verify that you see the AD FS databases.
![AD FS databases](media/ad-fs-tshoot-sql/sql7.png)

## Next Steps

- [AD FS Troubleshooting](ad-fs-tshoot-overview.md)