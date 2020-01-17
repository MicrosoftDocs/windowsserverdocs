---
title: AD Forest Recovery - Devising an AD Forest Recovery Plan
description:
ms.author: joflore
author: MicrosoftGuyJFlo
manager: mtillman
ms.date: 08/09/2018
ms.topic: article
ms.prod: windows-server
ms.assetid: 17381f30-55f2-4e00-977a-b701675fa4ff
ms.technology: identity-adds
---
# AD Forest Recovery - Devising an AD Forest Recovery Plan

>Applies To: Windows Server 2016, Windows Server 2012 and 2012 R2, Windows Server 2008 and 2008 R2

Depending on your environment and business requirements, you might or might not need to perform all the steps described in this guide to perform a successful forest recovery. Given that this guide serves only as a template for forest recovery, it is vital that you devise a custom forest recovery plan that suits your environment and meets your business needs.  
  
For example, in your forest recovery plan, you should have a detailed topology map of your forests. The map should list all the information about the DCs, such as their names, their roles and backup status, and the trust relationships between them. For a tool that you can use to create a topology map, see [Microsoft Active Directory Topology Diagrammer](https://www.microsoft.com/download/details.aspx?id=13380).  
  
You should practice your forest recovery plan at least once a year. Also, it is a good idea to perform a forest recovery drill when there are membership changes to the Enterprise Admins or Domain Admins group. This helps ensure that your information technology (IT) staff fully understands the forest recovery plan.

## Next Steps

- [AD Forest Recovery - Prerequisites](AD-Forest-Recovery-Prerequisties.md)  
- [AD Forest Recovery - Devising a custom forest recovery plan](AD-Forest-Recovery-Devising-a-Plan.md)  
- [AD Forest Recovery - Identify the problem](AD-Forest-Recovery-Identify-the-Problem.md)
- [AD Forest Recovery - Determine how to recover](AD-Forest-Recovery-Determine-how-to-Recover.md)
- [AD Forest Recovery - Perform initial recovery](AD-Forest-Recovery-Perform-initial-recovery.md)  
- [AD Forest Recovery - Procedures](AD-Forest-Recovery-Procedures.md)  
- [AD Forest Recovery - Frequently Asked Questions](AD-Forest-Recovery-FAQ.md)  
- [AD Forest Recovery - Recovering a Single Domain within a Multidomain Forest](AD-Forest-Recovery-Single-Domain-in-Multidomain-Recovery.md)  
- [AD Forest Recovery - Forest Recovery with Windows Server 2003 Domain Controllers](AD-Forest-Recovery-Windows-Server-2003.md)
