---
title: Get started with Setup and Boot Event Collection
description: "Setting up Setup and Boot Event Collection collectors and targets"
ms.prod: windows-server
ms.service: na
manager: DonGill
ms.technology: server-sbec
ms.localizationpriority: medium
ms.date: 10/16/2017
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: fc239aec-e719-47ea-92fc-d82a7247b3f8
author: jaimeo
ms.author: jaimeo
---
# Get started with Setup and Boot Event Collection

>Applies To: Windows Server

  
## Overview  
Setup and Boot Event Collection is a new feature in Windows Server 2016 that allows you to designate a "collector" computer that can gather a variety of important events that occur on other computers when they boot or go through the setup process. You can then later analyze the collected events with Event Viewer, Message Analyzer, Wevtutil, or Windows PowerShell cmdlets.  
  
Previously, these events have been impossible to monitor because the infrastructure needed to collect them doesn't exist until a computer is already set up. The kinds of setup and boot events you can monitor include:  
  
-   Loading of kernel modules and drivers  
  
-   Enumeration of devices and initialization of their drivers (including "devices" such as CPU type)  
  
-   Verification and mounting of file systems  
  
-   Starting of executable files  
  
-   Starting and completions of system updates  
  
-   The points when the system becomes available for logon, establishes connection with a domain controller, completion of service starts, and availability of network shares  
  
The collector computer must be running Windows Server 2016 (it can be in either Server with Desktop Experience or Server Core mode). The target computer must be running either Windows 10 or Windows Server 2016. You can also run this service on a virtual machine which is hosted on a computer that is **not** running Windows Server 2016. The following combinations of virtualized collector and target computers are known to work:  
  
|Virtualization host|Collector virtual machine|Target virtual machine|  
|-----------------------|-----------------------------|--------------------------|  
|Windows 8.1|yes|yes|  
|Windows 10|yes|yes|  
|Windows Server 2016|yes|yes|  
|Windows Server 2012 R2|yes|no|  
  
## Installing the collector service  
Starting with the Windows Server 2016, the event collector service is available as an optional feature. In this release, you can install it using DISM.exe with this command at an elevated Windows PowerShell prompt:  
  
`dism /online /enable-feature /featurename:SetupAndBootEventCollection`  
  
This command creates a service called BootEventCollector and starts it with an empty configuration file.  
  
Confirm that the installation succeed by checking `get-service -displayname *boot*`. The Boot Event Collector should be running. It runs under the Network Service Account and creates an empty configuration file (Active.xml) in **%SystemDrive%\ProgramData\Microsoft\BootEventCollector\Config**.  
  
You can also install the Setup and Boot Event Collection service with the Add Roles and Features wizard in Server Manager.  
  
## Configuration  
You need to configure two items to collect setup and boot events.  
  
-   On the target computers which will send the events (that is, the computers whose setup and boot you want to monitor), enable the KDNET/EVENT-NET transport and enable the forwarding of events.  
  
-   On the collector computer, specify which computers to accept events from and where to save them.  
  
> [!NOTE]  
> You cannot configure a computer to send the startup or boot events to itself. But if you want to monitor two computers, you can configure them to send the events to each other.  
  
### Configuring a target computer  
On each target computer, you first enable the KDNET/EVENT-NET transport, then enable sending of ETW events through the transport, and then restart the target computer. EVENT-NET is an in-kernel transport protocol which is similar to KDNET (the kernel debugger protocol). EVENT-NET only transmits events and doesn't allow debugger access. These two protocols are mutually exclusive; you can only enable one of them at a time.  
  
You can enable event transport remotely (with Windows PowerShell) or locally.  
  
##### To enable event transport remotely  
  
1.  If you have already set up Windows PowerShell Remoting to the target computer, skip to Step 3. If not, then on the target computer, open a command prompt and run the following command:  
  
    winrm quickconfig  
  
2.  Respond to the prompts and then restart the target computer. If the target computers are not in the same domain as the collector computer, you might need to define them as trusted hosts. To do this:  
  
3.  On the collector computer, run either of these commands:  
  
    -   In a Windows PowerShell prompt: `Set-Item -Force WSMan:\localhost\Client\TrustedHosts "<target1>,<target2>,..."`, followed by `Set-Item -Force WSMan:\localhost\Client\AllowUnencrypted true` where \<target1>, etc. are the names or IP addresses of the target computers.  
  
    -   Or in a command prompt: **winrm set winrm/config/client @{TrustedHosts="\<target1>,\<target2>,...";AllowUnencrypted="true"}**  
  
        > [!IMPORTANT]  
        > This sets up unencrypted communication, so don't do this outside of a lab environment.  
  
