---
title: AD FS Modern Authentication Concepts  
description: Learn about AD FS modern authentication concepts.
author: billmath
ms.author: billmath
manager: daveba
ms.date: 08/09/2019
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: identity-adfs
---

# AD FS Modern Authentication Concepts 
 
 
## Modern Authentication Actors 

|Actor| Description|
|-----|-----| 
|End User|This is the security principal (users, applications, services and groups) who needs to access the resource.|  
|Client|This is your app, identified by its client ID. The client is usually the party that the end user interacts with, and it requests tokens from the authorization server.|  
|Authorization Server / Identity Provider (IdP)| This is your AD FS server. It is responsible for verifying the identity of security principals (users, applications, services and groups) that exist in an organization’s directory, and issues security tokens (bearer access token, ID token, refresh token) upon successful authentication of those security principals.| 
Resource Server / Resource Provider / Relying Party| 
This is where the resource or data resides. It trusts the Authorization Server to securely authenticate and authorize the Client and uses Bearer access tokens to ensure that access to a resource (Web API) can be granted.| 

Following diagram provides the most basic relationship between the actors:

![Modern Authentication actors](media/adfs-modern-auth-concepts/concept1.png)

## Application Types 
 

|Application Type|Description|Role|
|-----|-----|-----|
|Native application|Sometimes called a **public client**, this is intended to be a client app that runs on a pc or device and with which the user interacts.|Requests tokens from the authorization server (AD FS) for user access to resources. Sends HTTP requests to protected resources, using the tokens as HTTP headers.| 
|Server application (Web app)|A web application that runs on a server and is generally accessible to users via a browser. Because it is capable of maintaining its own client 'secret' or credential, it is sometimes called a **confidential client**. |Requests tokens from the authorization server (AD FS) for user access to resources. Before requesting token, client (Web App) needs to authenticate using its secret. | 
|Web API|The end resource the user is accessing. Think of these as the new representation of "relying parties".|Consumes tokens obtained by clients| 

## Application Group 
 
Every OAuth client or resource configured with AD FS needs to be associated with an application group. The clients in an application group can be configured to access the resources in the same group. An application group can contain multiple clients (Native App/Server App) and resources (Web API).  

## Security Tokens 
 
Modern authentication uses following token types: 
- **id_token**: A JWT token issued by authorization server (AD FS) and consumed by the client. Claims in the ID token will contain information about the user so that client can use that.  
- **access_token**: A JWT token issued by authorization server (AD FS) and intended to be consumed by the resource. The 'aud' or audience claim of this token must match the identifier of the resource or Web API.  
- **refresh_token**: This is token issued by AD FS for client to use when it needs to refresh the id_token and access_token. The token is opaque to the client and can only be consumed by AD FS.  

## Scopes 
 
While registering a resource in AD FS, scopes can be configured to allow AD FS to perform specific actions. In addition to configuring the scope, the scope value is also required to be sent in the request for AD FS to perform the action. For e.g., Admin needs to configure scope as openid during resource registration and application (client) needs to send scope = openid in the auth request for AD FS to issue ID Token. Details on the scopes available in AD FS are provided below 
 
