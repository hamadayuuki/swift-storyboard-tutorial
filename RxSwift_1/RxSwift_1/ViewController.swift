//
//  ViewController.swift
//  RxSwift_1
//
//  Created by 濵田　悠樹 on 2022/03/07.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        // MARK: RxSwift
        let helloWorldSubject = PublishSubject<String>()   // ①: Subject の定義
        
        helloWorldSubject   // ②: Subject を購読
            // ③: 流れてきたデータを表示
            .subscribe(onNext: { message in
                print("onNext: \(message)")
            })
            .disposed(by: disposeBag)
        
        // ④: イベントを流す
        helloWorldSubject.onNext("Hello World!_1")
        helloWorldSubject.onNext("Hello World!_2")
        helloWorldSubject.onNext("Hello World!_3")
        helloWorldSubject.onCompleted()   // 終了
    }


}

