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
        borderTrailingPadding: CGFloat = 9,
        maxHeight: CGFloat? = nil
    
    @ObservedObject var expansionController: TextSectionExpansionController = TextSectionExpansionController(expanded: false)
    
    var isExpanded: Bool {
        return expansionController.expanded
    }
    var expansionIndicatorAngle: Angle {
        return Angle(degrees: (isExpanded ? 180 : 0))
    }
    
    /// Indicates to the user that the current text section can be expanded to reveal more text
    var expansionIndicator: some View {
            Icons.getIconImage(named: .chevron_compact_down)
            .resizable()
                .rotationEffect(expansionIndicatorAngle)
                .animation(.spring(), value: isExpanded)
                .aspectRatio(contentMode: .fit)
                .foregroundColor(borderColor)
                .frame(width: 30, height: 30)
    }
    
    var body: some View {
        VStack {
            HStack {
                Rectangle()
                    .fill(borderColor)
                    .frame(width: borderWidth)
                    .padding(.trailing, borderTrailingPadding)
                ScrollView {
                    if let message = message.0 {
                        Text(message)
                            .withFont(font)
                            .fontWeight(fontWeight)
                            .padding([.top, .bottom], verticalPadding / 2)
                    }
                    else if let message = message.1 {
                        Text(message)
                            .withFont(font)
                            .fontWeight(fontWeight)
                            .padding([.top, .bottom], verticalPadding / 2)
                    }
                }
                .onTapGesture {
                    expansionController.toggle()
                }
            }
            .background(backgroundColor)
            .animation(.spring(), value: isExpanded)
            .frame(maxHeight: isExpanded ? nil : maxHeight)
            .fixedSize(horizontal: false,
                       vertical: true)
         
            if maxHeight != nil {
                expansionIndicator
                    .onTapGesture {
                        expansionController.toggle()
                    }
            }
        }
    }
}

class TextSectionExpansionController: ObservableObject {
    @Published var expanded: Bool = false
    
    init(expanded: Bool) {
        self.expanded = expanded
    }
    
    func toggle() {
        expanded.toggle()
    }
}

struct BorderedTextSection_Previews: PreviewProvider {
    static var previews: some View {
        BorderedTextSection(message: ("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", nil))
    }
}
