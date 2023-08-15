---
description: "Learn more about: Checklist: Configuring AD FS to Send Claims to an AD FS 1.x Claims-Aware Web Agent"
ms.assetid: 551c1a0d-8d30-41b4-9c4a-35a3337dd3bc
title: Configuring AD FS to Send Claims to an AD FS 1.x Claims-Aware Web Agent
author: billmath
manager: amycolannino
ms.date: 08/15/2023
ms.topic: article
ms.author: billmath
---

# Checklist: Configuring AD FS to Send Claims to an AD FS 1.x Claims-Aware Web Agent


## Checklist: Configuring AD FS to send claims to an AD FS 1.x claims\-aware Web agent
This checklist includes the tasks that are necessary for configuring your Active Directory Federation Services \(AD FS\) Federation Service in  Windows Server 2012  to send claims that can be understood by an application that is hosted by a Web server running the AD FS 1.*x* claims\-aware Web agent.

> [!NOTE]
> Complete the tasks in this checklist in order. When a reference link takes you to a procedure, return to this topic after you complete the steps in that procedure so that you can proceed with the remaining tasks in this checklist.

![Check mark icon, Configure AD FS to send claims to an AD FS 1.x claims-aware Web agent.](media/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)**Checklist: Configuring AD FS to send claims to an AD FS 1.x claims\-aware Web agent**

|Task|Reference|
|--------|-------------|
|Plan for interoperability between AD FS in  Windows Server 2012  and previous versions of AD FS and learn more about the Name ID claim type.|![Icon, Plan for interoperability between AD FS in Windows Server 2012.](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Planning for Interoperability with AD FS 1.x](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/ff678040(v=ws.11))|
|If you have not already done so, use the link on the right to first create a relying party trust between the AD FS Federation Service in  Windows Server 2012  and the AD FS 1.*x* Federation Service.|[Checklist: Configuring AD FS to Send Claims to an AD FS 1.x Federation Service](Checklist--Configuring-AD-FS-to-Send-Claims-to-an-AD-FS-1.x-Federation-Service.md)|
|Before you can achieve interoperation with an application that is hosted by the AD FS 1.*x* claims\-aware Web agent, you must first create a relying party trust in the AD FS Federation Service in  Windows Server 2012  to the AD FS 1. *x* claims\-aware Web agent. **Note:** Creating this trust in the AD FS Federation Service is the equivalent of adding a new **Application** to the AD FS 1.x Federation Service \(**Federation Service\\Trust Policy\\My Organization\\Application**\). This relying party trust is necessary because AD FS does not have an equivalent **Application** node in its own snap\-in. However, it still must have a secure channel to the application.<p>When you set up the trust using the procedure in the link to the right, you must do the following in the Add Relying Party Trust Wizard to set up this trust to interoperate with an AD FS 1.*x* claims\-aware Web agent:<p>1.  On the **Select Data Source** page, select **Enter data about the relying party trust manually**.<br />2.  On the **Choose Profile** page, select **AD FS 1.0 and 1.1 profile**.<br />3.  On the **Configure URL** page, under **WS\-Federation Passive URL**, type the **Application URL** as defined in the AD FS 1.*x* Federation Service of the partner.<br />4.  On the **Configure Identifiers** page, under **Relying part trust identifier**, type the **Application URL**  as defined in the AD FS 1.*x* claims\-aware Web agent|![Icon, Create a relying party trust.](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Create a Relying Party Trust Manually](../../ad-fs/operations/Create-a-Relying-Party-Trust.md)|
|Contact the administrator of the Web server running the AD FS 1.*x* claims\-aware Web agent and have that administrator edit the web.config file that is associated with the claims\-aware application \(under the Default Web Site in Internet Information Services \(IIS\)\) to point the Web agent at the AD FS Federation Service.<p>For example, replace *myresourcefederationserver* in the tag `<fs>https://myresourcefederationserver/adfs/fs/federationserverservice.asmx</fs>` of the web.config file with a valid AD FS federation server name.<p>This is necessary for the application and AD FS 1.x claims\-aware Web agent to be able to consume the claims that are sent to it from the AD FS Federation Service in  Windows Server 2012 .|N\/A|
|On the relying party trust that you created earlier, you have to create claim rules that will take incoming claims that were extracted from an attribute store and pass through, filter, or transform them into a Name ID claim type that can be understood and consumed by the AD FS 1.*x* claims\-aware Web agent. **Note:** Before you create this rule, make sure that the claim rule set where you are creating this rule has a rule that comes before it that first extracts a Lightweight Directory Access Protocol \(LDAP\) attribute claim from an attribute store. This claim will be used as input to the rule that you create to send an AD FS 1.*x*\-compatible claim. For more information about how to create a rule to extract an LDAP attribute, see [Create a Rule to Send LDAP Attributes as Claims](../../ad-fs/operations/Create-a-Rule-to-Send-LDAP-Attributes-as-Claims.md).|![configure AD FS to send claims](media/faa393df-4856-4431-9eda-4f4e5be72a90.gif)[Create a Rule to Send an AD FS 1.x Compatible Claim](../../ad-fs/operations/Create-a-Rule-to-Send-an-AD-FS-1x-Compatible-Claim.md)|

