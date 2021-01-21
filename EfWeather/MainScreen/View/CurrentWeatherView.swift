//
//  CurrentWeatherView.swift
//  EfWeather
//
//  Created by user on 18.01.2021.
//  Copyright © 2021 user. All rights reserved.
//

import UIKit

class CurrentWeatherView: UIView {
    
    var conteinerView: UIView = {
          let bg = UIView()
          bg.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
          bg.translatesAutoresizingMaskIntoConstraints = false
          return bg
      }()
      
      var weatherImageView: UIImageView = {
            let imageView = UIImageView()
          imageView.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            imageView.image = UIImage(named: "ic_white_day_cloudy")
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.layer.masksToBounds = true
          imageView.layer.borderWidth = 1
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .brown
        self.createView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CurrentWeatherView {
    
    func createView() {
        self.addSubview(weatherImageView)
        self.addSubview(conteinerView)
        
        weatherImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        weatherImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -80).isActive = true
        weatherImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        weatherImageView.widthAnchor.constraint(equalTo: weatherImageView.heightAnchor).isActive = true
        
        conteinerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        conteinerView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 80).isActive = true
        conteinerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        conteinerView.widthAnchor.constraint(equalTo: conteinerView.heightAnchor).isActive = true
        

    }
}
