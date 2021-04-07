//
//  HomeRouter.swift
//  TheMoviesApp
//
// Created by Bruno Cardenas on 07/04/21.
//
import Foundation
import UIKit

class HomeRouter {
    var viewController: UIViewController {
        return createViewController()
    }
    
    private var sourceView: UIViewController?
    
    private func createViewController() -> UIViewController {
        let view = HomeView(nibName: "HomeView", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView: UIViewController?) {
        guard let view = sourceView else {fatalError("Error desconocido")}
        self.sourceView = view
    }
    
    func navigateToDetailView(movieID: String) {
        let detailView = DetailRouter(movieID: movieID).viewController
        sourceView?.navigationController?.pushViewController(detailView, animated: true)
    }
}
