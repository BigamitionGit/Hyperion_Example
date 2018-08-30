//
//  HYPAPIDebugPlugin.swift
//  Hyperion-Plugin-Example Debug
//
//  Created by Hiroshi Hosoda on 2018/08/28.
//  Copyright © 2018年 Hiroshi Hosoda. All rights reserved.
//

import HyperionCore

class HYPAPIDebugPlugin: NSObject, HYPPlugin {
    
    // MARK: HYPPlugin
    
    static func createPluginModule(_ pluginExtension: HYPPluginExtension) -> HYPPluginModuleProtocol {
        return HYPAPIDebugPluginModule(with: pluginExtension)
    }
    
    static func pluginVersion() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
    }
}

