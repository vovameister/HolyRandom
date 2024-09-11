
import CoreData

final class CoreDataManager: CoreDataManagerHistoryProtocol, CoreDataCreateProtocol, ObservableObject {
    let persistentContainer: NSPersistentContainer

    init() {
        persistentContainer = NSPersistentContainer(name: "SolveData")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
    }

    func saveWheelItemList(items: [WheelItem], creationDate: Date) {
        let context = persistentContainer.viewContext
        
        let wheelItemList = WheelItemListEntity(context: context)
        wheelItemList.creationDate = creationDate
        
        for wheelItem in items {
            let wheelItemEntity = WheelItemEntity(context: context)
            wheelItemEntity.id = wheelItem.id
            wheelItemEntity.text = wheelItem.text
            wheelItemList.addToItem(wheelItemEntity)
        }
        
        do {
            try context.save()
        } catch {
            print("Failed to save wheel item list: \(error)")
        }
    }

    func fetchHistoryModels() -> [HistoryModel] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<WheelItemListEntity> = WheelItemListEntity.fetchRequest()

        do {
            let fetchedWheelItemLists = try context.fetch(fetchRequest)

            let historyModels = fetchedWheelItemLists.compactMap { listEntity -> HistoryModel? in
                guard let creationDate = listEntity.creationDate,
                      let items = listEntity.item as? Set<WheelItemEntity> else {
                    return nil
                }
                let wheelItems = items.compactMap { wheelItemEntity -> WheelItem? in
                    let id = wheelItemEntity.id
                    let textData = wheelItemEntity.text
                    let text = textData
                   
                    return WheelItem(text: text ?? "", id: id ?? UUID())
                }

                return HistoryModel(date: creationDate, item: wheelItems)
            }

            return historyModels

        } catch {
            print("Failed to fetch wheel item lists: \(error)")
            return []
        }
    }
    func deleteHistoryModel(_ group: HistoryModel) {
           let context = persistentContainer.viewContext
        
           let fetchRequest: NSFetchRequest<WheelItemListEntity> = WheelItemListEntity.fetchRequest()
           fetchRequest.predicate = NSPredicate(format: "creationDate == %@", group.date as NSDate)
           
           do {
               let fetchResults = try context.fetch(fetchRequest)
               
               if let entityToDelete = fetchResults.first {
                   context.delete(entityToDelete)
                   
                   try context.save()
                   
                   print("Successfully deleted group: \(group)")
               }
           } catch {
               print("Failed to delete history group: \(error)")
           }
       }
}

protocol CoreDataManagerHistoryProtocol {
    func fetchHistoryModels() -> [HistoryModel]
    func deleteHistoryModel(_ group: HistoryModel)
}
protocol CoreDataCreateProtocol {
    func saveWheelItemList(items: [WheelItem], creationDate: Date)
}
