---
ms.assetid: ed3206b4-bbfc-4bc7-a43c-981b0544a50d
title: Required Updates for Active Directory Federation Services (AD FS)
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---
# Required Updates for Active Directory Federation Services (AD FS) and Web Application Proxy (WAP)

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2 SP1

As of October 2016, all updates to all components of Windows Server are released only via Windows Update (WU).  There are no more hotfixes or individual downloads.
This applies to Windows Server 2016, Windows Server 2012 R2, Windows Server 2012 and Windows Server 2008 R2 SP1.

This page lists rollup packages of particular interest for AD FS and WAP, as well as the historic list of hotfix updates recommended for AD FS and WAP.

## Updates for AD FS and WAP in Windows Server 2016
Updates for Windows Server 2016 are delivered monthly via Windows Update and are cumulative. The update package listed below is recommended for all AD FS and WAP 2016 servers and includes all previously required updates as well as the latest fixes.

|KB # |Description|Date Released
|----- | ----- |-----
|[3213986](https://support.microsoft.com/kb/3213986)|Cumulative Update for Windows Server 2016 for x64-based Systems (KB3213986)| January 2017

## Updates for AD FS and WAP in Windows Server 2012 R2
Below is the list of hotfixes and update rollups that have been released for Active Directory Federation Services (AD FS) in Windows Server 2012 R2.

|KB # |Description|Date Released
|----- | ----- |-----
|[3179574](https://support.microsoft.com/kb/3179574)|Fixed issue with AD FS extranet password update. |August 2016 Update Rollup
|[3172614](https://support.microsoft.com/kb/3172614)|Introduced prompt=login [support](https://technet.microsoft.com/en-us/windows-server-docs/identity/ad-fs/overview/ad-fs-faq#BKMK_7), fixed issue with the AD FS management console and AlwaysRequireAuthentication setting. |July 2016 Update Rollup
|[3163306](https://support.microsoft.com/kb/3163306)|Active Directory Federation Services (AD FS) 3.0 can't connect to Lightweight Directory Access Protocol (LDAP) attribute stores that are configured to use Secure Sockets Layer (SSL) port 636 or 3269 in connection string. |June 2016 Update Rollup
|[3148533](https://support.microsoft.com/kb/3148533)|MFA fallback authentication fails through ADFS Proxy in Windows Server 2012 R2 |May 2016
|[3134787](http://support.microsoft.com/kb/3134787)|AD FS logs don't contain client IP address for account lockout scenarios in Windows Server 2012 R2 |February 2016
|[3134222](http://support.microsoft.com/kb/3134222)|MS16-020: Security update for Active Directory Federation Services to address denial of service: February 9, 2016|February 2016
|[3105881](http://support.microsoft.com/kb/3105881)|Can't access applications when device authentication is enabled in Windows Server 2012 R2-based AD FS server|October 2015
|[3092003](http://support.microsoft.com/kb/3092003)|Page loads repeatedly and authentication fails when users use MFA in Windows Server 2012 R2 AD FS|August 2015
|[3080778](http://support.microsoft.com/kb/3080778)|AD FS does not call OnError when MFA adapter throws an exception in Windows Server 2012 R2|July 2015
|[3075610](http://support.microsoft.com/kb/3075610)|Trust relationships are lost on secondary AD FS server after you add or remove claims provider in Windows Server 2012 R2|July 2015
|[3070080](http://support.microsoft.com/kb/3070080)|Home Realm Discovering not working correctly for Non-claims Aware Relying Party Trust|June 2015
|[3052122](http://support.microsoft.com/kb/3052122)|Update adds support for compound ID claims in AD FS tokens in Windows Server 2012 R2|May 2015
|[3045711](http://support.microsoft.com/kb/3045711)|MS15-040: Vulnerability in Active Directory Federation Services could allow information disclosure|April 2015
|[3042127](http://support.microsoft.com/kb/3042127)|"HTTP 400 - Bad Request" error when you open a shared mailbox through WAP in Windows Server 2012 R2|March 2015
|[3042121](https://support.microsoft.com/kb/3042121)|AD FS token replay protection for Web Application Proxy authentication tokens in Windows Server 2012 R2|March 2015
|[3035025](http://support.microsoft.com/kb/3035025)|Hotfix for update password feature so that users are not required to use registered device in Windows Server 2012 R2|January 2015
|[3033917](http://support.microsoft.com/kb/3033917)|AD FS cannot process SAML response in Windows Server 2012 R2|January 2015
|[3025080](http://support.microsoft.com/kb/3025080)|Operation fails when you try to save an Office file through Web Application Proxy in Windows Server 2012 R2|January 2015
|[3025078](http://support.microsoft.com/kb/3025078)|You are not prompted for username again when you use an incorrect username to log on to Windows Server 2012 R2|January 2015
|[3020813](http://support.microsoft.com/kb/3020813)|You are prompted for authentication when you run a web application in Windows Server 2012 R2 AD FS|January 2015
|[3020773](http://support.microsoft.com/kb/3020773)|Time-out failures after initial deployment of Device Registration service in Windows Server 2012 R2|January 2015
|[3018886](http://support.microsoft.com/kb/3018886)|You are prompted for a username and password two times when you access Windows Server 2012 R2 AD FS server from intranet|January 2015
|[3013769](http://support.microsoft.com/kb/3013769)|Windows Server 2012 R2 Update Roll-up|December 2014
|[3000850](http://support.microsoft.com/kb/3000850)|Windows Server 2012 R2 Update Roll-up|November 2014
|[2975719](http://support.microsoft.com/kb/2975719)|Windows Server 2012 R2 Update Roll-up|August 2014
|[2967917](http://support.microsoft.com/kb/2967917)|Windows Server 2012 R2 Update Roll-up|July 2014
|[2962409](http://support.microsoft.com/kb/2962409)|Windows Server 2012 R2 Update Roll-up|June 2014
|[2955164](http://support.microsoft.com/kb/2955164)|Windows Server 2012 R2 Update Roll-up|May 2014
|[2919355](http://support.microsoft.com/kb/2919355)|Windows Server 2012 R2 Update Roll-up|April 2014

## Updates for AD FS in Windows Server 2012 (AD FS 2.1) and AD FS 2.0
Below is the list of hotfixes and update rollups that have been released for AD FS 2.0 and 2.1.

|KB # |Description|Date Released|Applies To:
|----- | ----- |-----|-----
|[3197878](http://support.microsoft.com/kb/3197878)|Authentication through proxy fails in Windows Server 2012 (this is the general release of hotfix 3094446)|November 2016 Quality Rollup|AD FS 2.1
|[3197869](http://support.microsoft.com/kb/3197869)|Authentication through proxy fails in Windows Server 2008 R2 SP1 (this is the general release of hotfix 3094446)|November 2016 Quality Rollup|AD FS 2.0
|[3094446](http://support.microsoft.com/kb/3094446)|Authentication through proxy fails in Windows Server 2012 or Windows Server 2008 R2 SP1|September 2015|AD FS 2.0 and 2.1
|[3070078](http://support.microsoft.com/kb/3070078)|AD FS 2.1 throws an exception when you authenticate against an encryption certificate in Windows Server 2012|July 2015|AD FS 2.1
|[3062577](http://support.microsoft.com/kb/3062577)|MS15-062: Vulnerability in Active Directory federation services could allow elevation of privilege|June 2015|AD FS 2.0 / 2.1
|[3003381](http://support.microsoft.com/kb/3003381)|MS14-077: Vulnerability in Active Directory Federation Services could allow information disclosure: April 14, 2015|November 2014|AD FS 2.0 / 2.1
|[2987843](http://support.microsoft.com/kb/2987843)|Memory usage of AD FS federation server keeps increasing when many users log on a web application in Windows Server 2012|July 2014|AD FS 2.1
|[2957619](http://support.microsoft.com/kb/2957619)|The relying party trust in AD FS is stopped when a request is made to AD FS for a delegated token|May 2014|AD FS 2.1
|[2926658](http://support.microsoft.com/kb/2926658)|ADFS SQL farm deployment fails if you do not have SQL permissions|October 2014|AD FS 2.1
|[2896713](http://support.microsoft.com/kb/2896713) or [2989956](http://support.microsoft.com/kb/2989956)|Update is available to fix several issues after you install security update 2843638 on an AD FS server|November 2013</br></br>September 2014|AD FS 2.0 / 2.1
|[2877424](http://support.microsoft.com/kb/2877424)|Update enables you to use one certificate for multiple Relying Party Trusts in an AD FS 2.1 farm|October 2013|AD FS 2.1
|[2873168](http://support.microsoft.com/kb/2873168)|FIX: An error occurs when you use a third-party CSP and HSM and then configure a claims provider trust in Update Rollup 3 for AD FS 2.0 on Windows Server 2008 R2 Service Pack 1|September 2013|AD FS 2.0
|[2861090](http://support.microsoft.com/kb/2861090)|A comma in the subject name of an encryption certificate causes an exception in Windows Server 2008 R2 SP1|August 2013|AD FS 2.0
|[2843639](http://support.microsoft.com/kb/2843639)|[Security] Vulnerability in Active Directory Federation Services Could Allow Information Disclosure|November 2013|AD FS 2.1
|[2843638](http://support.microsoft.com/kb/2843638)|MS13-066: Description of the security update for Active Directory Federation Services 2.0: August 13, 2013|August 2013|AD FS 2.0
|[2827748](http://support.microsoft.com/kb/2827748)|Federationmetadata.xml file does not contain the MEX endpoint information for the WS-Trust and WS-Federation endpoints in Windows Server 2012|May 2013|AD FS 2.1
|[2790338](http://support.microsoft.com/kb/2790338)|Description of Update Rollup 3 for Active Directory Federation Services (AD FS) 2.0|March 2013|AD FS 2.0




