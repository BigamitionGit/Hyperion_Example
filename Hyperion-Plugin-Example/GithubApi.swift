//
//  GithubApi.swift
//  Hyperion-Plugin-Example
//
//  Created by Hiroshi Hosoda on 2018/08/23.
//  Copyright © 2018年 Hiroshi Hosoda. All rights reserved.
//

import Foundation

enum GithubApi {
    
    case searchRepositories
    
    private var baseURL: String {
        return "https://api.github.com"
    }
    
    var url: String {
        switch self {
        case .searchRepositories:
            return baseURL + "/search/repositories"
        }
    }
    
}
