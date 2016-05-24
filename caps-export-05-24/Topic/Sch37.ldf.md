---
title: Sch37.ldf
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: d4184f60-28aa-4c7f-93a6-ea58367576ff
author: Femila
---
# Sch37.ldf
  dn: CN\=ms\-DS\-User\-Password\-Expiry\-Time\-Computed,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-UserPasswordExpiryTimeComputed  
  
 adminDisplayName: ms\-DS\-User\-Password\-Expiry\-Time\-Computed  
  
 adminDescription: Contains the expiry time for the user's current password  
  
 attributeId: 1.2.840.113556.1.4.1996  
  
 attributeSyntax: 2.5.5.16  
  
 omSyntax: 65  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 schemaIdGuid:: EM\/VrQl7SUSa5iU0FI\+Kcg\=\=  
  
 attributeSecurityGuid:: AEIWTMAg0BGnaACqAG4FKQ\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 20  
  
 dn: CN\=ms\-DS\-Principal\-Name,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDS\-PrincipalName  
  
 adminDisplayName: ms\-DS\-Principal\-Name  
  
 adminDescription: Account name for the security principal \(constructed\)  
  
 attributeId: 1.2.840.113556.1.4.1865  
  
 attributeSyntax: 2.5.5.12  
  
 omSyntax: 64  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 schemaIdGuid:: JZNOVlfQQ8GeO0\+eXvRvkw\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 20  
  
 dn: CN\=ms\-DFSR\-OnDemandExclusionDirectoryFilter,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDFSR\-OnDemandExclusionDirectoryFilter  
  
 adminDisplayName: DFSR\-OnDemandExclusionDirectoryFilter  
  
 adminDescription: Filter string applied to on demand replication directories  
  
 attributeId: 1.2.840.113556.1.6.13.3.36  
  
 attributeSyntax: 2.5.5.12  
  
 omSyntax: 64  
  
 isSingleValued: TRUE  
  
 searchFlags: 0  
  
 rangeLower: 0  
  
 rangeUpper: 32767  
  
 schemaIdGuid:: \/zpSfRKQskmZJfkioAGGVg\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 dn: CN\=ms\-DFSR\-DefaultCompressionExclusionFilter,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDFSR\-DefaultCompressionExclusionFilter  
  
 adminDisplayName: DFSR\-DefaultCompressionExclusionFilter  
  
 adminDescription: Filter string containing extensions of file types not to be compressed  
  
 attributeId: 1.2.840.113556.1.6.13.3.34  
  
 attributeSyntax: 2.5.5.12  
  
 omSyntax: 64  
  
 isSingleValued: TRUE  
  
 searchFlags: 0  
  
 rangeLower: 0  
  
 rangeUpper: 32767  
  
 schemaIdGuid:: 1RuBh4vNy0WfXZgPOp4Mlw\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 dn: CN\=ms\-TS\-Home\-Drive,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msTSHomeDrive  
  
 adminDisplayName: ms\-TS\-Home\-Drive  
  
 adminDescription: Terminal Services Home Drive specifies a Home drive for the user. In a network environment, this property is a string containing a drive specification \(a drive letter followed by a colon\) to which the UNC path specified in the TerminalServicesHomeDirectory property is mapped. To set a home directory in a network environment, you must first set this property and then set the TerminalServicesHomeDirectory property.  
  
 attributeId: 1.2.840.113556.1.4.1978  
  
 attributeSyntax: 2.5.5.12  
  
 omSyntax: 64  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 rangeLower: 0  
  
 rangeUpper: 32767  
  
 schemaIdGuid:: 2SQKX\/rf2Uysv6BoDANzHg\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=MS\-TS\-Property01,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msTSProperty01  
  
 adminDisplayName: MS\-TS\-Property01  
  
 adminDescription: Placeholder Terminal Server Property 01  
  
 attributeId: 1.2.840.113556.1.4.1991  
  
 attributeSyntax: 2.5.5.12  
  
 omSyntax: 64  
  
 isSingleValued: FALSE  
  
 systemOnly: FALSE  
  
 searchFlags: 1  
  
 rangeLower: 0  
  
 rangeUpper: 32767  
  
 schemaIdGuid:: d6mu\+lWW10mFPfJ7t6rKDw\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=MS\-TS\-Property02,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msTSProperty02  
  
 adminDisplayName: MS\-TS\-Property02  
  
 adminDescription: Placeholder Terminal Server Property 02  
  
 attributeId: 1.2.840.113556.1.4.1992  
  
 attributeSyntax: 2.5.5.12  
  
 omSyntax: 64  
  
 isSingleValued: FALSE  
  
 systemOnly: FALSE  
  
 searchFlags: 1  
  
 rangeLower: 0  
  
 rangeUpper: 32767  
  
 schemaIdGuid:: rPaGNbdReEmrQvk2RjGY5w\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-TS\-Allow\-Logon,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msTSAllowLogon  
  
 adminDisplayName: ms\-TS\-Allow\-Logon  
  
 adminDescription: Terminal Services Allow Logon specifies whether the user is allowed to log on to the Terminal Server. The value is 1 if logon is allowed, and 0 if logon is not allowed.  
  
 attributeId: 1.2.840.113556.1.4.1979  
  
 attributeSyntax: 2.5.5.8  
  
 omSyntax: 1  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 schemaIdGuid:: ZNQMOlS850CTrqZGpuzEtA\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=MS\-TS\-ExpireDate,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msTSExpireDate  
  
 adminDisplayName: MS\-TS\-ExpireDate  
  
 adminDescription: TS Expiration Date  
  
 attributeId: 1.2.840.113556.1.4.1993  
  
 attributeSyntax: 2.5.5.11  
  
 omSyntax: 24  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 1  
  
 schemaIdGuid:: 9U4AcMMlakSXyJlq6FZndg\=\=  
  
 showInAdvancedViewOnly: FALSE  
  
 systemFlags: 16  
  
 dn: CN\=MS\-TS\-ManagingLS,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msTSManagingLS  
  
 adminDisplayName: MS\-TS\-ManagingLS  
  
 adminDescription: TS Managing License Server  
  
 attributeId: 1.2.840.113556.1.4.1995  
  
 attributeSyntax: 2.5.5.12  
  
 omSyntax: 64  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 1  
  
 schemaIdGuid:: R8W887CFLEOawDBFBr8sgw\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DFSR\-Options2,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDFSR\-Options2  
  
 adminDisplayName: DFSR\-Options2  
  
 adminDescription: Object Options2  
  
 attributeId: 1.2.840.113556.1.6.13.3.37  
  
 attributeSyntax: 2.5.5.9  
  
 omSyntax: 2  
  
 isSingleValued: TRUE  
  
 searchFlags: 0  
  
 schemaIdGuid:: GEPiEaZMSU\+a\/uXrGvo0cw\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 dn: CN\=ms\-TS\-Profile\-Path,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msTSProfilePath  
  
 adminDisplayName: ms\-TS\-Profile\-Path  
  
 adminDescription: Terminal Services Profile Path specifies a roaming or mandatory profile path to use when the user logs on to the Terminal Server. The profile path is in the following network path format: \\\\servername\\profiles folder name\\username  
  
 attributeId: 1.2.840.113556.1.4.1976  
  
 attributeSyntax: 2.5.5.12  
  
 omSyntax: 64  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 rangeLower: 0  
  
 rangeUpper: 32767  
  
 schemaIdGuid:: 2zBc5mwxYECjoDh7CD8JzQ\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-TS\-Max\-Idle\-Time,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msTSMaxIdleTime  
  
 adminDisplayName: ms\-TS\-Max\-Idle\-Time  
  
 adminDescription: Terminal Services Session Maximum Idle Time is maximum amount of time, in minutes, that the Terminal Services session can remain idle. After the specified number of minutes have elapsed, the session can be disconnected or terminated.  
  
 attributeId: 1.2.840.113556.1.4.1983  
  
 attributeSyntax: 2.5.5.9  
  
 omSyntax: 2  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 schemaIdGuid:: nJ5z\/7drDkayIeJQ894PlQ\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-TS\-Home\-Directory,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msTSHomeDirectory  
  
 adminDisplayName: ms\-TS\-Home\-Directory  
  
 adminDescription: Terminal Services Home Directory specifies the Home directory for the user. Each user on a Terminal Server has a unique home directory. This ensures that application information is stored separately for each user in a multi\-user environment. To set a home directory on the local computer, specify a local path; for example, C:\\Path. To set a home directory in a network environment, you must first set the TerminalServicesHomeDrive property, and then set this property to a UNC path.  
  
 attributeId: 1.2.840.113556.1.4.1977  
  
 attributeSyntax: 2.5.5.12  
  
 omSyntax: 64  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 rangeLower: 0  
  
 rangeUpper: 32767  
  
 schemaIdGuid:: 8BA1XefEIkG5H6IK3ZDiRg\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-TS\-Remote\-Control,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msTSRemoteControl  
  
 adminDisplayName: ms\-TS\-Remote\-Control  
  
 adminDescription: Terminal Services Remote Control specifies the whether to allow remote observation or remote control of the user's Terminal Services session. For a description of these values, see the RemoteControl method of the Win32\_TSRemoteControlSetting WMI class. 0 \- Disable, 1 \- EnableInputNotify, 2 \- EnableInputNoNotify, 3 \- EnableNoInputNotify and 4 \- EnableNoInputNoNotify  
  
 attributeId: 1.2.840.113556.1.4.1980  
  
 attributeSyntax: 2.5.5.9  
  
 omSyntax: 2  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 schemaIdGuid:: JnIXFUKGi0aMSAPd\/QBJgg\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-TS\-Work\-Directory,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msTSWorkDirectory  
  
 adminDisplayName: ms\-TS\-Work\-Directory  
  
 adminDescription: Terminal Services Session Work Directory specifies the working directory path for the user. To set an initial application to start when the user logs on to the Terminal Server, you must first set the TerminalServicesInitialProgram property, and then set this property.  
  
 attributeId: 1.2.840.113556.1.4.1989  
  
 attributeSyntax: 2.5.5.12  
  
 omSyntax: 64  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 rangeLower: 0  
  
 rangeUpper: 32767  
  
 schemaIdGuid:: ZvZEpzw9yEyDS51Pb2h7iw\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-TS\-Initial\-Program,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msTSInitialProgram  
  
 adminDisplayName: ms\-TS\-Initial\-Program  
  
 adminDescription: Terminal Services Session Initial Program specifies the Path and file name of the application that the user wants to start automatically when the user logs on to the Terminal Server. To set an initial application to start when the user logs on, you must first set this property and then set the TerminalServicesWorkDirectory property. If you set only the TerminalServicesInitialProgram property, the application starts in the user's session in the default user directory.  
  
 attributeId: 1.2.840.113556.1.4.1990  
  
 attributeSyntax: 2.5.5.12  
  
 omSyntax: 64  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 rangeLower: 0  
  
 rangeUpper: 32767  
  
 schemaIdGuid:: b6wBkmkd\+02ALtlVEBCVmQ\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=MS\-TS\-LicenseVersion,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msTSLicenseVersion  
  
 adminDisplayName: MS\-TS\-LicenseVersion  
  
 adminDescription: TS License Version  
  
 attributeId: 1.2.840.113556.1.4.1994  
  
 attributeSyntax: 2.5.5.12  
  
 omSyntax: 64  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 1  
  
 schemaIdGuid:: iUrpCi838k2uisZKK8RyeA\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-TS\-Max\-Connection\-Time,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msTSMaxConnectionTime  
  
 adminDisplayName: ms\-TS\-Max\-Connection\-Time  
  
 adminDescription: Terminal Services Session maximum Connection Time is Maximum duration, in minutes, of the Terminal Services session. After the specified number of minutes have elapsed, the session can be disconnected or terminated.  
  
 attributeId: 1.2.840.113556.1.4.1982  
  
 attributeSyntax: 2.5.5.9  
  
 omSyntax: 2  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 schemaIdGuid:: 4g6WHWRklU6ngeO1zV\+ViA\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-TS\-Reconnection\-Action,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msTSReconnectionAction  
  
 adminDisplayName: ms\-TS\-Reconnection\-Action  
  
 adminDescription: Terminal Services Session Reconnection Action specifies whether to allow reconnection to a disconnected Terminal Services session from any client computer. The value is 1 if reconnection is allowed from the original client computer only, and 0 if reconnection from any client computer is allowed.  
  
 attributeId: 1.2.840.113556.1.4.1984  
  
 attributeSyntax: 2.5.5.8  
  
 omSyntax: 1  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 schemaIdGuid:: ytduNhg\+f0yrrjUaAeS09w\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-TS\-Connect\-Client\-Drives,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msTSConnectClientDrives  
  
 adminDisplayName: ms\-TS\-Connect\-Client\-Drives  
  
 adminDescription: Terminal Services Session Connect Client Drives At Logon specifies whether to reconnect to mapped client drives at logon. The value is 1 if reconnection is enabled, and 0 if reconnection is disabled.  
  
 attributeId: 1.2.840.113556.1.4.1986  
  
 attributeSyntax: 2.5.5.8  
  
 omSyntax: 1  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 schemaIdGuid:: rypXI90p6kSw\+n6EOLmkow\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DFSR\-CommonStagingPath,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDFSR\-CommonStagingPath  
  
 adminDisplayName: DFSR\-CommonStagingPath  
  
 adminDescription: Full path of the common staging directory  
  
 attributeId: 1.2.840.113556.1.6.13.3.38  
  
 attributeSyntax: 2.5.5.12  
  
 omSyntax: 64  
  
 isSingleValued: TRUE  
  
 searchFlags: 0  
  
 rangeLower: 0  
  
 rangeUpper: 32767  
  
 schemaIdGuid:: Qaxuk1fSuUu9VfMQo88JrQ\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 dn: CN\=ms\-TS\-Max\-Disconnection\-Time,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msTSMaxDisconnectionTime  
  
 adminDisplayName: ms\-TS\-Max\-Disconnection\-Time  
  
 adminDescription: Terminal Services Session Maximum Disconnection Time is maximum amount of time, in minutes, that a disconnected Terminal Services session remains active on the Terminal Server. After the specified number of minutes have elapsed, the session is terminated.  
  
 attributeId: 1.2.840.113556.1.4.1981  
  
 attributeSyntax: 2.5.5.9  
  
 omSyntax: 2  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 schemaIdGuid:: iXBvMthThEe4FEbYU1EQ0g\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-TS\-Default\-To\-Main\-Printer,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msTSDefaultToMainPrinter  
  
 adminDisplayName: ms\-TS\-Default\-To\-Main\-Printer  
  
 adminDescription: Terminal Services Default To Main Printer specifies whether to print automatically to the client's default printer. The value is 1 if printing to the client's default printer is enabled, and 0 if it is disabled.  
  
 attributeId: 1.2.840.113556.1.4.1988  
  
 attributeSyntax: 2.5.5.8  
  
 omSyntax: 1  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 schemaIdGuid:: veL\/wM\/Kx02I1WHp6Vdm9g\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-TS\-Connect\-Printer\-Drives,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msTSConnectPrinterDrives  
  
 adminDisplayName: ms\-TS\-Connect\-Printer\-Drives  
  
 adminDescription: Terminal Services Session Connect Printer Drives At Logon specifies whether to reconnect to mapped client printers at logon. The value is 1 if reconnection is enabled, and 0 if reconnection is disabled.  
  
 attributeId: 1.2.840.113556.1.4.1987  
  
 attributeSyntax: 2.5.5.8  
  
 omSyntax: 1  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 schemaIdGuid:: N6nmjBuHkkyyhdmdQDZoHA\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-TS\-Broken\-Connection\-Action,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msTSBrokenConnectionAction  
  
 adminDisplayName: ms\-TS\-Broken\-Connection\-Action  
  
 adminDescription: Terminal Services Session Broken Connection Action specifies the action to take when a Terminal Services session limit is reached. The value is 1 if the client session should be terminated, and 0 if the client session should be disconnected.  
  
 attributeId: 1.2.840.113556.1.4.1985  
  
 attributeSyntax: 2.5.5.8  
  
 omSyntax: 1  
  
 isSingleValued: TRUE  
  
 systemOnly: FALSE  
  
 searchFlags: 0  
  
 schemaIdGuid:: uhv0HARWPkaU1hoSh7csow\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 systemFlags: 16  
  
 dn: CN\=ms\-DFSR\-DisablePacketPrivacy,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDFSR\-DisablePacketPrivacy  
  
 adminDisplayName: DFSR\-DisablePacketPrivacy  
  
 adminDescription: Disable packet privacy on a connection  
  
 attributeId: 1.2.840.113556.1.6.13.3.32  
  
 attributeSyntax: 2.5.5.8  
  
 omSyntax: 1  
  
 isSingleValued: TRUE  
  
 searchFlags: 0  
  
 schemaIdGuid:: 5e2Eah50\/UOd1qoPYVeGIQ\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 dn: CN\=ms\-DFSR\-CommonStagingSizeInMb,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDFSR\-CommonStagingSizeInMb  
  
 adminDisplayName: DFSR\-CommonStagingSizeInMb  
  
 adminDescription: Size of the common staging directory in MB  
  
 attributeId: 1.2.840.113556.1.6.13.3.39  
  
 attributeSyntax: 2.5.5.16  
  
 omSyntax: 65  
  
 isSingleValued: TRUE  
  
 searchFlags: 0  
  
 rangeLower: 0  
  
 rangeUpper: \-1  
  
 schemaIdGuid:: DrBeE0ZIi0WOoqN1Wa\/UBQ\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 dn: CN\=ms\-DFSR\-OnDemandExclusionFileFilter,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDFSR\-OnDemandExclusionFileFilter  
  
 adminDisplayName: DFSR\-OnDemandExclusionFileFilter  
  
 adminDescription: Filter string applied to on demand replication files  
  
 attributeId: 1.2.840.113556.1.6.13.3.35  
  
 attributeSyntax: 2.5.5.12  
  
 omSyntax: 64  
  
 isSingleValued: TRUE  
  
 searchFlags: 0  
  
 rangeLower: 0  
  
 rangeUpper: 32767  
  
 schemaIdGuid:: 3FmDpoGl5k6QFVOCxg8PtA\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 dn: CN\=ms\-DFSR\-StagingCleanupTriggerInPercent,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: attributeSchema  
  
 ldapDisplayName: msDFSR\-StagingCleanupTriggerInPercent  
  
 adminDisplayName: DFSR\-StagingCleanupTriggerInPercent  
  
 adminDescription: Staging cleanup trigger in percent of free disk space  
  
 attributeId: 1.2.840.113556.1.6.13.3.40  
  
 attributeSyntax: 2.5.5.9  
  
 omSyntax: 2  
  
 isSingleValued: TRUE  
  
 searchFlags: 0  
  
 schemaIdGuid:: I5xL1vrhe0azF2lk10TWMw\=\=  
  
 showInAdvancedViewOnly: TRUE  
  
 dn: CN\=Terminal\-Server,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: searchFlags  
  
 searchFlags: 1  
  
 \-  
  
 dn: CN\=MS\-TS\-ExpireDate,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: attributeSecurityGuid  
  
 attributeSecurityGuid:: YrwFWMm9KESl4oVqD0wYXg\=\=  
  
 \-  
  
 dn: CN\=MS\-TS\-LicenseVersion,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: attributeSecurityGuid  
  
 attributeSecurityGuid:: YrwFWMm9KESl4oVqD0wYXg\=\=  
  
 \-  
  
 dn: CN\=MS\-TS\-ManagingLS,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: attributeSecurityGuid  
  
 attributeSecurityGuid:: YrwFWMm9KESl4oVqD0wYXg\=\=  
  
 \-  
  
 dn: CN\=Terminal\-Server,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: attributeSecurityGuid  
  
 attributeSecurityGuid:: YrwFWMm9KESl4oVqD0wYXg\=\=  
  
 \-  
  
 dn: CN\=ms\-DFSR\-LocalSettings,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: mayContain  
  
 mayContain: 1.2.840.113556.1.6.13.3.37  
  
 mayContain: 1.2.840.113556.1.6.13.3.38  
  
 mayContain: 1.2.840.113556.1.6.13.3.39  
  
 mayContain: 1.2.840.113556.1.6.13.3.40  
  
 \-  
  
 dn: CN\=ms\-DFSR\-Subscriber,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: mayContain  
  
 mayContain: 1.2.840.113556.1.6.13.3.37  
  
 \-  
  
 dn: CN\=ms\-DFSR\-Subscription,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: mayContain  
  
 mayContain: 1.2.840.113556.1.6.13.3.35  
  
 mayContain: 1.2.840.113556.1.6.13.3.36  
  
 mayContain: 1.2.840.113556.1.6.13.3.37  
  
 mayContain: 1.2.840.113556.1.6.13.3.40  
  
 \-  
  
 dn: CN\=ms\-DFSR\-GlobalSettings,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: mayContain  
  
 mayContain: 1.2.840.113556.1.6.13.3.37  
  
 \-  
  
 dn: CN\=ms\-DFSR\-ReplicationGroup,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: mayContain  
  
 mayContain: 1.2.840.113556.1.6.13.3.34  
  
 mayContain: 1.2.840.113556.1.6.13.3.35  
  
 mayContain: 1.2.840.113556.1.6.13.3.36  
  
 mayContain: 1.2.840.113556.1.6.13.3.37  
  
 \-  
  
 dn: CN\=ms\-DFSR\-Content,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: mayContain  
  
 mayContain: 1.2.840.113556.1.6.13.3.37  
  
 \-  
  
 dn: CN\=ms\-DFSR\-ContentSet,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: mayContain  
  
 mayContain: 1.2.840.113556.1.6.13.3.34  
  
 mayContain: 1.2.840.113556.1.6.13.3.35  
  
 mayContain: 1.2.840.113556.1.6.13.3.36  
  
 mayContain: 1.2.840.113556.1.6.13.3.37  
  
 \-  
  
 dn: CN\=ms\-DFSR\-Topology,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: mayContain  
  
 mayContain: 1.2.840.113556.1.6.13.3.37  
  
 \-  
  
 dn: CN\=ms\-DFSR\-Member,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: mayContain  
  
 mayContain: 1.2.840.113556.1.6.13.3.37  
  
 \-  
  
 dn: CN\=User,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.1976  
  
 systemMayContain: 1.2.840.113556.1.4.1977  
  
 systemMayContain: 1.2.840.113556.1.4.1978  
  
 systemMayContain: 1.2.840.113556.1.4.1979  
  
 systemMayContain: 1.2.840.113556.1.4.1980  
  
 systemMayContain: 1.2.840.113556.1.4.1981  
  
 systemMayContain: 1.2.840.113556.1.4.1982  
  
 systemMayContain: 1.2.840.113556.1.4.1983  
  
 systemMayContain: 1.2.840.113556.1.4.1984  
  
 systemMayContain: 1.2.840.113556.1.4.1985  
  
 systemMayContain: 1.2.840.113556.1.4.1986  
  
 systemMayContain: 1.2.840.113556.1.4.1987  
  
 systemMayContain: 1.2.840.113556.1.4.1988  
  
 systemMayContain: 1.2.840.113556.1.4.1989  
  
 systemMayContain: 1.2.840.113556.1.4.1990  
  
 systemMayContain: 1.2.840.113556.1.4.1991  
  
 systemMayContain: 1.2.840.113556.1.4.1992  
  
 systemMayContain: 1.2.840.113556.1.4.1993  
  
 systemMayContain: 1.2.840.113556.1.4.1994  
  
 systemMayContain: 1.2.840.113556.1.4.1995  
  
 \-  
  
 dn: CN\=ms\-DFSR\-Connection,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: mayContain  
  
 mayContain: 1.2.840.113556.1.6.13.3.32  
  
 mayContain: 1.2.840.113556.1.6.13.3.37  
  
 \-  
  
 dn: CN\=Computer,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.1991  
  
 systemMayContain: 1.2.840.113556.1.4.1992  
  
 \-  
  
 dn: CN\=User,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.1996  
  
 \-  
  
 dn: CN\=Top,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.1865  
  
 \-  
  
 dn: CN\=Top,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.1957  
  
 \-  
  
 dn: CN\=Computer,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: systemMayContain  
  
 systemMayContain: 1.2.840.113556.1.4.1958  
  
 \-  
  
 dn: CN\=ms\-DS\-AuthenticatedTo\-Accountlist,CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 add: adminDescription  
  
 adminDescription: Backlink for ms\-DS\-AuthenticatedAt\-DC; for a Computer, identifies which users have authenticated to this Computer  
  
 \-  
  
 dn:  
  
 changetype: ntdsSchemaModify  
  
 add: schemaUpdateNow  
  
 schemaUpdateNow: 1  
  
 \-  
  
 dn: CN\=MS\-TS\-GatewayAccess,CN\=Extended\-Rights,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: controlAccessRight  
  
 displayName: MS\-TS\-GatewayAccess  
  
 rightsGuid: ccc2dc7d\-a6ad\-4a7a\-8846\-c04e3cc53501  
  
 appliesTo: bf967a86\-0de6\-11d0\-a285\-00aa003049e2  
  
 validAccesses: 48  
  
 localizationDisplayId: 74  
  
 dn: CN\=Terminal\-Server\-License\-Server,CN\=Extended\-Rights,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaAdd  
  
 objectClass: controlAccessRight  
  
 displayName: Terminal Server License Server  
  
 appliesTo: 4828cc14\-1437\-45bc\-9b07\-ad6f015e5f28  
  
 appliesTo: bf967aba\-0de6\-11d0\-a285\-00aa003049e2  
  
 rightsGuid: ccc2dc7d\-a6ad\-4a7a\-8846\-c04e3cc53501  
  
 appliesTo: 5805bc62\-bdc9\-4428\-a5e2\-856a0f4c185e  
  
 validAccesses: 48  
  
 localizationDisplayId: 75  
  
 \# Increase object version  
  
 dn: CN\=Schema,CN\=Configuration,DC\=X  
  
 changetype: ntdsSchemaModify  
  
 replace: objectVersion  
  
 objectVersion: 37  
  
 \-  
  
  