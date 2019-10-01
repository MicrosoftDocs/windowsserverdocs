---
ms.assetid: 22f53391-8c6a-4873-a1f4-08b4760ea621
title: The Role of Claims
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
---


# The Role of Claims
In the claims\-based identity model, claims play a pivotal role in the federation process, They are the key component by which the outcome of all Web\-based authentication and authorization requests are determined. This model enables organizations to securely project digital identity and entitlement rights, or *claims*, across security and enterprise boundaries in a standardized way.  
  
## What are claims?  
In its simplest form, claims are simply *statements* \(for example, name, identity, group\), made about users, that are used primarily for authorizing access to claims\-based applications located anywhere on the Internet. Each statement corresponds to a *value* that is stored in the claim.  
  
### How claims are sourced  
The Federation Service in Active Directory Federation Services \(AD FS\) defines which claims are exchanged between federated partners. However, before it can do this it must first populate or source the claim with either a retrieved value or a calculated value. Each claim value represents a value of a user, group, or entity and is sourced in one of two ways:  
  
1.  When the value that makes up the claim is retrieved from an attribute store, for example, when an attribute value of Sales Department is retrieved from the properties of an Active Directory user account. For more information, see [The Role of Attribute Stores](The-Role-of-Attribute-Stores.md).  
  
2.  When the value of an incoming claim is transformed into another value based on the logic expressed in a rule. For example, when an incoming claim with the value of Domain Admins is transformed into a new value of Administrators before it is sent as an outgoing claim. For more information, see [The Role of Claim Rules](The-Role-of-Claim-Rules.md).  
  
Claims can include values such as an e\-mail address, User Principal Name \(UPN\), group membership, and other account attributes.  
  
### How claims flow  
Other parties rely on the values of the claims to perform authorization tasks for Web\-based applications that they host. These parties are referred to as *relying parties* in the AD FS Management snap\-in. The Federation Service is responsible for brokering trust between many disparate parties. It is designed to process and flow the trusted exchange of claims from an organization that initially sources the claims, also referred to as *claims providers* in the AD FS Management snap\-in, to a relying party. A relying party then uses these claims to make authorization decisions.  
  
The flow of claims using this process is known as the *claims pipeline*. There are three steps in the flow of claims through the claims pipeline:  
  
1.  The claims that are received from the claims provider are processed by the acceptance transform rules on the claims provider trust. These rules determine which claims are accepted from the claims provider.  
  
2.  The output of the acceptance transform rules is used as input to the issuance authorization rules. These rules determine whether the user is permitted to access the relying party.  
  
3.  The output of the acceptance transform rules is used as input to the issuance transform rules. These rules determine the claims that will be sent to the relying party.  
  
For more information, see [The Role of the Claims Pipeline](The-Role-of-the-Claims-Pipeline.md)  
  
### How claims are issued  
When you write claim rules, the source of the incoming claims for the claim rules varies based on whether you are writing rules on a claims provider trust or a relying party trust. When you write claim rules for a claims provider trust, the incoming claims are the claims sent from the trusted claims provider to the Federation Service. When you write rules for a relying party trust, the incoming claims are the claims that are output by the claim rules of the applicable claims provider trust. For more information about incoming claims and outgoing claims, see [The Role of the Claims Pipeline](The-Role-of-the-Claims-Pipeline.md) and [The Role of the Claims Engine](The-Role-of-the-Claims-Engine.md).  
  
## What are claim types?  
A claim type provides context for the claim value. It is usually expressed as a Uniform Resource Identifier \(URI\). AD FS can support any claim type, and it is configured with the claim types in the following table by default.  
  
