# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Version 1.0.3 - 2024-03-13
### CHANGES:
- No real changes. Just update version number, which gets printed out with the -v switch. DUH!

## Version 1.0.2 - 2024-03-13
### CHANGES:
- This is just a little change to skip the return character at the beginning of the struct.
  It simply conflicts with a "Swiftformat" rule and therefore gets permantly switched back and forth.

## Version 1.0.1 - 2023-12-18
### CHANGES:
- Add build parameter in scheme for testing
- Fix non optional path parameters
- Add unit tests

## Version 1.0.0 - 2023-12-18
### CHANGES:
- rewrote the original tool to be a swift package
- changed the meaning of the -s switch from "struct" to "staticString".
  There is no point in vending the identifiers as struct.
