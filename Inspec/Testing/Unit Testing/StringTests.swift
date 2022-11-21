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
    func parseStringComponentsTest() throws {
        let testCases: [(String, String, Int)] = [("hello.world.how.are.you", ".", 5),
                                                  ("helloworld", ".", 1),
                                                  ("endPeriod.", ".", 1),
                                                  (".startPeriod", ".", 1),
                                                  ("middle.period", ".", 2),
                                                  ("..doubleStartPeriod", ".", 1),
                                                  ("doubleEndPeriod..", ".", 1),
                                                  ("doubleMiddle..Period", ".", 2),
                                                  ("tripleMiddle...Period", ".", 2),
                                                  ("tripleEndPeriod...", ".", 1),
                                                  ("...tripleStartPeriod", ".", 1),
                                                  ("different,separator", ",", 2),
                                                  ("emoji😀Separator", "😀", 2),
                                                  ("glyph•Separator", "•", 2),
                                                  ("nullSeparator", "", 1),
                                                  ("space Separator", " ", 2)]
        
        for testCase in testCases {
            let string = testCase.0
            let separator = testCase.1
            let expectedSeparatedComponents = testCase.2
            
            XCTAssertEqual(string.splitStringIntoComponents(using: separator).count,
                           expectedSeparatedComponents)
        }
    }
}
