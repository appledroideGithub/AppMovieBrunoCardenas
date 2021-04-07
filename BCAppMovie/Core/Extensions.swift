//
//  Extensions.swift
//  BCAppMovie
//
//  Created by Bruno Cardenas on 07/04/21.
//

import UIKit

extension UIImageView {
    
    func downloadImage(urlImage: String, placeHolderImage: UIImage) {
        
        if self.image == nil {
            self.image = placeHolderImage
        }
        
        URLSession.shared.dataTask(with: URL(string: urlImage)!) { (data, response, error) in
            
            if error != nil {
                return
            }
            
            DispatchQueue.main.async {
                guard let data = data else { return }
                let image = UIImage(data: data)
                self.image = image
            }
            
        }.resume()
    }
}

extension RegistrationError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidEmail:
            return NSLocalizedString("Datos Incorrectos", comment: "Datos Incorrectos")
        case .invalidPassword:
            return NSLocalizedString("Datos Incorrectos", comment: "Datos incorrectos")
        }
    }
}
