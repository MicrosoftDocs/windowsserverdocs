---
title: Create a Rule to Send an Authentication Method Claim
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0d1f2577-cba8-4dc0-aafa-a48c62574190
author: billmath
---
# Create a Rule to Send an Authentication Method Claim
You can use either the **Send Group Membership as Claims** rule template or the **Transform an Incoming Claim** rule template to send an authentication method claim. The relying party can use an authentication method claim to determine the logon mechanism that the user uses to authenticate and obtain claims from Active Directory Federation Services \(AD FS\).  You can also use the Authentication Mechanism Assurance feature of Active Directory Domain Services \(AD DS\) in Windows Server 2008 R2 as input to generate authentication method claims for situations in which the relying party wants to determine the level of access based on smart\-card logons.  For example, a developer can assign different levels of access to federated users of the relying party application based on whether the users log on with their user name\/password credentials, as opposed to their smart cards.  
  
> [!NOTE]  
> If you do not write an explicit rule to generate an authentication method claim, AD FS will generate one automatically based on the logon method that the user uses to authenticate originally. For more information about the Authentication Mechanism Assurance feature, see [What's New in AD DS: Authentication Mechanism Assurance](http://go.microsoft.com/fwlink/?LinkID=159947) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=159947\).  
  
Depending on the needs of your organization, use one of the following procedures:  
  
-   Create this rule using the Send Group Membership as Claims rule template \- You can use this rule template when you want the group that you specify in this template to ultimately determine what authentication method claim to issue.  
  
-   Create this rule using the Transform an Incoming Claim rule template \- You can use this rule template in situations in which you want to change the existing authentication method to a new authentication method that will work with a product that does not understand standard AD FS authentication method claims.  
  
#### To create this rule using the Send Group Membership as Claims rule template  
  
1.  [!INCLUDE[clickstart](../Token/clickstart_md.md)]**AD FS Management**, and then press ENTER.  
  
2.  In the console tree, under **AD FS\\Trust Relationships**, click either **Claims Provider Trusts** or **Relying Party Trusts**, and then click a specific trust in the list where you want to create this rule.  
  
3.  Right\-click the selected trust, and then click **Edit Claim Rules**.  
  
4.  In the **Edit Claim Rules** dialog box, select one the following tabs, depending on the trust that you are editing and which rule set you want to create this rule in, and then click **Add Rule** to start the rule wizard that is associated with that rule set:  
  
    -   **Acceptance Transform Rules**  
  
    -   **Issuance Transform Rules**  
  
    -   **Issuance Authorization Rules**  
  
    -   **Delegation Authorization Rules**  
  
5.  On the **Select Rule Template** page, under **Claim rule template**, select **Send Group Membership as a Claim** in the list, and then click **Next**.  
  
6.  On the **Configure Rule** page, type a claim rule name.  
  
7.  Click **Browse**, select the group whose members should receive this authentication method claim, and then click **OK**.  
  
8.  In **Outgoing claim type**, select **Authentication method** in the list.  
  
9. In **Outgoing claim value**, type one of the default Uniform Resource Identifier \(URI\) values in the following table, depending on your preferred authentication method, click **Finish**, and then click **OK** to save the rule.  
  
    |Actual Authentication method|Corresponding URI|  
    |--------------------------------|---------------------|  
    |Username Password authentication|http:\/\/schemas.microsoft.com\/ws\/2008\/06\/identity\/authenticationmethod\/password|  
    |Windows authentication|http:\/\/schemas.microsoft.com\/ws\/2008\/06\/identity\/authenticationmethod\/windows|  
    |TLS Mutual authentication using X.509 certificates|http:\/\/schemas.microsoft.com\/ws\/2008\/06\/identity\/authenticationmethod\/tlsclient|  
    |X.509\-based authentication that does not use TLS|http:\/\/schemas.microsoft.com\/ws\/2008\/06\/identity\/authenticationmethod\/x509|  
  
    > [!NOTE]  
    > Other URI values can be used in addition to the values in the table. The URI values shown here reflect the URIs that the relying party will accept by default.  
  
#### To create this rule using the Transform an Incoming Claim rule template  
  
1.  [!INCLUDE[clickstart](../Token/clickstart_md.md)]**AD FS Management**, and then press ENTER.  
  
2.  In the console tree, under **AD FS\\Trust Relationships**, click either **Claims Provider Trusts** or **Relying Party Trusts**, and then click a specific trust in the list where you want to create this rule.  
  
3.  Right\-click the selected trust, and then click **Edit Claim Rules**.  
  
4.  In the **Edit Claim Rules** dialog box, select one the following tabs, depending on the trust that you are editing and which rule set you want to create this rule in, and then click **Add Rule** to start the rule wizard that is associated with that rule set:  
  
    -   **Acceptance Transform Rules**  
  
    -   **Issuance Transform Rules**  
  
    -   **Issuance Authorization Rules**  
  
    -   **Delegation Authorization Rules**  
  
5.  On the **Select Rule Template** page, under **Claim rule template**, select **Transform an Incoming Claim** in the list, and then click **Next**.  
  
6.  On the **Configure Rule** page, type a claim rule name.  
  
7.  In **Incoming claim type**, select **Authentication method** in the list.  
  
8.  In **Outgoing claim type**, select **Authentication method** in the list.  
  
9. Select **Replace an incoming claim value with a different outgoing claim value**, and then do the following:  
  
    1.  In **Incoming claim value**, type one of the following URI values based on the actual authentication method URI that was used originally, click **Finish**, and then click **OK** to save the rule.  
  
    2.  In **Outgoing claim value**, type one of the default URI values in the following table, depending on your new preferred authentication method choice, click **Finish**, and then click **OK** to save the rule.  
  
    |Actual Authentication method|Corresponding URI|  
    |--------------------------------|---------------------|  
    |Username Password authentication|http:\/\/schemas.microsoft.com\/ws\/2008\/06\/identity\/authenticationmethod\/password|  
    |Windows authentication|http:\/\/schemas.microsoft.com\/ws\/2008\/06\/identity\/authenticationmethod\/windows|  
    |TLS Mutual authentication using X.509 certificates|http:\/\/schemas.microsoft.com\/ws\/2008\/06\/identity\/authenticationmethod\/tlsclient|  
    |X.509\-based authentication that does not use TLS|http:\/\/schemas.microsoft.com\/ws\/2008\/06\/identity\/authenticationmethod\/x509|  
  
    > [!NOTE]  
    > Other URI values can be used in addition to the values in the table. The URI values shown here reflect the URIs that the relying party will accept by default.  
  
