//
//  NiceRect.swift
//  Culturify
//
//  Created by Jatin Rakesh on 19/3/25.
//

import Foundation
import SwiftUI 

struct NiceRect: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.99566*width, y: 0.5*height))
        path.addCurve(to: CGPoint(x: 0.50222*width, y: height), control1: CGPoint(x: 0.99566*width, y: height), control2: CGPoint(x: 0.77959*width, y: height))
        path.addCurve(to: CGPoint(x: 0, y: 0.5*height), control1: CGPoint(x: 0.22485*width, y: height), control2: CGPoint(x: 0, y: height))
        path.addCurve(to: CGPoint(x: 0.50222*width, y: 0), control1: CGPoint(x: 0, y: 0.1925*height), control2: CGPoint(x: 0.07282*width, y: 0))
        path.addCurve(to: CGPoint(x: 0.99566*width, y: 0.5*height), control1: CGPoint(x: 0.93162*width, y: 0), control2: CGPoint(x: 0.99566*width, y: 0.20125*height))
        path.closeSubpath()
        return path
    }
}
