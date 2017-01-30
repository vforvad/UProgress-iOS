//
//  CommonFunctions.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 30.01.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit

struct CommonFunctions {
    struct DeviceData {
        static func isIPad() -> Bool {
            return  UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
        }
        
        static func isIphone() -> Bool {
            return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
        }
    }
}
