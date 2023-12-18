# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
