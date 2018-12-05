//
//  AddMembersViewController.swift
//  ActivityTracker
//
//  Created by Antony Raphel on 05/12/18.
//  Copyright (c) 2018 Antony Raphel. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol AddMembersDisplayLogic: class {
    func display(viewModel: AddMembers.Fetch.ViewModel)
    func displaySomething(viewModel: AddMembers.Something.ViewModel)
}

class AddMembersViewController: UIViewController, AddMembersDisplayLogic, TextFrame {
    
    typealias field = UITextField
    var textField: UITextField = UITextField()
    let imagePicker = UIImagePickerController()

    var completionHandler: (AddActivities.Member.Response.MemberResponse?) -> Void = { arg in }

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var descTxt: UITextField!
    
    var interactor: AddMembersBusinessLogic?
    var router: (NSObjectProtocol & AddMembersRoutingLogic & AddMembersDataPassing)?
    
    // MARK: Object lifecycle
    
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
        let interactor = AddMembersInteractor()
        let presenter = AddMembersPresenter()
        let router = AddMembersRouter()
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
        setUpView()
        fetch()
    }
    
    private func setUpView() {
        imagePicker.delegate = self
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddMembersViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    private func fetch() {
        let requst = AddMembers.Fetch.Request()
        interactor?.fetch(request: requst)
    }
 
    private func showAlert(with dismiss: Bool, message: String) {
        let alert = UIAlertController(title: "",
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { [weak self] (action) in
            guard let strongSelf = self else { return }
            if dismiss {
                strongSelf.router?.routeToBack()
            }
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func display(viewModel: AddMembers.Fetch.ViewModel) {
        imageView.image = viewModel.photo
        titleTxt.text = viewModel.title
    }
    
    func displaySomething(viewModel: AddMembers.Something.ViewModel) {
        showAlert(with: viewModel.success,
                  message: viewModel.message)
    }
    
    @objc private func adjustForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = UIEdgeInsets.zero
        } else {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        
        scrollView.scrollIndicatorInsets = scrollView.contentInset
        scrollView.scrollRectToVisible(self.textField.frame, animated: true)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func loadImageButtonTapped(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func didTapOnSave(_ sender: UIButton) {
        let request = AddMembers.Something.Request(title: titleTxt.text ?? "",
                                                   description: descTxt.text ?? "",
                                                   image: imageView.image)
        interactor?.doSomething(request: request)
    }
}

extension AddMembersViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.textField.frame = textField.frame
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension AddMembersViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
