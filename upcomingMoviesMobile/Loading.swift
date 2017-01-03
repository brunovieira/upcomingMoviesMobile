//
//  Loading.swift
//  upcomingMoviesMobile
//
//  Created by Bruno on 29/12/16.
//  Copyright © 2016 Bruno. All rights reserved.
//

import Foundation
import UIKit

class Loading : UIActivityIndicatorView{
    
    init(view : UIView) {
        let frameRect =  CGRect(origin: CGPoint(x: 100,y :100), size: CGSize(width: view.frame.size.width, height: view.frame.size.height))
        
        super.init(frame : frameRect)
        super.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        super.backgroundColor = UIColor(white: 0.6, alpha: 0.5) ;
        super.center = view.center
        view.addSubview(self)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
