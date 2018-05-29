//
//  StoryboardParserDelegate.swift
//  SBEnumerator
//
//  Created by Alex da Franca on 27.05.18.
//  Copyright © 2018 Farbflash. All rights reserved.
//

import Cocoa

class StoryboardParserDelegate: NSObject, XMLParserDelegate {
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
        return cellIdentifiersEnum(for: tableViewCellIdentifiers, named: "TableCell", blockIndent: blockIndent)
    }

    final func cvCellIdentifiersEnum(blockIndent: String = "") -> String {
        return cellIdentifiersEnum(for: collectionViewCellIdentifiers, named: "CollectionCell", blockIndent: blockIndent)
    }

    final func aiCellIdentifiersEnum(blockIndent: String = "") -> String {
        return cellIdentifiersEnum(for: accessibiltyIdentifiers, named: "Accessibility", blockIndent: blockIndent)
    }

    private final func cellIdentifiersEnum(for enums: Set<String>, named enumName: String, blockIndent: String = "") -> String {
        guard !enums.isEmpty else {
            return ""
        }
        let enumArray = enums.sorted()
        var enumString = "\(blockIndent)enum \(enumName): String {\n"
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

    private final func snakeCase(_ input: String) -> String {
        return input.replacingOccurrences(of: " ", with: "_")
    }
}
