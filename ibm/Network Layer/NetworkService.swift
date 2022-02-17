//
//  NetworkService.swift
//
//
//  Created by Amit Jain on 2/14/22.
//

import Foundation

public enum HttpMethod : String, Codable {
    case GET
    case POST
    case PUT
    case DELETE
    
    func enumToString() -> String {
        return self.rawValue
    }
}

//force every service implementing NetworkService to set path (& other request params)
public protocol NetworkService {
    var path:String { get set }
    var httpMethodtype:HttpMethod  { get }
    var parameters: [String:Any] { get set }
    init(parameters: [String : Any])
}

extension NetworkService {
    var httpMethodType:HttpMethod { return .GET} //default data
    
    func getBaseUrl() -> String {
        return "https://itunes.apple.com"
    }
    
    func fetchAPI<GenericModel: Decodable>() async throws -> GenericModel  {
        
        if  getBaseUrl().isEmpty  {
            fatalError("Missing URL")
        }
        if self.path.isEmpty  {
            fatalError("Missing Path")
        }
        guard let fullUrl = URL(string: getBaseUrl() + self.path) else {
            fatalError("Missing full URL")
        }
        guard var urlRequest = createGetRequestWithURLComponents(url: fullUrl, parameters: self.parameters, requestType: self.httpMethodtype)  else { fatalError("Missing url components")
        }
        
        urlRequest.httpMethod  = httpMethodtype.enumToString()
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data")
        }
        
        let decoder = JSONDecoder()
        //decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        let decodedData = try decoder.decode(GenericModel.self, from: data)
        
        return decodedData
    }
    
    
    private func createGetRequestWithURLComponents(url:URL,
                                                   parameters: [String:Any],
                                                   requestType: HttpMethod) -> URLRequest? {
        var components = URLComponents(string: url.absoluteString)!
        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: "\(value)")
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        var request = URLRequest(url: components.url ?? url)
        request.httpMethod = requestType.rawValue
        return request
    }
}
