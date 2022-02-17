//
//  SoftwareViewModel.swift
//  ibm
//
//  Created by Amit Jain on 2/14/22.
//

import Foundation
class SoftwareViewModel : ObservableObject {
    
    var apps: [SoftwareModel] = []
    var genres:[String] = []
    var filteredCount:Int = 0
    @Published var loading:Bool = false
    @Published var isSearchCleared:Bool = true
    
    func fetchApps(searchText:String) async {
        do {
            loading = true
            isSearchCleared = false
            let parameters = [ "term":searchText, "entity":"software", "limit":"200"]
            let appService:SoftwareService = SoftwareService(parameters: parameters)
            let appData = try await appService.callSoftwareApi()
            DispatchQueue.main.async { [weak self] in //can use @MainActor on the VM, but then request & response go on mainQ.
                
                self?.apps = appData
                self?.loading = false
                
                //create  a list of genres from the fetched results
                let dict = Dictionary(grouping: appData, by: {$0.primaryGenreName})
                var array:[String] = [Constants.any]
                array.append(contentsOf: dict.keys)
                self?.genres = array
            }
        } catch {
            print("Fetching apps  failed with error \(error)")
            DispatchQueue.main.async { [weak self] in
                self?.loading = false
            }
        }
    }
    
    func filteredApps(appPaidFilter: AppFilterType, selectedGenre:String) -> [SoftwareModel] {
        var filtered:[SoftwareModel] = []
        if selectedGenre == Constants.any {
            switch appPaidFilter {
            case .any:
                filtered = self.apps
            case .free:
                filtered = self.apps.filter { $0.formattedPrice == "Free" || $0.formattedPrice == nil}
            case .paid:
                filtered = self.apps.filter { $0.formattedPrice != "Free"}
            }
        } else {
            switch appPaidFilter {
            case .any:
                filtered = self.apps.filter{ $0.primaryGenreName == selectedGenre }
            case .free:
                filtered = self.apps.filter { $0.formattedPrice == "Free" && $0.primaryGenreName == selectedGenre }
            case .paid:
                filtered = self.apps.filter { $0.formattedPrice != "Free" && $0.primaryGenreName == selectedGenre}
            }
            
        }
        filteredCount = filtered.count
        print ("Filter:\(filteredCount) of \(apps.count)")
        return filtered
    }
    
    func clearSearch () {
        apps.removeAll()
        filteredCount = 0
        isSearchCleared = true
    }
}
