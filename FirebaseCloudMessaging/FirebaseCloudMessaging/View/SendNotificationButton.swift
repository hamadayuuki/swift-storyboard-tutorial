//
//  SendNotificationButton.swift
//  FirebaseCloudMessaging
//
//  Created by 濵田　悠樹 on 2022/03/03.
//

import UIKit

class SendNotificationButton: UIButton {
    init(text: String) {
        super.init(frame: .zero)
        setTitle(text, for: .normal)
        setTitleColor(.white, for: .normal)
        backgroundColor = .red
        layer.cornerRadius = 10
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
