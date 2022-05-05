//
//  UnitTest_1Tests.swift
//  UnitTest_1Tests
//
//  Created by 濵田　悠樹 on 2022/05/05.
//

import XCTest
@testable import UnitTest_1

/*
 ■ UnitTest 実行方法
    - プログラム左の実行ボタンをクリック → 楽
    - Product > Test
    - Command + U → 楽
 
 ■ 関数名: test + テストしたい関数名
 */
class UnitTest_1Tests: XCTestCase {

    func testAdd() throws {
        let result = Calclator().add(num1: 10, num2: 20)
        
        XCTAssertEqual(result, 30)   // 30 = 10 + 20
    }
    
    func testSub() throws {
        let result = Calclator().sub(num1: 10, num2: 20)
        
        XCTAssertEqual(result, -10)   // -10 = 10 - 20
    }

}
