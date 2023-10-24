//
//  Extensions+UIView.swift
//  StockSimulator
//
//  Created by David Razmadze on 9/29/21.
//  Copyright © 2021 David Razmadze. All rights reserved.
//

import UIKit

// MARK: - UIView

extension UIView {
  func anchor(top: NSLayoutYAxisAnchor? = nil,
              left: NSLayoutXAxisAnchor? = nil,
              bottom: NSLayoutYAxisAnchor? = nil,
              right: NSLayoutXAxisAnchor? = nil,
              paddingTop: CGFloat = 0,
              paddingLeft: CGFloat = 0,
              paddingBottom: CGFloat = 0,
              paddingRight: CGFloat = 0,
              width: CGFloat? = nil,
              height: CGFloat? = nil) {
    
    translatesAutoresizingMaskIntoConstraints = false
    
    if let top = top {
      topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
    }
    
    if let left = left {
      leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
    }
    
    if let bottom = bottom {
      bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
    }
    
    if let right = right {
      rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
    }
    
    if let width = width {
      widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    if let height = height {
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
  }
  
  func center(inView view: UIView, yConstant: CGFloat? = 0) {
    translatesAutoresizingMaskIntoConstraints = false
    centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yConstant!).isActive = true
  }
  
  func centerX(inView view: UIView, topAnchor: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat? = 0) {
    translatesAutoresizingMaskIntoConstraints = false
    centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
    if let topAnchor = topAnchor {
      self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop!).isActive = true
    }
  }
  
  func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil, paddingLeft: CGFloat? = nil, constant: CGFloat? = 0) {
    translatesAutoresizingMaskIntoConstraints = false
    
    centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant!).isActive = true
    
    if let leftAnchor = leftAnchor, let padding = paddingLeft {
      self.leftAnchor.constraint(equalTo: leftAnchor, constant: padding).isActive = true
    }
  }
    
    func removeallContrains(){
        for i in self.constraints{
            if i.isActive {
                removeConstraint(i)
            }
        }
    }
  
  func setDimensions(width: CGFloat, height: CGFloat) {
    translatesAutoresizingMaskIntoConstraints = false
    widthAnchor.constraint(equalToConstant: width).isActive = true
    heightAnchor.constraint(equalToConstant: height).isActive = true
  }
  
  func addConstraintsToFillView(_ view: UIView) {
    translatesAutoresizingMaskIntoConstraints = false
    anchor(top: view.topAnchor, left: view.leftAnchor,
           bottom: view.bottomAnchor, right: view.rightAnchor)
  }
  
  func pinTo(_ view: UIView) {
    translatesAutoresizingMaskIntoConstraints = false
    heightAnchor.constraint(equalToConstant: 50).isActive = true
    leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12).isActive = true
  }
  
}

// This will allow alert action to be at bottom, rather then any where else
class MyBetterAlertController : UIAlertController {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let screenBounds = UIScreen.main.bounds

        if (preferredStyle == .actionSheet) {
            self.view.center = CGPointMake(screenBounds.size.width*0.5, screenBounds.size.height - (self.view.frame.size.height*0.5) - 8)
        } else {
            self.view.center = CGPointMake(screenBounds.size.width*0.5, screenBounds.size.height*0.5)
        }
    }
}
