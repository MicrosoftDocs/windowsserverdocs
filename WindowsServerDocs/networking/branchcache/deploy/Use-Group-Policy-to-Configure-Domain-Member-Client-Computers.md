---
title: Use Group Policy to Configure Domain Member Client Computers
description: This topic is part of the BranchCache Deployment Guide for Windows Server 2016, which demonstrates how to deploy BranchCache in distributed and hosted cache modes to optimize WAN bandwidth usage in branch offices
manager: dougkim
ms.prod: windows-server
ms.technology: networking-bc
ms.topic: get-started-article
ms.assetid: 911c1538-f79d-42e9-ba38-f4618f87b008
ms.author: lizross
author: eross-msft
ms.date: 06/02/2018
---
# Use Group Policy to Configure Domain Member Client Computers

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

In this section, you create a Group Policy Object for all of the computers in your organization, configure domain member client computers with distributed cache mode or hosted cache mode, and configure Windows Firewall with Advanced Security to allow BranchCache traffic.  
  
This section contains the following procedures.  
  
1.  [To create a Group Policy Object and configure BranchCache modes](#bkmk_gp)  
  
2.  [To configure Windows Firewall with Advanced Security Inbound Traffic Rules](#bkmk_inbound)  
  
3.  [To configure Windows Firewall with Advanced Security Outbound Traffic Rules](#bkmk_outbound)  
  
> [!TIP]  
> In the following procedure, you are instructed to create a Group Policy Object in the Default Domain Policy, however, you can create the object in an organizational unit (OU) or other container that is appropriate for your deployment.  
  
You must be a member of **Domain Admins**, or equivalent to perform these procedures.  
  
## <a name="bkmk_gp"></a>To create a Group Policy Object and configure BranchCache modes  
  
1.  On a computer upon which the Active Directory Domain Services server role is installed, in Server Manager, click **Tools**, and then click **Group Policy Management**. The Group Policy Management console opens.  
  
2.  In the Group Policy Management console, expand the following path: **Forest:** *example.com*, **Domains**, *example.com*, **Group Policy Objects**, where *example.com* is the name of the domain where the BranchCache client computer accounts that you want to configure are located.  
  
3.  Right-click **Group Policy Objects**, and then click **New**. The **New GPO** dialog box opens. In **Name**, type a name for the new Group Policy Object (GPO). For example, if you want to name the object BranchCache Client Computers, type **BranchCache Client Computers**. Click **OK**.  
  
4.  In the Group Policy Management console, ensure that **Group Policy Objects** is selected, and in the details pane right-click the GPO that you just created. For example, if you named your GPO BranchCache Client Computers, right-click **BranchCache Client Computers**. Click **Edit**. The Group Policy Management Editor console opens.  
  
5.  In the Group Policy Management Editor console, expand the following path: **Computer Configuration**, **Policies**, **Administrative Templates: Policy definitions (ADMX files) retrieved from the local computer**, **Network**, **BranchCache**.  
  
6.  Click **BranchCache**, and then in the details pane, double-click **Turn on BranchCache**. The policy setting dialog box opens.  
  
7.  In the **Turn on BranchCache** dialog box, click **Enabled**, and then click **OK**.  
  
8.  To enable BranchCache distributed cache mode, in the details pane, double-click **Set BranchCache Distributed Cache mode**. The policy setting dialog box opens.  
  
9. In the **Set BranchCache Distributed Cache mode** dialog box, click **Enabled**, and then click **OK**.  
  
10. If you have one or more branch offices where you are deploying BranchCache in hosted cache mode, and you have deployed hosted cache servers in those offices, double-click **Enable Automatic Hosted Cache Discovery by Service Connection Point**. The policy setting dialog box opens.  
  
11. In the **Enable Automatic Hosted Cache Discovery by Service Connection Point** dialog box, click **Enabled**, and then click **OK**.  
  
    > [!NOTE]  
    > When you enable both the **Set BranchCache Distributed Cache mode** and the **Enable Automatic Hosted Cache Discovery by Service Connection Point** policy settings, client computers operate in BranchCache distributed cache mode unless they find a hosted cache server in the branch office, at which point they operate in hosted cache mode.  
  
12. Use the procedures below to configure firewall settings on client computers by using Group Policy.  
  
## <a name="bkmk_inbound"></a>To configure Windows Firewall with Advanced Security Inbound Traffic Rules  
  
1.  In the Group Policy Management console, expand the following path: **Forest:** *example.com*, **Domains**, *example.com*, **Group Policy Objects**, where *example.com* is the name of the domain where the BranchCache client computer accounts that you want to configure are located.  
  
2.  In the Group Policy Management console, ensure that **Group Policy Objects** is selected, and in the details pane right-click the BranchCache client computers GPO that you created previously. For example, if you named your GPO BranchCache Client Computers, right-click **BranchCache Client Computers**. Click **Edit**. The Group Policy Management Editor console opens.  
  
3.  In the Group Policy Management Editor console, expand the following path: **Computer Configuration**, **Policies**, **Windows Settings**, **Security Settings**, **Windows Firewall with Advanced Security**, **Windows Firewall with Advanced Security - LDAP**, **Inbound Rules**.  
  
4.  Right-click **Inbound Rules**, and then click **New Rule**. The New Inbound Rule Wizard opens.  
  
5.  In **Rule Type**, click **Predefined**, expand the list of choices, and then click **BranchCache - Content Retrieval (Uses HTTP)**. Click **Next**.  
  
6.  In **Predefined Rules**, click **Next**.  
  
7.  In **Action**, ensure that **Allow the connection** is selected, and then click **Finish**.  
  
    > [!IMPORTANT]  
    > You must select **Allow the connection** for the BranchCache client to be able to receive traffic on this port.  
  
8.  To create the WS-Discovery firewall exception, again right-click **Inbound Rules**, and then click **New Rule**. The New Inbound Rule Wizard opens.  
  
9. In **Rule Type**, click **Predefined**, expand the list of choices, and then click **BranchCache - Peer Discovery (Uses WSD)**. Click **Next**.  
  
10. In **Predefined Rules**, click **Next**.  
  
11. In **Action**, ensure that **Allow the connection** is selected, and then click **Finish**.  
  
    > [!IMPORTANT]  
    > You must select **Allow the connection** for the BranchCache client to be able to receive traffic on this port.  
  
## <a name="bkmk_outbound"></a>To configure Windows Firewall with Advanced Security Outbound Traffic Rules  
  
1.  In the Group Policy Management Editor console, right-click **Outbound Rules**, and then click **New Rule**. The New Outbound Rule Wizard opens.  
  
2.  In **Rule Type**, click **Predefined**, expand the list of choices, and then click **BranchCache - Content Retrieval (Uses HTTP)**. Click **Next**.  
  
3.  In **Predefined Rules**, click **Next**.  
  
4.  In **Action**, ensure that **Allow the connection** is selected, and then click **Finish**.  
  
    > [!IMPORTANT]  
    > You must select **Allow the connection** for the BranchCache client to be able to send traffic on this port.  
  
5.  To create the WS-Discovery firewall exception, again right-click **Outbound Rules**, and then click **New Rule**. The New Outbound Rule Wizard opens.  
  
6.  In **Rule Type**, click **Predefined**, expand the list of choices, and then click **BranchCache - Peer Discovery (Uses WSD)**. Click **Next**.  
  
7.  In **Predefined Rules**, click **Next**.  
  
8.  In **Action**, ensure that **Allow the connection** is selected, and then click **Finish**.  
  
    > [!IMPORTANT]  
    > You must select **Allow the connection** for the BranchCache client to be able to send traffic on this port.  
  


