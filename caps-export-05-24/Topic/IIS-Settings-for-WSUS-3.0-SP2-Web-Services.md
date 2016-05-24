---
title: IIS Settings for WSUS 3.0 SP2 Web Services
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b940c212-f4c4-493f-906a-29bcdc7c9186
author: britw
---
# IIS Settings for WSUS 3.0 SP2 Web Services
This topic discusses the Internet Information Services \(IIS\) settings that are used with [!INCLUDE[wsus_firstref_30SP2](../Token/wsus_firstref_30SP2_md.md)] 3.0 SP2. It introduces the **adsutil.vbs** utility, which you can use to find the paths for the WSUS 3.0 SP2 web services on your computer and to check the properties of a web service.  
  
A WSUS 3.0 SP2 web service may have stopped working correctly because one of these settings was changed by another installation or application. Troubleshooting the WSUS 3.0 SP2 web services may be simplified if you compare your current IIS settings for the WSUS web services with those listed in this topic, which are set by WSUS setup.  
  
The values of these IIS settings are sometimes represented with variable names instead of actual values. This is because the actual value may vary from one installation to another. The variable names that are used in the IIS settings and in the following instructions are:  
  
-   **windir**  
    The standard environment variable for the Windows directory \(usually **C:\\WINDOWS**\).  
  
-   **InetpubDir**  
    The IIS inetpub directory \(usually **C:\\Inetpub**\).  
  
-   **WSUSInstallDir**  
    The directory where WSUS is installed \(usually **C:\\Program Files\\Update Services**\).  
  
-   **WebSiteID**  
    The number that IIS uses to identify websites \(1 is the ID of the default website, but other websites are assigned random numbers\).  
  
## IIS vroots  
The following virtual directories \(vroots\) are created in IIS \(in the default website\) for client\-to\-server synchronization, server\-to\-server synchronization, reporting, and client self\-update.  
  
|Vroot in IIS|Properties|  
|----------------|--------------|  
|ClientWebService|Directory: **%ProgramFiles%Update Services\\WebServices\\ClientWebService**<br /><br />Application Pool: WsusPool<br /><br />Security: Anonymous Access Enabled<br /><br />Execute Permissions: Scripts Only|  
|Content|Directory\[the location of the WSUS content directory\]<br /><br />Security: Anonymous Access Enabled<br /><br />Execute Permissions: None|  
|DssAuthWebService|Directory: **%ProgramFiles%Update Services\\WebServices\\DssAuthWebService**<br /><br />Application Pool: WsusPool<br /><br />Security: Anonymous Access Enabled<br /><br />Execute Permissions: Scripts Only|  
|Inventory|Directory: **%ProgramFiles%Update Services\\Inventory**<br /><br />Application Pool: WsusPool<br /><br />Security: Anonymous Access Enabled<br /><br />Execute Permissions: Scripts Only|  
|ReportingWebService|Directory: **%ProgramFiles%Update Services\\WebServices\\ReportingWebService**<br /><br />Application Pool: WsusPool<br /><br />Security: Anonymous Access Enabled<br /><br />Execute Permissions: Scripts Only|  
|ServerSyncWebService|Directory: **%ProgramFiles%Update Services\\WebServices\\ServerSyncWebService**<br /><br />Application Pool: WsusPool<br /><br />Security: Anonymous Access Enabled<br /><br />Execute Permissions: Scripts Only|  
|SimpleAuthWebService|Directory: **%ProgramFiles%Update Services\\WebServices\\SimpleAuthWebService**<br /><br />Application Pool: WsusPool<br /><br />Security: Anonymous Access Enabled<br /><br />Execute Permissions: Scripts Only|  
|ApiRemoting30|Directory: **%ProgramFiles%Update Services\\Administration**<br /><br />Application Pool: WsusPool<br /><br />Security: Integrated Windows Authentication, Digest Authentication<br /><br />Execute Permissions: Scripts Only|  
|SelfUpdate|Directory: **%ProgramFiles%Update Services\\SelfUpdate**<br /><br />Security: Anonymous Access Enabled<br /><br />Execute Permissions: Scripts Only|  
  
