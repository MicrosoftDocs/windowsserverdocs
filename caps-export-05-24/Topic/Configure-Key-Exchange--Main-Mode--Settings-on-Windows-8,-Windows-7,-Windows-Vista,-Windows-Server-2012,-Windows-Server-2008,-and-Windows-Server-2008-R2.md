---
title: Configure Key Exchange (Main Mode) Settings on Windows 8, Windows 7, Windows Vista, Windows Server 2012, Windows Server 2008, and Windows Server 2008 R2
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3f61e22e-f4e1-4843-b3d4-402b3e04f15d
author: vhorne
---
# Configure Key Exchange (Main Mode) Settings on Windows 8, Windows 7, Windows Vista, Windows Server 2012, Windows Server 2008, and Windows Server 2008 R2
This procedure shows you how to configure the main mode key exchange settings used to secure the IPsec authentication traffic.  
  
**Administrative credentials**  
  
To complete these procedures, you must be a member of the Domain Administrators group, or otherwise be delegated permissions to modify the GPOs.  
  
### To configure key exchange settings  
  
1.  [Open the Group Policy Management Console to Windows Firewall with Advanced Security](../Topic/Open-the-Group-Policy-Management-Console-to-Windows-Firewall-with-Advanced-Security.md).  
  
2.  In the details pane on the main [!INCLUDE[wfas](../Token/wfas_md.md)] page, click **Windows Firewall Properties**.  
  
3.  On the **IPsec Settings** tab, click **Customize**.  
  
4.  In the **Key exchange \(Main Mode\)** section, click **Advanced**, and then click **Customize**.  
  
5.  Select the security methods to be used to help protect the main mode negotiations between the two computers. If the security methods displayed in the list are not what you want, then do the following:  
  
    > [!IMPORTANT]  
    > In [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)], [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], you can specify only one key exchange algorithm. This means that if you want to communicate by using IPsec with another computer running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], then you must select the same key exchange algorithm on both computers.  
    >   
    > Also, if you create a connection security rule that specifies an option that requires AuthIP instead of IKE, then only the one combination of the top integrity and encryption security method are used in the negotiation. Make sure that all of your computers that run [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)], [!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] have the same methods at the top of the list and the same key exchange algorithm selected.  
  
    > [!NOTE]  
    > When AuthIP is used, no Diffie\-Hellman key exchange protocol is used. Instead, when Kerberos V5 authentication is requested, the Kerberos V5 service ticket secret is used in place of a Diffie\-Hellman value. When either certificate authentication or NTLM authentication is requested, a transport level security \(TLS\) session is established, and its secret is used in place of the Diffie\-Hellman value. This happens no matter which Diffie\-Hellman key exchange protocol you select.  
  
    1.  Remove any of the security methods that you do not want by selecting the method and then clicking **Remove**.  
  
    2.  Add any required security method combinations by clicking **Add**, selecting the appropriate encryption algorithm and integrity algorithm from the lists, and then clicking **OK**.  
  
        > [!CAUTION]  
        > We recommend that you do not include MD5 or DES in any combination. They are included for backward compatibility only.  
  
    3.  After the list contains only the combinations you want, use the up and down arrows to the right of the list to arrange them in the order of preference. The combination that appears first in the list is tried first, and so on.  
  
6.  From the list on the right, select the key exchange algorithm that you want to use.  
  
    > [!CAUTION]  
    > We recommend that you do not use Diffie\-Hellman Group 1. It is included for backward compatibility only.  
  
7.  In **Key lifetime \(in minutes\)**, type the number of minutes. When the specified number of minutes has elapsed, any IPsec operation between the two computers requires a new key.  
  
    > [!NOTE]  
    > You need to balance performance with security requirements. Although a shorter key lifetime results in better security, it also reduces performance.  
  
8.  In **Key lifetime \(in sessions\)**, type the number of sessions. After the specified number of quick mode sessions have been created within the security association protected by this key, IPsec requires a new key.  
  
9. Click **OK** three times to save your settings.  
  
If you arrived at this page by clicking a link in a checklist, use your browser’s **Back** button to return to the checklist.  
  
