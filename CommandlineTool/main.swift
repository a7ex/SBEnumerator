//
//  main.swift
//  SBEnumerator
//
//  Created by Alex da Franca on 27.05.18.
//  Copyright © 2018 Farbflash. All rights reserved.
//

import Foundation
import ArgumentParser
import SBEnumeratorLib

private let marketingVersion = "1.0.0"

struct sbenumerator: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "SBEnumerator \(marketingVersion)\nParse Xcode storyboard and xib files and gather cell- and accessibility identifiers, which are used in Interface Builder files."
    )

    @Flag(name: .shortAndLong, help: "Output static strings instead of enum cases.")
    var staticStrings: Int

    @Flag(name: .shortAndLong, help: "Show version number.")
    var version: Int

    @Argument(help: "The paths to the Interface Builder files.")
    var ibFiles: [String]

    mutating func run() throws {
        guard version != 1 else {
            print(marketingVersion)
            return
        }
        guard !ibFiles.isEmpty else {
            throw ParseError.argumentError
        }

        let ibparser = InterfaceBuilderParser(createStaticStrings: (staticStrings != 0)) { error in
            writeToStdOut("// \(error)")
        }

        for storyboardFile in ibFiles {
            let url = URL(fileURLWithPath: storyboardFile)
            guard let parser = XMLParser(contentsOf: url) else {
                writeToStdError("Unable to read xml file at \(url.absoluteString)!\n")
                continue
            }
            parser.delegate = ibparser
            parser.parse()
        }

        let ident = "    "
        var filecontents = """
//
// StoryboardIdentifiers.swift
// Automatically created by SBEnumerator.
//
// DO NOT EDIT THIS FILE!
// This file was automatically generated from the contents of storyboard files
// Update the storyboard and then use the SBEnumerator
// to create the corresponding Enum or Struct source files automatically

import Foundation

enum StoryboardIdentifiers {
"""
        if let identifiers = ibparser.tvCellIdentifiersEnum(blockIndent: ident).nonEmptyString {
            filecontents += "\n\n\(identifiers)"
        }
        if let identifiers = ibparser.cvCellIdentifiersEnum(blockIndent: ident).nonEmptyString {
            filecontents += "\n\n\(identifiers)"
        }
        if let identifiers = ibparser.aiCellIdentifiersEnum(blockIndent: ident).nonEmptyString {
            filecontents += "\n\n\(identifiers)"
        }
        filecontents += "\n}"

        writeToStdOut(filecontents)
    }
}

enum ParseError: Error {
    case argumentError
}

sbenumerator.main()