|Name|Description|URI|  
|--------|---------------|-------|  
|E\-Mail Address|The e\-mail address of the user|http:\/\/schemas.xmlsoap.org\/ws\/2005\/05\/identity\/claims\/emailaddress|  
|Given Name|The given name of the user|http:\/\/schemas.xmlsoap.org\/ws\/2005\/05\/identity\/claims\/givenname|  
|Name|The unique name of the user|http:\/\/schemas.xmlsoap.org\/ws\/2005\/05\/identity\/claims\/name|  
|UPN|The user principal name \(UPN\) of the user|http:\/\/schemas.xmlsoap.org\/ws\/2005\/05\/identity\/claims\/upn|  
|Common Name|The common name of the user|http:\/\/schemas.xmlsoap.org\/claims\/CommonName|  
|AD FS 1.x E\-Mail Address|The e\-mail address of the user when interoperating with AD FS 1.1 or ADFS 1.0|http:\/\/schemas.xmlsoap.org\/claims\/EmailAddress|  
|Group|A group that the user is a member of|http:\/\/schemas.xmlsoap.org\/claims\/Group|  
|AD FS 1.x UPN|The UPN of the user when interoperating with AD FS 1.1 or ADFS 1.0|http:\/\/schemas.xmlsoap.org\/claims\/UPN|  
|Role|A role that the user has|http:\/\/schemas.microsoft.com\/ws\/2008\/06\/identity\/claims\/role|  
|Surname|The surname of the user|http:\/\/schemas.xmlsoap.org\/ws\/2005\/05\/identity\/claims\/surname|  
|PPID|The private identifier of the user|http:\/\/schemas.xmlsoap.org\/ws\/2005\/05\/identity\/claims\/privatepersonalidentifier|  
|Name Identifier|The SAML name identifier of the user|http:\/\/schemas.xmlsoap.org\/ws\/2005\/05\/identity\/claims\/nameidentifier|  
|Authentication Method|The method used to authenticate the user|http:\/\/schemas.microsoft.com\/ws\/2008\/06\/identity\/claims\/authenticationmethod|  
|Deny Only Group SID|The deny\-only group SID of the user|http:\/\/schemas.xmlsoap.org\/ws\/2005\/05\/identity\/claims\/denyonlysid|  
|Deny only primary SID|The deny\-only primary SID of the user|http:\/\/schemas.microsoft.com\/ws\/2008\/06\/identity\/claims\/denyonlyprimarysid|  
|Deny only primary group SID|The deny\-only primary group SID of the user|http:\/\/schemas.microsoft.com\/ws\/2008\/06\/identity\/claims\/denyonlyprimarygroupsid|  
|Group SID|The group SID of the user|http:\/\/schemas.microsoft.com\/ws\/2008\/06\/identity\/claims\/groupsid|  
|Primary group SID|The primary group SID of the user|http:\/\/schemas.microsoft.com\/ws\/2008\/06\/identity\/claims\/primarygroupsid|  
|Primary SID|The primary SID of the user|http:\/\/schemas.microsoft.com\/ws\/2008\/06\/identity\/claims\/primarysid|  
|Windows account name|The domain account name of the user in the form of \<domain\>\\\<user\>|http:\/\/schemas.microsoft.com\/ws\/2008\/06\/identity\/claims\/windowsaccountname|  
  
## What are claim descriptions?  
Claim descriptions represent a list of claims types that AD FS supports and that may be published in federation metadata. The claim types mentioned in the previous table are configured as claims descriptions in the AD FS Management snap\-in.  
  
The collection of claim descriptions that will be published to federation metadata is stored in the AD FS configuration database. These claim descriptions are used by various components of the Federation Service.  
  
Each claim description includes a claim type URI, name, publishing state, and description. You can manage the claim description collection by using the **Claim Descriptions** node in the AD FS Management snap\-in. You can modify the publishing state of a claim description using the snap\-in. The following settings are available:  
  
-   **Publish this claim in federation metadata as a claim type that this Federation Service can accept** \(Publish as Accepted\)—Indicates the claim types that will be accepted from other claims providers by this Federation Service.  
  
-   **Publish this claim in federation metadata as a claim type that this Federation Service can send** \(Publish as Sent\)—Indicates the claim types that are offered by this Federation Service. These are the claim types the Federation Service publishes to others as those it is willing to send. The actual claim types sent by the claims provider are often a subset of this list.  
  
For more information about how to set the publishing state of a claim type, see [Add a Claim Description](https://technet.microsoft.com/library/dd807051.aspx) in the AD FS Deployment Guide.  
  
### When generating Federation Metadata  
Federation Metadata includes all the claim descriptions that are marked for publishing.  
  
### When claims rules are processed  
When you keep configuration information about claims descriptions, it is easier for you to configure rules about claims. For more information about the claim rules that can be used in the claims provider organization, see [The Role of Claim Rules](The-Role-of-Claim-Rules.md).  
  

