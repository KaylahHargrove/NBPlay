//
//  Model.swift
//  AngeloApp
//
//  Created by Joseph Brinker on 10/9/24.
//

import Foundation

class Model: ObservableObject {
    @Published var ballCount = 3000000000.0
    @Published var generation = 1.0
    
    var timer: Timer?
    
    init(){
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in self.tick() })
    }
    
    func tick() {
        ballCount += generation
    }
}
