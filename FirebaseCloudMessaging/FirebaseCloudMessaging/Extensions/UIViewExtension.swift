//
//  UIViewExtension.swift
//  tinder-app
//
//  Created by 濵田　悠樹 on 2022/02/20.
//

import UIKit

extension UIView {
    
    // Viewの 位置 や 大きさ を指定する
    func anchor(
        top: NSLayoutYAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil,
        right: NSLayoutXAxisAnchor? = nil,
        
        centerY: NSLayoutYAxisAnchor? = nil,
        centerX: NSLayoutXAxisAnchor? = nil,
        
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        
        topPadding: CGFloat = 0,
        bottomPadding: CGFloat = 0,
        leftPadding: CGFloat = 0,
        rightPadding: CGFloat = 0
    
    ) {
        
        self.translatesAutoresizingMaskIntoConstraints = false   //  Auto Layout以前に使われていた、Autosizingのレイアウトの仕組みをAuto Layoutに変換するかどうかを設定するフラグ
        
        // nilチェック
        //                      ↓ 制約の種類           ↓ スタート位置  ↓ スタートとの間隔
        if let top = top { self.topAnchor.constraint(equalTo: top, constant: topPadding).isActive = true }
        if let bottom = bottom { self.bottomAnchor.constraint(equalTo: bottom, constant: -bottomPadding).isActive = true }
        if let left = left { self.leftAnchor.constraint(equalTo: left, constant: leftPadding).isActive = true }
        if let right = right { self.rightAnchor.constraint(equalTo: right, constant: -rightPadding).isActive = true }
        if let centerX = centerX { self.centerXAnchor.constraint(equalTo: centerX).isActive = true }
        if let centerY = centerY { self.centerYAnchor.constraint(equalTo: centerY).isActive = true }
        if let width = width { self.widthAnchor.constraint(equalToConstant: width).isActive = true }
        if let height = height { self.heightAnchor.constraint(equalToConstant: height).isActive = true }
        
    }
}

// MARK: Animations
extension UIView {
    
    // スワイプした後のアニメーション
    func removeCardViewAnimation(x: CGFloat) {
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7 ,options: []) {
            let degree: CGFloat = x / 40
            let angle: CGFloat = degree * .pi / 180
            
            let rotateTolanslation = CGAffineTransform(rotationAngle: angle)
            self.transform = rotateTolanslation.translatedBy(x: x, y: 100)   // 回転移動
            self.layoutIfNeeded()
        } completion:  { _ in
            self.removeFromSuperview()
        }
    }
}
