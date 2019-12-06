---
title: Troubleshoot Software Inventory Logging
description: Describes how to resolve common Software Inventory Logging deployment issues.
ms.custom: na
ms.prod: windows-server
ms.technology: manage-software-inventory-logging
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
author: brentfor
ms.author: coreyp
manager: lizapo
ms.date: 10/16/2017
---

# Troubleshoot Software Inventory Logging 

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2

## Understanding SIL

Before you start troubleshooting SIL, you should have a good understanding of its components and how it works. The following videos give an overview of SIL and SIL Aggregator, and how to use them to forward and report inventory data:

1. [An Introduction to Software Inventory Logging (SIL) (10:57)](https://channel9.msdn.com/Blogs/Regular-IT-Guy/An-Introduction-to-Software-Inventory-Logging-SIL)

2. [Software Inventory Logging: Setting Up SIL Aggregator (14:34)](https://channel9.msdn.com/Blogs/windowsserver/Software-Inventory-Logging-Setting-up-SIL-Aggregator)

3. [Software Inventory Logging: Enabling SIL Forwarding (7:20)](https://channel9.msdn.com/Blogs/windowsserver/Software-Inventory-Logging-Enabling-SIL-Forwarding)

## How SIL data flow works

The SIL framework has two main components and two channels of communication. Flow of data over both channels, and between both components, is necessary for a successful SIL deployment (this assumes a virtualized, or cloud, environment -- purely physical environments only need one of the communication channels). You'll need to understand the components and data flow of SIL to deploy it correctly. After watching the overview videos above, you will have seen the architectural diagram that illustrates the components and the flow of data over both channels. Orange arrows indicate remote queries over WinRM, green dashed arrows indicate HTTPS posts to the SIL Aggregator from SIL in each WS end node:

![](../media/software-inventory-logging/image1.png)

If you encounter a problem with SIL, it is likely related to a disruption in the flow of data over the channels, and between the components. Following are the most common issues related to data flow, followed in the next section by the troubleshooting steps to resolve each of the three issues:

-   **Data flow issue 1** – **No data in the report when using the Publish-SilReport cmdlet** (or generally missing data).

-   **Data flow issue 2** – **Too many servers under Unknown Host** in the report.

-   **Data flow issue 3** – **Too many VMs under physical hosts listed as Unknown OS** in the report, and/or an error produced when using **Publish-SilData** on Windows Servers running SIL.

## Troubleshooting data flow issues

Before you begin, you'll need to know how long ago SIL Aggregator started with the **Start-SilAggregator** cmdlet.

>[!IMPORTANT]
>There will be no data in the report until the SQL data cube is processed at 3AM local system time. Do not proceed with troubleshooting steps until the cube has processed data.

If you are troubleshooting data in the report (or missing from the report) that is more recent than the last time the cube processed, or before the cube has ever processed (for a new installation), follow these steps to process the SQL data cube in real time:

1. Log in as an administrator of SQL Server and run **SSMS** at a command prompt.
2. Connect to the Database Engine.
3. Expand **SQL Server Agent** and then expand **Jobs**.
4. Right click **SILStagingRefresh** and then select **Start Job at Step**.
5. Click **Start** and wait for the refresh progress bar to complete.
6. Open PowerShell as an administrator and run the **publish-silreport -openreport** cmdlet.

If there is still no data in the report, proceed with troubleshooting the three data flow issues.

### Data flow issue 1 

#### No data in the report when using the Publish-SilReport cmdlet (or data is generally missing)

If data is missing, it is likely due to the SQL data cube not having processed yet. If it has processed recently and you believe data that is missing should have arrived at the Aggregator before cube processing, follow the path of the data in reverse order. Pick a unique host and a unique VM to troubleshoot. The data path in reverse would be **SILA Report** &lt; **SILA database** &lt; **SILA local directory** &lt; **remote physical host** or **WS VM running SIL agent/task**.

#### Check to see if data is in the database

There are two ways to check for data: **Powershell** or **SSMS**.

>[!Important]
>If the cube has processed at least once since SILA inserted data into the database, then this data should be reflected in the report. If there is no data in the database then either polling the physical hosts is failing, or nothing is being received over HTTPS, or both.

 #### PowerShell

1. Open PowerShell as an administrator and run the **get-silvmhost** cmdlet, and then run **get-silaggregator**.

    >[!NOTE]
    >The output of **get-silaggregator** will always mimic the **Windows Server Details Tab** of the Excel report. Don't expect a different result.

2. Run **get-silvmhost**
   - If there are no hosts listed, then add hosts using the **add-silvmhost** cmdlet.
   - If hosts are listed as **Unknown**, then go to Issue 2. 
   d - If hosts are listed but there is no **datetime** under the **Recent Poll** column, then go to **Issue 2** below.

**Other related commands**

**Get-SilAggregator -Computername &lt;fqdn of a known server pushing data&gt;**: This will produce information from the database about a computer (VM) even before the cube has processed. Thus this cmdlet can be used to check on data in the database for a Windows Server pushing SIL data over HTTPS, before, or without, the cube process at 3AM (or if you haven't refreshed the cube in real time as described at the beginning of this section).

**Get-SilAggregator -VmHostName &lt;fqdn of a polled physical host where there is a value under the Recent Poll column when using the Get-SilVmHost cmdlet&gt;**: This will produce information from the database about a physical host even before the cube has processed.

#### SSMS

n**Check for data from hosts being polled:**
 
1. Open **SSMS** and connect to the **Database Engine**.
2. Expand **Databases**, expand the **SoftwareInventoryLogging** database, expand **Tables**, right click the **HostInfo** table and then select top 1000 rows. 

    If there is data for one or more hosts in the table, then polling for that/those host(s) has been successful at least once.

   **Check for data from VMs, or standalone servers, that have pushed data over HTTPS:** 

3. Open **SSMS** and connect to the **Database Engine**.
   a2. Expand **Databases**, expand the **SoftwareInventoryLogging** database, expand **Tables**, right click the **VMInfo** table and then select the top 1000 rows. 

    >[!NOTE] 
    >Each row for a unique VM will represent one processed **bmil** file successfully pushed over HTTPS and processed by the SIL Aggregator. Bmil files are proprietary files used by SIL, one is created each our by each SIL instance Note that this is only necessary when SIL and SILA are used in virtual environments. Otherwise only HTTPS traffic is necessary/expected).

   All data in the database should be reflected in SIL reports after the cube has processed.

### Data flow issue 2
#### Too many servers under Unknown Host

This is likely to occur in virtual environments when SIL Aggregator is not successfully polling physical hosts that are hosting the virtual machines.

1. Open **PowerShell** as an administrator and run the **get-silvmhost** cmdlet.

    -   If hosts are listed as **Unknown**, the **add-silvmhost** cmdlet did not work correctly – usually because of bad credentials added for access to these hosts (thus, Unknown). But if credentials are verified, it could mean the auto-detection of **hosttype** and **hypervisortype** in the **add-silvmhost** cmdlet was not able to recognize the platform. There are advanced troubleshooting steps available for these situations, but are not covered here (check EventViewer SIL Aggregator channels).

    -   If hosts are listed, and **hosttype** and **hypervisortype** are listed with values that are NOT **Unknown**, i.e Windows and HyperV, or Ubuntu and Xen, etc., but there is no **datetime** under **Recent Poll** column, then polling has not successfully occurred yet.

        -   You'll need to wait an hour after adding the host for polling to occur (assuming this interval is set to default – can be checked using the **get-silaggregator** cmdlet).

        -   If it has been an hour since the host was added, check that the polling task is running: In **Task Scheduler**, select **Software Inventory Logging Aggregator** under **Microsoft** &gt; **Windows** and check the history of the task.

    -   If a host is listed, but there is no value for **RecentPoll**, **HostType**, or **HypervisorType**, this can be largely ignored. This will only occur in HyperV environments. This data actually comes from the Windows Server VM, identifying the physical host it is running over HTTPS. This can be useful in identifying a specific VM that is reporting, but requires mining the database using the **Get-SilAggregatorData** cmdlet.

Once the hosts are polling correctly, you will be able to see the data for these physical hosts in the SILA database where there is a **datetime** under **recent poll**. The Issue 1 section above provides steps for retrieving this data.

### Data flow issue 3
#### Too many physical hosts with VMs listed as Unknown OS

1. Pick one Windows Server end node (VM) that you know is on one of these hosts, login as an administrator.
2. Open PowerShell as an administrator.
3. Verify **SilLogging** is running by using the **Get-SilLogging** cmdlet.
   - If running, try to manually push SIL data by using **Publish-SilData**.

   - If there is an error:
     - Ensure the **targeturi** has **https://** in the entry.
     - Ensure all pre-requisites are met 
     - Ensure all required updates for Windows Server are installed (see Prerequisites for SIL). A quick way to check (on WS 2012 R2 only) is to look for these using the following cmdlet: **Get-SilWindowsUpdate \*3060, \*3000**
     - Ensure the certificate being used to authenticate with the aggregator is installed in the correct store on the local server to be inventoried with **SilLogging**.
     - On the SIL Aggregator, be sure the certificate thumbprint of the certificate being used to authenticate with the aggregator is added to list using the **Set-SilAggregator** **–AddCertificateThumbprint** cmdlet.
     - If using enterprise certificates, check that the server with SIL enabled is joined to the domain for which the cert was created, or is otherwise verifiable with a root authority. If a certificate is not trusted on the local machine attempting to forward/push data to an Aggregator, this action will fail with an error.

     If all of the above has been checked and verified,but the issue persist:

     - Check that the certificate used to install the SIL Aggregator is healthy and matches the name of the SIL Aggregator server itself. Also, if enterprise certificates are used for installing the SIL Aggregator, the Aggregator may need to be joined to the domain where the certificate was created (these steps are unnecessary if other machines are successfully forwarding to the same SIL Aggregator).

     -  Finally, you can check the following location for cached SIL files on the server attempting to forward/push, **\Windows\System32\Logfiles\SIL**. If **SilLogging** has started and has been running for more than an hour, or **Publish-SilData** has been run recently, and there are no files in this directory, than logging to the Aggregator has been successful.

If there is no error, and no output on the console, then the data push/publish from the Windows Server end node to SIL Aggregator over HTTPS was successful. To follow the path of the data forward, login to the SIL Aggregator as an administrator and examine the data file(s) that have arrived. Go to **Program Files (x86)** &gt; **Microsoft SIL Aggregator** &gt; SILA directory. You can watch data files arriving in real time.

>[!NOTE] 
>More than one data file may have been transferred with the **Publish-SilData** cmdlet. SIL on the end node will cache failed pushes for up to 30 days. On the next successful push ALL data files will go to the Aggregator for processing. In this way, a newly set up SIL Aggregator could show data from an end node well before its own setup.

>[!NOTE] 
>There are rules SILA follows when processing data files in the SILA directory that are only relevant in low traffic situations. High traffic will always trigger processing in real time. The default behavior is that processing will commence either after 100 files arrive in the directory, or after 15 minutes. When troubleshooting end-to-end in a small environment, it is often necessary to wait 15 minutes.

After these files are processed, you will see the data in the database.
