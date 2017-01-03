//
//  Alerta.swift
//  upcomingMoviesMobile
//
//  Created by Bruno on 29/12/16.
//  Copyright © 2016 Bruno. All rights reserved.
//

import Foundation
import UIKit

public class AlertMessage{
    
    
    static func showAlert(title : String, message : String, view : UIViewController){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        
        let okButton = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
        
        alert.addAction(okButton)
        
        view.present(alert, animated: true, completion: nil)
    }
    
}
