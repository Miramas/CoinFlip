//
//  ContentViewModel.swift
//  CoinFlip
//
//  Created by miras-fx on 12.02.2024.
//

import SwiftUI

class ContentViewModel: ObservableObject{
    @Published var backDegree = 0.0
    @Published var frontDegree = -90.0
    @Published var counter: Int = 0
    @Published var isTails: Bool = false
    @Published var text: String = "-"
    @Published var tailsCountText: String = "Tails Count: 0"
    @Published var headsCountText: String = "Heads Count: 0"
    
    private lazy var tailsCount: Int = 0
    private lazy var headsCount: Int = 0
    
    private let duration: CGFloat = 0.2
    
    func flipCoin() {
        text = "flipping"
        isTails = Int.random(in: 0...1).isMultiple(of: 2)
        
        if backDegree != 450 {
            backDegree = 0.0
            frontDegree = -90.0
            
            for i in stride(from: 0, to: 5, by: 2) {
                let floatI = CGFloat(i)
                
                
                withAnimation(.linear(duration: duration).delay(duration * floatI)) {
                    backDegree += 90
                }
                withAnimation(.linear(duration: duration).delay(duration * (floatI + 1))) {
                    frontDegree += 90
                } completion: { [weak self] in
                    guard let self else { return }
                    if i == 4 && self.isTails {
                        finishAnimation()
                    }
                }
                
                if !(i == 4 && isTails) {
                    withAnimation(.linear(duration: duration).delay(duration * (floatI + 1))) {
                        frontDegree += 90
                    }
                    withAnimation(.linear(duration: duration).delay(duration * (floatI + 2))) {
                        backDegree += 90
                    } completion: { [weak self] in
                        guard let self else { return }
                        if i == 4 {
                            finishAnimation()
                        }
                    }
                }
            }
        } else {
            frontDegree = 0.0
            backDegree = -90.0
                        
            for i in stride(from: 0, to: 5, by: 2) {
                let floatI = CGFloat(i)
                
            
                withAnimation(.linear(duration: duration).delay(duration * floatI)) {
                    frontDegree += 90
                }
                withAnimation(.linear(duration: duration).delay(duration * (floatI + 1))) {
                    backDegree += 90
                } completion: { [weak self] in
                    guard let self else { return }
                    if i == 4 && !self.isTails {
                        finishAnimation()
                    }
                }
                
                if !(i == 4 && !isTails) {
                    withAnimation(.linear(duration: duration).delay(duration * (floatI + 1))) {
                        backDegree += 90
                    }
                    withAnimation(.linear(duration: duration).delay(duration * (floatI + 2))) {
                        frontDegree += 90
                    } completion: { [weak self] in
                        guard let self else { return }
                        if i == 4 {
                            finishAnimation()
                        }
                    }
                }
            }
        }
    }
    
    private func finishAnimation() {
        if isTails {
            text = "it is tails"
            tailsCount += 1
            tailsCountText = "Tails Count: \(tailsCount)"
        } else {
            text = "it is head"
            headsCount += 1
            headsCountText = "Heads Count: \(headsCount)"
        }
    }
}
