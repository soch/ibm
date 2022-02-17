//
//  ContentView.swift
//  ibm
//
//  Created by Amit Jain on 2/14/22.
//

import SwiftUI

struct ContentView: View {
    @State  var appPaidFilter:AppFilterType = .any
    @State private var searchText:String  =  ""
    @ObservedObject var appsManager = SoftwareViewModel()
    @State private var selectedGenre:String = Constants.any
    
    //Note for self: Create search in .overlay of another view (e.g. show downloaded apps page & provide search bar in it.)
    //@Environment(\.isSearching) private var isSearching: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                if appsManager.loading {
                    ProgressView()
                } else {
                    if appsManager.apps.count > 0 {
                        FilterView(appPaidFilter: $appPaidFilter,
                                   selectedGenre: $selectedGenre,
                                   appsManager: appsManager)
                    }
                    Divider()
                    
                    AppsListView(
                        filteredApps:appsManager.filteredApps(
                            appPaidFilter: appPaidFilter,
                            selectedGenre: selectedGenre),
                        totalCount:appsManager.apps.count)
                }
            }
            .navigationTitle("Apps")
            .searchable(text: $searchText,
                        prompt: "Type to search in App Store",
                        suggestions: {
                Text("IBM")
                    .searchCompletion("IBM")
            })
            .onChange(of: searchText) { value in
                if searchText.isEmpty {
                    appsManager.clearSearch()
                    selectedGenre = Constants.any
                    appPaidFilter  = .any
                }
            }
            .onSubmit(of: .search) {
                Task.init {
                    if !searchText.isEmpty  {
                        await appsManager.fetchApps(searchText: searchText)
                    } else {
                        appsManager.apps.removeAll()
                    }
                }
                //dismiss keyboard when auto searching for "IBM"
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct FilterView : View {
    @Binding  var appPaidFilter:AppFilterType
    @Binding  var selectedGenre:String
    var appsManager:SoftwareViewModel
    @Environment(\.isSearching) var isSearching:Bool
    
    var body: some View {
        HStack{
            //All, Free or Paid selection
            Picker("", selection: $appPaidFilter) {
                Text("All").tag(AppFilterType.any)
                Text("Free").tag(AppFilterType.free)
                Text("Paid").tag(AppFilterType.paid)
            }
            .pickerStyle(.segmented)
            Divider()
            
            //genre selection
            Menu {
                Picker("", selection: $selectedGenre) {
                    ForEach(appsManager.genres, id: \.self) {
                        Text($0)
                    }
                }
            }label:{
                Label("\(selectedGenre)", systemImage: "chevron.down.circle")
                    .padding(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.blue, lineWidth: 1)
                    )
            }
        }
        .padding(15)
        .fixedSize()
        .onAppear {
            print("\(isSearching), \(appsManager.filteredCount)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
