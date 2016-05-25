---
title: Procedure: Enable DNS Diagnostic Events
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a7b8bef3-e258-46b9-8f7b-3a44de93a488
author: vhorne
---
# Procedure: Enable DNS Diagnostic Events
DNS server debug logging is enabled by default with individual diagnostic events disabled. You can use the procedures in this topic to enable diagnostic event logging and change other event log parameters.  
  
> [!TIP]  
> By default, the DNS debug log is located in the **%windir%\\system32\\dns** directory.  
  
## In this section  
  
-   [To view event logging status](../Topic/Procedure--Enable-DNS-Diagnostic-Events.md#eeee)  
  
-   [To enable diagnostic events in the event log](../Topic/Procedure--Enable-DNS-Diagnostic-Events.md#rrrrr)  
  
-   [To enable debug log rollover](../Topic/Procedure--Enable-DNS-Diagnostic-Events.md#ggggg)  
  
## <a name="windows_ui"></a>View and modify the event logging status  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### <a name="eeee"></a>To view event logging status  
  
1.  Open an elevated Windows PowerShell prompt on a DNS server.  
  
2.  Use the **Get\-DnsServerDiagnostics** cmdlet to view the status of individual diagnostic events. See the following example.  
  
    ```  
    PS C:\> Get-DnsServerDiagnostics  
  
    SaveLogsToPersistentStorage          : False  
    Queries                              : False  
    Answers                              : False  
    Notifications                        : False  
    Update                               : False  
    QuestionTransactions                 : False  
    UnmatchedResponse                    : False  
    SendPackets                          : False  
    ReceivePackets                       : False  
    TcpPackets                           : False  
    UdpPackets                           : False  
    FullPackets                          : False  
    FilterIPAddressList                  :  
    EventLogLevel                        : 4  
    UseSystemEventLog                    : False  
    EnableLoggingToFile                  : True  
    EnableLogFileRollover                : False  
    LogFilePath                          :  
    MaxMBFileSize                        : 500000000  
    WriteThrough                         : False  
    EnableLoggingForLocalLookupEvent     : False  
    EnableLoggingForPluginDllEvent       : False  
    EnableLoggingForRecursiveLookupEvent : False  
    EnableLoggingForRemoteServerEvent    : False  
    EnableLoggingForServerStartStopEvent : False  
    EnableLoggingForTombstoneEvent       : False  
    EnableLoggingForZoneDataWriteEvent   : False  
    EnableLoggingForZoneLoadingEvent     : False  
    ```  
  
### <a name="rrrrr"></a>To enable diagnostic events in the event log  
  
1.  Open an elevated Windows PowerShell prompt on the DNS server where you wish to enable event logging.  
  
2.  Use the **Set\-DnsServerDiagnostics** cmdlet to enable individual diagnostic events, or you can enable all diagnostic events at once. See the following example.  
  
    ```  
    PS C:\> Set-DnsServerDiagnostics -All $true  
    ```  
  
    The previous command will set the status of all diagnostic events to **True**. You can verify this status with the **Get\-DnsServerDiagnostics** cmdlet. See the following example.  
  
    ```  
    PS C:\> Get-DnsServerDiagnostics  
  
    SaveLogsToPersistentStorage          : True  
    Queries                              : True  
    Answers                              : True  
    Notifications                        : True  
    Update                               : True  
    QuestionTransactions                 : True  
    UnmatchedResponse                    : True  
    SendPackets                          : True  
    ReceivePackets                       : True  
    TcpPackets                           : True  
    UdpPackets                           : True  
    FullPackets                          : True  
    FilterIPAddressList                  :  
    EventLogLevel                        : 7  
    UseSystemEventLog                    : False  
    EnableLoggingToFile                  : True  
    EnableLogFileRollover                : True  
    LogFilePath                          :  
    MaxMBFileSize                        : 500000000  
    WriteThrough                         : True  
    EnableLoggingForLocalLookupEvent     : True  
    EnableLoggingForPluginDllEvent       : True  
    EnableLoggingForRecursiveLookupEvent : True  
    EnableLoggingForRemoteServerEvent    : True  
    EnableLoggingForServerStartStopEvent : True  
    EnableLoggingForTombstoneEvent       : True  
    EnableLoggingForZoneDataWriteEvent   : True  
    EnableLoggingForZoneLoadingEvent     : True  
  
    ```  
  
3.  You can also enable only selected diagnostic events. See the following example.  
  
    ```  
    PS C:\> Set-DnsServerDiagnostics -Queries $true -Answers $true -Notifications $true -SendPackets $true -ReceivePackets $true -TcpPackets $true -UdpPackets $true  
    PS C:\> Get-DnsServerDiagnostics  
  
    SaveLogsToPersistentStorage          : False  
    Queries                              : True  
    Answers                              : True  
    Notifications                        : True  
    Update                               : False  
    QuestionTransactions                 : False  
    UnmatchedResponse                    : False  
    SendPackets                          : True  
    ReceivePackets                       : True  
    TcpPackets                           : True  
    UdpPackets                           : True  
    FullPackets                          : False  
    FilterIPAddressList                  :  
    EventLogLevel                        : 0  
    UseSystemEventLog                    : False  
    EnableLoggingToFile                  : False  
    EnableLogFileRollover                : False  
    LogFilePath                          :  
    MaxMBFileSize                        : 500000000  
    WriteThrough                         : False  
    EnableLoggingForLocalLookupEvent     : False  
    EnableLoggingForPluginDllEvent       : False  
    EnableLoggingForRecursiveLookupEvent : False  
    EnableLoggingForRemoteServerEvent    : False  
    EnableLoggingForServerStartStopEvent : False  
    EnableLoggingForTombstoneEvent       : False  
    EnableLoggingForZoneDataWriteEvent   : False  
    EnableLoggingForZoneLoadingEvent     : False  
    ```  
  
### <a name="ggggg"></a>To enable debug log rollover  
  
1.  Open an elevated Windows PowerShell prompt on the DNS server where you wish to enable event logging.  
  
2.  Use the **Set\-DnsServerDiagnostics** cmdlet to enable debug log rollover. See the following example.  
  
    ```  
    PS C:\> Set-DnsServerDiagnostics - EnableLogFileRollover $true  
    ```  
  
## See also  
[DNSSEC in Windows](../Topic/DNSSEC-in-Windows.md)  
  
[DNSSEC Deployment Planning](../Topic/DNSSEC-Deployment-Planning.md)  
  
