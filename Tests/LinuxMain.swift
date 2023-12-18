//
//  LinuxMain.swift
//
//  Created by Alex da Franca on 26.12.21.
//

import XCTest
import SBEnumeratorTests

var tests = [XCTestCaseEntry]()
tests += SBEnumeratorTests.allTests()
XCTMain(tests)