- aza - If using [OAuth 2.0 Protocol Extensions for Broker Clients](https://docs.microsoft.com/openspecs/windows_protocols/ms-oapxbc/2f7d8875-0383-4058-956d-2fb216b44706) and if the scope parameter contains the scope "aza", the server issues a new primary refresh token and sets it in the refresh_token field of the response, as well as setting the refresh_token_expires_in field to the lifetime of the new primary refresh token if one is enforced. 
- openid - Allows application to request use of the OpenID Connect authorization protocol. 
- logon_cert - The logon_cert scope allows an application to request logon certificates, which can be used to interactively logon authenticated users. The AD FS server omits the access_token parameter from the response and instead provides a base64-encoded CMS certificate chain or a CMC full PKI response. More details available [here](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-oapx/32ce8878-7d33-4c02-818b-6c9164cc731e).
- user_impersonation - The user_impersonation scope is necessary to successfully request an on-behalf-of access token from AD FS. For details on how to use this scope refer to [Build a multi-tiered application using On-Behalf-Of (OBO) using OAuth with AD FS 2016](ad-fs-on-behalf-of-authentication-in-windows-server.md). 
- allatclaims – The allatclaims scope allows the application to request claims in access token to be added in the ID Token as well.   
- vpn_cert - The vpn_cert scope allows an application to request VPN certificates, which can be used to establish VPN connections using EAP-TLS authentication. This is not supported anymore. 
- email - Allows application to request email claim for the signed in user.  
- profile - Allows application to request profile related claims for the sign-in user.  

## Claims 
 
Security tokens (access and ID tokens) issued by AD FS contain claims, or assertions of information about the subject that has been authenticated. Applications can use claims for various tasks, including: 
- Validate the token 
- Identify the subject's directory tenant 
- Display user information 
- Determine the subject's authorization 
The claims present in any given security token are dependent upon the type of token, the type of credential used to authenticate the user, and the application configuration.  
 
## Issuance Transform Rules 
 
Transform rules specify the claims that are sent to the Web API as a part of the security tokens. AD FS provides following 5 types of claim rule templates to create claim rules.  

 1. **Send LDAP Attributes as Claims**: Using the Send LDAP Attributes as Claims rule template in Active Directory Federation Services (AD FS), you can create a rule that will select attributes from a Lightweight Directory Access Protocol (LDAP) attribute store, such as Active Directory, to send as claims to the relying party. For example, you can use this rule template to create a Send LDAP Attributes as Claims rule that will extract attribute values for authenticated users from the displayName and telephoneNumber Active Directory attributes and then send those values as two different outgoing claims. For more details visit [Create a Rule to Send LDAP Attributes as Claims](../operations/create-a-rule-to-send-ldap-attributes-as-claims.md).  
 
 2. **Send Group Membership as a Claim**: Using the Send Group Membership as a Claim rule template in Active Directory Federation Services (AD FS), you can create a rule that will make it possible for you to select an Active Directory security group to send as a claim. Only a single claim will be emitted from this rule, based on the group that you select. For example, you can use this rule template to create a rule that will send a group claim with a value of Admin if the user is a member of the Domain Admins security group. This rule should be used only for users in the local Active Directory domain. For more details visit [Create a Rule to Send Group Membership as a Claim](../operations/create-a-rule-to-send-group-membership-as-a-claim.md).  
 
 3. **Transform an Incoming Claim**: By using the Transform an Incoming Claim rule template in Active Directory Federation Services (AD FS), you can select an incoming claim, change its claim type, and change its claim value. For example, you can use this rule template to create a rule that sends a role claim with the same claim value of an incoming group claim. You can also use this rule to send a group claim with a claim value of Purchasers when there is an incoming group claim with a value of Admins, or you can send only user principal name (UPN) claims that end with @fabrikam. For more details visit [Create a Rule to Transform an Incoming Claim](../operations/create-a-rule-to-transform-an-incoming-claim.md).  
 
 4. **Pass through or Filter an Incoming Claim**: Using the Pass Through or Filter an Incoming Claim rule template you can pass through all incoming claims with a selected claim type. You can also filter the values of incoming claims with a selected claim type. For example, you can use this rule template to create a rule that will send all the incoming group claims. You can also use this rule to send only UPN claims that end with “@fabricam”. Multiple claims with the same claim type may be emitted from this rule. Sources of incoming claims vary based on the rules being edited. For more details visit [Create a Rule to Pass Through or Filter an Incoming Claim](../operations/create-a-rule-to-pass-through-or-filter-an-incoming-claim.md).  
 
 5. **Send Claims Using a Custom Rule**: By using the Send Claims Using a Custom Rule template in Active Directory Federation Services (AD FS), you can create custom claim rules for situation in which a standard rule template does not satisfy the requirements of your organization. Custom claim rules are written in the claim rule language and must then be copied into the Custom rule text box before they can be used in a rule set. For information about constructing the syntax for an advanced rule, see [The Role of the Claim Rule Language](../technical-reference/the-role-of-the-claim-rule-language.md). For more details visit [Create a Rule to Send Claims Using a Custom Rule](../operations/create-a-rule-to-send-claims-using-a-custom-rule.md).  

## Access Control Policy 
 
In Windows Server 2016 or later, you can use an Access Control Policy to create rules that will give targeted users access to a resource (Web API). In Windows Server 2012 R2, using the Permit All Users rule template in AD FS, you can create an authorization rule that will give targeted users access to resource (Web API). For more details visit [Create a Rule to Permit All Users](../operations/create-a-rule-to-permit-all-users.md).  
 
## Types of libraries 
  
Two types of libraries are used with AD FS: 
    - **Client libraries**: Native clients and server apps use client libraries to acquire access tokens for calling a resource such as a Web API. Microsoft Authentication Library (MSAL) is the latest and recommended client library when using AD FS 2019. Active Directory Authentication Library (ADAL) is recommended for AD FS 2016.  
    - **Server middleware libraries**: Web apps use server middleware libraries for user sign in. Web APIs use server middleware libraries to validate tokens that are sent by native clients or by other servers. OWIN (Open Web Interface for .NET) is the recommended middleware library. 
 
 
## Userinfo endpoint 
 
Userinfo endpoint is the default endpoint access request is redirected to if the request doesn’t include resource parameter i.e. the resource (Web API) is not specified in the request by the client. The ADFS userinfo endpoint always returns the subject claim as specified in the OpenID standards. The endpoint cannot be customized to provide additional claims.   
 
 