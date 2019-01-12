//
//  MeasureShoeViewController.swift
//  Proyecto
//
//  Created by Edgar Barragan on 12/28/18.
//  Copyright © 2018 Edgar Barragan. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class MeasureShoeViewController:UIViewController, ARSCNViewDelegate{
    @IBOutlet var scnView: ARSCNView!
    
    @IBOutlet weak var lblMeasurementDetails : UILabel!
    
    //var nodes: [SCNNode] = []
    
    var nodes: [SphereNode] = []

    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScene()
        self.tabBarController?.tabBar.isHidden = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapRecognizer.numberOfTapsRequired = 1
        scnView.addGestureRecognizer(tapRecognizer)
    }

    func setupScene(){
        let scene = SCNScene()
        self.scnView.delegate = self
        self.scnView.showsStatistics = false
        self.scnView.automaticallyUpdatesLighting = true
        //self.scnView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.scnView.scene = scene
    }

    func setupARSession(){
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        scnView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        setupARSession()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Pause the view's session
        //self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.tabBarController?.tabBar.isHidden = false
        
    }

    
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        print("Estado de la Camara: \(camera.trackingState)")
        switch camera.trackingState {
        case .normal:
            self.lblMeasurementDetails.text  = "Ready to measure "
        default:
            self.lblMeasurementDetails.text  = "Loading ..."
        }
        
    }
    
    var startNode: SCNNode?
    var distance: Double?
    
    // MARK: Gesture handlers
    @objc func handleTap(sender: UITapGestureRecognizer) {
        
        
        
        if nodes.count == 2 {
           cleanAllNodes()
        }
        
        //let tapLocation = self.scnView.center// Get the center point, of the SceneView.
        
        let tapLocation = sender.location(in: scnView)
        
        let hitTestResults = scnView.hitTest(tapLocation, types:.featurePoint)

        if let result = hitTestResults.first {
            let position = SCNVector3.positionFrom(matrix: result.worldTransform)
//            let sphere = SCNSphere(color: UIColor.init(red: 0.4, green: 0.3, blue: 0.6, alpha: 1.0), radius: 0.005)
//            let node = SCNNode(geometry: sphere)
            
            let sphere = SphereNode(position: position)
            scnView.scene.rootNode.addChildNode(sphere)
            let lastNode = nodes.last
            nodes.append(sphere)

            // Setting our starting point for drawing a line in real time
            self.startNode = nodes.first

            if lastNode != nil {
                // If there is 2 nodes or more
                if nodes.count >= 2 {
                    // Create a node line between the nodes
//                    let measureLine = LineNode(from: (lastNode?.position)!,
//                                               to: node.position, lineColor: self.nodeColor)
                    
                    let measureLine = SCNNode.createLineNode(fromNode: (lastNode)!, toNode: sphere, andColor: UIColor.green)
                    
                    
                    measureLine.name = "measureLine"
                    // Add the Node to the scene.
                    scnView.scene.rootNode.addChildNode(measureLine)
                }

                self.distance = Double(lastNode!.position.distance(to: sphere.position)) * 100
                print( String(format: "Distance between nodes:  %.2f cm", self.distance!))
                
                self.lblMeasurementDetails.text = String(format: "Distance between nodes:  %.2f cm", self.distance!)
                //presentShoeSizes(distance: self.distance)
            }
        }
        
        
//        let tapLocation = sender.location(in: scnView)
//        let hitTestResults = scnView.hitTest(tapLocation, types: .featurePoint)
//
//
//        if let result = hitTestResults.first {
//            if nodes.count == 2 {
//                cleanAllNodes()
//            }
//            let position = SCNVector3.positionFrom(matrix: result.worldTransform)
//            let sphere = SphereNode(position: position)
//            scnView.scene.rootNode.addChildNode(sphere)
//            let lastNode = nodes.last
//            nodes.append(sphere)
//            if lastNode != nil {
//                let distance = lastNode!.position.distance(to: sphere.position)
//                //infoLabel.text = String(format: "Distance: %.2f meters", distance)
//                print(distance)
//
//
//            }
//        }
    }
    
    
    func cleanAllNodes() {
        
        //Clean nodes array
        if nodes.count != 0 {
            for node in nodes {
                node.removeFromParentNode()
            }
            
            //clean measureLine
            for node in scnView.scene.rootNode.childNodes {
                if node.name == "measureLine" {
                    node.removeFromParentNode()
                }
            }
            nodes = []
        }
    }
    
    
}


extension SCNVector3{
    func distance(to destination: SCNVector3) -> CGFloat {
        let dx = destination.x - x
        let dy = destination.y - y
        let dz = destination.z - z
        return CGFloat(sqrt(dx*dx + dy*dy + dz*dz))
    }
    
    static func positionFrom(matrix: matrix_float4x4) -> SCNVector3 {
    let column = matrix.columns.3
    return SCNVector3(column.x, column.y, column.z)
    }
}


extension SCNNode {
    static func createLineNode(fromNode: SCNNode, toNode: SCNNode, andColor color: UIColor) -> SCNNode {
    let line = lineFrom(vector: fromNode.position, toVector: toNode.position)
    let lineNode = SCNNode(geometry: line)
    let planeMaterial = SCNMaterial()
    planeMaterial.diffuse.contents = color
    line.materials = [planeMaterial]
    return lineNode
    }
    
    static func lineFrom(vector vector1: SCNVector3, toVector vector2: SCNVector3) -> SCNGeometry {
    let indices: [Int32] = [0, 1]
    let source = SCNGeometrySource(vertices: [vector1, vector2])
    let element = SCNGeometryElement(indices: indices, primitiveType: .line)
    return SCNGeometry(sources: [source], elements: [element])
    }
}
