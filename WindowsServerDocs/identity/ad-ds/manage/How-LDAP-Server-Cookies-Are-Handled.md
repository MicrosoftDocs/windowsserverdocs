---
ms.assetid: 3acaa977-ed63-4e38-ac81-229908c47208
title: How LDAP Server Cookies Are Handled
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adds
---

# How LDAP Server Cookies Are Handled

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

In LDAP, some queries result in a large result set. Such queries pose some challenges to the Windows Server.  
  
Collecting and building these big result sets is significant work. Many of the attributes need to be converted from an internal representation to the LDAP wire representation. For many attributes, a conversion from an internal, often binary, format needs to happen to a text-based UTF-8 format in the LDAP response frame.  
  
Another challenge is that result sets with tens of thousands of objects become huge, easily several hundred Mega-Bytes. These then require lots of virtual address space and also the transfer over network has issues as the whole effort is lost when the TCP session breaks down in transit.  
  
These capacity and logistic issues have led the Microsoft LDAP developers to creating a LDAP extension known as "Paged Query". It is implementing a LDAP control to separate one huge query into chunks of smaller result sets. It has become a RFC standard as [RFC 2696](http://www.ietf.org/rfc/rfc2696).  
  
## Cookie Handling on Client  
The Paged Query method uses the page size either set by the client or through a [LDAP Policy](https://support.microsoft.com/kb/315071/en-us) ("MaxPageSize"). The client always needs to enable paging by sending a LDAP control.  

  
When working on a query with many results, at some point the maximum number of objects allowed is reached. The LDAP server packages up the response message and adds a cookie that contains information it needs to later continue the search.  
  
The client application must treat the cookie as an opaque blob. It can retrieve the object count in the response and can continue the search based on the presence of the cookie.The client continues the search by sending the query to the LDAP server again with the same parameters such as base object and filter, and includes the cookie value that was returned on the previous response.  
  
If the number of objects doesn't fill a page, the LDAP query is complete and the response contains no page cookie. If no cookie is returned by the server, the client must consider the paged search to be successfully complete.  
  
If an error is returned by the server, the client must consider the paged search to be unsuccessful. Retrying the search will result in restarting the search from the first page.  
  
## Server-side Cookie handling  
The Windows Server returns the cookie to the client and sometimes stores information related to the cookie on the server. This information is stored on the server in a cache and is subject to certain limits.  
  
In this case, the cookie sent to the client by the Server is also used by the server to lookup the information from the cache on the Server. When the client continues the paged search, the Windows Server will use the client cookie as well as any related information from the server cookie cache to continue the search. If the server cannot find related cookie information from the server cache due to any reason, the search is discontinued and error is returned to the client.  
  
## How the cookie pool is managed  
Obviously, the LDAP server is serving more than one client at a time, and also more than one client at a time can launch queries that require the use of server cookie cache.Thus the Windows Server implementation there is a tracking of cookie pool usage and limits are put into place so the cookie pool is not taking too much resources. The limits can be set by the Administrator using the following settings in LDAP Policy. The defaults and explanations are:  
  
**MinResultSets: 4**  
  
The LDAP server will not look at the maximum pool size discussed below, if there are less than MinResultSets entries in the server cookie cache.  
  
**MaxResultSetSize: 262,144 bytes**  
  
The total cookie cache size on the server must not exceed the maximum of MaxResultSetSize in bytes. If it does, cookies starting from the oldest are deleted until the pool is smaller than MaxResultSetSize bytes or less than MinResultSets cookies are in the pool. This means that using default settings, the LDAP server considers a pool of 450KB to be OK if there are only 3 cookies stored.  
  
**MaxResultSetsPerConn: 10**  
  
The LDAP server allows no more than MaxResultSetsPerConn cookies per LDAP connection in the pool.  
  
## Handling Deleted Cookies  
The removal of cookie information from LDAP Server cache does not result in an immediate error for applications in all cases. Applications may restart the paged search from the start and complete it on another attempt. Some applications have this kind of a retry mechanism to add robustness.  
  
Some applications may go through a page search and never complete it. This may leave entries in the LDAP server cookie cache, which is handled through the mechanism in section 4. This is essential to free up memory on the server for active LDAP searches.  
  
What happens when such a cookie is deleted on the server and the client continues the search with this cookie handle?The LDAP Server will not find the cookie in the server cookie cache and return an error for the query, the error response will be similar to:  
  
```  
00000057: LdapErr: DSID-xxxxxxxx, comment: Error processing control, data 0, v1db1  
```  
  
> [!NOTE]  
> The hexadecimal value behind "DSID" will vary depending on the build version of the LDAP server binaries.  
  
## Reporting on the cookie pool  
The LDAP Server has the ability to log events through category "16 Ldap Interface" in the [NTDS diagnostics key](https://support.microsoft.com/kb/314980/en-us). If you set this category to "2", you can get the following events:  
  
```  
Log Name:      Directory Service  
Source:        Microsoft-Windows-ActiveDirectory_DomainService  
Event ID:      2898  
Task Category: LDAP Interface  
Level:         Information  
Description:  
Internal event: The LDAP server has reached the limit of the number of Result Sets it will maintain for a single connection.  A stored Result Set will be discarded.  This will result in a client being unable to continue a paged LDAP search.  
Maximum number of Result Sets allowed per LDAP connection:  
10  
Current number of Result Sets for this LDAP connection:  
11  
  
User Action  
The client should consider a more efficient search filter.  The limit for Maximum Result Sets per Connection may also be increased.  
  
```  
  
```  
Log Name:      Directory Service  
Source:        Microsoft-Windows-ActiveDirectory_DomainService  
Event ID:      2899  
Task Category: LDAP Interface  
Level:         Information  
Description:  
Internal event: The LDAP server has exceeded the limit of the LDAP Maximum Result Set Size. A stored Result Set will be discarded.  This will result in a client being unable to continue a paged LDAP search.   
  
Number of result sets currently stored:   
4   
Current Result Set Size:   
263504   
Maximum Result Set Size:   
262144   
Size of single Result Set being discarded:   
40876   
User Action   
The client should consider a more efficient search filter.  The limit for Maximum Result Set Size may also be increased.  
  
```  
  
The events signal that a stored cookie was removed. It does NOT mean a client has seen the LDAP error, but only that the LDAP Server has reached the administration limits for the cache.  In some cases, an LDAP client may have abandoned the paged search and may never see the error.  
  
## Monitoring the cookie pool  
If you never experience LDAP search errors in your domain, you may never need to monitor the LDAP server page search cookie pool. In case you see LDAP page search related errors in your environment, you may have an issue with the cookie pool administrator limits.  
  
Events 2898 and 2899 are the only ways to know that the LDAP server has reached the administrator limits. When you experience that LDAP queries error out because of the control processing error above, you should look at Increasing limits on one or more of the LDAP Policy settings mentioned in section 4, depending on which event you are getting.  
  
If you are seeing event 2898 on your DC/LDAP Server, we recommend you set MaxResultSetsPerConn to 25. More than 25 parallel paged searches on a single LDAP connection is not usual. If you continue to see event 2898, consider investigating your LDAP client application which encounters the error. The suspicion would be that it somehow gets stuck retrieving additional paged results, leaves the cookie pending and restarts a new query. So see whether the application would at some point have sufficient cookies for its purposes, you can also increase the value of MaxResultSetsPerConn beyond 25.When you see events 2899 logged on your domain controllers, the plan would be different. If your DC/LDAP server runs on a machine with sufficient memory (several GBs of free memory), we recommend you set the MaxResultsetSize on the LDAP server to >=250MB. This limit is large enough to accommodate large volumes of LDAP page searches even on very large directories.  
  
If you are still seeing events 2899 with a pool of 250MB or more, you are likely having many clients with very high number of objects returned, queried in a very frequent manner. The data you can gather with the [Active Directory Data Collector Set](http://blogs.technet.com/b/askds/archive/2010/06/08/son-of-spa-ad-data-collector-sets-in-win2008-and-beyond.aspx) can help you find repetitive paged queries that keep your LDAP Servers busy. These queries will all show with a number of "Entries returned" that matches the size of the page used.  
  
If possible, you should review the application design, and implement a different approach with a lower frequency, data volume and/or fewer client instances querying this data.In case of the applications for which you have source code access, this guide to  [creating efficient AD-Enabled Applications](https://msdn.microsoft.com/library/ms808539.aspx) can help you understand the optimal way for applications to access AD.  
  
If the query behavior can't be changed, one approach is also adding more replicated instances of the naming contexts needed and to redistribute the clients and eventually reduce the load on the individual LDAP Servers.  
  


