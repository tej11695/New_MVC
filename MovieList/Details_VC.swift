//
//  Details_VC.swift
//  MovieList
//
//  Created by eSparkBiz-1 on 29/08/19.
//  Copyright © 2019 eSparkBiz. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class Details_VC: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    var dictItemDetail = MovieDataList.MovieData()

    @IBOutlet var bgImageHeight: NSLayoutConstraint!
    @IBOutlet var imgBackGround: UIImageView!
    @IBOutlet var imgView: UIImageView!
    
    var arr = [String]()
    var values = [String:AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = .none
        
        let url = "https://api.themoviedb.org/3/movie/\(self.dictItemDetail.id)?api_key=14bc774791d9d20b3a138bb6e26e2579&language=en-US"
        Alamofire.request(URL(string: url)!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (responseObject) in
            let response = self.formatResponse(data: responseObject)
            print(response)
            self.values = response
            self.arr = response.keys.sorted()
            let img = response["backdrop_path"] as? String ?? ""
            let imageURL = "https://image.tmdb.org/t/p/w500" + img
            self.imgBackGround!.sd_setImage(with:URL(string: imageURL)! , placeholderImage: #imageLiteral(resourceName: "Placeholder.jpg"), options: [.continueInBackground,.refreshCached,.lowPriority]) { (image, error, type, url) in
                self.imgBackGround.image = image
            }
            
            let imgURL = "https://image.tmdb.org/t/p/w185" + self.dictItemDetail.poster_path
            self.imgView!.sd_setImage(with:URL(string: imgURL)! , placeholderImage: #imageLiteral(resourceName: "Placeholder.jpg"), options: [.continueInBackground,.refreshCached,.lowPriority]) { (image, error, type, url) in
                 self.imgView.image = image
            }
            
            let multiplier = UIScreen.main.bounds.width / 500;
            let height = multiplier * 281
            self.bgImageHeight.constant = height
            self.view.updateConstraintsIfNeeded()
            
            self.tableView.reloadData()
            
        }
    }
    
    //MARK: - UITableview delegate and Datasource -
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell") as! DetailsCell
        cell.selectionStyle = .none
        cell.lblName.text = self.arr[indexPath.row]
        
        let value = self.values[self.arr[indexPath.row]]
        if value is String{
            cell.lblValue.text = value as? String ?? ""
        }else if value is Bool{
            cell.lblValue.text = "\(value as? Bool ?? false)"
        }else if value is Int{
            cell.lblValue.text = "\(value as? Int ?? 0)"
        }else if value is Double{
            cell.lblValue.text = "\(value as? Double ?? 0.0)"
        }else if value is Array<Any>{
            let arr = value as! Array<[String: AnyObject]>
            cell.lblValue.text = self.arrayToString(array: arr)
        }else{
            cell.lblValue.text = "N/A"
        }
        return cell
    }

    func arrayToString(array: Array<[String: AnyObject]>) -> String {
        var arrStrings = [String]()
        for data in array{
            arrStrings.append(data["name"] as? String ?? "")
        }
        let formattedArray = (arrStrings.map{String($0)}).joined(separator: ",")
        return formattedArray
    }
}
