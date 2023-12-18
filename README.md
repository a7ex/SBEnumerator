# SBEnumerator

## Overview

Generate swift enums for cell reuseidentifiers and accessibilty identifiers defined in storyboards

A macOS command line tool that generates Swift Enums based on storyboard files in XML format.

This command line tool parses the storyboard files, which are passed as arguments for tableViewCell identifiers, collectionViewCell identifiers and accessibility identifiers. It creates a struct with three enums, which list the names.

If the identifier names contain spaces, those are replaced by underscores for the enum cases, but kept preserved as string rawValue.

Written in Swift 4.

## Features

- Processes XML files, which are in storyboard and xib format

## What is code generation?

Using a Swift code generator is very different from using a ibrary API. If you have never worked with a code generator before, check out [this blog post](https://ijoshsmith.com/2016/11/03/swift-json-library-vs-code-generation/) for a quick overview.

## How to get it

- Download the `sbenumerator` app binary from the latest [release](https://github.com/a7ex/SBEnumerator/tree/master/release)
- Copy `SBEnumerator` to your desktop
- Open a Terminal window and run this command to give the app permission to execute:

```
chmod +x ~/Desktop/sbenumerator
```

Or build the tool in Xcode yourself:

- Clone the repository / Download the source code
- Build the project
- Open a Finder window to the executable file

- Drag `sbenumerator` from the Finder window to your desktop

## How to install it

Assuming that the `sbenumerator` app is on your desktop…

Open a Terminal window and run this command:
```
cp ~/Desktop/sbenumerator /usr/local/bin/
```
Verify `sbenumerator` is in your search path by running this in Terminal:
```
sbenumerator
```
You should see the tool respond like this:
```
Error: Missing expected argument '<ib-files> ...'

OVERVIEW: SBEnumerator 1.0.0
Parse Xcode storyboard and xib files and gather cell- and accessibility
identifiers, which are used in Interface Builder files.

USAGE: sbenumerator [--static-strings ...] [--version ...] <ib-files> ...

ARGUMENTS:
  <ib-files>              The paths to the Interface Builder files.

OPTIONS:
  -s, --static-strings    Output static strings instead of enum cases.
  -v, --version           Show version number.
  -h, --help              Show help information.

```
Now that a copy of `sbenumerator` is in your search path, delete it from your desktop.

You're ready to go! 🎉

## How to use it

Open a Terminal window and pass `sbenumerator` one or more file path to storyboard XML files:
```
sbenumerator /path/to/some/Main.storyboard > StoryboardIdentifiers.swift
```
The tool prints the swift code. Write the output into a swift file.  
Or  
Find all storyboard and xib files in the current wroking directory and write the output into file 'StoryboardIdentifiers.swift':
```
find . -name "*.storyboard" -o -name "*.xib" | xargs sbenumerator > StoryboardIdentifiers.swift
```
