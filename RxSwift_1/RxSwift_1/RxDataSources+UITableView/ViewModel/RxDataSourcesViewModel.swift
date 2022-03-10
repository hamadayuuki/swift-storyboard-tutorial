//
//  RxDataSourcesViewModel.swift
//  RxSwift_1
//
//  Created by 濵田　悠樹 on 2022/03/09.
//

import RxSwift
import RxCocoa
import RxDataSources

class RxDataSourcesViewModel {
    
    private let items = BehaviorRelay<[RxDataSourcesModel]>(value: [])
    
    var itemsObservable: Observable<[RxDataSourcesModel]> {
        return items.asObservable()
    }
    
    func setup() {
        updateItems()
    }
    
    private func updateItems() {
        let sections: [RxDataSourcesModel] = [
            accountSection(),
            commonSection()
        ]
        items.accept(sections)   // 通知
    }
    
    private func accountSection() ->  RxDataSourcesModel {
        let items: [SettingItem] = [
            .account,
            .security,
            .notification,
            .contents
        ]
        
        return RxDataSourcesModel(model: .account, items: items)
    }
    
    private func commonSection() -> RxDataSourcesModel {
        let items: [SettingItem] = [
            .sounds,
            .dataUsing,
            .accessibility,
            .description(text: "基本設定はこの端末でログインしている全てのアカウントに適応されます")
        ]
        
        return RxDataSourcesModel(model: .common, items: items)
    }
}
