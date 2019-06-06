---
ms.assetid: 
title: Client Access Control policies in Active Directory Federation Services 2.0
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: identity-adfs
---
# Client Access Control policies in AD FS 2.0
A client access policies in Active Directory Federation Services 2.0 allow you to restrict or grant users access to resources.  This document describes how to enable client access policies in AD FS 2.0 and how to configure the most common scenarios.

## Enabling Client Access Policy in AD FS 2.0

To enable client access policy, follow the steps below.

### Step 1: Install the Update Rollup 2 for AD FS 2.0 package on your AD FS servers

Download the [Update Rollup 2 for Active Directory Federation Services (AD FS) 2.0](https://support.microsoft.com/en-us/help/2681584/description-of-update-rollup-2-for-active-directory-federation-services-ad-fs-2.0) package and install it on all federation server and federation server proxies.

### Step 2: Add five claim rules to the Active Directory Claims Provider trust

Once Update Rollup 2 has been installed on all of the AD FS servers and proxies, use the following procedure to add a set of claims rules that makes the new claim types available to the policy engine.

To do this, you will be adding five acceptance transform rules for each of the new request context claim types using the following procedure.

On the Active Directory claims provider trust, create a new acceptance transform rule to pass through each of the new request context claim types.

#### To add a claim rule to the Active Directory claims provider trust for each of the five context claim types:


1. Click Start, point to Programs, point to Administrative Tools, and then click AD FS 2.0 Management.
2. In the console tree, under AD FS 2.0\Trust Relationships, click Claims Provider Trusts, right-click Active Directory, and then click Edit Claim Rules.
3. In the Edit Claim Rules dialog box, select the Acceptance Transform Rules tab, and then click Add Rule to start the Rule wizard.
4. On the Select Rule Template page, under Claim rule template, select Pass Through or Filter an Incoming Claim from the list, and then click Next.
5. On the Configure Rule page, under Claim rule name, type the display name for this rule; in Incoming claim type, type the following claim type URL, and then select Pass through all claim values.</br>
        `https://schemas.microsoft.com/2012/01/requestcontext/claims/x-ms-forwarded-client-ip`</br>
6. To verify the rule, select it in the list and click Edit Rule, then click View Rule Language. The claim rule language should appear as follows: 
        `c:[Type == "https://schemas.microsoft.com/2012/01/requestcontext/claims/x-ms-forwarded-client-ip"] => issue(claim = c);`
7. Click Finish.
8. In the Edit Claim Rules dialog box, click OK to save the rules.
9. Repeat steps 2 through 6 to create an additional claim rule for each of the remaining four claim types shown below until all five rules have been created.

    `https://schemas.microsoft.com/2012/01/requestcontext/claims/x-ms-client-application`


~~~
`https://schemas.microsoft.com/2012/01/requestcontext/claims/x-ms-client-user-agent`

`https://schemas.microsoft.com/2012/01/requestcontext/claims/x-ms-proxy`

`https://schemas.microsoft.com/2012/01/requestcontext/claims/x-ms-endpoint-absolute-path`
~~~

### Step 3: Update the Microsoft Office 365 Identity Platform relying party trust

Choose one of the example scenarios below to configure the claim rules on the Microsoft Office 365 Identity Platform relying party trust that best meets the needs of your organization.

## Client access policy scenarios for AD FS 2.0
The following sections will describe the scenarios that exist for AD FS 2.0

### Scenario 1: Block all external access to Office 365

This client access policy scenario allows access from all internal clients and blocks all external clients based on the IP address of the external client. The rule set builds on the default Issuance Authorization rule Permit Access to All Users. You can use the following procedure to add an Issuance Authorization rule to the Office 365 relying party trust.

#### To create a rule to block all external access to Office 365



1. Click Start, point to Programs, point to Administrative Tools, and then click AD FS 2.0 Management.
2. In the console tree, under AD FS 2.0\Trust Relationships, click Relying Party Trusts, right-click the Microsoft Office 365 Identity Platform trust, and then click Edit Claim Rules. 
3. In the Edit Claim Rules dialog box, select the Issuance Authorization Rules tab, and then click Add Rule to start the Claim Rule Wizard.
4. On the Select Rule Template page, under Claim rule template, select Send Claims Using a Custom Rule, and then click Next.
5. On the Configure Rule page, under Claim rule name, type the display name for this rule. Under Custom rule, type or paste the following claim rule language syntax:
    `exists([Type == "https://schemas.microsoft.com/2012/01/requestcontext/claims/x-ms-proxy"]) &&
    NOT exists([Type == "https://schemas.microsoft.com/2012/01/requestcontext/claims/x-ms-forwarded-client-ip",
    Value=~"customer-provided public ip address regex"])
    => issue(Type = "https://schemas.microsoft.com/authorization/claims/deny", Value = "true");` 
6. Click Finish. Verify that the new rule appears immediately below the Permit Access to All Users rule in the Issuance Authorization Rules list.
7. To save the rule, in the Edit Claim Rules dialog box, click OK.

>[!NOTE]
>You will have to replace the value above for “public ip address regex” with a valid IP expression; see Building the IP address range expression for more information.


### Scenario 2: Block all external access to Office 365 except Exchange ActiveSync

The following example allows access to all Office 365 applications, including Exchange Online, from internal clients including Outlook. It blocks access from clients residing outside the corporate network, as indicated by the client IP address, except for Exchange ActiveSync clients such as smart phones. The rule set builds on the default Issuance Authorization rule titled Permit Access to All Users. Use the following steps to add an Issuance Authorization rule to the Office 365 relying party trust using the Claim Rule Wizard:

#### To create a rule to block all external access to Office 365



1. Click Start, point to Programs, point to Administrative Tools, and then click AD FS 2.0 Management.
2. In the console tree, under AD FS 2.0\Trust Relationships, click Relying Party Trusts, right-click the Microsoft Office 365 Identity Platform trust, and then click Edit Claim Rules. 
3. In the Edit Claim Rules dialog box, select the Issuance Authorization Rules tab, and then click Add Rule to start the Claim Rule Wizard.
4. On the Select Rule Template page, under Claim rule template, select Send Claims Using a Custom Rule, and then click Next.
5. On the Configure Rule page, under Claim rule name, type the display name for this rule. Under Custom rule, type or paste the following claim rule language syntax:
    `exists([Type == "https://schemas.microsoft.com/2012/01/requestcontext/claims/x-ms-proxy"]) &&
    NOT exists([Type == "https://schemas.microsoft.com/2012/01/requestcontext/claims/x-ms-client-application",
    Value=="Microsoft.Exchange.Autodiscover"]) &&
    NOT exists([Type == "https://schemas.microsoft.com/2012/01/requestcontext/claims/x-ms-client-application",
    Value=="Microsoft.Exchange.ActiveSync"]) &&
    NOT exists([Type == "https://schemas.microsoft.com/2012/01/requestcontext/claims/x-ms-forwarded-client-ip",
    Value=~"customer-provided public ip address regex"])
    => issue(Type = "https://schemas.microsoft.com/authorization/claims/deny", Value = "true");`
6. Click Finish. Verify that the new rule appears immediately below the Permit Access to All Users rule in the Issuance Authorization Rules list.
7. To save the rule, in the Edit Claim Rules dialog box, click OK.

>[!NOTE]
>You will have to replace the value above for “public ip address regex” with a valid IP expression; see Building the IP address range expression for more information.

### Scenario 3: Block all external access to Office 365 except browser-based applications

The rule set builds on the default Issuance Authorization rule titled Permit Access to All Users. Use the following steps to add an Issuance Authorization rule to the Microsoft Office 365 Identity Platform relying party trust using the Claim Rule Wizard:

>[!NOTE]
>This scenario is not supported with a third-party proxy because of limitations on client access policy headers with passive (Web-based) requests.

#### To create a rule to block all external access to Office 365 except browser-based applications



1. Click Start, point to Programs, point to Administrative Tools, and then click AD FS 2.0 Management.
2. In the console tree, under AD FS 2.0\Trust Relationships, click Relying Party Trusts, right-click the Microsoft Office 365 Identity Platform trust, and then click Edit Claim Rules. 
3. In the Edit Claim Rules dialog box, select the Issuance Authorization Rules tab, and then click Add Rule to start the Claim Rule Wizard.
4. On the Select Rule Template page, under Claim rule template, select Send Claims Using a Custom Rule, and then click Next.
5. On the Configure Rule page, under Claim rule name, type the display name for this rule. Under Custom rule, type or paste the following claim rule language syntax:
    `exists([Type == "https://schemas.microsoft.com/2012/01/requestcontext/claims/x-ms-proxy"]) &&
    NOT exists([Type == "https://schemas.microsoft.com/2012/01/requestcontext/claims/x-ms-forwarded-client-ip",
    Value=~"customer-provided public ip address regex"]) &&
    NOT exists([Type == "https://schemas.microsoft.com/2012/01/requestcontext/claims/x-ms-endpoint-absolute-path", Value == "/adfs/ls/"])
    => issue(Type = "https://schemas.microsoft.com/authorization/claims/deny", Value = "true");`
6. Click Finish. Verify that the new rule appears immediately below the Permit Access to All Users rule in the Issuance Authorization Rules list.
7. To save the rule, in the Edit Claim Rules dialog box, click OK.

### Scenario 4: Block all external access to Office 365 for designated Active Directory groups

The following example enables access from internal clients based on IP address. It blocks access from clients residing outside the corporate network that have an external client IP address, except for those individuals in a specified Active Directory Group.The rule set builds on the default Issuance Authorization rule titled Permit Access to All Users. Use the following steps to add an Issuance Authorization rule to the Microsoft Office 365 Identity Platform relying party trust using the Claim Rule Wizard:

#### To create a rule to block all external access to Office 365 for designated Active Directory groups



1. Click Start, point to Programs, point to Administrative Tools, and then click AD FS 2.0 Management.
2. In the console tree, under AD FS 2.0\Trust Relationships, click Relying Party Trusts, right-click the Microsoft Office 365 Identity Platform trust, and then click Edit Claim Rules. 
3. In the Edit Claim Rules dialog box, select the Issuance Authorization Rules tab, and then click Add Rule to start the Claim Rule Wizard.
4. On the Select Rule Template page, under Claim rule template, select Send Claims Using a Custom Rule, and then click Next.
5. On the Configure Rule page, under Claim rule name, type the display name for this rule. Under Custom rule, type or paste the following claim rule language syntax:
    `exists([Type == "https://schemas.microsoft.com/2012/01/requestcontext/claims/x-ms-proxy"]) &&
    exists([Type == "https://schemas.microsoft.com/ws/2008/06/identity/claims/groupsid", Value =~ "Group SID value of allowed AD group"]) &&
    NOT exists([Type == "https://schemas.microsoft.com/2012/01/requestcontext/claims/x-ms-forwarded-client-ip",
    Value=~"customer-provided public ip address regex"])
    => issue(Type = "https://schemas.microsoft.com/authorization/claims/deny", Value = "true");`
6. Click Finish. Verify that the new rule appears immediately below the Permit Access to All Users rule in the Issuance Authorization Rules list.
7. To save the rule, in the Edit Claim Rules dialog box, click OK.


### Descriptions of the claim rule language syntax used in the above scenarios

|                                                                                                   Description                                                                                                   |                                                                     Claim Rule language syntax                                                                     |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|              Default AD FS rule to Permit Access to All Users. This rule should already exist in the Microsoft Office 365 Identity Platform relying party trust Issuance Authorization Rules list.              |                                  => issue(Type = "<https://schemas.microsoft.com/authorization/claims/permit>", Value = "true");                                   |
|                               Adding this clause to a new, custom rule specifies that the request has come from the federation server proxy (i.e., it has the x-ms-proxy header)                                |                                                                                                                                                                    |
|                                                                                 It is recommended that all rules include this.                                                                                  |                                    exists([Type == "<https://schemas.microsoft.com/2012/01/requestcontext/claims/x-ms-proxy>"])                                    |
|                                                         Used to establish that the request is from a client with an IP in the defined acceptable range.                                                         | NOT exists([Type == "<https://schemas.microsoft.com/2012/01/requestcontext/claims/x-ms-forwarded-client-ip>", Value=~"customer-provided public ip address regex"]) |
|                                    This clause is used to specify that if the application being accessed is not Microsoft.Exchange.ActiveSync the request should be denied.                                     |       NOT exists([Type == "<https://schemas.microsoft.com/2012/01/requestcontext/claims/x-ms-client-application>", Value=="Microsoft.Exchange.ActiveSync"])        |
|                                                      This rule allows you to determine whether the call was through a Web browser, and will not be denied.                                                      |              NOT exists([Type == "<https://schemas.microsoft.com/2012/01/requestcontext/claims/x-ms-endpoint-absolute-path>", Value == "/adfs/ls/"])               |
| This rule states that the only users in a particular Active Directory group (based on SID value) should be denied. Adding NOT to this statement means a group of users will be allowed, regardless of location. |             exists([Type == "<https://schemas.microsoft.com/ws/2008/06/identity/claims/groupsid>", Value =~ "{Group SID value of allowed AD group}"])              |
|                                                                This is a required clause to issue a deny when all preceding conditions are met.                                                                 |                                   => issue(Type = "<https://schemas.microsoft.com/authorization/claims/deny>", Value = "true");                                    |

### Building the IP address range expression

The x-ms-forwarded-client-ip claim is populated from an HTTP header that is currently set only by Exchange Online, which populates the header when passing the authentication request to AD FS. The value of the claim may be one of the following:

>[!Note] 
>Exchange Online currently supports only IPV4 and not IPV6 addresses.

A single IP address: The IP address of the client that is directly connected to Exchange Online

>[!Note] 
>The IP address of a client on the corporate network will appear as the external interface IP address of the organization’s outbound proxy or gateway.

Clients that are connected to the corporate network by a VPN or by Microsoft DirectAccess (DA) may appear as internal corporate clients or as external clients depending upon the configuration of VPN or DA.

One or more IP addresses: When Exchange Online cannot determine the IP address of the connecting client, it will set the value based on the value of the x-forwarded-for header, a non-standard header that can be included in HTTP-based requests and is supported by many clients, load balancers, and proxies on the market.

>[!Note]
>Multiple IP addresses, indicating the client IP address and the address of each proxy that passed the request, will be separated by a comma.

IP addresses related to Exchange Online infrastructure will not appear on the list.


#### Regular Expressions

When you have to match a range of IP addresses, it becomes necessary to construct a regular expression to perform the comparison. In the next series of steps, we will provide examples for how to construct such an expression to match the following address ranges (note that you will have to change these examples to match your public IP range):


- 192.168.1.1 – 192.168.1.25
- 10.0.0.1 – 10.0.0.14

First, the basic pattern that will match a single IP address is as follows: \b###\.###\.###\.###\b

Extending this, we can match two different IP addresses with an OR expression as follows: \b###\.###\.###\.###\b|\b###\.###\.###\.###\b

So, an example to match just two addresses (such as 192.168.1.1 or 10.0.0.1) would be: \b192\.168\.1\.1\b|\b10\.0\.0\.1\b

This gives you the technique by which you can enter any number of addresses. Where a range of address need to allowed, for example 192.168.1.1 – 192.168.1.25, the matching must be done character by character: \b192\.168\.1\.([1-9]|1[0-9]|2[0-5])\b

>[!Note] 
>The IP address is treated as string and not a number.


The rule is broken down as follows: \b192\.168\.1\.

This matches any value beginning with 192.168.1.

The following matches the ranges required for the portion of the address after the final decimal point:


- ([1-9] Matches addresses ending in 1-9
- |1[0-9] Matches addresses ending in 10-19
- |2[0-5]) Matches addresses ending in 20-25

>[!Note]
>The parentheses must be correctly positioned, so that you don’t start matching other portions of IP addresses.

With the 192 block matched, we can write a similar expression for the 10 block: \b10\.0\.0\.([1-9]|1[0-4])\b

And putting them together, the following expression should match all the addresses for “192.168.1.1～25” and “10.0.0.1～14”: \b192\.168\.1\.([1-9]|1[0-9]|2[0-5])\b|\b10\.0\.0\.([1-9]|1[0-4])\b

#### Testing the Expression

Regex expressions can become quite tricky, so we highly recommend using a regex verification tool. If you do an internet search for “online regex expression builder”, you will find several good online utilities that will allow you to try out your expressions against sample data.

When testing the expression, it’s important that you understand what to expect to have to match. The Exchange online system may send many IP addresses, separated by commas. The expressions provided above will work for this. However, it’s important to think about this when testing your regex expressions. For example, one might use the following sample input to verify the examples above: 

192.168.1.1, 192.168.1.2, 192.169.1.1. 192.168.12.1, 192.168.1.10, 192.168.1.25, 192.168.1.26, 192.168.1.30, 1192.168.1.20 

10.0.0.1, 10.0.0.5, 10.0.0.10, 10.0.1.0, 10.0.1.1, 110.0.0.1, 10.0.0.14, 10.0.0.15, 10.0.0.10, 10,0.0.1 











## Validating the Deployment

### Security Audit Logs

To verify that the new request context claims are being sent and are available to the AD FS claims processing pipeline, enable audit logging on the AD FS server. Then send some authentication requests and check for the claim values in the standard security audit log entries. 

To enable the logging of audit events to the security log on an AD FS server, follow the steps at Configure auditing for AD FS 2.0.

### Event Logging

By default, failed requests are logged to the application event log located under Applications and Services Logs \ AD FS 2.0 \ Admin.For more information on event logging for AD FS, see [Set up AD FS 2.0 event logging](https://technet.microsoft.com/library/adfs2-troubleshooting-configuring-computers.aspx).

### Configuring Verbose AD FS Tracing Logs

AD FS tracing events are logged to the AD FS 2.0 debug log. To enable tracing, see [Configure debug tracing for AD FS 2.0](https://technet.microsoft.com/library/adfs2-troubleshooting-configuring-computers.aspx).

After you have enabled tracing, use the following command line syntax to enable the verbose logging level:
wevtutil.exe sl “AD FS 2.0 Tracing/Debug” /l:5  

## Related
For more information on the new claim types see [AD FS Claims Types](AD-FS-Claims-Types.md).

