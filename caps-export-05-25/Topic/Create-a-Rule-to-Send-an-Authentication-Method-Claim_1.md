---
title: Create a Rule to Send an Authentication Method Claim_1
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2b75ed2c-aed1-45aa-a491-8f3277ddde7e
author: billmath
---
# Create a Rule to Send an Authentication Method Claim_1
You can use either the **Send Group Membership as Claims** rule template or the **Transform an Incoming Claim** rule template to send an authentication method claim. The relying party can use an authentication method claim to determine the logon mechanism that the user uses to authenticate and obtain claims from [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)]. You can also use the Authentication Mechanism Assurance feature of [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)] in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] as input to generate authentication method claims for situations in which the relying party wants to determine the level of access that is based on smart card logons. For example, a developer can assign different levels of access to federated users of the relying party application. The levels of access are based on whether the users log on with their user name and password credentials, as opposed to their smart cards.  
  
Depending on the requirements of your organization, use one of the following procedures:  
  
-   Create this rule by using the **Send Group Membership as Claims** rule template \- You can use this rule template when you want the group that you specify in this template to ultimately determine what authentication method claim to issue.  
  
-   Create this rule by using the **Transform an Incoming Claim** rule template \- You can use this rule template when you want to change the existing authentication method to a new authentication method that works with a product that does not recognize standard [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] authentication method claims.  
  
#### To create this rule by using the Send Group Membership as Claims rule template  
  
1.  In Server Manager, click **Tools**, and then click **AD FS Management**.  
  
2.  In the console tree, under **AD FS\\Trust Relationships**, click either **Claims Provider Trusts** or **Relying Party Trusts**, and then click a specific trust in the list where you want to create this rule.  
  
3.  Right\-click the selected trust, and then click **Edit Claim Rules**.  
  
4.  In the **Edit Claim Rules** dialog box, select one of the following tabs, depending on the trust that you are editing, and in which rule set you want to create this rule, and then click **Add Rule** to start the rule wizard that is associated with that rule set:  
  
    -   **Acceptance Transform Rules**  
  
    -   **Issuance Transform Rules**  
  
    -   **Issuance Authorization Rules**  
  
    -   **Delegation Authorization Rules**  
  
5.  On the **Select Rule Template** page, under **Claim rule template**, select **Send Group Membership as a Claim** in the list, and then click **Next**.  
  
6.  On the **Configure Rule** page, type a claim rule name.  
  
7.  Click **Browse**, select the group whose members should receive this authentication method claim, and then click **OK**.  
  
8.  In **Outgoing claim type**, select **Authentication method** in the list.  
  
9. In **Outgoing claim value**, type one of the default uniform resource identifier \(URI\) values in the following table, depending on your preferred authentication method, click **Finish**, and then click **OK** to save the rule.  
  
    |Actual Authentication method|Corresponding URI|  
    |--------------------------------|---------------------|  
    |User name and password authentication|http:\/\/schemas.microsoft.com\/ws\/2008\/06\/identity\/authenticationmethod\/password|  
    |Windows authentication|http:\/\/schemas.microsoft.com\/ws\/2008\/06\/identity\/authenticationmethod\/windows|  
    |Transport Layer Security \(TLS\) Mutual authentication that uses X.509 certificates|http:\/\/schemas.microsoft.com\/ws\/2008\/06\/identity\/authenticationmethod\/tlsclient|  
    |X.509\-based authentication that does not use TLS|http:\/\/schemas.microsoft.com\/ws\/2008\/06\/identity\/authenticationmethod\/x509|  
  
    > [!NOTE]  
    > Other URI values can be used in addition to the values in the table. The URI values that are shown in the previous table reflect the URIs that the relying party accepts by default.  
  
#### To create this rule by using the Transform an Incoming Claim rule template  
  
1.  In Server Manager, click **Tools**, and then click **AD FS Management**.  
  
2.  In the console tree, under **AD FS\\Trust Relationships**, click either **Claims Provider Trusts** or **Relying Party Trusts**, and then click a specific trust in the list where you want to create this rule.  
  
3.  Right\-click the selected trust, and then click **Edit Claim Rules**.  
  
4.  In the **Edit Claim Rules** dialog box, select one the following tabs, which depends on which trust you are editing and in which rule set you want to create this rule, and then click **Add Rule** to start the rule wizard that is associated with that rule set:  
  
    -   **Acceptance Transform Rules**  
  
    -   **Issuance Transform Rules**  
  
    -   **Issuance Authorization Rules**  
  
    -   **Delegation Authorization Rules**  
  
5.  On the **Select Rule Template** page, under **Claim rule template**, select **Transform an Incoming Claim** in the list, and then click **Next**.  
  
6.  On the **Configure Rule** page, type a claim rule name.  
  
7.  In **Incoming claim type**, select **Authentication method** in the list.  
  
8.  In **Outgoing claim type**, select **Authentication method** in the list.  
  
9. Select **Replace an incoming claim value with a different outgoing claim value**, and then do the following:  
  
    1.  In **Incoming claim value**, type one of the following URI values that are based on the actual authentication method URI that was used originally, click **Finish**, and then click **OK** to save the rule.  
  
    2.  In **Outgoing claim value**, type one of the default URI values in the following table, which depends on your new preferred authentication method choice, click **Finish**, and then click **OK** to save the rule.  
  
    |Actual authentication method|Corresponding URI|  
    |--------------------------------|---------------------|  
    |User name and password authentication|http:\/\/schemas.microsoft.com\/ws\/2008\/06\/identity\/authenticationmethod\/password|  
    |Windows authentication|http:\/\/schemas.microsoft.com\/ws\/2008\/06\/identity\/authenticationmethod\/windows|  
    |TLS mutual authentication that uses X.509 certificates|http:\/\/schemas.microsoft.com\/ws\/2008\/06\/identity\/authenticationmethod\/tlsclient|  
    |X.509\-based authentication that does not use TLS|http:\/\/schemas.microsoft.com\/ws\/2008\/06\/identity\/authenticationmethod\/x509|  
  
    > [!NOTE]  
    > Other URI values can be used in addition to the values in the table. The URI values that are shown ion the previous table reflect the URIs that the relying party accepts by default.  
  
## See Also  
[Configuring Claim Rules_1](../Topic/Configuring-Claim-Rules_1.md)  
  
