//
//  Indicator.swift
//  SQLIQUIZ
//
//  Created by OUSSAMA BENNOUR EL FAHSI on 02/1/2023.
//

import Foundation
import UIKit

public class Indicator {

    public static let sharedInstance = Indicator()
    var blurImg = UIImageView()
    var indicator = UIActivityIndicatorView()

    private init()
    {
        blurImg.frame = UIScreen.main.bounds
        blurImg.backgroundColor = UIColor.black
        blurImg.isUserInteractionEnabled = true
        blurImg.alpha = 0.5
        indicator.style = .large
        indicator.center = blurImg.center
        indicator.startAnimating()
        indicator.color = .white
    }

    func showIndicator(){
        DispatchQueue.main.async( execute: {
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let _ = windowScene.windows.first {
                
                windowScene.windows.first{ $0.isKeyWindow }?.addSubview(self.blurImg)
                windowScene.windows.first{ $0.isKeyWindow }?.addSubview(self.indicator)
                // do something with window
            }
        
        })
    }
    func hideIndicator(){

        DispatchQueue.main.async( execute:
            {
                self.blurImg.removeFromSuperview()
                self.indicator.removeFromSuperview()
        })
    }
}

