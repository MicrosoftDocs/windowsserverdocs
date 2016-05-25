---
title: Procedure: Remove a Trust Point
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5d1b5956-4b73-4153-ab22-a36d66e083a6
author: vhorne
---
# Procedure: Remove a Trust Point
Use the following procedures to delete trust anchors from a DNS server. Before deleting a trust anchor, you might wish to export trust points for purposes of backup. For information about exporting a trust point, see [Procedure: Export a Trust Point](../Topic/Procedure--Export-a-Trust-Point.md).  
  
For more information about trust points, see [Trust Anchors](../Topic/Trust-Anchors.md).  
  
Procedures are provided using the DNS Manager console and Windows PowerShell. When you have completed the procedures in this topic, return to the parent checklist.  
  
Choose DNS Manager or Windows PowerShell to perform this procedure:  
  
-   [Delete a trust point using DNS Manager](../Topic/Procedure--Remove-a-Trust-Point.md#windows_ui)  
  
-   [Delete a trust point using Windows PowerShell](../Topic/Procedure--Remove-a-Trust-Point.md#PS)  
  
## <a name="windows_ui"></a>Delete a trust point using DNS Manager  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To delete a trust point using DNS Manager  
  
1.  Open DNS Manager on the server where you wish to delete the trust point, or connect to the DNS server from another location using DNS Manager.  
  
2.  In the console tree, navigate to the location under **Trust Points** corresponding to the zone for which you will delete a trust point. For example, to delete a trust point for the zone secure.contoso.com, navigate to Trust Points > com > contoso > secure.  
  
3.  In the right\-hand pane, right\-click the trust anchor you wish to remove, and then click **Delete**.  
  
When the last trust anchor is removed for a zone, right\-click **Trust Points** in DNS Manager, and then click **Refresh** to remove the container \(folder\) in DNS Manager for that namespace.  
  
## <a name="PS"></a>Delete a trust point using Windows PowerShell  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
To use the Windows PowerShell examples that are provided, replace server and zone names with the names you will use in your environment.  
  
#### To delete a trust point using Windows PowerShell  
  
1.  Open an elevated Windows PowerShell prompt on the server where you wish to delete the trust point.  
  
2.  To delete a trust point, use the **Remove\-DnsServerTrustAnchor** cmdlet. See the following example.  
  
    ```  
    Remove-DnsServerTrustAnchor -Name secure.contoso.com -Type DS -Force  
    ```  
  
    In the previous example, the **Type** parameter was used to specify that only DSSET trust anchors should be deleted from the local server for the *secure.contoso.com zone*.  
  
3.  To delete DNSKEY trust anchors, specify a **Type** of DnsKey. See the following example.  
  
    ```  
    Remove-DnsServerTrustAnchor -Name fb.contoso.com -Type DnsKey -Force  
    ```  
  
4.  To delete all trust anchors, do not specify the **Type** parameter.  
  
When the last trust anchor is removed for a zone using Windows PowerShell, the container \(folder\) in DNS Manager for that namespace is also removed.  
  
## See also  
[DNSSEC in Windows](../Topic/DNSSEC-in-Windows.md)  
  
[DNSSEC Deployment Planning](../Topic/DNSSEC-Deployment-Planning.md)  
  
