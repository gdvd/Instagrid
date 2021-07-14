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
    var gridNumber: Int = 1
    
    // Button to select grid
    @IBOutlet weak var buttonGrid1: UIButton!
    @IBOutlet weak var buttonGrid2: UIButton!
    @IBOutlet weak var buttonGrid3: UIButton!
    @IBOutlet weak var view0: UIView!
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
    
    // temporary button selected to show image after to use pickerView
    var btn: UIButton?
    var orientationChange = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectGrid()
                
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self        
        
        viewGesture.addGestureRecognizer(createSwipeGestureRecognizer(for: .up))
        viewGesture.addGestureRecognizer(createSwipeGestureRecognizer(for: .left))
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    deinit {
       NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)     
    }
    
    //MARK: - Swipes and Moves
    @objc func rotated() {
        orientationChange = true
        selectGrid()
    }
    
    private func createSwipeGestureRecognizer(for direction: UISwipeGestureRecognizer.Direction) -> UISwipeGestureRecognizer {
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeGestureRecognizer.direction = direction
        return swipeGestureRecognizer
    }
    
    @objc private func didSwipe(_ sender: UISwipeGestureRecognizer) {
        // Landscape
        if (UIDevice.current.orientation.isLandscape && sender.direction == .left) {
            orientationChange = false
            UIView.animate(withDuration: 1.0, animations: {
                self.moveup()
            }, completion: {(finished) in 
                if finished {
                    self.shareView()
                }
            })}
        // Portrait
        if (!UIDevice.current.orientation.isLandscape && (sender.direction == .up)) {
            orientationChange = false
            UIView.animate(withDuration: 1.0, animations: {
                self.moveleft()
            }, completion: {(finished) in 
                if finished {
                    self.shareView()
                }
            })
        }
    }
    private func shareView(){
        let img = view0.asImg
        let avc = UIActivityViewController(activityItems: [img!], applicationActivities: nil)
        
        avc.excludedActivityTypes = [UIActivity.ActivityType.airDrop,
                                     UIActivity.ActivityType.addToReadingList,
//                                     UIActivity.ActivityType.assignToContact,
                                     UIActivity.ActivityType.saveToCameraRoll,
                                     UIActivity.ActivityType.copyToPasteboard
        ]
        
        // Share or cancel
        avc.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            self.viewsBack()
        }
        
        avc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(avc, animated: true)
    }
    
    private func viewsBack(){
        if !orientationChange {
            if UIDevice.current.orientation.isLandscape{
                UIView.animate(withDuration: 1.0, animations: {
                    self.movedown()
                }, completion: {(finished) in 
                    if finished {
                    }
                })
            } else {
                UIView.animate(withDuration: 1.0, animations: {
                    self.moveright()
                }, completion: {(finished) in 
                    if finished {
                    }
                })
            }   
        }
    }
    
    private func moveup(){
        view0.center.x -= UIScreen.main.bounds.height * 2
    }
    
    private func moveleft(){
        view0.center.y -= UIScreen.main.bounds.width * 2
    }
    
    private func movedown(){
        view0.center.x += UIScreen.main.bounds.height * 2
    }
    
    private func moveright(){
        view0.center.y += UIScreen.main.bounds.width * 2
    }
    
    
    // MARK: - Switch viewGrid
    private func selectGrid(){
        switch gridNumber {
        case 1:
            buttonGrid1.imageView!.isHidden = false
            buttonGrid2.imageView!.isHidden = true
            buttonGrid3.imageView!.isHidden = true
            
            view1.isHidden = false
            view2.isHidden = true
            view3.isHidden = true
        case 2:
            buttonGrid1.imageView!.isHidden = true
            buttonGrid2.imageView!.isHidden = false
            buttonGrid3.imageView!.isHidden = true
            
            view1.isHidden = true
            view2.isHidden = false
            view3.isHidden = true
        case 3:
            buttonGrid1.imageView!.isHidden = true
            buttonGrid2.imageView!.isHidden = true
            buttonGrid3.imageView!.isHidden = false
            
            view1.isHidden = true
            view2.isHidden = true
            view3.isHidden = false            
        default:
            print("Error gridNumber?")
        }
    }

    @IBAction func actionButtonGrid1(_ sender: Any) {
        gridNumber = 1
        selectGrid()
    }
    
    @IBAction func actionButtonGrid2(_ sender: Any) {
        gridNumber = 2
        selectGrid()
    }
    
    @IBAction func actionButtonGrid3(_ sender: Any) {
        gridNumber = 3
        selectGrid()
    }
    
    // MARK: - Image picker    
    private func prepareImagePickerController(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if let button = btn {
                button.setBackgroundImage(image, for: .normal)
                btn = nil
            }
            selectGrid()
        }
    }
    
    // MARK: - View1 Action
    @IBAction func actionV1U(_ sender: UIButton) {
        btn = btnV1U
        prepareImagePickerController()
    }
    @IBAction func actionV1DL(_ sender: UIButton) {
        btn = btnV1DL
        prepareImagePickerController()
    }
    @IBAction func actionV1DR(_ sender: UIButton) {
        btn = btnV1DR
        prepareImagePickerController()
    }
    
    // MARK: - View2 Action
    @IBAction func actionV2UL(_ sender: UIButton) {
        btn = btnV2UL
        prepareImagePickerController()
    }
    @IBAction func actionV2UR(_ sender: UIButton) {
        btn = btnV2UR
        prepareImagePickerController()
    }
    @IBAction func actionV2D(_ sender: UIButton) {
        btn = btnV2D
        prepareImagePickerController()
    }
    
    // MARK: - View3 Action
    @IBAction func actionV3UL(_ sender: UIButton) {
        btn = btnV3UL
        prepareImagePickerController()
    }
    @IBAction func actionV3UR(_ sender: UIButton) {
        btn = btnV3UR
        prepareImagePickerController()
    }
    @IBAction func actionV3DL(_ sender: UIButton) {
        btn = btnV3DL
        prepareImagePickerController()
    }
    @IBAction func actionV3DR(_ sender: UIButton) {
        btn = btnV3DR
        prepareImagePickerController()
    }

}

extension UIView {
    var asImg: UIImage? {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
