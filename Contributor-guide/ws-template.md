---
# required metadata
title: [ARTICLE TITLE]
description:
author: [GITHUB USERNAME]
ms.author: [MICROSOFT ALIAS]
ms.date: [DATE]
ms.topic: article
ms.prod: windows-server-threshold
ms.technology:
ms.localizationpriority: [high/medium/low]
---

# Metadata and Markdown Template

This OPS template contains examples of Markdown syntax, as well as guidance on setting the metadata. To get the most of it, you must view both the [raw Markdown](https://raw.githubusercontent.com/Microsoft/WindowsServerDocs-pr/master/Contributor-guide/ws-template.md?token=AG1vEhARRHNLtPgKXP35BGjNZGajKOArks5YLNIwwA%3D%3D) and the [rendered view](https://github.com/Microsoft/WindowsServerDocs-pr/blob/master/Contributor-guide/ws-template.md). (The raw Markdown shows the metadata block, while the rendered view does not.)

When creating a Markdown file, you should copy this template to a new file, fill out the metadata as specified below, set the H1 heading above to the title of the article, and delete the content. Anything in CAPS in square brackets requires your attention.


## Metadata 

The full metadata block is above. Some key notes:

- You **must** have a space between the colon (:) and the value for a metadata element.
- Colons in a value (for example, a title) break the metadata parser. In their place, use the HTML encoding for a colon of `&#58;` (for example, `"title: Azure Rights Management&#58; the basics | Azure RMS"`).
- **title**: This title will appear in search engine results. 
- **author**: The author field should contain the **GitHub username** of the author, not their alias.
- **ms.prod**, **ms.technology**: Use "windows-server-threshold" for ms.prod (or w10 if you're using this template to create content for Windows 10). Talk to your CX contact to get the ms.technology value.

## Basic Markdown, GFM, and special characters

All basic and GitHub-flavored Markdown is supported. For more information on these, see:

- [Baseline Markdown syntax](https://daringfireball.net/projects/markdown/syntax)
- [GitHub-flavored Markdown (GFM) documentation](https://guides.github.com/features/mastering-markdown)

Markdown uses special characters such as \*, \`, and \# for formatting. If you wish to include one of these characters in your content, you must do one of two things:

- Put a backslash before the special character to "escape" it (for example, \\\* for a \*)
- Use the [HTML entity code](http://www.ascii.cl/htmlcodes.htm) for the character (for example, \&\#42\; for a &#42;).

## Headings

Headings should be done using atx-style, that is, use 1-6 hash characters (#) at the start of the line to indicate a heading, corresponding to HTML headings levels H1 through H6. Examples of first- and second-level headers are used above. 

There **must** be only one first-level heading (H1) in your topic, which will be displayed as the on-page title.  

Second-level headings will generate the on-page TOC that appears in the "In this article" section underneath the on-page title.

### Third-level heading
#### Fourth-level heading
##### Fifth level heading
###### Sixth-level heading

## Text styling

*Italics* 

**Bold** 

~~Strikethrough~~

## Links

### Internal Links

To link to a header in the same Markdown file, view the source of the published article, find the ID of the head (for example, `id="blockquote"`), and link using # + id (for example, `#blockquote`).

- Example: [Blockquotes](#blockquote)

To link to a Markdown file in the same repo, use [relative links](https://www.w3.org/TR/WD-html40-970917/htmlweb.html#h-5.1.2), including the ".md" at the end of the filename.

- Example: [Tips and gotchas](tips-gotchas.md)
- Example: [Tools and setup for contributors](../readme.md)

To link to a header in a Markdown file in the same repo, use relative linking + hashtag linking.

- Example: [Deleting files](tips-gotchas.md#deleting-files)

### External Links

To link to an external file, use the full URL as the link.

- Example: [GitHub](http://www.github.com)

If a URL appears in a Markdown file, it will be transformed into a clickable link.

- Example: http://www.github.com

## Lists

### Ordered lists

1. This 
1. Is
1. An
1. Ordered
1. List  


#### Ordered list with an embedded list

1. Here
1. comes
1. an
1. embedded
    1. Miss Scarlett
    1. Professor Plum
1. ordered
1. list


### Unordered Lists

- This
- is
- a
- bulleted
- list


##### Unordered list with an embedded list

- This 
- bulleted 
- list
    - Mrs. Peacock
    - Mr. Green
- contains  
- other
    1. Colonel Mustard
    1. Mrs. White
- lists


## Horizontal rule

---

## Tables

In almost every instance, use MD formatting for tables. While HTML tables provide more flexibility we DO NOT use them in our content. If you have an HTML table in your article, we will not merge that article.

| Tables        | Are           | Cool  |
| ------------- |:-------------:| -----:|
| col 3 is      | right-aligned | $1600 |
| col 2 is      | centered      |   $12 |
| col 1 is default | left-aligned     |    $1 |


## Code

### Generic codeblock

Indent code four spaces for generic codeblock coding.

    function fancyAlert(arg) {
      if(arg) {
        $.docs({div:'#foo'})
      }
    }


### Codeblocks with language identifier

Use three backticks (&#96;&#96;&#96;) + a language ID to apply language-specific color coding to a code block.  Here is the entire list of [GitHub Flavored Markdown (GFM) language IDs](https://github.com/jmm/gfm-lang-ids/wiki/GitHub-Flavored-Markdown-(GFM)-language-IDs).

##### C&#9839;

```c#
using System;
namespace HelloWorld
{
    class Hello 
    {
        static void Main() 
        {
            Console.WriteLine("Hello World!");

            // Keep the console window open in debug mode.
            Console.WriteLine("Press any key to exit.");
            Console.ReadKey();
        }
    }
}
```
#### Python

```python
friends = ['john', 'pat', 'gary', 'michael']
for i, name in enumerate(friends):
    print "iteration {iteration} is {name}".format(iteration=i, name=name)
```
#### PowerShell

```powershell
Clear-Host
$Directory = "C:\Windows\"
$Files = Get-Childitem $Directory -recurse -Include *.log `
-ErrorAction SilentlyContinue
```

### Inline code

Use backticks (&#96;) for `inline code`.

## Blockquotes

> The drought had lasted now for ten million years, and the reign of the terrible lizards had long since ended. Here on the Equator, in the continent which would one day be known as Africa, the battle for existence had reached a new climax of ferocity, and the victor was not yet in sight. In this barren and desiccated land, only the small or the swift or the fierce could flourish, or even hope to survive.

## Images

### Static Image

![this is the alt text](../windowsserverdocs/get-started/media/wsbanner.png)

### Linked Image

[![alt text for linked image](../windowsserverdocs/get-started/nano.png)](../windowsserverdocs/get-started/getting-started-with-nano-server.md) 

## Alerts

### Note

> [!NOTE]
> This is NOTE

### Warning

> [!WARNING]
> This is WARNING

### Tip

> [!TIP]
> This is TIP

### Important

> [!IMPORTANT]
> This is IMPORTANT

