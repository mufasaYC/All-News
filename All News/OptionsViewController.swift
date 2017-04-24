//
//  OptionsViewController.swift
//  All News
//
//  Created by Mustafa Yusuf on 09/03/17.
//  Copyright © 2017 Mustafa Yusuf. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class OptionsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var flag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
		
		tableView.delegate = self
		tableView.dataSource = self
        fetchNews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if flag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "logo", for: indexPath) as! LogoCell
            cell.logoImageView.backgroundColor = UIColor(red: CGFloat(arc4random()%255)/255.0, green: CGFloat(arc4random()%255)/255.0, blue: CGFloat(arc4random()%255)/255.0, alpha: 1.0)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "both", for: indexPath) as! BothCell
            cell.logoImageView.backgroundColor = UIColor(red: CGFloat(arc4random()%255)/255.0, green: CGFloat(arc4random()%255)/255.0, blue: CGFloat(arc4random()%255)/255.0, alpha: 1.0)
            cell.nameLabel.text = news[indexPath.row]
            return cell
        }
    }
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return news_mera.count
	}
	
	var news_mera = [NSDictionary]()
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		cell.textLabel?.text = news_mera[indexPath.row]["title"] as! String
		return cell
	}
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let x = UIScreen.main.bounds.width/4
        if flag == 0 {
            return CGSize(width: x, height: x)
        } else {
            return CGSize(width: 4*x, height: 69)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.53,0.53,0.53)
        UIView.animate(withDuration: 0.3, animations: {
            cell.layer.transform = CATransform3DMakeScale(1,1,1)
        },completion: { finished in
            UIView.animate(withDuration: 0.1, animations: {
                cell.layer.transform = CATransform3DMakeScale(1,1,1)
            })
        })

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        fetchNews()
    }
    
    var done = 0
    var total = 0
    
	@IBOutlet weak var tableView: UITableView!
	
	
	
    func fetchNews() {
        let parameters = ["source":"bbc-news","sortBy":"top","apiKey":"\(apiKey)"]
		
		Alamofire.request("https://newsapi.org/v1/articles", method: .get, parameters: parameters).responseJSON(completionHandler: {response in
		
			print(response)
			let x = response.value as! NSDictionary
			let y = x["articles"] as! [NSDictionary]
			self.news_mera = y
			self.tableView.reloadData()
		})
		
//		Alamofire.request("https://newsapi.org/v1/articles", method: .get, parameters: parameters).responseJSON(completionHandler: {response in
//		
//			//print(response)
//			let x = response.value as! NSDictionary
//			self.news_mera = x["articles"] as! [NSDictionary]
//			
//			self.tableView.reloadData()
//		
//		})
		
//        Alamofire.request("https://newsapi.org/v1/articles", method: .get, parameters: parameters).responseJSON(completionHandler: {res in
//            
//            if res.result.isSuccess == true {
//                currentNews.removeAll()
//                newsImage.removeAll()
//                self.done = 0
//                let JSON = res.result.value as! NSDictionary
//                let articles = JSON["articles"] as! [NSDictionary]
//                self.total = articles.count
//                for i in articles {
//                    //print(i["title"] as! String)
//                    Alamofire.request(i["urlToImage"] as! String).responseImage { response in
//                        
//                        //debugPrint(response)
//                        //debugPrint(response.result)
//                        
//                        if let image = response.result.value {
//                            let x = ["\(i["title"]!)","\(i["description"]!)","\(i["author"]!)","\(i["publishedAt"]!)"]
//                            currentNews.append(x)
//                            newsImage.append(image)
//                            self.done += 1
//                            self.proceed()
//                        }
//                        
//                    }
//                }
//                
//            }
//            
//            
//            
//        })
        //performSegue(withIdentifier: "show", sender: self)
    }
    
    func proceed() {
        if done == total {
            print(currentNews.count)
            print(newsImage.count)
            performSegue(withIdentifier: "show", sender: self)
        }
    }
    
    @IBAction func changeFlag(_ sender: Any) {
        
        flag = (flag + 1) % 2
        collectionView.reloadData()
        
    }


}
