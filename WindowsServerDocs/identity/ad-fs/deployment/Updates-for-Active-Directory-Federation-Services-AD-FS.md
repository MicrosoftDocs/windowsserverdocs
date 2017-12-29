---
ms.assetid: ed3206b4-bbfc-4bc7-a43c-981b0544a50d
title: Required Updates for Active Directory Federation Services (AD FS)
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 11/28/2017
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
|[4041688 (OS Build 14393.1794)](https://support.microsoft.com/kb/4041688)|This fix addresses an issue that intermittently misdirects AD Authority requests to the wrong Identity Provider because of incorrect caching behavior. This can effect authentication features like Multi Factor Authentication. </br></br>Added the ability for AAD Connect Health to report ADFS server health with correct fidelity (using verbose auditing) on mixed WS2012R2 and WS2016 ADFS farms.</br></br>Fixed a problem where during upgrade of 2012 R2 ADFS farm to ADFS 2016, the powershell cmdlet to raise the farm behavior level fails with a timeout when there are many relying party trusts.</br></br>Addressed an issue where AD FS causes authentication failures by modifying the wct parameter value while federating the requests to other Security Token Server (STS).|October 2017|
|[4038801 (OS Build 14393.1737)](https://support.microsoft.com/kb/4038801)|Support added for OIDC logout using federated LDPs. This will allow "Kiosk Scenarios" where multiple users might be serially logged into a single device where there is federation with an LDP.</br></br>Fixed a WinHello issue where CEP/CES based certificates don't work with gMSA accounts.</br></br>Fixes a problem where the Windows Internal Database (WID) on Windows Server 2016 ADFS servers fails to sync some settings, such as the ApplicationGroupId columns from IdentityServerPolicy.Scopes and IdentityServerPolicy.Clients tables)  due to a foreign key constraint. Such sync failures can cause different claim, claim provider and application experiences between primary to secondary ADFS servers. Also, if the WID primary role is moved to a secondary node, application groups will no longer be manageable in the ADFS management UX.</br></br>This update fixes an issues where Multi Factor Authentication does not work correctly with Mobile devices that use custom culture definitions|September 2017|
|[4034661 (OS Build 14393.1613)](https://support.microsoft.com/kb/4034661)|Fixes a problem where the caller IP address is nog logged by 411 events in the Security Event log of ADFS 4.0 \ Windows Server 2016 RS1 ADFS servers even after enabling “success audits” and “failure audits”.</br></br>This fix addresses an issue with Azure Multi Factor Authentication (MFA) when an ADFX server is configured to use an HTTP Proxy.</br></br>"Addressed an issue where presenting an expired or revoked certificate to the ADFS Proxy server does not return an error to the user."|August 2017|
|[4034658 (OS Build 14393.1593)](https://support.microsoft.com/kb/4034658)|Fix for 2016 AD FS server in order to support MFA certificate enrollment for Windows Hello For Business for on prem deployments|August 2017| 
|[4025334 (OS Build 14393.1532)](https://support.microsoft.com/kb/4025334)|Addressed an issue where the PkeyAuth token handler could fail an authentication if the pkeyauth request contains incorrect data. The authentication should still continue without performing device authentication|July 2017|
|[4022723 (OS Build 14393.1378)](https://support.microsoft.com/kb/4022723)|[Web Application Proxy] Value of DisableHttpOnlyCookieProtection configuration property is not picked up by WAP 2016 in 2012R2/2016 mixed deployment </br></br>[Web Application Proxy] Unable to obtain user access token from AD FS in EAS Pre-auth scenarios.</br></br>AD FS 2016 : WSFED sign-out leads to an exception|June 2017 
|[3213986](https://support.microsoft.com/kb/3213986)|Cumulative Update for Windows Server 2016 for x64-based Systems (KB3213986)| January 2017

## Updates for AD FS and WAP in Windows Server 2012 R2
Below is the list of hotfixes and update rollups that have been released for Active Directory Federation Services (AD FS) in Windows Server 2012 R2.

|KB # |Description|Date Released
|----- | ----- |-----
|[4041685](https://support.microsoft.com/kb/4041685)|Addressed an AD FS issue where MSISConext cookies in request headers can eventually overflow the headers size limit and cause failure to authenticate with HTTP status code 400 “Bad Request - Header Too Long".</br></br>Fixed a problem where ADFS can no longer ignore "prompt=login" during authentication. A "Disabled" option was added to restore scenarios where non-password authentication is used.|October 2017 Preview of Update Rollup|
|[4019217](https://support.microsoft.com/kb/4019217)|Work Folders clients using token broker do not work when using a Server 2012 R2 AD FS Server|May 2017 Preview Update Rollup| 
|[4015550](https://support.microsoft.com/kb/4015550)|Fixed an issue with AD FS not authenticating External users and AD FS WAP randomly failing to forward request|April 2017 Update Rollup| 
|[4015547](https://support.microsoft.com/kb/4015547)|Fixed an issue with AD FS not authenticating External users and AD FS WAP randomly failing to forward request|April 2017 Security Update| 
|[4012216](https://support.microsoft.com/kb/4009970)|MS17-019 This security update resolves a vulnerability in Active Directory Federation Services (ADFS). The vulnerability could allow information disclosure if an attacker sends a specially crafted request to an AD FS server, allowing the attacker to read sensitive information about the target system.|March 2017 Update Rollup| 
|[3179574](https://support.microsoft.com/kb/3179574)|Fixed issue with AD FS extranet password update. |August 2016 Update Rollup
|[3172614](https://support.microsoft.com/kb/3172614)|Introduced prompt=login [support](https://technet.microsoft.com/en-us/windows-server-docs/identity/ad-fs/overview/ad-fs-faq#BKMK_7), fixed issue with the AD FS management console and AlwaysRequireAuthentication setting. |July 2016 Update Rollup
|[3163306](https://support.microsoft.com/kb/3163306)|Active Directory Federation Services (AD FS) 3.0 can't connect to Lightweight Directory Access Protocol (LDAP) attribute stores that are configured to use Secure Sockets Layer (SSL) port 636 or 3269 in connection string. |June 2016 Update Rollup
|[3148533](https://support.microsoft.com/kb/3148533)|MFA fallback authentication fails through ADFS Proxy in Windows Server 2012 R2 |May 2016
|[3134787](https://support.microsoft.com/kb/3134787)|AD FS logs don't contain client IP address for account lockout scenarios in Windows Server 2012 R2 |February 2016
|[3134222](https://support.microsoft.com/kb/3134222)|MS16-020: Security update for Active Directory Federation Services to address denial of service: February 9, 2016|February 2016
|[3105881](https://support.microsoft.com/kb/3105881)|Can't access applications when device authentication is enabled in Windows Server 2012 R2-based AD FS server|October 2015
|[3092003](https://support.microsoft.com/kb/3092003)|Page loads repeatedly and authentication fails when users use MFA in Windows Server 2012 R2 AD FS|August 2015
|[3080778](https://support.microsoft.com/kb/3080778)|AD FS does not call OnError when MFA adapter throws an exception in Windows Server 2012 R2|July 2015
|[3075610](https://support.microsoft.com/kb/3075610)|Trust relationships are lost on secondary AD FS server after you add or remove claims provider in Windows Server 2012 R2|July 2015
|[3070080](https://support.microsoft.com/kb/3070080)|Home Realm Discovering not working correctly for Non-claims Aware Relying Party Trust|June 2015
|[3052122](https://support.microsoft.com/kb/3052122)|Update adds support for compound ID claims in AD FS tokens in Windows Server 2012 R2|May 2015
|[3045711](https://support.microsoft.com/kb/3045711)|MS15-040: Vulnerability in Active Directory Federation Services could allow information disclosure|April 2015
|[3042127](https://support.microsoft.com/kb/3042127)|"HTTP 400 - Bad Request" error when you open a shared mailbox through WAP in Windows Server 2012 R2|March 2015
|[3042121](https://support.microsoft.com/kb/3042121)|AD FS token replay protection for Web Application Proxy authentication tokens in Windows Server 2012 R2|March 2015
|[3035025](https://support.microsoft.com/kb/3035025)|Hotfix for update password feature so that users are not required to use registered device in Windows Server 2012 R2|January 2015
|[3033917](https://support.microsoft.com/kb/3033917)|AD FS cannot process SAML response in Windows Server 2012 R2|January 2015
|[3025080](https://support.microsoft.com/kb/3025080)|Operation fails when you try to save an Office file through Web Application Proxy in Windows Server 2012 R2|January 2015
|[3025078](https://support.microsoft.com/kb/3025078)|You are not prompted for username again when you use an incorrect username to log on to Windows Server 2012 R2|January 2015
|[3020813](https://support.microsoft.com/kb/3020813)|You are prompted for authentication when you run a web application in Windows Server 2012 R2 AD FS|January 2015
|[3020773](https://support.microsoft.com/kb/3020773)|Time-out failures after initial deployment of Device Registration service in Windows Server 2012 R2|January 2015
|[3018886](https://support.microsoft.com/kb/3018886)|You are prompted for a username and password two times when you access Windows Server 2012 R2 AD FS server from intranet|January 2015
|[3013769](https://support.microsoft.com/kb/3013769)|Windows Server 2012 R2 Update Roll-up|December 2014
|[3000850](https://support.microsoft.com/kb/3000850)|Windows Server 2012 R2 Update Roll-up|November 2014
|[2975719](https://support.microsoft.com/kb/2975719)|Windows Server 2012 R2 Update Roll-up|August 2014
|[2967917](https://support.microsoft.com/kb/2967917)|Windows Server 2012 R2 Update Roll-up|July 2014
|[2962409](https://support.microsoft.com/kb/2962409)|Windows Server 2012 R2 Update Roll-up|June 2014
|[2955164](https://support.microsoft.com/kb/2955164)|Windows Server 2012 R2 Update Roll-up|May 2014
|[2919355](https://support.microsoft.com/kb/2919355)|Windows Server 2012 R2 Update Roll-up|April 2014

## Updates for AD FS in Windows Server 2012 (AD FS 2.1) and AD FS 2.0
Below is the list of hotfixes and update rollups that have been released for AD FS 2.0 and 2.1.

|KB # |Description|Date Released|Applies To:
|----- | ----- |-----|-----
|[3197878](https://support.microsoft.com/kb/3197878)|Authentication through proxy fails in Windows Server 2012 (this is the general release of hotfix 3094446)|November 2016 Quality Rollup|AD FS 2.1
|[3197869](https://support.microsoft.com/kb/3197869)|Authentication through proxy fails in Windows Server 2008 R2 SP1 (this is the general release of hotfix 3094446)|November 2016 Quality Rollup|AD FS 2.0
|[3094446](https://support.microsoft.com/kb/3094446)|Authentication through proxy fails in Windows Server 2012 or Windows Server 2008 R2 SP1|September 2015|AD FS 2.0 and 2.1
|[3070078](https://support.microsoft.com/kb/3070078)|AD FS 2.1 throws an exception when you authenticate against an encryption certificate in Windows Server 2012|July 2015|AD FS 2.1
|[3062577](https://support.microsoft.com/kb/3062577)|MS15-062: Vulnerability in Active Directory federation services could allow elevation of privilege|June 2015|AD FS 2.0 / 2.1
|[3003381](https://support.microsoft.com/kb/3003381)|MS14-077: Vulnerability in Active Directory Federation Services could allow information disclosure: April 14, 2015|November 2014|AD FS 2.0 / 2.1
|[2987843](https://support.microsoft.com/kb/2987843)|Memory usage of AD FS federation server keeps increasing when many users log on a web application in Windows Server 2012|July 2014|AD FS 2.1
|[2957619](https://support.microsoft.com/kb/2957619)|The relying party trust in AD FS is stopped when a request is made to AD FS for a delegated token|May 2014|AD FS 2.1
|[2926658](https://support.microsoft.com/kb/2926658)|ADFS SQL farm deployment fails if you do not have SQL permissions|October 2014|AD FS 2.1
|[2896713](https://support.microsoft.com/kb/2896713) or [2989956](https://support.microsoft.com/kb/2989956)|Update is available to fix several issues after you install security update 2843638 on an AD FS server|November 2013</br></br>September 2014|AD FS 2.0 / 2.1
|[2877424](https://support.microsoft.com/kb/2877424)|Update enables you to use one certificate for multiple Relying Party Trusts in an AD FS 2.1 farm|October 2013|AD FS 2.1
|[2873168](https://support.microsoft.com/kb/2873168)|FIX: An error occurs when you use a third-party CSP and HSM and then configure a claims provider trust in Update Rollup 3 for AD FS 2.0 on Windows Server 2008 R2 Service Pack 1|September 2013|AD FS 2.0
|[2861090](https://support.microsoft.com/kb/2861090)|A comma in the subject name of an encryption certificate causes an exception in Windows Server 2008 R2 SP1|August 2013|AD FS 2.0
|[2843639](https://support.microsoft.com/kb/2843639)|[Security] Vulnerability in Active Directory Federation Services Could Allow Information Disclosure|November 2013|AD FS 2.1
|[2843638](https://support.microsoft.com/kb/2843638)|MS13-066: Description of the security update for Active Directory Federation Services 2.0: August 13, 2013|August 2013|AD FS 2.0
|[2827748](https://support.microsoft.com/kb/2827748)|Federationmetadata.xml file does not contain the MEX endpoint information for the WS-Trust and WS-Federation endpoints in Windows Server 2012|May 2013|AD FS 2.1
|[2790338](https://support.microsoft.com/kb/2790338)|Description of Update Rollup 3 for Active Directory Federation Services (AD FS) 2.0|March 2013|AD FS 2.0




