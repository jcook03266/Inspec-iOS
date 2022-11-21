//
//  StringTests.swift
//  InspecTests
//
//  Created by Justin Cook on 11/21/22.
//

@testable import Inspec
import XCTest

final class StringTests: XCTestCase {
    
    /// Tuple format: String to parse, separator type, expected components parsed from initial string
    func testParseStringComponents() throws {
        let testCases: [(String, String, Int)] = [("hello.world.how.are.you", ".", 5),
                                                  ("helloworld", ".", 1),
                                                  ("endPeriod.", ".", 2),
                                                  (".startPeriod", ".", 2),
                                                  ("middle.period", ".", 2),
                                                  ("..doubleStartPeriod", ".", 3),
                                                  ("doubleEndPeriod..", ".", 3),
                                                  ("doubleMiddle..Period", ".", 3),
                                                  ("tripleMiddle...Period", ".", 4),
                                                  ("tripleEndPeriod...", ".", 4),
                                                  ("...tripleStartPeriod", ".", 4),
                                                  ("different,separator", ",", 2),
                                                  ("emoji😀Separator", "😀", 2),
                                                  ("glyph•Separator", "•", 2),
                                                  ("nullSeparator", "", 1),
                                                  ("space Separator", " ", 2)]
        
        for testCase in testCases {
            let string = testCase.0
            let separator = testCase.1
            let expectedSeparatedComponents = testCase.2
            
            let parsedComponents = string.splitStringIntoComponents(using: separator)
            
            XCTAssertEqual(parsedComponents.count,
                           expectedSeparatedComponents,
                           "Test String: \(string), Parsed Components: \(parsedComponents)")
        }
    }
}
