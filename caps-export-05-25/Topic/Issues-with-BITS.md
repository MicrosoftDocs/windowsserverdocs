---
title: Issues with BITS
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fb9d7cd2-0227-418b-a7a7-6a638211efd9
author: britw
---
# Issues with BITS
Background Intelligent Transfer Service \(BITS\) is the service that is used by WSUS to download updates from Microsoft Update to the main WSUS server, and from WSUS servers to their client computers. BITS also supports the transfer of files between peer computers in a domain.  
  
Some download issues may be caused by running BITS on the server or client computers. When you are troubleshooting download problems, after you have verified that all WSUS settings are correct on the server and its client computers, you should ensure that BITS is running properly on all affected computers.  
  
BITS provides a downloadable tool called **bitsadmin** that allows you to verify and change BITS settings. For more information about the **bitsadmin** utility, see [BITSAdmin Tool](http://go.microsoft.com/fwlink/?LinkId=80934).  
  
## Finding BITS  
To find the BITS service, open a Command Prompt window and type:  
  
```  
sc query bits   
```  
  
If BITS is running, you should see output like the following:  
  
```  
SERVICE_NAME: bits  
TYPE               : 20  WIN32_SHARE_PROCESS  
 STATE              : 4  RUNNING  
                         (STOPPABLE,NOT_PAUSABLE,ACCEPTS_SHUTDOWN)  
 WIN32_EXIT_CODE    : 0  (0x0)  
 SERVICE_EXIT_CODE  : 0  (0x0)  
 CHECKPOINT         : 0x0  
 WAIT_HINT          : 0x0  
```  
  
If BITS is not running, you should see output like the following:  
  
```  
SERVICE_NAME: bits  
 TYPE               : 20  WIN32_SHARE_PROCESS  
 STATE              : 1  STOPPED  
                         (NOT_STOPPABLE,NOT_PAUSABLE,IGNORES_SHUTDOWN)  
 WIN32_EXIT_CODE    : 0  (0x0)  
 SERVICE_EXIT_CODE  : 0  (0x0)  
 CHECKPOINT         : 0x0  
 WAIT_HINT          : 0x0  
```  
  
## Stopping and restarting BITS  
Often it is possible to resolve BITS issues simply by stopping the service and restarting it. The following procedure shows how to stop and restart the service from a Command Prompt window.  
  
> [!NOTE]  
> To modify, stop, or restart BITS, log on as a local administrator.  
  
#### To stop and restart BITS  
  
1.  Open a Command Prompt window.  
  
2.  Type **sc stop bits**.  
  
3.  Type **sc start bits**.  
  
## Troubleshooting BITS download issues  
The following sections are an incomplete list of possible problems with BITS configuration. For more information, see [Background Intelligent Transfer Service](http://go.microsoft.com/fwlink/?LinkID=210761) in MSDN.  
  
#### The BITS service must run under the local system user account  
By default BITS runs under the **LocalSystem** account.  
  
###### To configure the service to run under the correct account  
  
1.  Open a Command Prompt window, and type:   
    `sc config bits obj= LocalSystem`  
  
    Note that a space must occur between `obj=` and `LocalSystem`.  
  
2.  Verify that output from the command is:  
  
    \[SC\] ChangeServiceConfig SUCCESS  
  
3.  Stop and restart BITS.  
  
#### Proxy servers must support HTTP 1.1 range requests  
  
-   BITS supports HTTP and HTTPS downloads and uploads, and it requires that the server support the HTTP 1.1 protocol. For downloads, the HTTP server's HEAD method property must return the file size, and its GET method property must support the Content\-Range and Content\-Length headers. BITS can use an HTTP 1.0 server as long as it meets the HEAD and GET method property requirements \(MIME headers must include the standard Content\-Range and Content\-Type headers plus a maximum of 180 bytes of other headers, and a maximum of two CR\/LF characters may occur between the HTTP headers and the first boundary string\).  
  
#### There is a mismatch between the BITS per\-user job limit and the per\-computer job limit  
  
###### To detect or correct a mismatch between thejob limits specified through Group Policy  
  
1.  Run gpedit.msc, if the policy is specified locally. If the policy is a domain policy, edit the Group Policy object with GPMC.  
  
2.  In the Group Policy Object Editor, navigate to Computer Configuration\\Administrative Templates\\Network\\Background Intelligent Transfer Service \(BITS\).  
  
3.  Ensure that the setting "Maximum number of BITS jobs for each user" is set to a lower value than the setting "Maximum number of BITS jobs for this computer."  
  
4.  Type **gpupdate \/force**.  
  
5.  Stop and restart BITS.  
  
6.  Verify that there are no errors in the event logs.  
  
#### BITS jobs are failing  
If BITS jobs fail, look in the event log to find errors. You can use the following table to diagnose the cause of the errors.  
  
|**Error name**|**Error code**|**Description**|  
|------------------|------------------|-------------------|  
|E\_INVALIDARG|0x80070057|An incorrect proxy server name was specified in the user’s Internet Explorer proxy settings. This error is also seen when credentials are supplied for authentication schemes that are not NTLM\/Negotiate, but the user name or password is null. Change the user’s Internet Explorer settings to a valid proxy server or change the credentials so that they are not NULL for user name and password for schemes other than NTLM\/Negotiate.|  
|ERROR\_WINHTTP\_NAME\_NOT\_RESOLVED|0x80072ee7|The proxy server could not be resolved by BITS. Internet Explorer on the same computer in the context of the job owner would see the same problem. Try downloading the same file through the web browser by using the context of the job owner.|  
|ERROR\_HTTP\_INVALID\_SERVER\_RESPONSE|0x80072f78|This is a transient error and the job will continue downloading.|  
|BG\_E\_INSUFFICIENT\_RANGE\_SUPPORT|0x80200013|BITS uses range headers in HTTP requests to request parts of a file. If the server or proxy server does not understand range requests and returns the full file instead of the requested range, BITS puts the job into the ERROR state with this error code. Capture the network traffic during the error and examine if HTTP GET requests with the Range header are getting valid responses. Check proxy servers to ensure that they are configured correctly to support range requests.|  
|BG\_E\_MISSING\_FILE\_SIZE|0x80200011|When BITS sends a HEAD request and the proxy server does not return Content\-Length header in the response, BITS puts the job in ERROR state with this error code. Check the proxy server and WSUS server to ensure that they are configured correctly. Some versions of the Apache 2.0 proxy server are known to exhibit this behavior.|  
|BG\_E\_HTTP\_ERROR\_403|0x80190193|When the server returns an HTTP 403 response in any of the requests, BITS puts the job in ERROR state with this error code. HTTP 403 corresponds to “Forbidden: Access is denied." Check access permissions for the account that is running the job.|  
|ERROR\_NOT\_LOGGED\_ON|0x800704dd|The SENS service is not receiving user logon notifications. BITS \(at least version 2.0\) depends on logon notifications from Service Control Manager, which in turn depends on the SENS service. Ensure that the SENS service is started and running correctly.|  
  
#### BITS fails to start  
If the BITS service fails to start, use the following table to diagnose the cause of the error.  
  
||||  
|-|-|-|  
|ERROR\_SERVICE\_DOES\_NOT\_EXIST|0x80070424|See  [Repairing a corrupted BITS configuration](../Topic/Issues-with-BITS.md#BKMK_RepairCorrupt)|  
|ERROR\_SERVICE\_NOT\_IN\_EXE|0x8007043B|BITS is not listed as one of the services in the **netsvcs svchost** group.|  
|ERROR\_SERVICE\_DISABLED|0x80070422|BITS has been disabled. Enable the BITS service.|  
|ERROR\_SERVICE\_DEPENDENCY\_DELETED ERROR\_SERVICE\_DEPENDENCY\_FAIL|0x80070433, 0x8007042c|A service that appears in the BITS service dependency list cannot be started. Make sure the dependency list for the BITS service is correct as follows:<br /><br />-   Windows 7:<br />-   [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)]: RpcSs, EventSystem \(also http.sys and LanManWorkstation when peer caching is enabled\)<br />-   Windows Server 2003: Rpcss, EventSystem<br />-   Windows XP: Rpcss|  
|ERROR\_PATH\_NOT\_FOUND|0x80070003|Prior to Windows Vista: %ALLUSERSPROFILE%\\Microsoft\\Network doesn’t exist|  
|ERROR\_FILE\_NOT\_FOUND|0x80070002|The **Parameters** key is missing. Ensure that the following keys and values exist: HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\BITS\\Parameters\\ServiceDll\= %SystemRoot%\\System32\\qmgr.dll|  
  
#### <a name="BKMK_RepairCorrupt"></a>Repairing a corrupted BITS configuration  
To repair corrupted BITS service configuration, you can enter the BITS service configuration manually.  
  
> [!IMPORTANT]  
> This action should only be taken in circumstances where all other troubleshooting attempts have failed. You must be an administrator to modify the BITS configuration.  
  
###### To repair a corrupted BITS configuration  
  
1.  Open a Command Prompt window, and type:  
  
    ```  
    Sc config bits binpath=”%systemroot%\system32\svchost.exe –k netsvcs“ Sc config bits depend = RpcSs EventSystem  
    ```  
  
    ```  
    Sc config bits start=delayed-auto  
    ```  
  
    ```  
    Sc config bits type=interact  
    ```  
  
    ```  
    Sc config bits error=normal  
    ```  
  
    ```  
    Sc config bits obj=LocalSystem  
    ```  
  
    ```  
    Sc privs bits privileges=SeCreateGlobalPrivilege/SeImpersonatePrivilege/SeTcbPrivilege/SeAssignPrimaryTokenPrivilege/SeIncreateQuotaPrivilege  
    ```  
  
    ```  
    Sc sidtype bits type= unrestricted  
    ```  
  
    ```  
    Sc failure bits reset= 86400 actions=restart/60000/restart/120000  
    ```  
  
2.  Stop and restart BITS.  
  
