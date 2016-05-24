---
title: IPAM IP Management
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d1737e23-2ade-4f3e-acf1-45740b853d55
---
# IPAM IP Management
The IPAM address space management \(ASM\) feature provides the ability to efficiently view, monitor, and manage IP address space on the network. The ASM feature supports IPv4 public and private address space, and IPv6 address space. You can manage dynamic IP addresses and static IP addresses on the network using IPAM ASM.  
  
The ASM feature addresses IP address space management problems in a growing distributed environment by ensuring better planning and control. IPAM also enables you to easily perform several essential administrative actions, including: detect overlapping IP address ranges that are defined on different DHCP servers, find available IP addresses within a range, create DHCP reservations, and create DNS records. IPAM ASM enables IPv4 and IPv6 address space planning, allocation, and inventory management.  
  
Features of IPAM ASM include:  
  
-   IP address space utilization statistics and trend monitoring  
  
-   Support for import and export of IP address space in comma\-separated\-value format  
  
-   Organizing and visualizing of address space data into custom\-defined hierarchical logical groups  
  
-   Identification and reservation of available IP addresses  
  
-   Expiry assignment and notification for IP addresses  
  
-   Advanced search and filter functions  
  
## Organizing IP address space  
IPAM helps to organize IP address space on your network by providing a highly customizable, hierarchical display. A network administrator can also display utilization trends, track IP address utilization and view threshold\-crossing status for specific IP address ranges.  
  
By default, IPAM allocates IP address space into IP address blocks, IP address ranges, and individual IP addresses.  
  
IP address blocks are large chunks of IP addresses that are used to organize address space at a high level. IP address ranges are smaller chunks of IP addresses that typically correspond to a DHCP scope. Individual IP addresses correspond to hosts or devices on the network.  
  
IPAM displays IP address blocks in a multilevel hierarchy of superblocks and sub\-blocks, if applicable. When you add an IP address range to IPAM, it is automatically mapped to the appropriate IP address block. Similarly, individual IP addresses are mapped to IP address ranges. If duplicate IP addresses or ranges exist, these can be identified using unique service and service instance fields.  
  
### Customizing IP address space display  
IPAM enables highly customizable sorting and display of IP address space. The display can be based on custom fields, such as region, Regional Internet Registries \(RIR\), device type, or customer name. IPAM enables you to add new free\-format or multivalued custom fields or to extend built\-in multivalued custom fields. Custom fields can be used to tag IPAM objects, and enables real\-world logical groups to be defined using a multilevel hierarchy of custom fields. With IPAM, you can organize and visualize IP address space using logical groups, depending on your business need. For example, you might organize and view IP address ranges based on geographical location or business unit. To achieve this, you can create a logical group based on country or business unit, and then apply the country or business unit field to the IP address ranges. This enables you to view the IP address ranges that are used by a particular business unit or are in a country by simply clicking the appropriate logical group.  
  
You can also track utilization data that is rolled up at the logical group level, based on IP address ranges. Multiple IP range groups can be created simultaneously. IPAM also contains a built\-in logical range group, which is called the Managed By group. This group is organized by Managed by Service and Service Instance values of the range.  
  
IPAM enables organizing of IP address space using a built\-in logical group that is organized by default using device type and called the IP Address Inventory group. IP address inventory data can be imported, exported, and modified to maintain a database of IP addresses.  
  
### Address space operations  
IPAM ASM provides the following IP address space operations.  
  
#### Non\-contextual operations  
The following non\-contextual operations are available from the Tasks menu in address space or by right\-clicking nodes in left navigation pane.  
  
-   **Add IP Address Block**: Create a new IP address block and add basic configuration information.  
  
-   **Add IP Address Range**: Create a new IP address range and add basic and custom configuration information.  
  
-   **Add IP Address**: Create a new IP address and add basic, custom, DHCP reservation and DNS record related information associated with the address.  
  
-   **Import IP Address Blocks**: Select a file of comma\-separated values that contain IP address block records, and then import these records from the file into IPAM. New addresses are added and existing addresses are updated in the IPAM database.  
  
