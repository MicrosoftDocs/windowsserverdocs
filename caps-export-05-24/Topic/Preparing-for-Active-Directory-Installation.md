---
title: Preparing for Active Directory Installation
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 94920da7-6334-4416-ab00-42c049f333b1
author: Femila
---
# Preparing for Active Directory Installation
  Properly preparing for the installation of Active Directory Domain Services \(AD DS\) decreases the chances of problems occurring during the installation process and helps you complete the installation quickly.  
  
 There are a number of requirements for installing AD DS on a new domain controller in an existing domain. Preparation includes configuring DNS and gathering information that you need for the installation. This section describes general requirements with respect to Domain Name System \(DNS\) configuration, placement of the domain controller in a site, and connectivity for the Active Directory Domain Services Installation Wizard.  
  
 After you have gathered all the information that you need to run the Active Directory Domain Services Installation Wizard and you have performed the tests to verify that all the necessary domain controllers are available, you are ready to install AD DS on your server and create an additional domain controller in your domain.  
  
## DNS configuration  
 The DNS Client service is always present on a server running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. A DNS server must be present in an Active Directory forest, and the DNS server must store DNS data for the server computer that you are installing. You should configure both the DNS client and the DNS server to ensure that name resolution and related dependencies will function as expected during the installation of AD DS.  
  
 For ease of administration, install the DNS Server service when you install AD DS. When you use the Active Directory Domain Services Installation Wizard to install the DNS Server service, DNS zones, zone delegations, root hints or forwarders, and DNS client settings are configured automatically.  
  
 Ensure that any required configuration, forwarders, or zones are present and accessible before installation. For more information about DNS configuration in preparation for domain controller installation, see Integrating AD DS into an Existing DNS Infrastructure \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=120585](http://go.microsoft.com/fwlink/?LinkId=120585)\).  
  
## Site placement  
 During Active Directory installation, the Active Directory Domain Services Installation Wizard attempts to place the new domain controller in the appropriate site. You can select a source replication partner, the site for the new domain controller, or both when you use the wizard to install AD DS. The appropriate site is determined by the domain controller’s IP address and subnet mask. The wizard uses the IP information to calculate the subnet address of the domain controller. The wizard then checks to see if a subnet object exists in the directory for that subnet address. If the subnet object exists, the wizard uses it to place the new server object in the appropriate site. If the subnet object does not exist, if you do not specify a site, the wizard places the new server object in the same site as the domain controller that is being used as a source to replicate the directory database to the new domain controller. Make sure that the subnet object has been created and that it is associated with the target site before you run the wizard. For information about creating a subnet and associating it with a site, see [Create a Subnet Object or Objects and Associate them with a Site](../Topic/Create-a-Subnet-Object-or-Objects-and-Associate-them-with-a-Site.md).  
  
## Domain connectivity  
 During the installation process, the Active Directory Domain Services Installation Wizard must communicate with other domain controllers to join the new domain controller to the domain. The wizard must communicate with a member of the domain to receive the initial copy of the directory database for the new domain controller. The wizard communicates with the domain controller that holds the domain naming operations master \(also known as flexible single master operations or FSMO\) role for domain installations only, so that the new domain controller can be added to the domain. The wizard must also contact the relative ID \(RID\) operations master so that the new domain controller can receive its RID pool, and the wizard must communicate with another domain controller in the domain to populate the SYSVOL shared folder on the new domain controller. All of this communication depends on proper DNS installation and configuration. By using Dcdiag.exe, you can test all of these connections before you start the Active Directory Domain Services Installation Wizard.  
  
 **Task requirements**  
  
 During the installation process, the wizard must communicate with other domain controllers to add this new domain controller to the domain and get the appropriate information into the Active Directory database. To maintain security, you must provide credentials that allow administrative access to the directory.  
  
 Before you begin your installation, the following conditions must exist in your environment:  
  
-   Your Active Directory forest root domain must already exist.  
  
-   If you are installing a new domain controller in a child domain, there should be at least two properly functioning domain controllers in the forest root domain.  
  
-   DNS must be functioning properly. In this guide, it is assumed that you are using Active Directory–integrated DNS zones. You must have configured at least one domain controller as a DNS server.  
  
 Creating or removing a domain or forest is beyond the scope of this guide.  
  
 The following information and tools are necessary to complete this task:  
  
-   The Active Directory Domain Services Installation Wizard asks for the following specific configuration information before it begins installing AD DS:  
  
    -   A domain administrator’s user name and password  
  
    -   A location to store the directory database and log files  
  
    -   A location to store SYSVOL  
  
    -   The password to use for Directory Services Restore Mode \(DSRM\)  
  
    -   The fully qualified DNS name of the domain to which the new domain controller will be added  
  
-   Dcdiag.exe  
  
-   Network Connections  
  
-   Active Directory Sites and Services  
  
 To complete this task, perform the following procedures:  
  
1.  [Verify DNS Infrastructure and Registrations](../Topic/Verify-DNS-Infrastructure-and-Registrations.md)  
  
2.  [Verify That an IP Address Maps to a Subnet and Determine the Site Association](../Topic/Verify-That-an-IP-Address-Maps-to-a-Subnet-and-Determine-the-Site-Association.md)  
  
3.  [Verify the Availability of the Operations Masters](../Topic/Verify-the-Availability-of-the-Operations-Masters.md)  
  
> [!CAUTION]  
>  If any verification test fails, do not continue until you determine what went wrong and you fix the problems. If one or more of these tests fail, the installation of AD DS is also likely to fail.  
  
  