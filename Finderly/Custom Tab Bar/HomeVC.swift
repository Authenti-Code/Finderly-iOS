//
//  HomeVC.swift
//  Finderly
//
//  Created by Pankush Mehra on 29/12/21.
//

import UIKit
import SVProgressHUD
import SDWebImage

class HomeVC: UIViewController {
  
    //MARK:-> IBOutlets
    @IBOutlet weak var oBannerCollectionView: UICollectionView!
    @IBOutlet weak var oListingTableView: UITableView!
    //MARK:-> Varibles
    var homeBusinessAry = [HomeDataBusinessModel]()
    var individualModelAry = [IndividualModel]()
    var todaysModelAry = [TodaysRecommendModel]()
    var top10ModelAry = [Top10BusinessModel]()
    var bannerModelAry = [BannerModel]()
    var listArray = ["Today's Recommended","Top 10 Business Sector","Individual Business"]
    //MARK:-> View's Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        oBannerCollectionView.delegate = self
        oBannerCollectionView.dataSource = self
        oListingTableView.delegate = self
        oListingTableView.dataSource = self
        getHomeProductsApi()
        UserDefaults.standard.set(true, forKey: "logged_in")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}
//MARK:-> Extension for collection view delagate and datasource method
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerModelAry.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let bannerModelObj = bannerModelAry[indexPath.row]
        let cell = oBannerCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeCVCell", for: indexPath) as! HomeCVCell
        let imgUrl = bannerModelObj.bannerImage
        let removeSpace = imgUrl!.replacingOccurrences(of: " ", with: "%20")
        cell.oTopImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.oTopImageView.sd_setImage(with: URL.init(string: removeSpace), placeholderImage: UIImage(named: ""), options: .highPriority, context: [:])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width*0.9, height: 140)
    }
}
//MARK:-> Extension for table view delagate and datasource method
extension HomeVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = oListingTableView.dequeueReusableCell(withIdentifier: "HomeTVCell") as! HomeTVCell
        cell.oHeadingLabel.text = listArray[indexPath.row]
        cell.oListingCollectionView.tag = indexPath.row
        if indexPath.row == 0{
            cell.todaysModelAry = todaysModelAry
            cell.callback = { (id) -> Void in
                print(id)
                self.selectedPost(id: id)
            }
        } else if indexPath.row == 1{
            cell.top10ModelAry = top10ModelAry
            cell.todaysModelAry = todaysModelAry
            cell.callback = { (id) -> Void in
                print(id)
                self.selectedPost(id: id)
            }
        } else if indexPath.row == 2{
            cell.individualModelAry = individualModelAry
            cell.todaysModelAry = todaysModelAry
            cell.callback = { (id) -> Void in
                print(id)
                self.selectedPost(id: id)
            }
        }
        cell.oListingCollectionView.reloadData()
        cell.oSeeAllBtn.tag = indexPath.row
        cell.oSeeAllBtn.addTarget(self, action: #selector(connected(sender:)), for: .touchUpInside)
        cell.selectionStyle = .none
        return cell
    }
    @objc func connected(sender: UIButton){
        let buttonTag = sender.tag
        if buttonTag == 0{
            Proxy.shared.pushNaviagtion(stryboard: storyboardMain, identifier: "TodayRecommededVCID", isAnimate: true, currentViewController: self)
        }else{
            print("Hello")
        }
    }
    //On Perticular Product Func
    func selectedPost(id: Int) {
        let nav = storyboardMain.instantiateViewController(withIdentifier: "TodayRecommededVCID") as! TodayRecommededVC
        nav.postID = id
        self.navigationController?.pushViewController(nav, animated: true)
    }
}
//MARK:-> Extension For Home Api
extension HomeVC{
    func getHomeProductsApi(){
        SVProgressHUD.show()
        var param = [String: String]()
        var homeData = ""
        homeData = "\(Apis.KServerUrl)\(Apis.kHome)"
        param = ["":""]
        print("Param:\(param)")
        let kURL = homeData.encodedURLString()
        WebProxy.shared.postData(kURL, params: param, showIndicator: true, methodType: .post) { (JSON, isSuccess, message) in
            if isSuccess {
                if JSON["success"] as? String == "true"{
                    SVProgressHUD.dismiss()
                    if let dataDict = JSON["data"] as? NSDictionary{
                        self.homeBusinessAry.removeAll()
                        self.bannerModelAry.removeAll()
                        if let newData = dataDict["individual_business"] as? NSArray{
                            for i in 0..<newData.count{
                                let dict = newData[i]
                                let individualModelObj = IndividualModel()
                                individualModelObj.businessData(dataDict: dict as! NSDictionary)
                                self.individualModelAry.append(individualModelObj)
                            }
                        }
                        if let newData = dataDict["todays_recommended"] as? NSArray{
                            for i in 0..<newData.count{
                                let dict = newData[i]
                                let todaysRecommendModelObj = TodaysRecommendModel()
                                todaysRecommendModelObj.businessData(dataDict: dict as! NSDictionary)
                                self.todaysModelAry.append(todaysRecommendModelObj)
                            }
                        }
                        if let newData = dataDict["top_10_business_sector"] as? NSArray{
                            for i in 0..<newData.count{
                                let dict = newData[i]
                                let top10ModelObj = Top10BusinessModel()
                                top10ModelObj.businessData(dataDict: dict as! NSDictionary)
                                self.top10ModelAry.append(top10ModelObj)
                            }
                        }
                        if let bannerData = dataDict["banner"] as? NSArray{
                            for i in 0..<bannerData.count{
                                let dict = bannerData[i]
                                let bannerModelObj = BannerModel()
                                bannerModelObj.bannerData(dataDict: dict as! NSDictionary)
                                self.bannerModelAry.append(bannerModelObj)
                            }
                        }
                        self.oListingTableView.delegate = self
                        self.oListingTableView.dataSource = self
                        self.oBannerCollectionView.delegate = self
                        self.oBannerCollectionView.dataSource = self
                        self.oListingTableView.reloadData()
                        self.oBannerCollectionView.reloadData()
                    }
                    Proxy.shared.displayStatusCodeAlert(JSON["message"] as? String ?? "")
                } else{
                    SVProgressHUD.dismiss()
                    Proxy.shared.displayStatusCodeAlert(JSON["errorMessage"] as? String ?? "")
                }
            } else {
                SVProgressHUD.dismiss()
                Proxy.shared.displayStatusCodeAlert(message)
            }
        }
    }
}