4.  Test the remote connection by going to the collector computer and running one of these Windows PowerShell commands:  
  
    If the target computer is in the same domain as the collector computer, run `New-PSSession -Computer <target> | Remove-PSSession`  
  
    If the target computer is not in the same domain, run `New-PSSession -Computer  <target>  -Credential Administrator | Remove-PSSession`, which will prompt you for credentials.  
  
    If the command doesn't return anything, remoting was successful.  
  
5.  On the target computer, open an elevated Windows PowerShell prompt and run this command:  
  
    `Enable-SbecBcd -ComputerName <target_name> -CollectorIP <ip> -CollectorPort <port> -Key <a.b.c.d>`  
  
    Here <target_name> is the name of the target computer, \<ip> is the IP address of the collector computer. \<port> is the port number where the collector will run. The Key <a.b.c.d> is a required encryption key for the communication, comprising four alphanumeric strings separated by dots. This same key is used on the collector computer. If you don't enter a key, the system generates a random key; you'll need this for the collector computer, so make a note of it.  
  
6.  If you already have a collector computer set up, update the configuration file on the collector computer with the information for the new target computer. See the "Configuring the collector computer" section for details.  
  
##### To enable event transport locally on the target computer  
  
1.  Start an elevated command prompt, and then run these commands:  
  
    **bcdedit /event yes**  
  
    **bcdedit /eventsettings net hostip:1.2.3.4 port:50000 key:a.b.c.d**  
  
    Here "1.2.3.4" is an example; replace this with the IP address of the collector computer. Also replace "50000" with the port number where the collector will run and "a.b.c.d" with the required encryption key for the communication. This same key is used on the collector computer. If you don't enter a key, the system generates a random key; you'll need this for the collector computer, so make a note of it.  
  
2.  If you already have a collector computer set up, update the configuration file on the collector computer with the information for the new target computer. See the "Configuring the collector computer" section for details.  
  
**Now that event transport itself is enabled, you must enable the system to actually send ETW events through that transport.**  
  
##### To enable sending of ETW events through the transport remotely  
  
1.  On the collector computer, open an elevated Windows PowerShell prompt.  
  
2.  Run `Enable-SbecAutologger -ComputerName <target_name>`, where <target_name> is the name of the target computer.  
  
If you aren't able to set up Windows PowerShell Remoting, you can always enable sending of events directly on the target computer.  
  
##### To enable sending of ETW events through the transport locally  
  
