//
//  Lantern+Ext.swift
//  Lantern
//
//  Created by admin on 2023/7/20.
//

import Foundation

extension UIScreen {
    
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static var status_bar_height: CGFloat {
        
        var isStatusBarHidden = false
        if #available(iOS 13.0, *) {
            let connectedScenes = UIApplication.shared.connectedScenes
            if let windowScene = connectedScenes.first as? UIWindowScene, let statusBarManager = windowScene.statusBarManager {
                isStatusBarHidden = statusBarManager.isStatusBarHidden
            }
        } else {
            isStatusBarHidden = UIApplication.shared.isStatusBarHidden
        }
        
        if isStatusBarHidden {
            guard let window = UIApplication.shared.keyWindow else {
                return 20
            }
            let layoutInsets = window.layoutInsets()
            if layoutInsets.top > 50 {
                return 54
            } else if layoutInsets.top >= 47 {
                return 47
            } else if layoutInsets.top >= 44 {
                return 44
            }
            return 20
        } else {
            if #available(iOS 13.0, *) {
                let connectedScenes = UIApplication.shared.connectedScenes
                if let windowScene = connectedScenes.first as? UIWindowScene,
                    let statusBarManager = windowScene.statusBarManager {
                    
                    return statusBarManager.statusBarFrame.size.height
                }
                return 20
            } else {
                return UIApplication.shared.statusBarFrame.size.height
            }
        }
    }
    @objc static var safe_area_bottom: CGFloat {
        let window = UIApplication.shared.keyWindow
        return window?.layoutInsets().bottom ?? 0
    }
    static var navigation_bar_height: CGFloat = 44.0
    static var pt_line: CGFloat = 1.0
    static var px_line: CGFloat {
        return 1.0/UIScreen.main.scale
    }
    
    static var tabbar_height: CGFloat {
        return safe_area_bottom > 0 ? 83 : 49
    }
}


extension UIWindow {
    func layoutInsets() -> UIEdgeInsets {
        if #available(iOS 11.0, *) {
            let safeAreaInsets: UIEdgeInsets = self.safeAreaInsets
            if safeAreaInsets.bottom > 0 {
                return safeAreaInsets
            }
            return UIEdgeInsets.zero
        }
        return UIEdgeInsets.zero
    }
}
