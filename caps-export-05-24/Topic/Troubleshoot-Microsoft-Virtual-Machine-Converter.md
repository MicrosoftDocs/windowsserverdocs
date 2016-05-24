---
title: Troubleshoot Microsoft Virtual Machine Converter
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 50f9c472-bae8-4d36-a78a-fc2fe07752ff
author: cwatsonmsft
---
# Troubleshoot Microsoft Virtual Machine Converter
This section provides information about common or known issues that you might experience while you are using Microsoft Virtual Machine Converter and information about the techniques that you can use to troubleshoot these issues.  
  
## Use the MVMC log file  
MVMC logs information and error details in the MVMC.log file in the user’s Temp folder when MVMC is invoked through the user interface \(UI\).  
  
## Troubleshoot issues in the converter  
  
### Issue number 1  
MVMC is not able to connect to an online Windows virtual machine.  
  
-   I get the following error when I run MVMC.exe:  
  
    “Microsoft.Accelerators.Mvmc.Engine.RpcServerUnavailableException: The RPC server is unavailable.”  
  
-   I get an error when I click **Next** on the **Virtual Machine Connection** page in the MVMC Wizard.  
  
**Possible cause and solutions for issue number 1**  
  
|Possible cause|Possible solutions|  
|------------------|----------------------|  
|Remote access through Windows Management Instrumentation \(WMI\) is not enabled on the virtual machine.|**Windows Management Instrumentation**<br /><br />Ensure that Windows Management Instrumentation \(WMI\) is allowed through **Windows Firewall**.<br /><br />**To allow WMI**<br />1.  Click **Start**, and then click **Control Panel**.<br />2.  Click **Windows Firewall**, and then select **Allow a program through Windows Firewall**.<br />3.  In the list of allowed programs and features, select **Windows Management Instrumentation**, and then select the **Domain** check box.<br /><br /><br /><br />To enable WMI through Group Policy settings, enable the Remote Administration exception for computers that have **Windows Firewall** enabled. This exception opens TCP port 135. If you have another host firewall installed, you have to allow network traffic through this port.<br /><br />**To enable remote administration**<br />1.  Click **Start**, and then click **Run**. In the **Open** box, type **gpedit.msc**, and then click **OK**.<br />2.  Under **Console Root**, expand **Computer Configuration** > **Administrative Templates** > **Network** > **Network Connections** > **Windows Firewall**, and then click **Domain Profile**.<br />3.  Right\-click **Windows Firewall: Allow remote administration exception**, and then click **Properties**.<br />4.  Click **Enabled**, and then click **OK**.<br /><br />**File and Printer Sharing exception**<br /><br />Enable the File and Printer Sharing exception for computers that have **Windows Firewall** enabled. This exception opens TCP ports 139 and 445 and User Datagram Protocol \(UDP\) ports 137 and 138. If you have another host firewall installed, you have to allow network traffic through these ports.<br /><br />**Other troubleshooting resources**<br /><br />The WMI Diagnosis Utility can help system administrators diagnose and repair problems with the WMI service. To provide some in\-depth troubleshooting, download [WMI Diagnosis Utility](http://www.microsoft.com/download/details.aspx?id=7684).|  
  
### Issue number 2  
I get the message **UNC Path \\\\SERVERIP\\Share is not valid or does not have write permission** in the **Summary** page of the MVMC user interface \(UI\), and I am unable to click **Finish** to start the conversion.  
  
**Possible cause and solution for issue number 2**  
  
|Possible cause|Possible solution|  
|------------------|---------------------|  
|The virtual machine on which you are running the conversion and the destination Hyper\-V host are not members of the same Active Directory domain.|Ensure that the virtual machine on which you are running the conversion and the destination Hyper\-V host are members of the same Active Directory domain.|  
  
### Issue number 3  
I was able to successfully convert a virtual machine but when I logged on to the converted virtual machine and opened the Disk Management console, I noticed that one or more disks that were attached to the converted virtual machine were set to offline.  
  
**Possible cause and solutions for issue number 3**  
  
|Possible cause|Possible solutions|  
|------------------|----------------------|  
|The guest operating system that is installed on the converted virtual machine is Windows Server 2008 R2 Datacenter, Windows Server 2008 R2 Enterprise, Windows Server 2008 Datacenter, or Windows Server 2008 Enterprise, with one or more disks that are connected to the SCSI controller.<br /><br />This issue is due to a default policy setting on the guest operating system called VDS\_SP\_OFFLINE\_SHARED that sets these nonbootable disks to offline.<br /><br />For more details about the policy, see [article 971436](http://support.microsoft.com/kb/971436) in the Microsoft Knowledge Base.|**To bring the disks online by using Diskmgmt.msc**<br />1.  To open the Disk Management console, run **Diskmgmt.msc** at a command prompt or type it into the **Run** dialog box on the **Start** menu.<br />2.  Right\-click the disk that you want to bring online, and then click **Online** on the **Action** menu.<br /><br />**To bring the disk online by using DiskPart.exe**<br />1.  Run DiskPart.exe.<br />2.  Select the disk that has to be made available. Select **Disk <disk \#>**.<br />3.  If the disk is offline, bring it online by running **Online Disk**.<br />4.  View the attributes by running **Detail Disk**.|  
  
### Issue number 4  
I see warnings in Device Manager when I log on to the converted virtual machine.  
  
**Possible cause and solution for issue number 4**  
  
|Possible cause|Possible solution|  
|------------------|---------------------|  
|Drivers are missing or not installed correctly on the converted guest operating system.|Repair the installation of the integration services.<br /><br />**To repair the installation of the integration services**<br />1.  Insert the Integration Services Setup disk through the Hyper\-V console.<br />2.  Click **Repair** to repair the installation.<br />3.  Restart the guest operating system when you are prompted.|  
  
### Issue number 5  
I am unable to contact an online Linux virtual machine through the MVMC user interface \(UI\) or when I run the Convertto\-MvmcVirtualHardDiskOvf with the UninstallVMTools switch.  
  
**Possible cause and solution for issue number 5**  
  
|Possible cause|Possible solution|  
|------------------|---------------------|  
|SSH port 22 might not be enabled on the Linux source virtual machine.|**To verify that SSH port 22 is enabled**<br />1.  If connecting by host name does not work, try connecting by IP address.<br />2.  If WinSCP connects to the Linux source virtual machine by IP address, then there is a DNS name resolution issue that must be fixed before the conversion can proceed.<br />3.  If WinSCP cannot connect to the Linux source virtual machine by host name or IP address, check the firewall settings for that Linux distribution and ensure that port 22 is open.|  
  
### Issue number 6  
I am unable to see the list of virtual machines in the **Virtual Machines** page in the MVMC user interface \(UI\). MVMC displays the error message **Receiving response from VMware failed after multiple attempts. See inner exception.**  
  
**Possible cause and solution for issue number 6**  
  
|Possible cause|Possible solution|  
|------------------|---------------------|  
|This error might be due to a temporary connectivity issue with the VMware source server.|**To see the list of virtual machines**<br />1.  Wait a few minutes, and then refresh the virtual machine inventory in the MVMC GUI.<br />2.  Click **Previous**, go back to the **Source** page, and reconnect to the source host.<br />3.  Close the GUI, and then try running the GUI again.|  
  
### Issue number 7  
I am unable to connect to either a Windows or Linux virtual machine so that MVMC can uninstall VMware Tools as part of the conversion process. On the **Virtual Machine Connection** page, all of the controls are in a disabled state.  
  
**Possible causes and solutions for issue number 7**  
  
|Possible causes|Possible solutions|  
|-------------------|----------------------|  
|-   The Windows or Linux virtual machine is in an offline state.<br />-   The virtual machine does not have a valid domain name system \(DNS\) entry or fully qualified domain name \(FQDN\).|-   MVMC cannot connect to offline virtual machines and therefore does not uninstall VMware Tools if the virtual machine is offline. If you want VMware Tools to be automatically uninstalled as part of the conversion, ensure that the source virtual machine is in a running state.<br />-   Check or configure the DNS settings for the virtual machine.|  
  
### Issue number 8  
My progress indicator shows 80 percent completion in the Validate Conversion step and does not proceed beyond that.  
  
**Possible cause and solution for issue number 8**  
  
|Possible cause|Possible solution|  
|------------------|---------------------|  
|You might have an ISO file mounted from the network share on the source virtual machine.|Check the source virtual machine to determine if any user interaction is required. You should be able to continue with the conversion after you delete any pop\-up windows in the source virtual machine.|  
  
### Issue number 9  
My converted Linux virtual machine does not recognize the Ethernet network adapters.  
  
**Possible cause and solution for issue number 9**  
  
|Possible cause|Possible solution|  
|------------------|---------------------|  
|The Hyper\-V network adapter MAC address settings do not match those of the original VMware Linux virtual machine.|**To match the Hyper\-V network adapter MAC address settings to the original VMware Linux virtual machine**<br />1.  Turn off the converted Linux virtual machine.<br />2.  Update the Hyper\-V network adapter MAC address settings to match those of the original VMware Linux virtual machine.<br />3.  Turn on the converted Linux virtual machine.|  
  
## See Also  
[Microsoft Virtual Machine Converter 3.0](../Topic/Microsoft-Virtual-Machine-Converter-3.0.md)  
  
