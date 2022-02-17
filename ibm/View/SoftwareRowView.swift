//
//  SoftwareRowView.swift
//  ibm
//
//  Created by Amit Jain on 2/15/22.
//

import SwiftUI

struct SoftwareRowView: View {
    var software:SoftwareModel
    
    var body: some View {
        NavigationLink(destination:AppDetailView(software:software)) {
            HStack {
                AppImage(imageURL: software.artworkUrl60, width: 60).cornerRadius(6)
                Text("\(software.trackName)")
                    .frame(alignment: .leading)
                Spacer()
                Text(software.formattedPrice ?? "Free")
                    .foregroundColor(.primary)
                    .frame(alignment: .leading)
            }
            .frame(alignment: .leading)
            .padding()
        }
    }
}

struct SoftwareRowView_Previews: PreviewProvider {
    static let software = TestData.apps[0]
    static var previews: some View {
        SoftwareRowView(software: software)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}

