//
//  HomeViewController.swift
//  FirebaseCloudMessaging
//
//  Created by 濵田　悠樹 on 2022/03/03.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let sendNotificationButton = SendNotificationButton(text: "通知を送信")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        setupLayout()
        setupBinding()
    }
    
    private func setupLayout() {
        view.backgroundColor = .yellow
        view.addSubview(sendNotificationButton)
        
        sendNotificationButton.anchor(centerY: view.centerYAnchor, centerX: view.centerXAnchor, width: 100, height: 100)
    }
    
    private func setupBinding() {
        sendNotificationButton.rx.tap
            .asDriver()
            .drive { [weak self] text in
                print("通知送信ボタンが押されました")
            }
            .disposed(by: disposeBag)
    }
}
