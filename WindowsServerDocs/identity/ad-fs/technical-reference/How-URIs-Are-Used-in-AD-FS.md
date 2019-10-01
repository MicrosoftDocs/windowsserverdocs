---
ms.assetid: 53ee93e2-09ea-4f8b-adb7-c24c59f055ea
title: How URIs Are Used in AD FS
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
---


# How URIs Are Used in AD FS
A Uniform Resource Identifier \(URI\) is a string of characters that is used as a unique identifier.  In AD FS, URIs are used to identify both partner network addresses and configuration objects.  When used to identify partner network addresses, the URI is always a URL.  When used to identify configuration objects, the URI may be a URN or a URL.  For more general information about URIs, see [RFC 2396](https://go.microsoft.com/fwlink/?LinkId=48289) and [RFC 3986](https://go.microsoft.com/fwlink/?LinkId=90453).  
  
## URIs as partner network addresses  
The following are the network address URLs that are most often handled by administrators in AD FS.  
  
-   The URLs of the Federation Service, including WS\-Federation, SAML, WS\-Trust, Federation Metadata, WS\-MetadataExchange, Privacy and Organization URLs  
  
-   The URLs of a relying party trust, including WS\-Federation, SAML, and Federation Metadata URLs  
  
-   The URLs of a claims provider trust, including WS\-Federation, SAML, and Federation Metadata URLs  
  
## URIs as object identifiers  
The following table describes the identifiers that are most often handled by administrators in AD FS.  
  
|Identifier name|Description|Comparisons|  
|-------------------|---------------|---------------|  
|Federation Service identifier|This identifier is used to identify the Federation Service.  It is used by relying parties that use claims from this Federation Service, as well as claims providers that issue claims to this Federation Service.|When a user requests claims from a claims provider for this Federation Service, the Federation Service identifier will be used to identify the target for the claims.<br /><br />When this Federation Service receives the claims from a claims provider, it will check to ensure the claims are scoped for it by looking for its Federation Service identifier.<br /><br />When a relying party is receiving claims from this Federation Service, the relying party will check that the issuer of the claims matches the Federation Service identifier.|  
|Relying party identifier|This identifier is used to identify the relying party to this Federation Service.  It is used when issuing claims to the relying party.|When a user requests claims from this Federation Service for the relying party, the relying party identifier will be used to identify the relying party for which the claims should be targeted.  This comparison is done using prefix matching \(see below\).<br /><br />When the relying party receives the claims, it will check for its identifier in the security token to ensure the claims are targeted for it.|  
|Claims provider identifier|This identifier is used to identify the claims provider to this Federation Service.  It is used when receiving claims from the claims provider.|When this Federation Service is receiving claims from the claims provider, this Federation Service will check that the issuer of the claims matches the claims provider identifier.|  
|Claim type|This identifier is used to define the type of claim.  It is used by this Federation Service, claims providers, and relying parties when sending and receiving claims.|When the Federation Service receives claims from a claims provider, the claim rules associated with the corresponding claims provider trust allow the administrator to compare claim types and process claims.  The claim rules associated with a relying party trust also allow the administrator to compare claim types from the claims coming out of the claims provider trust rules, and decide which claims to issue.|  
  
## URI prefix matching for relying party identifiers  
The path syntax of a URI is organized hierarchically and is delimited by either all “\/” characters or all “:”characters.  Thus the path may be split into path sections based on the delimiting character.  When prefix matching, each section must be a full match according to the matching rules \(these rules govern the casing of matches\). For more information about matching rules, see the RFC's mentioned above.  
  
When a relying party is identified in a request to the Federation Service, AD FS uses prefix matching logic to determine if there is a matching relying party trust in the AD FS configuration database.  
  
For example, if the relying party identifier in the AD FS configuration database \(URI1\) is a prefix to the relying party identifier in the incoming request \(URI2\), then the following must be true:  
  
-   Trailing delimiters \(slashes and colons\) of path sections or authorities must be ignored  
  
-   The scheme and authority parts of URI1 and URI2 must be a case insensitive exact match  
  
-   Each path section of URI1 must be an exact match \(based on the case sensitivity chosen\) to the corresponding path section of URI2  
  
-   URI2 may have more path sections than URI1, but URI1 must not have more path sections than URI2  
  
-   URI1 cannot have more path sections than URI2  
  
-   If URI1 has a query string, it must match exactly to a URI2 query string  
  
-   If URI1 has a fragment, it must match exactly to a URI2 fragment  
  
The following table provides additional examples.  
  
|Relying party identifier in AD FS configuration database|Relying party identifier in request message|Request identifier matches the configuration identifier?|Reason|  
|------------------------------------------------------------|-----------------------------------------------|------------------------------------------------------------|----------|  
|http:\/\/contoso.com|http:\/\/contoso.com|TRUE|Exact match|  
|http:\/\/contoso.com\/|http:\/\/contoso.com|TRUE|Trailing slashes are ignored|  
|http:\/\/contoso.com|http:\/\/contoso.com\/|TRUE|Trailing slashes are ignored|  
|http:\/\/contoso.com|http:\/\/contoso.com\/hr|TRUE|URI1 has no path and matches scheme and authority to URI2|  
|http:\/\/contoso.com\/hr|http:\/\/contoso.com\/hr\/web|TRUE|First path sections match, URI1 has no second path section|  
|http:\/\/contoso.com\/hr|http:\/\/contoso.com\/hr\/web\/?m\=t|TRUE|Same reasons as above, query string doesn't change anything|  
|http:\/\/contoso.com\/hr\/|http:\/\/contoso.com\/hrw\/main|FALSE|URI1 path section 1 does not match URI2 path section 1|  
|http:\/\/contoso.com\/hr|http:\/\/contoso.com|FALSE|URI1 has more path sections than URI2|  
|http:\/\/contoso.com\/hr|http:\/\/contoso.com\/hrweb|FALSE|First path sections do not match|  
|http:\/\/contoso.com\/?m\=t|http:\/\/contoso.com\/?m\=f|FALSE|Query string parts do not match|  
|https:\/\/contoso.com|http:\/\/contoso.com|FALSE|Scheme parts do not match|  
|http:\/\/sts.contoso.com|http:\/\/contoso.com|FALSE|Authority parts do not match|  
|http:\/\/contoso.com|http:\/\/sts.contoso.com|FALSE|Authority parts do not match|  
  

