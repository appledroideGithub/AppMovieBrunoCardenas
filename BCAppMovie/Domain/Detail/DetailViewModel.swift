//
//  DetailViewModel.swift
//  TheMoviesApp
//
// Created by Bruno Cardenas on 07/04/21.
//

import Foundation
import RxSwift

class DetailViewModel {
    private var managerConnections = DetailMovieApiManager()
    private(set) weak var view: DetailView?
    private var router: DetailRouter?
    
    func bind(view: DetailView, router: DetailRouter) {
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func getMovieData(movieID: String) -> Observable<MovieDetail> {
        return managerConnections.getDetailMovies(movieID: movieID)
    }
    
    func getImageMovie(urlString: String) -> Observable<UIImage> {
        return managerConnections.getImageFromServer(urlString: urlString)
    }
}
