---
title: Pubprn.vbs
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0bc7f7e3-84e1-4359-b477-7b1a1a0bd639
author: jpjofre
---
# Pubprn.vbs
Publishes a printer to the Active Directory Domain Services.  
  
For examples of how this command can be used, see [Examples](#BKMK_examples).  
  
## Syntax  
  
```  
Cscript Pubprn.vbs {<ServerName> | <UNCPrinterPath>}   
"LDAP://CN=<Container>,DC=<Container>"  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|<ServerName>|Specifies the name of the Windows server that hosts the printer that you want to publish. If you do not specify a computer, the local computer is used.|  
|<UNCPrinterPath>|The Universal Naming Convention \(UNC\) path to the shared printer that you want to publish.|  
|"LDAP:\/\/CN\=<Container>,DC\=<Container>"|Specifies the path to the container in Active Directory Domain Services where you want to publish the printer.|  
|\/?|Displays help at the command prompt.|  
  
## Remarks  
  
-   The **Pubprn.vbs** command is a Visual Basic script located in the %WINDIR%\\System32\\Printing\_Admin\_Scripts\\<language> directory. To use this command, at a command prompt, type **Cscript** followed by the full path to the Pubprn.vbs file, or change directories to the appropriate folder. For example:  
  
    ```  
    Cscript %WINDIR%\System32\Printing_Admin_Scripts\en-US\Pubprn.vbs  
    ```  
  
-   If the information that you supply contains spaces, use quotation marks around the text \(for example, `"Computer Name"`\).  
  
## <a name="BKMK_examples"></a>Examples  
To publish all printers on the \\\\Server1 computer to the MyContainer container in the MyDomain.Company.Com domain, type:  
  
```  
Cscript Ppubprn.vbs Server1 "LDAP://CN=MyContainer,DC=MyDomain,DC=Company,DC=Com"  
```  
  
To publish the LaserPrinter1 printer on the \\\\Server1 server to the MyContainer container in the MyDomain.Company.Com domain, type:  
  
```  
Cscript Ppubprn.vbs \\Server1\LaserPrinter1 "LDAP://CN=MyContainer,DC=MyDomain,DC=Company,DC=Com"  
```  
  
#### Additional references  
[Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
[Print Command Reference](../Topic/Print-Command-Reference.md)  
  
