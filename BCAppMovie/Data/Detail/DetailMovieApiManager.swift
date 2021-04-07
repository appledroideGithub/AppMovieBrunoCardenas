//
//  DetailMovieApiManager.swift
//  BCAppMovie
//
//  Created by Bruno Cardenas on 07/04/21.
//

import Foundation
import RxSwift

class DetailMovieApiManager: BaseApiManager<MovieDetail,Error> {
    
    func getDetailMovies(movieID: String) -> Observable<MovieDetail> {
        urlPath = Constants.URL.main+Constants.Endpoints.urlDetailMovie+movieID+Constants.apiKey
        httpMethod = .GET
        createRequest()
        return requestToService()
    }
    
    func getImageFromServer(urlString: String) -> Observable<UIImage> {
        
        return Observable.create { observer in
            
            let placeHolderImage = UIImage(named: "background")!
            
            URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
                
                guard let data = data, error == nil, let response = response as? HTTPURLResponse else { return }
                
                if error != nil {
                    print(error ?? "No Error")
                    return
                }
                
                if response.statusCode == 200 {
                        guard let image = UIImage(data: data) else { return }
                        observer.onNext(image)
                } else {
                    observer.onNext(placeHolderImage)
                }
                //MARK: observer onCompleted event
                observer.onCompleted()
                
            }).resume()
            
            //MARK: return our disposable
            return Disposables.create {}
        }
    }
}
