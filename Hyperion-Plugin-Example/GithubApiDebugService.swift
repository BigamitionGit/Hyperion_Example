//
//  GithubApiDebugService.swift
//  Hyperion-Plugin-Example Debug
//
//  Created by Hiroshi Hosoda on 2018/08/23.
//  Copyright © 2018年 Hiroshi Hosoda. All rights reserved.
//

import RxSwift
import Foundation

final class GithubApiDebugService: GithubApiService {
    
    enum ResponseType: String, CaseIterable {
        case `default` = "default"
        case json0 = "0"
        case json10 = "10"
        case error = "error"
    }
    
    static var type: ResponseType = .default
    
    override func fetchRepositories(queryItems: [URLQueryItem]?)-> Single<GithubRepositoryModel> {
        switch GithubApiDebugService.type {
        case .default:
            return super.fetchRepositories(queryItems: queryItems)
        case .json0:
            return JSONService.fetchJSONData(fileName: "GithubRepositories0")
        case .json10:
            return JSONService.fetchJSONData(fileName: "GithubRepositories10")
        case .error:
            return Single.error(FetchError())
        }
    }
}
