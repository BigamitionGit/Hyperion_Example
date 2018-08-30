//
//  HYPAPIDebugPluginMenuItem.swift
//  Hyperion-Plugin-Example Debug
//
//  Created by Hiroshi Hosoda on 2018/08/28.
//  Copyright © 2018年 Hiroshi Hosoda. All rights reserved.
//

import HyperionCore
import RxCocoa
import RxSwift

class HYPAPIDebugPluginMenuItem: HYPPluginMenuItem {
    
    private let disposeBag = DisposeBag()
    private var menuView: UIStackView?
    
    private func setup() {
        
        self.height = 130
        
        menuView = UIStackView()
        menuView?.axis = .vertical
        menuView?.alignment = .fill
        menuView?.distribution = .fillProportionally
        menuView?.isHidden = true
        
        let debugApiLabel = UILabel()
        debugApiLabel.text = GithubApiDebugService.ResponseType.default.rawValue
        debugApiLabel.backgroundColor = UIColor.lightGray
        menuView?.addArrangedSubview(debugApiLabel)
        
        GithubApiDebugService.ResponseType.allCases
            .map { type->UIButton in
                let button = UIButton(type: .custom)
                button.setTitle(type.rawValue, for: .normal)
                button.setTitleColor(UIColor.darkText, for: .normal)
                button.backgroundColor = UIColor.white
                button.rx.tap
                    .do(onNext: { GithubApiDebugService.type = type })
                    .map { type.rawValue }
                    .bind(to: debugApiLabel.rx.text)
                    .disposed(by: disposeBag)
                return button
            }
            .forEach { button in
                menuView?.addArrangedSubview(button)
        }
        
        if let mView = menuView {
            self.addSubview(mView)
            
            // Autolayout 設定
            mView.translatesAutoresizingMaskIntoConstraints = false
            mView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            mView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            mView.topAnchor.constraint(equalTo: self.pluginImageView.bottomAnchor).isActive = true
            mView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.height = 400
            menuView?.isHidden = false
        } else {
            self.height = 130
            menuView?.isHidden = true
        }
    }
    
    // MARK: - Factory
    
    static func create()-> HYPAPIDebugPluginMenuItem {
        
        let menuItem = HYPAPIDebugPluginMenuItem()
        menuItem.setup()
        return menuItem
    }
}
