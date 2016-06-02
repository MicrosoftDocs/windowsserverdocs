---
title: Atmadm
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 37156c2e-c4d4-4fd8-a03d-245fb60bf996
author: jaimeo
---
# Atmadm
Monitors connections and addresses that are registered by the ATM Call Manager on an asynchronous transfer mode \(ATM\) network. You can use **atmadm** to display statistics for incoming and outgoing calls on ATM adapters. Used without parameters, **atmadm** displays statistics for monitoring the status of active ATM connections. For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).  
  
## Syntax  
  
```  
atmadm [/c][/a][/s]  
```  
  
### Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|\/c|Displays call information for all current connections to the ATM network adapter installed on this computer.|  
|\/a|Displays the registered ATM network service access point \(NSAP\) address for each adapter installed in this computer.|  
|\/s|Displays statistics for monitoring the status of active ATM connections.|  
|\/?|Displays Help at the command prompt.|  
  
## Remarks  
  
-   The **atmadm \/c** command produces output similar to the following:  
  
    ```  
  
    Windows ATM Call Manager Statistics  
  
    ATM Connections on Interface : [009] Olicom ATM PCI 155 Adapter  
  
       Connection   VPI/VCI   Remote Address/  
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
  
    The following table contains descriptions of each element in the **atmadm \/c** sample output.  
  
    |Type of Data|Screen Display|Description|  
    |----------------|------------------|---------------|  
    |Connection Information|In\/Out|Direction of the call.  **In** is to the ATM network adapter from another device.  **Out** is from the ATM network adapter to another device.|  
    ||PMP|Point\-to\-multipoint call.|  
    ||P\-P|Point\-to\-point call.|  
    ||SVC|Connection is on a switched virtual circuit.|  
    ||PVC|Connection is on a permanent virtual circuit.|  
    |VPI\/VCI Information|VPI\/VCI|Virtual path and virtual channel of the incoming or outgoing call.|  
    |Remote Address\/Media Parameters|47000580FFE1000000F21A2E180000C110081500|NSAP address of the calling **\(In\)** or called **\(Out\)** ATM device.|  
    ||**Tx**|The **Tx** parameter includes the following three elements:<br /><br />-   Default or specified bit\-rate type \(UBR, CBR, VBR, or ABR\)<br />-   Default or specified line speed<br />-   Specified service data unit \(SDU\) size|  
    ||**Rx**|The **Rx** parameter includes the following three elements:<br /><br />-   Default or specified bit\-rate type \(UBR, CBR, VBR, or ABR\)<br />-   Default or specified line speed<br />-   Specified SDU size|  
  
-   The **atmadm \/a** command produces output similar to the following:  
  
    ```  
  
    Windows ATM Call Manager Statistics  
  
    ATM Addresses for Interface : [009] Olicom ATM PCI 155 Adapter  
  
    47000580FFE1000000F21A2E180000C110081500  
  
    ```  
  
-   The **atmadm \/s** command produces output similar to the following:  
  
    ```  
  
    Windows ATM Call Manager Statistics  
  
    ATM Call Manager statistics for Interface : [009] Olicom ATM PCI 155 Adapter  
  
    Current Active calls                        = 4  
    Total successful Incoming calls             = 1332  
    Total successful Outgoing calls             = 1297  
    Unsuccessful Incoming calls                 = 1  
    Unsuccessful Outgoing calls                 = 1  
    Calls Closed by Remote                      = 1302  
    Calls Closed Locally                        = 1323  
    Signaling and ILMI Packets Sent            = 33655  
    Signaling and ILMI Packets Received        = 34989  
  
    ```  
  
    The following table contains descriptions of each element in the **atmadm \/s** sample output.  
  
    |Call Manager Statistic|Description|  
    |--------------------------|---------------|  
    |Current Active calls|Calls currently active on the ATM adapter installed on this computer.|  
    |Total successful Incoming calls|Calls successfully received from other devices on this ATM network.|  
    |Total successful Outgoing calls|Calls successfully completed to other ATM devices on this network from this computer.|  
    |Unsuccessful Incoming calls|Incoming calls that failed to connect to this computer.|  
    |Unsuccessful Outgoing calls|Outgoing calls that failed to connect to another device on the network.|  
    |Calls Closed by Remote|Calls closed by a remote device on the network.|  
    |Calls Closed Locally|Calls closed by this computer.|  
    |Signaling and ILMI Packets Sent|Number of integrated local management interface \(ILMI\) packets sent to the switch to which this computer is attempting to connect.|  
    |Signaling and ILMI Packets Received|Number of ILMI packets received from the ATM switch.|  
  
## <a name="BKMK_Examples"></a>Examples  
To display call information for all current connections to the ATM network adapter installed on this computer, type:  
  
```  
atmadm /c  
```  
  
To display the registered ATM network service access point \(NSAP\) address for each adapter installed in this computer, type:  
  
```  
atmadm /a  
```  
  
To display statistics for monitoring the status of active ATM connections, type:  
  
```  
atmadm /s  
```  
  
## Additional references  
  
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  

