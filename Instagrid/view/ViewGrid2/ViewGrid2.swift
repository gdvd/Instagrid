//
//  ViewGrid2.swift
//  Instagrid
//
//  Created by Gilles David on 29/06/2021.
//

import UIKit

class ViewGrid2: UIView {
    
    @IBOutlet weak var buttonUp: UIButton!
    @IBOutlet weak var buttonDownLeft: UIButton!
    @IBOutlet weak var buttonDownRight: UIButton!
    
    
    
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
//        Bundle(for: type(of: self)).loadNibNamed(String(describing: ViewGrid2.self), owner: self, options: nil)
//        addSubview(self)
//        self.frame = bounds
//        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    @IBAction func actionButtonUp(_ sender: Any) {
        print("A que coucou ViewGrid2 1")
    }
    
    @IBAction func actionButtonDownLeft(_ sender: Any) {
        print("A que coucou ViewGrid2 2")
    }
    
    @IBAction func actionButtonDownRight(_ sender: Any) {
        print("A que coucou ViewGrid2 3")
    }
    
    
}
