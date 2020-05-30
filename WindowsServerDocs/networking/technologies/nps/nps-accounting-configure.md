---
title: Configure Network Policy Server Accounting
description: This topic provides information about text file and SQL Server logging for Network Policy Server in Windows Server 2016.
manager: dougkim
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: dfde2e21-f3d5-41e8-8492-cb3f0d028afb
ms.author: lizross 
author: eross-msft
ms.date: 05/25/2018
---

# Configure Network Policy Server Accounting

There are three types of logging for Network Policy Server \(NPS\):

- **Event logging**. Used primarily for auditing and troubleshooting connection attempts. You can configure NPS event logging by obtaining the NPS properties in the NPS console.

- **Logging user authentication and accounting requests to a local file**. Used primarily for connection analysis and billing purposes. Also useful as a security investigation tool because it provides you with a method of tracking the activity of a malicious user after an attack. You can configure local file logging using the Accounting Configuration wizard.

- **Logging user authentication and accounting requests to a Microsoft SQL Server XML-compliant database**. Used to allow multiple servers running NPS to have one data source. Also provides the advantages of using a relational database. You can configure SQL Server logging by using the Accounting Configuration wizard.

## Use the Accounting Configuration wizard

By using the Accounting Configuration wizard, you can configure the following four accounting settings:

- **SQL logging only**. By using this setting, you can configure a data link to a SQL Server that allows NPS to connect to and send accounting data to the SQL server. In addition, the wizard can configure the database on the SQL Server to ensure that the database is compatible with NPS SQL server logging.
- **Text logging only**. By using this setting, you can configure NPS to log accounting data to a text file.
- **Parallel logging**. By using this setting, you can configure the SQL Server data link and database. You can also configure text file logging so that NPS logs simultaneously to the text file and the SQL Server database. 
- **SQL logging with backup**. By using this setting, you can configure the SQL Server data link and database. In addition, you can configure text file logging that NPS uses if SQL Server logging fails.

In addition to these settings, both SQL Server logging and text logging allow you to specify whether NPS continues to process connection requests if logging fails. You can specify this in the **Logging failure action section** in local file logging properties, in SQL server logging properties, and while you are running the Accounting Configuration Wizard.

### To run the Accounting Configuration Wizard

To run the Accounting Configuration Wizard, complete the following steps:

1. Open the NPS console or the NPS Microsoft Management Console (MMC) snap-in.
2. In the console tree, click **Accounting**.
3. In the details pane, in **Accounting**, click **Configure Accounting**.

## Configure NPS Log File Properties

You can configure Network Policy Server (NPS) to perform Remote Authentication Dial-In User Service (RADIUS) accounting for user authentication requests, Access-Accept messages, Access-Reject messages, accounting requests and responses, and periodic status updates. You can use this procedure to configure the log files in which you want to store the accounting data.

