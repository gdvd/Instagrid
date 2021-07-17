//
//  ViewController.swift
//  Instagrid
//
//  Created by Gilles David on 27/06/2021.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet private weak var viewGesture: UIView!
    var imagePicker: UIImagePickerController!
    private var gridNumber: Int = 1
    
    // Button to select grid
    @IBOutlet private weak var buttonGrid1: UIButton!
    @IBOutlet private weak var buttonGrid2: UIButton!
    @IBOutlet private weak var buttonGrid3: UIButton!
    @IBOutlet private weak var view0: UIView!
    @IBOutlet private weak var view1: UIView!
    @IBOutlet private weak var view2: UIView!
    @IBOutlet private weak var view3: UIView!
    
    // View1 Outlets
    @IBOutlet private weak var btnV1U: UIButton!
    @IBOutlet private weak var btnV1DL: UIButton!
    @IBOutlet private weak var btnV1DR: UIButton!
    
    // View2 Outlets
    @IBOutlet private weak var btnV2UL: UIButton!
    @IBOutlet private weak var btnV2UR: UIButton!
    @IBOutlet private weak var btnV2D: UIButton!
    
    // View3 Outlets
    @IBOutlet private weak var btnV3UL: UIButton!
    @IBOutlet private weak var btnV3UR: UIButton!
    @IBOutlet private weak var btnV3DL: UIButton!
    @IBOutlet private weak var btnV3DR: UIButton!
    
    // temporary button selected to show image after to use pickerView
    private var btnSelected: UIButton?
    private var orientationChange = true
    
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
    
    // When imagePicker goes out, the grid must return
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
        view0.center.x -= UIScreen.main.bounds.width
    }
    
    private func moveleft(){
        view0.center.y -= UIScreen.main.bounds.height
    }
    
    private func movedown(){
        view0.center.x += UIScreen.main.bounds.width
    }
    
    private func moveright(){
        view0.center.y += UIScreen.main.bounds.height    
        
    }
    
    
    // MARK: - Switch viewGrid
    private func selectGrid(){
        switch gridNumber {
        case 1:
            buttonGrid1.imageView?.isHidden = false
            buttonGrid2.imageView?.isHidden = true
            buttonGrid3.imageView?.isHidden = true
            
            view1.isHidden = false
            view2.isHidden = true
            view3.isHidden = true
        case 2:
            buttonGrid1.imageView?.isHidden = true
            buttonGrid2.imageView?.isHidden = false
            buttonGrid3.imageView?.isHidden = true
            
            view1.isHidden = true
            view2.isHidden = false
            view3.isHidden = true
        case 3:
            buttonGrid1.imageView?.isHidden = true
            buttonGrid2.imageView?.isHidden = true
            buttonGrid3.imageView?.isHidden = false
            
            view1.isHidden = true
            view2.isHidden = true
            view3.isHidden = false            
        default:
            print("Error gridNumber?")
        }
    }
    
    @IBAction func selectOneGrid(_ sender: UIButton) {
        gridNumber = sender.tag
        selectGrid()
    }
    
    // MARK: - Image picker    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            if let button = btnSelected {
                button.setBackgroundImage(image, for: .normal)
                btnSelected = nil
            }
            selectGrid()
        }
    }
    
    @IBAction func actionButtonClicked(_ sender: UIButton) {
        btnSelected = sender
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
}


