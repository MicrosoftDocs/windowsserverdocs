---
title: AD FS Troubleshooting - SQL Connectivity
description: Learn how to troubleshoot various aspects of Active Directory Federation Services as it relates to SQL connectivity.
ms.date: 02/13/2024
ms.topic: troubleshooting-general
ms.custom:
  - sfi-image-nochange
  - sfi-ropc-nochange
---

# AD FS troubleshooting: SQL connectivity

With Active Directory Federation Services (AD FS), you can use remote SQL servers for AD FS farm data. You see issues if the AD FS servers in your farm can't communicate with the back-end SQL servers. This article provides basic steps to test the communication with the back-end servers.

## Acquire the SQL database connection string

The first thing to test when you check SQL connectivity is if AD FS has the correct SQL connection information. Use PowerShell for this task.

1. Open Windows PowerShell.
1. Enter `$adfs = gwmi -Namespace root/ADFS -Class SecurityTokenService`, and then select the Enter key.
1. Enter `$adfs.ConfigurationDatabaseConnectionString`, and then select the Enter key.

The connection string information appears.

![Screenshot that shows the PowerShell command screen running commands.](media/ad-fs-tshoot-sql/sql2.png)

## Create a UDL file to test connectivity

A Universal Data Link (UDL) file is a text file that contains a database connection string. By using the information you obtained, you can test whether or not the SQL server is responding to connections.

1. Open Notepad and save the file as **test.udl**. In the **Save as type** dropdown list, select **All Files**.
1. Double-click **test.udl**.
1. Fill in the following information:

    1. **Select or enter a server name:** Use the data source from the preceding connection string.
    1. **Enter information to log on to the server:** Use the AD FS service account or an account that has permissions to sign in remotely. If the account is a Windows account, use Integrated Windows Authentication. Otherwise, enter the username and password.
    1. **Select the database on the server:** Use the Initial Catalog from the preceding string. An example is `AdfsConfigurationV3`.

    ![Screenshot that shows the Connection dialog.](media/ad-fs-tshoot-sql/sql4.png)

1. Select **Test Connection**.

   ![Screenshot that shows the message Test connection succeeded.](media/ad-fs-tshoot-sql/sql3.png)

## Use SQL Server Management Studio to test connectivity

You can also [download](https://go.microsoft.com/fwlink/?linkid=864329) and install SQL Server Management Studio (SSMS) to test database connectivity.

1. Download and install SSMS.

   ![Screenshot that shows the installation process.](media/ad-fs-tshoot-sql/sql5.png)
1. Open SSMS and enter the server name from the preceding data source.
1. Use the AD FS service account or an account that has permissions to sign in remotely. If the account is a Windows account, use Integrated Windows Authentication. Otherwise, enter the username and password.

   ![Screenshot that shows the Connect to Server pane.](media/ad-fs-tshoot-sql/sql6.png)
1. After the left pane populates, expand databases and verify that you can see the AD FS databases.

   ![Screenshot that shows the AD FS databases.](media/ad-fs-tshoot-sql/sql7.png)

## Related content

- [AD FS troubleshooting](ad-fs-tshoot-overview.md)
