---
title: Checklist: Configuring AD FS to Send Claims to an AD FS 1.x Federation Service
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: cca09569-a55c-4672-8501-1e2d9baed3bd
author: billmath
---
# Checklist: Configuring AD FS to Send Claims to an AD FS 1.x Federation Service
  
## Checklist: Configuring AD FS to send claims to an AD FS 1.x Federation Service  
This checklist includes the tasks that are necessary for configuring your [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)] Federation Service in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] to send claims that can be understood by an AD FS 1.*x* Federation Service.  
  
> [!NOTE]  
> Complete the tasks in this checklist in order. When a reference link takes you to a procedure, return to this topic after you complete the steps in that procedure so that you can proceed with the remaining tasks in this checklist.  
  
![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)**Checklist: Configuring AD FS to send claims to an AD FS 1.x Federation Service**  
  
||Task|Reference|  
|-|--------|-------------|  
|![](../Image/icon_checkboxo.gif)|Plan for interoperability between AD FS in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and previous versions of AD FS and learn more about the Name ID claim type.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Planning for Interoperability with AD FS 1.x](../Topic/Planning-for-Interoperability-with-AD-FS-1.x.md)|  
|![](../Image/icon_checkboxo.gif)|Before you can achieve interoperability with a previous version of AD FS, you must first create a relying party trust in the AD FS Federation Service to the AD FS 1.*x* Federation Service. **Note:** You cannot create a trust with an AD FS 1.*x* Federation Service by using federation metadata.<br /><br />When you set up the trust using the procedure in the link to the right, you must do the following in the Add Relying Party Trust Wizard to set up this trust to interoperate with an AD FS 1.*x* Federation Service:<br /><br />1.  On the **Select Data Source** page, select **Enter data about the relying party trust manually**.<br />2.  On the **Choose Profile** page, select **AD FS 1.0 and 1.1 profile**.<br />3.  On the **Configure URL** page, under **WS\-Federation Passive URL**, type the **Federation Service endpoint URL** as defined in the AD FS 1.*x* Federation Service of the partner.<br />4.  On the **Configure Identifiers** page, under **Relying part trust identifier**, type the **Federation Service URI** as defined in the AD FS 1.*x* Federation Service of the partner.|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Create a Relying Party Trust Manually](../Topic/Create-a-Relying-Party-Trust-Manually.md)|  
|![](../Image/icon_checkboxo.gif)|On the relying party trust that you created earlier, you must create claim rules that will take incoming claims that were extracted from an attribute store and pass through, filter, or transform them into a Name ID claim type that can be understood and consumed by the AD FS 1.*x* Federation Service. **Note:** Before you create this rule, make sure that the claim rule set where you are creating this rule has a rule that comes before it that first extracts a Lightweight Directory Access Protocol \(LDAP\) attribute claim from an attribute store. This claim will be used as input to the rule that you create to send an AD FS 1.*x*\-compatible claim. For more information about how to create a rule to extract an LDAP attribute, see [Create a Rule to Send LDAP Attributes as Claims_1](../Topic/Create-a-Rule-to-Send-LDAP-Attributes-as-Claims_1.md).|![](../Image/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Create a Rule to Send an AD FS 1.x Compatible Claim_1](../Topic/Create-a-Rule-to-Send-an-AD-FS-1.x-Compatible-Claim_1.md)|  
|![](../Image/icon_checkboxo.gif)|Contact the administrator of the AD FS 1.*x* Federation Service and have the administrator of the AD FS 1.*x* Federation Service set up a new account partner trust. Also, provide that administrator with the Federation Service URI \(in the Federation Service properties\), the WS\-Federation Passive endpoint URL \(the Federation Service endpoint URL\), and an exported token\-signing certificate file \(with public key only\). That administrator will need these items to set up the trust.|N\/A|  
  
