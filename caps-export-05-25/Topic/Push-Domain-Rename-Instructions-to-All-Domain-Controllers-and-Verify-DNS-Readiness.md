---
title: Push Domain Rename Instructions to All Domain Controllers and Verify DNS Readiness
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 3ef12c8f-364a-4073-8dab-90d1fab6accf
author: Femila
---
# Push Domain Rename Instructions to All Domain Controllers and Verify DNS Readiness
  You can use this procedure to push domain rename instructions to all domain controllers and verify Domain Name System \(DNS\) readiness. In this procedure, you force Active Directory replication to push the domain rename instructions that were uploaded to the domain naming operations master in [Generate Domain Rename Instructions](../Topic/Generate-Domain-Rename-Instructions.md) to all domain controllers in the forest. In addition, you verify that the domain controller Locator \(DC Locator\) records that are registered in DNS by each domain controller for the new domain names have replicated to all DNS servers that are authoritative for those records.  
  
## Pushing domain rename instructions to all domain controllers  
 You can use Repadmin.exe tool to force Active Directory replication of directory changes on the domain naming master to all domain controllers in the forest.  
  
> [!NOTE]  
>  Forcing replication is not required, but it serves to accelerate the replication of the changes to the Partitions container in the configuration directory partition to all domain controllers in the forest. As an option, you can wait for replication to complete according to the usual replication intervals and delays that are characteristic of your forest.  
  
 If the command in the following procedure completes successfully, the changes that originate at the domain naming master domain controller  have replicated to every domain controller in the forest. If the command reports an error for some subset of the domain controllers in the forest, the replication must be reattempted for those failed domain controllers until all domain controllers in the forest have successfully received the changes from the domain naming master.  
  
 Membership in the **Enterprise Admins** group in the target forest is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To force synchronization of changes made on the domain naming master to all domain controllers in the forest  
  
1.  On the control station, click **Start**, click **Run**, type **cmd**, and then click **OK**.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
    ```  
    repadmin /syncall /d /e /P /q DomainNamingMaster  
    ```  
  
    > [!NOTE]  
    >  The **repadmin** command\-line options are case sensitive.  
  
    > [!NOTE]  
    >  If read\-only domain controllers \(RODCs\) are included in your domain, run this command one more time to ensure that the RODC new **servicePrincipalName** attribute is replicated to all the domain controllers in the forest.  
  
|Parameter|Description|  
|---------------|-----------------|  
|\/syncall|Synchronizes a specified domain controller with all replication partners.|  
|\/d|Identifies servers by distinguished name in messages.|  
|\/e|Enterprise, cross sites.|  
|\/P|Pushes changes outward from the home server.|  
|\/q|Quiet mode; suppresses callback messages.|  
|DomainNamingMaster|Specifies the DNS host name of the domain controller that is the current domain naming master for the forest.|  
  
 If you do not know the DNS host name of the domain naming master, you can use the Dsquery.exe tool to discover it.  
  
 Membership in the **Enterprise Admins** group in the target forest, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To discover the DNS host name of the domain naming master  
  
1.  On the control station, click **Start**, click **Run**, type **cmd**, and then click **OK**.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
    ```  
    Dsquery server -hasfsmo name  
    ```  
  
|Parameter|Description|  
|---------------|-----------------|  
|Dsquery server \-hasfsmo|Finds the domain controller in Active Directory Domain Services \(AD DS\) that holds the specified operations master \(also known as flexible single master operations \(FSMO\)\) role.|  
|name|Specifies the Active Directory domain controller name.|  
  
## Verifying DNS readiness  
 During domain rename, the service \(SRV\) resource records that are associated with the new domain name that are used by the domain controller Locator \(DC Locator\) are prepublished in the authoritative DNS servers by the Net Logon service that is running on the domain controllers of the domain. For domain controller location to be functional after domain rename, there are a subset of records whose presence at the authoritative DNS servers is critical for authentication and replication to take place.  
  
 The following table lists the necessary resource records, in order of importance.  
  
||||  
|-|-|-|  
|Type|Name of owner|Explanation|  
|CNAME|DsaGuid.\_msdcs.DnsForestName|There must be one alias \(CNAME\) resource record associated with every domain controller in all authoritative DNS servers. This record ensures that replication will take place from that domain controller.|  
|SRV|\_ldap.\_tcp.pdc.\_msdcs.DnsDomainName|There must be one service \(SRV\) resource record that pertains to the primary domain controller \(PDC\) on all authoritative DNS servers. This record ensures that authentication of users and computers is functioning.|  
|SRV|\_ldap.\_tcp.gc.\_msdcs.DnsForestName|There must be at least one resource record that pertains to at least one global catalog server on all authoritative DNS servers. This record ensures that authentication of users and computers is functioning. For example, one DNS server might contain a record of this type that is registered by one gobal catalog, while other DNS servers might contain the records of this type that are registered by other global catalogss. It is sufficient, temporarily, if there is at least one record of this type that is present on all authoritative DNS servers. The other records will eventually replicate to all authoritative DNS servers.|  
|SRV|\_ldap.\_tcp.dc.\_msdcs.DnsDomainName|There must be at least one resource record pertaining to at least one domain controller on all authoritative DNS servers. This record ensures that authentication of users and computers is functioning. For example, one DNS server might contain a resource record of this type that is registered by one domain controller, while other DNS servers might contain the records of this type that are registered by other domain controllers. It is sufficient, temporarily, if there is at least one record of this type present on all authoritative DNS servers. The other records will eventually replicate to all authoritative DNS servers.|  
  
> [!NOTE]  
>  The word "must" in the context of this table means do not—under any circumstances—proceed with domain rename unless this requirement is fulfilled.  
  
 The following two resource records are also required for authentication:  
  
-   KDC: A service \(SRV\) resource record that is owned by \_kerberos.\_tcp.dc.\_msdcs.DnsDomainName.  
  
-   GcIpAddress: A host \(A\) resource record that is owned by \_gc.\_msdcs.DnsForestName.  
  
 However, because these resource records are closely linked with the global catalog and the domain controller service \(SRV\) resource records that are described in the table, it is sufficient to confirm the presence of the global catalog and the domain controller service \(SRV\) resource records to assume that these two records have also been prepublished.  
  
 You can use the DcDiag.exe tool to confirm that the correct service \(SRV\) resource records that DC Locator uses have been registered in DNS.  
  
 Membership in the **Enterprise Admins** group in the target forest, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To verify DNS records readiness  
  
1.  On the control station, click **Start**, click **Run**, type **cmd**, and then click **OK**.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
    ```  
    Dcdiag /test:DNS /DnsRecordRegistration /s:domaincontroller  
    ```  
  
     For more information about **dcdiag** syntax and parameters, see Dcdiag Syntax \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=123103](http://go.microsoft.com/fwlink/?LinkID=123103)\).  
  
  