//
//  ViewExtension.swift
//  MemoryChainKit
//
//  Created by Marc Steven on 2023/11/8.
//  Copyright © 2023 Marc Steven(https://marcsteven.top). All rights reserved.
//

import Foundation
import SwiftUI


@available(iOS 13.0, *)
public extension View {
     func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
            return overlay(RoundedRectangle(cornerRadius: cornerRadius).strokeBorder(content, lineWidth: width))
        }
    
    // If condition is met, apply modifier, otherwise, leave the view untouched
    func conditionalModifier<T>(_ condition: Bool, _ modifier: T) -> some View where T: ViewModifier {
            Group {
                if condition {
                    self.modifier(modifier)
                } else {
                    self
                }
            }
        }
    

        // Apply trueModifier if condition is met, or falseModifier if not.
    func conditionalModifier<M1, M2>(_ condition: Bool, _ trueModifier: M1, _ falseModifier: M2) -> some View where M1: ViewModifier, M2: ViewModifier {
            Group {
                if condition {
                    self.modifier(trueModifier)
                } else {
                    self.modifier(falseModifier)
                }
            }
        }
    
       
}
