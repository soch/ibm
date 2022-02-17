//
//  AppDetailView.swift
//  ibm
//
//  Created by Amit Jain on 2/15/22.
//

import SwiftUI

/*
 each app’s details, including app name, app icon, description, all screen shots, price, size, version, etc.
 */
struct AppDetailView: View {
    var software:SoftwareModel
    
    var body: some View {
        GroupBox{
            VStack(spacing:15){
                HStack{
                    AppImage(imageURL:software.artworkUrl60, width: 75).cornerRadius(10)
                    Text(software.trackName).font(.title2)
                    Spacer()
                }
                HStack{
                    Cell(model: CellModel(title:"Price", value: software.formattedPrice ?? "Free"))
                    Spacer()
                    Cell(model: CellModel(title:"Version", value:software.version))
                }
                HStack{
                    Cell(model: CellModel(title:"Size", value:software.fileSizeBytes ?? "--"))
                    Spacer()
                    Cell(model: CellModel(title:"Category", value:software.primaryGenreName ))
                }
                Divider()
                HStack{
                    Text("Description")
                    Text(software.resultDescription ?? "")
                }
                Divider()
                
                //screenshots
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        ForEach(software.screenshotUrls, id: \.self) {
                            AppImage(imageURL:$0, width: 200)
                        }
                    }
                }
            }
        }
        .padding(10)
        .frame(minWidth: 100, maxWidth:.infinity)
        .navigationTitle(software.trackName)
        .navigationBarTitleDisplayMode(.inline)
        Spacer()
    }
    
}

struct Cell: View {
    var model: CellModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(model.title)
                .font(.system(size: 13.0, weight: .light))
                .frame(width: 150, alignment: .leading)
            Text(model.value)
                .minimumScaleFactor(0.01)
                .frame(width: 150, alignment: .leading)
        }
    }
}

struct CellModel {
    var title : String
    var value : String
}

struct AppDetailView_Previews: PreviewProvider {
    static let software = TestData.apps[0]
    static var previews: some View {
        AppDetailView(software: software)
    }
}
