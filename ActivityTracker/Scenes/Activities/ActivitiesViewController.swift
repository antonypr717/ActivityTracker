//
//  ActivitiesViewController.swift
//  ActivityTracker
//
//  Created by Antony Raphel on 03/12/18.
//  Copyright (c) 2018 Antony Raphel. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ActivitiesDisplayLogic: class {
    func displaySomething(viewModel: Activities.Something.ViewModel)
}

class ActivitiesViewController: UIViewController, ActivitiesDisplayLogic {
    var interactor: ActivitiesBusinessLogic?
    var router: (NSObjectProtocol & ActivitiesRoutingLogic & ActivitiesDataPassing)?
    
    // MARK: Object lifecycle
    @IBOutlet weak var tblView: UITableView!
    
    var arr = [String]()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = ActivitiesInteractor()
        let presenter = ActivitiesPresenter()
        let router = ActivitiesRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        doSomething()
    }
    
    // MARK: Do something
    func doSomething() {
        let request = Activities.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    private func setupView() {
        tblView.estimatedRowHeight = 70.0
        tblView.rowHeight = UITableView.automaticDimension
        tblView.tableFooterView = UIView()
    }
    
    func displaySomething(viewModel: Activities.Something.ViewModel) {
        //nameTextField.text = viewModel.name
    }
}

extension ActivitiesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let lCell = tableView.dequeueReusableCell(withIdentifier: "ActivitiesTableViewCell", for: indexPath) as! ActivitiesTableViewCell
        return lCell
    }
    
}
