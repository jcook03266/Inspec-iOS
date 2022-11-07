//
//  BorderedTextSection.swift
//  Inspec
//
//  Created by Justin Cook on 11/5/22.
//

import SwiftUI

struct BorderedTextSection: View {
    var backgroundColor: Color = Color.clear,
        textColor: Color = Colors.text_white.0,
        borderColor: Color = Colors.primary_1.0,
        font: FontRepository = .body_L,
        fontWeight: Font.Weight = .medium,
        message: (String?, LocalizedStringKey?),
        borderWidth: CGFloat = 2,
        verticalPadding: CGFloat = 4,
        borderTrailingPadding: CGFloat = 9
        
    
    var body: some View {
        HStack {
            Rectangle()
                .fill(borderColor)
                .frame(width: borderWidth)
                .padding(.trailing, borderTrailingPadding)
            
            if let message = message.0 {
                Text(message)
                    .withFont(font)
                    .fontWeight(fontWeight)
                    .padding([.top, .bottom], verticalPadding / 2)
                    .minimumScaleFactor(0.5)
            }
            else if let message = message.1 {
                Text(message)
                    .withFont(font)
                    .fontWeight(fontWeight)
                    .padding([.top, .bottom], verticalPadding / 2)
                    .minimumScaleFactor(0.5)
            }
            
            Spacer()
        }
        .fixedSize(horizontal: false,
                   vertical: true)
        
    }
}

struct BorderedTextSection_Previews: PreviewProvider {
    static var previews: some View {
        BorderedTextSection(message: ("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", nil))
    }
}
