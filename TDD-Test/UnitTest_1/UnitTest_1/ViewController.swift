//
//  ViewController.swift
//  UnitTest_1
//
//  Created by 濵田　悠樹 on 2022/05/05.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
    }

}

// MARK: - UnitTest
struct Calclator {
    func add(num1: Int, num2: Int) -> Int {
        num1 + num2
//        99
    }
    
    func sub(num1: Int, num2: Int) -> Int {
        num1 - num2
//        99
    }
}

