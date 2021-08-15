//
//  DJClassInheritDemo.swift
//  dj-learn-Swift
//
//  Created by jie sun on 2021/8/10.
//  Copyright © 2021 S.J. All rights reserved.
//

import UIKit
    
class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        print("Vehicle makeNoise")
        // do nothing - an arbitrary vehicle doesn't necessarily make a noise
    }
}

class Bicycle: Vehicle {
    var hasBasket = false
}

class Train: Vehicle {
    override func makeNoise() {
        super.makeNoise()
        print("Choo Choo")
    }
}

class DJClassInheritDemo: NSObject {

}
