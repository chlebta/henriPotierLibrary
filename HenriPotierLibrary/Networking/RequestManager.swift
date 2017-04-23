//
//  RequestManager.swift
//  HenriPotierLibrary
//
//  Created by Ahmed K on 19/04/2017.
//  Copyright © 2017 Ahmed K. All rights reserved.
//

import Foundation
import Alamofire

typealias ResponseHandler  = (_ response: Any?, _ error: Error?) -> Void


enum RequestError: Error {
    case unknown
    case noInternet
    
    var description : String {
        switch self {
        case .unknown:
            return "Unknow error"
        case .noInternet:
            return "No internet connection"
        }
    }
}

class RequestManager {
    
    fileprivate var url: String
    fileprivate var method: Alamofire.HTTPMethod
    fileprivate var parameters: [String : AnyObject]?
    
    
    init(url: String, method : Alamofire.HTTPMethod? = nil, parameters: [String : AnyObject]? = nil) {
        self.url = url
        self.method = method ?? .get
        self.parameters = parameters
    }

}

//MARK: Actions
extension RequestManager {
    
    func responseJSON(_ result: ResponseHandler? = nil) {
        
        Alamofire.request(self.url, method: self.method, parameters: parameters)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    result?(response.result.value, nil)
                    
                case .failure(let error):
                    print("Error : \(error)")
                    
                    if let error = error as? URLError,
                        error.code  == URLError.Code.notConnectedToInternet {
                        result?(nil, RequestError.noInternet)
                    }
                    else { result?(nil, RequestError.unknown) }

                }
        }
    }
}


