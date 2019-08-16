---
title: Troubleshooting DirectAccess
description: This topic provides information about troubleshooting DirectAccess deployments in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-da
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 61040e19-5960-4eb0-b612-d710627988f7
ms.author: pashort
author: shortpatti
---
# Troubleshooting DirectAccess

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

Follow these steps to troubleshoot Remote Access (DirectAccess) issues.  
  
|||  
|-|-|  
|**Issue**|**Resolution**|  
|Remote Access management console is unable to show the DirectAccess configuration|**To restore missing configuration information**<br />-   If you are troubleshooting a multisite deployment, ensure that the domain controller closest to the entry point is available.<br />-   Use the **Get-DAEntrypointDC** cmdlet to retrieve the name of the domain controller closest to the entry point. If the domain controller is not running, use the **Set-DAEntryPointDC** cmdlet to point to another domain controller.<br />-   Run **gpresult** from an elevated command prompt on the server to ensure the server is getting the DirectAccess Group Policy Objects.<br />-   Enable user interface (UI) logging.<br />-   Use the following command to start Windows PowerShell logging:<pre>logman create trace ETWTrace -ow -o c:\ETWTrace.etl -p {AAD4C46D-56DE-4F98-BDA2-B5EAEBDD2B04} 0xffffffffffffffff 0xff -nb 16 16 -bs 1024 -mode 0x2 -max 2048 -ets <br />logman update trace ETWTrace -p {62DFF3DA-7513-4FCA-BC73-25B111FBB1DB} 0xffffffffffffffff 0xff -ets</pre><repro>-   Close and reopen the user interface.<br />-   Disable Windows Powershell logging. Collect the Event Trace Log files. Also, collect all the logs from the **%windir%/tracing** folder.|  
|Applying the DirectAccess configuration fails|**To refresh the DirectAccess configuration**<br />-   If you are troubleshooting a multisite deployment, ensure that the domain controller closest to the entry point is available.<br />-   Use the **Get-DAEntrypointDC** cmdlet to retrieve the name of the domain controller closest to the entry point. If the domain controller is not running, use the **Set-DAEntryPointDC** cmdlet to point to another domain controller.<br />-   Use the following command to start Windows Powershell logging:<br /><pre>logman create trace ETWTrace -ow -o c:\ETWTrace.etl -p {AAD4C46D-56DE-4F98-BDA2-B5EAEBDD2B04} 0xffffffffffffffff 0xff -nb 16 16 -bs 1024 -mode 0x2 -max 2048 -ets<br />logman update trace ETWTrace -p {62DFF3DA-7513-4FCA-BC73-25B111FBB1DB} 0xffffffffffffffff 0xff -ets</pre>    <repro><br />-   Click **Apply**.<br />-   After the failure occurs, disable Windows Powershell logging, and collect the Event Trace Log.|  
|DirectAccess is configured, but clients are not able to connect to internal resources|**To troubleshoot client connection issues**<br />-   Click the **Operations Status** tab in the Remote Access Management console, and ensure that all the components show a green icon. If not, check the error details and follow the resolution steps.<br />-   Run the Remote Access Server Best Practices Analyzer (BPA). If there are any warnings or errors, follow the resolution steps to resolve the issue.|  
|Encountering issues related to a multisite configuration (for example, enabling a multisite, adding entry points, or setting the domain controller for an entry point)|Follow the steps in [Troubleshoot a Multisite Deployment](https://technet.microsoft.com/library/jj554657(v=ws.11).aspx).|  
|Configuration status tile on the dashboard shows a warning or error|Follow the steps in [Monitor the configuration distribution status of the Remote Access server](https://technet.microsoft.com/library/jj574221(v=ws.11).aspx).|  
|Encountering issues related to configuring load balancing (for example, the configuration fails when you enable load balancing, or there are issues when you add or remove servers from a cluster)|If you were enabling load balancing  or adding a node, and the configuration refreshed when you clicked **Apply**, but the cluster didn't form correctly on the server, run the following command: **cmd.exe /c "reg add HKLM\SYSTEM\CurrentControlSet\Services\RaMgmtSvc\Parameters /f /v DebugFlag /t REG_DWORD /d ""0xffffffff"" "** to collect the user interface logs on the new server.|  
|Operations status shows an error or warning after following steps to correct the situation|If the operations status is showing incorrect information (such as errors-even after you fix them):<br /><br />-   Enable the registry key **cmd.exe /c "reg add HKLM\SYSTEM\CurrentControlSet\Services\RaMgmtSvc\Parameters /f /v EnableTracing /t REG_DWORD /d ""5"" "**.<br />-   Refresh the operations status and collect the logs from **%windir%/tracing**.|  
|Windows 8 and later DirectAccess client computers report "No Internet" as status for the DirectAccess connection, and Network Connectivity Status Indicator (NCSI) reports limited connectivity.|This can occur when Force Tunneling is enabled in the DirectAccess configuration and, because of this, only IPHTTPS is being used. To resolve this issue, you can create and configure a proxy server. NCSI then uses the proxy server to perform Internet connectivity checks. It is recommended that you add a static proxy to the Name Resolution Policy Table (NRPT) by using the following procedure.<br /><br />Before you run the commands in this procedure, ensure that you replace all domain names, computer names, and other Windows PowerShell command variables with values that are appropriate for your deployment.<br /><br />**Configure a static proxy for an NRPT rule**<br />1.  Display the "." NRPT rule: `Get-DnsClientNrptRule -GpoName "corp.example.com\DirectAccess Client Settings" -Server <DomainControllerNetBIOSName>`<br />2.  Note the name (GUID) of the "." NRPT rule. The name (GUID) should start with **DA-{..}**<br />3.  Set the proxy for the "." NRPT rule to **proxy.corp.example.com:8080**:  `Set-DnsClientNrptRule -Name "DA-{..}" -Server <DomainControllerNetBIOSName> -GPOName "corp.example.com\DirectAccess Client Settings" -DAProxyServerName "proxy.corp.example.com:8080" -DAProxyType "UseProxyName"`<br />4.  Display the "." NRPT rule again by running `Get-DnsClientNrptRule`, and verify that **ProxyFQDN:port** is now correctly configured.<br />5.  Refresh Group Policy by running `gpupdate /force` on a DirectAccess client when the client is connected internally, then display the NRPT using `Get-DnsClientNrptPolicy` and verify that the "." rule shows **ProxyFQDN:port**.|  
  


