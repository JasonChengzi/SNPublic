//
//  UINavigationBarExtension.swift
//  creams
//
//  Created by Rawlings on 08/12/2016.
//  Copyright © 2016 jiangren. All rights reserved.
//

import UIKit


extension UINavigationBar {
    private struct AssociatedKeys {
        static var overlayKey = "overlayKey"
    }
    
    var overlay: UIView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.overlayKey) as? UIView
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.overlayKey, newValue as UIView?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
}


extension UINavigationBar {
    
    func lt_setBackgroundColor(backgroundColor: UIColor) {
        if overlay == nil{
            guard let superViewOfOverlay = subviews.first else { return }
            setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            let statusBarHeight = UIApplication.shared.statusBarFrame.height
            let overLay = UIView.init()
            overlay = overLay
            overLay.isUserInteractionEnabled = false
            overLay.autoresizingMask = UIViewAutoresizing.flexibleWidth
            overLay.translatesAutoresizingMaskIntoConstraints = false
            superViewOfOverlay.insertSubview(overLay, at: 0)
            let leading = NSLayoutConstraint.init(item: overLay, attribute: .leading, relatedBy: .equal, toItem: superViewOfOverlay, attribute: .leading, multiplier: 1, constant: 0)
            let top = NSLayoutConstraint.init(item: overLay, attribute: .top, relatedBy: .equal, toItem: superViewOfOverlay, attribute: .top, multiplier: 1, constant: -statusBarHeight)
            let trailing = NSLayoutConstraint.init(item: overLay, attribute: .trailing, relatedBy: .equal, toItem: superViewOfOverlay, attribute: .trailing, multiplier: 1, constant: 0)
            let bottom = NSLayoutConstraint.init(item: overLay, attribute: .bottom, relatedBy: .equal, toItem: superViewOfOverlay, attribute: .bottom, multiplier: 1, constant: 0)
            leading.isActive = true
            top.isActive = true
            trailing.isActive = true
            bottom.isActive = true
            superViewOfOverlay.addConstraints([leading,top,trailing,bottom])
        }
        overlay?.backgroundColor = backgroundColor
    }
    
    
    func lt_setTranslationY(translationY: CGFloat) {
        transform = CGAffineTransform.init(translationX: 0, y: translationY)
    }
    
    
    func lt_setElementsAlpha(alpha: CGFloat) {
        for (_, element) in subviews.enumerated() {
            if element.isKind(of: NSClassFromString("UINavigationItemView") as! UIView.Type) ||
                element.isKind(of: NSClassFromString("UINavigationButton") as! UIButton.Type) ||
                element.isKind(of: NSClassFromString("UINavBarPrompt") as! UIView.Type)
            {
                element.alpha = alpha
            }
            
            if element.isKind(of: NSClassFromString("_UINavigationBarBackIndicatorView") as! UIView.Type) {
                element.alpha = element.alpha == 0 ? 0 : alpha
            }
        }
        
        items?.forEach({ (item) in
            if let titleView = item.titleView {
                titleView.alpha = alpha
            }
            for BBItems in [item.leftBarButtonItems, item.rightBarButtonItems] {
                BBItems?.forEach({ (barButtonItem) in
                    if let customView = barButtonItem.customView {
                        customView.alpha = alpha
                    }
                })
            }
        })
    }
    
    
    func lt_reset() {
        setBackgroundImage(nil, for: UIBarMetrics.default)
        overlay?.removeFromSuperview()
        overlay = nil
    }
}
