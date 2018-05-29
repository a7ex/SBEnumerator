//
//  StringExtension.swift
//  SBEnumerator
//
//  Created by Alex da Franca on 29.05.18.
//  Copyright © 2018 Farbflash. All rights reserved.
//

import Foundation

extension String {
    var nonEmptyString: String? {
        guard !isEmpty else {
            return nil
        }
        return self
    }
}
