//
//  ControllerGrid1.swift
//  Instagrid
//
//  Created by Gilles David on 29/06/2021.
//

import UIKit

class  ViewGrid1: UIView {

        // MARK: - Outlets
//    @IBOutlet weak var imageUpLeft: UIButton!
//    @IBOutlet weak var imageUpRight: UIButton!
//    @IBOutlet weak var imageDown: UIButton!
    @IBOutlet weak var imageUpLeft: UIButton!
    
    @IBOutlet var contentView: UIView!
    //    @IBOutlet weak var contentView: NSObject!
    //@IBOutlet private var contentView: UIView!
    
    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    
    
    //MARK: - Action
    private func initialize() {
//        Bundle(for: type(of: self)).loadNibNamed(String(describing: ViewGrid1.self), owner: self, options: nil)
//        addSubview(<#T##view: UIView##UIView#>)
    }
    @IBAction func actionUpLeft(_ sender: Any) {
        
    }
    
    @IBAction func actionUpRight(_ sender: Any) {
        
    }
    
    @IBAction func actionDown(_ sender: Any) {
        
    }
    
    
    
}
