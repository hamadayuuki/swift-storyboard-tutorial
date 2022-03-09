//
//  RxDataSourcesModel.swift
//  RxSwift_1
//
//  Created by 濵田　悠樹 on 2022/03/09.
//

/*
 
    TableView に表示する セクションのタイプ や 文字列 を定義
 
 */

import UIKit
import RxDataSources

typealias RxDataSourcesModel = SectionModel<SettingSeciton, SettingItem>

// TableView(CollectionView)のセクション単位のモデル
enum SettingSeciton {
    case account
    case common
    
    var headerHeight: CGFloat { return 4.0 }
    var footerHeight: CGFloat { return 1.0 }
}

enum SettingItem {
    // アカウントセクション
    case account
    case security
    case notification
    case contents
    
    // 一般セクション
    case sounds
    case dataUsing
    case accessibility
    
    // その他
    case description(text: String)
    
    // セクションタイトル
    var title: String? {
        switch self {
        // アカウントセクション
        case .account:
            return "アカウント"
        case .security:
            return "セキュリティー"
        case .notification:
            return "通知"
        case .contents:
            return "コンテンツ設定"
            
        // 一般セクション
        case .sounds:
            return "サウンド設定"
        case .dataUsing:
            return "データ利用時の設定"
        case .accessibility:
            return "アクセシビリティ"
            
        // その他
        case .description:
            return nil
        }
    }
    
    var rowHeight: CGFloat {
        switch self {
        case .description:
            return 72.0
        default:
            return 48.0
        }
    }
    
    // TableView のアクセサリ を指定
    var accessoryType: UITableViewCell.AccessoryType {
        switch self {
        case .account, .security, .notification, .contents, .sounds, .dataUsing, .accessibility:
            return .disclosureIndicator   // 「>」 をセクションごとにつける
        case .description:
            return .none
        }
    }
}
