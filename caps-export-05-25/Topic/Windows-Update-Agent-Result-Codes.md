---
title: Windows Update Agent Result Codes
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 48061af2-cebf-4107-b804-d0fa16bb65ea
author: britw
---
# Windows Update Agent Result Codes
The Windows Update Agent provides result codes to help troubleshoot installation issues.  
  
The following tables show the result codes \(hexadecimal value\), the corresponding strings, and their descriptions.  
  
**WUA success codes**  
  
|Result Code|Result String|Description|  
|---------------|-----------------|---------------|  
|0x240001|WU\_S\_SERVICE\_STOP|Windows Update Agent was stopped successfully.|  
|0x240002|WU\_S\_SELFUPDATE|Windows Update Agent updated itself.|  
|0x240003|WU\_S\_UPDATE\_ERROR|Operation completed successfully but there were errors applying the updates.|  
|0x240004|WU\_S\_MARKED\_FOR\_DISCONNECT|A callback was marked to be disconnected later because the request to disconnect the operation came while a callback was running.|  
|0x240005|WU\_S\_REBOOT\_REQUIRED|The system must be restarted to complete update installation.|  
|0x240006|WU\_S\_ALREADY\_INSTALLED|The update to be installed is already installed on the system.|  
|0x240007|WU\_S\_ALREADY\_UNINSTALLED|The update to be removed is not installed on the system.|  
|0x240008|WU\_S\_ALREADY\_DOWNLOADED|The update to be downloaded has already been downloaded.|  
  
**WUA error codes**  
  
