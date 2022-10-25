//
//  GradientView.swift
//  BluetoothLib
//
//  Created by Marc Steven on 2022/10/25.
//

import UIKit

public class GradientView: UIView {

    public var isShowingGradient:Bool = true {
        didSet {
            gradientLayer.isHidden = !isShowingGradient
        }
    }
    let gradientLayer:CAGradientLayer
    
    public init(colors: [UIColor]) {
        self.gradientLayer = .init()
        self.gradientLayer.colors = colors.map({$0.cgColor })
        super.init(frame: .zero)
        setupViews()
    }
    required public init?(coder aDecoder:NSCoder)  {
        fatalError("init(coder:) has not been implement")
    }
    public override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    

}
fileprivate extension GradientView {
    func setupViews() {
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

public extension GradientView {
    func setGradientColors(_ colors: [UIColor]?, locations: [NSNumber]? = nil, animated: Bool, animationDuration: Double = 0.3) {
        guard let colors = colors else {
          gradientLayer.colors = nil
          gradientLayer.locations = nil
          return
        }
        
        guard animated else {
          gradientLayer.colors = colors.map { $0.cgColor }
          gradientLayer.locations = locations
          return
        }
        
        let gradientColorsChangeAnimation = CABasicAnimation(keyPath: "colors")
        gradientColorsChangeAnimation.duration = animationDuration
        gradientColorsChangeAnimation.toValue = colors.map { $0.cgColor }
        gradientColorsChangeAnimation.fillMode = CAMediaTimingFillMode.forwards
        gradientColorsChangeAnimation.isRemovedOnCompletion = false
        gradientLayer.add(gradientColorsChangeAnimation, forKey: "colorChange")
        
        let gradientLocationsChangeAnimation = CABasicAnimation(keyPath: "locations")
        gradientLocationsChangeAnimation.duration = animationDuration
        gradientLocationsChangeAnimation.toValue = locations
        gradientLocationsChangeAnimation.fillMode = CAMediaTimingFillMode.forwards
        gradientLocationsChangeAnimation.isRemovedOnCompletion = false
        gradientLayer.add(gradientLocationsChangeAnimation, forKey: "locationsChange")
      }
      
      func setLocations(locations: [NSNumber]) {
        gradientLayer.locations = locations
      }
      
      func setGradient(startPoint: CGPoint, endPoint: CGPoint) {
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
      }
}
