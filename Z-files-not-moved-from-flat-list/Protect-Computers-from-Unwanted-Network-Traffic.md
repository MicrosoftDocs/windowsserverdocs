---
title: Protect Computers from Unwanted Network Traffic
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0dcd0001-09dc-4c41-b04a-4f7f820384ab
---
# Protect Computers from Unwanted Network Traffic
Although network perimeter firewalls provide important protection to network resources from external threats, there are network threats that a perimeter firewall cannot protect against. Some attacks might successfully penetrate the perimeter firewall, and at that point what can stop it? Other attacks might originate from inside the network, such as a computer virus that is brought in on portable media and run on a trusted computer. Portable computers are often taken outside the network and connected directly to the Internet, without adequate protection between the computer and security threats.

Reports of targeted attacks against organizations, governments, and individuals have become more widespread in recent years. For a general overview of these threats, also known as advanced persistent threats (APT), see the [Microsoft Security Intelligence Report](http://download.microsoft.com/download/C/9/A/C9A544AD-4150-43D3-80F7-4F1641EF910A/Microsoft_Security_Intelligence_Report_Volume_12_Key_Findings_Summary_English.pdf) at http://download.microsoft.com/download/C/9/A/C9A544AD-4150-43D3-80F7-4F1641EF910A/Microsoft_Security_Intelligence_Report_Volume_12_Key_Findings_Summary_English.pdf.

Running a host-based firewall on every computer that your organization manages is an important layer in a "defense-in-depth" security strategy. A host-based firewall can help protect against attacks that originate from inside the network and also provide additional protection against attacks from outside the network that manage to penetrate the perimeter firewall. It also travels with a portable computer to provide protection when it is away from the organization's network.

A host-based firewall helps secure a computer by dropping all network traffic that does not match the administrator-designed rule set for permitted network traffic. This design, which corresponds to [Basic Firewall Policy Design](https://technet.microsoft.com/library/cc753180.aspx), provides the following benefits:

-   Network traffic that is a reply to a request from the local computer is permitted into the computer from the network.

-   Network traffic that is unsolicited, but that matches a rule for allowed network traffic, is permitted into the computer from the network.

    For example, Woodgrove Bank wants a computer that is running SQL Server to be able to receive the SQL queries sent to it by client computers. The firewall policy deployed to the computer that is running SQL Server includes firewall rules that specifically allow inbound network traffic for the SQL Server program.

-   Outbound network traffic that is not specifically blocked is allowed on the network.

    For example, Woodgrove Bank has a corporate policy that prohibits the use of certain peer-to-peer file sharing programs. The firewall policy deployed to the computers on the network includes firewall rules that block both inbound and outbound network traffic for the prohibited programs. All other outbound traffic is permitted.

The following component is recommended for this deployment goal:

-   **Active Directory**: Active Directory supports centralized management of connection security rules by configuring the rules in one or more Group Policy objects (GPOs) that can be automatically applied to all relevant computers in the domain. For more information about Active Directory, see [Additional Resources \[lhs\]](https://technet.microsoft.com/library/cc753180.aspx).

Other means of deploying a firewall policy are available, such as creating scripts that use the **netsh** command-line tool, and then running those scripts on each computer in the organization. This guide uses Active Directory as a recommended means of deployment because of its ability to scale to very large organizations.

**Next:**[Restrict Access to Only Trusted Computers](https://technet.microsoft.com/library/cc725659.aspx)


