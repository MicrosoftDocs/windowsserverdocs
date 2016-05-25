---
title: Configure Member Computers for Host Name Changes
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 090ca2b3-3ead-444f-a1e9-8b5fa1a18c26
author: Femila
---
# Configure Member Computers for Host Name Changes
  You can use this procedure to configure member computers for host name changes in a domain rename operation. By default, the primary Domain Name System \(DNS\) suffix of a member computer of an Active Directory domain is configured to change automatically when domain membership of the computer changes. The same default behavior is true when the DNS name of the domain to which a computer is joined changes. For this reason, rename of an Active Directory domain can cause modification of the primary DNS suffix and, therefore, of the full DNS host names of the computers that are the members of the renamed domain.  
  
 For example, if the sales.cohowinery.com domain is renamed to marketing.cohowinery.com, the primary DNS suffix of the member computers of this domain might also change from sales.cohowinery.com to marketing.cohowinery.com, depending on whether the default behavior is in effect. If the default behavior is in effect, the full DNS host name of a computer in the renamed domain changes from host.sales.cohowinery.com to host.marketing.cohowinery.com.  
  
##  <a name="BKMK_Conditions"></a> Conditions for automatic computer name change  
 The primary DNS suffix, and therefore the full DNS name of a member computer in an Active Directory domain, changes automatically when the domain is renamed if both of the following conditions are true:  
  
-   The primary DNS suffix of the computer is configured to be updated when domain membership changes.  
  
-   No Group Policy that specifies a primary DNS suffix is applied to the member computer.  
  
 These conditions represent the default configuration for computers that are running Windows Server 2003 and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].  
  
 Remember that the DNS suffix setting also applies to servers that are running Microsoft Exchange. When you determine the primary DNS suffix configuration for your servers, also check your Exchange servers.  
  
> [!NOTE]  
>  The DNS host names of domain controllers in a renamed domain are not changed automatically to use the new domain DNS name as the primary DNS suffix, regardless of the primary DNS suffix configuration. In other words, the DNS names of domain controllers in a renamed domain will remain unchanged. You can rename the domain controllers in a separate step after the domain rename operation is complete by using a special domain controller rename procedure. For more information about how to rename a domain controller, see [Renaming a Domain Controller](../Topic/Renaming-a-Domain-Controller.md).  
  
## Replication effects of renaming large numbers of computers  
 If the conditions that prompt automatic update of the DNS host names for all computers in the domain are true and if there are a large number of member computers in the domain that is being renamed, replication of that many changes might cause excessive traffic on your network. Recall that a computer name change triggers update of the **dnsHostName** and **servicePrincipalName** attributes on the corresponding computer account in Active Directory Domain Services \(AD DS\). These attributes will typically be updated when the member computer is restarted, as required by the domain rename operation after you rename the domain. Update of these attributes by a large number of computers within a short period of time might trigger replication activity that saturates the network. Moreover, computer name change triggers update of the host \(A\), host \(AAAA\), and pointer \(PTR\) resource records in the DNS database. Such updates also cause additional replication traffic, regardless of whether DNS zones are stored in AD DS or in some other DNS store. For these reasons, you should prepare for the domain rename operation in advance by reconfiguring the default behavior that changes the primary DNS suffix on member computers when a domain is renamed.  
  
