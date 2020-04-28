---
title: QoS Policy Scenarios
description: This topic provides Quality of Service (QoS) Policy scenarios, which demonstrate how to use Group Policy to prioritize the network traffic of specific applications and services in Windows Server 2016.
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: c4306f06-a117-4f65-b78b-9fd0d1133f95
manager: brianlic
ms.author: lizross
author: eross-msft
---

# QoS Policy Scenarios

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this topic to review hypothetical scenarios that demonstrate how, when, and why to use QoS Policy.

The two scenarios in this topic are:

1. Prioritize Network Traffic for a Line-of-Business Application
2. Prioritize Network Traffic for an HTTP Server Application

>[!NOTE]
>Some sections of this topic contain general steps you can take to perform the described actions. For more detailed instructions on managing QoS Policy, see [Manage QoS Policy](qos-policy-manage.md).

## Scenario 1: Prioritize Network Traffic for a Line-of-Business Application

In this scenario, an IT department has several goals that they can accomplish by using QoS Policy:

- Provide better network performance for mission\-critical applications.
- Provide better network performance for a key set of users while they are using a specific application.
- Ensure that the company\-wide data Backup application doesn't impede network performance by using too much bandwidth at one time.

The IT department decides to configure QoS Policy to prioritize specific applications by using Differentiation Service Code Point \(DSCP\) values to classify network traffic, and to configure its routers to provide preferential treatment for higher priority traffic. 

>[!NOTE]
>For more information on DSCP, see the section **Define QoS Priority Through a Differentiated Services Code Point** in the topic [Quality of Service (QoS) Policy](qos-policy-top.md).

In addition to DSCP values, QoS policies can specify a throttle rate. Throttling has the effect of limiting all outbound traffic that matches the QoS Policy to a specific send rate.

### QoS Policy Configuration

With three separate goals to accomplish, the IT administrator decides to create three different QoS policies.

#### QoS Policy for LOB App Servers

The first mission\-critical application for which the IT department creates a QoS Policy is a company\-wide Enterprise resource planning \(ERP\) application. The ERP application is hosted on several computers that are all running Windows Server 2016. In Active Directory Domain Services, these computers are members of an organization unit \(OU\) that was created for line-of-business \(LOB\)  application servers. The client\-side component for the ERP application is installed on computers that are running Windows 10 and Windows 8.1.

In Group Policy, an IT administrator selects the Group Policy Object \(GPO\) upon which the QoS policy will be applied. By using the QoS policy wizard, the IT administrator creates a QoS policy called "Server LOB policy" that specifies a high\-priority DSCP value of 44 for all applications, any IP address, TCP and UDP, and port number.

The QoS policy is applied only to the LOB servers by linking the GPO to the OU that contains only these servers, via the Group Policy Management Console \(GPMC\) tool. This initial server LOB policy applies the high\-priority DSCP value whenever the computer sends network traffic. This QoS policy can later be edited \(in the Group Policy Object Editor tool\) to include the ERP application's port numbers, which limits the policy to apply only when the specified port number is used.

#### QoS Policy for the Finance Group

While many groups within the company access the ERP application, the finance group depends on this application when dealing with customers, and the group requires consistently high performance from the app.

To ensure that the finance group can support their customers, the QoS policy must classify these users' traffic as high priority. However, the policy should not apply when members of the finance group use applications other than the ERP application. 

Because of this, the IT department defines a second QoS policy called "Client LOB policy" in the Group Policy Object Editor tool that applies a DSCP value of 60 when the finance user group runs the ERP application.

#### QoS Policy for a Backup App

A separate backup application is running on all computers. To ensure the backup application's traffic does not use all available network resources, the IT department creates a backup data policy. This backup policy specifies a DSCP value of 1 based on the executable name for the backup app, which is **backup.exe**. 

A third GPO is created and deployed for all client computers in the domain. Whenever the backup application sends data, the low-priority DSCP value is applied, even if it originates from computers in the finance department.
  
>[!NOTE]
>Network traffic without a QoS Policy sends with a DSCP value of 0.

### Scenario Policies

The following table summarizes the QoS policies for this scenario.
  
|Policy name|DSCP value|Throttle rate|Applied to organization units|Description|  
|-----------------|----------------|-------------------|-----------------------------------|-----------------|
|[No policy]|0|None|[No deployment]|Best effort (default) treatment for unclassified traffic.|  
|Backup data|1|None|All clients|Applies a low-priority DSCP value for this bulk data.|  
|Server LOB|44|None|Computer OU for ERP servers|Applies high-priority DSCP for ERP server traffic|  
|Client LOB|60|None|Finance user group|Applies high-priority DSCP for ERP client traffic|  

>[!NOTE]
>DSCP values are represented in decimal form.

With QoS policies defined and applied by using Group Policy, outbound network traffic receives the policy-specified DSCP value. Routers then provide differential treatment based on these DSCP values by using queuing. For this IT department, the routers are configured with four queues: high-priority, middle-priority, best-effort, and low-priority.

When traffic arrives at the router with DSCP values from "Server LOB policy" and "Client LOB policy," the data is placed into high-priority queues. Traffic with a DSCP value of 0 receives a best-effort level of service. Packets with a DSCP value of 1 (from the backup application) receive low-priority treatment.  
  
