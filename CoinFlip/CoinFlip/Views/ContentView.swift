//
//  ContentView.swift
//  CoinFlip
//
//  Created by miras-fx on 12.02.2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ContentViewModel()

    enum Constants {
        static let radius: CGFloat = 200
    }
    
    var body: some View {
        VStack {
            Text("Flip a coin!")
            Spacer(minLength: 144)
            ZStack {
                CoinView(
                    radius: Constants.radius,
                    color: .yellow,
                    degree: $viewModel.frontDegree
                )
                CoinView(
                    radius: Constants.radius,
                    color: .blue,
                    degree: $viewModel.backDegree
                )
            }
            .onTapGesture {
                viewModel.flipCoin()
            }
            .gesture(
                DragGesture(
                    minimumDistance: 0,
                    coordinateSpace: .local
                )
                .onEnded( { value in
                    if value.translation.height < 0 {
                        viewModel.flipCoin()
                    }
                })
            )
            Spacer(minLength: 32)
            Text(viewModel.text)
            Spacer()
            HStack {
                Text(viewModel.headsCountText)
                    .frame(alignment: .leading)
                Spacer()
                Text(viewModel.tailsCountText)
                    .frame(alignment: .trailing)
            }
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
