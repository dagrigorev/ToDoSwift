//
//  ListViewModel.swift
//  ToDoSwift
//
//  Created by Dmitry Grigorev on 08.01.2023.
//

import Foundation

class ListViewModel: ObservableObject {
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItems()
        }
    }
    
    let itemsKey = "items_key"
    
    init() {
        generateSampleItemsIfNeeded()
    }
    
    private func generateSampleItemsIfNeeded() {
        if items.isEmpty {
            guard
                let data = UserDefaults.standard.data(forKey: itemsKey),
                let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
            else { return }
            
            self.items = savedItems
        }
    }
    
    func addItem(newItem: ItemModel) {
        if items.contains(where: { $0.id == newItem.id }) {
            return
        }
        
        items.append(newItem)
    }
    
    func createItem(newItemTitle: String) {
        if !newItemTitle.isEmpty {
            items.append(ItemModel(title: newItemTitle, isCompleted: false))
        }
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func updateItem(existedItem: ItemModel) {
        if !items.contains(where: { $0.id == existedItem.id }) {
            return
        }
        
        if let itemIndex = items.firstIndex(where: { $0.id == existedItem.id }) {
            items[itemIndex] = existedItem.updateCompleted()
        }
    }
    
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    
    func isNoItems() -> Bool {
        return items.isEmpty
    }
}
