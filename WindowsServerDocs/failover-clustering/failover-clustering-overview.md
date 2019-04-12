---
ms.assetid: c9844427-27cf-4d76-b5bb-e06368b092f7
title: Failover Clustering  
ms.prod: windows-server-threshold
layout: LandingPage  
ms.topic: landing-page
ms.manager: dongill
author: JasonGerend
ms.author: jgerend  
ms.technology: storage-failover-clustering
ms.date: 03/08/2019
ms.localizationpriority: high
---
# Failover Clustering in Windows Server

> Applies to: Windows Server 2019, Windows Server 2016, Windows Server (Semi-Annual Channel)

>[!TIP]
> Looking for information about older versions of Windows Server? Check out our other [Windows Server libraries](/previous-versions/windows/) on docs.microsoft.com. You can also [search this site](https://docs.microsoft.com/search/index?search=Windows+Server&dataSource=previousVersions) for specific information.

<hr />

A failover cluster is a group of independent computers that work together to increase the availability and scalability of clustered roles (formerly called clustered applications and services). The clustered servers (called nodes) are connected by physical cables and by software. If one or more of the cluster nodes fail, other nodes begin to provide service (a process known as failover). In addition, the clustered roles are proactively monitored to verify that they are working properly. If they are not working, they are restarted or moved to another node.

Failover clusters also provide Cluster Shared Volume (CSV) functionality that provides a consistent, distributed namespace that clustered roles can use to access shared storage from all nodes. With the Failover Clustering feature, users experience a minimum of disruptions in service.

Failover Clustering has many practical applications, including:
* Highly available or continuously available file share storage for applications such as Microsoft SQL Server and Hyper-V virtual machines
* Highly available clustered roles that run on physical servers or on virtual machines that are installed on servers running Hyper-V

<hr />

<ul class="cardsF panelContent">
<li>
                         <div class="cardSize">
                                <div class="cardPadding">
                                    <div class="card">
                                        <div class="cardImageOuter">
                                            <div class="cardImage">
                                                <img src="../media/i-whats-new.svg" alt="" />
                                            </div>
                                        </div>
                                        <div class="cardText">
                                        <h2><a href="whats-new-in-failover-clustering.md">What's new in Failover Clustering</a></h2>
                                        </div>
                                    </div>
                                </div>
                             </div>
                          </a>
                        </li>
                     </ul>
<HR />

<ul class="cardsF panelContent">

<li>
                         <div class="cardSize">
                                <div class="cardPadding">
                                    <div class="card">
                                        <div class="cardImageOuter">
                                            <div class="cardImage">
                                                <img src="../media/i-cluster.svg" alt="" />
                                            </div>
                                        </div>
                                        <div class="cardText">
                                        <h3>Understand</h3>
<HR />
                                        <p><a href="sofs-overview.md">Scale-Out File Server for application data</a></p>
<HR />
                                        <p><a href="../storage/storage-spaces/understand-quorum.md">Cluster and pool quorum</a></p>
<HR />
                                        <p><a href="fault-domains.md">Fault domain awareness</a></p>
<HR />
                                        <p><a href="smb-multichannel.md">Simplified SMB Multichannel and multi-NIC cluster networks</a></p>
<HR />
                                        <p><a href="vm-load-balancing-overview.md">VM load balancing</a></p>
<HR />
                                        <p><a href="../storage/storage-spaces/cluster-sets.md">Cluster sets</a></p>
<HR />
                                        <p><a href="cluster-affinity.md">Cluster affinity</a></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                          </a>
                        </li>

<li>
                         <div class="cardSize">
                                <div class="cardPadding">
                                    <div class="card">
                                        <div class="cardImageOuter">
                                            <div class="cardImage">
                                                <img src="../media/i-cluster.svg" alt="" />
                                            </div>
                                        </div>
                                        <div class="cardText">
                                        <h3>Planning</h3>
<HR />
										<p><a href="clustering-requirements.md">Failover Clustering Hardware Requirements and Storage Options</a></p>
<HR />
                                        <p><a href="failover-cluster-csvs.md">Use Cluster Shared Volumes (CSVs)</a></p>               
<HR />
                                        <p><a href="../storage/storage-spaces/storage-spaces-direct-in-vm.md">Using guest virtual machine clusters with Storage Spaces Direct</a></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                          </a>
                        </li>
<li>
                         <div class="cardSize">
                                <div class="cardPadding">
                                    <div class="card">
                                        <div class="cardImageOuter">
                                            <div class="cardImage">
                                                <img src="../media/i-cluster.svg" alt="" />
                                            </div>
                                        </div>
                                        <div class="cardText">
                                        <h3>Deployment</a></h3> 
<HR />
                                        <p><a href="prestage-cluster-adds.md">Prestage Cluster Computer Objects in Active Directory Domain Services</a></p>
<HR />
                                        <p><a href="create-failover-cluster.md">Creating a Failover Cluster</a></p> 
<HR />
                                        <p><a href="deploy-two-node-clustered-file-server.md">Deploy a two-node file server</a></p> 
<HR />
                                        <p><a href="manage-cluster-quorum.md">Manage the quorum and witnesses</a></p> 
<HR />
                                        <p><a href="deploy-cloud-witness.md">Deploy a cloud witness</a></p>
<HR />
                                        <p><a href="file-share-witness.md">Deploy a file share witness</a></p>
<HR />
                                        <p><a href="cluster-operating-system-rolling-upgrade.md">Cluster operating system rolling upgrades</a></p> 
<HR />
                                        <p><a href="upgrade-option-same-hardware.md">Upgrading a failover cluster on the same hardware</a></p>
<HR />
                                        <p><a href="https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn265970\(v%3dws.11\)">Deploy an Active Directory Detached Cluster</a></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                          </a>
                        </li>
                     </ul>
<HR />
<ul class="cardsF panelContent">
<li>
                         <div class="cardSize">
                                <div class="cardPadding">
                                    <div class="card">
                                        <div class="cardImageOuter">
                                            <div class="cardImage">
                                                <img src="../media/i-cluster.svg" alt="" />
                                            </div>
                                        </div>
                                        <div class="cardText">
                                        <h3>Manage</h3>
<HR />
                                        <p><a href="cluster-aware-updating.md">Cluster-Aware Updating</a></p> 
<HR />
                                        <p><a href="health-service-overview.md">Health Service</a></p>
<HR />
                                        <p><a href="cluster-domain-migration.md">Cluster-domain migration</a></p>
<HR />
                                        <p><a href="troubleshooting-using-wer-reports.md">Troubleshooting using Windows Error Reporting</a></p> 
                                        </div>
                                    </div>
                                </div>
                            </div>
                          </a>
                        </li>
<li>
                         <div class="cardSize">
                                <div class="cardPadding">
                                    <div class="card">
                                        <div class="cardImageOuter">
                                            <div class="cardImage">
                                                <img src="../media/i-cluster.svg" alt="" />
                                            </div>
                                        </div>
                                        <div class="cardText">
                                        <h3>Tools and settings</a></h3>
<HR />
                                        <p><a href="https://docs.microsoft.com/powershell/module/failoverclusters/?view=win10-ps">Failover Clustering PowerShell Cmdlets</a></p> 
<HR />
                                        <p><a href="https://docs.microsoft.com/powershell/module/clusterawareupdating/?view=win10-ps">Cluster Aware Updating PowerShell Cmdlets</a></p> 
                                        </div>
                                    </div>
                                </div>
                            </div>
                          </a>
                        </li>
<li>
                         <div class="cardSize">
                                <div class="cardPadding">
                                    <div class="card">
                                        <div class="cardImageOuter">
                                            <div class="cardImage">
                                                <img src="../media/i-cluster.svg" alt="" />
                                            </div>
                                        </div>
                                        <div class="cardText">
                                        <h3>Community resources</a></h3>
<HR />
                                        <p><a href="https://go.microsoft.com/fwlink/p/?LinkId=230641">High Availability (Clustering) Forum</a></p> 
<HR />
                                        <p><a href="http://blogs.msdn.com/b/clustering/">Failover Clustering and Network Load Balancing Team Blog</a></p> 
                                        </div>
                                    </div>
                                </div>
                            </div>
                          </a>
                        </li>
</ul>
