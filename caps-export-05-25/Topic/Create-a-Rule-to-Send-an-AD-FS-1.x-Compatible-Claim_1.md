---
title: Create a Rule to Send an AD FS 1.x Compatible Claim_1
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9d581919-858a-4837-b4a7-b94b26915f54
author: billmath
---
# Create a Rule to Send an AD FS 1.x Compatible Claim_1
In situations in which you are using [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)] to issue claims that will be received by federation servers running AD FS 1.0 \(Windows Server 2003 R2\) or AD FS 1.1 \(Windows Server 2008 or Windows Server 2008 R2\), you must do the following:  
  
-   Create a rule that will send a Name ID claim type with a format of UPN, Email, or Common Name.  
  
-   All other claims that are sent must have one of the following claim types:  
  
    -   AD FS 1.*x* Email Address  
  
    -   AD FS 1.*x* UPN  
  
    -   Common Name  
  
    -   Group  
  
    -   Any other claim type that begins with https:\/\/schemas.xmlsoap.org\/claims\/, such as https:\/\/schemas.xmlsoap.org\/claims\/EmployeeID  
  
Depending on the needs of your organization, use one of the following procedures to create an AD FS 1.*x* compatible NameID claim:  
  
-   Create this rule to issue an AD FS 1.x Name ID claim using the Pass Through or Filter an Incoming Claim rule template  
  
-   Create this rule to issue an AD FS 1.x Name ID claim using the Transform an Incoming Claim rule template. You can use this rule template in situations in which you want to change the existing claim type to a new claim type that will work with AD FS 1. *x* claims.  
  
> [!NOTE]  
> For this rule to work as expected, make sure that the relying party trust or claims provider trust where you are creating this rule has been configured to use the **AD FS 1.0 and 1.1 profile**.  
  
## Creating a rule to issue an AD FS 1.*x* Name ID claim using the Pass Through or Filter an Incoming Claim rule template  
You can use this rule template when you want the group that you specify in this template to ultimately determine what AD FS 1.*x*\-compatible claim to issue.  
  
#### To create a rule to issue an AD FS 1.*x* Name ID claim using the Pass Through or Filter an Incoming Claim rule template  
  
1.  [!INCLUDE[clickstart](../Token/clickstart_md.md)]**AD FS Management**, and then press ENTER.  
  
2.  In the console tree, under **AD FS\\Trust Relationships**, click either **Claims Provider Trusts** or **Relying Party Trusts**, and then click a specific trust in the list where you want to create this rule.  
  
3.  Right\-click the selected trust, and then click **Edit Claim Rules**.  
  
4.  In the **Edit Claim Rules** dialog box, select one the following tabs, depending on the trust that you are editing and which rule set you want to create this rule in, and then click **Add Rule** to start the rule wizard that is associated with that rule set:  
  
    -   **Acceptance Transform Rules**  
  
    -   **Issuance Transform Rules**  
  
    -   **Issuance Authorization Rules**  
  
    -   **Delegation Authorization Rules**  
  
5.  On the **Select Rule Template** page, under **Claim rule template**, select **Send LDAP Attributes as Claims** in the list, and then click **Next**.  
  
6.  On the **Configure Rule** page, type a claim rule name.  
  
7.  In **Incoming claim type**, select **Name ID** in the list.  
  
8.  In **Incoming name ID format**, select one of the following AD FS 1.*x*\-compatible claim formats from the list:  
  
    -   **UPN**  
  
    -   **E\-Mail**  
  
    -   **Common Name**  
  
9. Select one of the following options, depending on the needs of your organization:  
  
    -   **Pass through all claim values**  
  
    -   **Pass through only a specific claim value**  
  
    -   **Pass through only claim values that match a specific email suffix value**  
  
    -   **Pass through only claim values that start with a specific value**  
  
10. Click **Finish**, and then click **OK** to save the rule.  
  
## Creating a rule to issue an AD FS 1.*x* Name ID claim using the Transform an Incoming Claim rule template  
You can use this rule template in situations in which you want to change the incoming claim type to a new outgoing claim type of Name ID that will work with AD FS 1.*x* federation servers.  
  
#### To create a rule to issue an AD FS 1.*x* Name ID claim using the Transform an Incoming Claim rule template  
  
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
  
7.  In **Incoming claim type**, select the type of incoming claim that you want to transform in the list.  
  
8.  In **Outgoing claim type**, select **Name ID** in the list.  
  
9. In **Outgoing name ID format**, select one of the following AD FS 1.*x*\-compatible claim formats from the list:  
  
    -   **UPN**  
  
    -   **E\-Mail**  
  
    -   **Common Name**  
  
10. Select one of the following options, depending on the needs of your organization:  
  
    -   **Pass through all claim values**  
  
    -   **Replace an incoming claim value with a different outgoing claim value**  
  
    -   **Replace incoming e\-mail suffix claims with a new e\-mail suffix**  
  
11. Click **Finish**, and then click **OK** to save the rule.  
  
