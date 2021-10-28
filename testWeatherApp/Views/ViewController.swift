//
//  ViewController.swift
//  testWeatherApp
//
//  Created by Георгий on 20.10.2021.
//

import UIKit
import PinLayout
import CoreData

class ViewController: UIViewController {

    private let tableView: UITableView = UITableView()
    private let searchBar: UISearchBar = UISearchBar()
    
    static let coreDataManager: CoreDataManager = CoreDataManager.shared
    private var data: [CityEntity] = []
    
    private let output: ViewOutput

    init(output: ViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.cellIdentifier)
        tableView.separatorStyle = .none
        
        searchBar.delegate = self
        searchBar.placeholder = "Search city"
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didPullRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        configureNavigationController()
        
        setupData()
        output.updateCities(from: data)
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.pin
            .top(view.pin.safeArea.top)
            .bottom(view.pin.safeArea.bottom)
            .right(view.pin.safeArea.right)
            .left(view.pin.safeArea.left)
        
        searchBar.pin
            .sizeToFit()
    }
    
    private func setupData() {
        ViewController.coreDataManager.initializeCoreDataIfNeeded(success: { [weak self] in
            self?.fetchData()
        }, failure: { error in
            debugPrint("Not ready, error: \(error.localizedDescription)")
        })
    }
    
    private func fetchData() {
        data = ViewController.coreDataManager.fetch(with: CityEntity.fetchRequest())
        tableView.reloadData()
    }
    
    private func configureNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Weather app"
        configureSearchBarButton(shouldShow: true)
    }
    
    private func search(shouldShow: Bool) {
        configureSearchBarButton(shouldShow: !shouldShow)
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchBar : nil
    }
    
    private func configureSearchBarButton(shouldShow: Bool) {
        if shouldShow {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search,
                                                                target: self,
                                                                action: #selector(handleShowSearchBar))
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    @objc private func handleShowSearchBar() {
        search(shouldShow: true)
        searchBar.becomeFirstResponder()
    }
    
    @objc private func didPullRefresh() {
        if !data.isEmpty {
            output.updateCities(from: data)
        } else {
            let alertVC = UIAlertController(title: "You have no cities to update",
                                            message: "Please, upload cities first",
                                            preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "Ok",
                                            style: .default,
                                            handler: nil))
            self.present(alertVC, animated: true, completion: nil)
        }
        self.tableView.refreshControl?.endRefreshing()
    }
    
    func presentingCoincidenceAlert() {
        let coincidenceAlert = UIAlertController(title: "You have already got this city",
                                        message: "Never mind, it is not a big problem",
                                        preferredStyle: .alert)
        coincidenceAlert.addAction(UIAlertAction(title: "Ok",
                                        style: .default,
                                        handler: nil))
        self.present(coincidenceAlert, animated: true, completion: nil)
    }
}

extension ViewController: ViewInput {
    func reloadData() {
        self.fetchData()
    }
    
    func presentAlert() {
        let alertVC = UIAlertController(title: "No city found",
                                        message: "Please, try again",
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok",
                                        style: .default,
                                        handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.cellIdentifier, for: indexPath) as? TableViewCell else {
            
            return .init()
        }
        
        let model: CityEntity = data[indexPath.row]
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            let cityToRemove = self.data[indexPath.row]
            ViewController.coreDataManager.deleteObject(city: cityToRemove)
            self.fetchData()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.didSelectItem(model: data[indexPath.row])
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            if output.checkForCoincidence(models: data, textInput: text) {
                output.loadCity(with: text)
            } else {
                self.presentingCoincidenceAlert()
            }
        }
        search(shouldShow: false)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(shouldShow: false)
    }
}

