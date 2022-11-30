//
//  SheathedTextFieldModel.swift
//  Inspec
//
//  Created by Justin Cook on 11/23/22.
//

import SwiftUI

class SheathedTextFieldModel: SheathedTextFieldModelProtocol {
    // MARK: - Properties
    let id: UUID = .init()
    var formatter: Formatter? = nil
    var keyboardType: UIKeyboardType = .default
    var textContentType: UITextContentType = .username
    var textInputAutocapitalization: TextInputAutocapitalization = .never
    var submitLabel: SubmitLabel = .done
    
    // Labels and initial text to be displayed
    var title: String
    var placeholderText: String
    
    // MARK: - Actions
    var onSubmitAction: (() -> Void)? = nil
    
    // MARK: - Binding (Non-property wrapper)
    var boundTextEntry: Binding<String> {
        .init {
            return self.textEntry
        } set: { newVal in
            self.textEntry = newVal
        }
    }
    
    // MARK: - Published
    @Published var textEntry: String
    @Published var enabled: Bool = true
    @Published var focused: Bool = false
    @Published var unsheathed: Bool = false
    @Published var protected: Bool = false
    
    // MARK: - Styling
    // Main Icon
    var icon: Image?
    var iconColor: Color? = Colors.icon_white.0
    
    // MARK: - General Properties
    // Interior
    var fieldBackgroundColor: Color = Colors.white.0
    var textColor: Color = Colors.text_white.0
    var borderColor: Color = Colors.primary_1.0
    var sheatheColor: Color = Colors.primary_1.0
    var textFont: FontRepository = .body_S
    var fontWeight: Font.Weight = .semibold
    
    // Exterior / Shadow
    var invalidEntryGlow: Color? = Colors.attention.0
    var validEntryGlow: Color? = Colors.primary_2
        .0
    var shadowColor: Color? = Colors.shadow_1.0
    var shadowRadius: CGFloat? = 0
    var shadowOffset: CGSize? = CGSize(width: 0, height: 6)
    
    // MARK: - Optional in-field button properties
    var inFieldButtonIcon: Image? = nil
    var inFieldButtonAction: (() -> Void)? = nil
    var inFieldButtonIconTint: Color? = Colors.neutral_500.0
    
    init(title: String = "",
         placeholderText: String = "",
         formatter: Formatter? = nil,
         textEntry: String = "")
    {
        self.title = title
        self.placeholderText = placeholderText
        self.formatter = formatter
        self.textEntry = textEntry
    }
    
    func configurator(configuration: @escaping ((SheathedTextFieldModel)-> Void)) {
        configuration(self)
    }
}
