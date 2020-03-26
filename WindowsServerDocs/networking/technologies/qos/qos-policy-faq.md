---
title: QoS Frequently Asked Questions
description: This topic provides answers to questions about Quality of Service (QoS) Policy in Windows Server 2016.
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: 74c97a14-b957-4568-b48e-8963a674fdb3
manager: brianlic
ms.author: lizross
author: eross-msft
---

# QoS Policy Frequently Asked Questions

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

Following are frequently asked questions – and answers to those questions – for QoS Policy.
  
1.  **What operating system does my domain controller need to be running to use QoS Policy?**
  
     Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, or Windows Server 2008

2.  **What operating systems support the application of QoS Policy to the user or computer?**

     You can apply QoS policies to users or computers running Windows Server 2016, Windows 10, Windows Server 2012 R2, Windows 8.1, Windows Server 2012, Windows 8, Windows Server 2008 R2, Windows Server 2008, and Windows Vista.

3.  **Do QoS policies apply to the sender or receiver of traffic?**

     QoS policies must be applied on the sending computer to affect its outbound traffic. In order to affect the bidirectional traffic of two computers, QoS policies need to be applied to both computers.

4.  **What happens if conflicting QoS policies are deployed to the same computer?**  
  
     If multiple policies apply, the more specific QoS policy takes precedence. For example, a policy that states a host address (192.168.4.12) gets applied instead of a less specific network address (192.168.0.0/16). If a computer-level and user-level policy have the same specificity, the user-level QoS policy is applied instead of the computer-level QoS policy. 

5.  **Is QoS Policy enabled by default?**

     No, QoS Policy is not enabled by default. You must create QoS policies manually to enable QoS.  For more information, see [Manage QoS Policy](qos-policy-manage.md).

For the first topic in this guide, see [Quality of Service (QoS) Policy](qos-policy-top.md).
