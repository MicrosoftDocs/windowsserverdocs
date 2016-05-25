---
title: Create a Rule to Send an AD FS 1.x Compatible Claim
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 63c4cbc1-3d84-4060-a757-ad59917eb809
author: billmath
---
# Create a Rule to Send an AD FS 1.x Compatible Claim
When you use [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)] to issue claims that are to be received by federation servers that run [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] 1.0 on the Windows Server 2003 R2 operating system or [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] 1.1 on the [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] operating system, you must do the following:  
  
-   Create a rule that sends a Name ID claim type with a format of user prinicipal name \(UPN\), Email, or Common Name.  
  
-   All other claims that are sent must have one of the following claim types:  
  
    -   [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] 1.*x* Email Address  
  
    -   [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] 1.*x* UPN  
  
    -   Common Name  
  
    -   Group  
  
    -   Any other claim type that begins with https:\/\/schemas.xmlsoap.org\/claims\/, such as https:\/\/schemas.xmlsoap.org\/claims\/EmployeeID.  
  
Depending on the requirements of your organization, use one of the following procedures to create an [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] 1.*x* compatible Name ID claim:  
  
-   Create this rule to issue an [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] 1.x Name ID claim by using the **Pass Through or Filter an Incoming Claim** rule template.  
  
-   Create this rule to issue an [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] 1.x Name ID claim by using the **Transform an Incoming Claim** rule template. You can use this rule template when you want to change the existing claim type to a new claim type that works with [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] 1. *x* claims.  
  
> [!NOTE]  
> For this rule to work as expected, ensure that the relying party trust or claims provider trust where you create this rule has been configured to use the **AD FS 1.0 and 1.1 profile**.  
  
## Create a rule to issue an AD FS 1.*x* Name ID claim by using the Pass Through or Filter an Incoming Claim rule template  
You can use this rule template when you want the group that you specify in this template to ultimately determine what [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] 1.*x*\-compatible claim to issue.  
  
#### To create a rule to issue an AD FS 1.*x* Name ID claim by using the Pass Through or Filter an Incoming Claim rule template  
  
1.  In Server Manager, click **Tools**, and then select **AD FS Management**.  
  
2.  In the console tree, under **AD FS\\Trust Relationships**, click either **Claims Provider Trusts** or **Relying Party Trusts**, and then click a specific trust in the list where you want to create this rule.  
  
3.  Right\-click the selected trust, and then click **Edit Claim Rules**.  
  
4.  In the **Edit Claim Rules** dialog box, select one the following tabs, which depends on the trust that you are editing and in which rule set you want to create this rule, and then click **Add Rule** to start the rule wizard that is associated with that rule set:  
  
    -   **Acceptance Transform Rules**  
  
    -   **Issuance Transform Rules**  
  
    -   **Issuance Authorization Rules**  
  
    -   **Delegation Authorization Rules**  
  
5.  On the **Select Rule Template** page, under **Claim rule template**, select **Send LDAP Attributes as Claims** in the list, and then click **Next**.  
  
6.  On the **Configure Rule** page, type a claim rule name.  
  
7.  In **Incoming claim type**, select **Name ID** in the list.  
  
8.  In **Incoming name ID format**, select one of the following [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] 1.*x*\-compatible claim formats from the list:  
  
    -   **UPN**  
  
    -   **E\-Mail**  
  
    -   **Common Name**  
  
9. Select one of the following options, which depends on the requirements of your organization:  
  
    -   **Pass through all claim values**  
  
    -   **Pass through only a specific claim value**  
  
    -   **Pass through only claim values that match a specific email suffix value**  
  
    -   **Pass through only claim values that start with a specific value**  
  
10. Click **Finish**, and then click **OK** to save the rule.  
  
## Create a rule to issue an AD FS 1.*x* Name ID claim by using the Transform an Incoming Claim rule template  
You can use this rule template when you want to change the incoming claim type to a new outgoing claim type of Name ID that works with [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] 1.*x* federation servers.  
  
#### To create a rule to issue an AD FS 1.*x* Name ID claim by using the Transform an Incoming Claim rule template  
  
1.  In Server Manager, click **Tools**, and then select **AD FS Management**.  
  
2.  In the console tree, under **AD FS\\Trust Relationships**, click either **Claims Provider Trusts** or **Relying Party Trusts**, and then click a specific trust in the list where you want to create this rule.  
  
3.  Right\-click the selected trust, and then click **Edit Claim Rules**.  
  
4.  In the **Edit Claim Rules** dialog box, select one the following tabs, which depends on the trust that you are editing and in which rule set you want to create this rule, and then click **Add Rule** to start the rule wizard that is associated with that rule set:  
  
    -   **Acceptance Transform Rules**  
  
    -   **Issuance Transform Rules**  
  
    -   **Issuance Authorization Rules**  
  
    -   **Delegation Authorization Rules**  
  
5.  On the **Select Rule Template** page, under **Claim rule template**, select **Transform an Incoming Claim** in the list, and then click **Next**.  
  
6.  On the **Configure Rule** page, type a claim rule name.  
  
7.  In **Incoming claim type**, select the type of incoming claim that you want to transform in the list.  
  
8.  In **Outgoing claim type**, select **Name ID** in the list.  
  
9. In **Outgoing name ID format**, select one of the following [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] 1.*x*\-compatible claim formats from the list:  
  
    -   **UPN**  
  
    -   **E\-Mail**  
  
    -   **Common Name**  
  
10. Select one of the following options, which depends on the requirements of your organization:  
  
    -   **Pass through all claim values**  
  
    -   **Replace an incoming claim value with a different outgoing claim value**  
  
    -   **Replace incoming e\-mail suffix claims with a new e\-mail suffix**  
  
11. Click **Finish**, and then click **OK** to save the rule.  
  
## See Also  
[Configuring Claim Rules_1](../Topic/Configuring-Claim-Rules_1.md)  
  
