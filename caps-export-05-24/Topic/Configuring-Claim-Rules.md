---
title: Configuring Claim Rules
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4ba23850-d3d7-41cf-8ad0-bf8744e6e8e4
author: billmath
---
# Configuring Claim Rules
To configure claim rules in your organization, complete each of the tasks in [Checklist: Creating Claim Rules for a Claims Provider Trust](../Topic/Checklist--Creating-Claim-Rules-for-a-Claims-Provider-Trust.md) or [Checklist: Creating Claim Rules for a Relying Party Trust](../Topic/Checklist--Creating-Claim-Rules-for-a-Relying-Party-Trust.md), depending on the federation role that your organization will play.  
  
> [!NOTE]  
> When you use either of these checklists, we recommend that you first read the references to understanding claims issuance and claim rules concepts in the [AD FS Design Guide in Windows Server 2012](../Topic/AD-FS-Design-Guide-in-Windows-Server-2012.md) before you begin the procedures for configuring claim rules. Following the checklist in this way provides a better understanding of the design and deployment process claim rules.  
  
## About Claim Rules  
In a claims\-based identity model, the function of [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)] as a federation service is to issue a token that contains a set of claims. The decision regarding what claims [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] issues is governed by claim rules. Claim rules \(and all server configuration dat\) are stored in the AD FS configuration database.  
  
[!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] makes issuance decisions based on identity information that is provided to it in the form of claims and other contextual information. At a high level, [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)]operates as a rules processor by taking one set of claims as input, performing a number of transformations, and then returning a different set of claims as output.  
  
