---
title: Designing RODCs in the Perimeter Network
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: b27975e0-b3d0-46e0-ab23-6a772d40b467
author: Femila
---
# Designing RODCs in the Perimeter Network
  This topic describes the design of the extended corporate forest model in the perimeter network that uses a read\-only domain controller \(RODC\):  
  
-   [Promoting the RODC](../Topic/Designing-RODCs-in-the-Perimeter-Network.md#dcpromo)  
  
-   [Configuring DNS for name resolution and registration](../Topic/Designing-RODCs-in-the-Perimeter-Network.md#config_dns_name_res)  
  
-   [Administrative Role Separation](../Topic/Designing-RODCs-in-the-Perimeter-Network.md#admin_role_sep)  
  
-   [Configuring the RODC Password Replication Policy](../Topic/Designing-RODCs-in-the-Perimeter-Network.md#config_rodc_pswd_rep_pol)  
  
-   [Active Directory replication](../Topic/Designing-RODCs-in-the-Perimeter-Network.md#ad_rep)  
  
-   [Securing RODC communication](../Topic/Designing-RODCs-in-the-Perimeter-Network.md#secure_rodc_comm)  
  
-   [Domain join using RODC](../Topic/Designing-RODCs-in-the-Perimeter-Network.md#domain_join_rodc)  
  
 For more information about the extended corporate forest model, see “Extended corporate forest model” in [Designing RODCs in the Perimeter Network](../Topic/Designing-RODCs-in-the-Perimeter-Network.md).  
  
##  <a name="dcpromo"></a> Promoting the RODC  
 Consider the following when you promote an RODC that will be located in the perimeter network of your organization’s network infrastructure:  
  
-   Which network should the RODC be connected to during the promotion process—the internal network or the perimeter network?  
  
     The decision about which network to promote the RODC in is important when there is a domain\-based network access security policy, such as Internet Protocol Security \(IPsec\), in place. In this case, you must ensure that the RODC has the IPsec policy in place before it is exposed in the perimeter network.  
  
-   Should you use a two\-stage promotion process?  
  
     A new feature of Windows Server 2008 is the ability to delegate the operation of the promotion of an RODC from a security perspective. The promotion of an RODC can now be performed in two stages. The first stage requires Domain Admin privileges to create the information in Active Directory Domain Services \(AD DS\). The second stage involves a specific domain user or a group whose members do not have or need Domain Admin privileges. For more information about planning and deploying RODCs, see the Read\-Only Domain Controller Planning and Deployment Guide \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=135993](http://go.microsoft.com/fwlink/?LinkID=135993)\).  
  
### Recommendations  
 When you promote an RODC that will be located in the perimeter network, the following actions are recommended:  
  
-   Use delegated two\-stage promotion. This reduces the risk that may be associated with a Domain Admin level account interactively logging on to a server in the perimeter network.  
  
     The delegated promotion mechanism requires that the computer not be domain joined before the promotion. Therefore, a secure build of Windows Server 2008 should be used on this computer before it is placed in the perimeter network. A secure build is a build that is created with appropriate security configurations, such as appropriate firewall configurations, unnecessary services stopped, and so on.  
  
-   Install Windows Server 2008 using the Server Core installation option. This reduces the attack surface.  
  
-   If you are using IPsec, perform the promotion of the first RODC that will be placed in the perimeter network for a given domain from the internal corporate network or with full connectivity to a writeable domain controller.  
  
 This also provides an opportunity to perform important domain controller functionality tests, such as replication and authentication, before you place the domain controller in the perimeter network.  
  
> [!NOTE]  
>  Similar testing must be performed again after you move the RODC to the perimeter network.  
  
##  <a name="config_dns_name_res"></a> Configuring DNS for name resolution and registration  
 As in all Active Directory deployments, Domain Name System \(DNS\) is a key part of the design. Domain controllers and client computers must be able to register, update, and resolve host names and service records. Best practices for DNS configurations on client computers and servers are still applicable for RODC deployments in perimeter networks. For more information, see the AD DS Deployment Guide \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=135996](http://go.microsoft.com/fwlink/?LinkId=135996)\).  
  
### Considerations  
 The main difference in DNS configuration between a writable domain controller and an RODC is that the RODC will not be authoritative for any integrated zone; that is, it will not accept updates for any Active Directory–integrated DNS zone. Therefore, any dynamic update requests for an Active Directory–integrated zone will result in the requester being provided with the start of authority \(SOA\) resource record of the zone. This resource record will provide a reference to a server that is authoritative and writeable for the zone.  
  
 The read\-only nature of Active Directory–integrated DNS on RODCs has the following implications in a perimeter network environment:  
  
-   It permits Active Directory–integrated zones to be available in the perimeter network without the risk of them being updated directly.  
  
-   However, it poses a problem of how secure dynamic updates can be established if they are required.  
  
 This leads to the following considerations for the design of a name resolution solution for the perimeter network:  
  
-   You must determine which namespaces must be visible.  
  
-   You must determine how those namespaces are to be updated: manually or dynamically.  
  
-   You must decide that, if dynamic updates are desired, how you can achieve this functionality within the constraints of communication inside the perimeter network and between the perimeter network and the corporate network.  
  
 The namespaces that are visible depend on whether domain controllers are deployed in the perimeter network and for which domain or forest. In some scenarios it may not be appropriate to make an entire namespace or part of a namespace visible in the perimeter network or for there to be any mechanism to allow servers or client computers to automatically update records. In other scenarios, these factors may not be a significant concern.  
  
### Approaches and configuration options  
 This section describes the approaches and options for configuring DNS for name resolution in the perimeter network.  
  
#### No DNS  
 This highly restrictive approach avoids the need for hosting DNS namespaces in the perimeter network. With this approach, client computers in the perimeter network resolve names through HOST files or NetBIOS broadcasts. Any RODC in the perimeter network resolves names against a writable domain controller in the internal network and registers its DNS records against the writable domain controller through the firewall that separates the internal network from the perimeter network.  This approach avoids exposure of any corporate DNS zones in the perimeter network.  
  
 Although this approach is possible, it is not practical. It does not scale well, and it incurs a high administrative cost when records must be kept up to date and consistent across more than a handful of computers.  
  
#### Manual administration of host \(A\) resource records  
 With this approach, all host \(A\) resource records that are required in the perimeter network for name resolution are added manually, which helps avoid the need to open ports from the perimeter network to the writable domain controller. The RODC will still be able to update its records dynamically against the writable domain controller because a communication channel must be open between the RODC and writable domain controller for other domain\-controller communications, such as replication. This approach works for highly controlled perimeter networks where there is little need for new registrations or updates to host \(A\) resource records.  
  
#### Open DNS communication with writeable domain controllers  
 This approach is suitable for perimeter networks that must have dynamic updates enabled. With this approach there is open DNS communication from computers in the perimeter network to the writeable domain controllers. This makes it possible for computers in the perimeter network to register their records directly against the writeable domain controllers. Even though computers in the perimeter network can communicate with a writable domain controller, having the RODC configured as a DNS server ensures that the DNS query load is handled by the RODC.  
  
 One possible issue with this configuration is that there might be a delay of up to four minutes before a new DNS resource record that is registered on the writable domain controller reaches the RODC through replication. This issue must be considered if there is a need for client computers to immediately resolve names that are registered by computers. For more information about how RODCs handle DNS updates, see Read\-Only Domain Controller Planning and Deployment Guide \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=135993](http://go.microsoft.com/fwlink/?LinkID=135993)\).  
  
#### Using DHCP server to perform name registration for clients  
 An alternative to allowing dynamic update registration through the firewall is to run a Dynamic Host Configuration Protocol \(DHCP\) server in the perimeter network and configure it to be able to perform registration of host \(A\) and pointer \(PTR\) resource records on behalf of client computers. If the DHCP role is combined with the RODC, it further reduces the number of servers that have to be allowed to pass DNS traffic through the firewall because it is assumed that the RODC is able to communicate directly with some subset of writeable domain controllers in its domain that reside in the internal network.  
  
 When you use this approach, we recommend that you:  
  
-   Configure the DHCP Server service to perform DNS updates with a specific service account. This ensures that records are registered in a manner that prevents their update in a way that is not secure.  
  
    > [!NOTE]  
    >  Do not add this service account to the DNSUpdateProxy group. For more information about the DNSUpdateProxy group, see article 816592 in the Microsoft Knowledge Base\([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=133266](http://go.microsoft.com/fwlink/?LinkID=133266)\).  
  
-   Create a scope that contains only reservations for the specific media access control \(MAC\) addresses of the servers in the perimeter network. This reduces the risk of an arbitrary client computer being placed on the perimeter network and registering its records in DNS.  
  
-   If the first DHCP server in the domain is to be installed on an RODC, it is important that you manually create the DHCP\-Admin\-related groups before this role is installed. RODCs are not allowed to create groups in their local Active Directory database. The DHCP groups that you must create in advance include the following:  
  
    -   DHCP Administrators \(Domain Local\)  
  
    -   DHCP Users \(Domain Local\)  
  
 For more information about using a DHCP server to perform name registration for client computers, see the following:  
  
-   DHCP Server Security \(Part 1\) \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=133263](http://go.microsoft.com/fwlink/?LinkId=133263)\)  
  
-   DHCP Server Security \(Part 2\) \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=133264](http://go.microsoft.com/fwlink/?LinkId=133264)\)  
  
-   Article 816592 in the Microsoft Knowledge Base \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=133266](http://go.microsoft.com/fwlink/?LinkId=133266)\)  
  
##  <a name="admin_role_sep"></a> Administrative Role Separation  
 The Administrative Role Separation feature that was introduced in Windows Server 2008 for RODCs makes it possible to create a delegated RODC administrator account. This account should be a regular domain user with limited rights in AD DS. For more information about Administrative Role Separation and best practices, see Read\-Only Domain Controller Planning and Deployment Guide \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=135993](http://go.microsoft.com/fwlink/?LinkID=135993)\).  
  
### Recommendation  
 For RODCs that are located in a perimeter network, all local administrative server tasks \(such as installing patches or modifying network settings\) that must be completed with a direct logon to an RODC should be performed with a delegated RODC administrator account.  
  
##  <a name="config_rodc_pswd_rep_pol"></a> Configuring the RODC Password Replication Policy  
 A key RODC feature is the ability to restrict sensitive data such as passwords from being replicated to RODCs. By default, the Active Directory database of an RODC contains only the passwords for the RODC computer account and the associated Kerberos krbtgt account.  
  
 The mechanism for controlling which passwords get replicated to the RODC is known as the Password Replication Policy \(PRP\). The PRP offers administrators flexibility—from the extreme of the default policy, which allows only the passwords of the RODC computer account and the associated krbtgt account to be cached, to the least restrictive policy, which allows the passwords of all users except sensitive accounts, such as domain administrators, to be cached. For more information, see RODC Filtered Attribute Set, Credential Caching, and the Authentication Process with an RODC \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=133355](http://go.microsoft.com/fwlink/?LinkId=133355)\).  
  
 When an RODC is deployed in the perimeter network and limiting the exposure of passwords is important, we recommend that you use a PRP, which is more restrictive. Typically, this means limiting the cacheable accounts to those accounts that are absolutely required inside the perimeter network.  
  
### Choosing which accounts should be cached  
 This section provides guidance about choosing the accounts to be cached on an RODC in your perimeter network.  
  
#### User accounts  
 In scenarios in which corporate identities are used, it is probably desirable to allow as few accounts as possible to have their passwords replicated to the RODC. This should not affect the user experience because the RODC is able to forward any authentication requests to a writeable domain controller.  
  
 User accounts for which it might be appropriate to allow caching include any accounts that are used for day\-to\-day configuration or monitoring of the RODC, such as accounts that are used for delegated administration through the Administrative Role Separation feature. The decision to allow these accounts to be cached is a tradeoff between ensuring that a user can log on locally in the absence of connectivity to a writeable domain controller and the consideration that the account password is stored in the perimeter network. Passwords for service accounts can also be included.  
  
 It should be noted that if communication to a writeable domain controller is not available, authentication fails for any accounts that do not have their passwords cached on the RODC.  
  
#### Computer accounts  
 If there are servers in the perimeter network that are joined to the domain that the RODC is a member of, the PRP must be configured to allow the passwords for those servers to be replicated. Typically, these servers have little or no access to the corporate network. Therefore, they must build their secure channel against the RODC. This requires that the computer password be cached to allow the secure channel to be established to the RODC.  
  
> [!NOTE]  
>  If there are multiple RODCs for a given domain in the perimeter network, configure all of them with the matching PRP to avoid unexpected authentication failures if  writeable domain controllers are not available.  
  
### Further considerations  
 To facilitate management and auditing of the PRP, we suggest that a per\-domain "perimeter network RODC Allow" group be created and added to the **msdsRevealOnDemandGroup** attribute of the RODC. Any accounts that are determined to be cacheable will be added to this group. Using this type of group makes it possible for changes to be picked up by the default auditing scheme in Windows Server 2008. This results in Event ID 4756 when a security principal is added and Event ID 4757 when a security principal is removed.  
  
### Administering the PRP  
 For  detailed information about how to administer the PRP, see Administering the Password Replication Policy \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=133488](http://go.microsoft.com/fwlink/?LinkId=133488)\).  
  
### Monitoring PRP compliance  
 You may want to ensure that the principals whose passwords have been cached on the RODC match the expectation of the constraints that the PRP sets. If the PRP for the perimeter network RODC is controlled by a single group, this task involves comparing an export of the membership of the group with the constructed attribute **msDS\-RevealedList** on the RODC computer account. All the principals in the **msDS\-RevealedList** output should be members of the perimeter network RODC Allow group, with the exception of the RODC account and the krbtgt account.  
  
##  <a name="ad_rep"></a> Active Directory replication  
 As a side effect of the read\-only nature of the RODC, no new data originates from it. Consequently, there is no need to replicate data out of the perimeter network.  
  
### Considerations  
 The primary considerations for Active Directory replication in the perimeter network are domain controller placement, topology, and reliability. As with any other RODC deployment, the RODC must be able to replicate directly from a Windows Server 2008 writeable domain controller partner in the same domain. Therefore, physical connectivity to one or more writeable domain controllers is required and must be supported by a matching Active Directory site or site link configuration.  
  
 In addition, we recommend in the ”Securing RODC Communication” section, later in this topic, that the RODCs in the perimeter network be allowed to communicate only with a specific subset of the writeable domain controllers in its domain that reside in the internal network.  
  
### Approaches and recommendations  
 We recommend that you create a separate Active Directory site for the RODCs in the perimeter network. The writeable domain controllers that the RODCs can contact can be placed in a site of their own, with the appropriate subnet mapping and additionally consider enabling a site link between that site and the site that is specific to the RODCs in the perimeter network.  
  
 To avoid issues with a single point of failure, you may consider deploying multiple RODCs for each domain in the perimeter network.  
  
 In this case, it is important to ensure that the replication latency from the writeable domain controller to the RODC is reduced to an appropriate level.  
  
 For more information about Active Directory replication, see How Active Directory Replication Topology Works, \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=133487](http://go.microsoft.com/fwlink/?LinkId=133487)\).  
  
 Another aspect of RODC design to consider is writeable domain controller communication with the RODC. This consideration is driven by the effort to simplify firewall configuration. We recommend that you statically assign the remote procedure call \(RPC\) ports that are used for replication traffic. This has the advantage of constraining, in advance, the firewall ports that must be open to enable the traffic between the domain controllers. For more information about replication traffic through a firewall, see the following:  
  
-   Article 224196 in the Microsoft Knowledge Base \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=133489](http://go.microsoft.com/fwlink/?LinkId=133489)\)  
  
-   Active Directory Replication over Firewalls \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=123775](http://go.microsoft.com/fwlink/?LinkID=123775)\)  
  
##  <a name="secure_rodc_comm"></a> Securing RODC communication  
 To ensure security compliance and to reduce your organization’s vulnerability to outside attack, it is critical that you secure the communication between the RODC and the internal corporate network.  
  
### Writeable domain controller vs. RODC  
 The main difference between a writeable domain controller and an RODC from a communication standpoint is that a writable domain controller, in a domain that operates at Windows Server 2008 domain functional level, does not create any connections for replication from an RODC. This allows for simpler planning by eliminating the need to plan for replication from the RODC to the writeable domain controller.  
  
> [!NOTE]  
>  The exception to this rule is a scenario in which SYSVOL replicates through File Replication Service \(FRS\), in which case the writeable domain controller must be able to open an RPC FRS connection to the RODC to allow the replication of SYSVOL content from the writeable domain controller to the RODC. This requirement does not exist when you use Distributed File System \(DFS\) replication for SYSVOL replication when your domain is at the Windows Server 2008 domain functional level.  
  
### RODC improvements  
 Reducing the inbound connections from other domain controllers to the RODC helps lower the cost of design and administration of communication policies \(IPsEC and Firewall\).  
  
### Considerations  
 Security is the most important consideration when you design your RODC communication model. Other considerations include performance, reliability, and diagnostics.  
  
#### Security  
 As a general rule, allow only the minimum network traffic that is necessary to provide the intended service, and guarantee the correct level of reliability and supportability. To this extent you should test that the allowed traffic will permit failover and the use of diagnostic tools or troubleshooting tools. Another option is to create a recovery\/troubleshooting process with a “troubleshooting communication policy” that sets up the environment for troubleshooting, when necessary, by allowing the traffic that is required for support and troubleshooting.  
  
#### Performance  
 If you are using IPsec, the CPU load on the servers that are involved in the communication will be affected. The type of IPsec policy determines the increase in load. Authentication Header \(AH\) communication has less CPU usage than Encapsulating Security Payload \(ESP\). Firewall configurations have an impact on performance, just as IPsec, does by blocking and permitting actions. To ensure that the impact due to IPsec is minimal, you should test solutions with different hardware and communication policies until the CPU load is deemed acceptable for your requirements.  
  
#### Reliability  
 When you design the communication in your perimeter network solution, you should take into account the functionality that your router or firewall provides for filtering rules. RPC is one of the biggest considerations to take into account when you set firewall rules for domain members. You might find firewalls that are RPC\-aware that allow the firewall to open ports based on previous communication though port TCP 135 \(End Point Mapped\), the appropriate port between the server and client that allows RPC dynamic port use.  
  
 This functionality allows greater flexibility when you configure RPC ports rules, although it may be too wide to open from a security point of view. You can choose an intermediate approach in which the router allows an RPC bind to a specific TCP port where a static RPC server is listening. This allows for the dynamic opening of the client RPC ports when servers reply. You can use this technology to avoid opening a wide range of ports in the router for RPC use.  For more information see, Active Directory in Networks Segmented by Firewalls \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=45087](http://go.microsoft.com/fwlink/?LinkID=45087)\).  
  
 The required RPC interfaces for using AD DS have been enabled for static assignment. As a result, you can now include design scenarios in which RPC interfaces are statically defined. Using this configuration, the routers in your environment can open RPC client ports on an RPC bind.  
  
### Approaches  
 You should enable traffic flow between the perimeter network and the corporate network by establishing filtering rules that you can use on the router firewall rules, the client firewall \(Windows Firewall\) rules, and the client IPsec policy. At the same time, you may have to enable integrity or encryption on the network traffic to increase the level of security. You can do this by using IPsec AH and IPsec ESP communication.  
  
 You can manage both client local Firewall and IPsec policy centrally from the Group Policy objects \(GPOs\) for the domain.  
  
### Technologies options  
 The two native Windows Server 2008 technologies that you can use for communication are IPsec and local Firewall.  
  
#### IPsec  
 IPsec is a powerful filtering and communication tunneling tool that you can use to control the communication between pairs of computers or a group of computers. It offers levels of security and encryption that can help reduce the number of “real” ports that are used, making the configuration of router firewall rules simpler. For more information about IPsec, see IPsec \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=136017](http://go.microsoft.com/fwlink/?LinkID=136017)\).  
  
#### Client firewall  
 You can use the client firewall \(Windows Firewall\) to control the traffic that is allowed in and out of the RODC or any other Windows\-based computer, based on IP and originating traffic application. The following table explains the advantages and disadvantages of using these technologies.  
  
|Issue|IPsec|Windows Firewall|  
|-----------|-----------|----------------------|  
|Router firewall ports|Allows the reduction of required ports on the firewall.|Does not reduce the required ports.|  
|Block and permit|Allows blocking and permit rules.|Allows blocking and permit rules.|  
|Integrity layer|Allows an Integrity check through the Authentication Headers \(AH\) protocol.|Does not allow an Integrity check.|  
|Confidentiality layer|Allows a confidentiality layer if it is required by the Encapsulating Security Payload \(ESP\) protocol.|Does not allow a confidentiality layer.|  
|CPU impact|Can increase CPU use in client computers and servers, depending on traffic load and the type of IPsec protocol that is used \(none, AH, ESP\).|No CPU impact.|  
|Configuration|Centralized through a Group Policy object \(GPO\).|Centralized through a GPO.|  
|Disable|Not easy to disable.|Easy to disable.|  
|Policy synchronization|Requires policy synchronization between the source and destination.|No policy synchronization required.|  
|Management cost|High management cost; you must confirm that all computers in the realm of the IPsec communication are in sync for changes to happen.|No much cost; the changed can be performed on a per\-computer basis.|  
|Scope of the policy|Based on IP level fact as source IP, destination IP, and ports. At the same time, it can be based on Kerberos authentication if you rely on this protocol for Internet Key Exchange \(IKE\) key exchange.|A part of normal IP information as source\/destination address and port; you can also base the configuration on the originator application.|  
  
### Design options  
 The design options for RODC communication are split into three different segments:  
  
-   Communication from client computers that belong to the perimeter network  
  
-   Communication from the RODC to a writeable domain controller  
  
-   Communication from the perimeter network to the writeable domain controller  
  
#### Communication from client computers that belong to the perimeter network  
 This communication depends on the solution that you implement in the perimeter network. You analyze each of the solution requirements to enable the necessary traffic into the RODC from the perimeter network.  
  
 For some examples of ports for different scenarios, see the “Required communication ports” section later in this topic.  
  
#### Communication from the RODC to a writeable domain controller  
 To enable the RODC role on a server that is designated to be an RODC, there must be communication between that server and a writeable domain controller.  
  
 For the required the ports for each functionality, see the “Required communication ports” section later in this topic.  
  
#### Communication from the perimeter network to a writeable domain controller  
 Based on the requirements of your RODC design, you may have to allow traffic from the perimeter network client computers and servers to a writeable domain controller that resides in the corporate network. For example, you may have to allow DNS traffic for dynamic updates, LDAP referrals, or other protocols, depending on your deployment scenario.  
  
### Tools  
 There are several tools that you can use to monitor the communication from the perimeter network to the internal corporate network:  
  
-   Sniffing tools, such as Microsoft Network Monitor and router filtering logging  
  
-   IPsec Mon  
  
-   Resultant Set of Policy \(RSoP\)  
  
-   Third\-party traffic\-monitoring tools  
  
    > [!NOTE]  
    >  Many of the traffic\-monitoring solutions require traffic to reach the wire in clear format. IPsec ESP encrypts the content and prevents these tools from detecting traffic that may be coming from attacks. You can check whether your traffic\-monitoring solutions are compatible with IPsec AH. This protocol does not encrypt the traffic, although it still permits IPsec security to be in place.  
  
### Required communication ports  
 The following table lists the ports that you must open on the firewall to allow communication from a writeable domain controller in the corporate network to the RODC in the perimeter network, along with the type of traffic that is used on these ports.  
  
|Port|Type of traffic|  
|----------|---------------------|  
|TCP 135|EPM|  
|TCP Static 53248|FrsRpc|  
|TCP 389|LDAP|  
  
> [!NOTE]  
>  For more information about configuring file replication through a specific static port see the Microsoft support article, \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=149419](http://go.microsoft.com/fwlink/?LinkId=149419)\)  
  
 The following table below lists the ports that you must open on the firewall to allow communication from the RODC in the perimeter network to a writeable domain controller in the corporate network, along with the type of traffic that is used on these ports.  
  
|Port|Type of traffic|  
|----------|---------------------|  
|TCP 49152\-65535|LSASS|  
|TCP 135|EPM|  
|TCP 389|LDAP|  
|TCP 3268|GC, LDAP|  
|TCP 445|DFS, LsaRpc, NbtSS, NetLogonR, SamR, SMB, SrvSvc|  
|TCP 53|DNS|  
|TCP 88|Kerberos|  
|UDP 123|NTP|  
|UDP 389|C\-LDAP|  
|UDP 53|DNS|  
|TCP 5722|DFS\-R|  
|TCP and UDP 464|Kerberos Change\/Set Password|  
  
> [!NOTE]  
>  For more information about configuring Active Directory replications through a specific port see the Microsoft support article, \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=133489](http://go.microsoft.com/fwlink/?LinkID=133489)\)  
  
 The following table lists the ports that you must open on the firewall to allow communication between the member servers in the perimeter network and the RODC in the perimeter network, along with the type of traffic that is used on these ports. You must open these ports only if there is an internal firewall that separates your member servers in the perimeter network from the RODC in the perimeter network.  
  
|Port|Type of traffic|  
|----------|---------------------|  
|TCP 135|EPM|  
|TCP 389|LDAP|  
|TCP 5722|DFS\-R|  
|TCP 445|DFS, LsaRpc, NbtSS, NetLogonR, SamR, SMB, SrvSvc|  
|TCP 88|Kerberos|  
|TCP Dynamic|DNS, DRSUAPI, NetLogonR, SamR|  
|UDP 389|C\-LDAP|  
|UDP 53|DNS|  
  
> [!NOTE]  
>  If you are using Windows Server 2003 in the perimeter network, you must also open port UDP 88 for Kerberos communication. In contrast, by default Windows Server 2008 uses only port TCP 88 for Kerberos communication.  
  
##  <a name="domain_join_rodc"></a> Domain join using RODC  
 During deployment and management of the perimeter network, you have to join computers to the domain.  
  
### RODC vs. writeable domain controller  
 RODCs do not allow normal domain joins; they allow only ”read\-only” domain joins. This is an unsecure join that requires no write to the database. Therefore, you must ensure that the appropriate information that is necessary for the join to succeed is in place before you proceed with the join.  
  
### RODC improvements  
 Because an RODC only allows ”read\-only” domain joins, the security of the domain is enhanced if the RODC is compromised. To join a new member to the domain, you must perform certain actions on the writeable domain controller in advance.  
  
### Considerations  
 The Windows user interface \(UI\) does not perform a ”read\-only” domain join by default. Regular UI domain\-join code triggers a discovery for a writable domain controller. When that domain controller is found, a regular join is attempted. In most perimeter networks, the access to a writeable domain controller is blocked, even the discovery process fails. At the same time, the communication of a client computer using the Netlogon RPC interface that targets a writeable domain controller might be blocked also. Therefore, even if the discovery succeeds, the join fails.  
  
 To enable the domain join through an RODC, you must follow a process in which computer accounts, the PRP, and account passwords are updated on the writeable domain controller. After that you must use a specific tool \(a script or executable file\) that performs the RPC call with the required unsecure switch.  
  
 In addition, these new switches are not present on Windows systems that do not have the RODC compatibility pack installed. You must update these systems in advance with the RODC compatibility pack. To download the RODC compatibility pack, see article 944043 in the Microsoft Knowledge Base \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=122974](http://go.microsoft.com/fwlink/?LinkID=122974)\).  
  
### Approaches  
 This section describes the tasks to complete when you perform a domain join using an RODC.  
  
#### Allow a join with a writeable domain controller  
 If you have a perimeter network solution that allows for a window of time when services are not available, you can configure connectivity rules that allow for direct communication between client computers and the domain’s writeable domain controller. You can consider the use of these windows of time to make the domain joins of the computers in the perimeter network.  
  
#### Join through the RODC  
 Follow the steps in [Deploying RODCs in the Perimeter Network](../Topic/Deploying-RODCs-in-the-Perimeter-Network.md) section of this guide to perform a read\-only domain join through the RODC.  
  
#### Tools  
 In the [Deploying RODCs in the Perimeter Network](../Topic/Deploying-RODCs-in-the-Perimeter-Network.md) section of the guide, there is a sample script that you can use to perform a domain join with a RODC  
  
## See Also  
 [Troubleshooting RODC's: Troubleshooting RODC location in the DMZ](http://blogs.technet.com/b/instan/archive/2009/03/24/troubleshooting-rodc-s-troubleshooting-rodc-location-in-the-dmz.aspx)  
  
  