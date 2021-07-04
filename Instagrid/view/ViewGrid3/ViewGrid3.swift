//
//  ViewGrid3.swift
//  Instagrid
//
//  Created by Gilles David on 29/06/2021.
//

import UIKit

class ViewGrid3: UIView {
    
    @IBOutlet weak var imageUpLeft: UIButton!
    @IBOutlet weak var imageUpRight: UIButton!
    @IBOutlet weak var imageDownLeft: UIButton!
    @IBOutlet weak var imageDownRight: UIButton!
    
    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
//        Bundle(for: type(of: self)).loadNibNamed(String(describing: ViewGrid3.self), owner: self, options: nil)
//        addSubview(self)
//        self.frame = bounds
//        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    @IBAction func actionButtonUpLeft(_ sender: Any) {
        
    }
    
    @IBAction func actionButtonUpRight(_ sender: Any) {
        
    }
    
    @IBAction func actionButtonDownLeft(_ sender: Any) {
        
    }
    
    @IBAction func actionButtonDownRight(_ sender: Any) {
        
    }
    
}
