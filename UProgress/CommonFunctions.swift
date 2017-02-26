//
//  CommonFunctions.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 30.01.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

struct CommonFunctions {
    static func customizeTextField(field: UITextField!, placeholder: String!, image: String!) {
        field.backgroundColor = UIColor.clear
//        let str = NSAttributedString(string: placeholder, attributes: [NSForegroundColorAttributeName:Constants.Colors.authViewPlaceholder])
        field.layer.masksToBounds = true
        field.placeholder = placeholder
        field.leftViewMode = UITextFieldViewMode.always
        var image = UIImage(named: image)
        var resizedImage = self.resizeImage(image: image!, targetSize: CGSize(width: 30.0, height: 30.0))
        field.leftView = UIImageView(image: resizedImage)
        field.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 18.0)
    }
    
    static func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: newSize.width, height: newSize.height))
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    static func avatarImage(imageView: UIImageView!, url: String?) {
        if let avatarUrl =  url {
            Alamofire.request(avatarUrl).responseImage{ response in
                if let image = response.result.value {
                    imageView.layer.cornerRadius = imageView.frame.size.width / 2
                    imageView.clipsToBounds = true
                    imageView.layer.borderWidth = 1
                    imageView.image = image
                }
            }
        }
        else {
            imageView.image = UIImage(named: "empty_user")
        }
    }
    
    static func avatarImage(imageView: UIImageView!, image: UIImage!) {
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.image = image
    }
    
    static func fromStoryboard(name: String!, identifier: String! ) -> UIViewController {
        return UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: identifier)
    }

    
    static func fromStoryboard(identifier: String!) -> UIViewController {
        return self.fromStoryboard(name: "iPhone", identifier: identifier)
    }
    
    struct DeviceData {
        static func isIPad() -> Bool {
            return  UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
        }
        
        static func isIphone() -> Bool {
            return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
        }
        
        static func isOrientationLandscape() -> Bool {
            return UIDevice.current.orientation.isLandscape
        }
        
        static func isOrientationPortrait() -> Bool {
            return UIDevice.current.orientation.isPortrait
        }
    }
}
