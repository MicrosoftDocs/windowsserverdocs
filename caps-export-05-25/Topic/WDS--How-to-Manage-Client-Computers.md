---
title: WDS: How to Manage Client Computers
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ac91604f-229f-45ad-ac8e-e23e899369bf
---
# WDS: How to Manage Client Computers
This topic contains procedures for the tasks that are listed and described in the following table.  
  
> [!NOTE]  
> Help for WDSUTIL is available by typing **WDSUTIL \/?** at a command prompt or online at [http:\/\/go.microsoft.com\/fwlink\/?LinkId\=112194](http://go.microsoft.com/fwlink/?LinkId=112194).  
  
|Type|Procedure|  
|--------|-------------|  
|[Prestage Computers](#BKMK_1)|-   To prestage a client computer<br />-   To prestage a client computer to boot from a different server<br />-   To prestage a client computer to use a network boot program other than the default<br />-   To prestage a client computer to use an unattend file other than the default for the Windows PE phase of unattended setup<br />-   To prestage a client computer to use a boot image other than the default<br />-   To prestage a client computer to join a domain<br />-   To view the attributes of a prestaged client|  
|[Configure the Auto\-Add Policy](#BKMK_3)|-   To enable the Auto\-Add policy<br />-   To change the length of time approved computers are held in the Auto\-Add database<br />-   To change the length of time rejected and pending computers are held in the Auto\-Add database<br />-   To delete the rejected or approved computers table|  
|[Specify Settings for Pending Computers](#BKMK_2)|-   To change the rate at which pending computers will poll the server<br />-   To change the number of times pending computers will poll the server<br />-   To change the message displayed to pending computers<br />-   To set a default server for pending computers to boot from<br />-   To set a default network boot program for pending computers<br />-   To set a default unattend file for pending computers<br />-   To set a default boot image for pending computers<br />-   To set domain join options for pending computers|  
|[Approve and Reject Pending Computers](#BKMK_4)|-   To view the table of computers that are pending approval<br />-   To approve a pending computer by using the default settings<br />-   To approve all pending computers by using the default settings<br />-   To approve a pending computer, but change a setting<br />-   To approve all pending computers, but change a setting<br />-   To reject a pending computer|  
  
## <a name="BKMK_1"></a>Prestage Computers  
  
### To prestage a client computer  
  
|Using the Active Directory Users and Computers snap\-in|Using WDSUTIL|  
|-----------------------------------------------------------|-----------------|  
|<ol><li>On the server running Active Directory Users and Computers, open the Active Directory Users and Computers MMC snap\-in \(click **Start**, click **Run**, type **dsa.msc**, and then click **OK**\). **Note:**     To manage the server remotely, you can install “AD DS Snap\-Ins and Command\-Line Tools” in the Remote Server Administration Tools. To do this, click **Add Features** in Server Manager, and install the feature from the following location: `Remote Server Administration Tools>Remote Administration Tools>AD DS and AD LDS Tools>AD DS Tools>AD DS Snap-Ins and Command-line Tools`.</li><li>In the console tree, right\-click the organizational unit that will contain the new client computer.</li><li>Click **New**, and then click **Computer**.</li><li>Type the client computer name, click **Next**, and then click **This is a managed computer**.</li><li>In the text box, type the client computer's MAC address preceded with twenty zeros or the globally unique identifier \(GUID\) in the format: {*XXXXXXXX\-XXXX\-XXXX\-XXX\-XXXXXXXXXXXX*}.</li><li>Click **Next**, and click one of the following options to specify which server or servers will support this client computer:<br /><br /><ul><li>**Any available remote installation server**</li><li>**The following remote installation server**</li></ul></li><li>Click **Next**, and then click **Finish**.</li></ol>|1.  Click **Start**, right\-click **Command Prompt**, and click **Run as administrator**.<br />2.  Run `WDSUTIL /Add-Device /Device:<name> /ID:<GUIDorMACAddress>` where `<GUIDorMACAddress>` is the identifier of the new computer. If you use a MAC address, you must precede it with twenty zeros \(0\).<br />    For example: **WDSUTIL \/Add\-Device \/Device:Computer1**<br />    **\/ID:{E8A3EFAC\-201F\-4E69\-953F\-B2DAA1E8B1B6}**<br />    **\/ReferralServer:WDSServer1 \/BootProgram:boot\\x86\\pxeboot.com \/WDSClientUnattend:WDSClientUnattend\\unattend.xml**<br />    **\/User:Domain\\MyUser \/JoinRights:Full \/BootImagePath:boot\\x86\\images\\boot.wim \/OU:"OU\=MyOU,CN\=Test,DC\=Domain,DC\=com"**|  
  
### To prestage a client computer to boot from a different server  
  
|Using the MMC|Using WDSUTIL|  
|-----------------|-----------------|  
|N\/A|1.  Click **Start**, right\-click **Command Prompt**, and click **Run as administrator**.<br />2.  Run `WDSUTIL /Set-Device /Device:<name> /ReferralServer:<ServerName>`.|  
  
### To prestage a client computer to use a network boot program other than the default  
  
|Using the MMC|Using WDSUTIL|  
|-----------------|-----------------|  
|N\/A|1.  Click **Start**, right\-click **Command Prompt**, and click **Run as administrator**.<br />2.  Run `WDSUTIL /Set-Device /Device:<name> /BootProgram:<path>`, where `<path>` is the relative path to the boot program you want from the RemoteInstall folder.|  
  
### To prestage a client computer to use an unattend file other than the default for the Windows PE phase of unattended setup  
  
|Using the MMC|Using WDSUTIL|  
|-----------------|-----------------|  
|N\/A|1.  Click **Start**, right\-click **Command Prompt**, and click **Run as administrator**.<br />2.  Run `WDSUTIL /Set-Device /Device:<name> /WDSClientUnattend:<path>`, where the path is relative to the unattend file you want from the RemoteInstall folder.|  
  
### To prestage a client computer to use a boot image other than the default  
  
|Using the MMC|Using WDSUTIL|  
|-----------------|-----------------|  
|N\/A|1.  Click **Start**, right\-click **Command Prompt**, and click **Run as administrator**.<br />2.  Run `WDSUTIL /Set-Device /Device:<name> /BootImagePath:<path>`, where `<path>` is the relative path to the boot image you want from the RemoteInstall folder.|  
  
### To prestage a client computer to join a domain  
  
|Using the MMC|Using WDSUTIL|  
|-----------------|-----------------|  
|N\/A|<ol><li>Click **Start**, right\-click **Command Prompt**, and click **Run as administrator**.</li><li>Do one of the following:<br /><br /><ul><li>To enable the specified user to join the client computer to the specified domain once, run `WDSUTIL /Set-Device /Device:<name> /User:<user> /JoinRights:JoinOnly /JoinDomain:Yes /Domain:<domain> /ResetAccount`, where:<br /><br />        `<user>` is domain\\user or user@domain<br /><br />        `<name>` is the name of the computer<br /><br />        `<domain>` is the name of the domain</li><li>To enable the specified user to join the client computer to the specified domain at any time, run `WDSUTIL /Set-Device /Device:<name> /User:<user> /JoinRights:Full /JoinDomain:Yes /Domain:<domain>`.</li><li>To join the client computer to the specified domain without granting any user rights, run `WDSUTIL /Set-Device /Device:<name> /JoinDomain:Yes /Domain:<domain>`.</li></ul></li></ol>|  
  
### To view the attributes of a prestaged client  
  
|Using the MMC|Using WDSUTIL|  
|-----------------|-----------------|  
|N\/A|<ol><li>Click **Start**, right\-click **Command Prompt**, and click **Run as administrator**.</li><li>Do one of the following:<br /><br /><ul><li>To view the prestaged client by name in the local domain, run `WDSUTIL /Get-Device /Device:<name>`.</li><li>To view a prestaged client by ID \(GUID or MAC\) in the local domain, run `WDSUTIL /Get-Device /ID:<ID>`. **Note:**         To specify that the client is in a domain other than the local one, specify `/Domain:<domain>` with either of these commands. **Note:**         To search the entire AD DS forest, specify `/Forest:Yes` with either of these commands.</li></ul></li></ol>|  
  
## <a name="BKMK_3"></a>Configure the Auto\-Add Policy  
For more information about the Auto\-Add policy, see Enabling the Auto\-Add Policy at [Prestaging Client Computers](https://technet.microsoft.com/en-us/library/cc770832(v=ws.10).aspx)  
  
### To enable the Auto\-Add policy  
  
|Using the MMC|Using WDSUTIL|  
|-----------------|-----------------|  
|1.  Right\-click the server, and then click **Properties**.<br />2.  On the **PXE Response settings** tab, click **Respond to all \(known and unknown\) client computers**.<br />3.  Select the check box **For unknown clients, notify administrator and respond after approval**.|1.  Click **Start**, right\-click **Command Prompt**, and click **Run as administrator**.<br />2.  Run `WDSUTIL /Set-Server /AutoAddPolicy /Policy:AdminApproval`.|  
  
### To change the length of time approved computers are held in the Auto\-Add database  
  
|Using the MMC|Using WDSUTIL|  
|-----------------|-----------------|  
|N\/A|1.  Click **Start**, right\-click **Command Prompt**, and click **Run as administrator**.<br />2.  Run `WDSUTIL /Set-Server /AutoAddPolicy /RetentionPeriod /Approved:<time in days>`.|  
  
### To change the length of time rejected and pending computers are held in the Auto\-Add database  
  
|Using the MMC|Using WDSUTIL|  
|-----------------|-----------------|  
|N\/A|1.  Click **Start**, right\-click **Command Prompt**, and click **Run as administrator**.<br />2.  Run `WDSUTIL /Set-Server /AutoAddPolicy /RetentionPeriod /Others:<time in days>`.|  
  
### To delete the approved or rejected computers table  
  
|Using the MMC|Using WDSUTIL|  
|-----------------|-----------------|  
|N\/A|1.  Click **Start**, right\-click **Command Prompt**, and click **Run as administrator**.<br />2.  Run `WDSUTIL /Delete-AutoAddDevices /DeviceType:<ApprovedDevices&#124;RejectedDevices>`.|  
  
## <a name="BKMK_2"></a>Specify Settings for Pending Computers  
  
### To change the rate at which pending computers will poll the server  
  
|Using the MMC|Using WDSUTIL|  
|-----------------|-----------------|  
|N\/A|1.  Click **Start**, right\-click **Command Prompt**, and click **Run as administrator**.<br />2.  To set the time between polls, run `WDSUTIL /Set-Server /AutoAddPolicy /PollInterval:<time in seconds>`.|  
  
### To change the number of times pending computers will poll the server  
  
|Using the MMC|Using WDSUTIL|  
|-----------------|-----------------|  
|N\/A|1.  Click **Start**, right\-click **Command Prompt**, and click **Run as administrator**.<br />2.  Run `WDSUTIL /Set-Server /AutoAddPolicy /MaxRetry:<retries>`.|  
  
### To change the message displayed to pending computers  
  
|Using the MMC|Using WDSUTIL|  
|-----------------|-----------------|  
|N\/A|1.  Click **Start**, right\-click **Command Prompt**, and click **Run as administrator**.<br />2.  Run `WDSUTIL /Set-Server /AutoAddPolicy /Message:<message>`.|  
  
### To set a default server for pending computers to boot from  
  
|Using the MMC|Using WDSUTIL|  
|-----------------|-----------------|  
|N\/A|1.  Click **Start**, right\-click **Command Prompt**, and click **Run as administrator**.<br />2.  Run `WDSUTIL /Set-Server /AutoAddSettings /Architecture:{x86&#124;x64&#124;ia64} /ReferralServer:<server name>`.|  
  
### To set a default network boot program for pending computers  
  
|Using the MMC|Using WDSUTIL|  
|-----------------|-----------------|  
|N\/A|1.  Click **Start**, right\-click **Command Prompt**, and click **Run as administrator**.<br />2.  Run `WDSUTIL /Set-Server /AutoAddSettings /Architecture:{x86&#124;x64&#124;ia64} /BootProgram:<path>`, where the `<path>` is relative to the RemoteInstall folder.|  
  
### To set a default unattend file for pending computers  
  
|Using the MMC|Using WDSUTIL|  
|-----------------|-----------------|  
|N\/A|1.  Click **Start**, right\-click **Command Prompt**, and click **Run as administrator**.<br />2.  Run `WDSUTIL /Set-Server /AutoAddSettings /Architecture:{x86&#124;x64&#124;ia64} /WDSClientUnattend:<path>`, where the path is relative to the RemoteInstall folder.|  
  
### To set a default boot image for pending computers  
  
|Using the MMC|Using WDSUTIL|  
|-----------------|-----------------|  
|N\/A|1.  Click **Start**, right\-click **Command Prompt**, and click **Run as administrator**.<br />2.  Run `WDSUTIL /Set-Server /AutoAddSettings /Architecture:{x86&#124;x64&#124;ia64} /BootImage:<path>`, where `<path>` is relative to the RemoteInstall folder.|  
  
### To set domain join options for pending computers  
  
|Using the MMC|Using WDSUTIL|  
|-----------------|-----------------|  
|N\/A|<ol><li>Click **Start**, right\-click **Command Prompt**, and click **Run as administrator**.</li><li>Do one of the following:<br /><br /><ul><li>To enable the specified user \(specified as domain\\user or user@domain\) to join the client computer to the specified domain once, run `WDSUTIL /Set-Server /AutoAddSettings Architecture:{x86&#124;x64&#124;ia64} /User:<user> /JoinRights:JoinOnly /JoinDomain:Yes /Domain:<domain>`.</li><li>To enable the specified user to join the client computer to the specified domain at any time, run `WDSUTIL /Set-Server /AutoAddSettings Architecture:{x86&#124;x64&#124;ia64} /User:<user> /JoinRights:Full /JoinDomain:Yes /Domain:<domain>`.</li></ul></li></ol>|  
  
## <a name="BKMK_4"></a>Approve and Reject Pending Computers  
  
### To view the list of computers that are pending approval  
  
|Using the MMC|Using WDSUTIL|  
|-----------------|-----------------|  
|1.  Expand the server node.<br />2.  Select the **Pending Devices** node.|1.  Click **Start**, right\-click **Command Prompt**, and click **Run as administrator**.<br />2.  Run `WDSUTIL /Get-AutoAddDevices /DeviceType:PendingDevices`.|  
  
### To approve a pending computer by using the default settings  
  
|Using the MMC|Using WDSUTIL|  
|-----------------|-----------------|  
|1.  Select the **Pending Devices** node.<br />2.  Right\-click the computer you want to approve, and then click **Approve.**|1.  Click **Start**, right\-click **Command Prompt**, and click **Run as administrator**.<br />2.  Run `WDSUTIL /Approve-AutoAddDevices /RequestID:<ID>` with the ID obtained from the Auto\-Add database.|  
  
### To approve all pending computers by using the default settings  
  
|Using the MMC|Using WDSUTIL|  
|-----------------|-----------------|  
|1.  Right\-click the **Pending Devices** node.<br />2.  Click **Approve All**.|1.  Click **Start**, right\-click **Command Prompt**, and click **Run as administrator**.<br />2.  Run `WDSUTIL /Approve-AutoAddDevices /RequestID:All`.|  
  
### To approve a pending computer, but change a setting  
  
|Using the MMC \(name change only\)|Using WDSUTIL|  
|--------------------------------------|-----------------|  
|1.  Select the **Pending Devices** node.<br />2.  Select the computer you want to approve.<br />3.  On the **Action** menu, click **Name and Approve**.<br />4.  In the dialog box, type the name you want to give the computer.|1.  Click **Start**, right\-click **Command Prompt**, and click **Run as administrator**.<br />2.  Run `WDSUTIL /Approve-AutoAddDevices  /RequestID:<ID>` with the ID obtained from the Auto\-Add database<br /><br />In addition, you can append this command with the following options:<br /><br />-   To change the name, specify `/MachineName:<name>`<br />-   To change the organizational unit \(OU\) where the account will be created, specify `/OU:<name of OU>`.<br />-   To change the user account for the domain join, specify `/User:<name>` where the name is domain\\user or user@domain.<br />-   To enable the user to join this computer to the domain only once, specify `/JoinRights:JoinOnly`.<br />-   To enable the user to join this computer to the domain at any time, specify `/JoinRights:Full`.<br />-   To join this computer to the domain, specify `/JoinDomain:Yes`.<br />-   To direct the computer to install from a different Windows Deployment Services server, specify `/ReferralServer:<server name>`.<br />-   To change the network boot program used, specify `/BootProgram:<path>`.<br />-   To change the unattend file used for the Microsoft Windows Preinstallation Environment \(Windows PE\) phase of unattended setup, specify `/WDSClientUnattend:<path>`.<br />-   To change the boot image used, specify `/BootImagePath:<path>`.|  
  
### To approve all pending computers, but change a setting  
  
|Using the MMC|Using WDSUTIL|  
|-----------------|-----------------|  
|N\/A|1.  Click **Start**, right\-click **Command Prompt**, and click **Run as administrator**.<br />2.  Run `WDSUTIL /Approve-AutoAddDevices /RequestID:All`<br /><br />In addition, you can append this command with the following options:<br /><br />-   To change the OU where the accounts will be created, specify `/OU:<name of OU>`.<br />-   To change the user account used for domain join, specify `/User:<name>` where the name is domain\\user or user@domain.<br />-   To allow the user to join these computers to the domain once only, specify `/JoinRights:JoinOnly`.<br />-   To allow the user to join these computers to the domain at any time, specify `/JoinRights:Full`.<br />-   To join these computers to the domain, specify `/JoinDomain:Yes`.<br />-   To direct the computers to install from a different Windows Deployment Services server, specify `/ReferralServer:<server name>`.<br />-   To change the network boot program used, specify `/BootProgram:<path>`.<br />-   To change the unattend file used for the Windows PE phase of unattended setup, specify `/WDSClientUnattend:<path>`.<br />-   To change the boot image used, specify `/BootImagePath:<path>`.|  
  
### To reject a pending computer  
  
|Using the MMC|Using WDSUTIL|  
|-----------------|-----------------|  
|1.  Select the **Pending Devices** node.<br />2.  Right\-click the computer, and then click **Reject** or **Reject All**.|<ol><li>Click **Start**, right\-click **Command Prompt**, and click **Run as administrator**.</li><li>Do one of the following:<br /><br /><ul><li>To reject a single computer, run `WDSUTIL /Reject-AutoAddDevices /RequestID:<ID>` with the ID obtained from the Auto\-Add database.</li><li>To reject all computers, run `WDSUTIL /Reject-AutoAddDevices /RequestID:All`.</li></ul></li></ol>|  
  
