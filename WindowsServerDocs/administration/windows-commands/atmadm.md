---
title: atmadm
description: "Windows Commands topic for **atmadm** - Monitors connections and addresses that are registered by the atM call Manager on an asynchronous transfer mode (atM) network."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 37156c2e-c4d4-4fd8-a03d-245fb60bf996
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# atmadm

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Monitors connections and addresses that are registered by the atM call Manager on an asynchronous transfer mode (atM) network. You can use **atmadm** to display statistics for incoming and outgoing calls on atM adapters. Used without parameters, **atmadm** displays statistics for monitoring the status of active atM connections. 

## Syntax

```
atmadm [/c][/a][/s]
```

### Parameters

|Parameter|Description|
|-------|--------|
|/c|Displays call information for all current connections to the atM network adapter installed on this computer.|
|/a|Displays the registered atM network service access point (NSAP) address for each adapter installed in this computer.|
|/s|Displays statistics for monitoring the status of active atM connections.|
|/?|Displays help at the command prompt.|

## Remarks

- The **atmadm /c** command produces output similar to the following:

    ```
    Windows atM call Manager Statistics
    atM Connections on Interface : [009] Olicom atM PCI 155 Adapter
       Connection   VPI/VCI   remote address/
                              Media Parameters (rates in bytes/sec)
       In  PMP SVC    0/193   47000580FFE1000000F21A2E180020481A2E180B
                              Tx:UBR,Peak 0,Avg 0,MaxSdu 1516
                              Rx:UBR,Peak 16953936,Avg 16953936,MaxSdu 1516
       Out P-P SVC    0/192   47000580FFE1000000F21A2E180020481A2E180B
                              Tx:UBR,Peak 16953936,Avg 16953936,MaxSdu 1516
                              Rx:UBR,Peak 16953936,Avg 16953936,MaxSdu 1516
       In  PMP SVC    0/191   47000580FFE1000000F21A2E180020481A2E180B
                              Tx:UBR,Peak 0,Avg 0,MaxSdu 1516
                              Rx:UBR,Peak 16953936,Avg 16953936,MaxSdu 1516
       Out P-P SVC    0/190   47000580FFE1000000F21A2E180020481A2E180B
                              Tx:UBR,Peak 16953936,Avg 16953936,MaxSdu 1516
                              Rx:UBR,Peak 16953936,Avg 16953936,MaxSdu 1516
       In  P-P SVC    0/475   47000580FFE1000000F21A2E180000C110081501
                              Tx:UBR,Peak 16953984,Avg 16953984,MaxSdu 9188
                              Rx:UBR,Peak 16953936,Avg 16953936,MaxSdu 9188
       Out PMP SVC    0/194   47000580FFE1000000F21A2E180000C110081501 (0)
                              Tx:UBR,Peak 16953984,Avg 16953984,MaxSdu 9180
                              Rx:UBR,Peak 0,Avg 0,MaxSdu 0
       Out P-P SVC    0/474   4700918100000000613E5BFE010000C110081500
                              Tx:UBR,Peak 16953984,Avg 16953984,MaxSdu 9188
                              Rx:UBR,Peak 16953984,Avg 16953984,MaxSdu 9188
       In  PMP SVC    0/195   47000580FFE1000000F21A2E180000C110081500
                              Tx:UBR,Peak 0,Avg 0,MaxSdu 0
                              Rx:UBR,Peak 16953936,Avg 16953936,MaxSdu 9180
    ```
    
    The following table contains descriptions of each element in the **atmadm /c** sample output.
    
    |type of Data|Screen Display|Description|
    |--------|---------|--------|
    |Connection Information|In/Out|direction of the call.  **In** is to the atM network adapter from another device.  **Out** is from the atM network adapter to another device.|
    ||PMP|Point-to-multipoint call.|
    ||P-P|Point-to-point call.|
    ||SVC|Connection is on a switched virtual circuit.|
    ||PVC|Connection is on a permanent virtual circuit.|
    |VPI/VCI Information|VPI/VCI|Virtual path and virtual channel of the incoming or outgoing call.|
    |remote address/Media Parameters|47000580FFE1000000F21A2E180000C110081500|NSAP address of the calling **(In)** or called **(Out)** atM device.|
    ||**Tx**|The **Tx** parameter includes the following three elements:<br /><br />-   Default or specified bit-rate type (UBR, CBR, VBR, or ABR)<br />-   Default or specified line speed<br />-   Specified service data unit (SDU) size|
    ||**Rx**|The **Rx** parameter includes the following three elements:<br /><br />-   Default or specified bit-rate type (UBR, CBR, VBR, or ABR)<br />-   Default or specified line speed<br />-   Specified SDU size|
    
- The **atmadm /a** command produces output similar to the following:

    ```
    Windows atM call Manager Statistics
    atM addresses for Interface : [009] Olicom atM PCI 155 Adapter
    47000580FFE1000000F21A2E180000C110081500
    ```
    
- The **atmadm /s** command produces output similar to the following:

    ```
    Windows atM call Manager Statistics
    atM call Manager statistics for Interface : [009] Olicom atM PCI 155 Adapter
    Current active calls                        = 4
    Total successful Incoming calls             = 1332
    Total successful Outgoing calls             = 1297
    Unsuccessful Incoming calls                 = 1
    Unsuccessful Outgoing calls                 = 1
    calls Closed by remote                      = 1302
    calls Closed Locally                        = 1323
    Signaling and ILMI Packets Sent            = 33655
    Signaling and ILMI Packets Received        = 34989
    ```
    
    The following table contains descriptions of each element in the **atmadm /s** sample output.
    
    |call Manager Statistic|Description|
    |-------------|--------|
    |Current active calls|calls currently active on the atM adapter installed on this computer.|
    |Total successful Incoming calls|calls successfully received from other devices on this atM network.|
    |Total successful Outgoing calls|calls successfully completed to other atM devices on this network from this computer.|
    |Unsuccessful Incoming calls|Incoming calls that failed to connect to this computer.|
    |Unsuccessful Outgoing calls|Outgoing calls that failed to connect to another device on the network.|
    |calls Closed by remote|calls closed by a remote device on the network.|
    |calls Closed Locally|calls closed by this computer.|
    |Signaling and ILMI Packets Sent|Number of integrated local management interface (ILMI) packets sent to the switch to which this computer is attempting to connect.|
    |Signaling and ILMI Packets Received|Number of ILMI packets received from the atM switch.|
    
## <a name="BKMK_Examples"></a>Examples

To display call information for all current connections to the atM network adapter installed on this computer, type:

```
atmadm /c
```

To display the registered atM network service access point (NSAP) address for each adapter installed in this computer, type:

```
atmadm /a
```

To display statistics for monitoring the status of active atM connections, type:

```
atmadm /s
```

## Additional references

- [Command-Line Syntax Key](command-line-syntax-key.md)
