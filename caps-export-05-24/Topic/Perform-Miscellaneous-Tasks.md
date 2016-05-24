---
title: Perform Miscellaneous Tasks
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 59dbb62c-7a6c-4e09-99d2-88360ecb89dd
author: Femila
---
# Perform Miscellaneous Tasks
  You can use this procedure to perform miscellaneous tasks after a domain rename procedure. There are a number of miscellaneous follow\-up tasks that you have to perform after the core domain rename tasks are complete. There is no particular order in which these tasks have to be performed.  
  
-   **Publish service connection points for renamed TAPI\-specific application directory partitions**.  
  
     If you renamed Telephony Application Programming Interface \(TAPI\)–specific application directory partitions as part of specifying the new forest description procedure \([Specify the New Forest Description](../Topic/Specify-the-New-Forest-Description.md)\), you have to publish service connection points in Active Directory Domain Services \(AD DS\) for the new name of the application directory partition so that TAPI clients can locate it. At the same time, you can remove the service connection points for the old name of the application directory partition.  
  
     For example, suppose that you had a TAPI\-specific application partition named mstapi.cohovineyard.com that was configured for the domain cohovineyard.com. As a result of the Domain Name System \(DNS\) name of the domain changing to cohowinery.com, you renamed the corresponding application directory partition to mstapi.cohowinery.com during the domain rename operation.  
  
     You should now remove the service connection point for the old application directory partition name mstapi.cohovineyard.com by running the following command from a command prompt on the control station computer:  
  
    ```  
    tapicfg removescp /directory:mstapi.cohovineyard.com /domain:cohowinery.com  
    ```  
  
     Then, publish a service connection point for the new application directory partition name mstapi.cohowinery.com by running the following command from a command prompt on the control station:  
  
    ```  
    tapicfg publishscp /directory:mstapi.cohowinery.com /domain:cohowinery.com /forcedefault  
    ```  
  
-   **Orchestrate password reset for Digest authentication.**  
  
     A Digest authentication mechanism uses the DNS domain name as the realm, which is then used to precompute the Digest user password hash that is stored in AD DS. If you are using Digest authentication in a domain that was renamed by the domain rename operation, a user in that domain will not be able to use Digest authentication until the user password is changed.  
  
     If you are using Digest authentication in a domain that is renamed, you must do something to cause a password reset to occur. For example, you could do the following:  
  
    -   After you complete all the procedures in [Run Domain Rename Instructions](../Topic/Run-Domain-Rename-Instructions.md), \(the domain rename instructions have all been followed and domain controllers have restarted in a renamed domain\), expire all user passwords by changing domain password policy in the renamed domain.  
  
    -   Send out e\-mail that warns users that they must change their passwords immediately after they reboot their computers twice \(as described in [Restart Member Computers](../Topic/Restart-Member-Computers.md)\). Users change their passwords by pressing Ctrl\+Alt\+Del.  
  
-   **Remove any redundant interdomain trusts within your forest.**  
  
     If you performed a forest restructure operation in which the existing domains were rearranged into a different tree structure, you would have created the necessary shortcut trusts to preserve complete trust between all the domains in your new forest, as described in "Pre\-Creating Parent\-Child Trust Relationships for a Restructured Forest" in [Create Necessary Shortcut Trust Relationships](../Topic/Create-Necessary-Shortcut-Trust-Relationships.md). This type of a restructure can result in one or more parent\-child or tree\-root trust relationships remaining in your forest that reflect the old domain structure and are no longer required. Although their presence does no harm, you can use the Active Directory Domains and Trusts snap\-in to remove these redundant trust relationships after the domain rename operation is complete. For more information, see Active Directory Domains and Trusts \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=124088](http://go.microsoft.com/fwlink/?LinkId=124088)\).  
  
-   **Fix Start menu shortcuts for Domain Security Policy and Domain Controller Security Policy Microsoft Management Console \(MMC\) snap\-ins.**  
  
    1.  Click **Start**, click **Programs**, and then click **Administrative Tools**.  
  
    2.  Right\-click **Domain Security Policy**, and then click **Properties**.  
  
    3.  Modify the **Target** field to replace the old distinguished name of the domain that appears as part of the \/gpobject: parameter with the new distinguished name of the domain.  
  
    4.  Click **OK**.  
  
        > [!NOTE]  
        >  For example, if you renamed the domain cohovineyard.com to cohowinery.com, the \/gpobject: parameter will have to be changed from  
        > \/gpobject:"LDAP:\/\/CN\={31B2F340\-016D\-11D2\-945F\-00C04FB984F9},CN\=Policies,CN\=System,DC\=cohovineyard,DC\=com"  
        > to \/gpobject:"LDAP:\/\/CN\={31B2F340\-016D\-11D2\-945F\-00C04FB984F9},CN\=Policies,CN\=System,DC\=cohowinery,DC\=com".  
  
    5.  To fix the Domain Controller Security Policy snap\-in shortcut, follow steps 1 through 4 above, but select **Domain Controller Security Policy** in step 2.  
  
        > [!NOTE]  
        >  For example, if you renamed the domain msn.com to msnzone.com, the \/gpobject: parameter will have to be changed from \/gpobject:"LDAP:\/\/CN\= {6AC1786C\-016F\-11D2\-945F\-00C04fB984F9},CN\=Policies,CN\=System,DC\=cohovineyard,DC\=com"  
        > to \/gpobject:"LDAP:\/\/CN\= {6AC1786C\-016F\-11D2\-945F\-00C04fB984F9},CN\=Policies,CN\=System,DC\=cohowinery,DC\=com".  
  
-   **Remove the Group Policy to set primary DNS suffix of member computers in renamed domains.**  
  
     If you followed the recommendations to avoid excess replication due to member computers being renamed in a large domain, as described in "Configuring Member Computers for Host Name Changes in Large Deployments" in [Configure Member Computers for Host Name Changes](../Topic/Configure-Member-Computers-for-Host-Name-Changes.md), you might have configured and applied a Group Policy setting **Primary DNS Suffix** to member computers in your renamed domains. Because the intended purpose of this Group Policy setting has now been served, it can be removed. To remove this Group Policy setting, follow steps 1 through 5 of the procedure "Apply Group Policy to Set the Primary DNS Suffix" in [Configure Member Computers for Host Name Changes](../Topic/Configure-Member-Computers-for-Host-Name-Changes.md), click **Disabled**, and then click **OK**.  
  
-   **Remove DNS zones that are no longer needed.**  
  
     As a result of the domain DNS name changes that occurred during the domain rename operation, some of the DNS zones in your DNS infrastructure might no longer be necessary.  For example, if there was a DNS zone with a name that matched the old DNS name of a renamed domain, there might be no more DNS resource records \(service \(SRV\), host \(A\), and pointer \(PTR\) resource records\) with the old domain suffix that have to be registered with DNS. In this case, you can remove these DNS zones that are no longer necessary.  
  
  