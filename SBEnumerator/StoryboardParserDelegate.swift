//
//  StoryboardParserDelegate.swift
//  SBEnumerator
//
//  Created by Alex da Franca on 27.05.18.
//  Copyright © 2018 Farbflash. All rights reserved.
//

import Cocoa

class StoryboardParserDelegate: NSObject, XMLParserDelegate {
    var createStructs = false
    private final var collectionViewCellIdentifiers = Set<String>()
    private final var tableViewCellIdentifiers = Set<String>()
    private final var accessibiltyIdentifiers = Set<String>()
    private let indent = "    "

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String] = [:]) {
        switch elementName {
        case "collectionViewCell":
            if let identifier = attributeDict["reuseIdentifier"],
                !identifier.isEmpty {
                collectionViewCellIdentifiers.insert(identifier)
            }
        case "tableViewCell":
            if let identifier = attributeDict["reuseIdentifier"],
                !identifier.isEmpty {
                tableViewCellIdentifiers.insert(identifier)
            }
        case "accessibility":
            if let identifier = attributeDict["identifier"],
                !identifier.isEmpty {
                if accessibiltyIdentifiers.contains(identifier) {
                    writeToStdError("Dupicate accessibility identifiers: \"\(identifier)\"!\n")
                } else {
                    accessibiltyIdentifiers.insert(identifier)
                }
            }
        default:
            break
        }
    }

    final func tvCellIdentifiersEnum(blockIndent: String = "") -> String {
        let topCopmment = """
        \(blockIndent)// All UITableViewCell reuseIdentifiers, which were found in all storyboards
        \(blockIndent)// and xibs at the last time SBEnumerator ran and scanned the IB files\n
        """
        if createStructs {
            return cellIdentifiersStruct(for: tableViewCellIdentifiers, named: "TableCell", blockIndent: blockIndent, topComment: topCopmment)
        } else {
            return cellIdentifiersEnum(for: tableViewCellIdentifiers, named: "TableCell", blockIndent: blockIndent, topComment: topCopmment)
        }
    }

    final func cvCellIdentifiersEnum(blockIndent: String = "") -> String {
        let topCopmment = """
        \(blockIndent)// All UICollectionViewCell reuseIdentifiers, which were found in all storyboards
        \(blockIndent)// and xibs at the last time SBEnumerator ran and scanned the IB files\n
        """
        if createStructs {
            return cellIdentifiersStruct(for: collectionViewCellIdentifiers, named: "CollectionCell", blockIndent: blockIndent, topComment: topCopmment)
        } else {
            return cellIdentifiersEnum(for: collectionViewCellIdentifiers, named: "CollectionCell", blockIndent: blockIndent, topComment: topCopmment)
        }
    }

    final func aiCellIdentifiersEnum(blockIndent: String = "") -> String {
        let topCopmment = """
        \(blockIndent)// All Accessibility Identifiers, which were found in all storyboards
        \(blockIndent)// and xibs at the last time SBEnumerator ran and scanned the IB files\n
        """
        if createStructs {
            return cellIdentifiersStruct(for: accessibiltyIdentifiers, named: "Accessibility", blockIndent: blockIndent, topComment: topCopmment)
        } else {
            return cellIdentifiersEnum(for: accessibiltyIdentifiers, named: "Accessibility", blockIndent: blockIndent, topComment: topCopmment)
        }
    }

    private final func cellIdentifiersEnum(for enums: Set<String>, named enumName: String, blockIndent: String = "", topComment: String = "") -> String {
        guard !enums.isEmpty else {
            return ""
        }
        let enumArray = enums.sorted()
        var enumString = "\(topComment)\(blockIndent)enum \(enumName): String {\n"
        for ident in enumArray {
            let key = snakeCase(ident)
            if key == ident {
                enumString += "\(blockIndent)\(indent)case \(key)\n"
            } else {
                enumString += "\(blockIndent)\(indent)case \(key) = \"\(ident)\"\n"
            }
        }
        enumString += "\(blockIndent)}"
        return enumString
    }

    private final func cellIdentifiersStruct(for enums: Set<String>, named enumName: String, blockIndent: String = "", topComment: String = "") -> String {
        guard !enums.isEmpty else {
            return ""
        }
        let enumArray = enums.sorted()
        var enumString = "\(topComment)\(blockIndent)struct \(enumName) {\n"
        for ident in enumArray {
            let key = snakeCase(ident)
            enumString += "\(blockIndent)\(indent)static let \(key) = \"\(ident)\"\n"
        }
        enumString += "\(blockIndent)}"
        return enumString
    }

    private final func snakeCase(_ input: String) -> String {
        return input.replacingOccurrences(of: " ", with: "_")
    }
}
