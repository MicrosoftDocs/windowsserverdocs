---
title: Smart Cards Debugging Information
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b7e4c592-73a3-4e6e-a0ce-98b7bdb5bbba
---
# Smart Cards Debugging Information
This topic explains tools and services that smart card developers can use to help identify certificate issues with the smart card deployment.

Debugging and tracing smart card issues requires a variety of tools and approaches. The following sections provide guidance about tools and approaches you can use.

-   [List and delete certificates available on the smart card by using Certutil](#BKMK_Certutil)

-   [Debugging and tracing using WPP](#BKMK_WPP_TracingDebuggingAndTracing)

-   [Kerberos protocol, KDC and NTLM debugging and tracing](#BKMK_KerberosDebuggingAndTracing)

-   [Diagnosing the Smart Card Service](#BKMK_DmartCardService)

-   [Diagnosing the smart card reader](#BKMK_DmartCardReaders)

-   [CryptoAPI 2.0 Diagnostics](#BKMK_CrytoAPI20Diagnostics)

## <a name="BKMK_Certutil"></a>Certutil
For a complete description of Certutil including examples that show how to use it, see [Certutil \[W2012\]](Certutil.md).

### List certificates available on the smart card
To list certificates that are available on the smart card, type `certutil –scinfo`.

> [!NOTE]
> Entering a PIN is not required for this operation. You can press ESC if you are prompted for a PIN.

### Delete certificates on the smart card
Each certificate is enclosed in a container. When you delete a certificate on the smart card, you are deleting the container for the certificate.

To find the container value, type `certutil –scinfo`.

To delete a container, type `certutil –delkey –csp "Microsoft Base Smart Card Crypto Provider" "`*<ContainerValue>***"**.

## <a name="BKMK_WPP_TracingDebuggingAndTracing"></a>Debugging and tracing using WPP
Windows software trace preprocessor \(WPP\) simplifies tracing the operation of the trace provider, and it provides a mechanism for the trace provider to log real\-time binary messages. Logged messages can subsequently be converted to a human\-readable trace of the operation of the trace provider. For more information about WPP, see [Diagnostics with WPP \- The NDIS blog](http://blogs.msdn.com/b/ndis/archive/2011/04/06/diagnostics-with-wpp.aspx).

### Enable the trace
Using WPP, use one of the following commands to enable tracing:

-   **tracelog.exe –kd –rt –start** *<FriendlyName>* **\-guid \#***<GUID>* **\-f .\\***<LogFileName>***.etl –flags** *<flags>* **\-ft 1**

-   **logman start** *<FriendlyName>* **\-ets –p {***<GUID>***} \-***<Flags>* **\-ft 1 –rt –o .\\***<LogFileName>***.etl –mode 0x00080000**

You can use the parameters in the following table.

###

|Friendly name|GUID|Flags|
|-----------------|--------|---------|
|scardsvr|13038e47\-ffec\-425d\-bc69\-5707708075fe|0xffff|
|winscard|3fce7c5f\-fb3b\-4bce\-a9d8\-55cc0ce1cf01|0xffff|
|basecsp|133a980d\-035d\-4e2d\-b250\-94577ad8fced|0x7|
|scksp|133a980d\-035d\-4e2d\-b250\-94577ad8fced|0x7|
|msclmd|fb36caf4\-582b\-4604\-8841\-9263574c4f2c|0x7|
|credprov|dba0e0e0\-505a\-4ab6\-aa3f\-22f6f743b480|0xffff|
|certprop|30eae751\-411f\-414c\-988b\-a8bfa8913f49|0xffff|
|scfilter|eed7f3c9\-62ba\-400e\-a001\-658869df9a91|0xffff|
|wudfusbccid|a3c09ba3\-2f62\-4be5\-a50f\-8278a646ac9d|0xffff|

**Examples**

To enable tracing for the SCardSvr service:

-   tracelog.exe –kd –rt –start scardsvr –guid \#13038e47\-ffec\-425d\-bc69\-5707708075fe –f .\\scardsvr.etl –flags 0xffff –ft 1

-   logman start scardsvr –ets –p {13038e47\-ffec\-425d\-bc69\-5707708075fe} 0xffff –ft 1 –rt –o .\\scardsvr.etl –mode 0x00080000

To enable tracing for scfilter.sys:

tracelog.exe –kd –rt –start scfilter –guid \#eed7f3c9\-62ba\-400e\-a001\-658869df9a91 –f .\\scfilter.etl –flags 0xffff –ft 1

### Stop the trace
Using WPP, use one of the following commands to stop the tracing:

-   **tracelog.exe –stop** *<FriendlyName>*

-   **logman –stop** *<FriendlyName>* **\-ets**

**Examples**

To stop a trace:

-   tracelog.exe \-stop scardsvr

-   logman \-stop scardsvr \-ets

## <a name="BKMK_KerberosDebuggingAndTracing"></a>Kerberos protocol, KDC and NTLM debugging and tracing
You can use the following resources to begin troubleshooting these protocols and the KDC:

-   [Troubleshooting Kerberos Errors](http://go.microsoft.com/fwlink/?LinkId=93730)

-   [Troubleshooting Kerberos Delegation](http://go.microsoft.com/fwlink/?LinkId=93731)

-   [Windows Software Development Kit Update for Windows Vista](http://go.microsoft.com/fwlink/?LinkId=81029) You can use the trace log tool in this SDK to debug Kerberos authentication failures.

To begin tracing , you can use Tracelog. Different components use different control GUIDs as explained in the following examples. For more information, see [Tracelog](http://msdn.microsoft.com/library/windows/hardware/ff552994(v=vs.85).aspx).

### NTLM
To enable tracing for NTLM authentication, run the following at the command line:

tracelog.exe \-kd \-rt \-start ntlm \-guid \#5BBB6C18\-AA45\-49b1\-A15F\-085F7ED0AA90 \-f .\\ntlm.etl \-flags 0x15003 \-ft 1

To stop tracing for NTLM authentication, run the following at the command line:

tracelog \-stop ntlm

### Kerberos authentication
To enable tracing for Kerberos authentication, run the following at the command line:

tracelog.exe \-kd \-rt \-start kerb \-guid \#6B510852\-3583\-4e2d\-AFFE\-A67F9F223438 \-f .\\kerb.etl \-flags 0x43 \-ft 1

To stop tracing for Kerberos authentication, run the following at the command line:

tracelog.exe \-stop kerb

### KDC
To enable tracing for the Key Distribution Center \(KDC\), run the following at the command line:

tracelog.exe \-kd \-rt \-start kdc \-guid \#1BBA8B19\-7F31\-43c0\-9643\-6E911F79A06B \-f .\\kdc.etl \-flags 0x803 \-ft 1

To stop tracing for the KDC, run the following at the command line:

tracelog.exe \-stop kdc

To stop tracing from a remote computer, run the following at the command line:  logman.exe \-s  *<ComputerName>*.

> [!NOTE]
> The default location for logman.exe is %systemroot%system32\\. Use the **\-s** option to supply a computer name.

### Configure tracing with the registry
You can also configure tracing by editing the Kerberos registry values shown in the following table.

###

|Element|Registry Key Setting|
|-----------|------------------------|
|NTLM|HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Lsa\\MSV1\_0<br /><br />-   Value name: NtLmInfoLevel<br />-   Value type: DWORD<br />-   Value data: c0015003|
|Kerberos|HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Lsa\\Kerberos<br /><br />-   Value name: LogToFile<br />-   Value type: DWORD<br />-   Value data: 00000001<br /><br />HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Lsa\\Kerberos\\Parameters<br /><br />-   Value name: KerbDebugLevel<br />-   Value type: DWORD<br />-   Value data: c0000043<br /><br />HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Lsa\\Kerberos\\Parameters<br /><br />-   Value name: LogToFile<br />-   Value type: DWORD<br />-   Value data: 00000001|
|KDC|HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Kdc<br /><br />-   Value name: KdcDebugLevel<br />-   Value type: DWORD<br />-   Value data: c0000803|

If you used Tracelog, look for the following log file in your current directory: kerb.etl\/kdc.etl\/ntlm.etl.

Otherwise, if you used the registry key settings shown in the previous table, look for the generated trace log files in the following locations:

-   NTLM: %systemroot%\\tracing\\msv1\_0

-   Kerberos: %systemroot%\\tracing\\kerberos

-   KDC: %systemroot%\\tracing\\kdcsvc

To decode event trace files, you can use Tracefmt \(tracefmt.exe\). Tracefmt is a command\-line tool that formats and displays trace messages from an event trace log file \(.etl\) or a real\-time trace session. Tracefmt can display the messages in the Command Prompt window or save them in a text file. It is located in the \\tools\\tracing subdirectory of the Windows Driver Kit \(WDK\). For more information, see [Tracefmt](http://go.microsoft.com/fwlink/?LinkId=93734).

## <a name="BKMK_DmartCardService"></a>Smart Card service
The smart card resource manager service runs in the context of a local service, and it is implemented as a shared service of the services host \(svchost\) process.

#### To check if Smart Card service is running

1.  Press CTRL\+ALT\+DEL, and then click **Start Task Manager**.

2.  In the **Windows Task Manager** dialog box, click the **Services** tab.

3.  Click the **Name** column to sort the list alphabetically, and then type **s**.

4.  In the **Name** column, look for **SCardSvr**, and then look under the **Status** column to see if the service is running or stopped.

#### To restart Smart Card service

1.  Run as administrator at the command prompt.

2.  [!INCLUDE[uac_confirm_action](includes/uac_confirm_action_md.md)]

3.  At the command prompt, type **net stop SCardSvr**.

4.  At the command prompt, type **net start SCardSvr**.

You can use the following command at the command prompt to check whether the service is running: **sc queryex scardsvr**.

The following is example output from running this command:

```
SERVICE_NAME: scardsvr
    TYPE        : 20 WIN32_SHARE_PROCESS
    STATE       : 4 RUNNING
                (STOPPABLE, NOT_PAUSABLE, ACCEPTS_SHUTDOWN)
    WIN32_EXIT_CODE  : 0 (0x0)
    SERVICE_EXIT_CODE : 0 (0x0)
    CHECKPOINT     : 0x0
    WAIT_HINT     : 0x0
    PID        : 1320
    FLAGS       :
C:\>
```

## <a name="BKMK_DmartCardReaders"></a>Smart card readers
As with any device connected to a computer, Device Manager can be used to view properties and begin the debug process.

#### To check if smart card reader is working

1.  Navigate to **Computer**.

2.  Right\-click **Computer**, and then click **Properties**.

3.  Under **Tasks**, click **Device Manager**.

4.  In Device Manager, expand **Smart card readers**, select the name of the smart card reader you want to check, and then click **Properties**.

    > [!NOTE]
    > If the smart card reader is not listed in Device Manager, in the **Action** menu, click **Scan for hardware changes**.

## <a name="BKMK_CrytoAPI20Diagnostics"></a>CryptoAPI 2.0 Diagnostics
CryptoAPI 2.0 Diagnostics is a feature that is available in Windows operating systems that supports CryptoAPI 2.0. This feature can help you troubleshoot public key infrastructure \(PKI\) issues.

CryptoAPI 2.0 Diagnostics logs events in the Windows event log, which contain detailed information about certificate chain validation, certificate store operations, and signature verification. This information makes it easier to identify the causes of issues and reduces the time required for diagnosis.

For more information about CryptoAPI 2.0 Diagnostics, see [Troubleshooting PKI Problems on Windows Vista](http://go.microsoft.com/fwlink/?LinkId=89570) and [Troubleshooting an Enterprise PKI](http://technet.microsoft.com/library/cc771463.aspx).

## See also
[Windows Smart Card Technical Reference](assetId:///d2761e8c-5980-4077-a341-ab3cb5dec955)


