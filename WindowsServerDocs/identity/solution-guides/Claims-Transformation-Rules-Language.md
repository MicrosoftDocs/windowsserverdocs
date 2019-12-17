---
ms.assetid: e831f781-3c45-4d44-b411-160d121d1324
title: Claims Transformation Rules Language
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Claims Transformation Rules Language

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The across-forest claims transformation feature enables you to bridge claims for Dynamic Access Control across forest boundaries by setting claims transformation policies on across-forest trusts. The primary component of all policies is rules that are written in claims transformation rules language. This topic provides details about this language and provides guidance about authoring claims transformation rules.  
  
The Windows PowerShell cmdlets for transformation policies on across-forest trusts have options to set simple policies that are required in common scenarios. These cmdlets translate the user input into policies and rules in the claims transformation rules language, and then store them in Active Directory in the prescribed format. For more information about cmdlets for claims transformation, see the [AD DS Cmdlets for Dynamic Access Control](https://go.microsoft.com/fwlink/?LinkId=243150).  
  
Depending on the claims configuration and the requirements placed on the across-forest trust in your Active Directory forests, your claims transformation policies may have to be more complex than the policies supported by the Windows PowerShell cmdlets for Active Directory. To effectively author such policies, it is essential to understand the claims transformation rules language syntax and semantics. This claims transformation rules language ("the language") in Active Directory is a subset of the language that is used by [Active Directory Federation Services](https://go.microsoft.com/fwlink/?LinkId=243982) for similar purposes, and it has a very similar syntax and semantics. However, there are fewer operations allowed, and additional syntax restrictions are placed in the Active Directory version of the language.  
  
This topic briefly explains the syntax and semantics of the claims transformation rules language in Active Directory and considerations to be made when authoring policies. It provides several sets of example rules to get you started, and examples of incorrect syntax and the messages they generate, to help you decipher error messages when you author the rules.  
  
## Tools for authoring claims transformation policies  
**Windows PowerShell cmdlets for Active Directory**: This is the preferred and recommended way to author and set claims transformation policies. These cmdlets provide switches for simple policies and verify rules that are set for more complex policies.  
  
**LDAP**: Claims transformation policies can be edited in Active Directory through Lightweight Directory Access Protocol (LDAP). However, this is not recommended because the policies have several complex components, and the tools you use may not validate the policy before writing it to Active Directory. This may subsequently require a considerable amount of time to diagnose problems.  
  
## Active Directory claims transformation rules language  
  
### Syntax overview  
Here is a brief overview of the syntax and semantics of the language:  
  
-   The claims transformation rule set consists of zero or more rules. Each rule has two active parts: **Select Condition List** and **Rule Action**. If the **Select Condition List** evaluates to TRUE, the corresponding rule action is executed.  
  
-   **Select Condition List** has zero or more **Select Conditions**. All of the **Select Conditions** must evaluate to TRUE for the **Select Condition List** to evaluate to TRUE.  
  
-   Each **Select Condition** has a set of zero or more **Matching Conditions**. All the **Matching Conditions** must evaluate to TRUE for the Select Condition to evaluate to TRUE. All of these conditions are evaluated against a single claim. A claim that matches a **Select Condition** can be tagged by an **Identifier** and referred to in the **Rule Action**.  
  
-   Each **Matching Condition** specifies the condition to match the **Type** or **Value** or **ValueType** of a claim by using different **Condition Operators** and **String Literals**.  
  
    -   When you specify a **Matching Condition** for a **Value**, you must also specify a **Matching Condition** for a specific **ValueType** and vice versa. These conditions must be next to each other in the syntax.  
  
    -   **ValueType** matching conditions must use specific **ValueType** literals only.  
  
-   A **Rule Action** can copy one claim that is tagged with an **Identifier** or issue one claim based on a claim that is tagged with an Identifier and/or given String Literals.  
  
**Example rule**  
  
This example shows a rule that can be used to translate the claims Type between two forests, provided that they use the same claims ValueTypes and have the same interpretations for claims Values for this type. The rule has one matching condition and an Issue statement that uses String Literals and a matching claims reference.  
  
```  
C1: [TYPE=="EmployeeType"]    
                 => ISSUE (TYPE= "EmpType", VALUE = C1.VALUE, VALUETYPE = C1.VALUETYPE);  
[TYPE=="EmployeeType"] == Select Condition List with one Matching Condition for claims Type.  
ISSUE (TYPE= "EmpType", VALUE = C1.VALUE, VALUETYPE = C1.VALUETYPE) == Rule Action that issues a claims using string literal and matching claim referred with the Identifier.  
  
```  
  
### Runtime operation  
It is important to understand the runtime operation of claims transformations to author the rules effectively. The runtime operation uses three sets of claims:  
  
1.  **Input claims set**: The input set of claims that are given to the claims transformation operation.  
  
2.  **Working claims set**: Intermediate claims that are read from and written to during the claims transformation.  
  
3.  **Output claims set**: Output of the claims transformation operation.  
  
Here is a brief overview of the runtime claims transformation operation:  
  
1.  Input claims for claims transformation are used to initialize the working claims set.  
  
    1.  When processing each rule, the working claims set is used for the input claims.  
  
    2.  The Selection Condition List in a rule is matched against all possible sets of claims from the working claims set.  
  
    3.  Each set of matching claims is used to run the action in that rule.  
  
    4.  Running a rule action results in one claim, which is appended to the output claims set and the working claims set. Thus, the output from a rule is used as input for subsequent rules in the rule set.  
  
2.  The rules in the rule set are processed in sequential order starting with the first rule.  
  
3.  When the entire rule set is processed, the output claims set is processed to remove duplicate claims and for other security issues.The resulting claims are the output of the claims transformation process.  
  
It is possible to write complex claims transformations based on the previous runtime behavior.  
  
**Example: Runtime operation**  
  
This example shows the runtime operation of a claims transformation that uses two rules.  
  
```  
  
     C1:[Type=="EmpType", Value=="FullTime",ValueType=="string"] =>  
                Issue(Type=="EmployeeType", Value=="FullTime",ValueType=="string");  
     [Type=="EmployeeType"] =>   
               Issue(Type=="AccessType", Value=="Privileged", ValueType=="string");  
Input claims and Initial Evaluation Context:  
  {(Type= "EmpType"),(Value="FullTime"),(ValueType="String")}  
{(Type= "Organization"),(Value="Marketing"),(ValueType="String")}  
After Processing Rule 1:  
 Evaluation Context:  
  {(Type= "EmpType"),(Value="FullTime"),(ValueType="String")}  
{(Type= "Organization"), (Value="Marketing"),(ValueType="String")}  
  {(Type= "EmployeeType"),(Value="FullTime"),(ValueType="String")}  
Output Context:  
  {(Type= "EmployeeType"),(Value="FullTime"),(ValueType="String")}  
  
After Processing Rule 2:  
Evaluation Context:  
  {(Type= "EmpType"),(Value="FullTime"),(ValueType="String")}  
{(Type= "Organization"),(Value="Marketing"),(ValueType="String")}  
  {(Type= "EmployeeType"),(Value="FullTime"),(ValueType="String")}  
  {(Type= "AccessType"),(Value="Privileged"),(ValueType="String")}  
Output Context:  
  {(Type= "EmployeeType"),(Value="FullTime"),(ValueType="String")}  
  {(Type= "AccessType"),(Value="Privileged"),(ValueType="String")}  
  
Final Output:  
  {(Type= "EmployeeType"),(Value="FullTime"),(ValueType="String")}  
  {(Type= "AccessType"),(Value="Privileged"),(ValueType="String")}  
  
```  
  
### Special rules semantics  
The following are special syntax for rules:  
  
1.  Empty Rule Set == No Output Claims  
  
2.  Empty Select Condition List == Every Claim matches the Select Condition List  
  
    **Example: Empty Select Condition List**  
  
    The following rule matches every claim in the working set.  
  
    ```  
    => Issue (Type = "UserType", Value = "External", ValueType = "string")  
    ```  
  
3.  Empty Select Matching List == Every claim matches the Select Condition List  
  
    **Example: Empty Matching Conditions**  
  
    The following rule matches every claim in the working set. This is the basic "Allow-all" rule if it is used alone.  
  
    ```  
    C1:[] => Issule (claim = C1);  
    ```  
  
## Security considerations  
**Claims that enter a forest**  
  
The claims presented by principals that are incoming to a forest need to be inspected thoroughly to ensure that we allow or issue only the correct claims. Improper claims can compromise the forest security, and this should be a top consideration when authoring transformation policies for claims that enter a forest.  
  
Active Directory has the following features to prevent misconfiguration of claims that enter a forest:  
  
-   If a forest trust has no claims transformation policy set for the claims that enter a forest, for security purposes, Active Directory drops all the principal claims that enter the forest.  
  
-   If running the rule set on claims that enters a forest results in claims that are not defined in the forest, the undefined claims are dropped from the output claims.  
  
**Claims that leave a forest**  
  
Claims that leave a forest present a lesser security concern for the forest than the claims that enter the forest. Claims are allowed to leave the forest as-is even when there is no corresponding claims transformation policy in place. It is also possible to issue claims that are not defined in the forest as part of transforming claims that leave the forest. This is to easily set up across-forest trusts with claims. An administrator can determine if claims that enter the forest need to be transformed, and set up the appropriate policy. For example, an administrator could set a policy if there is a need to hide a claim to prevent information disclosure.  
  
**Syntax errors in claims transformation rules**  
  
If a given claims transformation policy has a rules set that is syntactically incorrect or if there are other syntax or storage issues, the policy is considered invalid. This is treated differently than the default conditions mentioned earlier.  
  
Active Directory is unable to determine the intent in this case and goes into a fail-safe mode, where no output claims are generated on that trust+direction of traversal. Administrator intervention is required to correct the issue. This could happen if LDAP is used to edit the claims transformation policy. Windows PowerShell cmdlets for Active Directory have validation in place to prevent writing a policy with syntax issues.  
  
## Other language considerations  
  
1.  There are several key words or characters that are special in this language (referred to as terminals). These are presented in the [Language terminals](Claims-Transformation-Rules-Language.md#BKMK_LT) table later in this topic. The error messages use the tags for these terminals for disambiguation.  
  
2.  Terminals can sometimes be used as string literals. However, such usage may conflict with the language definition or have unintended consequences. This kind of usage is not recommended.  
  
3.  The rule action cannot perform any type conversions on claim Values, and a rule set that contains such a rule action is considered invalid. This would cause a runtime error, and no output claims are produced.  
  
4.  If a rule action refers to an Identifier that was not used in the Select Condition List portion of the rule, it is an invalid usage. This would cause a syntax error.  
  
    **Example: Incorrect Identifier reference**  
    The following rule illustrates an incorrect Identifier used in rule action.  
  
    ```  
    C1:[] => Issue (claim = C2);  
    ```  
  
## Sample transformation rules  
  
-   **Allow all claims of a certain type**  
  
    Exact type  
  
    ```  
    C1:[type=="XYZ"] => Issue (claim = C1);  
    ```  
  
    Using Regex  
  
    ```  
    C1: [type =~ "XYZ*"] => Issue (claim = C1);  
    ```  
  
-   **Disallow a certain claim type**  
    Exact type  
  
    ```  
    C1:[type != "XYZ"] => Issue (claim=C1);  
    ```  
  
    Using Regex  
  
    ```  
    C1:[Type !~ "XYZ?"] => Issue (claim=C1);  
    ```  
  
## Examples of rules parser errors  
Claims transformation rules are parsed by a custom parser to check for syntax errors. This parser is run by related Windows PowerShell cmdlets before storing rules in Active Directory. Any errors in parsing the rules, including syntax errors, are printed on the console. Domain controllers also run the parser before using the rules for transforming claims, and they log errors in the event log (add event log numbers).  
  
This section illustrates some examples of rules that are written with incorrect syntax and the corresponding syntax errors that are generated by the parser.  
  
1. Example:  
  
   ```  
   c1;[]=>Issue(claim=c1);  
   ```  
  
   This example has an incorrectly used semicolon in place of a colon.   
   **Error message:**  
   *POLICY0002: Could not parse policy data.*  
   *Line number: 1, Column number: 2, Error token: ;. Line: 'c1;[]=>Issue(claim=c1);'.*  
   *Parser error: 'POLICY0030: Syntax error, unexpected ';', expecting one of the following: ':' .'*  
  
2. Example:  
  
   ```  
   c1:[]=>Issue(claim=c2);  
   ```  
  
   In this example, the Identifier tag in the copy issuance statement is undefined.   
   **Error message**:   
   *POLICY0011: No conditions in the claim rule match the condition tag specified in the CopyIssuanceStatement: 'c2'.*  
  
3. Example:  
  
   ```  
   c1:[type=="x1", value=="1", valuetype=="bool"]=>Issue(claim=c1)  
   ```  
  
   "bool" is not a Terminal in the language, and it is not a valid ValueType. Valid terminals are listed in the following error message.   
   **Error message:**  
   *POLICY0002: Could not parse policy data.*  
   Line number: 1, Column number: 39, Error token: "bool". Line: 'c1:[type=="x1", value=="1",valuetype=="bool"]=>Issue(claim=c1);'.   
   *Parser error: 'POLICY0030: Syntax error, unexpected 'STRING', expecting one of the following: 'INT64_TYPE' 'UINT64_TYPE' 'STRING_TYPE' 'BOOLEAN_TYPE' 'IDENTIFIER'*  
  
4. Example:  
  
   ```  
   c1:[type=="x1", value==1, valuetype=="boolean"]=>Issue(claim=c1);  
   ```  
  
   The numeral **1** in this example is not a valid token in the language, and such usage is not allowed in a matching condition. It has to be enclosed in double quotes to make it a string.   
   **Error message:**  
   *POLICY0002: Could not parse policy data.*  
   *Line number: 1, Column number: 23, Error token: 1. Line: 'c1:[type=="x1", value==1, valuetype=="bool"]=>Issue(claim=c1);'.*<em>Parser error: 'POLICY0029: Unexpected input.</em>  
  
5. Example:  
  
   ```  
   c1:[type == "x1", value == "1", valuetype == "boolean"] =>   
  
        Issue(type = c1.type, value="0", valuetype == "boolean");  
   ```  
  
   This example used a double equal sign (==) instead of a single equal sign (=).   
   **Error message:**  
   *POLICY0002: Could not parse policy data.*  
   *Line number: 1, Column number: 91, Error token: ==. Line: 'c1:[type=="x1", value=="1",*  
   *valuetype=="boolean"]=>Issue(type=c1.type, value="0", valuetype=="boolean");'.*  
   *Parser error: 'POLICY0030: Syntax error, unexpected '==', expecting one of the following: '='*  
  
6. Example:  
  
   ```  
   c1:[type=="x1", value=="boolean", valuetype=="string"] =>   
  
         Issue(type=c1.type, value=c1.value, valuetype = "string");  
   ```  
  
   This example is syntactically and semantically correct. However, using "boolean" as a string value is bound to cause confusion, and it should be avoided. As previously mentioned, using language terminals as claims values should be avoided where possible.  
  
## <a name="BKMK_LT"></a>Language terminals  
The following table lists the complete set of terminal strings and the associated language terminals that are used in the claims transformation rules language. These definitions use case-insensitive UTF-16 strings.  
  
|String|Terminal|  
|----------|------------|  
|"=>"|IMPLY|  
|";"|SEMICOLON|  
|":"|COLON|  
|","|COMMA|  
|"."|DOT|  
|"["|O_SQ_BRACKET|  
|"]"|C_SQ_BRACKET|  
|"("|O_BRACKET|  
|")"|C_BRACKET|  
|"=="|EQ|  
|"!="|NEQ|  
|"=~"|REGEXP_MATCH|  
|"!~"|REGEXP_NOT_MATCH|  
|"="|ASSIGN|  
|"&&"|AND|  
|"issue"|ISSUE|  
|"type"|TYPE|  
|"value"|VALUE|  
|"valuetype"|VALUE_TYPE|  
|"claim"|CLAIM|  
|"[_A-Za-z][_A-Za-z0-9]*"|IDENTIFIER|  
|"\\"[^\\"\n]*\\""|STRING|  
|"uint64"|UINT64_TYPE|  
|"int64"|INT64_TYPE|  
|"string"|STRING_TYPE|  
|"boolean"|BOOLEAN_TYPE|  
  
## Language syntax  
The following claims transformation rules language is specified in ABNF form. This definition uses the terminals that are specified in the previous table in addition to the ABNF productions defined here. The rules must be encoded in UTF-16, and the string comparisons must be treated as case insensitive.  
  
```  
Rule_set        = ;/*Empty*/  
             / Rules  
Rules         = Rule  
             / Rule Rules  
Rule          = Rule_body  
Rule_body       = (Conditions IMPLY Rule_action SEMICOLON)  
Conditions       = ;/*Empty*/  
             / Sel_condition_list  
Sel_condition_list   = Sel_condition  
             / (Sel_condition_list AND Sel_condition)  
Sel_condition     = Sel_condition_body  
             / (IDENTIFIER COLON Sel_condition_body)  
Sel_condition_body   = O_SQ_BRACKET Opt_cond_list C_SQ_BRACKET  
Opt_cond_list     = /*Empty*/  
             / Cond_list  
Cond_list       = Cond  
             / (Cond_list COMMA Cond)  
Cond          = Value_cond  
             / Type_cond  
Type_cond       = TYPE Cond_oper Literal_expr  
Value_cond       = (Val_cond COMMA Val_type_cond)  
             /(Val_type_cond COMMA Val_cond)  
Val_cond        = VALUE Cond_oper Literal_expr  
Val_type_cond     = VALUE_TYPE Cond_oper Value_type_literal  
claim_prop       = TYPE  
             / VALUE  
Cond_oper       = EQ  
             / NEQ  
             / REGEXP_MATCH  
             / REGEXP_NOT_MATCH  
Literal_expr      = Literal  
             / Value_type_literal  
  
Expr          = Literal  
             / Value_type_expr  
             / (IDENTIFIER DOT claim_prop)  
Value_type_expr    = Value_type_literal  
             /(IDENTIFIER DOT VALUE_TYPE)  
Value_type_literal   = INT64_TYPE  
             / UINT64_TYPE  
             / STRING_TYPE  
             / BOOLEAN_TYPE  
Literal        = STRING  
Rule_action      = ISSUE O_BRACKET Issue_params C_BRACKET  
Issue_params      = claim_copy  
             / claim_new  
claim_copy       = CLAIM ASSIGN IDENTIFIER  
claim_new       = claim_prop_assign_list  
claim_prop_assign_list = (claim_value_assign COMMA claim_type_assign)  
             /(claim_type_assign COMMA claim_value_assign)  
claim_value_assign   = (claim_val_assign COMMA claim_val_type_assign)  
             /(claim_val_type_assign COMMA claim_val_assign)  
claim_val_assign    = VALUE ASSIGN Expr  
claim_val_type_assign = VALUE_TYPE ASSIGN Value_type_expr  
Claim_type_assign   = TYPE ASSIGN Expr  
  
```  
  