1.  On the target computer, start Regedit.exe and find this registry key:  
  
    **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger**. Various log sessions are listed as sub-keys under this key. **Setup Platform**, **NT Kernel Logger**, and **Microsoft-Windows-Setup** are possible choices for use with Setup and Boot Event Collection, but the recommended option is **EventLog-System**. These keys are detailed in [Configuring and Starting an AutoLogger Session](https://msdn.microsoft.com/library/windows/desktop/aa363687(v=vs.85).aspx).  
  
2.  In the EventLog-System key, change the value of **LogFileMode** from **0x10000180** to **0x10080180**. For more information about the details of these settings, see [Logging Mode Constants](https://msdn.microsoft.com/library/windows/desktop/aa364080(v=vs.85).aspx).  
  
3.  Optionally, you can also enable forwarding of bug check data to the collector computer. To do this, find the registry key HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager and create the key **Debug Print Filter** with a value of **0x1**.  
  
4.  Restart the target computer.  
  
### Choosing the network adapter  
If the target computer has more than one network adapter, the KDNET driver will choose the first supported one listed. You can specify a particular network adapter to use for forwarding setup events with these steps:  
  
##### To specify a network adapter  
  
1.  On the target computer, open Device Manager, expand **Network Adapters**, find the network adapter you want to use, and right-click it.  
  
2.  In the menu that opens, click **Properties**, and then click the **Details** tab. Expand the menu in the **Property** field, scroll to find **Location information** (the list is probably not in alphabetical order), and then click it. The value will be a string of the form **PCI bus X, device Y, function Z**. Make note of X.Y.Z; these are the bus parameters you need for the following command.  
  
3.  Run either one of these commands:  
  
    From an elevated Windows PowerShell prompt: `Enable-SbecBcd -ComputerName <target_name> -CollectorIP <ip> -CollectorPort <port> -Key <a.b.c.d> -BusParams <X.Y.Z>`  
  
    From an elevated command prompt: **bcdedit /eventsettings  net hostip:aaa port:50000 key:bbb busparams:X.Y.Z**  
  
### Validate target computer configuration  
To check settings on the target computer, open an elevated command prompt and run **bcdedit /enum**. When this is finished, then run **bcdedit /eventsettings**. You can double-check the following values:  
  
-   Key  
  
-   Debugtype = NET  
  
-   Hostip = \<IP address of the collector>  
  
-   Port = \<port number you specified for the collector to use>  
  
-   DHCP = yes  
  
Also check that you have enabled **bcdedit /event**, since **/debug** and **/event** are mutually exclusive. You can only run one or the other. Similarly, you can't mix /eventsettings with /debug or /dbgsettings with /event.  
  
Note also that event collection doesn't work if you set it to a serial port.  
  
### Configuring the collector computer  
The collector service receives the events and saves them in ETL files. These ETL files can then be read by other tools, such as Event Viewer, Message Analyzer, Wevtutil, and Windows PowerShell cmdlets.  
  
Since the ETW format doesn't allow you to specify the target computer name, the events for each target computer must be saved to a separate file. The display tools might show a computer name but it will be the name of the computer on which the tool runs.  
  
More exactly, each target computer is assigned a ring of ETL files. Each file name includes an index from 000 to a maximum value that you configure (up to 999). When the file reaches the maximum configured size, it switches writing events to the next file. After the highest possible file it switches back to file index 000. In this way, the files are automatically recycled, limiting usage of disk space. You can also set additional external retention policies to further limit disk usage; for example, you can delete files older than a set number of days.  
  
Collected ETL files are typically kept in the directory **c:\ProgramData\Microsoft\BootEventCollector\Etl** (which might have additional subdirectories). You can find the most recent log file by sorting them by the last modification time. There is also a status log (typically in **c:\ProgramData\Microsoft\BootEventCollector\Logs**), which records whenever the collector switches writing to a new file.  
  
There is also a collector log, which records information about the collector itself. You can keep this log in the ETW format (in which events are reported to the Windows log service; this is the default) or in a file (normally in **c:\ProgramData\Microsoft\BootEventCollector\Logs**). Using a file could be useful if you want to enable verbose modes that produce a lot of data. You can also set the log to write to a standard output by running the collector from the command line.  
  
**Creating the collector configuration file**  
  
When you enable the service, three XML configuration files are created and stored in **c:\ProgramData\Microsoft\BootEventCollector\Config**:  
  
-   **Active.xml** This file contains the current active configuration of the collector service.  Right after installation, this file has the same contents as Empty.xml. When you set a new collector configuration you save it to this file.  
  
-   **Empty.xml** This file contains the minimum configuration elements needed with their default values set. It does not enable any collection; it only allows the collector service to start in an idle mode.  
  
-   **Example.xml** This file provides examples and explanations of the possible configuration elements.  
  
**Choosing a file size limit**  
  
One of the decisions you have to make is to set a file size limit. The best file size limit depends on the expected volume of events and available disk space. Smaller files are more convenient from the standpoint of cleaning the old data. However, each file carries with it the overhead of a 64KB header and reading many files to get the combined history might be inconvenient. The absolute minimum file size limit is 256 KB. A reasonable practical file size limit should be over 1 MB, and 10 MB is probably a good typical value. A higher limit might be reasonable if you expect many events.  
  
There are several details to keep in mind regarding the configuration file:  
  
-   The target computer address. You can use its IPv4 address, a MAC address, or a SMBIOS GUID. Keep these factors in mind when choosing the address to use:  
  
    -   The IPv4 address works best with static assignment of the IP addresses. However, even static IP addresses must be available through DHCP.  
  
    -   A MAC address or SMBIOS GUID is convenient when they are known in advance but the IP addresses are assigned dynamically.  
  
    -   IPv6 addresses are not supported by the EVENT-NET protocol.  
  
    -   It is possible to specify multiple ways to identify the computer. For example, if the physical hardware is about to be replaced, you can enter both the old and the new MAC addresses, and either will be accepted.  
  
-   The encryption key used for the communication with the collector computer  
  
-   The name of the target computer. You can use the IP address, host name, or any other name as the computer name.  
  
-   The name of the ETL file to use and the ring size configuration for it  
  
##### To create the configuration file  
  
1.  Open an elevated Windows PowerShell prompt and change directories to %SystemDrive%\ProgramData\Microsoft\BootEventCollector\Config.  
  
2.  Type `notepad .\newconfig.xml` and press ENTER.  
  
3.  Copy this example configuration into the Notepad window:  
  
    ```  
    <collector configVersionMajor="1" statuslog="c:\ProgramData\Microsoft\BootEventCollector\Logs\statuslog.xml">  
      <common>  
        <collectorport value="50000"/>  
        <forwarder type="etl">  
          <set name="file" value="c:\ProgramData\Microsoft\BootEventCollector\Etl\{computer}\{computer}_{#3}.etl"/>  
          <set name="size" value="10mb"/>  
          <set name="nfiles" value="10"/>  
          <set name="toxml" value="none"/>  
        </forwarder>  
        <target>  
          <ipv4 value="192.168.1.1"/>  
          <key value="a.b.c.d"/>  
          <computer value="computer1"/>  
        </target>  
        <target>  
          <ipv4 value="192.168.1.2"/>  
          <key value="d1.e2.f3.g4"/>  
          <computer value="computer2"/>  
        </target>  
      </common>  
    </collector>  
    ```  
  
    > [!NOTE]  
    > The root node is \<collector>. Its attributes specify the version of the configuration file syntax and the name of the status log file.  
    >   
    > The \<common> element groups together multiple targets specifying the common configuration elements for them, very much like a user group can be used to specify the common permissions for multiple users.  
    >   
    > The \<collectorport> element defines the UDP port number where the collector will listen for incoming data. This is the same port as was specified in the target configuration step for Bcdedit. The collector supports only one port and all the targets must connect to the same port.  
    >   
    > The \<forwarder> element specifies how ETW events received from the target computers will be forwarded. There is only one type of forwarder, which writes them to the ETL files. The parameters specify the file name pattern, the size limit for each file in the ring, and the size of the ring for each computer. The setting "toxml" specifies that the ETW events will be written in the binary form as they were received, without conversion to XML. See the "XML event conversion" section for information about deciding whether to confer the events to XML or not. The file name pattern contains these substitutions: {computer} for the computer name and {#3} for the index of file in the ring.  
    >   
    > In this example file, two target computers are defined with the \<target> element. Each definition specifies the IP address with \<ipv4>, but you could also use the MAC address (for example, <mac value="11:22:33:44:55:66"\/> or <mac value="11-22-33-44-55-66"\/>) or SMBIOS GUID (for example, <guid value="{269076F9-4B77-46E1-B03B-CA5003775B88}"\/>) to identify the target computer. Also note the encryption key (the same as was specified or generated with Bcdedit on the target computer), and the computer name.  
  
4.  Enter the details for each target computer as a separate \<target> element in the configuration file, and then save Newconfig.xml and close Notepad.  
  
5.  Apply the new configuration with `$result = (Get-Content .\newconfig.xml | Set-SbecActiveConfig); $result`. The output should return with the Success field "true." If you get another result, see the Troubleshooting section of this topic.  
  
You can always check the current active configuration with `(Get-SbecActiveConfig).text`.  
  
You can perform a validity check on the configuration file with `$result = (Get-Content .\newconfig.xml | Check-SbecConfig); $result`.  
  
Though the Windows PowerShell command to apply a new configuration automatically updates the service without requiring you to restart it, you can always restart the service yourself with either of these commands:  
  
-   With Windows PowerShell: `Restart-Service BootEventCollector`  
  
-   In an ordinary command prompt: **sc stop BootEventCollector; sc start BootEventCollector**  
  
## Configuring Nano Server as a target computer  
The minimal interface offered by Nano Server can sometimes make it hard to diagnose issues with it. You can configure your Nano Server image to participate in Setup and Boot Event Collection automatically, sending diagnostic data to a collector computer without further intervention from you. To do this, follow these steps:  
  
#### To configure Nano Server as a target computer  
  
1.  Create your basic Nano Server image. See [Getting Started with Nano Server](https://technet.microsoft.com/library/mt126167.aspx) for details.  
  
2.  Set up a collector computer as in the "Configuring the collector computer" section of this topic.  
  
3.  Add AutoLogger registry keys to enable sending diagnostic messages. To do this, you mount the Nano Server VHD created in Step 1, load the registry hive, and then add certain registry keys. In this example, the Nano Server image is in C:\NanoServer; your path might be different, so adjust the steps accordingly.  
  
    1.  On the collector computer, copy the **..\Windows\System32\WindowsPowerShell\v1.0\Modules\BootEventCollector** folder and paste it into the **..\Windows\System32\WindowsPowerShell\v1.0\Modules** directory on the computer you are using to modify the Nano Server VHD.  
  
    2.  Start a Windows PowerShell console with elevated permissions and run `Import-Module BootEventCollector` .  
  
    3.  Update the Nano Server VHD registry to enable AutoLoggers. To do this, run `Enable-SbecAutoLogger -Path C:\NanoServer\Workloads\IncludingWorkloads.vhd`. This adds a basic list of the most typical setup and boot events; you can research others  at [Controlling Event Tracing Sessions](https://msdn.microsoft.com/library/windows/desktop/aa363694(v=vs.85).aspx).  
  
4.  Update BCD settings in the Nano Server image to enable the Events flag and set the collector computer to ensure diagnostic events are sent to the right server. Note the collector computer's IPv4 address, TCP port, and encryption key you configured in the collector's Active.XML file (described elsewhere in this topic). Use this command in a Windows PowerShell console with elevated permissions: `Enable-SbecBcd -Path C:\NanoServer\Workloads\IncludingWorkloads.vhd -CollectorIp 192.168.100.1 -CollectorPort 50000 -Key a.b.c.d`  
  
5.  Update the collector computer to receive event sent by the Nano Server computer by adding either the IPv4 address range, the specific IPv4 address, or the MAC address of the Nano Server to the Active.XML file on the collector computer (see the "Configuring the collector computer" section of this topic).  
  
## Starting the event collector service  
Once a valid configuration file is saved on the collector computer and a target computer is configured, as soon as the target computer is restarted, the connection to the collector is made and events will be collected.  
  
The log for the collector service itself (which is distinct from the setup and boot data collected by the service) can be found under Microsoft-Windows-BootEvent-Collector/Admin . For a graphical interface for the events, use Event Viewer. Create a new view; expand **Applications and Services Logs**, then expand **Microsoft** and then **Windows**. Find **BootEvent-Collector**, expand it, and find **Admin**.  

-   With Windows PowerShell: `Get-WinEvent -LogName Microsoft-Windows-BootEvent-Collector/Admin`  
  
-   In an ordinary command prompt: **wevtutil qe Microsoft-Windows-BootEvent-Collector/Admin**  
  
## Troubleshooting  
  
### Troubleshooting installation of the feature  
  
||Error|Error description|Symptom|Potential problem|  
|-|---------|---------------------|-----------|---------------------|  
|Dism.exe|87|The feature-name option is not recognized in this context||-   This can happen if you misspell the feature name. Verify that you have the correct spelling and try again.<br />-   Confirm that this feature is available on the operating system version you are using. In Windows PowerShell, run **dism /online /get-features &#124; ?{$_ -match "boot"}**. If no match is returned, you're probably running a version that doesn't support this feature.|  
|Dism.exe|0x800f080c|Feature \<name> is unknown.||Same as above|  
  
### Troubleshooting the collector  
  
**Logging:**  
The Collector logs its own events as ETW provider Microsoft-Windows-BootEvent-Collector. It's the first place you should look for troubleshooting problems with the collector. You can find them in Event Viewer under Applications and Services Logs > Microsoft > Windows > BootEvent-Collector > Admin, or you can read them in a command window with either of these commands:  
  
In an ordinary command prompt: **wevtutil qe Microsoft-Windows-BootEvent-Collector/Admin**  
  
In a Windows PowerShell prompt: `Get-WinEvent -LogName Microsoft-Windows-BootEvent-Collector/Admin` (you can append `-Oldest` to return the list in chronological order with oldest events first)  
  
You can adjust the level of detail in the logs from "error," through "warning," "info" (the default), "verbose," and "debug." More detailed levels than "info" are useful for diagnosing problems with target computers not connecting, but they might generate a large amount of data, so use them with care.  
  
You set the minimum log level in the \<collector> element of the configuration file. For example: <collector configVersionMajor="1" minlog\="verbose">.  
  
The verbose level logs a record for every packet received as it is processed. The debug level adds more processing detail and dumps the contents of all received ETW packets as well.  
  
At the debug level, it might be useful to write the log into a file rather than trying to view it in the usual logging system. To do this, add an additional element in the \<collector> element of the configuration file:  
  
<collector configVersionMajor="1" minlog="debug" log\="c:\ProgramData\Microsoft\BootEventCollector\Logs\log.txt">  
      
 **A suggested approach to troubleshooting the Collector:**  
   
1. First of all, verify that the collector has received the connection from the target (it will create the file only when the target starts sending the messages) with   
   ```  
   Get-SbecForwarding  
   ```  
   If it returns that there is a connection from this target then the problem might be in the autologger settings. If it returns nothing, the problem is with the KDNET connection to start with. To diagnose KDNET connection problems, try checking the connection from both ends (that is, from the collector and from the target).  
  
2. To see extended diagnostics from the Collector, add this to the \<collector> element of the configuration file:  
   \<collector ... minlog="verbose">  
   This will enable messages about every received packet.  
3. Check whether any packets are received at all. Optionally, you might want to write the log in verbose mode directly to a file rather than through ETW. To do this, add this to the \<collector> element of the configuration file:  
   \<collector ... minlog="verbose" log="c:\ProgramData\Microsoft\BootEventCollector\Logs\log.txt">  
      
4. Check the event logs for any messages about the received packets. Check whether any packets are received at all. If the packets are received but incorrect, check event messages for details.  
5. From the target side, KDNET writes some diagnostic information into the registry. Look in   
   **HKLM\SYSTEM\CurrentControlSet\Services\kdnet** for messages.  
   KdInitStatus (DWORD) will = 0 on success and show an error code on error  
   KdInitErrorString = explanation of the error (also contains informational messages if no error)  
  
6. Run Ipconfig.exe on the target and check for the device name it reports. If KDNET loaded properly, the device name should be  something like "kdnic" instead of the original vendor's card name.  
7. Check whether DHCP is configured for the target. KDNET absolutely requires DHCP.  
8. Confirm that the collector is on the same network as the target. If not, check whether the routing is configured correctly, especially the default gateway setting for DHCP.  
  
  
**Connection status**  
  
You can check the current list of established connections and information on where the data is being forwarded with `Get-SbecForwarding`.  
  
You can also get the recent history of status changes in connections with `Get-SbecHistory`.  
  
### Troubleshooting setting a new configuration  
If you applied the configuration with the Windows PowerShell command `$result = (Get-Content .\newconfig.xml | Set-SbecActiveConfig); $result`, then the variable `$result` will contain information about the deployment. You can query this variable to get different information out of it:  
  
Get information about errors with `$result.ErrorString`. If any errors are reported here, the new configuration will not have been applied and the old configuration will be unchanged.  
  
Get warnings with `$result.WarningString`.  
  
Get information on the details of the configuration with `$result.InfoString`.  
  
You can get the complete result with `$result | fl *`.  
Alternately, if you don't want to save the result in a variable, you can use `Get-Content .\newconfig.xml | Set-SbecActiveConfig | fl *`.  
  
### Troubleshooting target computers  
  
||Error|Error description|Symptom|Potential problem|  
|-|---------|---------------------|-----------|---------------------|  
|Target computer||Target is not connecting to the Collector||-   The target computer didn't get restarted after it was configured. Restart the target computer.<br />-   The target computer has incorrect BCD settings. Check the settings in the "Validate target computer settings" section. Correct as necessary, and then restart the target computer.<br />-   The KDNET/EVENT-NET driver was not able to connect to a network adapter or connected to the wrong network adapter. In Windows PowerShell, run `gwmi Win32_NetworkAdapter` and check the output for one with the ServiceName **kdnic**. If the wrong network adapter is selected, re-do the steps in "To specify a network adapter." If the network adapter doesn't appear at all, it could be that the driver doesn't support any of your network adapters.<br>**See also** "A suggested approach to troubleshooting the Collector" above, especially Steps 5 through 8.|  
|Collector||I am no longer seeing events after migrating the VM my collector is hosted on.||Verify that the IP address of the collector computer has not changed. If it has, review "To enable sending of ETW events through the transport remotely."|  
|Collector||The ETL files are not created.|`Get-SbecForwarding` shows that the target has connected, with no errors, but the ETL files are not created.|The target computer has probably not sent any data yet; ETL files are only created when data is received.|  
|Collector||An event is not showing in the ETL file.|The target computer has sent an event but when the ETL file is read with Event Viewer of Message Analyzer, the event is not present.|-   The event could still be in the buffer. Events aren't written to the ETL file until a full 64 KB buffer is collected or a timeout of about 10-15 seconds with no new events has occurred. Either wait for the timeout to expire or flush the buffers with `Save-SbecInstance`.<br />-   The event manifest is not available on the collector computer or the computer where the Event Viewer or Message Analyzer runs.  In this case, the Collector might not be able to process the event (check the Collector log) or the viewer might not be able to show it.  It is a good practice to have all the manifests installed on the collector computer and install updates on the collector computer before installing them on the target computers.|
