//
//  ProfileView.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 19.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import ObjectMapper
import MBProgressHUD

class ProfileView: NSObject, UITableViewDelegate, UIImagePickerControllerDelegate, UITableViewDataSource, UINavigationControllerDelegate, AttachmentViewProtocol {
    private var cellIdentifier = "profileItem"
    private var user: User!
    private var tableView: UITableView!
    private var profileItems = [Dictionary<String, String>]()
    private var profileHeader: ProfileHeader!
    private let navButtonSize = 30
    private var viewController: BaseViewController!
    private var actions: ProfileViewActionsProtocol!
    private let imagePicker = UIImagePickerController()
    private var presenter: AttachmentPresenter!
    private var uploadedImage: UIImage!
    
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
        
        tableView.backgroundColor = UIColor("#f6f7f8")
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.register(UINib(nibName: "ProfileCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        var buttonsArr: [UIBarButtonItem]! = []
        
        if user.id == AuthorizationService.sharedInstance.currentUser.id {
            buttonsArr.append(CommonFunctions.barButtonAsButton(target: self, iconName: "settings_icon", action: #selector(showOptions(_:))))
            buttonsArr.append(CommonFunctions.barButtonAsButton(target: self, iconName: "camera", action: #selector(takePhoto(_:))));
        }
        
        viewController.navigationItem.rightBarButtonItems = buttonsArr
        
        let model = AttachmentManager()
        presenter = AttachmentPresenter(model: model, view: self)
        
    }
    
    func showOptions(_ sender: UIButton) {
        let alert:UIAlertController=UIAlertController(title: NSLocalizedString("profile_settings_action", comment: ""), message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let editAction = UIAlertAction(title: NSLocalizedString("profile_settings_edit", comment: ""), style: UIAlertActionStyle.default) { UIAlertAction in
                self.actions.editUser()
            }
        
        let signOutAction = UIAlertAction(title: NSLocalizedString("profile_settings_sign_out", comment: ""), style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.signOut()
        }
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("profile_image_cancel", comment: ""), style: UIAlertActionStyle.cancel) { UIAlertAction in
            alert.dismiss(animated: true, completion: {})
        }
        
        alert.addAction(editAction)
        alert.addAction(signOutAction)
        alert.addAction(cancelAction)
        alert.popoverPresentationController?.sourceView = sender
        alert.popoverPresentationController?.sourceRect = sender.bounds
        viewController.present(alert, animated: true, completion: {})
    }
    
    func takePhoto(_ sender: UIButton) {
        let alert:UIAlertController=UIAlertController(title: NSLocalizedString("profile_select_image", comment: ""), message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: NSLocalizedString("profile_image_photo", comment: ""), style: UIAlertActionStyle.default) { UIAlertAction in
                self.openCamera()
            }
            alert.addAction(cameraAction)
        }
        
        let gallaryAction = UIAlertAction(title: NSLocalizedString("profile_image_gallery", comment: ""), style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.openGallery()
        }
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("profile_image_cancel", comment: ""), style: UIAlertActionStyle.cancel) { UIAlertAction in
        }
        
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        alert.popoverPresentationController?.sourceView = sender
        alert.popoverPresentationController?.sourceRect = sender.bounds
        viewController.present(alert, animated: true, completion: {})
    }
    
    func signOut() {
        AuthorizationService.sharedInstance.signOut()
    }
    
    func openCamera() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        imagePicker.cameraCaptureMode = .photo
        imagePicker.modalPresentationStyle = .fullScreen
        viewController.present(imagePicker, animated: true, completion: {})
    }
    
    func openGallery() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        viewController.present(imagePicker, animated: true, completion: {})
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ProfileCell
        cell.setData(list: profileItems[indexPath.row])
        return cell as UITableViewCell
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
        return 220
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
        uploadedImage = image as! UIImage!
        presenter.uploadProfileImage(image: image as! UIImage!, attachableId: user.id, attachableType: "User")
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    internal func successAttachmentUpload(attachment: Attachment) {
        let user = AuthorizationService.sharedInstance.currentUser
        user?.attachment = attachment
        user?.avatarUrl = attachment.url
        if let selectedImage = uploadedImage {
            self.profileHeader.updateAvatar(image: selectedImage)
        } else {
            CommonFunctions.avatarImage(imageView: profileHeader.avatarImage, url: attachment.url)
        }
        AuthorizationService.sharedInstance.currentUser = user
        let notificationName = Notification.Name("currentUserUpdated")
        NotificationCenter.default.post(name: notificationName, object: AuthorizationService.sharedInstance.currentUser)
    }
    
    internal func failedAttachmentUpload(error: ServerError) {
        
    }
    
    internal func stopLoader() {
        MBProgressHUD.hide(for: viewController.view, animated: true)
    }
    
    internal func startLoader() {
        MBProgressHUD.showAdded(to: viewController.view, animated: true)
    }
}
