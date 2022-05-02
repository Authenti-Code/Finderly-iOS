//
//  HomeTVCell.swift
//  Finderly
//
//  Created by Pankush Mehra on 30/12/21.
//

import UIKit
import SDWebImage
//protocol PostDelegate {
//    func selectedPost(post: IndexPath)
//}

class HomeTVCell: UITableViewCell {
    //MARK:-> IBOutlets
    @IBOutlet weak var oHeadingLabel: UILabel!
    @IBOutlet weak var oSeeAllBtn: UIButton!
    @IBOutlet weak var oListingCollectionView: UICollectionView!
    //MARK:-> Variables
    var homeBuisnessAry = [HomeDataBusinessModel]()
    var individualModelAry = [IndividualModel]()
    var todaysModelAry = [TodaysRecommendModel]()
    var top10ModelAry = [Top10BusinessModel]()
    var sponsoredAry =  [SponsoreModel]()
    var callback: ((_ id: Int) -> Void)?
    var callbackspon: ((_ id: Int) -> Void)?
    var currentIndex = String()
    // var delegateObj: PostDelegate?
    //MARK:-> View's Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        oListingCollectionView.delegate = self
        oListingCollectionView.dataSource = self
        oListingCollectionView.reloadData()
    }
    //override func viewWillAppear(animated: Bool) {
    //
    //    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
