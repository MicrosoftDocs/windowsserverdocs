---
title: LDAP considerations in ADDS performance tuning
description: LDAP considerations in Active Directory workloads
ms.topic: article
ms.author: timwi
author: phstee
ms.date: 10/16/2017
---

# LDAP considerations in ADDS performance tuning

> [!IMPORTANT]
> The following is a summary of the key recommendations and considerations to optimize server hardware for Active Directory workloads covered in greater depth in the [Capacity Planning for Active Directory Domain Services](./capacity-planning-for-active-directory-domain-services.md) article. Readers are highly encouraged to review [Capacity Planning for Active Directory Domain Services](./capacity-planning-for-active-directory-domain-services.md) for a greater technical understanding and implications of these recommendations.

## Verify LDAP queries

Verify that LDAP queries conform with the creating efficient queries recommendations.

There is extensive documentation on MSDN about how to properly write, structure, and analyze queries for use against Active Directory. For more info, see [Creating More Efficient Microsoft Active Directory-Enabled Applications](/previous-versions/ms808539(v=msdn.10)).

## Optimize LDAP page sizes

When returning results with multiple objects in response to client requests, the domain controller has to temporarily store the result set in memory. Increasing page sizes will cause more memory usage and can age items out of cache unnecessarily. In this case, the default settings are optimal. There are several scenarios where recommendations were made to increase the page size settings. We recommend using the default values unless specifically identified as inadequate.

When queries have many results, a limit of similar queries concurrently executed may be encountered.  This occurs as the LDAP server may deplete a global memory area known as the cookie pool.  It may be necessary to increase the size of the pool as discussed in [How LDAP Server Cookies Are Handled](../../../../identity/ad-ds/manage/how-ldap-server-cookies-are-handled.md).

To tune these settings, see [Windows Server 2008 and newer domain controller returns only 5000 values in a LDAP response](https://support.microsoft.com/kb/2009267).

## Determine whether to add indices

Indexing attributes is useful when searching for objects that have the attribute name in a filter. Indexing can reduce the number of objects that must be visited when evaluating the filter. However, this reduces the performance of write operations because the index must be updated when the corresponding attribute is modified or added. It also increases the size of the directory database, though the benefits often outweigh the cost of storage. Logging can be used to find the expensive and inefficient queries. Once identified, consider indexing some attributes that are used in the corresponding queries to improve the search performance. For more info on how Active Directory Searches work, see [How Active Directory Searches Work](/previous-versions/windows/it-pro/windows-server-2003/cc755809(v=ws.10)).

### Scenarios that benefit in adding indices

-   Client load in requesting the data is generating significant CPU usage and the client query behavior cannot be changed or optimized.

-   The client load is generating significant disk I/O on a server due to an unindexed attribute and the client query behavior cannot be changed or optimized.

-   A query is taking a long time and is not completing in an acceptable timeframe to the client due to lack of covering indices.

- Large volumes of queries with high durations are causing consumption and exhaustion of ATQ LDAP Threads. Monitor the following performance counters:

    - **NTDS\\Request Latency** – This is subject to how long the request takes to process. Active Directory times out requests after 120 seconds (default), however, the majority should run much faster and extremely long running queries should get hidden in the overall numbers. Look for changes in this baseline, rather than absolute thresholds.

        > [!NOTE]
        > High values here can also be indicators of delays in "proxying" requests to other domains and CRL checks.

    - **NTDS\\Estimated Queue Delay** – This should ideally be near 0 for optimal performance as this means that requests spend no time waiting to be serviced.

These scenarios can be detected using one or more of the following approaches:

-   [Determining Query Timing with the Statistics Control](/previous-versions/ms808539(v=msdn.10))

-   [Tracking Expensive and Inefficient Searches](/previous-versions/ms808539(v=msdn.10))

-   Active Directory Diagnostics Data Collector Set in Performance Monitor ([Son of SPA: AD Data Collector Sets in Win2008 and beyond](/archive/blogs/askds/son-of-spa-ad-data-collector-sets-in-win2008-and-beyond))

-   Searches using any filter besides "(objectClass=\*)" that use the Ancestors Index.

### Other index considerations

-   Ensure that creating the index is the right solution to the problem after tuning the query has been exhausted as an option. Sizing hardware properly is very important. Indices should be added only when the right fix is to index the attribute, and not an attempt to obfuscate hardware problems.

-   Indices increase the size of the database by a minimum of the total size of the attribute being indexed. An estimate of database growth can therefore be evaluated by taking the average size of the data in the attribute and multiplying by the number of objects that will have the attribute populated. Generally this is about a 1% increase in database size. For more info, see [How the Data Store Works](/previous-versions/windows/it-pro/windows-server-2003/cc772829(v=ws.10)).

-   If search behavior is predominantly done at the organization unit level, consider indexing for containerized searches.

-   Tuple indices are larger than normal indices, but it is much harder to estimate the size. Use normal indices size estimates as the floor for growth, with a maximum of 20%. For more info, see [How the Data Store Works](/previous-versions/windows/it-pro/windows-server-2003/cc772829(v=ws.10)).

-   If search behavior is predominantly done at the organization unit level, consider indexing for containerized searches.

-   Tuple Indices are needed to support medial search strings and final search strings. Tuple indices are not needed for initial search strings.

    -   Initial Search String – (samAccountName=MYPC\*)

    -   Medial Search String - (samAccountName=\*MYPC\*)

    -   Final Search String – (samAccountName=\*MYPC$)

-   Creating an index will generate disk I/O while the index is being built. This is done on a background thread with lower priority and incoming requests will be prioritized over the index build. If capacity planning for the environment has been done correctly, this should be transparent. However, write-heavy scenarios or an environment where the load on the domain controller storage is unknown could degrade client experience and should be done off-hours.

-   Affects to replication traffic is minimal since building indices occurs locally.

For more info, see the following:

-   [Creating More Efficient Microsoft Active Directory-Enabled Applications](/previous-versions/ms808539(v=msdn.10))

-   [Searching in Active Directory Domain Services](/windows/win32/ad/searching-in-active-directory-domain-services)

-   [Indexed Attributes](/windows/win32/ad/indexed-attributes)

## Additional References

- [Performance tuning Active Directory Servers](index.md)
- [Hardware considerations](hardware-considerations.md)
- [Proper placement of domain controllers and site considerations](site-definition-considerations.md)
- [Troubleshooting ADDS performance](troubleshoot.md)
- [Capacity Planning for Active Directory Domain Services](./capacity-planning-for-active-directory-domain-services.md)