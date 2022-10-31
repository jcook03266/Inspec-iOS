//
//  ResourcesTests.swift
//  InspecTests
//
//  Created by Justin Cook on 10/28/22.
//

@testable import Inspec
import XCTest

final class ResourcesTests: XCTestCase {

    func testAllColorsExist() throws {
        for color in IterableColors.allCases {
            XCTAssertNotNil(Colors.getUIColor(named: color))
            XCTAssertNotNil(Colors.getColor(named: color))
        }
    }
    
    func testAllGradientsExist() throws {
        for gradient in IterableGradients.allCases {
            XCTAssertNotNil(Colors.getLinearGradient(named: gradient))
        }
    }

    func testAllLocalizableStringsExist() throws {
        for string in LocalizedStrings.allCases {
            XCTAssertNoThrow(LocalizedStrings.getLocalizedString(for: string))
        }
    }

}
