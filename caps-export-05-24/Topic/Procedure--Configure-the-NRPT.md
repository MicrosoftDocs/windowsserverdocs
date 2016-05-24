---
title: Procedure: Configure the NRPT
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 326c1651-bc10-4960-a7e6-e9959f668133
---
# Procedure: Configure the NRPT
Use the following procedures to configure the Name Resolution Policy Table \(NRPT\). The examples that are provided demonstrate how to add a rule in an existing Group Policy Object \(GPO\) that requires DNSSEC validation for a namespace \(zone\).  
  
Procedures are provided using the Group Policy Management Console d Windows PowerShell. When you have completed the procedures in this topic, return to the parent checklist.  
  
For more information about NRPT rule processing, see [The NRPT](../Topic/The-NRPT.md).  
  
Choose the Group Policy Management console Windows PowerShell to configure the NRPT:  
  
-   [Configure the NRPT with the Group Policy Management Console](../Topic/Procedure--Configure-the-NRPT.md#windows_ui)  
  
-   [Configure the NRPT with Windows PowerShell](../Topic/Procedure--Configure-the-NRPT.md#PS)  
  
## <a name="windows_ui"></a>Configure the NRPT with the Group Policy Management Console  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To configure the NRPT with the Group Policy Management Console  
  
1.  On a computer with the Group Policy Management feature installed, click **Tools** on the Server Manager menu, and then click **Group Policy Management**.  
  
2.  In the Group Policy Management Console tree, navigate to **Forest: contoso.com\\Domains\\contoso.com\\Group Policy Objects**.  
  
3.  Right\-click the Group Policy Object \(GPO\) that you wish to configure, and then click **Edit**.  
  
4.  In the Group Policy Management Editor tree, navigate to **Computer Configuration\\Policies\\Windows Settings\\Name Resolution Policy**.  
  
5.  Under **Create Rules**, choose the part of the namespace to which the rule will apply from the drop\-down list. For example, choose **Suffix** to create a rule that applies to all names that end in the text that you provide.  
  
    > [!TIP]  
    > To view an explanation of each choice in the drop\-down list, choose an item, and then click in the text box to the right. A description of the selected item is displayed to the left under **Description**.  
  
6.  Next to the drop\-down list item, for example, **Suffix**, type the namespace to which the rule will apply. For example, to apply a rule to all devices in the *secure.contoso.com* zone, choose **Suffix** and type **secure.contoso.com**.  
  
7.  On the **DNSSEC** tab, select the **Enable DNSSEC in this rule** check box, and then select the **Require DNS clients to check that name and address data has been validated by the DNS server**  check box.  
  
8.  At the bottom of this section of the NRPT, click **Create**.  
  
9. Under **Name Resolution Policy Table**, verify that the new rule is displayed.  
  
10. Close the Group Policy Management Editor.  
  
11. Close the Group Policy Management Console.  
  
## <a name="PS"></a>Configure the NRPT with Windows PowerShell  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
In the Windows PowerShell examples that are used, replace *secure.contoso.com* with the name of the zone you wish to sign with DNSSEC. Also replace the example computer names with names of the DNS servers you will use.  
  
#### To configure the NRPT with Windows PowerShell  
  
1.  Open an elevated Windows PowerShell prompt on a computer with the Group Policy Management feature installed.  
  
2.  To add an NRPT rule to an existing Group Policy Object \(GPO\), use the **Add\-DnsClientNrptRule** cmdlet. See the following example.  
  
    ```  
    PS C:\> Add-DnsClientNrptRule -GpoName NRPT_settings -NameSpace secure.contoso.com -DnsSecEnable -DnsSecValidationRequired  
    ```  
  
    In this example, the GPO named **NRPT\_settings** is configured with a rule requiring DNSSEC validation for the secure.contoso.com namespace.  
  
3.  To confirm that the GPO was successfully configured, use the **Get\-DnsClientNrptRule** cmdlet. See the following example.  
  
    ```  
    PS C:\> Get-DnsClientNrptRule -GpoName NRPT_settings  
  
    Name                             : Rule1  
    Version                          : 1  
    Namespace                        : {.adatum.com}  
    IPsecCARestriction               :  
    DirectAccessDnsServers           :  
    DirectAccessEnabled              : False  
    DirectAccessProxyType            :  
    DirectAccessProxyName            :  
    DirectAccessQueryIPsecEncryption :  
    DirectAccessQueryIPsecRequired   :  
    NameServers                      :  
    DnsSecEnabled                    : True  
    DnsSecQueryIPsecEncryption       :  
    DnsSecQueryIPsecRequired         : False  
    DnsSecValidationRequired         : True  
    NameEncoding                     : Disable  
    DisplayName                      :  
    Comment                          :  
  
    Name                             : {77BCF3D4-8442-49F1-9E73-4715CAD9888A}  
    Version                          : 1  
    Namespace                        : {secure.contoso.com}  
    IPsecCARestriction               :  
    DirectAccessDnsServers           :  
    DirectAccessEnabled              : False  
    DirectAccessProxyType            :  
    DirectAccessProxyName            :  
    DirectAccessQueryIPsecEncryption :  
    DirectAccessQueryIPsecRequired   :  
    NameServers                      :  
    DnsSecEnabled                    : True  
    DnsSecQueryIPsecEncryption       :  
    DnsSecQueryIPsecRequired         : False  
    DnsSecValidationRequired         : True  
    NameEncoding                     : Disable  
    DisplayName                      :  
    Comment                          :  
  
    ```  
  
    In this example, a second rule was added to the **NRPT\_settings** GPO. The rule for the *adatum.com* namespace was already present, and the rule for the *secure.contoso.com* namespace was added.  
  
## See also  
[DNSSEC in Windows](../Topic/DNSSEC-in-Windows.md)  
  
[DNSSEC Deployment Planning](../Topic/DNSSEC-Deployment-Planning.md)  
  
