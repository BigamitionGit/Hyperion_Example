//
//  ServiceModule.swift
//  Hyperion-Plugin-Example Debug
//
//  Created by Hiroshi Hosoda on 2018/08/23.
//  Copyright © 2018年 Hiroshi Hosoda. All rights reserved.
//

import Foundation

struct ServiceModule {
    
    static func provideGithubApiService() -> GithubApiService {
        return GithubApiDebugService()
    }
}