-   **Import IP Address Ranges**: Select a file of comma\-separated values that contain IP address range records, and then import these records from the file into IPAM. New IP address ranges are added and existing addresses are updated in the IPAM database.  
  
-   **Import IP Addresses**: Select a file of comma\-separated values that contain IP address records, and then import these records from the file into IPAM. New IP addresses are added and existing addresses are updated in the IPAM database.  
  
-   **Import and Update IP Address Ranges**: Select a file of comma\-separated values that contain IP address records, and then import these records from the file into IPAM. New IP address ranges are added and existing addresses are updated in the IPAM database. If a record exists in IPAM with the same Managed By Service and Service Instance values, but the record is not present in the file, it will be deleted.  
  
-   **IP Address Expiry Log Settings**: Set the number of days before expiry that an IP address should be transitioned to a state of Expiry Due. You can also select whether to generate period expiry events or generate expiry events only on state transitions.  
  
-   **Retrieve Address Space Data**: Trigger background tasks to retrieve and update address space information such as utilization and expiry.  
  
-   **Export**: Export records from the current IPAM view into a file of comma\-separated values. If you have applied any filters in the view, only filtered records will be exported.  
  
#### IP address block operations  
The following are the right\-click contextual operations that are available on IP address blocks:  
  
-   **Add IP Address Block**: Provides a dialog with the properties of the currently selected IP address block, enabling allocation of a new sub\-block under the existing parent IP address block.  
  
-   **Edit IP Address Block**: Edit the selected IP address block and update basic information that is associated with the block.  
  
-   **Delete**: Delete the selected IP address block, and prompt for confirmation if the selected blocks have sub\-blocks that also must to be deleted.  
  
#### IP address range operations  
The following are the right\-click contextual operations that are available for IP address ranges:  
  
-   **Edit IP Address Range**: Edit the selected IP address range to update basic and custom information for the range.  
  
-   **Import and Update IP Addresses**: Select a file of comma\-separated values that contain a snapshot of all the IP addresses in the selected IP address range, and then import the records into IPAM. New addresses are added, existing address are modified, and missing addresses are deleted from IPAM to synchronize the existing database with the new data that is being imported.  
  
-   **Find and Allocate Available IP Address**: Find an available IP address from the selected range, confirm the availability status of the IP address using ping and DNS, and create new IP address record in IPAM.  
  
-   **Map to IP Address Block**: Map an IP address range by exchanging an existing overlapping range.  
  
-   **Reclaim IP Addresses**: Reclaim IP address records that have expired.  
  
-   **Retrieve Address Space Data**: Trigger background tasks to update address space information, such as utilization data.  
  
-   **Delete**: Delete the selected IP address range and prompt for confirmation if the selected range has IP addresses that also must be deleted.  
  
#### IP address operations  
The following are right\-click contextual operations on IP addresses:  
  
-   **Edit IP Address**: Edit the selected IP address record to update basic, custom, DHCP reservation and DNS record related information.  
  
-   **Create DHCP Reservation**: Create a DHCP reservation for the selected IP address record. You must edit the IP address record and provide DHCP reservation information before you attempt this operation.  
  
-   **Create DNS Host Record**: Creates a DNS host \(A\/AAAA\) record for the selected IP address record. You must edit the IP address record and provide DNS record information before you attempt this operation.  
  
-   **Create DNS PTR Record**: Create a DNS PTR record for the selected IP address record. You must edit the IP address record and provide DNS record information before you attempt this operation.  
  
-   **Delete DHCP Reservation**: Delete an existing DHCP reservation for the selected IP address.  
  
-   **Delete DNS Host Record**: Delete an existing DNS host \(A\/AAAA\) record for the selected IP address.  
  
-   **Delete DNS PTR Record**: Delete an existing DNS PTR record for the selected IP address.  
  
-   **Delete**: Delete the selected IP address record from IPAM.  
  
## See also  
[Managing IP Address Space \[ops\]](../Topic/Managing-IP-Address-Space.md)  
  
[IP Address Management Overview](assetId:///9035778c-7ab3-42d0-8540-45a163c1d46b)  
  
