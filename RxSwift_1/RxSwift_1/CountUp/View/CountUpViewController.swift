//
//  CountUpViewController.swift
//  RxSwift_1
//
//  Created by 濵田　悠樹 on 2022/03/08.
//

import UIKit
import RxSwift
import RxCocoa

class CountUpViewController: UIViewController {
    
    // MARK: Cells
    var countNumLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.backgroundColor = .green
        label.textColor = .black
        return label
    }()
    
    var countUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.tintColor = .black
        button.backgroundColor = .yellow
        return button
    }()
    
    var countDownButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.tintColor = .black
        button.backgroundColor = .blue
        return button
    }()
    
    var countResetButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reset", for: .normal)
        button.tintColor = .black
        button.backgroundColor = .gray
        return button
    }()

    private let disposeBag = DisposeBag()
    private var viewModel: CounterViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupViewModel()
    }
    
    // SnapKit を使って画面を描画
    private func setupLayout() {
        view.backgroundColor = .blue
        view.addSubview(countNumLabel)
        view.addSubview(countUpButton)
        view.addSubview(countDownButton)
        view.addSubview(countResetButton)
        
        countNumLabel.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(100)
            make.top.equalTo(view.snp.top).offset(100)
            make.centerX.equalToSuperview()
        }
        
        countUpButton.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(100)
            make.top.equalTo(countNumLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        countDownButton.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(100)
            make.top.equalTo(countUpButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        countResetButton.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(100)
            make.top.equalTo(countDownButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupViewModel() {
        viewModel = CounterViewModel()
        
        // input の初期化
        let input = CounterViewModelInput (
            countUpButton: countUpButton.rx.tap.asObservable(),
            countDownButton: countDownButton.rx.tap.asObservable(),
            countResetButton: countResetButton.rx.tap.asObservable()
        )
        viewModel.setup(input: input)
        
        // output の呼び出し
        viewModel.outputs?.counterText
            .drive(countNumLabel.rx.text)   // 返ってきた文字列を countNumLabel に代入する
            .disposed(by: disposeBag)
        
    }

}