//MARK:-> Extension for collection view delegate and datasource method
extension HomeTVCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var arrayCount = Int()
        if oListingCollectionView.tag == 0{
            arrayCount =  todaysModelAry.count
        } else if oListingCollectionView.tag == 1{
            arrayCount =  sponsoredAry.count
        } else if oListingCollectionView.tag == 2{
            arrayCount =  top10ModelAry.count
        }
        return arrayCount
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = oListingCollectionView.dequeueReusableCell(withReuseIdentifier: "HomeCVCell", for: indexPath) as! HomeCVCell
        cell.oTitleLabel.isHidden = false
        cell.oLocationLabel.isHidden = false
        cell.constimgVwheight.constant = 110
        if oListingCollectionView.tag == 0{
            oListingCollectionView.isHidden = false
            let todayModelObj = todaysModelAry[indexPath.item]
            cell.oLocationLabel.text = todayModelObj.location
            cell.oTitleLabel.text = todayModelObj.businessName
            cell.oDiscriptionLabel.text = todayModelObj.description
            cell.oRatingLabel.text =
            "\(todayModelObj.ratings ?? "") (\(todayModelObj.ratings_count  ?? 0 ))"
            //            cell.oMainView.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.4, radius: 5, edge: AIEdge.None, shadowSpace: 20, cornerRadius: 15)
            cell.oMainView.layer.masksToBounds = true
            layer.masksToBounds = false
            // MARK:--> a shadow
            layer.shadowRadius = 1.5
            layer.shadowOpacity = 0.3
            layer.shadowColor = UIColor.gray.cgColor
            layer.shadowOffset = CGSize(width: 0.5, height: 1.5)
            layer.cornerRadius = 13
            let imgUrl = todayModelObj.image
            let removeSpace = imgUrl!.replacingOccurrences(of: " ", with: "%20")
            cell.oListImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.oListImageView.sd_setImage(with: URL.init(string: removeSpace), placeholderImage: UIImage(named: ""), options: .highPriority, context: [:])
            if todayModelObj.is_liked == 1{
                cell.oLikeUnlikeBtn.setImage(UIImage(named: "liked_heart"), for: .normal)
            }else{
                cell.oLikeUnlikeBtn.setImage(UIImage(named: "Icon heart"), for: .normal)
            }
            cell.oLikeUnlikeBtn.tag = indexPath.row
            cell.oLikeUnlikeBtn.addTarget(self, action: #selector(RecommendedPostLikeButton), for: .touchUpInside)
        } else if oListingCollectionView.tag == 1{
            let sponsoredObj = sponsoredAry[indexPath.item]
            let imgUrl = sponsoredObj.image
            let removeSpace = imgUrl!.replacingOccurrences(of: " ", with: "%20")
            cell.oListImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.oListImageView.sd_setImage(with: URL.init(string: removeSpace), placeholderImage: UIImage(named: ""), options: .highPriority, context: [:])
            cell.oListImageView.layer.cornerRadius = 40
            cell.oTitleLabel.isHidden = true
            cell.oLocationLabel.isHidden = true
            cell.oRatingLabel.isHidden = true
            cell.oRatingImg.isHidden = true
            cell.olikeVw.isHidden = true
            cell.olocaionVw.isHidden = true
            cell.constimgVwheight.constant = 207
        } else if oListingCollectionView.tag == 2{
            cell.oMainView.layer.masksToBounds = true
            layer.masksToBounds = false
            // MARK:--> a shadow
            layer.shadowRadius = 1.5
            layer.shadowOpacity = 0.3
            layer.shadowColor = UIColor.gray.cgColor
            layer.shadowOffset = CGSize(width: 0.5, height: 1.5)
            layer.cornerRadius = 13
            oListingCollectionView.isHidden = false
            let top10ModelObj = top10ModelAry[indexPath.item]
            cell.oLocationLabel.text = top10ModelObj.location
            cell.oTitleLabel.text = top10ModelObj.businessName
            cell.oDiscriptionLabel.text = top10ModelObj.description
            cell.oRatingLabel.text = "\(top10ModelObj.ratings ?? "") (\(top10ModelObj.ratings_count  ?? 0 ))"
            //            cell.oMainView.applyShadowWithCornerRadius(color: appcolor.backgroundShadow, opacity: 0.3, radius: 2, edge: AIEdge.None, shadowSpace:5, cornerRadius:15)
            let imgUrl = top10ModelObj.image
            let removeSpace = imgUrl!.replacingOccurrences(of: " ", with: "%20")
            cell.oListImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.oListImageView.sd_setImage(with: URL.init(string: removeSpace), placeholderImage: UIImage(named: ""), options: .highPriority, context: [:])
            if top10ModelObj.is_liked == 1{
                cell.oLikeUnlikeBtn.setImage(UIImage(named: "liked_heart"), for: .normal)
            }else{
                cell.oLikeUnlikeBtn.setImage(UIImage(named: "Icon heart"), for: .normal)
            }
            cell.oLikeUnlikeBtn.tag = indexPath.row
            cell.oLikeUnlikeBtn.addTarget(self, action: #selector(TopBusinessSetorButton), for: .touchUpInside)
        }
        return cell
    }
    @objc func RecommendedPostLikeButton( sender:UIButton){
        let todayModelObj = todaysModelAry[sender.tag]
        businessLikeApi(id:todayModelObj.id ?? ""){
        }
    }
    @objc func TopBusinessSetorButton( sender:UIButton){
        let top10ModelObj = top10ModelAry[sender.tag]
        businessLikeApi(id:top10ModelObj.id ?? ""){
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if oListingCollectionView.tag == 1{
            return CGSize(width: 250, height: 207)
        }
        else{
            return CGSize(width: 150, height: 190)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if oListingCollectionView.tag == 0{
            let todayModelObj = todaysModelAry[indexPath.item]
            callback?(Int(todayModelObj.id ?? "0") ?? 0)
        }
        else if oListingCollectionView.tag == 1{
            let sponsoredObj = sponsoredAry[indexPath.item]
            if sponsoredAry.count > 0 {
                if let Url = NSURL(string: sponsoredObj.urlLink!){
                    UIApplication.shared.openURL(Url as URL)
                    print(Url)
                }
            }
            callbackspon?(Int(sponsoredObj.id ?? "0") ?? 0)
        } else if oListingCollectionView.tag == 2{
            let top10ModelObj = top10ModelAry[indexPath.item]
            callback?(Int(top10ModelObj.id ?? "0") ?? 0)
        }
    }
}
extension HomeTVCell{
    func businessLikeApi(id:String,completion:@escaping() -> Void)  {
        let likeUrl = "\(Apis.KServerUrl)\(Apis.kLikebusiness)"
        let kURL = likeUrl.encodedURLString()
        let params = [
            "business_id":  id as AnyObject
        ]
        WebProxy.shared.postData(kURL, params: params, showIndicator: true, methodType: .post) { (JSON, isSuccess, message) in
            if isSuccess {
                if JSON["success"] as? String == "true"{
                    if let dataDict = JSON["data"] as? NSDictionary {
                        print("Dict:",dataDict)
                    }
                    completion()
                    self.oListingCollectionView.reloadData()
                    self.oListingCollectionView.delegate = self
                    self.oListingCollectionView.dataSource = self
                    Proxy.shared.displayStatusCodeAlert(JSON["message"] as? String ?? "")
                } else{
                    Proxy.shared.displayStatusCodeAlert(JSON["message"] as? String ?? "")
                }
            } else {
                Proxy.shared.displayStatusCodeAlert(message)
            }
        }
    }
}

