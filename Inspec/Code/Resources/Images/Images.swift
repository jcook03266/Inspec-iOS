//
//  Images.swift
//  Inspec
//
//  Created by Justin Cook on 10/31/22.
//

import UIKit
import SwiftUI

/// Image / icon selector for picking out all enumerated images stored in the corresponding Images xcassets file
/// Please update the appropriate enumerations whenever an image is added or removed from the xcassets
// MARK: - Structs
struct Images {
    static func getImage(named imageName: ImageRepository) -> Image {
        return Image(uiImage: getUIImage(named: imageName))
    }
    
    static func getUIImage(named imageName: ImageRepository) -> UIImage {
        guard let image = UIImage(named: imageName.rawValue) else {
            
            preconditionFailure("Error: The image named \(imageName) was not found, Function: \(#function)")
        }
        
        return image
    }
}

extension Images {
    struct Characters {}
    
    static func getImage(named imageName: CharacterImageRepository) -> Image {
        return Image(uiImage: getUIImage(named: imageName))
    }
    
    static func getUIImage(named imageName: CharacterImageRepository) -> UIImage {
        guard let image = UIImage(named: imageName.rawValue) else {
            
            preconditionFailure("Error: The character image named \(imageName) was not found, Function: \(#function)")
        }
        
        return image
    }
}

extension Images.Characters {
    static func getImage(named imageName: CharacterImageRepository) -> Image {
        return Image(uiImage: getUIImage(named: imageName))
    }
    
    static func getUIImage(named imageName: CharacterImageRepository) -> UIImage {
        guard let image = UIImage(named: imageName.rawValue) else {
            
            preconditionFailure("Error: The character image named \(imageName) was not found, Function: \(#function)")
        }
        
        return image
    }
}

/// Use this struct to select custom or system icons
struct Icons {
    static func getIconImage(named customName: CustomIconRepository) -> Image {
        return Image(uiImage: getIconUIImage(named: customName))
    }
    
    static func getIconUIImage(named customName: CustomIconRepository) -> UIImage {
        guard let image = UIImage(named: customName.rawValue) else {
            
            preconditionFailure("Error: The custom icon named \(customName) was not found, Function: \(#function)")
        }
        
        return image
    }
    
    static func getIconImage(named systemName: SystemIconRepository) -> Image {
        return Image(uiImage: getIconUIImage(named: systemName))
    }
    
    static func getIconUIImage(named systemName: SystemIconRepository) -> UIImage {
        guard let image = UIImage(systemName: systemName.rawValue) else {
            
            preconditionFailure("Error: The system icon named \(systemName) was not found, Function: \(#function)")
        }
        
        return image
    }
}

// MARK: - Image Enumerations
enum ImageRepository: String, CaseIterable, Hashable {
    case twitter = "twitter"
    case google = "google"
    case apple = "apple"
}

enum CharacterImageRepository: String, CaseIterable, Hashable {
    case Ian_Transparent_Background = "Ian.Transparent.Background",
         Ian_Portrait = "Ian.Portrait"
}

enum CustomIconRepository: String, CaseIterable, Hashable {
    case chat = "chat",
         brain_graph = "brain.graph"
}

enum SystemIconRepository: String, CaseIterable, Hashable {
    case chevron_left = "chevron.left",
         chevron_right = "chevron.right",
         chevron_up = "chevron.up",
         chevron_down = "chevron.down",
         arrow_right = "arrow.right",
         arrow_left = "arrow.left",
         ellipsis = "ellipsis",
         square = "square",
         checkmark_square_fill = "checkmark.square.fill",
         plus_circle = "plus.circle",
         minus_circle = "minus.circle",
         plus_circle_fill = "plus.circle.fill",
         xmark_circle_fill = "xmark.circle.fill",
         checkmark_circle_fill = "checkmark.circle.fill",
         plus = "plus",
         minus = "minus",
         checkmark = "checkmark",
         xmark = "xmark",
         paperplane = "paperplane",
         square_grid_2x2 = "square.grid.2x2",
         doc = "doc",
         book = "book",
         text_bubble = "text.bubble",
         bubble_left = "bubble.left",
         square_and_pencil = "square.and.pencil",
         bell = "bell",
         clock = "clock",
         questionmark_circle = "questionmark.circle",
         exclamationmark_triangle = "exclamationmark.triangle",
         lock = "lock",
         key = "key",
         link = "link",
         creditcard = "creditcard",
         wifi_slash = "wifi.slash",
         person_crop_circle_badge_plus = "person.crop.circle.badge.plus",
         heart = "heart",
         heart_fill = "heart.fill",
         hand_thumbsup = "hand.thumbsup",
         hand_thumbsup_fill = "hand.thumbsup.fill",
         hand_thumbsdown = "hand.thumbsdown",
         hand_thumbsdown_fill = "hand.thumbsdown.fill",
         star = "star",
         star_fill = "star.fill",
         play_circle_fill = "play.circle.fill",
         gobackward = "gobackward",
         magnifyingglass = "magnifyingglass",
         plus_square_on_square = "plus.square.on.square",
         square_and_arrow_up = "square.and.arrow.up",
         square_and_arrow_down = "square.and.arrow.down",
         gear = "gear",
         bolt_fill = "bolt.fill",
         bolt_slash_fill = "bolt.slash.fill",
         bolt_badge_a_fill = "bolt.badge.a.fill",
         stop_circle = "stop.circle",
         rays = "rays",
         arrow_triangle_2_circlepath = "arrow.triangle.2.circlepath",
         arrow_2_squarepath = "arrow.2.squarepath",
         rectangle_portrait_and_arrow_right = "rectangle.portrait.and.arrow.right",
         face_smiling = "face.smiling",
         wand_and_stars = "wand.and.stars",
         gauge = "gauge",
         crown = "crown",
         megaphon = "megaphone",
         tray = "tray",
         house = "house",
         point_3_connected_trianglepath_dotted = "point.3.connected.trianglepath.dotted",
         point_3_filled_connected_trianglepath_dotted = "point.3.filled.connected.trianglepath.dotted",
         circle_hexagongrid_fill = "circle.hexagongrid.fill",
         aqi_medium = "aqi.medium",
         rectangle_3_group_fill = "rectangle.3.group.fill"
}
