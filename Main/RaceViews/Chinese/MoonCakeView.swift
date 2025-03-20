import UIKit
import RealityKit
import ARKit

class ViewController: UIViewController, @preconcurrency ARSessionDelegate  {
    
    var arView: ARView!
    var label: UILabel!
    var hasPlacedMooncake = false
    var textUpdateTimer: Timer?
    var currentIndex = 0
    var actionButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        arView = ARView(frame: self.view.frame)
        self.view.addSubview(arView)
        
        
        label = UILabel()
        label.text = "Find a flat surface!"
        label.textColor = .white
        label.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            label.widthAnchor.constraint(equalToConstant: 250),
            label.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
      
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        arView.session.run(config)
        
        arView.session.delegate = self
    }
    
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            guard !hasPlacedMooncake else { return }
            
            for anchor in anchors {
                if let planeAnchor = anchor as? ARPlaneAnchor {
                   
                    label.text = "Plane detected! Placing Mooncake..."
                    
                    if let mooncake = createMoonCake() {
                        let worldPos = simd_make_float3(planeAnchor.transform.columns.3) 
                        placeObject(object: mooncake, at: worldPos)
                        hasPlacedMooncake = true
                    } else {
                        print("Failed to load Mooncake model")
                    }
                }
            }
        }
    
    
    func createMoonCake() -> ModelEntity? {
        guard let moonCakeModel = try? Entity.loadModel(named: "Mooncake") else {
            print("Failed to load Mooncake model")
            return nil
        }
        moonCakeModel.generateCollisionShapes(recursive: true)
        
        return moonCakeModel
    }
    
    func placeObject(object: ModelEntity, at location: SIMD3<Float>) {
        let objectAnchor = AnchorEntity(world: location)
        objectAnchor.addChild(object)
        arView.scene.addAnchor(objectAnchor)
    }

}
