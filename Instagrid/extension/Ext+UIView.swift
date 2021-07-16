//
//  Ext+UIView.swift
//  Instagrid
//
//  Created by Gilles David on 16/07/2021.
//

import UIKit

extension UIView {
    var asImg: UIImage? {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
