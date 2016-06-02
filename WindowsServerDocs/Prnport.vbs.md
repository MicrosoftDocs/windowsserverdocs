---
title: Prnport.vbs
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6a0ec638-a21e-4a34-be5c-bd0f7ca89ffe
author: jpjofre
---
# Prnport.vbs
Creates, deletes, and lists standard TCP\/IP printer ports, in addition to displaying and changing port configuration.  
  
For examples of how this command can be used, see [Examples](#BKMK_examples).  
  
## Syntax  
  
```  
Cscript prnport {-a | -d | -l | -g | -t | -?} [-r <PortName>]   
[-s <ServerName>] [-u <UserName>] [-w <Password>] [-o {raw | lpr}]   
[-h <HostAddress>] [-q <QueueName>] [-n <PortNumber>] -m{e | d}   
[-i <SNMPIndex>] [-y <CommunityName>] -2{e | -d}  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|\-a|Creates a standard TCP\/IP printer port.|  
|\-d|Deletes a standard TCP\/IP printer port.|  
|\-l|Lists all standard TCP\/IP printer ports on the computer specified with the **\-s** parameter.|  
|\-g|Displays the configuration of a standard TCP\/IP printer port.|  
|\-t|Configures the port settings for a standard TCP\/IP printer port.|  
|\-r <PortName>|Specifies the port to which the printer is connected.|  
|\-s <ServerName>|Specifies the name of the remote computer that hosts the printer that you want to manage. If you do not specify a computer, the local computer is used.|  
|\-u <UserName> \-w <Password>|Specifies an account with permissions to connect to the computer that hosts the printer that you want to manage. All members of the target computer's local Administrators group have these permissions, but the permissions can also be granted to other users. If you do not specify an account, you must be logged on under an account with these permissions for the command to work.|  
|\-o {raw &#124; lpr}|Specifies which protocol the port uses: TCP raw or TCP LPR. If you use TCP raw, you can optionally specify the port number by using the **\-n** parameter. The default port number is 9100.|  
|\-h <HostAddress>|Specifies \(by IP address\) the printer for which you want to configure the port.|  
|\-q <QueueName>|Specifies the queue name for a TCP raw port.|  
|\-n <PortNumber>|Specifies the port number for a TCP raw port. The default port number is 9100.|  
|\-m{e &#124; d}|Specifies whether SNMP is enabled. The parameter **e** enables SNMP. The parameter **d** disables SNMP.|  
|\-i <SNMPIndex|Specifies the SNMP index, if SNMP is enabled. For more information, see RFC 1759 at the RFC Editor Web site \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=569\).|  
|\-y <CommunityName>|Specifies the SNMP community name, if SNMP is enabled.|  
|\-2{e &#124; \-d}|Specifies whether double spools \(also known as respooling\) are enabled for TCP LPR ports. Double spools are necessary because TCP LPR must include an accurate byte count in the control file that is sent to the printer, but the protocol cannot get the count from the local print provider. Therefore, when a file is spooled to a TCP LPR print queue, it is also spooled as a temporary file in the system32 directory. TCP LPR determines the size of the temporary file and sends the size to the server running LPD. The parameter **e** enables double spools. The parameter **d** disables double spools.|  
|\/?|Displays help at the command prompt.|  
  
## Remarks  
  
-   The **Prnport.vbs** command is a Visual Basic script located in the %WINDIR%\\System32\\Printing\_Admin\_Scripts\\<language> directory. To use this command, at a command prompt, type **Cscript** followed by the full path to the Prnport.vbs file, or change directories to the appropriate folder. For example:  
  
    ```  
    Cscript %WINDIR%\System32\Printing_Admin_Scripts\en-US\Prnport.vbs  
    ```  
  
-   If the information that you supply contains spaces, use quotation marks around the text \(for example, `"Computer Name"`\).  
  
-   The TCP raw protocol is a higher performance protocol on Windows than the LPR protocol.  
  
## <a name="BKMK_examples"></a>Examples  
To display all standard TCP\/IP printing ports on the server \\\\Server1, type:  
  
```  
Cscript Prnport.vbs -l -s Server1  
```  
  
To delete the standard TCP\/IP printing port on the server \\\\Server1 that connects to a network printer at 10.2.3.4, type:  
  
```  
Cscript Prnport.vbs -d -s Server1 -r IP_10.2.3.4  
```  
  
To add a standard TCP\/IP printing port on the server \\\\Server1 that connects to a network printer at 10.2.3.4 and uses the TCP raw protocol on port 9100, type:  
  
```  
Cscript Prnport.vbs -a -s Server1 -r IP_10.2.3.4 -h 10.2.3.4 -o raw -n 9100  
```  
  
To enable SNMP, specify the "public" community name and set the SNMP index to 1 on a network printer at 10.2.3.4 shared by the server \\\\Server1, type:  
  
```  
Cscript Prnport.vbs -t -s Server1 -r IP_10.2.3.4 -me -y public -i 1 -n 9100  
```  
  
To add a standard TCP\/IP printing port on the local computer that connects to a network printer at 10.2.3.4 and automatically get the device settings from the printer, type:  
  
```  
Cscript Prnport.vbs -a -r IP_10.2.3.4 -h 10.2.3.4  
```  
  
#### Additional references  
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  
[Print Command Reference](Print-Command-Reference.md)  
  

