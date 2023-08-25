//  ListViewModel.swift

import Foundation

/*
    CRUD FUNCTIONS
 */

class ListViewModel: ObservableObject {
    @Published var items: [ItemModel] = []{
        // any time we make a CRUD change to the items array, we call the didSet
        didSet {
            saveItems()
        }
    }
    let itemsKey: String = "items_list"
    
    init() {
     getItems()
    }
    
    func getItems() {
        // Sets items data manually
//        let newItems = [
//            ItemModel(title: "This is the first title", isCompleted: false),
//            ItemModel(title: "This is the second title", isCompleted: true),
//            ItemModel(title: "This is the third title", isCompleted: false)
//        ]
//        items.append(contentsOf: newItems)
        
        // Checks if there's data with our key in UserDefaults (localStorage)
        // Sets items data from UserDefaults
        // [ItemModel].self:
        //   - We know our items data is in an array so we put the type in an array
        //   - Our items data is of type ItemModel
        //   - We add .self because we want to refer to the type of the data not the aray of ItemModel data itself
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        
        self.items = savedItems
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int){
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String){
        let newItem = ItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
    
    func updateItem(item: ItemModel) {
        
//        if let index = items.firstIndex { (existingItem) -> Bool in
//            return existingItem.id == item.id
//        } {
//                // run this code
//        }
        
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item.updateCompletion()
        }
    }
    
    // Converts the data in items array into a JSON data
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
}
