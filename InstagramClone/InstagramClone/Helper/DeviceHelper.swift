//
//  DeviceHelper.swift
//  InstagramClone
//
//  Created by Apple on 11/2/19.
//  Copyright © 2019 nguyen manh hung. All rights reserved.
//

import Foundation
import UIKit

enum Device {
    case iPhoneSE
    case iPhone8
    case iPhone8Plus
    case iPhoneX
    case iPhoneXR
    case iPhoneXSMax
    case Unknown
}

struct DeviceHelper {
    
    static private let nativeHeight = UIScreen.main.nativeBounds.height
    static private let nativeScale = UIScreen.main.nativeScale
    
    static func getDevice() -> Device {
        if DeviceHelper.isIphoneSE {
            return Device.iPhoneSE
        }
        else if DeviceHelper.isIphone8 {
            return Device.iPhone8
        }
        else if DeviceHelper.isIphone8Plus {
            return Device.iPhone8Plus
        }
        else if DeviceHelper.isIphoneX {
            return Device.iPhoneX
        }
        else if DeviceHelper.isIphoneXR {
            return Device.iPhoneXR
        }
        else if DeviceHelper.isIphoneXSMax {
            return Device.iPhoneXSMax
        }
        return Device.Unknown
    }
    
    static var isIphoneSE: Bool = {
        if nativeHeight == 1136.0 {
            return true
        }
        return false
    }()
    
    static var isIphone8: Bool = {
        if nativeHeight == 1334.0 {
            return true
        }
        return false
    }()
    
    static var isIphone8Plus: Bool = {
        if nativeHeight == 1920.0 || nativeScale == 2.608 {
            return true
        }
        return false
    }()
    
    static var isIphoneX: Bool = {
        if nativeHeight == 2436.0 {
            return true
        }
        return false
    }()
    
    static var isIphoneXR: Bool = {
        if nativeHeight == 1792.0 {
            return true
        }
        return false
    }()
    
    static var isIphoneXSMax: Bool = {
        if nativeHeight == 2688.0 {
            return true
        }
        return false
    }()
    
    static var isIphoneXFamily: Bool = {
        if DeviceHelper.isIphoneX || DeviceHelper.isIphoneXR || DeviceHelper.isIphoneXSMax || nativeScale == 3.0 {
            return true
        }
        return false
    }()
    
}
