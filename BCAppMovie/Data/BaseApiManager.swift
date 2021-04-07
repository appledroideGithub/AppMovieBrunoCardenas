//
//  BaseApiManager.swift
//  BCAppMovie
//
//  Created by Bruno Cardenas on 14/03/21.
//

import Foundation
import RxSwift

enum HTTPMehod: String {
    case GET
    case POST
}

class BaseApiManager<CVCodable,CVError>: NSObject where CVCodable: Codable, CVError: Error {
    let session = URLSession.shared
    var request : URLRequest?
    var urlPath: String?
    var httpMethod: HTTPMehod?
    var bodyRequest: Data?
    
    func createRequest(){
        guard let urlString = self.urlPath else {
            return
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        self.request = URLRequest(url: url)
        self.request?.httpMethod = self.httpMethod?.rawValue
        self.request?.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let bodyPost = self.bodyRequest else {
            return
        }
        
        self.request?.httpBody = bodyPost
    }
    
    func addBody<CVRequest> (_ body: CVRequest?) where CVRequest: Encodable {
        do {
            bodyRequest = try JSONEncoder().encode(body)
        } catch let error {
            print("error " + error.localizedDescription)
        }
    }
    
    func requestToService() -> Observable<CVCodable>{
        return Observable.create { [weak self] observer in
            
            self?.session.dataTask(with: (self?.request)!) { (data, response, error) in
                
                guard let data = data, error == nil, let response = response as? HTTPURLResponse else { return }
                
                print(response)
                if response.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let objectDecode = try decoder.decode(CVCodable.self, from: data)
                        observer.onNext(objectDecode)
                    } catch let error{
                        observer.onError(error)
                        print("Ha ocurrido un error: \(error.localizedDescription)")
                    }
                }
                else if response.statusCode == 401 || response.statusCode == 400 {
                    print("Error 401")
                    observer.onError(RegistrationError.invalidEmail)
                }
                else
                {
                    observer.onCompleted()
                }
                self?.bodyRequest = nil
            }.resume()
            return Disposables.create {
                self!.session.finishTasksAndInvalidate()
            }
            
        }
    }
    
}
