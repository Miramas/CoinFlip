//
//  CoinView.swift
//  CoinFlip
//
//  Created by miras-fx on 12.02.2024.
//


import SwiftUI

struct CoinView: View {
    let radius: CGFloat
    let color: Color
    
    @Binding var degree: Double

    var body: some View {
        ZStack {
            Circle()
                .fill(color)
                .frame(width: radius)
                .shadow(color: .gray, radius: 2, x: 0, y: 0)
        }.rotation3DEffect(Angle(degrees: degree), axis: (x: 1, y: 0, z: 0))
    }
}
