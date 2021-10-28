//
//  DetailsViewController.swift
//  testWeatherApp
//
//  Created by Георгий on 27.10.2021.
//


import UIKit
import PinLayout

final class DetailsViewController: UIViewController {
    
    private var cityNameLabel: UILabel = UILabel()
    private var temperatureLabel: UILabel = UILabel()
    private var descriptionLabel: UILabel = UILabel()
    private var secondDescriptionLabel: UILabel = UILabel()
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLabels()
        [cityNameLabel, temperatureLabel, descriptionLabel, secondDescriptionLabel].forEach {
            view.addSubview($0)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        cityNameLabel.pin
            .top(view.pin.safeArea.top + 180)
            .hCenter()
            .width(view.frame.width)
            .height(40)
        
        temperatureLabel.pin
            .below(of: cityNameLabel)
            .marginTop(30)
            .hCenter()
            .width(view.frame.width)
            .height(60)
        
        descriptionLabel.pin
            .below(of: temperatureLabel)
            .marginTop(20)
            .hCenter()
            .width(view.frame.width)
            .height(30)
        
        secondDescriptionLabel.pin
            .below(of: descriptionLabel)
            .marginTop(10)
            .hCenter()
            .width(view.frame.width)
            .height(15)
    }
    
    private func setupLabels() {
        
        cityNameLabel.font = .systemFont(ofSize: 40, weight: .semibold)
        cityNameLabel.textAlignment = NSTextAlignment.center
        
        temperatureLabel.font = .systemFont(ofSize: 60, weight: .medium)
        temperatureLabel.textAlignment = NSTextAlignment.center
        
        descriptionLabel.font = .systemFont(ofSize: 30, weight: .light)
        descriptionLabel.textAlignment = NSTextAlignment.center
        
        secondDescriptionLabel.font = .systemFont(ofSize: 15, weight: .thin)
        secondDescriptionLabel.textAlignment = NSTextAlignment.center
    }
    
    public func configureWithCityEntity(cityEntity: CityEntity) {
        cityNameLabel.text = cityEntity.title
        temperatureLabel.text = "\(cityEntity.temperature ?? "No info")°"
        descriptionLabel.text = cityEntity.firstDescription
        secondDescriptionLabel.text = cityEntity.secondDescription
        title = "Weather app"
    }
}
