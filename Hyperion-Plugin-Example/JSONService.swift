//
//  JSONService.swift
//  Hyperion-Plugin-Example
//
//  Created by 細田大志 on 2018/10/01.
//  Copyright © 2018年 Hiroshi Hosoda. All rights reserved.
//

import Foundation
import RxSwift

struct JSONService {
    
    static func fetchJSONData<T: Codable>(fileName: String) -> Single<T> {
        return Single<T>.create() { observer -> Disposable in
            let path = Bundle.main.path(forResource: fileName, ofType: "json")
            let url = URL(fileURLWithPath: path!)
            do {
                let data = try Data(contentsOf: url)
                let model = try JSONDecoder().decode(T.self, from: data)
                observer(.success(model))
            } catch {
                observer(.error(error))
            }
            
            return Disposables.create()
        }
    }
}
