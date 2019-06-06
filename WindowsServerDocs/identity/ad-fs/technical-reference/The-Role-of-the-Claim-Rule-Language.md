---
title: The Role of the Claim Rule Language
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 07/07/2017
ms.topic: article
ms.prod: windows-server-threshold
ms.assetid: dda9d148-d72f-4bff-aa2a-f2249fa47e4c
ms.technology: identity-adfs
---


# The Role of the Claim Rule Language
The Active Directory Federation Services  (AD FS ) claim rule language acts as the administrative building block for the behavior of incoming and outgoing claims, while the claims engine acts as the processing engine for the logic in the claim rule language that defines the custom rule. For more information about how all rules are processed by the claims engine, see [The Role of the Claims Engine](The-Role-of-the-Claims-Engine.md).  

## Creating custom claim rules using the claim rule language  
AD FS provides administrators with the option to define custom rules that they can use to determine the behavior of identity claims with the claim rule language. You can use the claim rule language syntax examples in this topic to create a custom rule that enumerates, adds, deletes, and modifies claims to meet the needs of your organization. You can build custom rules by typing in the claim rule language syntax in the **Send Claims Using a Custom Claim** rule template.  

Rules are separated from each other with semicolons.  

For more information about when to use custom rules, see [When to Use a Custom Claim Rule](When-to-Use-a-Custom-Claim-Rule.md).  

## Using claim rule templates to learn about the claim rule language syntax  
AD FS also provides a set of predefined claim issuance and claim acceptance rule templates that you can use to implement common claim rules. In the **Edit Claim Rules** dialog box for a given trust, you can create a predefined rule—and view the claim rule language syntax that makes up that rule—by clicking the **View Rule Language** tab for that rule. Using the information in this section and the **View Rule Language** technique can provide insight into how to construct your own custom rules.  

For more detailed information about claim rules and claim rule templates, see [The Role of Claim Rules](The-Role-of-Claim-Rules.md).  

## Understanding the components of the claim rule language  
The claim rule language consists of the following components, separated by the “ =>” operator:  

-   A condition  

-   An issuance statement  

### Conditions  
You can use conditions in a rule to check input claims and determine whether the issuance statement of the rule should be executed. A condition represents a logical expression that must be evaluated to true to execute the rule body part. If this part is missing, a logical true is assumed; that is, the rule’s body is always executed. The conditions part contains a list of conditions that are combined together with the conjunction logical operator  (“&&” ). All conditions in the list must be evaluated to true for the whole conditional part to be evaluated to true. The condition can be either a claims selection operator or an aggregate function call. These two are mutually exclusive, which means that claim selectors and aggregate functions cannot be combined in a single rule conditions part.  

Conditions are optional in rules. For example, the following rule does not have a condition:  

```  
=> issue(type = "http://test/role", value = "employee");  
```  

There are three types of conditions:  

-   Single condition—This is the simplest form of a condition. Checks are made for only one expression; for example, windows account name  = domain  user.  

-   Multiple condition—This condition requires additional checks to process multiple expressions in the rule body; for example, windows account name  = domain  user and group  = contosopurchasers.  

> [!NOTE]  
> Another condition exists, but it is a subset of either the single condition or the multiple condition. It is referred to as a regular expression  (Regex ) condition. It is used to take an input expression and match the expression with a given pattern. An example of how it is can be used is shown below.  

The following examples show a few of the syntax constructions, which are based on the condition types, that you can use to create custom rules.  

#### Single -condition examples  
Single -expression conditions are described in the following table. They are constructed to simply check for a claim with a specified claim type or for a claim with a specified claim type and claim value.  


|                                                                                                                   Condition description                                                                                                                    |                           Condition syntax example                            |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------|
|               This rule has a condition to check for an input claim with a specified claim type  ("<http://test/name>" ). If a matching claim is in the input claims, the rule copies the matching claim or claims to the output claims set.               |         ``` c: [type == "http://test/name"] => issue(claim = c );```          |
| This rule has a condition to check for an input claim with a specified claim type  ("<http://test/name>" ) and claim value  (“Terry” ). If a matching claim is in the input claims, the rule copies the matching claim or claims to the output claims set. | ``` c: [type == "http://test/name", value == "Terry"] => issue(claim = c);``` |

