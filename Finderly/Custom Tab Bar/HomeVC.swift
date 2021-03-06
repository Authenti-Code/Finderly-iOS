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
    //    var individualModelAry = [IndividualModel]()
    var todaysModelAry = [TodaysRecommendModel]()
    var top10ModelAry = [Top10BusinessModel]()
    var sponsoredAry =  [SponsoreModel]()
    var bannerModelAry = [BannerModel]()
    
    var rat:Int?
    var listArray = ["Today's Recommended","Sponsored","Top 10 Business Sector"]
    //MARK:-> View's Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getHomeProductsApi()
        UserDefaults.standard.set(true, forKey: "logged_in")
    }
    @IBAction func oSearchbtnAction(_ sender: Any) {
        let nav = storyboardMain.instantiateViewController(withIdentifier: "SearchHomeVC") as! SearchHomeVC
        self.navigationController?.pushViewController(nav, animated: false)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //    callbackRating = { (rating,indx) -> Void in
        //                    self.todaysModelAry[indx].ratings = String(rating as? String ?? "0")
        //                print("Rating",rating)
        //                }
        //Do what you want in here
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
        if indexPath.row == 0{
            
            cell.callbackLike = { (is_liked,indx) -> Void in
                print("is_liked",indx)
                self.todaysModelAry[indx].is_liked = is_liked
            }
            cell.oListingCollectionView.tag = indexPath.row
            cell.currentIndex = "0"
            cell.todaysModelAry = todaysModelAry
            cell.oSeeAllBtn.isHidden = true
            cell.callback = { (id) -> Void in
                print(id)
                self.selectedPost(id: id)
            }
        }else if indexPath.row == 1{
            cell.oListingCollectionView.tag = indexPath.row
            cell.sponsoredAry = sponsoredAry
            print(sponsoredAry.count)
            cell.top10ModelAry = top10ModelAry
            cell.todaysModelAry = todaysModelAry
            cell.oSeeAllBtn.isHidden = false
            cell.callbackspon = { (id) -> Void in
                print(id)
                self.selectedPostSpon(id: id)
            }
        } else if indexPath.row == 2{
            cell.callbackLike = { (is_liked,indx) -> Void in
                print("is_liked",indx)
                self.top10ModelAry[indx].is_liked = is_liked
            }
            cell.oListingCollectionView.tag = indexPath.row
            cell.currentIndex = "2"
            cell.top10ModelAry = top10ModelAry
            cell.todaysModelAry = todaysModelAry
            cell.oSeeAllBtn.isHidden = true
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
        if buttonTag == 1{
            let nav = storyboardMain.instantiateViewController(withIdentifier: "TodayRecommededVCID") as! TodayRecommededVC
            self.navigationController?.pushViewController(nav, animated: true)
        }
    }
    //On Perticular Product Func
    func selectedPost(id: Int) {
        let nav = storyboardMain.instantiateViewController(withIdentifier: "BusinessDetailVCID") as! BusinessDetailVC
        nav.businessId = id
        print(id)
        self.navigationController?.pushViewController(nav, animated: true)
    }
    func selectedPostSpon(id: Int) {
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
                SVProgressHUD.dismiss()
                if JSON["success"] as? String == "true"{
                    if let dataDict = JSON["data"] as? NSDictionary{
                        //                        self.homeBusinessAry.removeAll()
                        self.bannerModelAry.removeAll()
                        //                        if let newData = dataDict["individual_business"] as? NSArray{
                        //                            self.individualModelAry.removeAll()
                        //                            for i in 0..<newData.count{
                        //                                let dict = newData[i]
                        //                                let individualModelObj = IndividualModel()
                        //                                individualModelObj.businessData(dataDict: dict as! NSDictionary)
                        //                                self.individualModelAry.append(individualModelObj)
                        //                            }
                        //                        }
                        if let newData = dataDict["sponsored"] as? NSArray{
                            self.sponsoredAry.removeAll()
                            for i in 0..<newData.count{
                                let dict = newData[i]
                                let sponsoreModelObj = SponsoreModel()
                                sponsoreModelObj.sponsored(dataDict: dict as! NSDictionary)
                                self.sponsoredAry.append(sponsoreModelObj)
                            }
                        }
                        if let newData = dataDict["todays_recommended"] as? NSArray{
                            self.todaysModelAry.removeAll()
                            for i in 0..<newData.count{
                                let dict = newData[i]
                                let todaysRecommendModelObj = TodaysRecommendModel()
                                todaysRecommendModelObj.businessData(dataDict: dict as! NSDictionary)
                                self.todaysModelAry.append(todaysRecommendModelObj)
                            }
                        }
                        if let newData = dataDict["top_10_business_sector"] as? NSArray{
                            self.top10ModelAry.removeAll()
                            for i in 0..<newData.count{
                                let dict = newData[i]
                                let top10ModelObj = Top10BusinessModel()
                                top10ModelObj.businessData(dataDict: dict as! NSDictionary)
                                self.top10ModelAry.append(top10ModelObj)
                            }
                        }
                        if let bannerData = dataDict["banner"] as? NSArray{
                            self.bannerModelAry.removeAll()
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
                } else{
                    //                    SVProgressHUD.dismiss()
                    Proxy.shared.displayStatusCodeAlert(JSON["errorMessage"] as? String ?? "")
                }
            } else {
                //                SVProgressHUD.dismiss()
                Proxy.shared.displayStatusCodeAlert(message)
            }
        }
    }
}
