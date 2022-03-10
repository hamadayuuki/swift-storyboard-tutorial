//
//  RxKeyboardViewController.swift
//  RxSwift_1
//
//  Created by 濵田　悠樹 on 2022/03/10.
//

/*
 何かしらのイベント(タップやスクロール)が発生した時に、ViewModelに通知して、ViewModelでデータを変更して、ViewControllerに通知して、ViewControllerで反映
 何かしらのイベントが直接 描画するとき(テキストフィールドへの入力)は ViewModel を介さず処理する
 */

import UIKit
import RxSwift
import RxCocoa
import RxKeyboard

class RxKeyboardViewController: UIViewController {
    
    // MARK: Cells
    var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "文字を入力してください"
        textField.textColor = .black
        textField.backgroundColor = .yellow
        return textField
    }()

    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupRxKeyboard()
    }
    
    // SnapKit を使って画面を描画
    private func setupLayout() {
        view.backgroundColor = .blue
        view.addSubview(nameTextField)
        
        nameTextField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(100)
            make.top.equalTo(view.snp.top).offset(100)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupRxKeyboard() {
        // キーボードの状態に変更があったとき呼ばれる → ViewController を ViewModel に分けて実装するものではない, ViewController にかく
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [weak self] keyboardHeight in
                print("キーボードの高さ: \(keyboardHeight)")
            })
            .disposed(by: disposeBag)
    }

}
