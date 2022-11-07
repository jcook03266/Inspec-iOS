//
//  ScrollViewModifier.swift
//  Inspec
//
//  Created by Justin Cook on 11/6/22.
//

import SwiftUI
import UIKit

struct ScrollViewPagingEnabledModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onAppear {
                UIScrollView.appearance().isPagingEnabled = true
            }
            .onDisappear {
                UIScrollView.appearance().isPagingEnabled = false
            }
    }
}

struct ScrollViewPagingDisabledModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onAppear {
                UIScrollView.appearance().isPagingEnabled = false
            }
            .onDisappear {
                UIScrollView.appearance().isPagingEnabled = false
            }
    }
}

extension ScrollView {
    func enablePaging() -> some View {
        modifier(ScrollViewPagingEnabledModifier())
    }
    
    func disablePaging() -> some View {
        modifier(ScrollViewPagingDisabledModifier())
    }
}
