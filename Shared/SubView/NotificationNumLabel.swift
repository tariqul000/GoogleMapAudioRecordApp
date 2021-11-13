//
//  NotificationNumLabel.swift
//  TestMapDemo (iOS)
//
//  Created by Md Tariqul Islam on 13/11/21.
//

import SwiftUI

struct NotificationNumLabel : View {
    @Binding var digit : Int
    var body: some View {
        ZStack {
            Capsule().fill(Color.red).frame(width: 10 * CGFloat(numOfDigits()), height: 20, alignment: .topTrailing).position(CGPoint(x: 40, y: 15))
            Text("\(digit)")
                .foregroundColor(Color.white)
                .font(Font.system(size: 12).bold()).position(CGPoint(x: 40, y: 15))
        }
    }
    func numOfDigits() -> Float {
        let numOfDigits = Float(String(digit).count)
        return numOfDigits == 1 ? 1.5 : numOfDigits
    }
}
