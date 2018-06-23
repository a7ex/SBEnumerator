//
//  CliArguments.swift
//
//  Created by Alex da Franca on 28.06.18.
//  Copyright © 2018 Farbflash. All rights reserved.
//

import Foundation

/// This is the "model" for our supported command line parameters
/// This is an example for a programm which recognizes -h (or -? or --help)
/// and all unnamed parameters go into the array "paths"

struct CliArguments {

    let programName: String
    let programPath: String
    let help: Bool
    let paths: [String]
    let version: Bool
    let createStructs: Bool

    static func expandedPropertyName(for shortform: String) -> String {
        switch shortform {
        case "h", "?":
            return "help"
        case "v":
            return "version"
        case "s":
            return "structs"
        default:
            return shortform
        }
    }

    init() {
        let cliArguments = CLIArgsParser.processCLIArgs(cliParams: CommandLine.arguments, mapping: CliArguments.expandedPropertyName)
        self.init(with: cliArguments)
    }

    init(with cliParams: [String: Any]) {
        // program stats:
        programName = (cliParams[SpecialCliArgsParserKeys.programName.rawValue] as? String) ?? ""
        programPath = (cliParams[SpecialCliArgsParserKeys.programPath.rawValue] as? String) ?? ""

        // help:
        help = (cliParams["help"] as? Bool) ?? (cliParams["h"] as? Bool) ?? (cliParams["?"] as? Bool) ?? false

        // unnamed parameters:
        paths = (cliParams[SpecialCliArgsParserKeys.unnamed.rawValue] as? [String]) ?? [String]()

        // version:
        version = (cliParams["version"] as? Bool) ?? (cliParams["v"] as? Bool) ?? false
        
        createStructs = (cliParams["structs"] as? Bool) ?? (cliParams["s"] as? Bool) ?? false
    }

    func printHelpText() {
        print(helpText)
    }

    func printVersion() {
        print(versionString)
    }

    var helpText: String {
        return """
        \(programName) - \(versionString)
        Created by Alex da Franca - Farbflash
        Usage: \(programName) [options]
            -s, --structs:\n    Create Structs if true, otherwise create Enums.
            -h, -?, --help:\n    Prints a help message.
            -v, --version:\n    Prints version information.
            all remaining parameters are considered paths to xml input files\n\n"
        """
    }

    var versionString: String {
        let majorVersion = (Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String) ?? ""
        let buildnumber = (Bundle.main.object(forInfoDictionaryKey: String(kCFBundleVersionKey)) as? String) ?? ""
        return "Version: \(majorVersion) (Build: \(buildnumber))"
    }
}
