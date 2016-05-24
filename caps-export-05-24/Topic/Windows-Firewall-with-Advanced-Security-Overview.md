---
title: Windows Firewall with Advanced Security Overview
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 14bdf3d6-3eec-4a91-a231-11fbaa2bca07
author: vhorne
---
# Windows Firewall with Advanced Security Overview
This is an overview of the [!INCLUDE[wfas](../Token/wfas_md.md)] \(WFAS\) and Internet Protocol security \(IPsec\) features in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
**Did you mean…**  
  
-   *[Windows Firewall with Advanced Security in Windows Server 2008 R2](http://technet.microsoft.com/library/cc732283(WS.10).aspx)*  
  
## <a name="BKMK_OVER"></a>Feature description  
[!INCLUDE[wfas](../Token/wfas_md.md)] is an important part of a layered security model. By providing host\-based, two\-way network traffic filtering for a computer, [!INCLUDE[wfas](../Token/wfas_md.md)] blocks unauthorized network traffic flowing into or out of the local computer. [!INCLUDE[wfas](../Token/wfas_md.md)] also works with Network Awareness so that it can apply security settings appropriate to the types of networks to which the computer is connected. Windows Firewall and Internet Protocol Security \(IPsec\) configuration settings are integrated into a single Microsoft Management Console \(MMC\) named [!INCLUDE[wfas](../Token/wfas_md.md)], so Windows Firewall is also an important part of your network’s isolation strategy.  
  
## <a name="BKMK_APP"></a>Practical applications  
To help address your organizational network security challenges, [!INCLUDE[wfas](../Token/wfas_md.md)] offers the following benefits:  
  
-   **Reduces the risk of network security threats.** [!INCLUDE[wfas](../Token/wfas_md.md)] reduces the attack surface of a computer, providing an additional layer to the defense\-in\-depth model. Reducing the attack surface of a computer increases manageability and decreases the likelihood of a successful attack. Network Access Protection \(NAP\), a feature of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], also helps ensure client computers comply with policies that define the required software and system configurations for computers that connect to your network. The integration of NAP helps prevent communications between compliant and noncompliant computers.  
  
-   **Safeguards sensitive data and intellectual property.** With its integration with IPsec, [!INCLUDE[wfas](../Token/wfas_md.md)] provides a simple way to enforce authenticated, end\-to\-end network communications. It provides scalable, tiered access to trusted network resources, helping to enforce integrity of the data, and optionally helping to protect the confidentiality of the data.  
  
-   **Extends the value of existing investments.** Because [!INCLUDE[wfas](../Token/wfas_md.md)] is a host\-based firewall that is included with [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], and prior Windows operating systems and because it is tightly integrated with Active Directory® Domain Services \(AD DS\) and Group Policy, there is no additional hardware or software required. [!INCLUDE[wfas](../Token/wfas_md.md)] is also designed to complement existing non\-Microsoft network security solutions through a documented application programming interface \(API\).  
  
## <a name="BKMK_NEW"></a>New and changed functionality  
The following table lists some of the new features for [!INCLUDE[wfas](../Token/wfas_md.md)] in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
|Feature\/functionality|[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|  
|--------------------------|-----------------------------------------------------------------|-----------------------------------------------------------|  
|Internet Key Exchange version 2 \(IKEv2\) for IPsec transport mode||X|  
|Windows Store app network isolation||X|  
|Windows PowerShell cmdlets for Windows Firewall||X|  
  
### IKEv2 for IPsec transport mode  
In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], IKEv2 supports additional scenarios including IPsec end\-to\-end transport mode connections.  
  
**What value does this change add?**  
  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] IKEv2 support provides interoperability for Windows with other operating systems using IKEv2 for end\-to\-end security, and Supports Suite B \(RFC 4869\) requirements.  
  
**What works differently?**  
  
In [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], IKEv2 is available as a virtual private network \(VPN\) tunneling protocol that supports automatic VPN reconnection. IKEv2 allows the security association to remain unchanged despite changes in the underlying connection.  
  
In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], IKEv2 support has been expanded.  
  
### Windows Store app network isolation  
Administrators can custom configure Windows Firewall to fine tune network access if they desire more control of their Windows Store apps.  
  
**What value does this change add?**  
  
The feature adds the ability to set and enforce network boundaries ensure that apps that get compromised can only access networks where they have been explicitly granted access. This significantly reduces the scope of their impact to other apps, the system, and the network. In addition, apps can be isolated and protected from malicious access from the network.  
  
**What works differently?**  
  
In addition to firewall rules that you can create for program and services, you can also create firewall rules for Windows Store apps and their various capabilities.  
  
### Windows PowerShell cmdlets for Windows Firewall  
[!INCLUDE[wps_2](../Token/wps_2_md.md)] has extensive cmdlets to allow Windows Firewall configuration and management.  
  
**What value does this change add?**  
  
You can now fully configure and manage Windows Firewall, IPsec, and related features using the very powerful and scriptable [!INCLUDE[wps_2](../Token/wps_2_md.md)].  
  
**What works differently?**  
  
In previous Windows versions, you could use Netsh to perform many configuration and management functions. This capability has been greatly expanded using the more powerful [!INCLUDE[wps_2](../Token/wps_2_md.md)] scripting language.  
  
## <a name="BKMK_LINKS"></a>See also  
See the following topics for more information about [!INCLUDE[wfas](../Token/wfas_md.md)] in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
|Content type|References|  
|----------------|--------------|  
|**Deployment**|[Securing End-to-End IPsec Connections by Using IKEv2 in Windows Server 2012](../Topic/Securing-End-to-End-IPsec-Connections-by-Using-IKEv2-in-Windows-Server-2012.md) &#124; [Isolating Windows Store Apps on Your Network](../Topic/Isolating-Windows-Store-Apps-on-Your-Network.md) &#124; [Windows Firewall with Advanced Security Administration with Windows PowerShell](../Topic/Windows-Firewall-with-Advanced-Security-Administration-with-Windows-PowerShell.md)|  
|**Troubleshooting**|[Troubleshooting Windows Firewall with Advanced Security in Windows Server 2012](http://social.technet.microsoft.com/wiki/contents/articles/13894.troubleshooting-windows-firewall-with-advanced-security-in-windows-server-2012.aspx)|  
  
