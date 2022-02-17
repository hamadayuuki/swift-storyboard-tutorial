//
//  ViweModel.swift
//  Combine_3
//
//  Created by 濵田　悠樹 on 2022/02/16.
//

/*
 Model の役割
 MVC
 */
import Combine

// publish される値を表示用の値に変換する
final class ViewModel {
    let labelText: AnyPublisher<String?, Never>
    private let account = Account()
    
    init() {
        labelText = account.$isValid
            .map { "isValid: \($0)" }
            .eraseToAnyPublisher()
    }
    
    func load() {
        account.update(userId: "hoge", password: "pass")
    }
}
