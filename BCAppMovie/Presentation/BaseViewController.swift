//
//  BaseViewController.swift
//  BCAppMovie
//
//  Created by Bruno Cardenas on 14/03/21.
//

import UIKit

class BaseViewController: UIViewController {

    var barNavigationIsHidden: Bool?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 8.0/255.0, green: 206/255.0, blue: 119/255.0, alpha: 1.0)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.lightText] // With a red background, make the title more readable.
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        showNavigation()
    }
    
    private func showNavigation(){
        self.navigationController?.navigationBar.isHidden = barNavigationIsHidden ?? false
    }

}
