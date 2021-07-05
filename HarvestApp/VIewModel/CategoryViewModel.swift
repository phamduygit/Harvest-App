//
//  CategoryViewModel.swift
//  HarvestApp
//
//  Created by Pham Minh Duy on 05/07/2021.
//

import Foundation
import Combine

class CategoryViewModel: ObservableObject {
    @Published var categories = [Category]()
    @Published var categoryRepository = CategoryRepository()
    private var cancellables : Set<AnyCancellable> = []
    init() {
        categoryRepository.$categories
            .assign(to: \.categories, on: self)
            .store(in: &cancellables)
    }
    func getListProductName(categoryName : String) -> [String] {
        let category = categoryRepository.categories.first { category in
            category.categoryName == categoryName
        }
        return category?.listProductName ?? []
    }
    func getOneCategory(categoryName: String) -> Category {
        let category = categoryRepository.categories.first { category in
            category.categoryName == categoryName
        }
        return category ?? Category()
    }
}
