---
title: Failover Clustering  
ms.custom: na  
ms.prod: windows-server-threshold  
ms.reviewer: na  
ms.service:  na  
ms.suite: na  
ms.tgt_pltfrm: na  
ms.topic: article  
ms.assetid: na
author: Kumud  
ms.author: kumud  
ms.technology:
  - Failover Clustering
---
# Failover Clustering
>Applies To: Windows Server 2016

Failover clusters provide high availability and scalability to many server workloads. These include server applications such as Microsoft Exchange Server, Hyper-V, Microsoft SQL Server, and file servers. The server applications can run on physical servers or virtual machines. This topic describes the Failover Clustering feature and provides links to additional guidance about creating, configuring, and managing failover clusters that can scale to 64 physical nodes and to 8,000 virtual machines.

## <a id="what-is-failover-clustering"></a>What is Failover Clustering?
A failover cluster is a group of independent computers that work together to increase the availability and scalability of clustered roles (formerly called clustered applications and services). The clustered servers (called nodes) are connected by physical cables and by software. If one or more of the cluster nodes fail, other nodes begin to provide service (a process known as failover). In addition, the clustered roles are proactively monitored to verify that they are working properly. If they are not working, they are restarted or moved to another node. Failover clusters also provide Cluster Shared Volume (CSV) functionality that provides a consistent, distributed namespace that clustered roles can use to access shared storage from all nodes. With the Failover Clustering feature, users experience a minimum of disruptions in service.

This has many practical applications, including:
* Highly available or continuously available file share storage for applications such as Microsoft SQL Server and Hyper-V virtual machines
* Highly available clustered roles that run on physical servers or on virtual machines that are installed on servers running Hyper-V

## Learn more about Failover Clustering
### Windows Server 2016-specific content
* **[Cluster Operating System Rolling Upgrade](Cluster-Operating-System-Rolling-Upgrade.md)**  
  Cluster Operating System Rolling Upgrade is a new feature in Windows Server 2016 that enables an administrator to upgrade the operating system of the cluster nodes from  Windows Server 2012 R2  to Windows Server 2016 without stopping the Hyper-V or the Scale-Out File Server workloads. Using this feature, the downtime penalties against Service Level Agreements (SLA) can be avoided.
* **[Deploy a Cloud Witness for a Failover Cluster](Deploy-a-Cloud-Witness-for-a-Failover-Cluster.md)**
* **[Simplified SMB Multichannel and Multi-NIC Cluster Networks](Simplified-SMB-Multichannel-and-Multi-NIC-Cluster-Networks.md)**
* **[Health Service](health-service/health-service-overview.md)**  
  Health Service is a new feature in Windows Server 2016 that which significantly improves the day-to-day monitoring, operations, and maintenance experience of Storage Spaces Direct.
* **[Fault Domains](fault-domains.md)**  
  Fault Domains is a new feature in Windows Server 2016. This topic provides an overview of fault domains and describes how to configure them.


### General Failover Clustering Content
<table>
  <thead>
    <tr>
      <th>Content Type</th>
      <th>References</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>Planning</td>
      <td>
        <ul>
          <li><a href="https://technet.microsoft.com/en-us/library/jj612869(v=ws.11).aspx">Failover Clustering Hardware Requirements and Storage Options</a></li>
          <li><a href="https://technet.microsoft.com/en-us/library/jj134244(v=ws.11).aspx">Validate Hrdware for Failover Clustering</a></li>
          <li><a href="https://technet.microsoft.com/en-us/library/dn550728(v=ws.11).aspx">Network Recommendations for a Hyper-V Cluster</a></li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>Deployment</td>
      <td>
        <ul>
          <li><a href="http://go.microsoft.com/fwlink/p/?LinkId=253342">Installing the Failover Clustering Feature and Tools</a></li>
          <li><a href="https://technet.microsoft.com/en-us/library/jj134244(v=ws.11).aspx">Validate Hardware for a Failover Cluster</a></li>
          <li><a href="https://technet.microsoft.com/en-us/library/dn466519(v=ws.11).aspx">Prestage Cluster Computer Objects in Active Directory Domain Services</a></li>
          <li><a href="http://blogs.msdn.com/b/clustering/archive/2012/05/01/10299698.aspx">Creating a Failover Cluster</a></li>
          <li><a href="https://technet.microsoft.com/library/jj134187">Deploy Hyper-V over SMB</a></li>
          <li><a href="https://technet.microsoft.com/library/hh831359">Deploy a Scale-Out File Server</a></li>
          <li><a href="https://technet.microsoft.com/library/hh848268">iSCSI Target Block Storage, How To</a></li>
          <li><a href="https://technet.microsoft.com/library/jj556313.aspx">Deploy an Active Directory Detached Cluster</a></li>
          <li><a href="https://technet.microsoft.com/en-us/library/jj863389(v=ws.11).aspx">Using Guest Clustering for High Availability</a></li>
          <li><a href="https://technet.microsoft.com/en-us/library/dn265980(v=ws.11).aspx">Deploy a Guest Cluster using a Shared Virtual Hard Disk</a></li>
          <li><a href="https://technet.microsoft.com/en-us/library/hh831441(v=ws.11).aspx">Building Your Cloud Infrastructure: Scenario Overview</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>Operations</td>
      <td>
        <ul>
          <li><a href="https://technet.microsoft.com/en-us/library/jj612870(v=ws.11).aspx">Configure and Manage the Quorum in a Failover Cluster</a></li>
          <li><a href="https://technet.microsoft.com/en-us/library/jj612868(v=ws.11).aspx">Use Cluster Shared Volumes in a Failover Cluster</a></li>
          <li><a href="https://technet.microsoft.com/en-us/library/hh831694(v=ws.11).aspx">Cluster-Aware Updating Overview</a></li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>Tools and Settings</td>
      <td>
        <ul>
          <li><a href="http://go.microsoft.com/fwlink/p/?LinkId=233200">Failover Clustering Windows PowerShell Cmdlets</a></li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>Community Resources</td>
      <td>
        <ul>
          <li><a href="http://go.microsoft.com/fwlink/p/?LinkId=230641">High Availability (Clustering) Forum</a></li>
          <li><a href="http://blogs.msdn.com/b/clustering/">Failover Clustering and Network Load Balancing Team Blog</a></li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>Related Technologies</td>
      <td>
        <ul>
          <li><a href="https://technet.microsoft.com/en-us/library/hh831531(v=ws.11).aspx">Hyper-V Overview</a></li>
          <li><a href="https://technet.microsoft.com/en-us/library/hh831487(v=ws.11).aspx">File and Storage Services Overview</a></li>
          <li><a href="https://technet.microsoft.com/en-us/library/hh831739(v=ws.11).aspx">Storage Spaces Overview</a></li>
          <li><a href="https://technet.microsoft.com/en-us/library/hh831349(v=ws.11).aspx">Scale-Out File Server for Application Data Overview</a></li>
          <li><a href="https://technet.microsoft.com/en-us/library/hh831698(v=ws.11).aspx">Network Load Balancing Overview</a></li>
          <li><a href="https://www.microsoft.com/sqlserver/default.aspx">Microsoft SQL Server</a></li>
          <li><a href="https://www.microsoft.com/server-cloud/">Microsoft Server and Cloud Platform</a></li>
          <li><a href="https://technet.microsoft.com/systemcenter/vmm/default.aspx">System Center Virtual Machine Manager</a></li>
        </ul>
      </td>
    </tr>
  </tbody>
</table>