### Prerequisites for prioritizing a line-of-business application

To complete this task, ensure that you meet the following requirements:

- The computers involved are running QoS\-compatible operating systems.

- The computers involved are members of an Active Directory Domain Services \(AD DS\) domain so that they can be configured by using Group Policy.

- TCP/IP networks are set up with routers configured for DSCP \(RFC 2474\). For more information, see [RFC 2474](https://www.ietf.org/rfc/rfc2474.txt).

- Administrative credentials requirements are met.

#### Administrative credentials

To complete this task, you must be able to create and deploy Group Policy Objects.
  
#### Setting up the test environment for prioritizing a line-of-business application

To set up the test environment, complete the following tasks.

- Create an AD DS domain with clients and users grouped into organization units. For instructions on deploying AD DS, see the [Core Network Guide](https://docs.microsoft.com/windows-server/networking/core-network-guide/core-network-guide).

- Configure the routers to differentially queue based on DSCP values. For example, DSCP value 44 enters a "Platinum" queue and all others are weighted-fair-queued.

>[!NOTE]
> You can view DSCP values by using network captures with tools like Network Monitor. After you perform a network capture, you can observe the TOS field in captured data.

#### Steps for prioritizing a line-of-business application

To prioritize a line-of-business application, complete the following tasks:

1. Create and link a Group Policy Object \(GPO\) with a QoS policy.

2. Configure the routers to differentially treat a line-of-business application (by using queuing) based on the selected DSCP values. The procedures of this task will vary depending upon the type of routers you have.

## Scenario 2: Prioritize Network Traffic for an HTTP Server Application

In Windows Server 2016, Policy-based QoS includes the feature URL-based Policies. URL Policies enable you to manage bandwidth for HTTP servers.

Many Enterprise applications are developed for and hosted on Internet Information Services \(IIS\) web servers, and the Web apps are accessed from browsers on client computers.

In this scenario, assume that you manage a set of IIS servers that host training videos for all your organization's employees. Your objective is to ensure that the traffic from these video servers won't overwhelm your network, and ensure that video traffic is differentiated from voice and data traffic on the network. 

The task is similar to the task in Scenario 1. You will design and configure the traffic management settings, such as the DSCP value for the video traffic, and the throttling rate the same as you would for the line-of-business applications. But when specifying the traffic, instead of providing the application name, you only enter the URL to which your HTTP server application will respond: for example, https://hrweb/training.
  
> [!NOTE]
>You cannot use URL-based QoS policies to prioritize network traffic for computers running Windows operating systems that were released prior to Windows 7 and Windows Server 2008 R2.

### Precedence rules for URL-based policies

All the following URLs are valid and can be specified in QoS Policy and applied simultaneously to a computer or a user:

- https://video

- https://training.hr.mycompany.com

- https://10.1.10.249:8080/tech  

- https://*/ebooks

But which one will receive precedence? The rules are simple. URL-based policies are prioritized in a left-to-right reading order. So, from the highest priority to the lowest priority, the URL fields are:
  
[1. URL scheme](#bkmk_QoS_UrlScheme)

[2. URL host](#bkmk_QoS_UrlHost)

[3. URL port](#bkmk_QoS_UrlPort)

[4. URL path](#bkmk_QoS_UrlPath)

Details are as follows:

####  <a name="bkmk_QoS_UrlScheme"></a> 1. URL scheme

 `https://` has a higher priority than `https://`.

####  <a name="bkmk_QoS_UrlHost"></a> 2. URL host

 From the highest priority to the lowest, they are:

1. Hostname

2. IPv6 address

3. IPv4 address

4. Wildcard

In the case of hostname, a hostname with more dotted elements (more depth) has a higher priority than a hostname with fewer dotted elements. For example, among the following hostnames:

- video.internal.training.hr.mycompany.com (depth = 6)
  
- selfguide.training.mycompany.com (depth = 4)
  
- training (depth = 1)
  
- library (depth = 1)
  
  **video.internal.training.hr.mycompany.com** has the highest priority, and **selfguide.training.mycompany.com** has the next highest priority. **Training** and **library** share the same lowest priority.  
  
####  <a name="bkmk_QoS_UrlPort"></a> 3. URL port

A specific or an implicit port number has a higher priority than a wildcard port.

####  <a name="bkmk_QoS_UrlPath"></a> 4. URL path

Like a hostname, a URL path may consist of multiple elements. The one with more elements always has a higher priority than the one with less. For example, the following paths are listed by priority:  

1.  /ebooks/tech/windows/networking/qos

2.  /ebooks/tech/windows/

3.  /ebooks

4.  /

If a user chooses to include all subdirectories and files following a URL path, this URL path will have a lower priority than it would have if the choice were not made.

A user may also choose to specify a destination IP address in a URL-based policy. The destination IP address has a lower priority than any of the four URL fields described previously.
  
### Quintuple policy

A Quintuple policy is specified by protocol ID, source IP address, source port, destination IP address, and destination port. A Quintuple policy always has a higher precedence than any URL-based policy. 

If a Quintuple policy is already applied for a user, a new URL-based policy will not cause conflicts on any of that user's client computers.

For the next topic in this guide, see [Manage QoS Policy](qos-policy-manage.md).

For the first topic in this guide, see [Quality of Service (QoS) Policy](qos-policy-top.md).
