
import CoreData
import Combine

final class CoreDataManager: CoreDataManagerHistoryProtocol, CoreDataCreateProtocol {
    let persistentContainer: NSPersistentContainer
    let maxHistoryCount = 100
    let dataChangedSubject = PassthroughSubject<Void, Never>()
    
    init() {
        persistentContainer = NSPersistentContainer(name: "SolveData")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                print("Ошибка при загрузке Core Data: \(error)")
            }
        }
    }
    
    func saveWheelItemList(items: [WheelItem], creationDate: Date) {
        let context = backgroundContext()
        
        context.perform {
            let wheelItemList = WheelItemListEntity(context: context)
            wheelItemList.creationDate = creationDate
            
            items.forEach { wheelItem in
                let wheelItemEntity = WheelItemEntity(context: context)
                wheelItemEntity.id = wheelItem.id
                wheelItemEntity.text = wheelItem.text
                wheelItemList.addToItem(wheelItemEntity)
            }
            
            do {
                try context.save()
                Task {
                    await self.checkHistoryLimit()
                    await self.notifyDataChanged()
                }
                
            } catch {
                print("Ошибка сохранения: \(error)")
            }
        }
    }
    
    private func checkHistoryLimit() async {
        let context = backgroundContext()
        
        await context.perform {
            let fetchRequest: NSFetchRequest<WheelItemListEntity> = WheelItemListEntity.fetchRequest()
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
            fetchRequest.fetchLimit = self.maxHistoryCount + 1
            
            do {
                let historyList = try context.fetch(fetchRequest)
                
                guard historyList.count > self.maxHistoryCount else { return }
                
                let itemsToDelete = historyList.prefix(historyList.count - self.maxHistoryCount)
                itemsToDelete.forEach { context.delete($0) }
                
                try context.save()
            } catch {
                print("Ошибка при удалении старых данных: \(error)")
            }
        }
    }
    
    func fetchHistoryModels() -> [HistoryModel] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<WheelItemListEntity> = WheelItemListEntity.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        fetchRequest.fetchLimit = maxHistoryCount
        
        do {
            let results = try context.fetch(fetchRequest)
            return results.compactMap { listEntity in
                guard let creationDate = listEntity.creationDate,
                      let items = listEntity.item as? Set<WheelItemEntity> else { return nil }
                
                let wheelItems = items.compactMap { WheelItem(text: $0.text ?? "", id: $0.id ?? UUID()) }
                
                return HistoryModel(date: creationDate, item: wheelItems)
            }
        } catch {
            print("Ошибка при выборке истории: \(error)")
            return []
        }
    }
    
    func deleteHistoryModel(_ group: HistoryModel) {
        let context = backgroundContext()
        
        context.perform {
            let fetchRequest: NSFetchRequest<WheelItemListEntity> = WheelItemListEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "creationDate == %@", group.date as NSDate)
            
            do {
                let fetchResults = try context.fetch(fetchRequest)
                fetchResults.forEach { context.delete($0) }
                
                try context.save()
                Task {
                    await self.notifyDataChanged()
                }
            } catch {
                print("Ошибка удаления: \(error)")
            }
        }
    }
    
    private func backgroundContext() -> NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
    @MainActor private func notifyDataChanged() {
        dataChangedSubject.send()
    }
}

protocol CoreDataManagerHistoryProtocol: AnyObject {
    var dataChangedSubject: PassthroughSubject<Void, Never> { get }
    func fetchHistoryModels() -> [HistoryModel]
    func deleteHistoryModel(_ group: HistoryModel)
}
protocol CoreDataCreateProtocol: AnyObject {
    func saveWheelItemList(items: [WheelItem], creationDate: Date)
}
