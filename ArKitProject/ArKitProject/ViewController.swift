//
//  ViewController.swift
//  ArKitProject
//
//  Created by Safak Yaral on 20.11.2024.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
      
       // let myBox = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.01)
        
        let world = createSphere(radius: 0.1, content: "world.jpeg", vector: SCNVector3(0, 0.2, -1))
        
        let mars = createSphere(radius: 0.2, content: "mars.jpeg", vector: SCNVector3(0.5, 0.2, -1))
        
        let mercury = createSphere(radius: 0.1, content: "mercury.jpeg", vector: SCNVector3(-0.5, 0.2, -1))
        
        sceneView.scene.rootNode.addChildNode(mercury)
        sceneView.scene.rootNode.addChildNode(mars)
        sceneView.scene.rootNode.addChildNode(world)
        
        sceneView.automaticallyUpdatesLighting = true
        
    }
    // bu fonksiyonu oluşturma sebebimiz her bir gezegen için ayrı ayrı tanımlamamak için hepsini 1 fonsiyon ile çağırdık.
    
    func createSphere(radius: CGFloat, content:String, vector:SCNVector3) -> SCNNode {
        
        let mySphere = SCNSphere(radius: radius)
        
        let sphereMetarial = SCNMaterial()
        
        sphereMetarial.diffuse.contents = UIImage(named: "art/\(content)")
        
        mySphere.materials = [sphereMetarial]
        
        let node = SCNNode()
        
        node.position = vector
      
        node.geometry = mySphere
        
        return node
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
        
        for node in sceneView.scene.rootNode.childNodes {
                 
                 let moveShip = SCNAction.moveBy(x: 0, y: 0.5, z: 0.5, duration: 1) //hareketi sağladık
                 let fadeOut = SCNAction.fadeOpacity(to: 0.5, duration: 1) //sönme
                 let fadeIn = SCNAction.fadeOpacity(to: 1, duration: 1) // yanma
                 let sequence = SCNAction.sequence([moveShip, fadeOut, fadeIn])
               
                 let repeatForever = SCNAction.repeatForever(sequence) //sonsuza kadar bu işlem yapılır.
                 
                 node.runAction(moveShip)
             }
        
        
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
