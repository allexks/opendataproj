//
//  OpenDataAPIService.swift
//  Open Data Project
//
//  Created by Yalishanda on 3.01.20.
//  Copyright © 2020 fmi-swift. All rights reserved.
//

import Foundation

class OpenDataAPIService {

    func getDataSetResources(_ completion: @escaping (ResourceList?) -> Void) {
        let endpoint: Endpoint = .listResources
        let jsonRequestBody = [
            "criteria": [
                "dataset_uri": OpenDataAPIService.dataSetGuid
            ]
        ]
        
        performPOSTRequest(to: endpoint, withJSONBody: jsonRequestBody) { response in
            guard let response = response else {
                completion(nil)
                return
            }
            
            do {
                let list = try OpenDataAPIService.decoder.decode(ResourceList.self, from: response)
                completion(list)
            } catch let err {
                print("nimoish kodish: \(err.localizedDescription)")
                completion(nil)
            }
            
        }
    }
    
    func getResourceData(_ resourceGuid: String, completion: @escaping (ResourceData?) -> Void) {
        let endpoint: Endpoint = .getResourceData
        let jsonRequestBody = ["resource_uri": resourceGuid]
        
        performPOSTRequest(to: endpoint, withJSONBody: jsonRequestBody) { response in
            guard let response = response else {
                completion(nil)
                return
            }
            
            do {
                let data = try OpenDataAPIService.decoder.decode(ResourceData.self, from: response)
                completion(data)
            } catch let err {
                print("teq danni mai ne sa tolkova otvoreni: \(err.localizedDescription)")
                completion(nil)
            }
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
    
    static let APIURI = "https://data.egov.bg/api"
    
    static let dataSetGuid = "f7d45237-a310-4c43-b37f-db434f8edf3d"
    
    static let defaultTimeout = TimeInterval(60)
    
    static let urlSession = URLSession.shared
    
    static let decoder = JSONDecoder()
    
    func performPOSTRequest(to endpoint: Endpoint, withJSONBody body: [String: Any], withCompletion completion: @escaping (_ jsonResponse: Data?) -> Void) {
        let endpointString = endpoint.rawValue
        let urlString = "\(OpenDataAPIService.APIURI)/\(endpointString)"
        
        guard let url = URL(string: urlString) else {
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
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        DispatchQueue.global(qos: .userInitiated).async {
            OpenDataAPIService.urlSession.dataTask(with: urlRequest) { data, _, error in
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
                    completion(data)
                } else {
                    print(response as Any)
                    completion(nil)
                }
            }.resume()
        }
    }
}
