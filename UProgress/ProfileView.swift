//
//  ProfileView.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 19.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit

class ProfileView: NSObject, UITableViewDelegate, UIImagePickerControllerDelegate, UITableViewDataSource, UINavigationControllerDelegate {
    private var cellIdentifier = "profileItem"
    private var user: User!
    private var tableView: UITableView!
    private var profileItems = [Dictionary<String, String>]()
    private var profileHeader: ProfileHeader!
    private let navButtonSize = 30
    private var viewController: BaseViewController!
    private var actions: ProfileViewActionsProtocol!
    private let imagePicker = UIImagePickerController()
    private var popover:UIPopoverController!
    
    init(user: User!, table: UITableView!, viewController: BaseViewController) {
        super.init()
        self.user = user
        self.tableView = table
        self.viewController = viewController
        self.actions = viewController as! ProfileViewActionsProtocol
        
        imagePicker.delegate = self
        
        self.tableView.estimatedRowHeight = 300
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.profileItems = user.attributesDictionary()
        
        tableView.register(UINib(nibName: "ProfileCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        viewController.navigationItem.rightBarButtonItems = [
            setBarButton(withIcon: "settings_icon", action: "createStep"),
            setBarButton(withIcon: "camera", action: #selector(takePhoto(sender:)))
        ]
        
    }
    
    func setBarButton(withIcon: String!, action: Selector) -> UIBarButtonItem {
//        let myBtn: UIButton = UIButton()
//        myBtn.setImage(UIImage(named: withIcon), for: .normal)
//        myBtn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: navButtonSize, height: navButtonSize))
//        myBtn.addTarget(self, action: action, for: .touchUpInside)
        return UIBarButtonItem(image: CommonFunctions.resizeImage(image: UIImage(named: withIcon)!, targetSize: CGSize(width: 30.0, height: 30.0)), style: UIBarButtonItemStyle.plain, target: self, action: action)
    }
    
    func createStep() {
        actions.editUser()
    }
    
    func takePhoto(sender: UIBarButtonItem) {
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default) { UIAlertAction in
                self.openCamera()
            }
            alert.addAction(cameraAction)
//            imagePicker.allowsEditing = false
//            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
//            imagePicker.cameraCaptureMode = .photo
//            imagePicker.modalPresentationStyle = .fullScreen
        }
//        else {
//            imagePicker.allowsEditing = false
//            imagePicker.sourceType = .photoLibrary
//        }
        let gallaryAction = UIAlertAction(title: "Gallary", style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.openGallery(sender: sender)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { UIAlertAction in
        }
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        if CommonFunctions.DeviceData.isIphone() {
            viewController.present(alert, animated: true, completion: {})
        }
        else {
            popover = UIPopoverController(contentViewController: alert)
            popover.present(from: sender, permittedArrowDirections: UIPopoverArrowDirection.any, animated: true)
//            popover.presentPopoverFromRect(sender, inView: self.view, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
        }
    }
    
    func openCamera() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        imagePicker.cameraCaptureMode = .photo
        imagePicker.modalPresentationStyle = .fullScreen
        viewController.present(imagePicker, animated: true, completion: {})
    }
    
    func openGallery(sender: UIBarButtonItem) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        if CommonFunctions.DeviceData.isIphone() {
            viewController.present(imagePicker, animated: true, completion: {})
        }
        else {
            popover=UIPopoverController(contentViewController: imagePicker)
            popover.present(from: sender, permittedArrowDirections: UIPopoverArrowDirection.any, animated: true)
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ProfileCell
        cell.setData(list: profileItems[indexPath.row])
//        cell.textLabel?.text = profileItems[indexPath.row]["value"]
//        cell.detailTextLabel?.text = profileItems[indexPath.row]["title"]
        return cell as! UITableViewCell
    }
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileItems.count
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        profileHeader = ProfileHeader.instanceFromNib() as! ProfileHeader
        profileHeader.setData(user: user)
        return profileHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 140
    }
    
    func updateUser(user: User!) {
        AuthorizationService.sharedInstance.currentUser = user
        self.user = user
        self.profileItems = user.attributesDictionary()
        self.tableView.reloadData()
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        viewController.dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerControllerOriginalImage]
        self.profileHeader.avatarImage.image = image as! UIImage?
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}
