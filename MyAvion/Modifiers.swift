//
//  Modifiers.swift
//  MyAvion
//
//  Created by Matthew Low on 2024-09-15.
//

import Foundation
import SwiftUI

struct FormTextfieldModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 0.5))

    }
}


struct ConfirmButtonModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundStyle(.white)
            .backgroundStyle(Color.accentColor)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 20))

    }
}
