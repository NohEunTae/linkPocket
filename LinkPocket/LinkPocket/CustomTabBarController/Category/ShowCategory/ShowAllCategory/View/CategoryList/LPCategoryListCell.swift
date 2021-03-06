//
//  LPCategoryListObject.swift
//  LinkPocket
//
//  Created by 내 맥북에어 on 2018. 8. 8..
//  Copyright © 2018년 LP. All rights reserved.
//

import UIKit

class LPCategoryListCell: UICollectionViewCell {
    @IBOutlet weak var categoryNL: UILabel!
    @IBOutlet weak var urlCountL: UILabel!
    
    @IBOutlet weak var image: UIImageView!
    var urls: [LPLinkModel] = []
    var categoryColor: UIColor = UIColor.colorFromRGB(0x008EFF)
   
    func modifyCell(category: LPCategoryModel, urlCount: String, urls: [LPLinkModel]) {
        image.isHidden = true
        categoryNL.isHidden = false
        urlCountL.isHidden = false
        
        categoryNL.text = category.name!
        urlCountL.text = urlCount
        categoryColor = category.color()!
        categoryNL.textColor = categoryColor
        
        self.urls = urls
        self.Shadow(color: UIColor.colorFromRGB(0xeeeeee), opacity: 0.3, offSet: CGSize(width: 0.2, height: 0.2), radius: 5, scale: true)
    }
    
    func modifyAllCell(categoryN: String, urlCount: String, urls: [LPLinkModel]) {
        image.isHidden = true
        categoryNL.isHidden = false
        urlCountL.isHidden = false
        
        categoryNL.text = categoryN
        urlCountL.text = urlCount
        categoryColor = UIColor.gray
        categoryNL.textColor = categoryColor
        
        self.urls = urls
        self.Shadow(color: UIColor.colorFromRGB(0xEEEEEE), opacity: 0.2, offSet: CGSize(width: 0.2, height: 0.2), radius: 5, scale: true)
    }
    
    func modeifyImageCell(image: String) {
        self.image.isHidden = false
        categoryNL.isHidden = true
        urlCountL.isHidden = true
        self.image.image = UIImage(named: image)
    }

    let fontC = UIColor.colorFromRGB(0x707070)
    
    func onClicked(){
        UIView.animate(withDuration: 0.1, animations: {
            self.layer.cornerRadius = 2*r
            self.backgroundColor = self.categoryColor
            self.categoryNL.textColor = UIColor.white
            self.urlCountL.textColor = UIColor.white
        })
    }
    
    func onUnclicked(){
        UIView.animate(withDuration: 0.1, animations: {
            self.layer.cornerRadius = 2*r
            self.backgroundColor = UIColor.white
            self.categoryNL.textColor = self.categoryColor
            self.urlCountL.textColor = self.fontC
        })
    }
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                if self.image.isHidden == false {
                    print("카테고리 추가")
                } else {
                self.onClicked()
                }
            } else {
                self.onUnclicked()
            }
        }
    }

}
