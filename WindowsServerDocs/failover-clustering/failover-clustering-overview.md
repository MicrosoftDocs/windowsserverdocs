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
ms.localizationpriority: high
---
# Failover Clustering

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
                                        <h3><a href="failover-clustering/whats-new-in-failover-clustering.md">What's new in Failover Clustering</a></h3>
                                        </div>
                                    </div>
                                </div>
                             </div>
                          </a>
                        </li>
                     </ul>
<HR />

<ul class="cardsI panelContent">
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
                                        </div>
                                    </div>
                                </div>
                            </div>
                          </a>
                        </li>
<HR />
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
                                        <p><a href="https://technet.microsoft.com/library/jj134187">Deploy Hyper-V over SMB</a></p> 
<HR />
                                        <p><a href="https://technet.microsoft.com/library/hh831359">Deploy a Scale-Out File Server</a></p> 
<HR />
                                        <p><a href="https://technet.microsoft.com/library/hh848268">iSCSI Target Block Storage, How To</a></p> 
<HR />
                                        <p><a href="https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn265970\(v%3dws.11\)">Deploy an Active Directory Detached Cluster</a></p>
 <HR />
                                        <p><a href="https://technet.microsoft.com/library/dn440540.aspx">Using Guest Clustering for High Availability</a></p> 
<HR />
                                        <p><a href="https://technet.microsoft.com/library/dn265980.aspx">Deploy a Guest Cluster using a Shared Virtual Hard Disk</a></p> 
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
                                        <h3>Configure and Manage the Quorum in a Failover Cluster</a></h3>
<HR />
                                        <p><a href="https://technet.microsoft.com/library/hh831359">Configure and Manage the Quorum in a Failover Cluster</a></p> 
<HR />
                                        <p><a href="cluster-aware-updating.md">Use Cluster Shared Volumes in a Failover Cluster</a></p> 
<HR />
                                        <p><a href="https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn265970\(v%3dws.11\)">Deploy an Active Directory Detached Cluster</a></p>
 <HR />
                                        <p><a href="https://go.microsoft.com/fwlink/p/?LinkId=233200">Cluster-Aware Updating Overview</a></p> 
<HR />
                                        <p><a href="https://www.microsoft.com/itpro/windows/support">Windows IT Pro Support</a></p> 
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
                                        <p><a href="https://go.microsoft.com/fwlink/p/?LinkId=233200">Failover Clustering PowerShell Cmdlets</a></p> 
<HR />
                                        <p><a href="https://technet.microsoft.com/library/hh847221.aspx">Cluster Aware Updating PowerShell Cmdlets</a></p> 
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
