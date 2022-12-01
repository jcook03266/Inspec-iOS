//
//  Bundle+AppExtensions.swift
//  Inspec
//
//  Created by Justin Cook on 12/1/22.
//

import Foundation

extension Bundle {
    // MARK: - Bundle Keys
    fileprivate enum Keys: AssociatedEnum {
        static var allCases: [Bundle.Keys] = [.nameKey(),
                                              .versionKey()]
        typealias associatedValue = String
        
        case nameKey(String = kCFBundleNameKey as String)
        case versionKey(String = kCFBundleVersionKey as String)
        case shortVersionKey(String = "CFBundleShortVersionString")
        
        func getAssociatedValue() -> String {
            switch self {
            case .versionKey(let key):
                return key
            case .nameKey(let key):
                return key
            case .shortVersionKey(let key):
                return key
            }
        }
    }
    
    /// Simplifies accessing the optional information dictionary of the main bundle
    var informationDictionary: [String : Any] {
        guard let info = infoDictionary
        else { fatalError("Info dictionary could not be resolved \(#function)") }
        
        return info
    }
    
    var name: String {
        guard let name = getInformation(using: .nameKey())
        else {
            guard AppInformation.isProduction else { fatalError("Bundle name could not be parsed using \(#function) in \(#filePath)") }
            return ""
        }
        
        return name
    }
    
    var version: String {
        guard let version = getInformation(using: .versionKey())
        else {
            guard AppInformation.isProduction else { fatalError("Bundle version could not be parsed using \(#function) in \(#filePath)") }
            return ""
        }
        
        return version
    }
    
    var releaseVersion: String {
        guard let shortenedVersion = getInformation(using: .shortVersionKey())
        else { fatalError("Bundle shortened version could not be parsed using \(#function) in \(#filePath)") }
        
        return shortenedVersion
    }
    
    var buildID: Int {
        guard let buildID = version.components(separatedBy: ".").last,
              let numericalBuildID = Int(buildID)
        else {
            if AppInformation.isProduction {
                return -1
            }
            else {
                fatalError("Bundle build ID could not be parsed using \(#function) in \(#filePath)")
            }
        }
        
        return numericalBuildID
    }
    
    fileprivate func getInformation(using key: Keys) -> String? {
        return informationDictionary[key.getAssociatedValue()] as? String
    }
}
