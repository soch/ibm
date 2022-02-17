//
//  AppsListView.swift
//  ibm
//
//  Created by Amit Jain on 2/15/22.
//

import SwiftUI

struct AppsListView: View {
    var filteredApps:[SoftwareModel]
    var totalCount:Int
    
    var body: some View {
        VStack(alignment:.leading)
        {
            Text(header()).padding([.leading], 15)
            Divider()
            ScrollView { //https://developer.apple.com/forums/thread/682498?login=true
                ForEach  (filteredApps, id: \.trackId ) {(software) in
                    SoftwareRowView(software:software)
                    Divider()
                }
            }
        }
    }
    
    func header() -> String {
        switch totalCount  {
        case 0:
            return ""
        case filteredApps.count:
            return "\(totalCount) apps found"
        default:
            return "Apps: \(filteredApps.count) of \(totalCount)"
        }
    }
}

struct AppsListView_Previews: PreviewProvider {
    static let apps = TestData.apps
    static var previews: some View {
        AppsListView(filteredApps: apps,totalCount:4)
    }
}