More -complex conditions are shown in the next section, including conditions to check for multiple claims, conditions to check the issuer of a claim, and conditions to check for values that match a regular expression pattern.  

#### Multiple -condition examples  
The following table provides an example of multiple -expression conditions.  


|                                                                                                                   Condition description                                                                                                                    |                                        Condition syntax example                                        |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------|
| This rule has a condition to check for two input claims, each with a specified claim type  ("<http://test/name>" and "<http://test/email>" ). If the two matching claims are in the input claims, the rule copies the name claim to the output claims set. | ``` c1: [type  == "http://test/name"] && c2: [type == "http://test/email"] => issue (claim  = c1 );``` |

#### Regular -condition examples  
The following table provides an example of a regular, expression -based condition.  

|Condition description|Condition syntax example|  
|-------------------------|----------------------------|  
|This rule has a condition that uses a regular expression to check for an e -mail claim ending in “@fabrikam.com”. If a matching claim is found in the input claims, the rule copies the matching claim to the output claims set.|```c: [type  == "http://test/email", value  =~ "^. +@fabrikam.com$" ] => issue (claim  = c );```|  

### Issuance statements  
Custom rules are processed based on the issuance statements  (*issue* or *add* ) that you program into the claim rule. Depending on the desired outcome, either the issue statement or add statement can be written into the rule to populate the input claim set or the output claim set. A custom rule that uses the add statement explicitly populates claim values only to the input claim set while a custom claim rule that uses the issue statement populates claim values in both the input claim set and in the output claim set. This can be useful when a claim value is intended to be used only by future rules in the set of claim rules.  

For example, in the following illustration, the incoming claim is added to the input claim set by the claims issuance engine. When the first custom claim rule executes and the criteria of domain  user is satisfied, the claims issuance engine processes the logic in the rule using the add statement, and the value of **Editor** is added to the input claim set. Because the value of Editor is present in the input claim set, Rule 2 can successfully process the issue statement in its logic and generate a new value of **Hello**, which is added to both the output claim set and to the input claim set for use by the next rule in the rule set. Rule 3 can now use all of the values that are present in the input claim set as input for processing its logic.  

![AD FS roles](media/adfs2_customrule.gif)  

#### Claim issuance actions  
The rule body represents a claim issuance action. There are two claim issuance actions that the language recognizes:  

-   **Issue statement:** The issue statement creates a claim that goes to both input and output claim sets. For example, the following statement issues a new claim based on its input claim set:  

    ```c:[type == "Name"] => issue(type = "Greeting", value = "Hello " + c.value);```  

-   **Add statement:** The add statement creates a new claim that is added only to the input claim set collection. For example, the following statement adds a new claim to the input claim set:  

    ```c:[type == "Name", value == "domain user"] => add(type = "Role", value = "Editor");``` 

The issuance statement of a rule defines what claims will be issued by the rule when the conditions are matched. There are two forms of issuance statements regarding arguments and the statement behavior:  

-   **Normal**—Normal issuance statements can issue claims by using literal values in the rule or the values from claims that match the conditions. A normal issuance statement can consist of one or both of the following formats:  

    -   *Claim copy*: The claim copy creates a copy of the existing claim in the output claim set. This issuance form only makes sense when it is combined with the “issue” issuance statement. When it is combined with the “add” issuance statement, it does not have any effect.  

    -   *New claim*: This format creates a new claim, given the values for various claim properties. Claim.Type must be specified; all other claim properties are optional. The order of arguments for this form is ignored.  

