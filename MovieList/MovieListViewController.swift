//
//  MovieListViewController.swift
//  MovieList
//
//  Created by eSparkBiz-1 on 22/08/19.
//  Copyright © 2019 eSparkBiz. All rights reserved.
//

import UIKit
import Alamofire
import CoreData


class MovieListViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    //IBOutlets
    @IBOutlet var tableView: UITableView!
    var MoviewList = MovieDataList()
    
    var currentPage : Int = 1
    var isLoadingList : Bool = false
    var arrMovie = [[String : AnyObject]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none

        if (NetworkReachabilityManager()?.isReachable)!{
            self.getMovieList(page: currentPage)
        }else{
            self.retrieveData()
        }
    }
    
    func getMovieList(page: Int){
        
        let url = API.SERVER_URL + "\(page)"
        Alamofire.request(URL(string: url)!, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (responseObject) in
            let response = self.formatResponse(data: responseObject)
            let arr = response["results"] as! [[String : AnyObject]]
            self.arrMovie.append(contentsOf: arr)
            self.MoviewList = MovieDataList(data: self.arrMovie)
            self.tableView.reloadData()
            self.isLoadingList = false
            self.deleteAllRecords()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.MoviewList.arrMovieData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListCell") as! MovieListCell
        cell.selectionStyle = .none
        cell.lblTitle.text = self.MoviewList.arrMovieData[indexPath.row].title
        cell.lblDescription.text =  self.MoviewList.arrMovieData[indexPath.row].overview
        cell.minHeight = 106
        
        
        if (NetworkReachabilityManager()?.isReachable)! {
            let imageURL = "https://image.tmdb.org/t/p/w185" + self.MoviewList.arrMovieData[indexPath.row].poster_path
            cell.imgView!.sd_setImage(with:URL(string: imageURL)! , placeholderImage: #imageLiteral(resourceName: "Placeholder.jpg"), options: [.continueInBackground,.refreshCached,.lowPriority]) { (image, error, type, url) in
                cell.imgView.image = image
            }
        }else{
            let imageURL = self.MoviewList.arrMovieData[indexPath.row].poster_path
            cell.imgView!.sd_setImage(with:URL(string: imageURL)! , placeholderImage: #imageLiteral(resourceName: "Placeholder.jpg"), options: [.fromCacheOnly]) { (image, error, type, url) in
                cell.imgView.image = image
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let details_VC = Details_VC.instantiate(fromAppStoryboard: .Main)
        details_VC.dictItemDetail = self.MoviewList.arrMovieData[indexPath.row]
        self.navigationController?.pushViewController(details_VC, animated: true)
    }
    
    
    //MARK: - Use For Pegination -
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if (NetworkReachabilityManager()?.isReachable)! {
            if (((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height ) && !isLoadingList){
                self.isLoadingList = true
                currentPage += 1
                self.getMovieList(page: currentPage)
            }
        }
    }
    
    //MARK: - CoreData Methods -
    func createData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "Movie", in: managedContext)!
        for obj in self.MoviewList.arrMovieData{
            let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
            user.setValue(obj.id, forKey: "id")
            user.setValue(obj.title, forKey: "title")
            user.setValue(obj.overview, forKey: "overview")
            let url = API.IMAGE_BASE_URL + obj.poster_path
            user.setValue(url, forKey: "poster_path")
       }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    func retrieveData() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        do {
            let result = try managedContext.fetch(fetchRequest)
            var arr = [[String:AnyObject]]()
            for data in result as! [NSManagedObject] {
                var obj = [String:AnyObject]()
                obj["id"] = data.value(forKey: "id") as AnyObject
                obj["title"] = data.value(forKey: "title") as AnyObject
                obj["overview"] = data.value(forKey: "overview") as AnyObject
                obj["poster_path"] = data.value(forKey: "poster_path") as AnyObject
                arr.append(obj)
            }
            self.MoviewList = MovieDataList(data: arr)
            self.tableView.reloadData()
        } catch {
            
            print("Failed")
        }
    }
    
    func deleteAllRecords() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            self.createData()
        } catch {
            
        }
    }
}
