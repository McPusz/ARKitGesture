//
//  ViewController.swift
//  ARKitGesture
//
//  Created by Mpalka on 16.03.2018.
//  Copyright © 2018 McPusz. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    private let boxObject = BoxNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.autoenablesDefaultLighting = true
        
        let scene = SCNScene()
        sceneView.scene = scene
        self.setupGestures()
        scene.rootNode.addChildNode(boxObject)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }

}

//MARK: Gestures
extension ViewController: UIGestureRecognizerDelegate {
    func setupGestures() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(pan(_:)))
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotate(_:)))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinch(_:)))
        
        sceneView.addGestureRecognizer(panGesture)
        sceneView.addGestureRecognizer(rotateGesture)
        sceneView.addGestureRecognizer(tapGesture)
        sceneView.addGestureRecognizer(pinchGesture)
        
        tapGesture.delegate = self
        rotateGesture.delegate = self
        panGesture.delegate = self
        pinchGesture.delegate = self
    }
    
    @objc func pan(_ gesture: UIPanGestureRecognizer) {
        let tapPoint = gesture.location(in: sceneView)
        let results = sceneView.hitTest(tapPoint, types: .featurePoint)
        guard let result: ARHitTestResult = results.first else { return }
        let position = SCNVector3Make(result.worldTransform.columns.3.x, result.worldTransform.columns.3.y, result.worldTransform.columns.3.z)
        boxObject.position = position
    }
    
    @objc func rotate(_ gesture: UIRotationGestureRecognizer) {
        let scaleRotation: CGFloat = 1/3
        let roationAngle: Float = Float(gesture.rotation*scaleRotation)
        boxObject.eulerAngles.y -= roationAngle
    }
    
    @objc func tap(_ gesture: UITapGestureRecognizer) {
        boxObject.select()
    }
    
    @objc func pinch(_ gesture: UIPinchGestureRecognizer) {
        let sizeScale = Float(gesture.scale)
        boxObject.scale = SCNVector3Make(sizeScale, sizeScale, sizeScale)
    }
}
