---
title: Windows Server 2008: Domain-Wide Updates
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 053948a0-21ff-4638-ad68-85e20d001449
author: Femila
---
# Windows Server 2008: Domain-Wide Updates
  If all the operations in the following list succeed, the CN\=ActiveDirectoryUpdate,CN\=DomainUpdates,CN\=System,DC\=ForestRootDomain object is stamped as completed successfully by setting the revision attribute \(CN\=Revision in the schema, syntax Integer\) to 3.  
  
 For more information about previous changes to Adprep in Windows Server 2003 or Windows Server 2003 R2, see article 309628 in the Microsoft Knowledge Base \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=95287](http://go.microsoft.com/fwlink/?LinkId=95287)\).  
  
 For more information about how to interpret the access control entry \(ACE\) strings, see ACE strings \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=137238](http://go.microsoft.com/fwlink/?LinkId=137238)\).  
  
 For more information about how to interpret the security ID \(SID\) strings, see SID strings \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=137240](http://go.microsoft.com/fwlink/?LinkId=137240)\).  
  
 56.{dda1d01d\-4bd7\-4c49\-a1\-84\-46\-f9\-24\-1b\-56\-0e}  
  
1.  Operation: Add a set of ACEs to a specific object by using the object's distinguished name.  
  
2.  Add ACEs to CN\=BuiltIn  
  
3.  \(A;;RC;;;RU\)  
  
4.  \(A;;RPRC;;;RU\)  
  
5.  \(A;;LCRPLORC;;;ED\)  
  
6.  \(OA;;RP;c7407360\-20bf\-11d0\-a768\-00aa006e0529;;RU\)  
  
7.  \(OA;;RP;b8119fd0\-04f6\-4762\-ab7a\-4986c76b3f9a;;RU\)  
  
8.  \(OA;;RP;b8119fd0\-04f6\-4762\-ab7a\-4986c76b3f9a;;AU\)  
  
 57.{a1789bfb\-e0a2\-4739\-8c\-c0\-e7\-7d\-89\-2d\-08\-0a}  
  
1.  Operation: Add a set of ACEs to a specific object by using the object's distinguished name.  
  
2.  Add ACE to CN\=Domain System Volume \(SYSVOL share\),CN\=File Replication Service,CN\=System  
  
3.  \(OA;;CCDC;2a132586\-9373\-11d1\-aebc\-0000f80367c1;;ED\)  
  
 58.{61b34cb0\-55ee\-4be9\-b5\-95\-97\-81\-0b\-92\-b0\-17}  
  
1.  Operation: Add a set of ACEs to a specific object by using the object's distinguished name.  
  
2.  Add ACEs to the Domain directory partition  
  
3.  \(OA;CIIO;CRRPWP;91e647de\-d96f\-4b70\-9557\-d63ff4f3ccd8;;PS\)  
  
4.  \(OA;;CR;1131f6ae\-9c07\-11d1\-f79f\-00c04fc2dcd2;;BA\)  
  
5.  \(OA;;CR;1131f6ae\-9c07\-11d1\-f79f\-00c04fc2dcd2;;ED\)  
  
 59.{57428d75\-bef7\-43e1\-93\-8b\-2e\-74\-9f\-5a\-8d\-56}  
  
1.  Operation: Add a set of ACEs to a specific object by using the object's distinguished name.  
  
2.  Add ACE to CN\=AdminSDHolder,CN\=System  
  
3.  \(OA;CI;CRRPWP;91e647de\-d96f\-4b70\-9557\-d63ff4f3ccd8;;PS\)  
  
 61.{0b7fb422\-3609\-4587\-8c\-2e\-94\-b1\-0f\-67\-d1\-bf}  
  
1.  Operation: Add a set of ACEs to a specific object by using the object's distinguished name.  
  
2.  Add ACE to CN\=AdminSDHolder,CN\=System  
  
3.  \(OA;;WPRP;5805bc62\-bdc9\-4428\-a5e2\-856a0f4c185e;;S\-1\-5\-32\-561\)  
  
 64.{0x71482d49,0x8870,0x4cb3,0xa4,0x38,0xb6,0xfc,0x9e,0xc3,0x5d,0x70}  
  
1.  Operation : Create the following object :  
  
2.  CN\=Password Settings Container, CN\=System  
  
3.  O:DAG:DAD:\(A;;RPWPCRLCLOCCDCRCWDWOSW;;;DA\)\(A;;RPWPCRLCLOCCDCRCWDWOSDDTSW;;;SY\)  
  
4.  Attributes:  
  
     objectClass  
  
     msDS\-PasswordSettingsContainer  
  
 65.{0xaed72870,0xbf16,0x4788,0x8a,0xc7,0x22,0x29,0x9c,0x82,0x07,0xf1}  
  
1.  Operation: Add the following ACEs to the Domain directory partition  
  
2.  \(OA;;CR;89e95b76\-444d\-4c62\-991a\-0facbeda640c;;ED\)  
  
3.  \(OA;;CR;89e95b76\-444d\-4c62\-991a\-0facbeda640c;;BA\)  
  
 67.{f58300d1\-b71a\-4db6\-88\-a1\-a8\-b9\-53\-8b\-ea\-ca}  
  
1.  Operation: add ACEs to the following object: CN\=IP Security,CN\=System  
  
2.  Add \(A;CI;RPLCLORC;;;S\-1\-5\-20\)  
  
3.  Add \(A;CI;RPLCLORC;;;\<ERODC\-SID\>\)  
  
 68.{231fb90b\-c92a\-40c9\-93\-79\-ba\-cf\-c3\-13\-a3\-e3}  
  
1.  Operation: remove ACEs from the Domain directory partition head:  
  
2.  Remove \(OA;;CR;1131f6aa\-9c07\-11d1\-f79f\-00c04fc2dcd2;;S\-1\-5\-22\)  
  
3.  Remove \(OA;;CR;1131f6aa\-9c07\-11d1\-f79f\-00c04fc2dcd2;;\<ERODC\-SID\>\)  
  
 69.{4aaabc3a\-c416\-4b9c\-a6\-bb\-4b\-45\-3a\-b1\-c1\-f0};  
  
1.  Operation: Add an ACE to the Domain directory partition head:  
  
2.  Add \(A;;RPLCLO;;;\<ERODC\-SID\>\)  
  
 70.{9738c400\-7795\-4d6e\-b1\-9d\-c1\-6c\-d6\-48\-61\-66};  
  
1.  Operation: add an ACE to the object CN\=System  
  
2.  Add \(A;;RPLCLO;;; \<ERODC\-SID\>\)  
  
 71.{de10d491\-909f\-4fb0\-9a\-bb\-4b\-78\-65\-c0\-fe\-80};  
  
1.  Operation: add an ACE to the object CN\=Infrastructure  
  
2.  Add \(A;;RPLCLO;;; \<ERODC\-SID\>\)  
  
 72.{b96ed344\-545a\-4172\-aa\-0c\-68\-11\-82\-02\-f1\-25};  
  
1.  Operation: add an ACE to the object CN\=DomainUpdates,CN\=System  
  
2.  Add \(A;;RPLCLO;;; \<ERODC\-SID\>\)  
  
 73.{4c93ad42\-178a\-4275\-86\-00\-16\-81\-1d\-28\-f3\-aa};  
  
1.  Operation: add an ACE to the object OU\=Domain Controllers  
  
2.  Add \(A;;RPLCLO;;; \<ERODC\-SID\>\)  
  
 74.{c88227bc\-fcca\-4b58\-8d\-8a\-cd\-3d\-64\-52\-8a\-02};  
  
1.  Operation: add\/remove ACEs to the object CN\=AdminSDHolder,CN\=System  
  
2.  Add \(A;;RPLCLORC;;;AU\)  
  
3.  Remove \(A;;RC;;;AU\)  
  
4.  Remove \(OA;;RP;59ba2f42\-79a2\-11d0\-9020\-00c04fc2d3cf;;AU\)  
  
5.  Remove \(OA;;RP;77B5B886\-944A\-11d1\-AEBD\-0000F80367C1;;AU\)  
  
6.  Remove \(OA;;RP;E45795B3\-9455\-11d1\-AEBD\-0000F80367C1;;AU\)  
  
7.  Remove \(OA;;RP;e48d0154\-bcf8\-11d1\-8702\-00c04fb96050;;AU\)  
  
8.  Remove \(A;;RPLCLORC;;;PS\)  
  
9. Remove \(OA;;RP;037088f8\-0ae1\-11d2\-b422\-00a0c968f939;;RS\)  
  
10. Remove \(OA;;RP;4c164200\-20c0\-11d0\-a768\-00aa006e0529;;RS\)  
  
11. Remove \(OA;;RP;bc0ac240\-79a9\-11d0\-9020\-00c04fc2d4cf;;RS\)  
  
12. Remove \(OA;;RP;5f202010\-79a5\-11d0\-9020\-00c04fc2d4cf;;RS\)  
  
## Previous domain upgrade changes to Adprep that are now removed  
 The following domain upgrade operations were present in Beta and Release Candidate versions of Adprep for [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and then removed:  
  
 56.{ebad865a\-d649\-416f\-99\-22\-45\-6b\-53\-bb\-b5\-b8}  
  
1.  Operation: Add a set of ACEs to a specific object by using the object's distinguished name.  
  
2.  Add ACE to Domain directory partition  
  
3.  \(OA;;CR;1131f6aa\-9c07\-11d1\-f79f\-00c04fc2dcd2;;\<ERODC\-SID\>\)  
  
 62.{0x2951353e,0xd102,0x4ea5,0x90,0x6c,0x54,0x24,0x7e,0xee,0xc7,0x41}  
  
1.  Operation: Add a set of ACEs to the Domain directory partition  
  
2.  \(OA;;CR;1131f6aa\-9c07\-11d1\-f79f\-00c04fc2dcd2;;\<ERODC\-SID\>\)  
  
 66.{0x96e35a41,0x33cb,0x4b00,0x80,0x22,0x0f,0x1f,0x99,0xb0,0xe4,0xba}  
  
1.  Operation: Add\/Remove a set of ACEs to the following object by using the object's distinguished name.  
  
2.  Object affected: CN\=AdminSDHolder,CN\=System  
  
3.  Delete \(A;;RPLCLORC;;;AU\)  
  
4.  Add \(A;;RC;;;AU\)  
  
5.  Add \(OA;;RP;59ba2f42\-79a2\-11d0\-9020\-00c04fc2d3cf;;AU\)  
  
6.  Add \(OA;;RP;77B5B886\-944A\-11d1\-AEBD\-0000F80367C1;;AU\)  
  
7.  Add \(OA;;RP;E45795B3\-9455\-11d1\-AEBD\-0000F80367C1;;AU\)  
  
8.  Add \(OA;;RP;e48d0154\-bcf8\-11d1\-8702\-00c04fb96050;;AU\)  
  
9. Add \(A;;RPLCLORC;;;PS\)  
  
10. Add \(OA;;RP;037088f8\-0ae1\-11d2\-b422\-00a0c968f939;;RS\)  
  
11. Add \(OA;;RP;4c164200\-20c0\-11d0\-a768\-00aa006e0529;;RS\)  
  
12. Add \(OA;;RP;bc0ac240\-79a9\-11d0\-9020\-00c04fc2d4cf;;RS\)  
  
13. Add \(OA;;RP;5f202010\-79a5\-11d0\-9020\-00c04fc2d4cf;;RS\)  
  
## See Also  
 [Windows Server 2008: Appendix of Changes to Adprep.exe to Support AD DS](../Topic/Windows-Server-2008--Appendix-of-Changes-to-Adprep.exe-to-Support-AD-DS.md)  
  
  