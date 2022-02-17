//
//  TestData.swift
//  ibm
//
//  Created by Amit Jain on 2/16/22.
//

import Foundation
struct TestData {
    static var apps: [SoftwareModel] = {
        var decodedApps:[SoftwareModel] = []
        do {
            //Using the ! and try! operators can point us to decoding problems during development.
            let url = Bundle.main.url(forResource: "Apps", withExtension: "json")!
            let data = try! Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let result = try! decoder.decode(Result.self, from: data)
            decodedApps = result.results
            print("Async decoded apps", decodedApps)
        }
        return decodedApps
    }()
}
