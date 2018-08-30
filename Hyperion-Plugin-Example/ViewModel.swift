//
//  ViewModel.swift
//  Hyperion-Plugin-Example
//
//  Created by Hiroshi Hosoda on 2018/08/22.
//  Copyright © 2018年 Hiroshi Hosoda. All rights reserved.
//

import RxCocoa
import RxSwift
import Foundation

final class ViewModel {
    
    // Input
    let viewDidLoad = PublishRelay<Void>()
    let refresh = PublishRelay<Void>()
    
    // Output
    let model: Driver<GithubRepositoryModel>
    var showErrorMessage: Signal<String> {
        return showErrorMessageRelay.asSignal()
    }
    private let showErrorMessageRelay: PublishRelay<String>
    
    var fetchCompleted: Signal<Void> {
        return fetchCompletedRelay.asSignal()
    }
    private let fetchCompletedRelay: PublishRelay<Void>
    
    init(service: GithubApiService) {
        
        let query: URLQueryItem = URLQueryItem(name: "q", value: "hyperion")
        
        let fetchErrorMessage = PublishRelay<String>()
        showErrorMessageRelay = fetchErrorMessage
        
        let fetchDispose = PublishRelay<Void>()
        fetchCompletedRelay = fetchDispose
        model = Observable
            .of(viewDidLoad, refresh)
            .merge()
            .flatMap { _ in service.fetchRepositories(queryItems: [query])
                .do(
                    onError: { error in
                        if let fetchError = error as? FetchError {
                            fetchErrorMessage.accept(fetchError.message)
                        }
                },
                    onDispose: { fetchDispose.accept(()) })
                .catchError({ _ in Single.never() })
            }
            .asDriver(onErrorDriveWith: Driver.empty())
    }
}
