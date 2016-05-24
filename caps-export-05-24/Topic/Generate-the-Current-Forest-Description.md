---
title: Generate the Current Forest Description
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 9dcf8a2b-4a52-4f31-8fc0-a0138023f849
author: Femila
---
# Generate the Current Forest Description
  You can use this procedure to generate a current forest description for a domain rename operation. In this procedure, you use the domain rename tool Rendom.exe to generate a textual description of your current forest structure as an XML\-encoded file named Domainlist.xml, which contains a list of all domain directory partitions as well as application directory partitions that constitute your forest. This file includes an entry for every domain and application directory partition, and each entry is bounded by the \<Domain\>\<\/Domain\> XML tags. Each entry for a domain \(or an application directory partition\) contains its naming data, which includes the object globally unique identifier \(GUID\) of the partition root object, the Domain Name System \(DNS\) name of the domain \(or application directory partition\), and the NetBIOS name of the domain. \(An application directory partition does not have a NetBIOS name.\) The domain name changes will be specified from this XML\-encoded forest description file in the subsequent step of the domain rename operation.  
  
 The following is a sample Domainlist.xml file that is generated in a forest with two domains named cohovineyard.com \(with a NetBIOS name of COHOVINEYARD\) and sales.cohovineyard.com \(with a NetBIOS name of SALES\). In addition to the two entries that correspond to the two domains in the forest, the following three entries appear. These entries correspond to the application directory partitions that the Active Directory–integrated DNS service uses:  
  
-   DomainDnsZones.sales.cohovineyard.com  
  
-   DomainDnsZones.cohovineyard.com  
  
-   ForestDnsZones.cohovineyard.com  
  
 These application directory partitions must also be renamed.  
  
```  
<?xml version = “1.0”?>  
<Forest>  
  <Domain>  
    <!-- PartitionType:Application -->  
    <Guid>59add6bb-d0e8-499e-82b9-8aaca5d3e18b</Guid>  
    <DNSname>DomainDnsZones.sales.cohovineyard.com</DNSname>  
    <NetBiosName></NetBiosName>  
    <DcName></DcName>  
  </Domain>  
  <Domain>  
    <Guid>89cf8ae3-f4a3-453b-ac5c-cb05a76bfa40</Guid>  
    <DNSname>sales.cohovineyard.com</DNSname>  
    <NetBiosName>SALES</NetBiosName>  
    <DcName></DcName>  
  </Domain>  
  <Domain>  
    <!-- PartitionType:Application -->  
    <Guid>f018941b-c899-4601-bfa7-5c017e9d31e7</Guid>  
    <DNSname>ForestDnsZones.cohovineyard.com</DNSname>  
    <NetBiosName></NetBiosName>  
    <DcName></DcName>  
  </Domain>  
  <Domain>  
    <!-- PartitionType:Application -->  
    <Guid>f018941b-c899-4601-bfa7-5c017e9d31f3</Guid>  
    <DNSname>DomainDnsZones.cohovineyard.com</DNSname>  
    <NetBiosName></NetBiosName>  
    <DcName></DcName>  
  </Domain>  
  <Domain>  
    <! — - ForestRoot -->  
    <Guid>89cf6b34-d753-32a8-da6b-6a8e04bc48a4</Guid>  
    <DNSname>cohovineyard.com</DNSname>  
    <NetBiosName>COHOVINEYARD</NetBiosName>  
    <DcName></DcName>  
  </Domain>  
</Forest>  
```  
  
> [!IMPORTANT]  
>  The functional level of the forest in which you perform the domain rename operation must be set to Windows Server 2003 or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. Otherwise, the domain rename tool, Rendom.exe, reports an error and it cannot proceed with further steps.  
  
 Membership in the **Enterprise Admins** group in the current forest and the **Local Administrators** group \(or write access to the domain rename C:\\domren working directory\) on the control station computer is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
> [!NOTE]  
>  You can use credentials other than those credentials with which you are currently logged on. To use alternative credentials, use the **\/user** and **\/pwd** command\-line switches of **rendom**, as described in [Appendix A: Command-Line Syntax for the Rendom Tool](../Topic/Appendix-A--Command-Line-Syntax-for-the-Rendom-Tool.md).  
  
### To generate the current forest description file  
  
1.  On the control station, click **Start**, click **Run**, type **cmd**, and then click **OK**.  
  
2.  At the command prompt, type the following command to change to the working directory, and then press ENTER:  
  
    ```  
    C:\domren  
    ```  
  
3.  To generate the XML\-encoded forest description file, at the command prompt, type the following command, and then press ENTER:  
  
    ```  
    rendom /list  
    ```  
  
4.  Save a copy of the current forest description file \(Domainlist.xml\) that was generated in step 3 as Domainlist\-save.xml for future reference by using the following copy command:  
  
    ```  
    copy domainlist.xml domainlist-save.xml  
    ```  
  
> [!NOTE]  
>  The Rendom tool contacts the domain controller that is the current domain naming operations master role owner in the target forest to gather the information that is necessary to generate the forest description file. The command might fail if the domain naming master is unavailable or unreachable from the control station.  
  
  