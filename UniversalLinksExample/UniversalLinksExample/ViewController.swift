//
//  ViewController.swift
//  UniversalLinksExample
//
//  Created by Caio Brigagão Lunardi on 18/01/2019.
//  Copyright © 2019 Caio Brigagão Lunardi. All rights reserved.
//

import UIKit
import CoreGraphics

class ViewController: UIViewController {
    private weak static var shared: ViewController?
    private static var link: String?

    @IBOutlet private var label: UILabel!
    
    private var color1: CGColor!
    private var color2: CGColor!
    private var currentGradienLayer: CALayer?
    
    static func configure(link: String?) {
        ViewController.link = link
        guard let controller = ViewController.shared else {
            return
        }
        controller.configure()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        ViewController.shared = self
        ViewController.configure(link: ViewController.link)
    }
    
    private func configure() {
        if let link = ViewController.link {
            label.text = "We have an Universal Link\n\(link)"
            color1 = UIColor(displayP3Red: 68 / 255, green: 233 / 255, blue: 150 / 255, alpha: 1.0).cgColor
            color2 = UIColor(displayP3Red: 10 / 255, green: 82 / 255, blue: 46 / 255, alpha: 1.0).cgColor
        } else {
            label.text = "No Universal Link"
            color1 = UIColor(displayP3Red: 203 / 255, green: 48 / 255, blue: 48 / 255, alpha: 1.0).cgColor
            color2 = UIColor(displayP3Red: 82 / 255, green: 10 / 255, blue: 10 / 255, alpha: 1.0).cgColor
        }
        
        currentGradienLayer?.removeFromSuperlayer()
        currentGradienLayer = animatedGradient()
        view.layer.insertSublayer(currentGradienLayer!, at: 0)
    }
    
    private func animatedGradient() -> CALayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.type = .axial
        gradientLayer.colors = [ color1, color2 ]
        
        let leadingAxisAnimation = CABasicAnimation(keyPath: "startPoint")
        leadingAxisAnimation.fromValue = CGPoint(x: 0, y: 0)
        leadingAxisAnimation.toValue = CGPoint(x: 0, y: 1)
        leadingAxisAnimation.beginTime = CACurrentMediaTime()
        leadingAxisAnimation.duration = 3.0
        leadingAxisAnimation.isRemovedOnCompletion = false
        leadingAxisAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        leadingAxisAnimation.fillMode = .forwards
        leadingAxisAnimation.autoreverses = true
        gradientLayer.add(leadingAxisAnimation, forKey: nil)
        
        let trailingAxisAnimation = CABasicAnimation(keyPath: "endPoint")
        trailingAxisAnimation.fromValue = CGPoint(x: 1, y: 1)
        trailingAxisAnimation.toValue = CGPoint(x: 1, y: 0)
        trailingAxisAnimation.beginTime = CACurrentMediaTime()
        trailingAxisAnimation.duration = 5.0
        trailingAxisAnimation.autoreverses = true
        trailingAxisAnimation.isRemovedOnCompletion = false
        trailingAxisAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        trailingAxisAnimation.fillMode = .forwards
        gradientLayer.add(trailingAxisAnimation, forKey: nil)

        let colorsAnimation = CABasicAnimation(keyPath: "colors")
        colorsAnimation.fromValue = [ color1, color2 ]
        colorsAnimation.toValue = [ color2, color1 ]
        colorsAnimation.beginTime = CACurrentMediaTime()
        colorsAnimation.duration = 8.0
        colorsAnimation.autoreverses = true
        colorsAnimation.isRemovedOnCompletion = false
        colorsAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        colorsAnimation.fillMode = .forwards
        gradientLayer.add(colorsAnimation, forKey: nil)

        return gradientLayer
    }


}

