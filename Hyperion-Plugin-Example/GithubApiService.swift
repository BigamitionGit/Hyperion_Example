//
//  GithubApiService.swift
//  Hyperion-Plugin-Example
//
//  Created by Hiroshi Hosoda on 2018/08/22.
//  Copyright © 2018年 Hiroshi Hosoda. All rights reserved.
//

import RxSwift
import Foundation

class GithubApiService {
    
    func fetchRepositories(queryItems: [URLQueryItem]?)-> Single<GithubRepositoryModel> {
        
        return Single<GithubRepositoryModel>.create(subscribe: { (observer) -> Disposable in
            
            var components = URLComponents(string: GithubApi.searchRepositories.url)
            components?.queryItems = queryItems
            let url = components?.url
            let task = URLSession.shared.dataTask(with: url!) { data, response, error in
                if let data = data {
                    let decoder: JSONDecoder = JSONDecoder()
                    do {
                        let repositories: GithubRepositoryModel = try decoder.decode(GithubRepositoryModel.self, from: data)
                        observer(.success(repositories))
                    } catch {
                        observer(.error(error))
                    }
                } else if let error = error {
                    observer(.error(error))
                } else {
                    observer(SingleEvent.error(FetchError()))
                }
            }
            task.resume()
            return Disposables.create()
        })
    }
}
