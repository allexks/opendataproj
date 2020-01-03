//
//  OpenDataAPIService.swift
//  Open Data Project
//
//  Created by Yalishanda on 3.01.20.
//  Copyright © 2020 fmi-swift. All rights reserved.
//

import Foundation

class OpenDataAPIService {

    func getDataSetResources(_ completion: @escaping ([String: Any]?) -> Void) {
        let endpoint: Endpoint = .listResources
        let jsonRequestBody: [String: Any] = [
            "criteria": [
                "dataset_uri": OpenDataAPIService.dataSetGuid
            ]
        ]
        performPOSTRequest(to: endpoint, withJSONBody: jsonRequestBody) { response in
            guard let response = response else {
                completion(nil)
                return
            }
            
            completion(response)
        }
    }
    
    func getResourceData(_ resourceGuid: String, completion: @escaping ([String: Any]?) -> Void) {
        let endpoint: Endpoint = .getResourceData
        let jsonRequestBody: [String: Any] = [:]
        performPOSTRequest(to: endpoint, withJSONBody: jsonRequestBody) { response in
            guard let response = response else {
                completion(nil)
                return
            }
            
            completion(response)
        }
    }
}

extension OpenDataAPIService {
    enum Endpoint: String {
        case listResources
        case getResourceData
    }
}

private extension OpenDataAPIService {
    
    static let APIURI = "http://data.egov.bg/api"
    
    static let dataSetGuid = "f7d45237-a310-4c43-b37f-db434f8edf3d"
    
    static let defaultTimeout = TimeInterval(60)
    
    func performPOSTRequest(to endpoint: Endpoint, withJSONBody body: [String: Any], withCompletion completion: @escaping (_ jsonResponse: [String: Any]?) -> Void) {
        let endpointString = endpoint.rawValue
        
        guard let url = URL(string: "\(OpenDataAPIService.APIURI)/\(endpointString)") else {
            fatalError("oprai si url-a")
        }
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: body) else {
            fatalError("oprai si json-a")
        }
        
        var urlRequest = URLRequest(
            url: url,
            cachePolicy: .returnCacheDataElseLoad,
            timeoutInterval: OpenDataAPIService.defaultTimeout
        )
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = httpBody
        
        DispatchQueue.global(qos: .userInitiated).async {
            URLSession.shared.dataTask(with: urlRequest) { data, _, error in
                guard let data = data, error == nil else {
                    print("ni moa fetchna: \(error?.localizedDescription ?? "")")
                    completion(nil)
                    return
                }
                
                var response: Any? = nil
                do {
                    response = try JSONSerialization.jsonObject(with: data)
                } catch let err {
                    print("ni moa konvertiram v json: \(err.localizedDescription)")
                    completion(nil)
                    return
                }
                
                if let jsonResponse = response as? [String: Any],
                    let success = jsonResponse["success"] as? Bool,
                    success == true {
                    completion(jsonResponse)
                } else {
                    print(response as Any)
                    completion(nil)
                }
            }.resume()
        }
    }
}
