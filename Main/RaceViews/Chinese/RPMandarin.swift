//
//  File.swift
//  Culturify
//
//  Created by Jatin Rakesh on 20/3/25.
//
import UIKit
import RealityKit
import ARKit

class RPMViewController: UIViewController, @preconcurrency ARSessionDelegate  {
    
    var arView: ARView!
    var label: UILabel!
    var activityIndicator: UIActivityIndicatorView!
    var hasPlacedItems = false
    var textUpdateTimer: Timer?
    var currentIndex = 0
    var actionButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize ARView
        arView = ARView(frame: self.view.frame)
        self.view.addSubview(arView)
        
        // Add label
        label = UILabel()
        label.text = "Find a flat surface"
        label.textColor = .white
        label.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating() // Start the spinner
        self.view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            //            label2.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30),
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            label.widthAnchor.constraint(equalToConstant: 250),
            label.heightAnchor.constraint(equalToConstant: 50),
            activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                activityIndicator.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20)
            
        ])
        
        // Configure AR session with plane detection
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        arView.session.run(config)
        
        // Set AR session delegate
        arView.session.delegate = self
        
        // Add tap gesture recognizer
    }
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        guard !hasPlacedItems else { return } // Ensure only one Mooncake is placed
        
        for anchor in anchors {
            if let planeAnchor = anchor as? ARPlaneAnchor {
                // Update label to indicate that the plane was found
                label.text = "Plane detected!"
                activityIndicator.isHidden = true
                // Place the Mooncake automatically on the detected plane
                if let rp = createRP(), let mandarin = createMandarins() {
                    let worldPos = simd_make_float3(planeAnchor.transform.columns.3)
                    placeObject(object: rp, at: worldPos)
                    let mandarinOffset = SIMD3<Float>(0, -0.1, 0.1) // Offset in the x-axis (adjust as needed)
                    placeObject(object: mandarin, at: worldPos + mandarinOffset)
                    
                    hasPlacedItems = true // Prevent further placements
                } else {
                    print("Failed to load Mooncake model")
                }
            }
        }
    }
    
    
    func createRP() -> ModelEntity? {
        guard let redPacketModel = try? Entity.loadModel(named: "RedPacket") else {
            print("Failed to load Mooncake model")
            return nil
        }
        redPacketModel.generateCollisionShapes(recursive: true)
        redPacketModel.scale = SIMD3<Float>(0.001, 0.001, 0.001)
        return redPacketModel
    }
    func createMandarins() -> ModelEntity? {
        guard let mandarinModel = try? Entity.loadModel(named: "Mandarin") else {
            print("Failed to load Star model")
            return nil
        }
        mandarinModel.generateCollisionShapes(recursive: true)
        mandarinModel.scale = SIMD3<Float>(0.01, 0.01, 0.01)
        return mandarinModel
    }
    func placeObject(object: ModelEntity, at location: SIMD3<Float>) {
        let objectAnchor = AnchorEntity(world: location)
        objectAnchor.addChild(object)
        arView.scene.addAnchor(objectAnchor)
    }
    
}
