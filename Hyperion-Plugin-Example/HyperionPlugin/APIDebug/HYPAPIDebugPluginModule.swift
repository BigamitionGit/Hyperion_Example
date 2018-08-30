//
//  HYPAPIDebugPluginModule.swift
//  Hyperion-Plugin-Example Debug
//
//  Created by Hiroshi Hosoda on 2018/08/28.
//  Copyright © 2018年 Hiroshi Hosoda. All rights reserved.
//

import HyperionCore

class HYPAPIDebugPluginModule: HYPPluginModule, HYPPluginMenuItemDelegate {
    
    override var pluginMenuItem: (UIView & HYPPluginMenuItemProtocol)? {
        
        let menuItem = HYPAPIDebugPluginMenuItem.create()
        // メニューアイコン、メニュータイトルを設定
        menuItem.bind(withTitle: "APIDebug", image: UIImage(named: "ic_edit"))
        menuItem.delegate = self
        return menuItem
    }
    
    // MARK: HYPPluginMenuItemDelegate
    
    func pluginMenuItemSelected(_ pluginView: (UIView & HYPPluginMenuItemProtocol)?) {
        guard let view = pluginView else { return }
        view.setSelected(!view.isSelected, animated: true)
    }
    
}
