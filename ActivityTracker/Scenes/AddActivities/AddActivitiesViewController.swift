//
//  AddActivitiesViewController.swift
//  ActivityTracker
//
//  Created by Antony Raphel on 04/12/18.
//  Copyright (c) 2018 Antony Raphel. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol TextFrame {
    associatedtype field
    var textField: field { get set }
}

protocol AddActivitiesDisplayLogic: class {
    func displayAlert(viewModel: AddActivities.Add.ViewModel)
    func displayMembers(viewModel: AddActivities.Member.ViewModel)
}

class AddActivitiesViewController: UIViewController, AddActivitiesDisplayLogic, TextFrame {
    
    typealias field = UITextField
    var textField: UITextField = UITextField()
    var dueDate: Date?
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yyyy"
        return formatter
    }
    let imagePicker = UIImagePickerController()
    var members: [AddActivities.Member.ViewModel.MemberViewModel] = []
    
    var interactor: AddActivitiesBusinessLogic?
    var router: (NSObjectProtocol & AddActivitiesRoutingLogic & AddActivitiesDataPassing)?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var descTxt: UITextField!
    @IBOutlet weak var dueDateTxt: UITextField!
    @IBOutlet weak var memberCollectionView: UICollectionView!
    
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
        let interactor = AddActivitiesInteractor()
        let presenter = AddActivitiesPresenter()
        let router = AddActivitiesRouter()
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
    }
    
    func addMember() {
        let request = AddActivities.Member.Request()
        interactor?.addMember(request: request)
    }
    
    func displayAlert(viewModel: AddActivities.Add.ViewModel) {
        showAlert(with: viewModel.success,
                  message: viewModel.message)
    }
    
    func displayMembers(viewModel: AddActivities.Member.ViewModel) {
        members = viewModel.members
        memberCollectionView.reloadData()
    }
    
    private func setUpView() {
        members = [AddActivities.Member.ViewModel.MemberViewModel(title: "Add Member",
                                                                  photo: UIImage(named: "Add-User-Placeholder") ?? UIImage(),
                                                                  isLast: true)]
        imagePicker.delegate = self
        
        memberCollectionView.layer.cornerRadius = 4
        memberCollectionView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
        memberCollectionView.layer.borderWidth = 0.80
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddActivitiesViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        // Present UIDatePicker for due date input
        let datePicker = UIDatePicker(frame: CGRect.zero)
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()
        datePicker.addTarget(self, action: #selector(AddActivitiesViewController.dateChanged(datePicker:)), for: .valueChanged)
        dueDateTxt.inputView = datePicker
        let toolBar = UIToolbar().Toolbar(done: #selector(AddActivitiesViewController.dismissPicker),
                                          cancel: #selector(AddActivitiesViewController.dismissKeyboard))
        dueDateTxt.inputAccessoryView = toolBar
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
    
    @objc private func dismissPicker() {
        if dueDate == nil {
            dueDate = Date()
        }
        dueDateTxt.text = dateFormatter.string(from: dueDate!)
        view.endEditing(true)
    }
    
    @objc private func dateChanged(datePicker: UIDatePicker) {
        dueDate = datePicker.date
        dueDateTxt.text = dateFormatter.string(from: datePicker.date)
    }
    
    @IBAction func loadImageButtonTapped(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func didTapOnSave(_ sender: UIButton) {
        let request = AddActivities.Add.Request(title: titleTxt.text ?? "",
                                                description: descTxt.text ?? "",
                                                dueDate: dueDate,
                                                image: imageView.image)
        interactor?.doAdd(request: request)
    }
}

extension AddActivitiesViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.textField.frame = textField.frame
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension AddActivitiesViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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

extension AddActivitiesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return members.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let lCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemberCollectionViewCell", for: indexPath) as! MemberCollectionViewCell
        lCell.configureCell(model: members[indexPath.item])
        return lCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.routeToAddMember(at: indexPath.item, isLast: members[indexPath.item].isLast)
    }
}
