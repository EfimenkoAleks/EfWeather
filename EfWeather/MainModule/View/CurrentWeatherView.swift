//
//  CurrentWeatherView.swift
//  EfWeather
//
//  Created by user on 18.01.2021.
//  Copyright © 2021 user. All rights reserved.
//

import UIKit

class CurrentWeatherView: UIView {
    
    var const: CGFloat?
    
    var conteinerView: UIView = {
        let bg = UIView()
        bg.backgroundColor = .clear
        bg.translatesAutoresizingMaskIntoConstraints = false
        return bg
    }()
    
    var conteinerTempView: UIView = {
        let bg = UIView()
        bg.backgroundColor = .clear
        bg.translatesAutoresizingMaskIntoConstraints = false
        return bg
    }()
    
    var conteinerHumidityView: UIView = {
        let bg = UIView()
        bg.backgroundColor = .clear
        bg.translatesAutoresizingMaskIntoConstraints = false
        return bg
    }()
    
    var conteinerWindView: UIView = {
        let bg = UIView()
        bg.backgroundColor = .clear
        bg.translatesAutoresizingMaskIntoConstraints = false
        return bg
    }()
    
    var conteinerContTempView: UIView = {
        let bg = UIView()
        bg.backgroundColor = .clear
        bg.translatesAutoresizingMaskIntoConstraints = false
        return bg
    }()
    
