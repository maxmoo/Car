//
//  UserInfoViewController.swift
//  Car
//
//  Created by hss on 2017/10/18.
//  Copyright © 2017年 FlycoIT. All rights reserved.
//

import UIKit

class UserInfoViewController: FKBaseTableViewController {

    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet var sTableView: UITableView!
    @IBAction func endEdit(_ sender: Any) {
        view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "个人信息"
    }
}

extension UserInfoViewController: CCActionSheetDelegate {
    
    func cc_actionSheetDidSelectedIndex(_ index: Int) {
        switch index {
        case 1:
            FKPhotoSelect.share().openPhoto(with: FKSelectTypePhoto, sender: self, image: { (image) in
                self.dealHeadImage(image: image!)
            })
        case 2:
            FKPhotoSelect.share().openPhoto(with: FKSelectTypeCamara, sender: self, image: { (image) in
                self.dealHeadImage(image: image!)
            })
        default:
            logPass("----")
        }
    }
    
    func dealHeadImage(image: UIImage) {
        headImageView.image = image
    }
}

extension UserInfoViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        view.endEditing(true)
        if indexPath.section == 0 && indexPath.row == 0 {
            CCActionSheet.share().cc_actionSheet(withSelect: ["相册","拍照"], cancelTitle: "取消", delegate: self)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }else{
            return 20
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "账号绑定"
        }else {
            return nil
        }
    }
}
