//
//  UserCenterController.swift
//  Car
//
//  Created by hss on 2017/10/17.
//  Copyright © 2017年 FlycoIT. All rights reserved.
//

import UIKit

class UserCenterController: FKBaseViewController {

    fileprivate var personListTableView: UITableView?
    var personHeaderView: UIView?
    fileprivate let headerViewHeight: CGFloat = 140 + TotalNavHeight()
    
    var cellTitleArray: [[String]] {
        get {
            return [["我的资产","我的订单","收货地址"],
                    ["我的信息","客户服务"],
                    ["版本信息","关于我们"]]
        }
    }
    var cellDescribeArray: [[String]] {
        get {
            return [["9,833,921.00￥","25","徐汇区"],
                    ["",""],
                    ["v1.3.2e6",""]]
        }
    }
    
    var controllersArray: [[String]] {
        get {
            return [["AssetsViewController","OrderViewController","AddressViewController"],
                    ["MessageViewController","CustomerViewController"],
                    ["VersionViewController","AboutViewController"]]
        }
    }
    var cellImageNameArray: [[String]] {
        get {
            return [["MoreMyBankCard","MyCardPackageIcon","MoreMyFavorites"],
                    ["MoreGame","MoreExpressionShops"],
                    ["MoreSetting","MoreMyAlbum"]]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "个人中心"
        initPersonHeaderView()
        initTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func initPersonHeaderView() {
        personHeaderView = UIView.init(frame: fk_Rect(0, 0, SCREEN_WIDTH(), headerViewHeight))
        
        let headBackView = UIView.init(frame: fk_Rect(-1, 10 + TotalNavHeight(), SCREEN_WIDTH() + 2, 100))
        headBackView.backgroundColor = UIColor.white
        headBackView.layer.borderColor = UIColor.lightGray.cgColor
        headBackView.layer.borderWidth = 0.5
        personHeaderView?.addSubview(headBackView)
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tapEventToUserInfoAction))
        headBackView.addGestureRecognizer(tapGesture)
        
        let headerImageView = UIImageView.init(frame: fk_Rect(15, 10, 80, 80))
        headerImageView.image = UIImage(named:"head")
//        headerImageView.center = fk_Point((personHeaderView?.bounds.size.width)!/2, (personHeaderView?.bounds.size.height)!/2 + 20)
        headerImageView.layer.cornerRadius = 2
        headerImageView.layer.masksToBounds = true
        headerImageView.layer.borderWidth = 0.5
        headerImageView.layer.borderColor = UIColor.lightGray.cgColor
        headBackView.addSubview(headerImageView)
        
        let nameLabel = UILabel.init(frame: fk_Rect(105, 15, SCREEN_WIDTH() - 120, 30))
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.systemFont(ofSize: 15.0)
        nameLabel.text = "琦玉老师"
//        nameLabel.center = fk_Point((personHeaderView?.bounds.size.width)!/2, (personHeaderView?.bounds.size.height)!/2 + headerImageView.bounds.size.width/2 + 35)
        headBackView.addSubview(nameLabel)
        
        let detailLabel = UILabel.init(frame: fk_Rect(105, 55, SCREEN_WIDTH() - 120, 30))
        detailLabel.textAlignment = .left
        detailLabel.font = UIFont.systemFont(ofSize: 15.0)
        detailLabel.textColor = UIColor.lightGray
        detailLabel.text = "15121177201"
        //        nameLabel.center = fk_Point((personHeaderView?.bounds.size.width)!/2, (personHeaderView?.bounds.size.height)!/2 + headerImageView.bounds.size.width/2 + 35)
        headBackView.addSubview(detailLabel)
    }
    
    private func initTableView() {
        personListTableView = UITableView.init(frame: CGRect(x:0,y:-64,width:SCREEN_WIDTH(),height:SCREEN_HEIGHT() + 64), style: .grouped)
        personListTableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        personListTableView?.delegate = self
        personListTableView?.dataSource = self
        personListTableView?.showsHorizontalScrollIndicator = false
        personListTableView?.showsVerticalScrollIndicator = false
        personListTableView?.ts_registerCellNib(UserTableViewCell.self)
        
        view.addSubview(personListTableView!)
    }
    
    func tapEventToUserInfoAction() {
        self.performSegue(withIdentifier: "UserInfoViewController", sender: nil)
    }
}

extension UserCenterController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return CGFloat(headerViewHeight)
        }else{
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return personHeaderView
        }else{
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        self.performSegue(withIdentifier: controllersArray[indexPath.section][indexPath.row], sender: nil)
    }
}


extension UserCenterController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellTitleArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitleArray[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UserTableViewCell = tableView.ts_dequeueReusableCell(UserTableViewCell.self)
        cell.titleImage.image = UIImage(named:cellImageNameArray[indexPath.section][indexPath.row])
        cell.titleLabel.text = cellTitleArray[indexPath.section][indexPath.row]
        cell.describeLabel.text = cellDescribeArray[indexPath.section][indexPath.row]
        return cell
    }
}