-   **Attribute Store**—This form creates claims with values that are retrieved from an attribute store. It is possible to create multiple claim types by using a single issuance statement, which is important for attribute stores that make network or disk input/output  (I/O ) operations during the attribute retrieval. Therefore, it is desirable to limit the number of round trips between the policy engine and the attribute store. It is also legal to create multiple claims for a given claim type. When the attribute store returns multiple values for a given claim type, the issuance statement automatically creates a claim for each returned claim value. An attribute store implementation uses the param arguments to substitute the placeholders in the query argument with values that are provided in param arguments. The placeholders use the same syntax as the .NET String.Format ( ) function  (for example, {1}, {2}, and so on ). The order of the arguments for this form of issuance is important, and it must be the order which is prescribed in the following grammar.  

The following table describes some common syntax constructions for both types of issuance statements in claim rules.  

|Issuance statement type|Issuance statement description|Issuance statement syntax example|  
|---------------------------|----------------------------------|-------------------------------------|  
|Normal|The following rule always emits the same claim whenever a user has the specified claim type and value:|```c: [type  == "http://test/employee", value  == "true"] => issue (type = "http://test/role", value = "employee");```|  
|Normal|The following rule converts one claim type into another. Notice that the value of the claim that matches the condition "c" is used in the issuance statement.|```c: [type  == "http://test/group" ] => issue (type  = "http://test/role", value  = c.Value );```|  
|Attribute store|The following rule uses the value of an incoming claim to query the Active Directory attribute store:|```c: [Type  == "http://test/name" ] => issue (store  = "Enterprise AD Attribute Store", types  =  ("http://test/email" ), query  = ";mail;{0}", param  = c.Value )```|  
|Attribute store|The following rule uses the value of an incoming claim to query a previously configured Structured Query Language  (SQL ) attribute store:|```c: [type  == "http://test/name"] => issue (store  = "Custom SQL store", types  =  ("http://test/email","http://test/displayname" ), query  = "SELECT mail, displayname FROM users WHERE name ={0}", param  = c.value );```|  

#### Expressions  
Expressions are used on the right side for both claims selector constraints and issuance statement parameters. There are various kinds of expressions that the language supports. All expressions in the language are string based, which means that they take strings as input and produce strings. Numbers or other data types, such as date/time, in expressions are not supported. The following are the types of expressions that the language supports:  

-   String literal: String value, delimited by the quote  (“ ) character on both sides.  

-   String concatenation of expressions: The result is a string that is produced by concatenation of the left and right values.  

-   Function call: The function is identified by an identifier, and the parameters are passed as a comma -delimited list of expressions enclosed in brackets  (“ ( )” ).  

-   Claim’s property access in the form of a variable name DOT property name: The result of the value of the identified claim’s property for a given variable valuation. The variable must first be bound to a claims selector before it can be used in this way. It is illegal to use the variable that is bound to a claims selector inside the constraints for that same claims selector.  

The following claim properties are available for access:  

-   Claim.Type  

-   Claim.Value  

-   Claim.Issuer  

-   Claim.OriginalIssuer  

-   Claim.ValueType  

-   Claim.Properties\[property\_name\]  (This property returns an empty string if the property _name cannot be found in the claim’s properties collection. )  

You can use the RegexReplace function to call inside an expression. This function takes an input expression and matches it with the given pattern. If the pattern matches, the output of the match is replaced with the replacement value.  

#### Exists functions  
The Exists function can be used in a condition to evaluate whether a claim that matches the condition exists in the input claim set. If any matching claim exists, the issuance statement is called only once. In the following example, the “origin” claim is issued exactly once—if there is at least one claim in the input claim set collection that has the issuer set to “MSFT”, no matter how many claims have the issuer set to “MSFT”. Using this function prevents duplicate claims from being issued.  

```  
exists([issuer == "MSFT"])  
   => issue(type = "origin", value = "Microsoft");  
```  

## Rule body  
The rule body can contain only a single issuance statement. If conditions are used without using the Exists function, the rule body is executed once for each time that the conditions part is matched.  

## Additional references  
[Create a Rule to Send Claims Using a Custom Rule](https://technet.microsoft.com/library/dd807049.aspx)  


