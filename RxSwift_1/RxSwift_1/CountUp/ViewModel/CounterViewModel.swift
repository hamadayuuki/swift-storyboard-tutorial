//
//  CounterViewModel.swift
//  RxSwift_1
//
//  Created by 濵田　悠樹 on 2022/03/08.
//

import UIKit
import RxSwift
import RxCocoa

// Rx で非同期を行うための要素を定義
struct CounterViewModelInput {
    let countUpButton: Observable<Void>
    let countDownButton: Observable<Void>
    let countResetButton: Observable<Void>
}

protocol CounterViewModelOutput {
    var counterText: Driver<String?> { get }
}

// ただの protocol
protocol CounterViewModelType {
    var outputs: CounterViewModelOutput? { get }
    func setup(input: CounterViewModelInput)
}

class CounterViewModel: CounterViewModelType {
    var outputs: CounterViewModelOutput?
    
    private let countRelay = BehaviorRelay<Int>(value: 0)
    
    private let initialCount = 0
    private let disposeBag = DisposeBag()
    
    init() {
        self.outputs = self
        resetCount()
    }
    
    // イベントの受信
    func setup(input: CounterViewModelInput) {
        input.countUpButton
            .subscribe(onNext: { [weak self] in
                self?.incrementCount()
            })
            .disposed(by: disposeBag)
        
        input.countDownButton
            .subscribe(onNext: { [weak self] in
                self?.decrementCount()
            })
            .disposed(by: disposeBag)
        
        input.countResetButton
            .subscribe(onNext: { [weak self] in
                self?.resetCount()
            })
            .disposed(by: disposeBag)
    }
    
    // カウントの増減/リセット
    private func incrementCount() {
        let count = countRelay.value + 1
        countRelay
            .accept(count)
    }
    private func decrementCount() {
        let count = countRelay.value - 1
        countRelay
            .accept(count)
    }
    private func resetCount() {
        countRelay
            .accept(initialCount)
    }
}

extension CounterViewModel: CounterViewModelOutput {
    var counterText: Driver<String?> {
        return countRelay
            .map { "Rxパターン: \($0)" }   // ViewController に返す文字列
            .asDriver(onErrorJustReturn: nil)   // エラーなら nil を返す
    }
    
}