> [!IMPORTANT]  
>  If you do not think that the resulting replication traffic poses a risk of network congestion or saturation to your infrastructure, you can allow for the DNS names of the member computers in the renamed domain to change automatically as a result of the domain rename operation. In other words, if there is no risk of network congestion, skip this preparatory step of configuring member computers for host name changes and proceed with the next step: [Prepare Certification Authorities](../Topic/Prepare-Certification-Authorities.md).  
  
 On the other hand, if the number of member computers in the domain to be renamed is large and the consequent replication traffic poses the risk of network congestion in your environment, you should prepare for an Active Directory domain rename operation in advance so that you can rename the member computers in smaller batches to mitigate the replication traffic problem. In this case, you can take steps so that computers will not be renamed after domain rename by ensuring that at least one of the two conditions in [Conditions for automatic computer name change](#BKMK_Conditions) is not true.  
  
> [!NOTE]  
>  You do not have to match the DNS suffix to the new domain name. If your current implementation uses a primary DNS suffix that does not match the DNS name of the domain to which the member computers are joined and if you do not want the DNS suffix to change following domain rename, you can ensure that these computers are not renamed after the domain rename by verifying that at least one of the two conditions in [Conditions for automatic computer name change](#BKMK_Conditions) is not satisfied.  
  
## Using Group Policy to apply the new primary DNS suffix  
 To avoid a replication "storm" that can result from thousands of computer names being changed at approximately the same time, you can use Group Policy to revise the primary DNS suffix to the new domain name before the domain rename so that member names are not automatically updated but have the correct primary DNS suffix at the time that you perform the domain rename.  
  
### Apply the new primary DNS suffix before renaming domains  
 If you establish the planned new name of the domain as the primary DNS suffix for all computers in the domain before you rename the domain, you can ensure that your member computers are not renamed automatically after the domain rename opration. In this way, you can avoid a potential problem in which replication of name\-change updates negatively affects network performance immediately after the domain rename.  
  
 You can use the Group Policy setting **Primary DNS Suffix** to establish the primary DNS suffix for the domain as the new DNS domain name. When this Group Policy setting is in effect, it overrides the default behavior of changing the primary DNS suffix when the DNS name of the domain changes. In this case, the computer names remain the same when you rename the domain and replication of name changes does not occur.  
  
###  <a name="BKMK_Apply"></a> Apply Group Policy in stages to avoid significant replication  
 When you apply the Group Policy setting, **Primary DNS Suffix** changes the DNS suffix and precipitates a name change. Therefore, you must manage the Group Policy application in stages, depending on how many member computers are in the domain that is being renamed. To apply Group Policy to all member computers in the domain or domains that are being renamed, while also avoiding replication on a large scale, you have  to divide computer objects among several locations in AD DS—either organizational units \(OUs\) or sites, or both. In deployments in which member computers exist in numbers that can affect network efficiency if all computers were renamed at the same time, you want to have computers distributed among several OUs, for ease of administration. If member computers at both the site and OU levels are too numerous to undergo a name change without causing excessive replication, you might want to create additional organizational units to temporarily house some of the computers so that you can apply Group Policy in stages.  
  
> [!IMPORTANT]  
>  Do not apply the Group Policy setting to cause a DNS host name change for member servers that are housing software distribution points for managed software deployment in your domain. You should wait until the step [Fix Group Policy Objects and Links](../Topic/Fix-Group-Policy-Objects-and-Links.md) later in this document. The member servers that house software distribution points will change their DNS host name at that step after they are restarted.  
  
 You can rename member computers one group at a time by using the following sequence of tasks:  
  
1.  Estimate the largest number of computers \(N\) that can be renamed in your environment so that the resulting replication traffic can be sustained by your network without becoming saturated. It is our expectation that 1000 is an acceptable number.  
  
2.  Divide the member computers in the domain to be renamed into groups. Each group should contain no more than the number of computers N estimated in step 1, so that the new primary DNS suffix can be applied to one group at a time.  
  
    > [!NOTE]  
    >  The "groups" that are specified in this step are purely imaginary entities that represent some collection of computers. There might be no actual object that corresponds to such a group in the domain. For example, the combination of two OUs , or one site, or one site plus an OU, and so on, might be used to form one group, provided that the number of computers in the group does not exceed the number N of computers that is specified in step 1. If existing sites and OUs all contain more computers than the number N that is specified in step 1, you might have to create one or more temporary OUs  to group computers so that the new primary DNS suffix can be applied to one group \(in this case, one or more OUs \) at a time. As an alternative, you can restrict the scope of application of Group Policy to one group by creating a temporary security group that consists of the group of computers that should receive the policy and by setting security permissions on the Group Policy object \(GPO\) accordingly using the security group that you just created.  
  
3.  Create a staggered schedule that determines when the new primary DNS suffix will be applied to each group of computers that you established in step 2. Ensure that there is sufficient time between two consecutive applications of the Group Policy setting **Primary DNS Suffix** to two different groups of computers to allow replication to occur. Replication of the updated **dnsHostName** and **servicePrincipalName** attributes on computer accounts and replication of the DNS records of the renamed computers must be completed fully during the scheduled gap.  
  
4.  Configure the domain that is being renamed to allow member computers of the domain to register the new primary DNS suffix in the **dnsHostName** attribute of their corresponding computer accounts in AD DS.  
  
### Configuration required before the application of Group Policy  
 When you apply the Group Policy setting **Primary DNS Suffix**, the DNS suffix of member computers will no longer match the DNS name of the domain of which they are members. To allow the member computers of a domain to have a primary DNS suffix that does not match the DNS domain name, you must first configure the domain to accept the names that the DNS suffix can have. This configuration must be in place before you can set Group Policy to apply to a set of computers.  
  
 To configure the set of DNS suffixes that can be applied to computers in the domain, add a new value \(or values\) to the **msDS\-AllowedNDSSuffixes** multivalued attribute of the domain object \(the domainDns object for the domain\) so that the attribute contains a list of DNS suffixes that member computers of the Active Directory domain can have. When you apply the Group Policy setting **Primary DNS Suffix**, you will specify one of the DNS suffixes that you have added to the **msDS\-AllowedNDSSuffixes** attribute.  
  
 If you apply the **Primary DNS suffix** Group Policy setting to the computers in the domain to be renamed, we highly recommend that you set the **DNS Suffix Search List** Group Policy setting and apply it to the computers in the domain being renamed. The **DNS Suffix Search List** setting should contain the old primary DNS suffix, new primary DNS suffix, and potentially parent suffixes of the old and new primary DNS suffixes. \(The latter depends on whether parent name spaces are being used in the organization.\) For example, suppose that the old name of a domain was payroll.hr.sales.cohowinery.com \(that also corresponds with the old primary DNS suffix\). Also, suppose that the new name of the domain is payroll.sales.cohowinery.com \(that also corresponds with the new primary DNS suffix\). The **DNS Suffix Search List** should contain the following suffixes:  
  
-   payroll.hr.sales.cohowinery.com  
  
-   payroll.sales.cohowinery.com  
  
 … and it may contain these suffixes:  
  
-   hr.sales.cohowinery.com  
  
-   sales.cohowinery.com  
  
-   cohowinery.com  
  
 Such configuration preserves the ability of users to resolve the DNS names of computers in the domain that is being renamed by specifying first label only of the full DNS names of computers—even during the transition period when a user’s computer and resource server may have different primary DNS suffixes.  
  
 For the same reason, if computers in another domain were configured with **DNS Suffix Search List** that contains the old name of a domain being renamed, during the domain rename operation those computers should be reconfigured so that **DNS Suffix Search List** is updated to contain both the old and new domain names.  
  
## Configuring member computers for host name changes in large deployments  
 If your AD DS implementation is large enough to warrant updating the primary DNS suffix before the domain rename \(that is, you want to avoid the effects of excessive replication of computer name changes that follow domain rename\), you must complete the following tasks:  
  
-   [Determine the primary DNS Suffix configuration](#BKMK_1)  
  
-   [Determine whether Group Policy controls the primary DNS suffix](#BKMK_2)  
  
-   [Configure the domain to allow a primary DNS suffix that does not match the domain name](#BKMK_3)  
  
-   [Apply Group Policy to set the primary DNS suffix](#BKMK_4)  
  
###  <a name="BKMK_1"></a> Determine the primary DNS Suffix configuration  
 As a preliminary step, if you do not know how your member computers are configured in relation to updating the primary DNS suffix if the membership domain changes, you first want to establish these conditions.  
  
 The following procedures describe two ways to view the setting for a member computer that determines whether the primary DNS suffix changes when the name of the membership domain changes.  
  
##### To check for primary DNS suffix update configuration using Control Panel  
  
1.  On a member computer, in **Control Panel**, double\-click **System**.  
  
2.  Click the **Change settings** link.  
  
3.  On **Computer Name** tab, click **Change**.  
  
4.  Click **More**, and then verify whether **Change primary domain suffix when domain membership changes** is selected.  
  
5.  Click **OK** until all dialog boxes are closed.  
  
##### To check for primary DNS suffix update configuration for a computer using the registry  
  
1.  On the **Start** menu, click **Run**.  
  
2.  In **Open**, type **regedit**, and then click **OK**.  
  
    > [!CAUTION]  
    >  Incorrectly editing the registry may severely damage your system. Before making changes to the registry, you should back up any valued data on the computer.  
  
3.  Navigate to **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Tcpip\\Parameters**.  
  
4.  Verify whether the value of **REG\_RWORDSyncDomainWithMembership** is 0x1. This value indicates that the primary DNS suffix changes when the domain membership changes.  
  
###  <a name="BKMK_2"></a> Determine whether Group Policy controls the primary DNS suffix  
 You can also determine whether Group Policy is applied to the computer to specify the primary DNS suffix. There are several ways to discover this information, as described in the following procedure.  
  
 You can determine whether Group Policy specifies the primary DNS suffix for a computer on a member computer using either of the following two procedures.  
  
##### To determine whether Group Policy specifies the primary DNS suffix by using the command line  
  
1.  To open a command prompt, click **Start**, click **Run**, type **cmd**, and then click **OK**.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
    ```  
    gpresult  
    ```  
  
3.  In the output, under **Applied Group Policy objects**, check to see whether **Primary DNS Suffix** is listed.  
  
     Or  
  
4.  Type the following command, and then press ENTER:  
  
    ```  
    ipconfig /all  
    ```  
  
5.  Check **Primary DNS Suffix** in the output. If it does not match the primary DNS suffix that is specified in Control Panel for the computer, the **Primary DNS Suffix** Group Policy setting is applied.  
  
##### To determine whether Group Policy specifies the primary DNS suffix by using the registry  
  
1.  On the **Start** menu, click **Run**.  
  
2.  In **Open**, type **regedit** and then click **OK**.  
  
3.  Navigate to **HKEY\_LOCAL\_MACHINE\\Software\\Policies\\Microsoft\\WindowsNT\\DNSclient**.  
  
4.  Check for the presence of the entry **Primary DNS Suffix**. If a value is present, the **Primary DNS Suffix** Group Policy setting is applied to the computer.  
  
###  <a name="BKMK_3"></a> Configure the domain to allow a primary DNS suffix that does not match the domain name  
 Before you apply Group Policy to set the primary DNS suffix for each renamed domain, create a list of the DNS suffixes that you want to use for each domain. The only primary DNS suffix available to the domain, by default, is the DNS name of the domain itself. To make these different DNS suffixes available to member computers, you must first make the DNS suffixes known to the domains in which you want to use them. You add DNS suffixes to the domain by editing the attribute **msDS\-AllowedDNSSuffixes** on the domain object to contain the additional DNS domain names that are available to be used as DNS suffixes for that domain.  
  
 For you to be able to add a primary DNS suffix that is different from the current DNS domain name, your environment must meet the following requirements:  
  
-   All domain controllers in the domain must be running Windows Server 2003 or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)].  
  
-   For each new DNS suffix that you add, a subdomain by that name must exist in DNS.  
  
> [!CAUTION]  
>  The same value in the **msDS\-AllowedDNSSuffixes** attribute cannot be used for more than one domain in the forest. This undesired configuration enables a malicious administrator of a computer that is joined to one such domain to set the **servicePrincipalName** attribute of its computer account to the same value as the Service Principal Name \(SPN\) of a computer in the other domain that is configured to allow the same DNS suffix. Such a configuration prevents Kerberos authentication against both of these computers.  
  
 The attribute **msDS\-AllowedDNSSuffixes** is an attribute of the domain object. Therefore, you must set DNS suffixes for each domain whose name is going to change.  
  
##### To use ADSI Edit to add DNS suffixes to msDSAllowedDNSSuffixes  
  
1.  Click **Start** menu, click **Administrative Tools**, and then click **ADSI Edit**.  
  
2.  Double\-click the domain directory partition for the domain that you want to modify.  
  
3.  Right\-click **Domain container object**, and then click **Properties**.  
  
4.  On the **Attribute Editor** tab, in **Attributes**, double\-click the attribute **msDS\-AllowedDNSSuffixes**.  
  
5.  In the **Multi\-valued String Editor** dialog box, in **Value to add**, type a DNS suffix, and then click **Add**.  
  
6.  When you have added all the DNS suffixes for the domain, click **OK**.  
  
7.  Click **OK** to close the **Properties** dialog box for that domain.  
  
8.  In the console tree, right\-click **ADSI Edit**, and then click **Connect to**.  
  
9. Under **Computer**, click **Select or type a domain or server**.  
  
10. Type the name of the next domain for which you want to set the primary DNS suffix, and then click **OK**.  
  
11. Repeat steps 2 through 7 for that domain.  
  
12. Repeat steps 8 through 10 to select each subsequent domain and repeat steps 2 through 7 to set the primary DNS suffix for each subsequent domain that is being renamed.  
  
###  <a name="BKMK_4"></a> Apply Group Policy to set the primary DNS suffix  
 Start applying the Group Policy setting **Primary DNS Suffix** to one group of computers at a time. \(For more information, see [Apply Group Policy in stages to avoid significant replication](#BKMK_Apply).\) The new primary DNS suffix must be applied to all member computers in a domain before the domain is renamed.  
  
> [!NOTE]  
>  The group of member computers to which this Group Policy setting is applied will have to be restarted for the host name change to take effect.  
  
##### To apply the Group Policy setting Primary DNS Suffix to groups of member computers  
  
1.  Open the Group Policy Management Editor snap\-in: click **Start**, click **Administrative Tools**, and then click **Group Policy Management**.  
  
2.  In Group Policy Management Editor, right\-click the domain or OU that contains the group of computers to which you are applying Group Policy.  
  
3.  In **Group Policy Objects**, right\-click the GPO that you want to contain the **Primary DNS Suffix** setting, and then click **Edit**.  
  
    > [!NOTE]  
    >  To create a new GPO that will contain the **Primary DNS Suffix** setting, right\-click **Group Policy Objects**, click **New**, and then type a name for the object.  
  
4.  Under **Computer Configuration**, expand **Policies** and **Administrative Templates, Network**, and then click **DNS Client**.  
  
5.  In the results pane, double\-click **Primary DNS Suffix**.  
  
6.  Click **Enabled**, and then in the **Enter a primary DNS suffix** box, type the DNS suffix for the domain whose member computers are in the group that you selected in step 2.  
  
 After the Active Directory domain has been renamed and all member computers have had time to restart, you can disable the Group Policy setting that you enabled in step 6 of the previous procedure.  
  
> [!NOTE]  
>  The steps in the previous procedure result in naming member computers only, not domain controllers. Renaming mission\-critical servers, such as domain controllers, requires special preparation that is beyond the scope of this document. For information about how to rename a domain controller, see [Renaming a Domain Controller](../Topic/Renaming-a-Domain-Controller.md). We strongly recommend that you carefully read this Help documentation and then rename domain controllers in a renamed domain according to the specified recommendations only after the domain rename operation has completed successfully.  
  
  