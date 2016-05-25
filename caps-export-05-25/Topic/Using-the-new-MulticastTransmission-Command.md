---
title: Using the new-MulticastTransmission Command
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c1f1dc46-dd50-4eb9-9f72-cf0e5d71bd3d
---
# Using the new-MulticastTransmission Command
Creates a new multicast transmission for an image. This command is equivalent to creating a transmission by using the Windows Deployment Services MMC snap\-in \(right\-click the **Multicast Transmissions** node, and then click **Create Multicast Transmission**\). You should use this command when you have both the Deployment Server role service and the Transport Server role service installed \(which is the default installation\). If you have only the Transport Server role service installed, use [Using the new-Namespace Command](../Topic/Using-the-new-Namespace-Command.md).  
  
## Syntax  
For install images transmissions:  
  
```  
WDSUTIL [Options] /New-MulticastTransmission /Image:<Image name>  
        [/Server:<Server name>]  
        /FriendlyName:<Friendly name>  
        [/Description:<Description>]  
        /TransmissionType: {AutoCast | ScheduledCast}  
            [/Time:<YYYY/MM/DD:hh:mm>]  
            [/Clients:<Num of Clients>]  
        /ImageType:Install  
        [/ImageGroup:<Image Group>]  
        [/Filename:<File name>]  
```  
  
For boot image transmissions \(only supported for Windows Server 2008 R2\):  
  
```  
WDSUTIL [Options] /New-MulticastTransmission /Image:<Image name>  
        [/Server:<Server name>]  
        /FriendlyName:<Friendly name>  
        [/Description:<Description>]  
        /TransmissionType: {AutoCast | ScheduledCast}  
            [/Time:<YYYY/MM/DD:hh:mm>]  
            [/Clients:<Num of Clients>]  
        /ImageType:Boot  
        /Architecture:{x86 | ia64 | x64}  
        [/Filename:<File name>]  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|\/Image:<Image name>|Specifies the name of the image to be transmitted using multicasting.|  
|\[\/Server:<Server name>\]|Specifies the name of the server. This can be the NetBIOS name or the fully qualified domain name \(FQDN\). If no server name is specified, the local server will be used.|  
|\/FriendlyName:<Friendly name>|Specifies the friendly name of the transmission.|  
|\[\/Description:<Description>\]|Specifies the description of the transmission.|  
|\/ImageType:{Boot&#124;Install}|Specifies the type of image to be transmitted using multicasting. Note **Boot** is only supported for Windows Server 2008 R2.|  
|\[\/ImageGroup:<Image group name>\]|Specifies the image group that contains the image. If no image group name is specified and only one image group exists on the server, that image group is used. If more than one image group exists on the server, you must use this option to specify the image group name.|  
|\[\/Filename:<File name>\]|Specifies the file name. If the source image cannot be uniquely identified by name, you must use this option to specify the file name.|  
|\/TransmissionType:{AutoCast &#124; ScheduledCast}|Specifies whether to start the transmission automatically \(AutoCast\) or based on the specified start criteria \(ScheduledCast\).<br /><br /><ul><li>**Auto\-Cast**. This transmission type indicates that as soon as an applicable client requests an install image, a multicast transmission of the selected image begins. As other clients request the same image, they are joined to the transmission that is already started.</li><li>**Scheduled\-Cast**. This transmission type sets the start criteria for the transmission based on the number of clients that are requesting an image and\/or a specific day and time. You can specify the following options:<br /><br /><ul><li>\[\/Time: <time>\] \- Sets the time that the transmission should start by using the following format: YYYY\/MM\/DD:hh:mm.</li><li>\[\/Clients: <Number of clients>\] \- Sets the minimum number of clients to wait for before the transmission starts.</li></ul></li></ul>|  
|\/Architecture:{x86 &#124; ia64 &#124; x64}|Specifies the architecture of the boot image to transmit using multicasting. Because it is possible to have the same name for boot images of different architectures, you should specify the architecture to ensure the correct image is used.|  
|\[\/Filename:<File name>\]|Specifies the file name. If the source image cannot be uniquely identified by name, you must specify the file name.|  
  
## <a name="BKMK_examples"></a>Examples  
To create an Auto\-Cast transmission of a boot image in Windows Server 2008 R2, type:  
  
```  
WDSUTIL /New-MulticastTransmission /FriendlyName:"WDS Boot Transmission"  
/Image:"X64 Boot Image" /ImageType:Boot /Architecture:x64 /TransmissionType:AutoCast  
  
```  
  
To create an Auto\-Cast transmission of an install image, type:  
  
```  
WDSUTIL /New-MulticastTransmission /FriendlyName:"WDS AutoCast Transmission"  
/Image:"Vista with Office" /ImageType:Install /TransmissionType:AutoCast  
```  
  
To create a Scheduled\-Cast transmission of an install image, type:  
  
```  
WDSUTIL /New-MulticastTransmission /FriendlyName:"WDS SchedCast Transmission" /Server:MyWDSServer /Image:"Vista with Office" /ImageType:Install   
/TransmissionType:ScheduledCast /Time:"2006/11/20:17:00" /Clients:100  
```  
  
#### Additional references  
[Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
[Using the get-AllMulticastTransmissions Command](../Topic/Using-the-get-AllMulticastTransmissions-Command.md)  
  
[Using the get-MulticastTransmission Command](../Topic/Using-the-get-MulticastTransmission-Command.md)  
  
[Using the remove-MulticastTransmission Command](../Topic/Using-the-remove-MulticastTransmission-Command.md)  
  
[Subcommand: start-MulticastTransmission](../Topic/Subcommand--start-MulticastTransmission.md)  
  
