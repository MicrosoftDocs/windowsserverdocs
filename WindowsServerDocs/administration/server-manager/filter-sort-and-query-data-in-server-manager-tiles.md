---
title: Filter, sort, and query Data in Server Manager Tiles
description: "Server Manager"
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-server-manager
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8786f791-73e5-4c75-8d12-46e88a196976
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# Filter, sort, and query Data in Server Manager Tiles

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

In Windows Server, tiles in Server Manager let you filter and sort data, and create and save custom queries. You can sort, use keyword filters, and run queries on list entries in the Events, Performance, Best Practices Analyzer, Services, and Roles and Features tiles on server role or group pages in Server Manager.  
  
This topic contains the following sections.  
  
-   [Filter list entries in tiles](#BKMK_tiles)  
  
-   [sort list entries in tiles](#BKMK_sort)  
  
-   [create and run custom queries on tile data](#BKMK_query)  
  
## <a name="BKMK_tiles"></a>Filter list entries in tiles  
The **Filter** text box is a quick way of reducing the list of entries that are displayed in a tile to only those entries that contain a specified text string.  
  
#### To apply a filter to the list of entries in a tile  
  
1.  Open a role or server group page in Server Manager.  
  
2.  In the **Filter** text box of an Events, Performance, Best Practices Analyzer, Services, or Roles and Features tile, type a string on which you want to filter.  
  
    for example, if you want to see only events with an event ID of 1014, type **1014** in the **Filter** text box. All collected events that contain the string **1014** in at least one field are returned as results.  
  
3.  Note that the filter changes the description text under the tile title. Instead of **All** results, it says **Filtered results**.  
  
4.  To clear the filter, delete the string in the filter box, or click **X**.  
  
## <a name="BKMK_sort"></a>sort list entries in tiles  
sort list entries in Server Manager tiles by clicking column headings. Clicking a column heading the first time sorts column values in ascending alphanumeric order (arrow pointing up); clicking again sorts column values in descending alphanumeric order (arrow pointing down).  
  
## <a name="BKMK_query"></a>create and run custom queries on tile data  
You can create custom queries in the Events, Performance, Best Practices Analyzer, Services, or Roles and Features tiles in Server Manager. By default, the area of the tile toolbar in which you select criteria to build a custom query is hidden; click **expand** (chevron button at right edge of tile toolbar) to display query criteria.  
  
#### To create a custom query for tile data  
  
1.  Open a role or server group page in Server Manager.  
  
2.  In an Events, Performance, Best Practices Analyzer, Services, or Roles and Features tile, expand the query-building area by clicking **expand**.  
  
3.  Click **add criteria** to open a list of attributes (or fields) that apply to the entries in the tile.  
  
4.  select criteria to add. When you are finished, click **add**. Criteria that you selected are added to the query-building area.  
  
5.  Click the hypertext operator to select an operator. For numerical or date and time criteria, for example, the default is **less than or equal to**.  
  
6.  Specify acceptable values for the criteria. For example, if you selected **date and time**, provide a date in the format *m/d/yyyy*.  
  
7.  Repeat these steps from step 3 forward to add more criteria to your query.  
  
    You can add duplicates of criteria that are already in your query, but the duplicates are added to the query with the **or** operator.  
  
    for example, to query for event IDs 1003 or 1014, you would first add the ID criteria to your query, make the value of ID equal to **1003**, and then add a second ID criteria to your query, making the value of the second ID equal to **1014**. The resulting query is **and ID equals 1003 or ID equals 1014**.  
  
8.  When you are finished adding criteria and specifying operators and values, click **Save** to save the query.  
  
9. Enter a friendly name for the query. For example, the query created in the preceding step can be named **Licensing events**.  
  
10. When you are finished viewing query results, click **Clear All** to clear all filters and queries, and display all entries in the list.  
  
11. To run a saved query, click **Saved Search Queries**, and click the name of the saved query that you want to run.  
  
12. To delete a saved query, click **Saved Search Queries**, and then click **X** by the name of the saved query that you want to delete.  
  
## See Also  
[Server Manager](server-manager.md)  
[View and Configure Performance, Event, and Service Data](view-and-configure-performance-event-and-service-data.md)  
  


