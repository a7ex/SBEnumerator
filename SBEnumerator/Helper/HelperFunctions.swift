//
//  HelperFunctions.swift
//  SwiftDTO
//
//  Created by Alex da Franca on 24.05.17.
//  Copyright © 2017 Farbflash. All rights reserved.
//

import Foundation

func writeToStdError(_ str: String) {
    let handle = FileHandle.standardError

    if let data = str.data(using: String.Encoding.utf8) {
        handle.write(data)
    }
}

func writeToStdOut(_ str: String) {
    let handle = FileHandle.standardOutput

    if let data = "\(str)\n".data(using: String.Encoding.utf8) {
        handle.write(data)
    }
}
