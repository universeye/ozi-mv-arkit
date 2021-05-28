//
//  ViewController.swift
//  oziPinkInkAR
//
//  Created by Terry Kuo on 2021/2/16.
//

import UIKit
import SceneKit
import SpriteKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Ozi PinkInk Cover", bundle: Bundle.main) {
            
            configuration.detectionImages = imageToTrack
            configuration.maximumNumberOfTrackedImages = 1
            
            print("Ozi Image detected Success")
            
        }
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            
            let videoNode = SKVideoNode(fileNamed: "ozipinkinkcover.mp4")
            
            videoNode.play()
            
            let videoScene = SKScene(size: CGSize(width: 1080, height: 720))
            
            videoNode.position = CGPoint(x: videoScene.size.width / 2, y: videoScene.size.height / 2)
            
            videoNode.yScale = -1.0
            videoNode.zRotation = CGFloat(-Double.pi) * 90 / 180
            
            videoScene.addChild(videoNode)
            
            let plane = SCNPlane(
                width: imageAnchor.referenceImage.physicalSize.width,
                height: imageAnchor.referenceImage.physicalSize.height )
            
            plane.firstMaterial?.diffuse.contents = videoScene
            
            let planeNode = SCNNode()
            
            planeNode.geometry = plane
            
            planeNode.eulerAngles.x = -Float.pi / 2
            
            node.addChildNode(planeNode)
            
            
            
        }
        return node
    }
    
}