## The adsutil.vbs IIS administration utility  
The **adsutil.vbs** IIS administration utility can be found on your server in the **Inetpub\\AdminScripts** directory. You can use this utility to find the paths for the WSUS 3.0 SP2 web services on your computer and to check the properties of a web service. For more information about using **adsutil.vbs**, see [Using the Adsutil.vbs Administration Script](http://go.microsoft.com/fwlink/?LinkId=162432).  
  
### Finding web service paths with adsutil.vbs  
You can use **adsutil.vbs** to find the paths for the WSUS 3.0 SP2 web services on your computer with the following procedure:  
  
##### To find the paths of web services  
  
1.  Open a Command Prompt window.  
  
2.  Navigate to the directory where **adsutil.vbs** is located: **cd %Inetpubdir%\\AdminScripts**.  
  
3.  Type the following command: **adsutil.vbs find path**  
  
4.  If you have WSUS installed, you should see output like the following:  
  
**Property path found at:**  
  
**W3SVC\/***WebSiteID***\/ROOT**  
  
**W3SVC\/***WebSiteID***\/ROOT\/ApiRemoting30**  
  
**W3SVC\/***WebSiteID***\/D\/ROOT\/ClientWebService**  
  
**W3SVC\/***WebSiteID***\/ROOT\/Content**  
  
**W3SVC\/***WebSiteID***\/ROOT\/DssAuthWebService**  
  
**W3SVC\/***WebSiteID***\/ROOT\/Inventory**  
  
**W3SVC\/***WebSiteID***\/ROOT\/ReportingWebService**  
  
**W3SVC\/***WebSiteID***\/ROOT\/Selfupdate**  
  
**W3SVC\/***WebSiteID***\/ROOT\/ServerSyncWebService**  
  
**W3SVC\/***WebSiteID***\/ROOT\/SimpleAuthWebService**  
  
> [!NOTE]  
> If you have installed WSUS on the default website, *WebSiteID* will be **1**, but if you have installed it on another website, *WebSiteID* will be a random number.  
  
### Checking the properties of a web service  
You can also use **adsutil.vbs** to find the properties of a given web service. You will use one of the web service paths listed previously to specify the web service that you want to check. For example, if you want to check the properties of the Reporting web service, you use the path **W3SVC\/***WebSiteID***\/ROOT\/ReportingWebService**, where *WebSiteID* represents the number of the WSUS website.  
  
##### To check the properties of a web service  
  
1.  Open a Command Prompt window.  
  
2.  Navigate to the directory where **adsutil.vbs** is located: **cd** *Inetpubdir***\\AdminScripts**.  
  
3.  Type the following command: **adsutil.vbs enum** *WebServicePath*  
    where *WebServicePath* represents the path of the web service that you want to check.  
  
4.  Compare the output to the standard values given in the tables that follow.  
  
### Global properties  
These global properties can be retrieved with the following **adsutil.vbs** command:  
  
**adsutil.vbs enum W3SVC**  
  
> [!NOTE]  
> The properties in the following table comprise a partial list.  
  
|**Property**|**Value**|  
|----------------|-------------|  
|KeyType|\(STRING\) "IIsWebService"|  
|MaxConnections|\(INTEGER\) 4294967295|  
|AnonymousUserName|\(STRING\) "IUSR\_<machinename>"|  
|ConnectionTimeout|\(INTEGER\) 120|  
|AllowKeepAlive|\(BOOLEAN\) True|  
|DefaultDoc|\(STRING\) "Default.htm,Default.asp,index.htm"|  
|CacheISAPI|\(BOOLEAN\) True|  
|CGITimeout|\(INTEGER\) 300|  
|ContentIndexed|\(BOOLEAN\) True|  
|DownlevelAdminInstance|\(INTEGER\) 1|  
|AspBufferingOn|\(BOOLEAN\) True|  
|AspLogErrorRequests|\(BOOLEAN\) True|  
|AspScriptErrorSentToBrowser|\(BOOLEAN\) True|  
|AspScriptErrorMessage|\(STRING\) "An error occurred on the server when<br /><br />processing the URL. Please contact the system administrator"|  
|AspAllowOutOfProcComponents|\(BOOLEAN\) True >|  
|AspScriptFileCacheSize|\(INTEGER\) 500|  
|AspDiskTemplateCacheDirectory|\(EXPANDSZ\) "%windir%\\system32\\inetsrv\\ASP<br /><br />Compiled Templates"|  
|AspMaxDiskTemplateCacheFiles|\(INTEGER\) 2000|  
|AspScriptEngineCacheMax|\(INTEGER\) 250|  
|AspScriptTimeout|\(INTEGER\) 90|  
|AspSessionTimeout|\(INTEGER\) 20|  
|AspEnableParentPaths|\(BOOLEAN\) False|  
|AspAllowSessionState|\(BOOLEAN\) True|  
|AspScriptLanguage|\(STRING\) "VBScript"|  
|AspExceptionCatchEnable|\(BOOLEAN\) True<br>|  
|AspCodepage|\(INTEGER\) 0|  
|AspLCID|\(INTEGER\) 2048|  
|AspQueueTimeout|\(INTEGER\) 4294967295|  
|AspEnableAspHtmlFallback|\(BOOLEAN\) False|  
|AspEnableChunkedEncoding|\(BOOLEAN\) True|  
|AspEnableTypelibCache|\(BOOLEAN\) True|  
|AspErrorsToNTLog|\(BOOLEAN\) False|  
|AspProcessorThreadMax|\(INTEGER\) 25|  
|AspTrackThreadingModel|\(BOOLEAN\) False|  
|AspRequestQueueMax|\(INTEGER\) 3000|  
|AspEnableApplicationRestart|\(BOOLEAN\) True|  
|AspQueueConnectionTestTime|\(INTEGER\) 3|  
|AspSessionMax|\(INTEGER\) 4294967295|  
|AppAllowDebugging|\(BOOLEAN\) False|  
|AppAllowClientDebug|\(BOOLEAN\) False|  
|PasswordChangeFlags|\(INTEGER\) 6|  
|AuthChangeUnsecure|\(BOOLEAN\) False|  
|AuthChangeDisable|\(BOOLEAN\) True|  
|AuthAdvNotifyDisable|\(BOOLEAN\) True|  
|DirBrowseFlags|\(INTEGER\) 1073741886|  
|EnableDirBrowsing|\(BOOLEAN\) False|  
|DirBrowseShowDate|\(BOOLEAN\) True|  
|DirBrowseShowTime|\(BOOLEAN\) True|  
|DirBrowseShowSize|\(BOOLEAN\) True|  
|DirBrowseShowExtension|\(BOOLEAN\) True|  
|DirBrowseShowLongDate|\(BOOLEAN\) True|  
|EnableDefaultDoc|\(BOOLEAN\) True|  
|AuthFlags|\(INTEGER\) 1|  
|AuthBasic|\(BOOLEAN\) False|  
|AuthAnonymous|\(BOOLEAN\) True|  
|AuthNTLM|\(BOOLEAN\) False|  
|AuthMD5|\(BOOLEAN\) False|  
|AuthPassport|\(BOOLEAN\) False|  
|InProcessIsapiApps|\(LIST\) \(6 Items\)<br /><br />"%windir%\\system32\\inetsrv\\httpext.dll"<br /><br />"%windir%\\system32\\inetsrv\\httpodbc.dll"<br /><br />"%windir%\\system32\\inetsrv\\ssinc.dll"<br /><br />"%windir%\\system32\\msw3prt.dll"<br /><br />"%windir%\\Microsoft.NET\\Framework\\v2.0.50727\\aspnet\_isapi.dll"|  
|LogOdbcDataSource|\(STRING\) "HTTPLOG">|  
|LogOdbcTableName|\(STRING\) "InternetLog"|  
|LogOdbcUserName|\(STRING\) "InternetAdmin"|  
|WAMUserName|\(STRING\) "IWAM\_<machinename>">|  
|AuthChangeURL|\(STRING\) "\/iisadmpwd\/achg.asp"|  
|AuthExpiredURL|\(STRING\) "\/iisadmpwd\/aexp.asp"|  
|AuthNotifyPwdExpURL|\(STRING\) "\/iisadmpwd\/anot.asp"|  
|AuthExpiredUnsecureURL|\(STRING\) "\/iisadmpwd\/aexp3.asp"|  
|AuthNotifyPwdExpUnsecureURL|\(STRING\) "\/iisadmpwd\/anot3.asp"|  
|AppPoolId|\(STRING\) "DefaultAppPool"|  
|IIs5IsolationModeEnabled|\(BOOLEAN\) False|  
|MaxGlobalBandwidth|\(INTEGER\) 4294967295|  
|MinFileBytesPerSec|\(INTEGER\) 240|  
|LogInUTF8|\(BOOLEAN\) False|  
|AspAppServiceFlags|\(INTEGER\) 0|  
|AspEnableTracker|\(BOOLEAN\) False|  
|AspEnableSxs|\(BOOLEAN\) False|  
|AspUsePartition|\(BOOLEAN\) False|  
|AspKeepSessionIDSecure|\(INTEGER\) 0|  
|AspExecuteInMTA|\(INTEGER\) 0|  
|CentralBinaryLoggingEnabled|\(BOOLEAN\) False|  
|AspRunOnEndAnonymously|\(BOOLEAN\) True|  
|AspBufferingLimit|\(INTEGER\) 4194304|  
|AspCalcLineNumber|\(BOOLEAN\) True|  
|ApplicationDependencies|\(LIST\) \(6 Items\)<br /><br />"Active Server Pages;ASP"<br /><br />"Internet Data Connector;HTTPODBC"<br /><br />"Server Side Includes;SSINC"<br /><br />"WebDAV;WEBDAV"<br /><br />"ASP.NET v1.1.4322;ASP.NET v1.1.4322"|  
|WebSvcExtRestrictionList|\(LIST\) \(8 Items\)<br /><br />"0,\*.dll"<br /><br />"0,\*.exe"><br /><br />"0,<windir>\\system32\\inetsrv\\asp.dll,0,ASP,Active Server Pages"><br /><br />"0,<windir>\\system32\\inetsrv\\httpodbc.dll,0,HTTPODBC,Internet Data<br /><br />Connector"<br /><br />"0,<windir>\\system32\\inetsrv\\ssinc.dll,0,SSINC,Server Side Includes"<br /><br />"0,<windir>\\system32\\inetsrv\\httpext.dll,0,WEBDAV,webDAV"><br /><br />"1,<windir>\\Microsoft.NET\\Framework\\v2.0.50727\\aspnet\_isapi.dll,0,ASP.NET<br /><br />v2.0.50727,ASP.NET v2.0.50727"|  
|AspMaxRequestEntityAllowed|\(INTEGER\) 204800|  
|\[\/w3svc\/1\]|**n\/a**|  
|\[\/w3svc\/AppPools\]|**n\/a**|  
|\[\/w3svc\/Filters\]|**n\/a**|  
|\[\/w3svc\/Info\]|**n\/a**|  
  
### Global properties of the World Wide Website  
These properties can be retrieved with the following **adsutil.vbs** command:  
  
**adsutil.vbs enum W3SVC\/***WebSiteID*  
  
> [!NOTE]  
> The properties in the following table comprise a partial list.  
  
|**Property**|**Value**|  
|----------------|-------------|  
|KeyType|\(STRING\) "IIsWebServer"|  
|ServerState|\(INTEGER\) 2|  
|ServerComment|\(STRING\) "Default Web site"|  
|ServerSize|\(INTEGER\) 1|  
|ServerBindings|\(LIST\) \(1 Items\) ":80:" \(or 8530\)|  
|SecureBindings|\(LIST\) \(1 Items\) ":443:" \(or 8531\)|  
|ConnectionTimeout|\(INTEGER\) 180|  
|DefaultDoc|\(STRING\) "Default.htm,Default.asp,index.htm,iisstart.htm"|  
|AspBufferingOn|\(BOOLEAN\) False|  
|LogPluginClsid|\(STRING\) "{FF160663\-DE82\-11CF\-BC0A\-00AA006111E0}"|  
|Win32Error|\(INTEGER\) 0|  
|AppPoolId|\(STRING\) "DefaultAppPool"|  
  
### Properties of the API Remoting web service  
  
|**Property**|**Value**|  
|----------------|-------------|  
|KeyType|\(STRING\) "IIsWebVirtualDir"|  
|AppRoot|\(STRING\) "\/LM\/W3SVC\/*webSiteID*\/ROOT\/ApiRemoting30"|  
|AppFriendlyName|\(STRING\) "ApiRemoting30"|  
|AppIsolated|\(INTEGER\) 2|  
|Path|\(STRING\) "<WSUSInstallDir>\\WebServices\\ApiRemoting30"|  
|AccessFlags|\(INTEGER\) 513|  
|AccessExecute|\(BOOLEAN\) False|  
|AccessSource|\(BOOLEAN\) False|  
|AccessRead|\(BOOLEAN\) True|  
|AccessWrite|\(BOOLEAN\) False|  
|AccessScript|\(BOOLEAN\) True|  
|AccessNoRemoteExecute|\(BOOLEAN\) False|  
|AccessNoRemoteRead|\(BOOLEAN\) False|  
|AccessNoRemoteWrite|\(BOOLEAN\) False|  
|AccessNoRemoteScript|\(BOOLEAN\) False|  
|AccessNoPhysicalDir|\(BOOLEAN\) False|  
|AspScriptErrorSentToBrowser|\(BOOLEAN\) False|  
|AspEnableParentPaths|\(BOOLEAN\) False|  
|AuthFlags|\(INTEGER\) 21|  
|AuthBasic|\(BOOLEAN\) False|  
|AuthAnonymous|\(BOOLEAN\) True|  
|AuthNTLM|\(BOOLEAN\) True|  
|AuthMD5|\(BOOLEAN\) True|  
|AuthPassport|\(BOOLEAN\) False|  
|AppPoolId|\(STRING\) "WsusPool"|  
  
### Properties of the Client web service  
  
|Property|Value|  
|------------|---------|  
|KeyType|\(STRING\) "IIsWebVirtualDir"|  
|AppRoot|\(STRING\) "\/LM\/W3SVC\/*WebSiteID*\/ROOT\/ClientWebService"|  
|AppFriendlyName|\(STRING\) "ClientWebService"|  
|AppIsolated|\(INTEGER\) 2|  
|Path|\(STRING\) "<WSUSInstallDir>\\WebServices\\ClientWebService"|  
|AccessFlags|\(INTEGER\) 513|  
|AccessExecute|\(BOOLEAN\) False|  
|AccessSource|\(BOOLEAN\) False|  
|AccessRead|\(BOOLEAN\) True|  
|AccessWrite|\(BOOLEAN\) False|  
|AccessScript|\(BOOLEAN\) True|  
|AccessNoRemoteExecute|\(BOOLEAN\) False|  
|AccessNoRemoteRead|\(BOOLEAN\) False|  
|AccessNoRemoteWrite|\(BOOLEAN\) False|  
|AccessNoRemoteScript|\(BOOLEAN\) False|  
|AccessNoPhysicalDir|\(BOOLEAN\) False|  
|AspScriptErrorSentToBrowser|\(BOOLEAN\) False|  
|AspEnableParentPaths|\(BOOLEAN\) False|  
|AuthFlags|\(INTEGER\) 1|  
|AuthBasic|\(BOOLEAN\) False|  
|AuthAnonymous|\(BOOLEAN\) True|  
|AuthNTLM|\(BOOLEAN\) False|  
|AuthMD5|\(BOOLEAN\) False|  
|AuthPassport|\(BOOLEAN\) False|  
|AppPoolId|\(STRING\) "WsusPool"|  
  
### Properties of the Downstream Server Authentication web service  
  
|**Property**|**Value**|  
|----------------|-------------|  
|KeyType|\(STRING\) "IIsWebVirtualDir"|  
|AppRoot|\(STRING\) "\/LM\/W3SVC\/*WebSiteID*\/ROOT\/DssAuthWebService"|  
|AppFriendlyName|\(STRING\) " DssAuthWebService "|  
|AppIsolated|\(INTEGER\) 2|  
|Path|\(STRING\) "<WSUSInstallDir>\\WebServices\\DssAuthWebService"|  
|AccessFlags|\(INTEGER\) 513|  
|AccessExecute|\(BOOLEAN\) False|  
|AccessSource|\(BOOLEAN\) False|  
|AccessRead|\(BOOLEAN\) True|  
|AccessWrite|\(BOOLEAN\) False|  
|AccessScript|\(BOOLEAN\) True|  
|AccessNoRemoteExecute|\(BOOLEAN\) False|  
|AccessNoRemoteRead|\(BOOLEAN\) False|  
|AccessNoRemoteWrite|\(BOOLEAN\) False|  
|AccessNoRemoteScript|\(BOOLEAN\) False|  
|AccessNoPhysicalDir|\(BOOLEAN\) False|  
|AspScriptErrorSentToBrowser|\(BOOLEAN\) False|  
|AspEnableParentPaths|\(BOOLEAN\) False|  
|AuthFlags|\(INTEGER\) 1|  
|AuthBasic|\(BOOLEAN\) False|  
|AuthAnonymous|\(BOOLEAN\) True|  
|AuthNTLM|\(BOOLEAN\) False|  
|AuthMD5|\(BOOLEAN\) False|  
|AuthPassport|\(BOOLEAN\) False|  
|AppPoolId|\(STRING\) "WsusPool"|  
  
### Properties of the Inventory Collection web service  
  
|**Property**|**Value**|  
|----------------|-------------|  
|KeyType|\(STRING\) "IIsWebVirtualDir"|  
|AppRoot|\(STRING\) "\/LM\/W3SVC\/*WebSiteID*\/ROOT\/Inventory"|  
|AppFriendlyName|\(STRING\) "Inventory"|  
|AppIsolated|\(INTEGER\) 2|  
|Path|\(STRING\) "<WSUSInstallDir>\\WebServices\\Inventory"|  
|AccessFlags|\(INTEGER\) 513|  
|AccessExecute|\(BOOLEAN\) False|  
|AccessSource|\(BOOLEAN\) False|  
|AccessRead|\(BOOLEAN\) True|  
|AccessWrite|\(BOOLEAN\) False|  
|AccessScript|\(BOOLEAN\) True|  
|AccessNoRemoteExecute|\(BOOLEAN\) False|  
|AccessNoRemoteRead|\(BOOLEAN\) False|  
|AccessNoRemoteWrite|\(BOOLEAN\) False|  
|AccessNoRemoteScript|\(BOOLEAN\) False|  
|AccessNoPhysicalDir|\(BOOLEAN\) False|  
|AspScriptErrorSentToBrowser|\(BOOLEAN\) False|  
|AspEnableParentPaths|\(BOOLEAN\) False|  
|AuthFlags|\(INTEGER\) 1|  
|AuthBasic|\(BOOLEAN\) False|  
|AuthAnonymous|\(BOOLEAN\) True|  
|AuthNTLM|\(BOOLEAN\) False|  
|AuthMD5|\(BOOLEAN\) False|  
|AuthPassport|\(BOOLEAN\) False|  
|AppPoolId|\(STRING\) "WsusPool"|  
  
### Properties of the Reporting web service  
  
|**Property**|**Value**|  
|----------------|-------------|  
|KeyType|\(STRING\) "IIsWebVirtualDir"|  
|AppRoot|\(STRING\) "\/LM\/W3SVC\/*WebSiteID*\/ROOT\/ReportingWebService"|  
|AppFriendlyName|\(STRING\) " ReportingWebService "|  
|AppIsolated|\(INTEGER\) 2|  
|Path|\(STRING\) "<WSUSInstallDir>\\WebServices\\ReportingWebService"|  
|AccessFlags|\(INTEGER\) 513|  
|AccessExecute|\(BOOLEAN\) False|  
|AccessSource|\(BOOLEAN\) False|  
|AccessRead|\(BOOLEAN\) True|  
|AccessWrite|\(BOOLEAN\) False|  
|AccessScript|\(BOOLEAN\) True|  
|AccessNoRemoteExecute|\(BOOLEAN\) False|  
|AccessNoRemoteRead|\(BOOLEAN\) False|  
|AccessNoRemoteWrite|\(BOOLEAN\) False|  
|AccessNoRemoteScript|\(BOOLEAN\) False|  
|AccessNoPhysicalDir|\(BOOLEAN\) False|  
|AspScriptErrorSentToBrowser|\(BOOLEAN\) False|  
|AspEnableParentPaths|\(BOOLEAN\) False|  
|AuthFlags|\(INTEGER\) 1|  
|AuthBasic|\(BOOLEAN\) False|  
|AuthAnonymous|\(BOOLEAN\) True|  
|AuthNTLM|\(BOOLEAN\) False|  
|AuthMD5|\(BOOLEAN\) False|  
|AuthPassport|\(BOOLEAN\) False|  
|AppPoolId|\(STRING\) "WsusPool"|  
  
### Properties of the Selfupdate web service  
  
|**Property**|**Value**|  
|----------------|-------------|  
|KeyType|\(STRING\) "IIsWebVirtualDir"|  
|Path|\(STRING\) "<WSUSInstallDir>\\WebServices\\ServerSyncWebService"|  
|AccessFlags|\(INTEGER\) 513|  
|AccessExecute|\(BOOLEAN\) False|  
|AccessSource|\(BOOLEAN\) False|  
|AccessRead|\(BOOLEAN\) True|  
|AccessWrite|\(BOOLEAN\) False|  
|AccessScript|\(BOOLEAN\) True|  
|AccessNoRemoteExecute|\(BOOLEAN\) False|  
|AccessNoRemoteRead|\(BOOLEAN\) False|  
|AccessNoRemoteWrite|\(BOOLEAN\) False|  
|AccessNoRemoteScript|\(BOOLEAN\) False|  
|AccessNoPhysicalDir|\(BOOLEAN\) False|  
  
### Properties of the Server Synchronization web service  
  
|**Property**|**Value**|  
|----------------|-------------|  
|KeyType|\(STRING\) "IIsWebVirtualDir"|  
|AppRoot|\(STRING\) "\/LM\/W3SVC\/*WebSiteID*\/ROOT\/ServerSyncWebService"|  
|AppFriendlyName|\(STRING\) " ServerSyncWebService "|  
|AppIsolated|\(INTEGER\) 2|  
|Path|\(STRING\) "<WSUSInstallDir>\\WebServices\\ServerSyncWebService"|  
|AccessFlags|\(INTEGER\) 513|  
|AccessExecute|\(BOOLEAN\) False|  
|AccessSource|\(BOOLEAN\) False|  
|AccessRead|\(BOOLEAN\) True|  
|AccessWrite|\(BOOLEAN\) False|  
|AccessScript|\(BOOLEAN\) True|  
|AccessNoRemoteExecute|\(BOOLEAN\) False|  
|AccessNoRemoteRead|\(BOOLEAN\) False|  
|AccessNoRemoteWrite|\(BOOLEAN\) False|  
|AccessNoRemoteScript|\(BOOLEAN\) False|  
|AccessNoPhysicalDir|\(BOOLEAN\) False|  
|AspScriptErrorSentToBrowser|\(BOOLEAN\) False|  
|AspEnableParentPaths|\(BOOLEAN\) False|  
|AuthFlags|\(INTEGER\) 1|  
|AuthBasic|\(BOOLEAN\) False|  
|AuthAnonymous|\(BOOLEAN\) True|  
|AuthNTLM|\(BOOLEAN\) False|  
|AuthMD5|\(BOOLEAN\) False|  
|AuthPassport|\(BOOLEAN\) False|  
|AppPoolId|\(STRING\) "WsusPool"|  
  
### Properties of the Simple Authorization web service  
  
|**Property**|**Value**|  
|----------------|-------------|  
|KeyType|\(STRING\) "IIsWebVirtualDir"|  
|AppRoot|\(STRING\) "\/LM\/W3SVC\/*WebSiteID*\/ROOT\/SimpleAuthWebService"|  
|AppFriendlyName|\(STRING\) "SimpleAuthWebService"|  
|AppIsolated|\(INTEGER\) 2|  
|Path|\(STRING\) "<WSUSInstallDir>\\WebServices\\SimpleAuthWebService"|  
|AccessFlags|\(INTEGER\) 513|  
|AccessExecute|\(BOOLEAN\) False|  
|AccessSource|\(BOOLEAN\) False|  
|AccessRead|\(BOOLEAN\) True|  
|AccessWrite|\(BOOLEAN\) False|  
|AccessScript|\(BOOLEAN\) True|  
|AccessNoRemoteExecute|\(BOOLEAN\) False|  
|AccessNoRemoteRead|\(BOOLEAN\) False|  
|AccessNoRemoteWrite|\(BOOLEAN\) False|  
|AccessNoRemoteScript|\(BOOLEAN\) False|  
|AccessNoPhysicalDir|\(BOOLEAN\) False|  
|AspScriptErrorSentToBrowser|\(BOOLEAN\) False|  
|AspEnableParentPaths|\(BOOLEAN\) False|  
|AuthFlags|\(INTEGER\) 1|  
|AuthBasic|\(BOOLEAN\) False|  
|AuthAnonymous|\(BOOLEAN\) True|  
|AuthNTLM|\(BOOLEAN\) False|  
|AuthMD5|\(BOOLEAN\) False|  
|AuthPassport|\(BOOLEAN\) False|  
|AppPoolId|\(STRING\) "WsusPool"|  
  
