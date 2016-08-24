<properties title="" pageTitle="File names and locations for Windows Server 2016 technical articles" description="Explains the file structure for articles and the naming conventions you should follow when you create a new article." metaKeywords="" services="" solutions="" documentationCenter="" authors="Kathy-Davies" videoId="" scriptId="" manager="required" />

<tags ms.service="contributor-guide" ms.devlang="" ms.topic="article" ms.tgt_pltfrm="" ms.workload="" ms.date="03/14/2016" ms.author="jimpark; tysonn" />

#File names and locations for Windows Server technical articles

Knowing and following the rules helps you get your pull request accepted faster.

+ [Rules]
+ [Pattern]
+ [File name approval]

##Rules

- All files must be in markdown and use the .md file extension.
- Use sentence case and only letters, numbers, and hyphens. [Sentence case](http://grammar.about.com/od/rs/g/Sentence-Case.htm) means capitalize the first word and proper nouns only. Trademarked names such as Windows are proper nouns, but features generally aren't.
- No spaces or punctuation characters. Use a hyphen to separate words and numbers in the file name.
- No more than 80 characters - this is a publishing system limit.
- Use the short form of action verbs, not the '-ing' form:"Deploy-Nano-Server" not "Deploying-Nano-Server"
- Leave out small words, such as a, and, the, in, or.
- Spell words out; avoid unapproved or unnecessary acronyms in file names

Acronyms and initialisms in file names - specific guidelines:

- Follow existing Microsoft guidance for acceptable name abbreviations
- Industry-standard abbreviations are acceptable as necessary in file names.

##Pattern

Review the list of articles in the repository to get an idea of existing names. Here's the general pattern:

 **component-platform-language-content-product-version.md**

##File name approval

When you submit a new file, pull request reviewers review the name and provide feedback via the pull request comment stream if changes are needed. The file name needs to be corrected before the pull request is accepted. Contributors can easily push the update to the pending pull request.

##Folders in the repo

Use the existing folder structure. Don't create folders without getting approval from a repository admin. Talk to them if you think you need a new folder.

##Changing case in file names

Windows operating systems are case insensitive. If you need to change a file name to fix casing, it's better to make a change to the file contents, unless you're on a Linux or Mac. For example:

  biztalk-administration-and-Development-Task-List-in-BizTalk-Services --> biztalk-services-administration-and-development-task-list

Use the 'git mv' command to rename a file:
```
  git mv <WindowsServerDocs/tech-area/subarea/current-file-name.md> <WindowsServerDocs/tech-area/subarea/new-file-name.md>
```

###Contributors' Guide Links

- [Index of guidance articles](./contributor-guide-index.md)


<!--Anchors-->
[Rules]: #rules
[Pattern]: #pattern
[File name approval]: #file-name-approval