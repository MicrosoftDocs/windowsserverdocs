---
title: Appendix B: Command-Line Syntax for the Gpfixup Tool
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 114b5607-139f-45fb-be2e-287d2c1746b6
author: Femila
---
# Appendix B: Command-Line Syntax for the Gpfixup Tool
  You can use the gpfixup command\-line tool to fix the dependencies that Group Policy objects \(GPOs\) and Group Policy links in Active Directory Domain Services \(AD DS\) have on Domain Name System \(DNS\) and NetBIOS names after a domain rename operation.  
  
 **Syntax**  
  
```  
gpfixup [/?] [/v] [/dc:DCNAME]  
[/user:USERNAME] [/pwd:{PASSWORD|*}]  
[/olddns:OLDDNSNAME] [/newdns:NEWDNSNAME]  
[/oldnb:OLDFLATNAME] [/newnb:NEWFLATNAME]  
[/sionly]  
```  
  
|Parameter|Description|  
|---------------|-----------------|  
|\/?|Optional. Displays the Help syntax and the version number of the tool.|  
|\/v|Optional. Requests that detailed status messages be displayed. In the absence of this switch, only error messages or a brief summary status message of **SUCCESS** or **FAILURE** appears.|  
|\/olddns:OLDDNSNAME|Optional. When the domain rename operation changes the DNS name of a domain, this switch specifies the old DNS name of the renamed domain as **OLDDNSNAME**, \(for example, olddom.contoso.com. You can use this switch if and only if you also use the **\/newdns** switch to provide a new domain DNS name.|  
|\/newdns:NEWDNSNAME|Optional. When the domain rename operation changes the DNS name of a domain, this switch specifies the new DNS name of the renamed domain as **NEWDNSNAME**, for example, newdom.contoso.com. You can use this switch to specify the new domain DNS name if and only if you use the **\/olddns** switch to provide the old domain DNS name.|  
|\/oldnb:OLDFLATNAME|Optional. When the domain rename operation changes the NetBIOS name of a domain, this switch specifies the old NetBIOS name of the renamed domain as **OLDFLATNAME**, for example, olddom. You can use this switch if and only if you use the **\/newnb** switch to provide a new domain NetBIOS name.|  
|\/newnb:NEWFLATNAME|Optional. When the domain rename operation changes the NetBIOS name of a domain, this switch specifies the new NetBIOS name of the renamed domain as NEWFLATNAME, for example, newdom. You can use this switch to specify the new NetBIOS name of the domain if and only if you use the **\/oldnb** switch to provide the old NetBIOS name of the domain.|  
|\/sionly|Optional. Requests that only the Group Policy fix that relates to managed software installation \(that is, the SI extension for Group Policy\) be performed. Skips the actions that fix up the Group Policy links and the SYSVOL paths in the GPOs.|  
|\/dc:DCNAME|Optional. Requests that the command connect to a specific domain controller, indicated by **DCNAME** \(a DNS name or a NetBIOS name\), to run the fix\-up operation. If **DCNAME** is specified, it must host a writable replica of the domain directory partition, as indicated by either of the following:<br /><br /> The DNS name **NEWDNSNAME**, using **\/newdns**<br /><br /> The NetBIOS name **NEWFLATNAME**, using **\/newnb**<br /><br /> Default: When this switch is not specified, connects to any domain controller in the renamed domain, as indicated by either **NEWDNSNAME** or **NEWFLATNAME**. You can use the function **DsGetDcName\(\)** to obtain a proper domain controller for the given domain.|  
|\/user:USERNAME|Optional. Requests that the command run in the security context of a specific user, indicated by **USERNAME**, that is different from the logged on user. **USERNAME** can currently be specified in only one form: *domain*\\*user*, for example, **ntdev\\jdow**.|  
|\/pwd:{PASSWORD &#124; \*}|Optional. Specifies the password for the alternate security context that is indicated by **USERNAME**. If the value that is specified for this switch is **\***, the command prompts for the password to allow hiding of the password.|  
  
  