    var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "01n")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var windImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "ic_wind")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var directionWindImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "icon_wind_ne")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var tempImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "ic_temp")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var humidityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.image = UIImage(named: "ic_humidity")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var humidityLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 22)
        lb.text = "33%"
        lb.textColor = Helper.shared.hexStringToUIColor(hex: "#FFFFFF")
        lb.backgroundColor = .clear
        lb.numberOfLines = 1
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    var windLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 22)
        lb.text = "5м/сек"
        lb.textColor = Helper.shared.hexStringToUIColor(hex: "#FFFFFF")
        lb.backgroundColor = .clear
        lb.numberOfLines = 1
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    var tempDayLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .right
        lb.font = UIFont.systemFont(ofSize: 22)
        lb.text = "27"
        lb.textColor = Helper.shared.hexStringToUIColor(hex: "#FFFFFF")
        lb.backgroundColor = .clear
        lb.numberOfLines = 1
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    var tempSeparateLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 22)
        lb.text = "/"
        lb.textColor = Helper.shared.hexStringToUIColor(hex: "#FFFFFF")
        lb.backgroundColor = .clear
        lb.numberOfLines = 1
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    var tempNightLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 22)
        lb.text = "19"
        lb.textColor = Helper.shared.hexStringToUIColor(hex: "#FFFFFF")
        lb.backgroundColor = .clear
        lb.numberOfLines = 1
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    var dayLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 17)
        lb.text = "ЧТ, 19 июля"
        lb.textColor = Helper.shared.hexStringToUIColor(hex: "#FFFFFF")
        lb.backgroundColor = .clear
        lb.numberOfLines = 1
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Helper.shared.hexStringToUIColor(hex: "#4A90E2") 
        self.const = gSizeWidth
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
        self.addSubview(dayLabel)
        
        dayLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        dayLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        dayLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        dayLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: gSizeHeight / 10).isActive = true
        
        weatherImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: const! / 15).isActive = true
        weatherImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -const! / 4).isActive = true
        weatherImageView.heightAnchor.constraint(equalToConstant: const! / 2.3).isActive = true
        weatherImageView.widthAnchor.constraint(equalTo: weatherImageView.heightAnchor).isActive = true
        
        conteinerView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: const! / 15).isActive = true
        conteinerView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: const! / 4).isActive = true
        conteinerView.heightAnchor.constraint(equalTo: weatherImageView.heightAnchor).isActive = true
        conteinerView.widthAnchor.constraint(equalTo: weatherImageView.widthAnchor).isActive = true
        
        // Добавляем контейнеры для строк погоды , влажности , ветра
        conteinerView.addSubview(conteinerTempView)
        conteinerView.addSubview(conteinerHumidityView)
        conteinerView.addSubview(conteinerWindView)
        
        conteinerTempView.widthAnchor.constraint(equalTo: conteinerView.widthAnchor).isActive = true
        conteinerTempView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        conteinerTempView.centerXAnchor.constraint(equalTo: conteinerView.centerXAnchor).isActive = true
        conteinerTempView.bottomAnchor.constraint(equalTo: conteinerHumidityView.topAnchor, constant: -10).isActive = true
        
        conteinerHumidityView.widthAnchor.constraint(equalTo: conteinerView.widthAnchor).isActive = true
        conteinerHumidityView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        conteinerHumidityView.centerXAnchor.constraint(equalTo: conteinerView.centerXAnchor).isActive = true
        conteinerHumidityView.centerYAnchor.constraint(equalTo: conteinerView.centerYAnchor).isActive = true
        
        conteinerWindView.widthAnchor.constraint(equalTo: conteinerView.widthAnchor).isActive = true
        conteinerWindView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        conteinerWindView.centerXAnchor.constraint(equalTo: conteinerView.centerXAnchor).isActive = true
        conteinerWindView.topAnchor.constraint(equalTo: conteinerHumidityView.bottomAnchor, constant: 10).isActive = true
        
        self.temp()
        self.humidity()
        self.wind()
    }
    
    private func temp() {
        
        conteinerTempView.addSubview(tempImageView)
        conteinerTempView.addSubview(conteinerContTempView)
        
        tempImageView.centerYAnchor.constraint(equalTo: conteinerTempView.centerYAnchor).isActive = true
        tempImageView.widthAnchor.constraint(equalToConstant: const! / 15).isActive = true
        tempImageView.heightAnchor.constraint(equalTo: tempImageView.widthAnchor).isActive = true
        tempImageView.leadingAnchor.constraint(equalTo: conteinerTempView.leadingAnchor, constant: 8).isActive = true
        
        conteinerContTempView.widthAnchor.constraint(equalToConstant: const! / 5).isActive = true
        conteinerContTempView.heightAnchor.constraint(equalTo: conteinerTempView.heightAnchor).isActive = true
        conteinerContTempView.centerYAnchor.constraint(equalTo: conteinerTempView.centerYAnchor).isActive = true
        conteinerContTempView.leadingAnchor.constraint(equalTo: tempImageView.trailingAnchor, constant: 0).isActive = true
        
        conteinerContTempView.addSubview(tempDayLabel)
        conteinerContTempView.addSubview(tempSeparateLabel)
        conteinerContTempView.addSubview(tempNightLabel)
        
        tempDayLabel.centerYAnchor.constraint(equalTo: conteinerContTempView.centerYAnchor).isActive = true
        tempDayLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        tempDayLabel.heightAnchor.constraint(equalTo: conteinerContTempView.heightAnchor).isActive = true
        tempDayLabel.leadingAnchor.constraint(equalTo: conteinerContTempView.leadingAnchor).isActive = true
        
        tempSeparateLabel.centerYAnchor.constraint(equalTo: conteinerContTempView.centerYAnchor).isActive = true
        tempSeparateLabel.leadingAnchor.constraint(equalTo: tempDayLabel.trailingAnchor).isActive = true
        tempSeparateLabel.widthAnchor.constraint(equalToConstant: 20).isActive = true
        tempSeparateLabel.heightAnchor.constraint(equalTo: tempDayLabel.heightAnchor).isActive = true
        
        tempNightLabel.centerYAnchor.constraint(equalTo: conteinerContTempView.centerYAnchor).isActive = true
        tempNightLabel.widthAnchor.constraint(equalTo: tempDayLabel.widthAnchor).isActive = true
        tempNightLabel.heightAnchor.constraint(equalTo: tempDayLabel.heightAnchor).isActive = true
        tempNightLabel.leadingAnchor.constraint(equalTo: tempSeparateLabel.trailingAnchor).isActive = true
    }
    
    private func humidity() {
        
        conteinerHumidityView.addSubview(humidityImageView)
        conteinerHumidityView.addSubview(humidityLabel)
        
        humidityImageView.centerYAnchor.constraint(equalTo: conteinerHumidityView.centerYAnchor).isActive = true
        humidityImageView.widthAnchor.constraint(equalToConstant: const! / 15).isActive = true
        humidityImageView.heightAnchor.constraint(equalTo: humidityImageView.widthAnchor).isActive = true
        humidityImageView.leadingAnchor.constraint(equalTo: conteinerHumidityView.leadingAnchor,constant: 8).isActive = true
        
        humidityLabel.centerYAnchor.constraint(equalTo: conteinerHumidityView.centerYAnchor).isActive = true
        humidityLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        humidityLabel.heightAnchor.constraint(equalTo: conteinerHumidityView.heightAnchor).isActive = true
        humidityLabel.leadingAnchor.constraint(equalTo: humidityImageView.trailingAnchor, constant: 10).isActive = true
    }
    
    private func wind() {
        conteinerWindView.addSubview(windImageView)
        conteinerWindView.addSubview(windLabel)
        conteinerWindView.addSubview(directionWindImageView)
        
        windImageView.centerYAnchor.constraint(equalTo: conteinerWindView.centerYAnchor).isActive = true
        windImageView.widthAnchor.constraint(equalToConstant: const! / 15).isActive = true
        windImageView.heightAnchor.constraint(equalTo: windImageView.widthAnchor).isActive = true
        windImageView.leadingAnchor.constraint(equalTo: conteinerWindView.leadingAnchor, constant: 8).isActive = true
        
        windLabel.centerYAnchor.constraint(equalTo: conteinerWindView.centerYAnchor).isActive = true
        windLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        windLabel.heightAnchor.constraint(equalTo: conteinerWindView.heightAnchor).isActive = true
        windLabel.leadingAnchor.constraint(equalTo: windImageView.trailingAnchor, constant: 10).isActive = true
        
        directionWindImageView.centerYAnchor.constraint(equalTo: conteinerWindView.centerYAnchor).isActive = true
        directionWindImageView.widthAnchor.constraint(equalTo: conteinerWindView.heightAnchor).isActive = true
        directionWindImageView.heightAnchor.constraint(equalTo: directionWindImageView.widthAnchor).isActive = true
        directionWindImageView.leadingAnchor.constraint(equalTo: windLabel.trailingAnchor, constant: 8).isActive = true
    }
    
}
