//
//  LoginRouter.swift
//  BCAppMovie
//
//  Created by Bruno Cardenas on 07/04/21.
//

import Foundation
import UIKit

class LoginRouter {
    
    private var sourceView: UIViewController?

    func navigateToHomeView() {
        let homeView = HomeView(nibName: "HomeView", bundle: nil)
        sourceView?.navigationController?.pushViewController(homeView, animated: true)
    }
    
    func setSourceView(_ sourceView: UIViewController?){
        guard let view = sourceView else {fatalError("Error")}
        self.sourceView = view
    }
}
