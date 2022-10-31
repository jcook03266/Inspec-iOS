//
//  ViewExtensions.swift
//  Inspec
//
//  Created by Justin Cook on 10/29/22.
//

import SwiftUI

extension View {
    func rectReader(_ binding: Binding<CGRect>, in space: CoordinateSpace) -> some View {
        self.background(GeometryReader {(geom) -> AnyView in
            let rect = geom.frame(in: space)
            DispatchQueue.main.async {
                binding.wrappedValue = rect
            }
            return AnyView(Rectangle().fill(Color.clear))
        })
    }
}
