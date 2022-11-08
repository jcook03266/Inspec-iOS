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
        for color in ColorRepository.allCases {
            XCTAssertNotNil(Colors.getUIColor(named: color))
            XCTAssertNotNil(Colors.getColor(named: color))
        }
    }
    
    func testAllGradientsExist() throws {
        for gradient in GradientRepository.allCases {
            XCTAssertNotNil(Colors.getLinearGradient(named: gradient))
        }
    }
    
    func testAllImagesExist() throws {
        for image in ImageRepository.allCases {
            XCTAssertNoThrow(Images.getImage(named: image))
        }
    }
    
    func testAllCharacterImagesExist() throws {
        for image in CharacterImageRepository.allCases {
            XCTAssertNoThrow(Images.Characters.getImage(named: image))
        }
    }
    
    func testAllIconsExist() throws {
        for icon in CustomIconRepository.allCases {
            XCTAssertNoThrow(Icons.getIconImage(named: icon))
        }
        for icon in SystemIconRepository.allCases {
            XCTAssertNoThrow(Icons.getIconImage(named: icon))
        }
    }
    
    func testAllAnimationsExist() throws {
        for animation in LottieAnimationRepository.allCases {
            XCTAssertNoThrow(LottieAnimations.getAnimation(named: animation))
        }
    }

    func testAllLocalizableStringsExist() throws {
        for string in LocalizedStrings.allCases {
            XCTAssertNoThrow(LocalizedStrings.getLocalizedString(for: string))
        }
    }

}
