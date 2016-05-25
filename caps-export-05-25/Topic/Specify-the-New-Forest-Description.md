---
title: Specify the New Forest Description
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 597b8eb1-86d6-4b56-8cc9-879aadc846d2
author: Femila
---
# Specify the New Forest Description
  You can use this procedure to specify the new forest description for a domain rename operation. In this procedure, you use a text editor to specify your new target forest structure by editing the forest description file Domainlist.xml that you created with the procedure [Generate the Current Forest Description](../Topic/Generate-the-Current-Forest-Description.md). The new forest description, which is specified through changes to the domain and the application directory partition names in the Domainlist.xml file will form the starting point for the remainder of the steps in the domain rename operation.  
  
 You can change either the Domain Name System \(DNS\) name \(the field that is bounded by the \<DNSname\>\<\/DNSname\> tags\) or the NetBIOS name \(the field that is bounded by the \<NetBiosName\>\<\/ NetBiosName\> tags\), or both names, for any given domain in the forest. You cannot, however, change the globally unique identifier \(GUID\) in the field that is bounded by the \<Guid\>\<\/ Guid\> tags.  
  
 Furthermore, pay special attention to the fact that when the DNS name of a parent domain changes, the DNS name of its child domain should also be changed, unless you are deliberately restructuring the child domain into a new domain tree root in the forest. For example, if the root domain cohovineyard.com is renamed to cohowinery.com, the child domain sales.cohovineyard.com should also be renamed to sales.cohowinery.com, unless you want to make the domain sales.cohovineyard.com become the root of a new domain tree.  
  
 Here is a sample of a forest description Domainlist.xml file before and after you edit it for domain name changes to rename the root domain from cohovineyard.com to cohowinery.com. This name change of the forest root domain also results in a renaming of the child domain from sales.cohovineyard.com to sales.cohowinery.com. Furthermore, assume that the NetBIOS name of the root domain is also being changed from COHOVINEYARD to COHOWINERY.  
  
 **BEFORE editing \(root domain name: cohovineyard.com\)**  
  
```  
<Forest>  
  <Domain>  
    <!-— PartitionType:Application -->  
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
    <! — - PartitionType:Application -->  
    <Guid> f018941b-c899-4601-bfa7-5c017e9d31e7</Guid>  
    <DNSname>ForestDnsZones.cohovineyard.com</DNSname>  
    <NetBiosName></NetBiosName>  
    <DcName></DcName>  
  </Domain>  
  <Domain>  
    <! — - PartitionType:Application -->  
    <Guid> f018941b-c899-4601-bfa7-5c017e9d31f3</Guid>  
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
  
 **AFTER editing \(root domain name: cohowinery.com\)**  
  
```  
<Forest>  
  <Domain>  
    <!-— PartitionType:Application -->  
    <Guid>59add6bb-d0e8-499e-82b9-8aaca5d3e18b</Guid>  
    <DNSname>DomainDnsZones.sales.cohowinery.com</DNSname>  
    <NetBiosName></NetBiosName>  
    <DcName></DcName>  
  </Domain>  
  <Domain>  
    <Guid>89cf8ae3-f4a3-453b-ac5c-cb05a76bfa40</Guid>  
    <DNSname>sales.cohowinery.com</DNSname>  
    <NetBiosName>SALES</NetBiosName>  
    <DcName></DcName>  
  </Domain>  
  <Domain>  
    <! — - PartitionType:Application -->  
    <Guid> f018941b-c899-4601-bfa7-5c017e9d31e7</Guid>  
    <DNSname>ForestDnsZones.cohowinery.com</DNSname>  
    <NetBiosName></NetBiosName>  
    <DcName></DcName>  
  </Domain>  
  <Domain>  
    <! — - PartitionType:Application -->  
    <Guid> f018941b-c899-4601-bfa7-5c017e9d31f3</Guid>  
    <DNSname>DomainDnsZones.cohowinery.com</DNSname>  
    <NetBiosName></NetBiosName>  
    <DcName></DcName>  
  </Domain>  
  <Domain>  
    <! — - ForestRoot -->  
    <Guid>89cf6b34-d753-32a8-da6b-6a8e04bc48a4</Guid>  
    <DNSname>cohowinery.com</DNSname>  
    <NetBiosName>COHOWINERY</NetBiosName>  
    <DcName></DcName>  
  </Domain>  
