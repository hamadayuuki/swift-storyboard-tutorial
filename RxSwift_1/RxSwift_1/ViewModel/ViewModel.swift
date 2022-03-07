//
//  ViewModel.swift
//  RxSwift_1
//
//  Created by 濵田　悠樹 on 2022/03/08.
//

import RxSwift
import RxCocoa

class ViewModel {
    
    // ■ 受け取りに使用
    // Observable: イベントを検知するためのクラス
    var helloWorldObservable: Observable<String> {
        return helloWorldSubject.asObservable()
    }
    
    // ■ 流すために使用
    public let helloWorldSubject = PublishSubject<String>()
    
    func updateItem() {
        helloWorldSubject.onNext("Hello World!_1")
        helloWorldSubject.onNext("Hello World!_2")
        helloWorldSubject.onNext("Hello World!_3")
        helloWorldSubject.onCompleted()   // 終了
    }
}
