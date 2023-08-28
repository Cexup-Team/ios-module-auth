//
//  File.swift
//  
//
//  Created by Iqbal Nur Haq on 29/01/23.
//

import Foundation
import Combine
import Alamofire
import Core

public struct RegisterRemoteDataSource: DataSource {
   
    
    public typealias Request = Any
    public typealias Response = Bool
    
    private let _endpoint: String
    private let _apiKey: String
    
    public init(endpoint: String, apiKey: String) {
        _endpoint = endpoint
        _apiKey = apiKey
    }
    
    public func execute(request: Any?) -> AnyPublisher<Bool, Error> {
    
        
        let headers: HTTPHeaders = [
            "x-api-key" : _apiKey
        ]
        
        return Future<Bool, Error> { completion in
            if let url = URL(string: _endpoint) {
                AF.request(url, method: .post, parameters: request as? Parameters, encoding: JSONEncoding.default, headers: headers)
                    .responseDecodable(of: AuthResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            print(value)
                            if  200 ... 299 ~= Int(value.code)!{
                                completion(.success(true))
                            }else{
                                completion(.failure(URLError.custom(value.message)))
                            }

                        case .failure(_):
                            completion(.failure(URLError.invalidRequest))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
}
