---
title: verifier
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 782173d6-f196-4bc4-a547-76109829453c

author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# verifier

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Driver verifier manager.  

## Syntax  
```  
verifier /standard /driver <name> [<name> ...]  
verifier /standard /all  
verifier [/flags <flags>] [/faults [<probability> [<tags> [<applications> [<minutes>]]]] /driver <name> [<name>...]  
verifier [/flags FLAGS] [/faults [<probability> [<tags> [<applications> [<minutes>]]]] /all  
verifier /querysettings  
verifier /volatile /flags <flags>  
verifier /volatile /adddriver <name> [<name>...]  
verifier /volatile /removedriver <name> [<name>...]  
verifier /volatile /faults [<probability> [<tags> [<applications>]]  
verifier /reset  
verifier /query  
verifier /log <LogFileName> [/interval <seconds>]  
```  
### Parameters  
|Parameter|Description|  
|-------|--------|  
|\<flags>|Must be a number in decimal or hexadecimal, combination of bits:<br /><br />-   **Value: description**<br />-   **bit 0:** special pool checking<br />-   **bit 1:** force irql checking<br />-   **bit 2:** low resources simulation<br />-   **bit 3:** pool tracking<br />-   **bit 4:** I/O verification<br />-   **bit 5:** deadlock detection<br />-   **bit 6:** unused<br />-   **bit 7:** DMA verification<br />-   **bit 8:** security checks<br />-   **bit 9:** force pending I/O requests<br />-   **bit 10:** IRP logging<br />-   **bit 11:** miscellaneous checks<br /><br />for example, **/flags 27** is equivalent with **/flags 0x1B**|  
|/volatile|Used to change the verifier settings dynamically without restarting the system. Any new settings will be lost when the system is restarted.|  
|\<probability>|Number between 1 and 10,000 specifying the fault injection probability. For example, specifying 100 means a fault injection probability of 1% (100/10,000).<br /><br />if this parameter is not specified then the default probability of 6% will be used.|  
|\<tags>|Specifies the pool tags that will be injected with faults, separated by space characters. If this parameter is not specified then any pool allocation can be injected with faults.|  
|\<applications>|Specifies the image file name of the applications that will be injected with faults, separated by space characters. If this parameter is not specified then low resources simulation can take place in any application.|  
|\<minutes>|A positive number specifying the length of the period after rebooting, in minutes, during which no fault injection will occur. If this parameter is not specified then the default length of 8 minutes will be used.|  
|/?|Displays help at the command prompt.|  

## Additional references  
-   [Command-Line Syntax Key](command-line-syntax-key.md)  