For more information about interpreting log files, see [Interpret NPS Database Format Log Files](https://technet.microsoft.com/library/cc771748.aspx).

To prevent the log files from filling the hard drive, it is strongly recommended that you keep them on a partition that is separate from the system partition. The following provides more information about configuring accounting for NPS:

- To send the log file data for collection by another process, you can configure NPS to write to a named pipe. To use named pipes, set the log file folder to \\.\pipe or \\ComputerName\pipe. The named pipe server program creates a named pipe called \\.\pipe\iaslog.log to accept the data. In the Local file properties dialog box, in Create a new log file, select Never (unlimited file size) when you use named pipes.

- The log file directory can be created by using system environment variables (instead of user variables), such as %systemdrive%, %systemroot%, and %windir%. For example, the following path, using the environment variable %windir%, locates the log file at the system directory in the subfolder \System32\Logs (that is, %windir%\System32\Logs\).

- Switching log file formats does not cause a new log to be created. If you change log file formats, the file that is active at the time of the change will contain a mixture of the two formats (records at the start of the log will have the previous format, and records at the end of the log will have the new format).

- If RADIUS accounting fails due to a full hard disk drive or other causes, NPS stops processing connection requests, preventing users from accessing network resources.

- NPS provides the ability to log to a Microsoft® SQL Server™ database in addition to, or instead of, logging to a local file.

Membership in the **Domain Admins** group is the minimum required to perform this procedure.


### To configure NPS log file properties

1. Open the NPS console or the NPS Microsoft Management Console (MMC) snap-in.
2. In the console tree, click **Accounting**.
3. In the details pane, in **Log File Properties**, click **Change Log File Properties**. The **Log File Properties** dialog box opens.
4. In **Log File Properties**, on the **Settings** tab, in **Log the following information**, ensure that you choose to log enough information to achieve your accounting goals. For example, if your logs need to accomplish session correlation, select all check boxes.
5. In **Logging failure action**, select **If logging fails, discard connection requests** if you want NPS to stop processing Access-Request messages when log files are full or unavailable for some reason. If you want NPS to continue processing connection requests if logging fails, do not select this check box.
6. In the **Log File Properties** dialog box, click the **Log File** tab.
7. On the **Log File** tab, in **Directory**, type the location where you want to store NPS log files. The default location is the systemroot\System32\LogFiles folder.<br>If you do not supply a full path statement in **Log File Directory**, the default path is used. For example, if you type **NPSLogFile** in **Log File Directory**, the file is located at %systemroot%\System32\NPSLogFile.
8. In **Format**, click **DTS Compliant**. If you prefer, you can instead select a legacy file format, such as **ODBC \(Legacy\)** or **IAS \(Legacy\)**.<br>**ODBC** and **IAS** legacy file types contain a subset of the information that NPS sends to its SQL Server database. The **DTS Compliant** file type's XML format is identical to the XML format that NPS uses to import data into its SQL Server database. Therefore, the **DTS Compliant** file format provides a more efficient and complete transfer of data into the standard SQL Server database for NPS.
9. In **Create a new log file**, to configure NPS to start new log files at specified intervals, click the interval that you want to use:
	- For heavy transaction volume and logging activity, click **Daily**.
	- For lesser transaction volumes and logging activity, click **Weekly** or **Monthly**.
	- To store all transactions in one log file, click **Never \(unlimited file size\)**.
	- To limit the size of each log file, click **When log file reaches this size**, and then type a file size, after which a new log is created. The default size is 10 megabytes (MB).
10. If you want NPS to delete old log files to create disk space for new log files when the hard disk is near capacity, ensure that **When disk is full delete older log files** is selected. This option is not available, however, if the value of **Create a new log file** is **Never \(unlimited file size\)**. Also, if the oldest log file is the current log file, it is not deleted.

## Configure NPS SQL Server Logging

You can use this procedure to log RADIUS accounting data to a local or remote database running Microsoft SQL Server.

>[!NOTE]
>NPS formats accounting data as an XML document that it sends to the **report_event** stored procedure in the SQL Server database that you designate in NPS. For SQL Server logging to function properly, you must have a stored procedure named **report_event** in the SQL Server database that can receive and parse the XML documents from NPS.

Membership in Domain Admins, or equivalent, is the minimum required to complete this procedure.

### To configure SQL Server logging in NPS

1. Open the NPS console or the NPS Microsoft Management Console (MMC) snap-in.
2. In the console tree, click **Accounting**.
3. In the details pane, in **SQL Server Logging Properties**, click **Change SQL Server Logging Properties**. The **SQL Server Logging Properties** dialog box opens.
4. In **Log the following information**, select the information that you want to log: 
	- To log all accounting requests, click **Accounting requests**.
	- To log authentication requests, click **Authentication requests**.
	- To log periodic accounting status, click **Periodic accounting status**.
	- To log periodic status, such as interim accounting requests, click **Periodic status**.
5. To configure the number of concurrent sessions allowed between the server running NPS and the SQL Server, type a number in **Maximum number of concurrent sessions**.
6. To configure the SQL Server data source, in **SQL Server Logging**, click **Configure**. The **Data Link Properties** dialog box opens. On the **Connection** tab, specify the following: 
	- To specify the name of the server on which the database is stored, type or select a name in **Select or enter a server name**.
	- To specify the authentication method with which to log on to the server, click **Use Windows NT integrated security**. Or, click **Use a specific user name and password**, and then type credentials in **User name** and **Password**.
	- To allow a blank password, click **Blank password**.
	- To store the password, click **Allow saving password**.
	- To specify which database to connect to on the computer running SQL Server, click **Select the database on the server**, and then select a database name from the list.
7. To test the connection between NPS and SQL Server, click **Test Connection**. Click **OK** to close **Data Link Properties**.
8. In **Logging failure action**, select **Enable text file logging for failover** if you want NPS to continue with text file logging if SQL Server logging fails. 
9. In **Logging failure action**, select **If logging fails, discard connection requests** if you want NPS to stop processing Access-Request messages when log files are full or unavailable for some reason. If you want NPS to continue processing connection requests if logging fails, do not select this check box.

## Ping user-name

Some RADIUS proxy servers and network access servers periodically send authentication and accounting requests (known as ping requests) to verify that the NPS is present on the network. These ping requests include fictional user names. When NPS processes these requests, the event and accounting logs become filled with access reject records, making it more difficult to keep track of valid records.

When you configure a registry entry for **ping user-name**, NPS matches the registry entry value against the user name value in ping requests by other servers. A **ping user-name** registry entry specifies the fictional user name (or a user name pattern, with variables, that matches the fictional user name) sent by RADIUS proxy servers and network access servers. When NPS receives ping requests that match the **ping user-name** registry entry value, NPS rejects the authentication requests without processing the request. NPS does not record transactions involving the fictional user name in any log files, which makes the event log easier to interpret.

**Ping user-name** is not installed by default. You must add **ping user-name** to the registry. You can add an entry to the registry using Registry Editor.

>[!CAUTION]
>Incorrectly editing the registry might severely damage your system. Before making changes to the registry, you should back up any valued data on the computer.

### To add ping user-name to the registry

Ping user-name can be added to the following registry key as a string value by a member of the local Administrators group:

`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\IAS\Parameters`

- **Name**: `ping user-name`
- **Type**:	`REG_SZ`
- **Data**:	 *User name*

>[!TIP]
>To indicate more than one user name for a **ping user-name** value, enter a name pattern, such as a DNS name, including wildcard characters, in **Data**.