</Forest>  
```  
  
> [!NOTE]  
>  The current forest description must be available as the XML\-encoded file Domainlist.xml that can be modified.  
  
 Membership in the **Local Administrators** group \(or write access to the domain rename C:\\domren working directory\) on the control station computer is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To edit the Domainlist.xml file  
  
1.  Use  a simple text editor, such as Notepad.exe, to open the current forest description file Domainlist.xml that you created in [Generate the Current Forest Description](../Topic/Generate-the-Current-Forest-Description.md).  
  
2.  Edit the forest description file, replacing the current DNS or NetBIOS names of the domains and application directory partitions to be renamed with the planned new DNS or NetBIOS names.  
  
    > [!NOTE]  
    >  It is not necessary to change the NetBIOS name of a domain when its DNS name changes.  
  
## Renaming application directory partitions  
 In the previous sample forest description Domainlist.xml file, notice that there are two DNSname entries that are not domains. These directory partitions are labeled as follows:  
  
```  
<!-— PartitionType:Application -->   
```  
  
 These directory partitions store DNS zone data. By default, application directory partitions can be used to store DNS zone data and Microsoft Telephony Application Programming Interface \(TAPI\) data in Active Directory Domain Services \(AD DS\). Other applications must be programmed to create and use application directory partitions in AD DS.  
  
 Application directory partitions can exist anywhere in the domain hierarchy where a domain directory partition can exist, except for the forest root or tree root domain positions. However, when you rename a domain, an application directory partition that occurs below the renamed domain in the domain tree is not renamed automatically. You must take care to edit the names of application directory partitions if they occur below a renamed domain in the hierarchy.  
  
## DNS data  
 If you have Active Directory–integrated DNS that is running on a domain controller, the DNS server might have created one or more application directory partitions to store data for DNS zones. There is one DNS\-specific application directory partition dedicated for each domain \(named DomainDnsZones.\<domain DNS name\>, where \<domain DNS name\> is the name of the domain\), and another DNS\-specific application directory partition dedicated for the entire forest \(named ForestDnsZones.\<forest DNS name\>, where \<forest DNS name\> is the name of the forest root domain\).  
  
> [!IMPORTANT]  
>  When an Active Directory forest root domain or other domain is renamed, the corresponding DNS\-specific application directory partition must be renamed. If the DNS\-specific application directory partition is not renamed, new DNS servers that are added to the network will not automatically load the DNS zones that are stored in the DNS\-specific application directory partition, and therefore they will not function correctly.  
  
 As you can see from the contents of the sample Domainlist.xml file before and after editing, the following three DNS\-specific application directory partitions in the original forest …  
  
```  
DomainDnsZones.sales.cohovineyard.com  
DomainDnsZones.cohovineyard.com  
ForestDnsZones.cohovineyard.com  
```  
  
 … are renamed to …  
  
```  
DomainDnsZones.sales.cohowinery.com  
DomainDnsZones.cohowinery.com  
ForestDnsZones.cohowinery.com  
```  
  
 … in the new forest as a result of the domain name sales.cohovineyard.com that is being changed to sales.cohowinery.com and the forest root domain name cohovineyard.com being changed to cohowinery.com, respectively.  
  
## TAPI data  
 If you have a Microsoft TAPI dynamic directory for a domain that is hosted by AD DS, you may have created one or more application directory partitions \(one for each domain\) to store TAPI application data. There is one TAPI\-specific application directory partition configured for each domain. When you rename an Active Directory domain, the corresponding TAPI\-specific application directory partition is not renamed automatically. We recommend that you rename a TAPI\-specific application directory partition when its corresponding domain name is changed.  
  
#### To rename application directory partitions  
  
1.  Examine the forest description file to determine if any application directory partitions in the forest must be renamed as a result of the domain DNS name changes that are being specified.  
  
2.  Consult the documentation for the application that created the application directory partition to see if the directory partition should be renamed. Any DNS name changes for application directory partitions must also be specified in the forest description file Domainlist.xml, along with the domain directory partition name changes.  
  
## Specifying the source domain controllers  
 In [Generate Domain Rename Instructions](../Topic/Generate-Domain-Rename-Instructions.md), the Rendom.exe tool contacts one arbitrarily chosen domain controller in each domain of the forest to gather the information that is required for translating your new forest specification in the Domainlist.xml file into a sequence of required directory changes that areee encoded as a script to be run at each domain controller. As an option, you can specify a particular domain controller in each domain from which to pull the domain\-specific information.  
  
#### To specify domain controllers for each renamed domain in domainlist.xml  
  
-   In the field that is bounded by the \<DcName\>\<\/DcName\> tags within each domain entry, type the DNS host name of the domain controller that you want to use. For example, to retrieve information for the domain sales.cohovineyard.com from the domain controller dc1.sales.cohovineyard.com, specify \<DcName\>dc1.sales.cohovineyard.com\<\/DcName\> within the domain entry for the renamed domain sales.cohowinery.com. \(Recall that domain controller names do not change when the domain is renamed.\)  
  
## Reviewing the new forest description  
 Verify that the domain name changes that you have specified in the forest description file Domainlist.xml yield the new forest structure that you want. You can use Rendom.exe to display the new forest structure that you specified in the Domainlist.xml file in a user\-friendly format by using text indentation to reflect the domain hierarchy.  
  
#### To review the new forest description in Domainlist.xml  
  
1.  Click **Start**, click **Run**, type **cmd**, and then click **OK**.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
    ```  
    rendom /showforest  
    ```  
  
     This command simply displays the contents of the Domainlist.xml file in a format that is easier to read and in which you can better see the forest structure. Use this command each time that you make any changes to the Domainlist.xml file to verify that the forest structure looks as you intended.  
  
    > [!NOTE]  
    >  It is essential at this step to specify an accurate forest description that reflects the desired changes to the forest structure, because any error at this stage will result in an unintended forest structure when the domain rename operation is complete. If your target structure is not what you intended, you must perform the entire domain rename procedure again.  
  
> [!NOTE]  
>  To gather the information that is necessary to process the **\/showforest** command\-line option, Rendom.exe contacts the domain controller that is the current domain naming master in the target forest. The command might fail if the domain naming master is unavailable or unreachable from the control station.  
  
  