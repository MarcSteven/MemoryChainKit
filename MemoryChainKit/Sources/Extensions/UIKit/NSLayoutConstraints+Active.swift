//
//  NSLayoutConstraints+Active.swift
//  MemoryChain
//
//  Created by Marc Zhao on 2018/8/4.
//  Copyright © 2018年 Memory Chain technology(China) co,LTD. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    @discardableResult func activate() ->NSLayoutConstraint {
        isActive = true
        return self 
    }
    }
//MARK: NSLayoutConstraint Convenience methods
public extension NSLayoutConstraint {
  
  // Pins an attribute of a view to an attribute of another view
  static func pinning(view: UIView, attribute: NSLayoutConstraint.Attribute, toView: UIView?, toAttribute: NSLayoutConstraint.Attribute, multiplier: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
    return NSLayoutConstraint(item: view, attribute: attribute, relatedBy: .equal, toItem: toView, attribute:toAttribute, multiplier: multiplier, constant: constant)
  }
  
  // Pins an array of NSLayoutAttributes of a view to a specific view (has to respect view tree hierarchy)
  static func pinning(view: UIView, toView: UIView?, attributes: [NSLayoutConstraint.Attribute], multiplier: CGFloat, constant: CGFloat) -> [NSLayoutConstraint] {
    return attributes.compactMap({ (attribute) -> NSLayoutConstraint in
      return NSLayoutConstraint(item: view, attribute: attribute, relatedBy: .equal, toItem: toView, attribute: attribute, multiplier: multiplier, constant: constant)
    })
  }
  
  // Pins bottom, top, leading and trailing of a view to a specific view (has to respect view tree hierarchy)
  static func pinningEdges(view: UIView, toView: UIView?) -> [NSLayoutConstraint] {
    let attributes: [NSLayoutConstraint.Attribute] = [.top, .bottom, .leading, .trailing]
    return NSLayoutConstraint.pinning(view: view, toView: toView, attributes: attributes, multiplier: 1.0, constant: 0.0)
  }
  
  // Pins bottom, top, leading and trailing of a view to its superview
  static func pinningEdgesToSuperview(view: UIView) -> [NSLayoutConstraint] {
    return NSLayoutConstraint.pinningEdges(view: view, toView: view.superview)
  }
  
  // Pins specified attribute to superview with specified or default multiplier and constant
  static func pinningToSuperview(view: UIView, attributes: [NSLayoutConstraint.Attribute], multiplier: CGFloat, constant: CGFloat) -> [NSLayoutConstraint] {
    return NSLayoutConstraint.pinning(view: view, toView: view.superview, attributes: attributes, multiplier: multiplier, constant: constant)
  }
}

