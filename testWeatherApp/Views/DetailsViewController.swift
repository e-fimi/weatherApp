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
        assignbackground()
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
        
        temperatureLabel.font = .systemFont(ofSize: 60, weight: .medium)
        
        descriptionLabel.font = .systemFont(ofSize: 30, weight: .light)
        
        secondDescriptionLabel.font = .systemFont(ofSize: 15, weight: .thin)
        
        [cityNameLabel, temperatureLabel, descriptionLabel, secondDescriptionLabel].forEach {
            $0.textAlignment = NSTextAlignment.center
            $0.textColor = .white
        }
    }
    
    public func configureWithCityEntity(cityEntity: CityEntity) {
        cityNameLabel.text = cityEntity.title
        temperatureLabel.text = "\(cityEntity.temperature ?? "No info")°"
        descriptionLabel.text = cityEntity.firstDescription
        secondDescriptionLabel.text = cityEntity.secondDescription
        title = "Weather app"
    }
    
    func assignbackground(){
           let background = UIImage(named: "night")
           var imageView : UIImageView!
           imageView = UIImageView(frame: view.bounds)
           imageView.contentMode =  UIView.ContentMode.scaleAspectFill
           imageView.clipsToBounds = true
           imageView.image = background
           imageView.center = view.center
           view.addSubview(imageView)
           self.view.sendSubviewToBack(imageView)
    }
}
