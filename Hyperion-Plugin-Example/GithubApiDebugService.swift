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
    
    enum ResponseType: String {
        case `default` = "通常"
        case json0 = "0件"
        case json10 = "10件"
        case error = "エラー"
        
        static var allCases: [ResponseType] {
            return [.default, .json0, .json10, .error]
        }
    }
    
    static var type: ResponseType = .default
    
    override func fetchRepositories(queryItems: [URLQueryItem]?)-> Single<GithubRepositoryModel> {
        switch GithubApiDebugService.type {
        case .default:
            return super.fetchRepositories(queryItems: queryItems)
        case .json0:
            return Single.error(FetchError())
        case .json10:
            return Single.error(FetchError())
        case .error:
            return Single.error(FetchError())
        }
    }
}
