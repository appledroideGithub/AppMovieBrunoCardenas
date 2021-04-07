//
//  LoginView.swift
//  BCAppMovie
//
//  Created by Bruno Cardenas on 07/04/21.
//

import UIKit
import RxSwift
import ProgressHUD
import SwiftMessages
class LoginView: BaseViewController {

    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var viewModel = LoginViewModel()
    private var loginRouter = LoginRouter()
    private var disposeBag = DisposeBag()
    private var tokenEntity: TokenEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //INYECCIÓN DE DEPENDENCIAS 
        viewModel.bind(view: self, router: loginRouter)
        customize()
    }
    
    func customize()
    {
        self.btnLogin.layer.cornerRadius = 10
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.barNavigationIsHidden = true
        super.viewWillAppear(animated)
    }
    func getToken(){
        ProgressHUD.show()
        return viewModel.getToken()
            .subscribe(
                onNext: { tokenEntity in
                    self.tokenEntity = tokenEntity
                    print("SE obtuvo token")
                    DispatchQueue.main.async {
                        self.setLogin()
                        return
                    }

            }, onError: { error in
                print(error.localizedDescription)
                
                ProgressHUD.dismiss()
            }, onCompleted: {
                ProgressHUD.dismiss()
            }).disposed(by: disposeBag)
    }
    
    func setLogin(){
        return viewModel.loginWithUser(user: UserEntity(username: userTextField.text!, password: passwordTextField.text!, request_token: self.tokenEntity?.request_token!))
            .subscribe(
                onNext: { tokenEntity in
                    print("SESSION INICIADA")
                    DispatchQueue.main.async {
                        ProgressHUD.dismiss()
                        self.loginRouter.navigateToHomeView()
                        return
                        
                    }
            }, onError: { error in
                DispatchQueue.main.async {
                    print(error.localizedDescription)
                    ProgressHUD.dismiss()
                    self.showAlert(tittle: "Mensaje", message: error.localizedDescription)
                    print("SE obtuvo error iniciando sesion")
                }
            }, onCompleted: {
                DispatchQueue.main.async {
                    ProgressHUD.dismiss()
                }
                

            }).disposed(by: disposeBag)
    }
        
    @IBAction func onStartSession(_ sender: Any) {
        self.getToken()
    }
    
    func showAlert(tittle: String, message: String){
        let alert =  UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelar = UIAlertAction(title: "Ok", style: .default, handler: {(action) in  })
        alert.addAction(cancelar)
        present(alert, animated: true, completion: nil)
    }
}
        
