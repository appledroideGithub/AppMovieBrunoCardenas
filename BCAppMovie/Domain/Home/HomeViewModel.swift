//
//  HomeViewModel.swift
//  BCAppMovie
//
//  Created by Bruno Cardenas on 07/04/21.
//

import Foundation
import RxSwift
class HomeViewModel{
    
    private weak var view: HomeView?
    private var router: HomeRouter?
    private var managerConnection = HomeApiManager()
    
     
    func gestListMoviesData(page:Int) -> Observable<Movies> {
        return managerConnection.getPopularMovies(page: page)
    }
    
    func bind(view: HomeView, router: HomeRouter) {
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makeDetailView(movieID: String) {
        router?.navigateToDetailView(movieID: movieID)
    }
}
