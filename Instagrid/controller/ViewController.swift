//
//  ViewController.swift
//  Instagrid
//
//  Created by Gilles David on 27/06/2021.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var viewGesture: UIView!
    var imagePicker: UIImagePickerController!
    
    // Button to select grid
    @IBOutlet weak var buttonGrid1: UIButton!
    @IBOutlet weak var buttonGrid2: UIButton!
    @IBOutlet weak var buttonGrid3: UIButton!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    // View1 Outlets
    @IBOutlet weak var btnV1U: UIButton!
    @IBOutlet weak var btnV1DL: UIButton!
    @IBOutlet weak var btnV1DR: UIButton!
    
    // View2 Outlets
    @IBOutlet weak var btnV2UL: UIButton!
    @IBOutlet weak var btnV2UR: UIButton!
    @IBOutlet weak var btnV2D: UIButton!
    
    // View3 Outlets
    @IBOutlet weak var btnV3UL: UIButton!
    @IBOutlet weak var btnV3UR: UIButton!
    @IBOutlet weak var btnV3DL: UIButton!
    @IBOutlet weak var btnV3DR: UIButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        buttonGrid1.imageView!.isHidden = false
        buttonGrid2.imageView!.isHidden = true
        buttonGrid3.imageView!.isHidden = true
        
        view1.isHidden = false
        view2.isHidden = true
        view3.isHidden = true
                
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self        
        
        viewGesture.addGestureRecognizer(createSwipeGestureRecognizer(for: .up))
        viewGesture.addGestureRecognizer(createSwipeGestureRecognizer(for: .right))
    }
    
    private func createSwipeGestureRecognizer(for direction: UISwipeGestureRecognizer.Direction) -> UISwipeGestureRecognizer {
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeGestureRecognizer.direction = direction
        return swipeGestureRecognizer
    }
    
    @objc private func didSwipe(_ sender: UISwipeGestureRecognizer) {
        // If Landscape
        if (UIDevice.current.orientation.isLandscape && sender.direction.rawValue == 2) {
            print("Landscape", sender.direction, UIDevice.current.orientation.isLandscape)
        } 
        // If Portrait
        if (!UIDevice.current.orientation.isLandscape && (sender.direction.rawValue == 4)) {
            print("Portrait", sender.direction, UIDevice.current.orientation.isLandscape)
        }
    }
    
    @IBAction func actionButtonGrid1(_ sender: Any) {
        buttonGrid1.imageView!.isHidden = false
        buttonGrid2.imageView!.isHidden = true
        buttonGrid3.imageView!.isHidden = true
        
        view1.isHidden = false
        view2.isHidden = true
        view3.isHidden = true
    }
    
    @IBAction func actionButtonGrid2(_ sender: Any) {
        buttonGrid1.imageView!.isHidden = true
        buttonGrid2.imageView!.isHidden = false
        buttonGrid3.imageView!.isHidden = true
        
        view1.isHidden = true
        view2.isHidden = false
        view3.isHidden = true
    }
    
    @IBAction func actionButtonGrid3(_ sender: Any) {
        buttonGrid1.imageView!.isHidden = true
        buttonGrid2.imageView!.isHidden = true
        buttonGrid3.imageView!.isHidden = false
        
        view1.isHidden = true
        view2.isHidden = true
        view3.isHidden = false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            btnV1U.setBackgroundImage(image, for: .normal)
        }
    }

    // View1 Action
    @IBAction func actionV1U(_ sender: Any) {
        print("A que coucou actionV1U")
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    @IBAction func actionV1DL(_ sender: Any) {
        print("A que coucou actionV1DL")
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    @IBAction func actionV1DR(_ sender: Any) {
        print("A que coucou actionV1DR")
    }
    
    // View2 Action
    @IBAction func actionV2UL(_ sender: Any) {
        print("A que coucou actionV2UL")
    }
    @IBAction func actionV2UR(_ sender: Any) {
        print("A que coucou actionV2UR")
    }
    @IBAction func actionV2D(_ sender: Any) {
        print("A que coucou actionV2D")
    }
    
    // View3 Action
    @IBAction func actionV3UL(_ sender: Any) {
        print("A que coucou actionV3UL")
    }
    @IBAction func actionV3UR(_ sender: Any) {
        print("A que coucou actionV3UR")
    }
    @IBAction func actionV3DL(_ sender: Any) {
        print("A que coucou actionV3DL")
    }
    @IBAction func actionV3DR(_ sender: Any) {
        print("A que coucou actionV3DR")
    }
    

}

