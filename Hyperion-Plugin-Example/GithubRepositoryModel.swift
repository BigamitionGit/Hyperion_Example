//
//  GithubRepositoryModel.swift
//  Hyperion-Plugin-Example
//
//  Created by Hiroshi Hosoda on 2018/08/22.
//  Copyright © 2018年 Hiroshi Hosoda. All rights reserved.
//

import Foundation

struct GithubRepositoryModel: Codable {
    
    let total_count: Int
    let incomplete_results: Bool
    let items: [Item]
    
    struct Item: Codable {
        let name: String
        let full_name: String
        let language: String
    }
}
