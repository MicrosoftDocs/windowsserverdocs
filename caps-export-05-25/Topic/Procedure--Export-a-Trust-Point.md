---
title: Procedure: Export a Trust Point
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2ed671e0-9db6-4d67-af9f-e21cd1a4670c
author: vhorne
---
# Procedure: Export a Trust Point
Use the following procedures to export a trust point from a DNS server.  
  
When you sign a zone on a DNS server running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], the DNSKEY RRSET \(also called the Keyset\) is saved on the local server. When you sign a zone on a DNS server running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or later, the DNSKEY RRSET and the DS RRSET \(also called the DSSET\) are automatically saved in a text file on the Key Master. By default these files are available in the **%windir%\\system32\\dns** directory.  
  
For more information about trust points, see [Trust Anchors](../Topic/Trust-Anchors.md).  
  
Procedures are provided using the File Explorer and Windows PowerShell. You cannot export a trust point using DNS Manager. When you have completed the procedures in this topic, return to the parent checklist.  
  
Choose File Explorer or Windows PowerShell to perform this procedure:  
  
-   [Export a trust point using File Explorer](../Topic/Procedure--Export-a-Trust-Point.md#windows_ui)  
  
-   [Export a trust point using Windows PowerShell](../Topic/Procedure--Export-a-Trust-Point.md#PS)  
  
## <a name="windows_ui"></a>Export a trust point using File Explorer  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To export a trust point using File Explorer  
  
1.  Open File Explorer on the server where you wish to export the trust point, or connect to the DNS server from another location using File Explorer. The server must be the Key Master for the DNSSEC\-signed zone.  
  
2.  Navigate to the **%windir%\\system32\\dns** directory on the server.  
  
    If the trust point that you wish to export is a KEYSET \(DNSKEY\), then locate the *keyset\-<zone.name.com>* file. For example: *keyset\-secure.contoso.com*. If the trust point that is available is a DSSET \(DS\), then locate the *dsset\-<zone.name.com>* file. For example: *dsset\-secure.contoso.com*.  
  
    > [!TIP]  
    > If File Explorer is currently configured \(on the View menu\) not to display file name extensions, then the file names will appear to be their missing “.com” suffix.  
  
3.  Copy \(do not move\) the KEYSET—or DSSET—file to a trusted location where it can be imported to other DNS servers. For example, you might wish to copy files to a network share, USB flash drive, or other storage device.  
  
## <a name="PS"></a>Export a trust point using Windows PowerShell  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
To use the Windows PowerShell examples that are provided, replace server and zone names with the names you will use in your environment.  
  
#### To export a trust point using Windows PowerShell  
  
1.  Open an elevated Windows PowerShell prompt on the server where you wish to import the trust point.  
  
2.  To export a trust point, use the **Export\-DnsServerDnsSecPublicKey** cmdlet. See the following example.  
  
    ```  
    Export-DnsServerDnsSecPublicKey -ComputerName DC2.contoso.com -ZoneName secure.contoso.com -Path \\Myshare\keys  
    ```  
  
    In this example, a DNSKEY trust anchor for the zone *secure.contoso.com* is exported from the primary, authoritative DNS server DC2.contoso.com. The \\\\Myshare\\keys location must be accessible from DC2.contoso.com. To export a DS trust anchor, add the **DigestType** parameter. See the following example.  
  
    ```  
    Export-DnsServerDnsSecPublicKey -ComputerName DC2.contoso.com -ZoneName secure.contoso.com -Path \\Myshare\keys -DigestType sha1  
    ```  
  
After exporting DNSKEY or DS trust anchors, text files will be saved in the location specified by the **Path** parameter. You can use these file to import a trust anchor on another DNS server. For more information about importing a trust anchor, see [Procedure: Import a Trust Point](../Topic/Procedure--Import-a-Trust-Point.md).  
  
## See also  
[DNSSEC in Windows](../Topic/DNSSEC-in-Windows.md)  
  
[DNSSEC Deployment Planning](../Topic/DNSSEC-Deployment-Planning.md)  
  
