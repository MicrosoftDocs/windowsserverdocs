---
title: Plan user accounts for your Windows MultiPoint Server 2012 environment
ms.custom: na
ms.prod: multipoint-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d47be540-e891-47bd-85da-6df4bbf93b2f
author: cfreemanwa
---
# Plan user accounts for your Windows MultiPoint Server 2012 environment
The best way to implement user accounts in [!INCLUDE[win8_server_multipoint_2](../Token/win8_server_multipoint_2_md.md)] depends on the size and complexity of your deployment:  
  
-   **Local user accounts** \- For a small deployment with only a few computers running [!INCLUDE[win8_server_multipoint_2](../Token/win8_server_multipoint_2_md.md)] and few users, you might find it most convenient to use *local user accounts* that are created on the MultiPoint Server computer. You can create an individual account for each person who will use the system, or create a generic account for each station, which anyone can use to log on. MultiPoint Server administrators create and manage local user accounts by using MultiPoint Manager. The local accounts can be administrators, have limited administrative rights, or be regular users with no access to the MultiPoint Server Desktop or MultiPoint Manager.  
  
-   **Domain accounts** \- If your environment has many computers running MultiPoint Server and many users, you probably will find it more useful to set up an Active Directory Domain Services \(AD DS\) domain and use *domain user accounts*, which enable a user to access her own user profile and settings from any station in the domain. Domain user accounts must be created on the domain controller by a domain administrator.  
  
> [!NOTE]  
> The following sections discuss scenarios that you might implement for local user accounts in [!INCLUDE[win8_server_multipoint_2](../Token/win8_server_multipoint_2_md.md)]. If you are using domain user accounts, see the “One or more MultiPoint Server computers in a domain network environment” scenario in [Example scenarios: Windows MultiPoint Server 2012 user accounts](../Topic/Example-scenarios--Windows-MultiPoint-Server-2012-user-accounts.md). For information about setting up domain user accounts in Active Directory Domain Services \(AD DS\), see [Create a New User Account](http://technet.microsoft.com/library/dd861308.aspx) \(http:\/\/technet.microsoft.com\/library\/dd861308.aspx\).  
  
## Planning local user accounts  
The following sections consider the advantages, disadvantages, and requirements for several ways to implement individual or shared local user accounts in your Windows MultiPoint Server 2012 environment.  
  
### Use individual local user accounts  
When creating local user accounts, you have the option of assigning each student to a particular computer running MultiPoint Server and creating a single account for each student. Alternatively, you might want to create an individual account for each student on every available computer running MultiPoint Server. A key advantage of implementing individual user accounts is that each user has his or her own Windows desktop experience that includes private folders for storing data. There are two approaches to creating individual local user accounts with MultiPoint Server: assign each user to a specific computer running MultiPoint Server, and then create an individual account for each user only on the computer to which they have been assigned; or, create local user accounts for all users on every computer running MultiPoint Server.  
  
From a system management perspective, assigning users to a specific MultiPoint Server computer might be more convenient. For example, if you have two computers running MultiPoint Server with five stations each, you might create local user accounts as illustrated in the following table.  
  
**Table 1: Assigning local user accounts to specific computers running MultiPoint Server**  
  
|Computer A|Computer B|  
|--------------|--------------|  
|UserAccount\_01|UserAccount\_06|  
|UserAccount\_02|UserAccount\_07|  
|UserAccount\_03|UserAccount\_08|  
|UserAccount\_04|UserAccount\_09|  
|UserAccount\_05|UserAccount\_10|  
  
In this scenario, each user has a single account on a particular computer. Therefore, everyone who has a local account on Computer A can log on to her or his account from any station associated with Computer A. However, these users cannot access their accounts if they use a station associated with Computer B, and vice versa. An advantage to this approach is that, by always connecting to the same computer, users can always find and access their files.  
  
In contrast, it is also possible to replicate individual user accounts on all computers running MultiPoint Server, as illustrated in the following table.  
  
**Table 2: Replicating user accounts on all computers running MultiPoint Server**  
  
|Computer A|Computer B|  
|--------------|--------------|  
|UserAccount\_01|UserAccount\_01|  
|UserAccount\_02|UserAccount\_02|  
|UserAccount\_03|UserAccount\_03|  
|UserAccount\_04|UserAccount\_04|  
|UserAccount\_05|UserAccount\_05|  
  
An advantage of this approach is that users have a local user account on every available computer running MultiPoint Server. However, the disadvantages might outweigh this advantage. For example, even if the user name and password for a particular person are the same on both computers, the accounts are not linked to each other. Therefore, if a user logs on to his or her account on Computer A on Monday, saves a file, and then logs on to his or her account on Computer B on Tuesday, he or she will not be able to access the file previously saved on Computer A. Additionally, replicating user accounts on multiple computers increases the administrative overhead and storage requirements.  
  
### Use generic local user accounts  
If your MultiPoint Server system is not connected to a domain, and you do not want to create an individual account for each user, you can create generic accounts for each station. For example, if you have two computers running MultiPoint Server, and five stations are associated with each computer, you might decide to create user accounts similar to those shown in the following table.  
  
**Table 3: Creating generic user accounts, one account per station**  
  
|Computer A|Computer B|  
|--------------|--------------|  
|Computer\_A\-Station\_01|Computer\_B\-Station\_01|  
|Computer\_A\-Station\_02|Computer\_B\-Station\_02|  
|Computer\_A\-Station\_03|Computer\_B\-Station\_03|  
|Computer\_A\-Station\_04|Computer\_B\-Station\_04|  
|Computer\_A\-Station\_05|Computer\_B\-Station\_05|  
  
In this scenario, every station account has the same password, and both the passwords and generic user account names are available to all users. An advantage to this approach is that the overhead of managing user accounts is likely to be less than if using individual accounts, because there typically are fewer stations than users. Additionally, the overhead caused by replicating user accounts on every server is eliminated.  
  
Another option is to create generic accounts on each server. Every user logs on to a server as the same account. To allow this, you must enable multiple sessions per account. You can further simplify by using the same account name and password on all servers. This simplifies logon for the users, who need only know one account name and password to use any station on any server. It should be noted that in this scenario all users can see any change that any user makes. For example, if a file is saved to the desktop, all users can see the file.  
  
> [!IMPORTANT]  
> It is important to understand that when users share a user account, either one per server or one per station, files saved on the server – even files saved in My Documents \- are not private. Any user who logs on with the account has access to those files. When you use one account per station, if a user saves files to My Documents on one station, the user does not have access to those files on a different station. The same occurs when logging on to different MultiPoint Server computers.  
  
To enable users to access their files from any station, you can use a file server, create a file share for each user account, or let users store their personal documents on a USB flash drive or other private storage device. Individual USB flash drives enable individual users to store private documents even if they are sharing a user account in MultiPoint Server.  
  
