---
title: WSUS Messages and Troubleshooting Tips
description: Windows Server Update Service (WSUS) article - Troubleshoot using WSUS messages
ms.topic: article
ms.assetid: 9f6317f7-bfe0-42d9-87ce-d8f038c728ca
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 01/11/2023
---
# WSUS Messages and Troubleshooting Tips

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This article contains information about the following WSUS messages:

- Computer hasn't reported status

- Message ID 6703 - WSUS Synchronization Failed

- Error 0x80070643: Fatal error during installation

- Some services aren't running. Check the following services [...]

## Computer hasn't reported status

This message is generated in the WSUS console when a WSUS client computer doesn't send information to the WSUS server to indicate its current update state. This issue is typically caused by the WSUS client computer, not the WSUS server.

The most common reasons are:

- The computer has lost connectivity to the network:
  - The network cable is unplugged.
  - An intervening network cable is faulty.
  - The computer has a faulty network adapter.
  - The network port to which the computer connects has been disabled.
  - The wireless adapter is unable to associate with and connect to the corporate wireless access point.
- The computer is turned off. (It has been shut down or is in sleep or hibernation mode.)

## Message ID 6703 - WSUS Synchronization Failed

```Event
Message: The request failed with HTTP status 503: Service Unavailable.
Source: Microsoft.UpdateServices.Administration.AdminProxy.createUpdateServer.
```

When you attempt to open Update Services on the WSUS server, you receive the following error:

```Event
Error: Connection Error
An error occurred trying to connect to the WSUS server. This error can happen for a number of reasons. Please contact your network administrator if the problem persists. Click the reset Server Node to connect to the server again.
```

Attempts to access the URL for the WSUS Administration website, for example `http://WSUS01:8530`, fails with the error:

`HTTP Error 503. The service is unavailable`

In this situation, the most likely cause is that the WsusPool Application Pool in IIS is in a stopped state.

Also, the Private Memory Limit (KB) for the Application Pool is probably set to the default value of 1843200 KB. If you encounter this problem, increase the Private Memory Limit to 4 GB (4000000 KB) and restart the Application Pool. To increase the memory perform the following steps:

1. Open the **Internet Information Services (IIS) Manager** console.
1. Select **Application Pools** from the **Connections** pane, then select **WsusPool**, right-click and select **Advanced Settings**.
1. Set the **Private Memory Limit (KB)** to _4000000_.
1. Select **OK** to apply the setting.

It may be necessary to increase the Private Memory Limit to 8GB (8000000 KB) or higher depending on the environment.

## Error 0x80070643: Fatal error during installation

If WSUS was set up using Microsoft SQL Server, this problem occurs because the user who is running WSUS Setup doesn't have System Administrator permissions in SQL Server.
To resolve this problem, grant System Administrator permissions to a user account or to a group account in SQL Server, and then run WSUS Setup again.

## Some services aren't running

Check the following services are running:

- **Selfupdate:** See [Automatic Updates Must Be Updated](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc708554(v=ws.10)) for information about troubleshooting the Selfupdate service.

- **WSSUService.exe:** This service facilitates synchronization. If you have problems with synchronization, access WSUSService.exe by clicking **Start**, pointing to **Administrative Tools**, clicking **Services**, and then finding **Windows Server Update Service** in the list of services. Once you have found the service:

  - Verify that this service is running. Select **Start** if it's stopped or **Restart** to refresh the service.

  - Use Event Viewer to check the **Application**, **Securit**y, and **System** event logs to see if there are any events that might indicate a problem.

- **Web servicesSQL Service:** Web services are hosted in IIS. If they aren't running, ensure that IIS is running (or started). You can also try resetting the Web service by typing **iisreset** at a command prompt.

- **SQL Service:** Every service except for the selfupdate service requires that the SQL service is running. If any of the log files indicate SQL connection problems, check the SQL service first. To access the SQL service, select **Start**, point to **Administrative Tools**, select **Services**, and then look for one of the following:

  - **MSSQLSERVER** (if you're using WMSDE or MSDE, or if you're using SQL Server and are using the default instance name for the instance name)

  - **MSSQL$WSUS** (if you're using a SQL Server database and have named your database instance WSUS)

    Right-click the service, and then select **Start** if the service isn't running, or **Restart** to refresh the service if it's running.
