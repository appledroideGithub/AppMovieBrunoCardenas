//
//  LoginViewModel.swift
//  BCAppMovie
//
//  Created by Bruno Cardenas on 07/04/21.
//

import Foundation
import RxSwift

class LoginViewModel {
    
    private var managerConnections = LoginApiManager()
    private weak var view: LoginView?
    private var router: LoginRouter?
    
    func bind(view: LoginView, router: LoginRouter) {
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func getToken() -> Observable<TokenEntity> {
        return managerConnections.getToken()
    }
    
    func loginWithUser(user: UserEntity) -> Observable<TokenEntity> {
        return managerConnections.login(user: user)
    }
}
