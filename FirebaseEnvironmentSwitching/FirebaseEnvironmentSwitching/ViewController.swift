//
//  ViewController.swift
//  FirebaseEnvironmentSwitching
//
//  Created by 濵田　悠樹 on 2022/05/10.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        
        #if Develop
            print("🐵")
        #elseif Debug
            print("🐥")
        #else
            print("🐻")
        #endif
    }


}

