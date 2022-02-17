//
//  PhotoService.swift
//
//
//  Created by Amit Jain on 2/14/22.
//

import Foundation

class SoftwareService: NetworkService {
    var parameters: [String : Any]
    
    required init(parameters: [String : Any]) {
        self.parameters = parameters
    }
    
    var path = "/search"
    let httpMethodtype = HttpMethod.GET
    
    func callSoftwareApi() async throws  -> [SoftwareModel] {
        let result:Result = try await fetchAPI()
#if DEBUG
        print("Resp: \(String(describing: result.results.first))")
#endif
        return result.results //Any
        
    }
}
