---
title: Manage Software Inventory Logging
description: Describes how to manage Software Inventory Logging
ms.custom: na
ms.prod: windows-server-threshold
ms.technology: manage-software-inventory-logging
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 812173d1-2904-42f4-a9e2-de19effec201
author: brentfor
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# Manage Software Inventory Logging

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2

This document describes how to manage Software Inventory Logging, a feature that helps datacenter administrators easily log Microsoft software asset management data for their deployments over time. This document describes how to manage Software Inventory Logging. Before using Software Inventory Logging with Windows Server 2012 R2, make sure that Windows Update [KB 3000850](https://support.microsoft.com/kb/3000850) and [KB 3060681](https://support.microsoft.com/kb/3060681) are installed on each system needing to be inventoried. No Wndows Updates are required for Windows Server 2016. This feature runs locally on each server to be inventoried. It does not collect data from remote servers.  

The Software Inventory Logging feature can also be added to two versions of Windows Server prior to Windows Server 2012 R2. You can install the following updates to add Software Inventory Logging functionality to Windows Server 2012 and Windows Server 2008 R2 SP1:

- **Windows Server 2012 (Standard or Datacenter Edition)** 

> [!NOTE] 
> Make sure you have [WMF 4.0](https://www.microsoft.com/en-us/download/details.aspx?id=40855) installed before applying the update package below.

-  WMF 4.0 Update package for Windows Server 2012: [KB 3119938](https://support.microsoft.com/en-us/kb/3119938)

- **Windows Server 2008 R2 SP1**

> [!NOTE] 
> Make sure you have [WMF 4.0](https://www.microsoft.com/en-us/download/details.aspx?id=40855) installed before applying the update package below.


- Requires [.NET Framework 4.5](https://www.microsoft.com/en-us/download/details.aspx?id=30653)


- WMF 4.0 Update package for Windows Server 2008 R2: [KB 3109118](https://support.microsoft.com/en-us/kb/3109118)


There are two primary methods for inventorying using this feature:  
  
1.  Starting the SIL logging functionality to collect from SIL data sources and forward the payload over the network to a specified target (URI) on an hourly basis.  
  
2.  Manually querying the SIL data using PowerShell or WMI at any interval.  
  
Starting SIL logging involves some planning and foresight, but has significant advantages compared to manually querying the data. Using SIL logging has the following three primary advantages for data center administrators:  
  
-   An ongoing history (log) can be collected over time, allowing flexible and comprehensive reports from a single source.  
  
-   Computer discovery challenges typical of many inventory tools can be overcome.  
  
-   Trust boundary challenges and the need for elevated user privileges typical of many inventory tools can be overcome while maintaining a level of security, since the data is encrypted over HTTPS with SSL.  
  
Software Inventory Logging is installed by default, but logging is not started by default. All configuration of Software Inventory Logging is done with PowerShell cmdlets. There are only a few configuration options for Software Inventory Logging. This document describes these options and their intended purpose, as well as the cmdlets used for data collection (if using the second method above).  
  
**In this document**  
  
The configuration options covered in this document include:  
  
-   [Starting and Stopping Software Inventory Logging](manage-software-inventory-logging.md#BKMK_Step1)  
  
-   [Software Inventory Logging over time](manage-software-inventory-logging.md#BKMK_Step2)  
  
-   [Displaying Software Inventory Logging data](manage-software-inventory-logging.md#BKMK_Step3)  
  
-   [Deleting data logged by Software Inventory Logging](manage-software-inventory-logging.md#BKMK_Step4)  
  
-   [Backing up and restoring data logged by Software Inventory Logging]manage-software-inventory-logging.md#BKMK_Step5)  
  
-   [Reading data logged and published by Software Inventory Logging](manage-software-inventory-logging.md#BKMK_Step6)  
  
-   [Software Inventory Logging Security](manage-software-inventory-logging.md#BKMK_Step7)  
  
-   [Working with date and time settings in Windows Server Software Inventory Logging](manage-software-inventory-logging.md#BKMK_Step8)  
  
-   [Enabling and Configuring Software Inventory Logging in a Mounted Virtual Hard Disk](manage-software-inventory-logging.md#BKMK_Step10)  
  
-   [Overview of Using Software Inventory Logging in Windows Server 2012 R2 without KB 3000850](manage-software-inventory-logging.md#BKMK_Step11)  
  
-   [Using Software Inventory Logging in a Windows Server 2012 R2 Hyper-V environment without KB 3000850](manage-software-inventory-logging.md#BKMK_Step12)  
  
> [!NOTE]  
> This topic includes sample Windows PowerShell cmdlets that you can use to automate some of the procedures described. For more information, see Using Cmdlets.

  
## <a name="BKMK_Step1"></a>Starting and Stopping Software Inventory Logging  
Software Inventory Logging daily collection and forward over the network must be enabled on a computer running Windows Server 2012 R2 to log software inventory.  
  
> [!NOTE]  
> You can use the **[Get-SilLogging](https://technet.microsoft.com/library/dn283396.aspx)** PowerShell cmdlet to retrieve information about the Software Inventory Logging Service, including whether it is running or stopped.  
  
#### To Start Software Inventory Logging  
  
1.  Sign in to the server with an account that has local administrator privileges.  
  
2.  Open PowerShell as an Administrator.  
  
3.  At the PowerShell prompt, type **[Start-SilLogging](https://technet.microsoft.com/library/dn283391.aspx)**  
  
> [!NOTE]  
> It is possible to set the target without setting a certificate thumbprint, but if you do, the forwards will fail and data will be stored locally for up to a default value of 30 days (after which it will be deleted). Once a valid certificate hash is set for the target (and corresponding valid certificate installed in the LocalMachine/Personal store), data stored locally will be forwarded to the target as long as the target is configured to accept this data with this certificate (see [Software Inventory Logging Aggregator](Software-Inventory-Logging-Aggregator.md) for more information).  
  
#### To Stop Software Inventory Logging  
  
1.  Sign in to the server with an account that has local administrator privileges.  
  
2.  Open PowerShell as an Administrator.  
  
3.  At the PowerShell prompt, type **[Stop-SilLogging](https://technet.microsoft.com/library/dn283394.aspx)**  
  
## Configuring Software Inventory Logging  
There are three steps to configuring Software Inventory Logging to forward data to an aggregation server over time:  
  
1.  Use **Set-SilLogging –TargetUri** to specify the web address of your aggregation server (must start with "https://").  
  
2.  Use **Set-SilLogging –CertificateThumbprint** to specify the thumbprint hash of your valid SSL certificate to be used to authenticate the data transmissions to your aggregation server (your aggregation server will need to be configured to accept hash).  
  
3.  Install a valid SSL certificate (for your network) in the **Local Machine/Personal Store** (or **/LocalMachine/MY**) of the local server to forward data from.  
  
It is best to complete these steps before using **Start-SilLogging**.  If you want to use them after using **Start-SilLogging**, you simply need to stop and start SIL again.  Or, you can use the Publish-SilData Cmdlet to ensure the aggregation server has a full complement of the data for this server.  
  
For a comprehensive guide to setting up the SIL framework as a whole, see [Software Inventory Logging Aggregator](software-inventory-logging-aggregator.md).  In particular, if **Publish-SilData** produces an error, or SIL Logging fails otherwise, see the troubleshooting section .  
  
## <a name="BKMK_Step2"></a>Software Inventory Logging over time  
If Software Inventory Logging was started by an administrator, hourly collection and forwarding of the data to the aggregation server (target URI) commences. The first forward will be a complete data set of the same data that [Get-SilData](https://technet.microsoft.com/library/dn283388.aspx) retrieves and displays on the console at a point in time. Thereafter, at each interval, SIL will make a check of the data and only forward a small identifying acknowledgment to the target aggregation server if there is no change in the data since the last collection. If any value has changed, SIL will again send a complete data set.  
  
> [!IMPORTANT]  
> If at any interval the target URI is unreachable or the data transfer over the network is unsuccessful for any reason, data collected will be stored locally for up to a default value of 30 days (after which time it will be deleted). On the next successful forward of data to the target aggregation server, all data stored locally will be forwarded and local cached data will be deleted.  
  
## <a name="BKMK_Step3"></a>Displaying Software Inventory Logging data  
In addition to the PowerShell cmdlets described in the previous section, six additional cmdlets can be used to collect Software Inventory Logging data:  
  
-   **[Get-SilComputer](https://technet.microsoft.com/library/dn283392.aspx)**: Displays the point in time values for specific server and operating system-related data, as well as the FQDN or hostname of the physical host, if available.  
  
-   **[Get-SilComputerIdentity (KB 3000850)](https://technet.microsoft.com/library/dn858074.aspx)**: Displays identifiers used by SIL for individual servers.  
  
-   **[Get-SilData](https://technet.microsoft.com/library/dn283388.aspx)**: Displays a point in time collection of all Software Inventory Logging data.  
  
-   **[Get-SilSoftware](https://technet.microsoft.com/library/dn283397.aspx)**: Displays the point in time identity of all software installed on the computer.  
  
-   **[Get-SilUalAccess](https://technet.microsoft.com/library/dn283389.aspx)**: Displays the total number of unique client device requests and client user requests of the server from two days prior.  
  
-   **[Get-SilWindowsUpdate](https://technet.microsoft.com/library/dn283393.aspx)**: Displays the point in time list of all Windows updates installed on the computer.  
  
A typical use case scenario for Software Inventory Logging cmdlets would be for an administrator to query Software Inventory Logging for a point in time collection of all Software Inventory Logging data using [Get-SilSoftware](https://technet.microsoft.com/library/dn283397.aspx).  
  
**Output Example**  
  
```  
PS C:\> Get-SilData   
  
ID                 : 961FF8A1-8549-4BEC-8DF6-3B3E32C26FFA  
UUID               : B49ACB4C-7D9C-4806-9917-AE750BB3DA84  
VMGUID             : E84CCCBD-0D0F-486B-A424-9780C7CF92E4  
Name               : Server01Guest.Test.Contoso.com  
HypervisorHostName : Server01.Test.Contoso.com  
  
ID          : {F0C3E5D1-1ADE-321E-8167-68EF0DE699A5}  
Name        : Microsoft Visual C++ 2010  x86 Redistributable - 10.0.40219  
InstallDate : 12/5/2013  
Publisher   : Microsoft Corporation  
Version     : 10.0.40219  
  
ID          : {89F4137D-6C26-4A84-BDB8-2E5A4BB71E00}  
Name        : Microsoft Silverlight  
InstallDate : 3/20/2014  
Publisher   : Microsoft Corporation  
Version     : 5.1.30214.0  
  
ChassisSerialNumber       : 4452-0564-0284-2290-0113-6804-05  
CollectedDateTime         : 10/27/2014 4:01:33 PM  
Model                     : Virtual Machine  
Name                      : Server01Guest.Test.Contoso.com  
NumberOfCores             : 1  
NumberOfLogicalProcessors : 1  
NumberOfProcessors        : 1  
OSName                    : Microsoft Windows Server 2012 R2 Datacenter  
OSSku                     : 8  
OSSuite                   : 400  
OSSuiteMask               : 400  
OSVersion                 : 6.3.9600  
ProcessorFamily           : 179  
ProcessorManufacturer     : GenuineIntel  
ProcessorName             : Intel(R) Xeon(R) CPU           E5440  @ 2.83GHz  
SystemManufacturer        : Microsoft Corporation  
  
```  
  
> [!NOTE]  
> Output from this cmdlet is the same as all other **Get-Sil** cmdlets for this feature combined, but is provided to the console asynchronously so the order of the objects may not always be the same.  
>   
> It is not necessary to have Software Inventory Logging started to use the **Get-Sil** cmdlets.  
  
## <a name="BKMK_Step4"></a>Deleting data logged by Software Inventory Logging  
Software Inventory Logging is not intended to be a mission critical component. Its design is intended to impact local system operations as little as possible while maintaining a high level of reliability. This also allows the administrator to manually delete Software Inventory Logging database and supporting files (every file in \Windows\System32\LogFiles\SIL directory) to meet operational needs.  
  
#### To delete data logged by Software Inventory Logging  
  
1. In PowerShell, stop Software Inventory Logging with the **[Stop-SilLogging](https://technet.microsoft.com/library/dn283394.aspx)** command.  
  
2. Open Windows Explorer.  
  
3. Go to **\Windows\System32\Logfiles\SIL\\**  
  
4. Delete all files in the folder.  
  
## <a name="BKMK_Step5"></a>Backing up and restoring data logged by Software Inventory Logging  
Software Inventory Logging will temporarily store hourly collections of data if forwards over the network are failing. The log files are stored in the \Windows\System32\LogFiles\SIL\ directory. Backups of this Software Inventory Logging data can be made with your regularly scheduled server backups.  
  
> [!IMPORTANT]  
> If for any reason a repair installation or upgrade of the operating system is necessary, any log files stored locally will be lost.  If this data is critical for operations, it is recommended to be backed up prior to new operating system installation. After repair or upgrade, simply restore to the same location.  
  
> [!NOTE]  
> If for any reason managing the retention duration of data logged locally by SIL becomes important, this can be configured by changing the registry value here: \HKEY_LOCAL_MACHINE\\SOFTWARE\Microsoft\Windows\SoftwareInventoryLogging. The default is ‘30’ for 30 days.  
  
## <a name="BKMK_Step6"></a>Reading data logged and published by Software Inventory Logging  
Data logged by SIL, but stored locally (if the forward to the target URI fails), or data that is successfully forwarded to the target aggregation server, is stored in a binary file (for each day’s data). To display this data in PowerShell, use the [Import-BinaryMiLog](https://technet.microsoft.com/library/dn262592.aspx) cmdlet.  
  
## <a name="BKMK_Step7"></a>Software Inventory Logging Security  
Administrative privileges on the local server are required to successfully retrieve data from Software Inventory Logging WMI and PowerShell APIs.  
  
To successfully leverage the full capability of the Software Inventory Logging feature to forward data to an aggregation point continually over time (at hourly intervals), an administrator needs to employ client certificates to ensure secure SSL sessions for transfer of data over HTTPS. A basic overview of HTTPS authentication can be found here: [HTTPS authentication](https://technet.microsoft.com/library/cc736680(v=WS.10).aspx).  
  
Any data stored locally on a Windows Server (only occurs if the feature is started but the target is unreachable for any reason) is only accessible with administrative privileges on the local server.  
  
## <a name="BKMK_Step8"></a>Working with date and time settings in Windows Server 2012 R2 Software Inventory Logging  
  
-   When using [Set-SilLogging](https://technet.microsoft.com/library/dn283387.aspx) -TimeOfDay to set the time SIL logging runs, you must specify a date and time. The calendar date will be set and logging will not occur until the date is reached, in local system time.  
  
-   When using [Get-SilSoftware](https://technet.microsoft.com/library/dn283397.aspx), or [Get-SilWindowsUpdate](https://technet.microsoft.com/library/dn283393.aspx), "InstallDate" will always show 12:00:00AM, a meaningless value.  
  
-   When using [Get-SilUalAccess](https://technet.microsoft.com/library/dn283389.aspx), "SampleDate" will always show 11:59:00PM, a meaningless value.  Date is the pertinent data for these cmdlet queries.  
  
## <a name="BKMK_Step10"></a>Enabling and Configuring Software Inventory Logging in a Mounted Virtual Hard Disk  
Software Inventory Logging also supports configuration and enablement on offline virtual machines. The practical uses for this are intended to cover both ‘gold image’ setup for wide deployment across data centers, as well as configuring end user images going from a premises to a cloud deployment.  
  
To support these uses, Software Inventory Logging has registry entries associated with each configurable option.  These registry values can be found under \HKEY_LOCAL_MACHINE\\SOFTWARE\Microsoft\Windows\SoftwareInventoryLogging.  
  
|||||  
|-|-|-|-|  
|**Function**|**Value Name**|**Data**|**Corresponding Cmdlet (available only in the running OS)**|  
|Start/Stop Feature|CollectionState|1 or 0|[Start-SilLogging](https://technet.microsoft.com/library/dn283391.aspx), [Stop-SilLogging](https://technet.microsoft.com/library/dn283394.aspx)|  
|Specifies target aggregation point on the network|TargetUri|string|[Set-SilLogging](https://technet.microsoft.com/library/dn283387.aspx) -TargetURI|  
|Specifies Certificate Thumbprint or Hash of the certificate used for SSL authentication for the target web server|CertificateThumbprint|string|[Set-SilLogging](https://technet.microsoft.com/library/dn283387.aspx) -CertificateThumbprint|  
|Specifies the date and time that the feature should start (if value set is in the future according to local system time)|CollectionTime|Default:  2000-01-01T03:00:00|[Set-SilLogging](https://technet.microsoft.com/library/dn283387.aspx) -TimeOfDay|  
  
To modify these values on an offline VHD (VM OS not running), a VHD must be first mounted and then the following commands can be used to make changes:  
  
-   [Reg load](https://technet.microsoft.com/library/cc742053.aspx)  
  
-   [Reg delete](https://technet.microsoft.com/library/cc742145.aspx)  
  
-   [Reg add](https://technet.microsoft.com/library/cc742162.aspx)  
  
-   [Reg unload](https://technet.microsoft.com/library/cc742043.aspx)  
  
Software Inventory Logging will check these values when the OS starts, and execute accordingly.  
  
## <a name="BKMK_Step11"></a>Overview of Using Software Inventory Logging in Windows Server 2012 R2 without KB 3000850  
The following changes to Software Inventory Logging capability and default settings were made with [KB 3000850](https://support.microsoft.com/kb/3000850):  
  
-   The default interval for collection and forward over the network when SIL logging is started changed from daily to hourly (at random within each hour).  
  
-   The default data payload was reduced to only include objects from Get-SilComputer, Get-SilComputerIdentity, and Get-SilSoftware.  
  
-   Guest to host channel communication in Hyper-V environments was removed.  
  
## <a name="BKMK_Step12"></a>Using Software Inventory Logging in a Windows Server 2012 R2 Hyper-V environment without KB 3000850  
  
> [!NOTE]  
> This functionality is removed with the installation of the [KB 3000850](https://support.microsoft.com/kb/3000850) update.  
  
When using Software Inventory Logging on a Windows Server 2012 R2 Hyper-V host, it is possible to retrieve SIL data from Windows Server 2012 R2 guests that are running locally, if SIL logging has been started in the guest(s). However, this is only possible when using the Get-SilData and Publish-SilData Powershell cmdlets, and only possible with WIndows Server 2012 R2 in both host and guest.  The purpose of this capability is to allow data center administrators that provide guest VMs to tenants, or other entities of a large corporation, to capture software inventory data at the hypervisor host and subsequently forward all of this data to an aggregator (or target URI).  
  
Below are two examples of what the output on the PowerShell console would look like (much abbreviated) on a Windows Server 2012 R2 Hyper-V host running one Windows Server 2012 R2 guest VM with SIL logging started.  You will notice the first example, which uses Get-SilData alone, will output all data from the host as expected.  Also included is all SIL data from the guest, but in a collapsed format.  To expand and view this data from the guest, simply cut and paste the snippet used in the second example below.  SIL data objects from the guest will always have the VM GUID associated within the object.  
  
> [!NOTE]  
> Since SIL data is output on the console, when using the Get-SilData cmdlet, in data streams, objects will not always be output in a predictive order.  In the two examples below, the text has been color coded (blue for physical host data and green for virtual guest data) only as an illustrative tool for this document.  
  
**Output Example 1**  
  
![](../media/software-inventory-logging/SILHyper-VExample1.png)  
  
**Output Example 2** (w/ Expand-SilData function)  
  
![](../media/software-inventory-logging/SILHyper-VExample2.png)  
  
## See Also  
[Get Started with Software Inventory Logging](get-started-with-software-inventory-logging.md)  
[Software Inventory Logging Aggregator](software-inventory-logging-aggregator.md)  
[Software Inventory Logging Cmdlets in Windows PowerShell](https://technet.microsoft.com/library/dn283390.aspx)  
[Import-BinaryMiLog](https://technet.microsoft.com/library/dn262592.aspx)  
[Export-BinaryMiLog](https://technet.microsoft.com/library/dn262591.aspx)  
  

