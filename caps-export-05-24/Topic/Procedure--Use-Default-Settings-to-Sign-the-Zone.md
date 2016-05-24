---
title: Procedure: Use Default Settings to Sign the Zone
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2be954e1-e711-47d3-a6ee-9c90d4f3007f
---
# Procedure: Use Default Settings to Sign the Zone
Use the following procedures to sign a zone with default settings. Procedures are provided using the DNS Manager console and Windows PowerShell. When you have completed the procedures in this topic, return to the parent checklist.  
  
Also see [DNS Zones](../Topic/DNS-Zones.md) for additional information about zone signing and DNSSEC parameter values.  
  
Choose DNS Manager or Windows PowerShell to sign the zone with default parameter values:  
  
-   [Sign a zone using default parameters in DNS Manager](../Topic/Procedure--Use-Default-Settings-to-Sign-the-Zone.md#windows_ui)  
  
-   [Sign a zone using default parameters in Windows PowerShell](../Topic/Procedure--Use-Default-Settings-to-Sign-the-Zone.md#PS)  
  
## <a name="windows_ui"></a>Sign a zone using default parameters in DNS Manager  
The **Zone Signing Wizard** is used to sign a zone in DNS Manager. For examples of the wizard, see [Zone Signing Wizard](../Topic/DNS-Zones.md#zsw).  
  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To sign a zone using default parameters in DNS Manager  
  
1.  Open DNS Manager on a primary, authoritative DNS server, or connect to a primary, authoritative DNS server with DNS Manager.  
  
2.  In the console tree, right\-click an unsigned zone, point to **DNSSEC**, and then click **Sign the Zone**.  
  
3.  Click **Next**, on the **Signing Options** page choose **Use default settings to sign the zone**, and then click **Next**.  
  
4.  You can review current choices for all DNSSEC parameter values on this page. Click **Back** to configure different parameter values, click **Cancel** to close the zone signing wizard without signing the zone, or click **Next** to begin signing the zone.  
  
5.  Verify that **The zone has been successfully signed** is displayed, and then click **Finish**.  
  
## <a name="PS"></a>Sign a zone using default parameters in Windows PowerShell  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
In the Windows PowerShell commands that are used, replace *secure.contoso.com* with the name of the zone you wish to sign with DNSSEC. Also replace the example computer names with names of the DNS servers you will use.  
  
#### To sign a zone using default parameters in Windows PowerShell  
  
1.  Open an elevated Windows PowerShell prompt on a primary, authoritative DNS server.  
  
2.  To sign the zone with default parameters, use the **Invoke\-DnsServerZoneSign** cmdlet with the **SignWithDefault** parameter. See the following example:  
  
    ```  
    Invoke-DnsServerZoneSign -ZoneName secure.contoso.com –SignWithDefault -Force  
    ```  
  
    In this example, the **Force** parameter is used to skip confirmation and immediately sign the zone. If you do not use the **Force** parameter, the default zone signing parameter values are displayed and you must confirm that you wish to sign the zone.  
  
By default, the local DNS server will be the Key Master.  
  
## See also  
[DNSSEC in Windows](../Topic/DNSSEC-in-Windows.md)  
  
[DNSSEC Deployment Planning](../Topic/DNSSEC-Deployment-Planning.md)  
  
