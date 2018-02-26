//
//  AppHelper.swift
//  The Ocean
//
//  Created by Hameleonlab on 10.08.17.
//  Copyright © 2017 Hameleonlab. All rights reserved.
//

import UIKit

struct AppHelper {
    
    /****************** ActivityIndicator *********************/
    
    static func showActivityIndicator(view: UIView, withOpaqueOverlay: Bool) {
        
        // this will be the alignment view for the activity indicator
        var superView: UIView = view
        
        // if we want an opaque overlay, do that work first then put the activity indicator within that view; else just use the passed UIView to center it
        if withOpaqueOverlay {
            let overlay = UIView()
            overlay.frame = CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: view.frame.height)
            overlay.layer.backgroundColor = UIColor.lightGray.cgColor
            overlay.alpha = 0.7
            overlay.tag = 999012
            
            overlay.center = superView.center
            overlay.isHidden = false
            superView.addSubview(overlay)
            superView.bringSubview(toFront: overlay)
            
            // now we'll work on adding the indicator to the overlay (now superView)
            superView = overlay
        }
        
        let indicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        
        indicator.center = superView.center
        indicator.tag = 999011
        indicator.isHidden = false
        
        superView.addSubview(indicator)
        superView.bringSubview(toFront: indicator)
        
        indicator.startAnimating()
        
        // also indicate network activity in the status bar
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    static func hideActivityIndicator(view: UIView) {
        
        // stop the network activity animation in the status bar
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        // remove the activity indicator and optional overlay views
        view.viewWithTag(999011)?.removeFromSuperview()
        view.viewWithTag(999012)?.removeFromSuperview()
    }

}


