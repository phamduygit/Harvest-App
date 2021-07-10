//
//  ItemViewModel.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 10/07/2021.
//

import Foundation
import Combine

class ItemViewModel: ObservableObject {
    @Published var items : [Item] = []
    @Published var itemRepository = ItemRepository()
    private var cancellables : Set<AnyCancellable> = []
    init() {
        itemRepository.$items
            .assign(to: \.items, on: self)
            .store(in: &cancellables)
    }
    func listItemFiltered(category: String, favorites: [String], isFavorite: Bool, updateDate: Date) -> [Item] {
        var filteredItem = items.filter { item in
            category == "Tất cả" ? true : category == item.category
        }
        if isFavorite {
            filteredItem = filteredItem.filter({ item in
                favorites.contains(item.id!)
            })
        }

//        let dateFormatterGet = DateFormatter()
//        dateFormatterGet.dateFormat = "yyyy-MM-dd"
//        filteredItem = filteredItem.filter({ item in
//            dateFormatterGet.string(from: (item.updateTime?.dateValue())!) == dateFormatterGet.string(from: updateDate)
//        })
        
        return filteredItem
    }
}
