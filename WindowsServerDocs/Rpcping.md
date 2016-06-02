---
title: Rpcping
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7382aa0d-90fc-47c0-84b3-15f52dd656d0
author: jaimeo
---
# Rpcping
Confirms the RPC connectivity between the computer running Microsoft Exchange Server and any of the supported Microsoft Exchange Client workstations on the network. This utility can be used to check if the Microsoft Exchange Server services are responding to RPC requests from the client workstations via the network. For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).  
  
## Syntax  
  
```  
rpcping [/t <protseq>] [/s <server_addr>] [/e <endpoint>  
        |/f <interface UUID>[,MajorVer]] [/O <Interface Object UUID]  
        [/i <#_iterations>] [/u <security_package_id>] [/a <authn_level>]  
        [/N <server_princ_name>] [/I <auth_identity>] [/C <capabilities>]  
        [/T <identity_tracking>] [/M <impersonation_type>]  
        [/S <server_sid>] [/P <proxy_auth_identity>] [/F <RPCHTTP_flags>]  
        [/H <RPC/HTTP_authn_schemes>] [/o <binding_options>]  
        [/B <server_certificate_subject>] [/b] [/E] [/q] [/c]  
        [/A <http_proxy_auth_identity>] [/U <HTTP_proxy_authn_schemes>]  
        [/r <report_results_interval>] [/v <verbose_level>] [/d]  
```  
  
### Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|\/t <protseq>|Specifies the protocol sequence to use. Can be one of the standard RPC protocol sequences, for example: ncacn\_ip\_tcp, ncacn\_np, or ncacn\_http.<br /><br />If not specified, default is ncacn\_ip\_tcp.|  
|\/s <server\_addr>|Specifies the server address. If not specified, the local machine will be pinged.|  
|\/e <endpoint>|Specifies the endpoint to ping. If none is specified, the endpoint mapper on the target machine will be pinged.<br /><br />This option is mutually exclusive with the interface \(**\/f**\) option.|  
|\/o <binding\_options>|Specifies the binding options for the RPC ping.|  
|\/f <interface UUID>\[,MajorVer\]|Specifies the interface to ping. This option is mutually exclusive with the endpoint option. The interface is specified as a UUID.<br /><br />If the *MajorVer* is not specified, version 1 of the interface will be sought.<br /><br />When interface is specified, **rpcping** will query the endpoint mapper on the target machine to retrieve the endpoint for the specified interface. The endpoint mapper will be queried using the options specified in the command line.|  
|\/O <Object UUID>|Specifies the object UUID if the interface registered one.|  
|\/i <\#\_iterations>|Specifies the number of calls to make. The default is 1. This option is useful for measuring connection latency if multiple iterations are specified.|  
|\/u <security\_package\_id>|Specifies the security package \(security provider\) RPC will use to make the call. The security package is identified as a number or a name. If a number is used it is the same number as in the RpcBindingSetAuthInfoEx API. The list below shows the names and numbers. Names are not case sensitive:<br /><br />-   Negotiate \/ 9 or one of nego, snego or negotiate<br />-   NTLM \/ 10 or NTLM<br />-   SChannel \/ 14 or SChannel<br />-   Kerberos \/ 16 or Kerberos<br />-   Kernel \/ 20 or Kernel<br />    If you specify this option, you must specify authentication level other than none. There is no default for this option. If it is not specified, RPC will not use security for the ping.|  
|\/a <authn\_level>|Specifies the authentication level to use. Possible values are:<br /><br />-   connect<br />-   call<br />-   pkt<br />-   integrity<br />-   privacy<br /><br />If this option is specified, the security package ID \(\/u\) must also be specified. There is no default for this option.<br /><br />If this option is not specified, RPC will not use security for the ping.|  
|\/N <server\_princ\_name>|Specifies a server principal name.<br /><br />This field can be used only when authentication level and security package are selected.|  
|\/I <auth\_identity>|Allows you to specify alternative identity to connect to the server. The identity is in the form user,domain,password. If the user name, domain, or password have special characters that can be interpreted by the shell, enclose the identity in double quotes. You can specify **\*** instead of the password and RPC will prompt you to enter the password without echoing it on the screen. If this field is not specified, the identity of the logged on user will be used.<br /><br />This field can be used only when authentication level and security package are selected.|  
|\/C <capabilities>|Specifies a hexadecimal bitmask of flags. This field can be used only when authentication level and security package are selected.|  
|\/T <identity\_tracking>|Specifies static or dynamic. If not specified, dynamic is the default.<br /><br />This field can be used only when authentication level and security package are selected.|  
|\/M <impersonation\_type>|Specifies anonymous, identify, impersonate or delegate. Default is impersonate.<br /><br />This field can be used only when authentication level and security package are selected.|  
|\/S <server\_sid>|Specifies the expected SID of the server.<br /><br />This field can be used only when authentication level and security package are selected.|  
|\/P <proxy\_auth\_identity>|Specifies the identity to authenticate with to the RPC\/HTTP proxy. Has the same format as for the \/I option. You must specify security package \(\/u\), authentication level \(\/a\), and authentication schemes \(\/H\) in order to use this option.|  
|\/F <RPCHTTP\_flags>|Specifies the flags to pass for RPC\/HTTP front end authentication. The flags may be specified as numbers or names The currently recognized flags are:<br /><br />-   Use SSL \/ 1 or ssl or use\_ssl<br />-   Use first auth scheme \/ 2 or first or use\_first<br /><br />You must specify security package \(\/u\) and authentication level \(\/a\) in order to use this option.|  
|\/H <RPC\/HTTP\_authn\_schemes>|Specifies the authentication schemes to use for RPC\/HTTP front end authentication. This option is a list of numerical values or names separated by comma. Example: Basic,NTLM. Recognized values are \(names are not case sensitive\):<br /><br />-   Basic \/ 1 or Basic<br />-   NTLM \/ 2 or NTLM<br />-   Certificate \/ 65536 or Cert<br /><br />You must specify security package \(\/u\) and authentication level \(\/a\) in order to use this option.|  
|\/B <server\_certificate\_subject>|Specifies the server certificate subject. You must use SSL for this option to work.<br /><br />You must specify security package \(\/u\) and authentication level \(\/a\) in order to use this option.|  
|\/b|Retrieves the server certificate subject from the certificate sent by the server and prints it to a screen or a log file. Valid only when the Proxy Echo only option \(\/E\) and the use SSL options are specified.<br /><br />You must specify security package \(\/u\) and authentication level \(\/a\) in order to use this option.|  
|\/R|Specifies the HTTP proxy. If *none*, the RPC proxy is used. The value *default* means to use the IE settings in your client machine. Any other value will be treated as the explicit HTTP proxy. If you do not specify this flag, the default value is assumed, that is, the IE settings are checked. This flag is valid only when the **\/E** \(Echo Only\) flag is enabled.|  
|\/E|Restricts the ping to the RPC\/HTTP proxy only. The ping does not reach the server. Useful when trying to establish whether the RPC\/HTTP proxy is reachable. To specify an HTTP proxy, use the \/R flag. If an HTTP proxy is specified in the \/o flag, this option will be ignored.<br /><br />You must specify security package \(\/u\) and authentication level \(\/a\) in order to use this option.|  
|\/q|Specifies quiet mode. Does not issue any prompts except for passwords. Assumes *Y* response to all queries. Use this option with care.|  
|\/c|Use smart card certificate. RPCPing will prompt user to choose smart card.|  
|\/A|Specifies the identity with which to authenticate to the HTTP proxy. Has the same format as for the \/I option.<br /><br />You must specify authentication schemes \(\/U\), security package \(\/u\) and authentication level \(\/a\) in order to use this option.|  
|\/U|Specifies the authentication schemes to use for HTTP proxy authentication. This option is a list of numerical values or names separated by comma. Example: Basic,NTLM. Recognized values are \(names are not case sensitive\):<br /><br />-   Basic \/ 1 or Basic<br />-   NTLM \/ 2 or NTLM<br /><br />You must specify security package \(\/u\) and authentication level \(\/a\) in order to use this option.|  
|\/r|If multiple iterations are specified, this option will make **rpcping** display current execution statistics periodically instead after the last call. The report interval is given in seconds. Default is 15.|  
|\/v|Tells **rpcping** how verbose to make the output. Default value is 1. 2 and 3 provide more output from **rpcping**.|  
|\/d|Launches RPC network diagnostic UI.|  
|\/p|Specifies to prompt for credentials if authentication fails.|  
|\/?|Displays Help at the command prompt.|  
  
## <a name="BKMK_Examples"></a>Examples  
To find out if your Exchange server that you connect through RPC\/HTTP is accessible, type:  
  
```  
rpcping /t ncacn_http /s exchange_server /o RpcProxy=front_end_proxy /P "username,domain,*" /H Basic /u NTLM /a connect /F 3  
```  
  
<Here is where you put a detailed description of another example.>  
  
```  
This /is /a:”different” /example  
```  
  
## Additional references  
  
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  

