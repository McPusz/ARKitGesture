//
//  BoxNode.swift
//  ARKitGesture
//
//  Created by Mpalka on 16.03.2018.
//  Copyright © 2018 McPusz. All rights reserved.
//

import Foundation
import SceneKit

class BoxNode: SCNNode {
    
    static var nodeName: String {
        return String(describing: self)
    }
    
    private var color: Any? {
        get {
            return self.geometry?.materials.first?.diffuse.contents
        }
        
        set {
            self.geometry?.materials.first?.diffuse.contents = newValue
        }
    }
    
    private let size: CGFloat = 0.1
    private var selected = false
    private let blue = UIColor(red: 0.34, green: 0.75, blue: 0.97, alpha: 1.0)
    private let red = UIColor(red: 1.00, green: 0.81, blue: 0.81, alpha: 1.0)
    
    override init() {
        super.init()
        self.name = BoxNode.nodeName
        self.setupNode()
        self.position = SCNVector3Make(0, 0, 0)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupNode() {
        self.geometry = SCNBox(width: size, height: size, length: size, chamferRadius: 0)
        self.color = blue
    }
    
    func select() {
        self.selected = !selected
        self.color = selected ? red : blue
    }
    
}
