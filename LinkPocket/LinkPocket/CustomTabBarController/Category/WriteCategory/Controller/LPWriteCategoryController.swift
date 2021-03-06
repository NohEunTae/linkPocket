//
//  LPWriteCategoryController.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 23..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPWriteCategoryController: LPParentViewController, LPWriteCategoryViewListener {
    
    var urls: [LPLinkModel] = []
    var categorys: [LPCategoryModel] = []
    var status: String = "CreatCategory" //CreatCategory || EditCategory
    var categoryModel = LPCategoryModel()
    var writeView: LPWriteCategoryView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let mLPWriteCategoryView = Bundle.main.loadNibNamed("LPWriteCategoryView", owner: self, options: nil)?.first as? LPWriteCategoryView {
            self.writeView = mLPWriteCategoryView
            self.writeView?.status = self.status
            self.writeView?.listener = self
            self.view.addSubview(writeView!)
            self.writeView?.setBaseData(categoryModel: categoryModel)

        }
        
        if status == "CreatCategory" {
            self.navigationItem.title = "추가하기"
        } else {
            self.navigationItem.title = "수정하기"
            var image = UIImage(named: "LPTrash")
            image = image?.withRenderingMode(.alwaysOriginal)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(deleteAction))
        }
        
        urls = LPCoreDataManager.store.selectAllObjectFromLink() as! [LPLinkModel]
        categorys = LPCoreDataManager.store.selectAllObjectFromCategory() as! [LPCategoryModel]
        urls.sort(by: { $0.date?.compare($1.date! as Date) == .orderedAscending})
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let margin: CGFloat = size.width > size.height ? 10 : 80
        self.writeView?.topMargin.constant = margin
        self.writeView?.bottomMargin.constant = margin
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setBaseData(title: String, color: UIColor) {
        self.categoryModel.setRGBA(color: color)
        self.categoryModel.name = title
    }
    
    //MARK:- Alert ===============================================
    @objc func deleteAction() {
        func yes() {
            LPCoreDataManager.store.deleteFromCategoryWhere(nameIs: self.categoryModel.name!)
            LPParentNavigationController.sharedInstance.popViewController(animated: true)
        }
        func no() { }
        self.AlertTwo(title: "카테고리를 삭제하시겠습니까?", message: "영구적으로 삭제됩니다.", yesAction: yes, noAction: no)
    }
    
    func saveAlert() {
        if writeView?.cardTextField.text != "" {
            func yes() {
                writeView?.saveAlertAction()
                LPParentNavigationController.sharedInstance.popViewController(animated: true)
            }
            func no() { }
            self.AlertTwo(title: "저장하시겠습니까?", message: "", yesAction: yes, noAction: no)
        } else {
            self.AlertDisappear()
        }
    }
    //==============================================================
}