|Result Code|Result String|Description|  
|---------------|-----------------|---------------|  
|0x80240001|WU\_E\_NO\_SERVICE|Windows Update Agent was unable to provide the service.|  
|0x80240002|WU\_E\_MAX\_CAPACITY\_REACHED|The maximum capacity of the service was exceeded.|  
|0x80240003|WU\_E\_UNKNOWN\_ID|An ID cannot be found.|  
|0x80240004|WU\_E\_NOT\_INITIALIZED|The object could not be initialized.|  
|0x80240005|WU\_E\_RANGEOVERLAP|The update handler requested a byte range that overlaps a previously requested range.|  
|0x80240006|WU\_E\_TOOMANYRANGES|The requested number of byte ranges exceeds the maximum number \(2^31 \- 1\).|  
|0x80240007|WU\_E\_INVALIDINDEX|The index to a collection was invalid.|  
|0x80240008|WU\_E\_ITEMNOTFOUND|The key for the item queried could not be found.|  
|0x80240009|WU\_E\_OPERATIONINPROGRESS|A conflicting operation was in progress. Some operations \(such as installation\) cannot be performed simultaneously.|  
|0x8024000A|WU\_E\_COULDNOTCANCEL|Cancellation of the operation was not allowed.|  
|0x8024000B|WU\_E\_CALL\_CANCELLED|Operation was cancelled.|  
|0x8024000C|WU\_E\_NOOP|No operation was required.|  
|0x8024000D|WU\_E\_XML\_MISSINGDATA|Windows Update Agent could not find the required information in the update's XML data.|  
|0x8024000E|WU\_E\_XML\_INVALID|Windows Update Agent found invalid information in the update's XML data.|  
|0x8024000F|WU\_E\_CYCLE\_DETECTED|Circular update relationships were detected in the metadata.|  
|0x80240010|WU\_E\_TOO\_DEEP\_RELATION|Update relationships that are too deep were evaluated.|  
|0x80240011|WU\_E\_INVALID\_RELATIONSHIP|An invalid update relationship was detected.|  
|0x80240012|WU\_E\_REG\_VALUE\_INVALID|An invalid registry value was read.|  
|0x80240013|WU\_E\_DUPLICATE\_ITEM|Operation tried to add a duplicate item to a list.|  
|0x80240016|WU\_E\_INSTALL\_NOT\_ALLOWED|Operation tried to install while another installation was in progress or the system was pending a mandatory restart.|  
|0x80240017|WU\_E\_NOT\_APPLICABLE|Operation was not performed because there are no applicable updates.|  
|0x80240018|WU\_E\_NO\_USERTOKEN|Operation failed because a required user token is missing.|  
|0x80240019|WU\_E\_EXCLUSIVE\_INSTALL\_CONFLICT|An exclusive update cannot be installed with other updates at the same time.|  
|0x8024001A|WU\_E\_POLICY\_NOT\_SET|A policy value was not set.|  
|0x8024001B|WU\_E\_SELFUPDATE\_IN\_PROGRESS|The operation could not be performed because the Windows Update Agent is self\-updating.|  
|0x8024001D|WU\_E\_INVALID\_UPDATE|An update contains invalid metadata.|  
|0x8024001E|WU\_E\_SERVICE\_STOP|Operation did not complete because the service or system was being shut down.|  
|0x8024001F|WU\_E\_NO\_CONNECTION|Operation did not complete because the network connection was unavailable.|  
|0x80240020|WU\_E\_NO\_INTERACTIVE\_USER|Operation did not complete because there is no logged\-on interactive user.|  
|0x80240021|WU\_E\_TIME\_OUT|Operation did not complete because it timed out.|  
|0x80240022|WU\_E\_ALL\_UPDATES\_FAILED|Operation failed for all the updates.|  
|0x80240023|WU\_E\_EULAS\_DECLINED|The license terms for all updates were declined.|  
|0x80240024|WU\_E\_NO\_UPDATE|There are no updates.|  
|0x80240025|WU\_E\_USER\_ACCESS\_DISABLED|Group Policy settings prevented access to Windows Update.|  
|0x80240026|WU\_E\_INVALID\_UPDATE\_TYPE|The type of update is invalid.|  
|0x80240027|WU\_E\_URL\_TOO\_LONG|The URL exceeded the maximum length.|  
|0x80240028|WU\_E\_UNINSTALL\_NOT\_ALLOWED|The update could not be uninstalled because the request did not originate from a WSUS server.|  
|0x80240029|WU\_E\_INVALID\_PRODUCT\_LICENSE|Search may have missed some updates before there is an unlicensed application on the system.|  
|0x8024002A|WU\_E\_MISSING\_HANDLER|A component that is required to detect applicable updates was missing.|  
|0x8024002B|WU\_E\_LEGACYSERVER|An operation did not complete because it requires a newer version of server software.|  
|0x8024002C|WU\_E\_BIN\_SOURCE\_ABSENT|A delta\-compressed update could not be installed because it required the source.|  
|0x8024002D|WU\_E\_SOURCE\_ABSENT|A full\-file update could not be installed because it required the source.|  
|0x8024002E|WU\_E\_WU\_DISABLED|Access to an unmanaged server is not allowed.|  
|0x8024002F|WU\_E\_CALL\_CANCELLED\_BY\_POLICY|Operation did not complete because the DisableWindowsUpdateAccess policy was set.|  
|0x80240030|WU\_E\_INVALID\_PROXY\_SERVER|The format of the proxy list was invalid.|  
|0x80240031|WU\_E\_INVALID\_FILE|The file is in the wrong format.|  
|0x80240032|WU\_E\_INVALID\_CRITERIA|The search criteria string was invalid.|  
|0x80240033|WU\_E\_EULA\_UNAVAILABLE|License terms could not be downloaded.|  
|0x80240034|WU\_E\_DOWNLOAD\_FAILED|Update failed to download.|  
|0x80240035|WU\_E\_UPDATE\_NOT\_PROCESSED|The update was not processed.|  
|0x80240036|WU\_E\_INVALID\_OPERATION|The object's current state did not allow the operation.|  
|0x80240037|WU\_E\_NOT\_SUPPORTED|The functionality for the operation is not supported.|  
|0x80240038|WU\_E\_WINHTTP\_INVALID\_FILE|The downloaded file has an unexpected content type.|  
|0x80240039|WU\_E\_TOO\_MANY\_RESYNC|The agent was asked by server to synchronize too many times.|  
|0x80240040|WU\_E\_NO\_SERVER\_CORE\_SUPPORT|WUA API method does not run on a Server Core installation option of the Windows 2008 R2 operating system.|  
|0x80240041|WU\_E\_SYSPREP\_IN\_PROGRESS|Service is not available when sysprep is running.|  
|0x80240042|WU\_E\_UNKNOWN\_SERVICE|The update service is no longer registered with Automatic Updates.|  
|0x80240FFF|WU\_E\_UNEXPECTED|An operation failed due to reasons not covered by another error code.|  
|0x80241001|WU\_E\_MSI\_WRONG\_VERSION|Search may have missed some updates because Windows Installer is less than version 3.1.|  
|0x80241002|WU\_E\_MSI\_NOT\_CONFIGURED|Search may have missed some updates because Windows Installer is not configured.|  
|0x80241003|WU\_E\_MSP\_DISABLED|Search may have missed some updates because a policy setting disabled Windows Installer patching.|  
|0x80241004|WU\_E\_MSI\_WRONG\_APP\_CONTEXT|An update could not be applied because the application is installed per\-user.|  
|0x80241FFF|WU\_E\_MSP\_UNEXPECTED|Search may have missed some updates because there was a failure of Windows Installer.|  
|0x80242000|WU\_E\_UH\_REMOTEUNAVAILABLE|A request for a remote update handler could not be completed because no remote process is available.|  
|0x80242001|WU\_E\_UH\_LOCALONLY|A request for a remote update handler could not be completed because the handler is local only.|  
|0x80242002|WU\_E\_UH\_UNKNOWNHANDLER|A request for an update handler could not be completed because the handler could not be recognized.|  
|0x80242003|WU\_E\_UH\_REMOTEALREADYACTIVE|A remote update handler could not be created because one already exists.|  
|0x80242004|WU\_E\_UH\_DOESNOTSUPPORTACTION|A request for the handler to install \(uninstall\) an update could not be completed because the update does not support install \(uninstall\).|  
|0x80242005|WU\_E\_UH\_WRONGHANDLER|An operation did not complete because the wrong handler was specified.|  
|0x80242006|WU\_E\_UH\_INVALIDMETADATA|A handler operation could not be completed because the update contains invalid metadata.|  
|0x80242007|WU\_E\_UH\_INSTALLERHUNG|An operation could not be completed because the installer exceeded the time limit.|  
|0x80242008|WU\_E\_UH\_OPERATIONCANCELLED|An operation being done by the update handler was cancelled.|  
|0x80242009|WU\_E\_UH\_BADHANDLERXML|An operation could not be completed because the handler\-specific metadata is invalid.|  
|0x8024200A|WU\_E\_UH\_CANREQUIREINPUT|A request to the handler to install an update could not be completed because the update requires user input.|  
|0x8024200B|WU\_E\_UH\_INSTALLERFAILURE|The installer failed to install \(uninstall\) one or more updates.|  
|0x8024200C|WU\_E\_UH\_FALLBACKTOSELFCONTAINED|The update handler should download self\-contained content rather than delta\-compressed content for the update.|  
|0x8024200D|WU\_E\_UH\_NEEDANOTHERDOWNLOAD|The update handler did not install the update because the update needs to be downloaded again.|  
|0x8024200E|WU\_E\_UH\_NOTIFYFAILURE|The update handler failed to send notification of the status of the install \(uninstall\) operation.|  
|0x8024200F|WU\_E\_UH\_INCONSISTENT\_FILE\_NAMES|The file names in the update metadata are inconsistent with the file names in the update package.|  
|0x80242010|WU\_E\_UH\_FALLBACKERROR|The update handler failed to fall back to the self\-contained content.|  
|0x80242011|WU\_E\_UH\_TOOMANYDOWNLOADREQUESTS|The update handler has exceeded the maximum number of download requests.|  
|0x80242012|WU\_E\_UH\_UNEXPECTEDCBSRESPONSE|The update handler has received an unexpected response from CBS.|  
|0x80242013|WU\_E\_UH\_BADCBSPACKAGEID|The update metadata contains an invalid CBS package identifier.|  
|0x80242014|WU\_E\_UH\_POSTREBOOTSTILLPENDING|The post\-reboot operation for the update is still in progress.|  
|0x80242015|WU\_E\_UH\_POSTREBOOTRESULTUNKNOWN|The result of the post\-reboot operation for the update could not be determined.|  
|0x80242016|WU\_E\_UH\_POSTREBOOTUNEXPECTEDSTATE|The state of the update after its post\-reboot operation has completed is unexpectedly.|  
|0x80242017|WU\_E\_UH\_NEW\_SERVICING\_STACK\_REQUIRED|The operating system servicing stack must be updated before this update is downloaded or installed.|  
|0x80242FFF|WU\_E\_UH\_UNEXPECTED|This update handler error is not covered by another WU\_E\_UH\_\* code.|  
|0x80243001|WU\_E\_INSTALLATION\_RESULTS\_UNKNOWN\_VERSION|The results of the download and installation could not be read in the registry due to an unrecognized data format version.|  
|0x80243002|WU\_E\_INSTALLATION\_RESULTS\_INVALID\_DATA|The results of download and installation could not be read in the registry due to an invalid data format.|  
|0x80243003|WU\_E\_INSTALLATION\_RESULTS\_NOT\_FOUND|The results of download and installation are not available; the operation may have failed to start.|  
|0x80243004|WU\_E\_TRAYICON\_FAILURE|A failure occurred when trying to create an icon in the notification area.|  
|0x80243FFD|WU\_E\_NON\_UI\_MODE|Unable to show the user interface \(UI\) when in a non\-UI mode; Windows Update \(WU\) client UI modules may not be installed.|  
|0x80243FFE|WU\_E\_WUCLTUI\_UNSUPPORTED\_VERSION|Unsupported version of WU client UI exported functions.|  
|0x80243FFF|WU\_E\_AUCLIENT\_UNEXPECTED|There was a user interface error not covered by another WU\_E\_AUCLIENT\_\* error code.|  
|0x80244000|WU\_E\_PT\_SOAPCLIENT\_BASE|WU\_E\_PT\_SOAPCLIENT\_\* error codes map to the SOAPCLIENT\_ERROR enum of the ATL Server Library.|  
|0x80244001|WU\_E\_PT\_SOAPCLIENT\_INITIALIZE|Initialization of the SOAP client failed, possibly because of an MSXML installation failure.|  
|0x80244002|WU\_E\_PT\_SOAPCLIENT\_OUTOFMEMORY|SOAP client failed because it ran out of memory.|  
|0x80244003|WU\_E\_PT\_SOAPCLIENT\_GENERATE|SOAP client failed to generate the request.|  
|0x80244004|WU\_E\_PT\_SOAPCLIENT\_CONNECT|SOAP client failed to connect to the server.|  
|0x80244005|WU\_E\_PT\_SOAPCLIENT\_SEND|SOAP client failed to send a message due to WU\_E\_WINHTTP\_\* error codes.|  
|0x80244006|WU\_E\_PT\_SOAPCLIENT\_SERVER|SOAP client failed because there was a server error.|  
|0x80244007|WU\_E\_PT\_SOAPCLIENT\_SOAPFAULT|SOAP client failed because there was a SOAP fault due to WU\_E\_PT\_SOAP\_\* error codes.|  
|0x80244008|WU\_E\_PT\_SOAPCLIENT\_PARSEFAULT|SOAP client failed to parse a SOAP fault.|  
|0x80244009|WU\_E\_PT\_SOAPCLIENT\_READ|SOAP client failed while reading the response from the server.|  
|0x8024400A|WU\_E\_PT\_SOAPCLIENT\_PARSE|SOAP client failed to parse the response from the server.|  
|0x8024400B|WU\_E\_PT\_SOAP\_VERSION|SOAP client found an unrecognizable namespace for the SOAP envelope.|  
|0x8024400C|WU\_E\_PT\_SOAP\_MUST\_UNDERSTAND|SOAP client was unable to understand a header.|  
|0x8024400D|WU\_E\_PT\_SOAP\_CLIENT|SOAP client found the message was malformed \(fix before resending\).|  
|0x8024400E|WU\_E\_PT\_SOAP\_SERVER|The SOAP message could not be processed due to a server error \(resend later\).|  
|0x8024400F|WU\_E\_PT\_WMI\_ERROR|There was an unspecified Windows Management Instrumentation \(WMI\) error.|  
|0x80244010|WU\_E\_PT\_EXCEEDED\_MAX\_SERVER\_TRIPS|The number of round trips to the server exceeded the maximum limit.|  
|0x80244011|WU\_E\_PT\_SUS\_SERVER\_NOT\_SET|WUServer policy value is missing in the registry.|  
|0x80244012|WU\_E\_PT\_DOUBLE\_INITIALIZATION|Initialization failed because the object was already initialized.|  
|0x80244013|WU\_E\_PT\_INVALID\_COMPUTER\_NAME|The computer name could not be determined.|  
|0x80244015|WU\_E\_PT\_REFRESH\_CACHE\_REQUIRED|The reply from the server indicates that the server was changed or the cookie was invalid; refresh the state of the internal cache and retry.|  
|0x80244016|WU\_E\_PT\_HTTP\_STATUS\_BAD\_REQUEST|HTTP 400 \- the server could not process the request due to invalid syntax.|  
|0x80244017|WU\_E\_PT\_HTTP\_STATUS\_DENIED|HTTP 401 \- the requested resource requires user authentication.|  
|0x80244018|WU\_E\_PT\_HTTP\_STATUS\_FORBIDDEN|HTTP 403 \- server understood the request, but declined to fulfill it.|  
|0x80244019|WU\_E\_PT\_HTTP\_STATUS\_NOT\_FOUND|HTTP 404 \- the server cannot find the requested Uniform Resource Identifier \(URI\).|  
|0x8024401A|WU\_E\_PT\_HTTP\_STATUS\_BAD\_METHOD|HTTP 405 \- the HTTP method is not allowed.|  
|0x8024401B|WU\_E\_PT\_HTTP\_STATUS\_PROXY\_AUTH\_REQ|HTTP 407 \- proxy authentication is required.|  
|0x8024401C|WU\_E\_PT\_HTTP\_STATUS\_REQUEST\_TIMEOUT|HTTP 408 \- the server timed out waiting for the request.|  
|0x8024401D|WU\_E\_PT\_HTTP\_STATUS\_CONFLICT|HTTP 409 \- the request was not completed due to a conflict with the current state of the resource.|  
|0x8024401E|WU\_E\_PT\_HTTP\_STATUS\_GONE|HTTP 410 \- the requested resource is no longer available at the server.|  
|0x8024401F|WU\_E\_PT\_HTTP\_STATUS\_SERVER\_ERROR|HTTP 500 \- an error internal to the server prevented fulfilling the request.|  
|0x80244020|WU\_E\_PT\_HTTP\_STATUS\_NOT\_SUPPORTED|HTTP 501 \- server does not support the functionality that is required to fulfill the request.|  
|0x80244021|WU\_E\_PT\_HTTP\_STATUS\_BAD\_GATEWAY|HTTP 502 \- the server, while acting as a gateway or proxy, received an invalid response from the upstream server it accessed when attempting to fulfill the request.|  
|0x80244022|WU\_E\_PT\_HTTP\_STATUS\_SERVICE\_UNAVAIL|HTTP 503 \- the service is temporarily overloaded.|  
|0x80244023|WU\_E\_PT\_HTTP\_STATUS\_GATEWAY\_TIMEOUT|HTTP 504 \- the request was timed out waiting for a gateway.|  
|0x80244024|WU\_E\_PT\_HTTP\_STATUS\_VERSION\_NOT\_SUP|HTTP 505 \- the server does not support the HTTP protocol version used for the request.|  
|0x80244025|WU\_E\_PT\_FILE\_LOCATIONS\_CHANGED|Operation failed due to a changed file location; refresh internal state and resend.|  
|0x80244026|WU\_E\_PT\_REGISTRATION\_NOT\_SUPPORTED|Operation failed because Windows Update Agent does not support registration with a non\-WSUS server.|  
|0x80244027|WU\_E\_PT\_NO\_AUTH\_PLUGINS\_REQUESTED|The server returned an empty authentication information list.|  
|0x80244028|WU\_E\_PT\_NO\_AUTH\_COOKIES\_CREATED|Windows Update Agent was unable to create any valid authentication cookies.|  
|0x80244029|WU\_E\_PT\_INVALID\_CONFIG\_PROP|A configuration property value was wrong.|  
|0x8024402A|WU\_E\_PT\_CONFIG\_PROP\_MISSING|A configuration property value was missing.|  
|0x8024402B|WU\_E\_PT\_HTTP\_STATUS\_NOT\_MAPPED|The HTTP request could not be completed and the reason did not correspond to any of the WU\_E\_PT\_HTTP\_\* error codes.|  
|0x8024402C|WU\_E\_PT\_WINHTTP\_NAME\_NOT\_RESOLVED|The proxy server or target server name cannot be resolved.|  
|0x8024402F|WU\_E\_PT\_ECP\_SUCCEEDED\_WITH\_ERRORS|External .cab file processing completed with some errors.|  
|0x80244030|WU\_E\_PT\_ECP\_INIT\_FAILED|The external .cab file processor initialization did not complete.|  
|0x80244031|WU\_E\_PT\_ECP\_INVALID\_FILE\_FORMAT|The format of a metadata file was invalid.|  
|0x80244032|WU\_E\_PT\_ECP\_INVALID\_METADATA|External .cab file processor found invalid metadata.|  
|0x80244033|WU\_E\_PT\_ECP\_FAILURE\_TO\_EXTRACT\_DIGEST|The file digest could not be extracted from an external .cab file.|  
|0x80244034|WU\_E\_PT\_ECP\_FAILURE\_TO\_DECOMPRESS\_CAB\_FILE|An external .cab file could not be decompressed.|  
|0x80244035|WU\_E\_PT\_ECP\_FILE\_LOCATION\_ERROR|External .cab processor was unable to get file locations.|  
|0x80244FFF|WU\_E\_PT\_UNEXPECTED|There was a communication error not covered by another WU\_E\_PT\_\* error code|  
|0x80245001|WU\_E\_REDIRECTOR\_LOAD\_XML|The redirector XML document could not be loaded into the Document Object Model \(DOM\) class.|  
|0x80245002|WU\_E\_REDIRECTOR\_S\_FALSE|The redirector XML document is missing some required information.|  
|0x80245003|WU\_E\_REDIRECTOR\_ID\_SMALLER|The redirector ID in the downloaded redirector .cab file is less than in the cached .cab file.|  
|0x8024502D|WU\_E\_PT\_SAME\_REDIR\_ID|Windows Update Agent failed to download a redirector .cab file with a new redirector ID value from the server during the recovery.|  
|0x8024502E|WU\_E\_PT\_NO\_MANAGED\_RECOVER|A redirector recovery action did not complete because the server is managed.|  
|0x80245FFF|WU\_E\_REDIRECTOR\_UNEXPECTED|The redirector failed for reasons not covered by another WU\_E\_REDIRECTOR\_\* error code.|  
|0x80246001|WU\_E\_DM\_URLNOTAVAILABLE|A download manager operation could not be completed because the requested file does not have a URL.|  
|0x80246002|WU\_E\_DM\_INCORRECTFILEHASH|A download manager operation could not be completed because the file digest was not recognized.|  
|0x80246003|WU\_E\_DM\_UNKNOWNALGORITHM|A download manager operation could not be completed because the file metadata requested an unrecognized hash algorithm.|  
|0x80246004|WU\_E\_DM\_NEEDDOWNLOADREQUEST|An operation could not be completed because a download request is required from the download handler.|  
|0x80246005|WU\_E\_DM\_NONETWORK|A download manager operation could not be completed because the network connection was unavailable.|  
|0x80246006|WU\_E\_DM\_WRONGBITSVERSION|A download manager operation could not be completed because the version of Background Intelligent Transfer Service \(BITS\) is incompatible.|  
|0x80246007|WU\_E\_DM\_NOTDOWNLOADED|The update has not been downloaded.|  
|0x80246008|WU\_E\_DM\_FAILTOCONNECTTOBITS|A download manager operation failed because the download manager was unable to connect the Background Intelligent Transfer Service \(BITS\).|  
|0x80246009|WU\_E\_DM\_BITSTRANSFERERROR|A download manager operation failed because there was an unspecified Background Intelligent Transfer Service \(BITS\) transfer error.|  
|0x8024600a|WU\_E\_DM\_DOWNLOADLOCATIONCHANGED|A download must be restarted because the location of the source of the download has changed.|  
|0x8024600B|WU\_E\_DM\_CONTENTCHANGED|A download must be restarted because the update content changed in a new revision.|  
|0x80246FFF|WU\_E\_DM\_UNEXPECTED|There was a download manager error not covered by another WU\_E\_DM\_\* error code.|  
|0x80247001|WU\_E\_OL\_INVALID\_SCANFILE|An operation could not be completed because the scan package was invalid.|  
|0x80247002|WU\_E\_OL\_NEWCLIENT\_REQUIRED|An operation could not be completed because the scan package requires a greater version of the Windows Update Agent.|  
|0x80247FFF|WU\_E\_OL\_UNEXPECTED|Search using the scan package failed.|  
|0x80248000|WU\_E\_DS\_SHUTDOWN|An operation failed because Windows Update Agent is shutting down.|  
|0x80248001|WU\_E\_DS\_INUSE|An operation failed because the data store was in use.|  
|0x80248002|WU\_E\_DS\_INVALID|The current and expected states of the data store do not match.|  
|0x80248003|WU\_E\_DS\_TABLEMISSING|The data store is missing a table.|  
|0x80248004|WU\_E\_DS\_TABLEINCORRECT|The data store contains a table with unexpected columns.|  
|0x80248005|WU\_E\_DS\_INVALIDTABLENAME|A table could not be opened because the table is not in the data store.|  
|0x80248006|WU\_E\_DS\_BADVERSION|The current and expected versions of the data store do not match.|  
|0x80248007|WU\_E\_DS\_NODATA|The information requested is not in the data store.|  
|0x80248008|WU\_E\_DS\_MISSINGDATA|The data store is missing required information or has a null value in a table column that requires a non\-null value.|  
|0x80248009|WU\_E\_DS\_MISSINGREF|The data store is missing required information or has a reference to missing license terms, a file, a localized property, or a linked row.|  
|0x8024800A|WU\_E\_DS\_UNKNOWNHANDLER|The update was not processed because its update handler could not be recognized.|  
|0x8024800B|WU\_E\_DS\_CANTDELETE|The update was not deleted because it is still referenced by one or more services.|  
|0x8024800C|WU\_E\_DS\_LOCKTIMEOUTEXPIRED|The data store section could not be locked within the allotted time.|  
|0x8024800D|WU\_E\_DS\_NOCATEGORIES|The category was not added because it contains no parent categories, and it is not a top\-level category.|  
|0x8024800E|WU\_E\_DS\_ROWEXISTS|The row was not added because an existing row has the same primary key.|  
|0x8024800F|WU\_E\_DS\_STOREFILELOCKED|The data store could not be initialized because it was locked by another process.|  
|0x80248010|WU\_E\_DS\_CANNOTREGISTER|The data store is not allowed to be registered with COM in the current process.|  
|0x80248011|WU\_E\_DS\_UNABLETOSTART|Could not create a data store object in another process.|  
|0x80248013|WU\_E\_DS\_DUPLICATEUPDATEID|The server sent the same update to the client computer, with two different revision IDs.|  
|0x80248014|WU\_E\_DS\_UNKNOWNSERVICE|An operation did not complete because the service is not in the data store.|  
|0x80248015|WU\_E\_DS\_SERVICEEXPIRED|An operation did not complete because the registration of the service has expired.|  
|0x80248016|WU\_E\_DS\_DECLINENOTALLOWED|A request to hide an update was declined because it is a mandatory update or because it was deployed with a deadline.|  
|0x80248017|WU\_E\_DS\_TABLESESSIONMISMATCH|A table was not closed because it is not associated with the session.|  
|0x80248018|WU\_E\_DS\_SESSIONLOCKMISMATCH|A table was not closed because it is not associated with the session.|  
|0x80248019|WU\_E\_DS\_NEEDWINDOWSSERVICE|A request to remove the Windows Update service or to unregister it with Automatic Updates was declined because it is a built\-in service and Automatic Updates cannot fall back to another service.|  
|0x8024801A|WU\_E\_DS\_INVALIDOPERATION|A request was declined because the operation is not allowed.|  
|0x8024801B|WU\_E\_DS\_SCHEMAMISMATCH|The schema of the current data store and the schema of a table in a backup XML document do not match.|  
|0x8024801C|WU\_E\_DS\_RESETREQUIRED|The data store requires a session reset; release the session and retry with a new session.|  
|0x8024801D|WU\_E\_DS\_IMPERSONATED|A data store operation did not complete because it was requested with an impersonated identity.|  
|0x80248FFF|WU\_E\_DS\_UNEXPECTED|There was a data store error not covered by another WU\_E\_DS\_\* code.|  
|0x80249001|WU\_E\_INVENTORY\_PARSEFAILED|Parsing of the rule file failed.|  
|0x80249002|WU\_E\_INVENTORY\_GET\_INVENTORY\_TYPE\_FAILED|Failed to get the requested inventory type from the server.|  
|0x80249003|WU\_E\_INVENTORY\_RESULT\_UPLOAD\_FAILED|Failed to upload inventory result to the server.|  
|0x80249004|WU\_E\_INVENTORY\_UNEXPECTED|There was an inventory error not covered by another error code.|  
|0x80249005|WU\_E\_INVENTORY\_WMI\_ERROR|A WMI error occurred when enumerating the instances for a particular class.|  
|0x8024A000|WU\_E\_AU\_NOSERVICE|Automatic Updates was unable to service incoming requests.|  
|0x8024A002|WU\_E\_AU\_NONLEGACYSERVER|The old version of Automatic Updates has stopped because the WSUS server has been upgraded.|  
|0x8024A003|WU\_E\_AU\_LEGACYCLIENTDISABLED|The old version of Automatic Updates was disabled.|  
|0x8024A004|WU\_E\_AU\_PAUSED|Automatic Updates was unable to process incoming requests because it was paused.|  
|0x8024A005|WU\_E\_AU\_NO\_REGISTERED\_SERVICE|No unmanaged service is registered with AU.|  
|0x8024AFFF|WU\_E\_AU\_UNEXPECTED|There was an Automatic Updates error not covered by another WU\_E\_AU \* code.|  
|0x8024C001|WU\_E\_DRV\_PRUNED|A driver was skipped.|  
|0x8024C002|WU\_E\_DRV\_NOPROP\_OR\_LEGACY|A property for the driver could not be found. It may not conform with required specifications.|  
|0x8024C003|WU\_E\_DRV\_REG\_MISMATCH|The registry type read for the driver does not match the expected type.|  
|0x8024C004|WU\_E\_DRV\_NO\_METADATA|The driver update is missing metadata.|  
|0x8024C005|WU\_E\_DRV\_MISSING\_ATTRIBUTE|The driver update is missing a required attribute.|  
|0x8024C006|WU\_E\_DRV\_SYNC\_FAILED|Driver synchronization failed.|  
|0x8024C007|WU\_E\_DRV\_NO\_PRINTER\_CONTENT|Information required for the synchronization of applicable printers is missing.|  
|0x8024CFFF|WU\_E\_DRV\_UNEXPECTED|There was a driver error not covered by another WU\_E\_DRV\_\* code.|  
|0x8024D001|WU\_E\_SETUP\_INVALID\_INFDATA|Windows Update Agent could not be updated because an .inf file contains invalid information.|  
|0x8024D002|WU\_E\_SETUP\_INVALID\_IDENTDATA|Windows Update Agent could not be updated because the wuident.cab file contains invalid information.|  
|0x8024D003|WU\_E\_SETUP\_ALREADY\_INITIALIZED|Windows Update Agent could not be updated because of an internal error that caused setup initialization to be performed twice.|  
|0x8024D004|WU\_E\_SETUP\_NOT\_INITIALIZED|Windows Update Agent could not be updated because setup initialization never completed successfully.|  
|0x8024D005|WU\_E\_SETUP\_SOURCE\_VERSION\_MISMATCH|Windows Update Agent could not be updated because the versions specified in the .inf file do not match the actual source file versions.|  
|0x8024D006|WU\_E\_SETUP\_TARGET\_VERSION\_GREATER|Windows Update Agent could not be updated because a Windows Update Agent file on the target system is newer than the corresponding source file.|  
|0x8024D007|WU\_E\_SETUP\_REGISTRATION\_FAILED|Windows Update Agent could not be updated because regsvr32.exe returned an error.|  
|0x8024D008|WU\_E\_SELFUPDATE\_SKIP\_ON\_FAILURE|An update to the Windows Update Agent was skipped because previous attempts to update failed.|  
|0x8024D009|WU\_E\_SETUP\_SKIP\_UPDATE|An update to the Windows Update Agent was skipped due to a directive in the wuident.cab file.|  
|0x8024D00A|WU\_E\_SETUP\_UNSUPPORTED\_CONFIGURATION|Windows Update Agent could not be updated because the current system configuration is not supported.|  
|0x8024D00B|WU\_E\_SETUP\_BLOCKED\_CONFIGURATION|Windows Update Agent could not be updated because the system is configured to block the update.|  
|0x8024D00C|WU\_E\_SETUP\_REBOOT\_TO\_FIX|Windows Update Agent could not be updated because a restart of the system is required.|  
|0x8024D00D|WU\_E\_SETUP\_ALREADYRUNNING|Windows Update Agent setup is already running.|  
|0x8024D00E|WU\_E\_SETUP\_REBOOTREQUIRED|Windows Update Agent setup package requires a reboot to complete installation.|  
|0x8024D00F|WU\_E\_SETUP\_HANDLER\_EXEC\_FAILURE|Windows Update Agent could not be updated because the setup handler failed when it was run.|  
|0x8024D010|WU\_E\_SETUP\_INVALID\_REGISTRY\_DATA|Windows Update Agent could not be updated because the registry contains invalid information.|  
|0x8024D011|WU\_E\_SELFUPDATE\_REQUIRED|Windows Update Agent must be updated before search can continue.|  
|0x8024D012|WU\_E\_SELFUPDATE\_REQUIRED\_ADMIN|Windows Update Agent must be updated before search can continue. An administrator is required to perform the operation.|  
|0x8024D013|WU\_E\_SETUP\_WRONG\_SERVER\_VERSION|Windows Update Agent could not be updated because the server does not contain update information for this version.|  
|0x8024DFFF|WU\_E\_SETUP\_UNEXPECTED|Windows Update Agent could not be updated because of an error not covered by another WU\_E\_SETUP\_\* error code.|  
|0x8024E001|WU\_E\_EE\_UNKNOWN\_EXPRESSION|An expression evaluator operation could not be completed because an expression was unrecognized.|  
|0x8024E002|WU\_E\_EE\_INVALID\_EXPRESSION|An expression evaluator operation could not be completed because an expression was invalid.|  
|0x8024E003|WU\_E\_EE\_MISSING\_METADATA|An expression evaluator operation could not be completed because an expression contains an incorrect number of metadata nodes.|  
|0x8024E004|WU\_E\_EE\_INVALID\_VERSION|An expression evaluator operation could not be completed because the version of the serialized expression data is invalid.|  
|0x8024E005|WU\_E\_EE\_NOT\_INITIALIZED|The expression evaluator could not be initialized.|  
|0x8024E006|WU\_E\_EE\_INVALID\_ATTRIBUTEDATA|An expression evaluator operation could not be completed because there was an invalid attribute.|  
|0x8024E007|WU\_E\_EE\_CLUSTER\_ERROR|An expression evaluator operation could not be completed because the cluster state of the computer could not be determined.|  
|0x8024EFFF|WU\_E\_EE\_UNEXPECTED|There was an expression evaluator error not covered by another WU\_E\_EE\_\* error code.|  
|0x8024F001|WU\_E\_REPORTER\_EVENTCACHECORRUPT|The event cache file was defective.|  
|0x8024F002|WU\_E\_REPORTER\_<br /><br />EVENTNAMESPACEPARSEFAILED|The XML in the event namespace descriptor could not be parsed.|  
|0x8024F003|WU\_E\_INVALID\_EVENT|The XML in the event namespace descriptor could not be parsed.|  
|0x8024F004|WU\_E\_SERVER\_BUSY|The server rejected an event because the server was too busy.|  
|0x8024FFFF|WU\_E\_REPORTER\_UNEXPECTED|There was a reporter error not covered by another error code.|  
  
