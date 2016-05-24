---
title: Windows Storage Server Testing and Troubleshooting
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bb7089c3-ca29-4c6e-867b-f18c6ca1f726
---
# Windows Storage Server Testing and Troubleshooting
After you preinstall the Windows Storage Server 2012 operating system on the reference computer, and before you capture the image and deploy it to customer computers, you should test and, if needed, troubleshoot the reference installation.  
  
|||  
|-|-|  
|![](b93f8edc-baa1-46ad-aed5-99c8690273c0)|Did you know that Microsoft Azure provides similar functionality in the cloud? Learn more about [Microsoft Azure storage solutions](http://aka.ms/y03tdi).<br /><br />Create a hybrid storage solution in Microsoft Azure:<br />\- [Learn about cost\-effective, highly responsive solid\-state storage for Azure virtual machines](http://aka.ms/xmo126)|  
  
## Testing storage appliance remote access  
As a best practice, you should verify that the storage appliance can be accessed remotely over the network. To test this, you must configure a client appropriately.  
  
## Enable VDS tracing  
If iSCSI Target Server is enabled on a computer running Windows Storage Server 2012, and if the Microsoft Virtual Disk Service \(VDS\) is installed on the application server \(the iSCSI initiator\), you can use the following procedure to enable VDS tracing to help in troubleshooting.  
  
#### To enable VDS tracing  
  
1.  On the computer running Windows Storage Server 2012, open a Command Prompt window. To exit all VDS clients and stop the VDS service, type: `net stop vds`  
  
2.  To set a registry key to enable debug logging, type: `reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vds\DebugLog /v Level /t REG_DWORD /d 31 /f`  
  
3.  Use one of the following methods to start VDS and reproduce the issue:  
  
    1.  Load the Diskpart.exe command interpreter.  
  
    2.  Run the Diskraid.exe command.  
  
    3.  Start another VDS client application.  
  
    4.  At a command prompt, type: `net start vds`  
  
4.  Confirm that VDS has created a log file at **%Windir%\\System32\\$vds$.log**.  
  
## Troubleshooting ICT customization  
The ICT user interface has the ability to handle assertions and collect tracing data that OEMs or developers can use to trap and diagnose error conditions that may occur when customizing the ICT window. Providing assertions and collecting tracing data are enabled by default. However, these settings can be adjusted as required for development purposes.  
  
> [!IMPORTANT]  
> If you have enabled the display of assertions or the collection of tracing data, you should disable it before you capture a completed installation as a master image.  
  
When enabled, tracing output is captured in the default OEMOOBE.txt file, which is located in the **%Windir%\\System32\\OEMOOBE** folder. The file name can be adjusted if required. In addition, the file can be safely deleted when the ICT window is closed, and it will be automatically re\-created the next time the ICT window runs.  
  
#### To disable the handling of assertions or tracing data collection  
  
1.  Open Notepad and then the OEMOOBE.exe.config file \(located at **%Windir%\\System32\\OEMOOBE**\).  
  
2.  In the following line, change the value from `true` to `false`: `<add key="AssertOnErrors" value="true" />.`  
  
3.  In the following line, change the value from `All` to `Off`: `<source name="Microsoft.StorageManagement.OEMOOBE.Tracing" switchValue="All" />`.  
  
4.  Save your changes to the OEMOOBE.exe.config file. The changes made to this file will be read the next time OEMOOBE.exe runs, and the assertions and tracing data will not be displayed or collected.  
  
#### To change the amount of tracing data collected  
  
1.  Open Notepad, and then open the OEMOOBE.exe.config file \(located at **%Windir%\\System32\\OEMOOBE**\).  
  
2.  In the following line, change the switchValue parameter from `All` to one of the values in the list that follows: `<source name="Microsoft.StorageManagement.OEMOOBE.Tracing" switchValue="All" />.`  
  
    **Off**: Set this parameter if you do not want any tracing data to be collected.  
  
    **Error**: Set this parameter if you want only system\-level details when an error is reported.  
  
    **Warning**: Set this parameter if you want system\-level details when the ICT window reports an error or a warning.  
  
    **Information**: Set this parameter if you want system\-level details when the ICT window reports an error, a warning, or when a successful event has occurred.  
  
    **Verbose**: Set this parameter if you want verbose system\-level details whenever the ICT window reports an error or a warning, or when a successful event has occurred.  
  
    **All**: Set this parameter if you want verbose system\-level details whenever the ICT window reports an error or a warning, or when a successful event occurs. This parameter enables the collection of all activity tracing details. Because this setting creates large log files and it may consume larger amounts of system resources, this parameter should be set only when directed by Microsoft support personnel.  
  
3.  On the **Security** tab, select **Trusted sites**, and then click **Custom level**.  
  
4.  Under **Settings**, scroll down to **Initialize and script ActiveX controls not marked as safe for scripting**, and then click **Enable** or **Prompt**.  
  
5.  Click **OK** to save the change to the security policy.  
  
#### To change the name of the file that contains trace log data  
  
1.  Open Notepad, and then open the OEMOOBE.exe.config file \(normally located at **%Windir%\\System32\\OEMOOBE**\).  
  
2.  In the following line, change the `switchValue` parameter from `OEMOOBE.txt` to the desired file name: `<add name="file" type="System.Diagnostics.TextWriterTraceListener" initializeData="OEMOOBE.txt"/>`  
  
3.  Save your changes to the OEMOOBE.exe.config file to change the name of the file that contains system logging data.  
  
### Troubleshooting Cluster Creation  
Under certain circumstances, you may be unable to run the Create Cluster wizard. Specifically, this can occur right after both nodes are successfully joined to the domain but the second node name is not successfully written to the Windows registry. In this case, you will need to enter the name of the second node in the Data field for the following registry key:  
  
**HKEY\_LOCAL\_MACHINE\/Software\/Microsoft\/OEMOOBE\/RemoteNodeName**`REG_SZ  Data = <enter second node name here>`  
  
Afterwards, you can rerun the Create Cluster wizard and proceed to create the cluster.  
  
### Troubleshooting Cluster Storage Provisioning  
If you choose to use Server Manager to provision cluster storage before the cluster has been created, you may need to tell the user to manually add each node to the Server Manager machine pool for provisioning to succeed. In Server Manager, users should click **Manage** and then click **Add Servers** as shown.  
  
### Troubleshooting the BulkException Error  
You must have a Nic.config file in the **Windows\/System32\/OEMOOBE** folder, otherwise a BulkException error will be generated.  
  
