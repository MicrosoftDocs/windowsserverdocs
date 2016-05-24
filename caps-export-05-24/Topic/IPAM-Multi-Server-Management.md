---
title: IPAM Multi-Server Management
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 937c6d67-1a0b-4e45-bdff-180a4f0c49dc
---
# IPAM Multi-Server Management
IPAM enables you to monitor and manage multiple DHCP servers and monitor multiple DNS servers that are distributed across different regions from a centralized console.  
  
## Multiserver management and display  
Administrative tasks are frequently repetitive across multiple servers, and the ability to run these tasks uniformly across servers reduces the effort involved and the probability of error. The IPAM multiserver management \(MSM\) feature enables you to easily edit and configure key properties of multiple DHCP servers and scopes across the organization. IPAM also enables tagging servers with built\-in and user\-defined custom field values to visualize these servers and group them into logical groups and subgroups.  
  
## Service and zone monitoring  
IPAM facilitates monitoring and tracking of DHCP and DNS service status on the network. With IPAM, you can monitor hundreds of DNS and DHCP servers allocated across multiple regions from a centralized console.  
  
IPAM service monitoring includes regular verification that the DNS or DHCP service is running, stopped, or paused on a managed server, and that there is proper network connectivity. Along with DHCP and DNS service status, IPAM allows monitoring of all DHCP scopes from a central console. The status of a scope as active or inactive is displayed. Utilization percentage for a scope is displayed with a current utilization status of: Over, Under, or Optimal.  
  
You can also monitor the “health” of a DNS zone on multiple DNS servers by viewing the zone status per server, and by displaying the aggregated status of a zone across all authoritative DNS servers.  
  
DNS zone monitoring includes the following:  
  
-   Forward lookup zones: IPAM displays a list of all forward lookup zones that are hosted by managed DNS servers. The overall status of each zone is provided, based on the status of the zone on each authoritative server, and the state of the authoritative server.  
  
-   IPv4 reverse lookup zones: IPAM displays all IPv4 reverse lookup zones that are hosted by managed DNS servers. A list of all authoritative servers that are hosting the selected reverse lookup zone is displayed.  
  
-   IPv6 reverse lookup zones: IPAM displays all IPv6 reverse lookup zones that are hosted by managed DNS servers. A list of all authoritative servers that are hosting the selected reverse lookup zone is displayed.  
  
IPAM displays a list of all authoritative servers for a zone in the preview pane along with zone type, zone health status, and duration of the current status.  
  
Some of the key attributes that are monitored include:  
  
-   Server availability state: State of the DNS service on a server.  
  
-   Zone status: State of the zone on a server.  
  
-   Zone status for all servers: Aggregate status of the zone across all authoritative servers.  
  
## Configuration monitoring  
IPAM displays server operational events for managed DHCP servers, DNS servers, and for the IPAM server. IPAM enables you to view event logs, perform searches based on multiple fields, and export information to a file. You can also save queries and modify or reuse them later. Configuration change events include the following details:  
  
1.  Event ID  
  
2.  Event description  
  
3.  Event time  
  
4.  Server name  
  
5.  Domain and user name for the user who is running the configuration event  
  
Additional fields are available for IPAM server configuration events, including task category, opcode, and keywords. IPAM also provides advanced query constructs within the event description field, which enables you to filter for other information such as Network ID, IP address, group name, or custom field name.  
  
## Server and scope management  
The IPAM MSM feature enables you to view and easily configure the key properties of multiple DHCP servers across the organization. Tasks that are frequently repetitive, such as altering a scope option setting on multiple DHCP scopes, can be performed uniformly across multiple servers. This reduces the effort required and the probability of error.  
  
The following noncontextual are available from the Tasks menu:  
  
-   **Retrieve Server Data**: Trigger background tasks to retrieve and update information such as service status, DHCP server and scope configuration, and DNS zone status.  
  
-   **Export**: Export records from the current IPAM view into a file of comma\-separated values. If you have applied any filters in the view, only filtered records will be exported.  
  
### DHCP server management actions  
The following actions are available for DHCP servers:  
  
-   **Edit DHCP Server Properties**: Configure the server properties of a DHCP server.  
  
-   **Edit DHCP Server Options**: Enables adding, deleting, editing, and find\-and\-replace operations on options at the server level. This action can be performed on multiple DHCP servers simultaneously.  
  
-   **Create DHCP Scope**: Create a scope on a DHCP server, and configure multiple scope properties.  
  
-   **Configure Predefined DHCP Options**: Add, edit, or delete predefined options. This action can be performed on multiple DHCP servers simultaneously.  
  
-   **Configure User Class**: Create, overwrite, or delete User Classes. This action can be performed on multiple DHCP servers simultaneously.  
  
-   **Configure Vendor Class**: Create, overwrite, or delete Vendor Classes. This action can be performed on multiple DHCP servers simultaneously.  
  
-   **Launch MMC**: Open a DHCP console window for the selected DHCP server.  
  
-   **Retrieve Server Data**: Retrieve current data on\-demand from the DHCP server. This action can be performed on multiple DHCP servers simultaneously.  
  
### DNS server management actions  
The following actions are available for DNS servers:  
  
-   **Launch MMC**: Open a DNS Manager window for the selected DHCP server.  
  
-   **Retrieve Server Data**: Retrieve current data on\-demand from the DNS server. This action can be performed on multiple DNS servers simultaneously.  
  
### DHCP scope management actions  
The following actions are available for DHCP scopes:  
  
-   **Edit DHCP Scopes**: Edit lease duration, exclusion ranges, DNS dynamic updates, and scope options. Scope editing includes adding, deleting, editing, and find\-and\-replace operations. Actions can be performed on one scope or on multiple scopes simultaneously.  
  
-   **Duplicate DHCP Scope**: Create a new scope, and configure it with the same properties as the selected scope.  
  
-   **Activate DHCP Scope**: Activate one or more scopes.  
  
-   **Deactivate DHCP Scope**: Deactivate one or more scopes.  
  
-   **Delete**: Delete one or more scopes.  
  
## See also  
[IP Address Management Overview](assetId:///9035778c-7ab3-42d0-8540-45a163c1d46b)  
  
[Multi\-server Management](../Topic/Multi-server-Management.md)  
  
