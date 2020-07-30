---
title: Remote Access Always On VPN migration planning
description: Migrating from DirectAccess to Always On VPN requires proper planning to determine your migration phases, which helps identify any issues before they affect the entire organization. 
manager: dougkim
ms.prod: windows-server
ms.technology: networking-ras
ms.topic: article
ms.assetid: eeca4cf7-90f0-485d-843c-76c5885c54b0
ms.author: lizross
author: eross-msft
ms.date: 05/29/2018
---

# Plan the DirectAccess to Always On VPN migration

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows 10

&#171; [**Previous:** Overview of the DirectAccess to Always On VPN migration](da-always-on-migration-overview.md)<br>
&#187; [**Next:** Migrate to Always On VPN and decommission DirectAccess](da-always-on-migration-deploy.md)


Migrating from DirectAccess to Always On VPN requires proper planning to determine your migration phases, which helps identify any issues before they affect the entire organization. The primary goal of the migration is for users to maintain remote connectivity to the office throughout the process. If you perform tasks out of order, a race condition may occur, leaving remote users with no way to access company resources. Therefore, Microsoft recommends performing a planned, side-by-side migration from DirectAccess to Always On VPN. For details, see the [Always On VPN migration deployment](da-always-on-migration-deploy.md) section.

The section describes the benefits of separating users for the migration, standard configuration considerations, and Always On VPN feature enhancements. The migration planning phase includes:

1.  [!INCLUDE [build-migration-rings-shortdesc-include](../includes/build-migration-rings-shortdesc-include.md)]

2.  [!INCLUDE [review-feature-mapping-shortdesc-include](../includes/review-feature-mapping-shortdesc-include.md)] 

3.  [!INCLUDE [review-the-enhancements-shortdesc-include](../includes/review-the-enhancements-shortdesc-include.md)] 

4.  [!INCLUDE [review-the-technology-overview-shortdesc-include](../includes/review-the-technology-overview-shortdesc-include.md)]

## Build migration rings
Migration rings are used to divide the Always On VPN client migration effort into multiple phases. By the time you get to the last phase, your process should be well tested and consistent.

This section provides one approach for separating users into migration phases, and then managing those phases. Regardless of the user phase separation method you choose, maintain a single VPN Users group for easier management when the migration is complete.

>[!NOTE] 
>The word _phase_ is not intended to indicate that this is a long process. Whether you move through each phase in a couple of days or a couple of months, Microsoft recommends that you take advantage of side-by-side migration and use a phased approach.

### Benefits of dividing the migration effort into multiple phases

-   **Mass outage protection.** By dividing a migration into phases, the number of people a migration-generated issue can affect is much smaller.

-   **Improvement in process or communication from feedback.** Ideally, users did not even notice that the migration occurred. However, if their experience was less than optimal, feedback from those uses gives you an opportunity to improve your planning and avoid issues in the future.

### Tips for building your migration ring

-   **Identify remote users.** Start by separating users into two buckets: those who frequently come into the office and those who do not. The migration process is the same for both groups, but it is likely to take longer for the remote clients to receive the update than for those who connect more frequently. Each migration phase, ideally, should include members from each bucket.

-  **Prioritize users.** Leadership and other high-impact users are typically among the last users migrated. When prioritizing users, however, consider their business productivity impact if migration of their client computer were to fail. For example, if you had a rating of 1 to 3, with 1 meaning that the employee would not be able to work and 3 meaning no immediate work interruption, a business analyst using only internal line-of-business (LOB) apps remotely would be a 1, whereas a salesperson using a cloud app would be a 3.

-   **Migrate each department or business unit in multiple phases.** Microsoft strongly recommends that you do not migrate an entire department at the same time. If an issue should arise, you do not want it to hinder remote work for the whole department. Instead, migrate each department or business unit in at least two phases.

-   **Gradually increase user counts.** Most typical migration scenarios start with members of the IT organization and then move to business users followed by leadership and other high-impact users. Each migration phase typically involves progressively more people. For example, the first phase may include ten users, and the final group may include 5,000 users. To simplify the deployment, create a single VPN Users security group, and add users to it as their phase arrives. In this way, you end up with a single VPN Users group to which you can add members in the future.

[!INCLUDE [always-on-vpn-standard-config-considerations-include](../includes/always-on-vpn-standard-config-considerations-include.md)]


## Next step

|If you want to...  |Then see...  |
|---------|---------|
|Start migrating to Always On VPN     |[Migrate to Always On VPN and decommission DirectAccess](da-always-on-migration-deploy.md). Migrating from DirectAccess to Always On VPN requires a specific process to migrate clients, which helps minimize race conditions that arise from performing migration steps out of order.         |
|Learn about the features of both Always On VPN and DirectAccess    |[Feature Comparison of Always On VPN and DirectAccess](../vpn/vpn-map-da.md). In previous versions of the Windows VPN architecture, platform limitations made it difficult to provide the critical functionality needed to replace DirectAccess (like automatic connections initiated before users sign in). Always On VPN, however, has mitigated most of those limitations or expanded the VPN functionality beyond the capabilities of DirectAccess.         |



---