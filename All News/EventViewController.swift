//
//  ViewController.swift
//  Events @VIT
//
//  Created by Mustafa Yusuf on 26/01/17.
//  Copyright © 2017 Mustafa Yusuf. All rights reserved.
//

import UIKit
import expanding_collection

class EventViewController: ExpandingViewController {
    
    
    fileprivate var cellsIsOpen = [Bool]()
    
    
}

// MARK: life cicle

extension EventViewController {
    
    override func viewDidLoad() {
        itemSize = CGSize(width: 256, height: 335)
        super.viewDidLoad()
        
        registerCell()
        fillCellIsOpeenArry()
        addGestureToView(collectionView!)
        configureNavBar()
    }
}

// MARK: Helpers

extension EventViewController {
    
    fileprivate func registerCell() {
        
        let nib = UINib(nibName: String(describing: EventCollectionViewCell.self), bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: String(describing: EventCollectionViewCell.self))
    }
    
    fileprivate func fillCellIsOpeenArry() {
        for _ in currentNews {
            cellsIsOpen.append(false)
        }
    }
    
    fileprivate func getViewController() -> ExpandingTableViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let toViewController: ExpandingTableViewController = storyboard.instantiateViewController(withIdentifier: "DemoTableViewController") as! ExpandingTableViewController
        return toViewController
    }
    
    fileprivate func configureNavBar() {
        navigationItem.leftBarButtonItem?.image = navigationItem.leftBarButtonItem?.image!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    }
}

/// MARK: Gesture

extension EventViewController {
    
    fileprivate func addGestureToView(_ toView: UIView) {
        
        let gesutereUp = UISwipeGestureRecognizer(target: self, action: #selector(EventViewController.swipeHandler(_:)))
        gesutereUp.direction = .up
        
        
        
        
        let gesutereDown = UISwipeGestureRecognizer(target: self, action: #selector(EventViewController.swipeHandler(_:)))
        gesutereDown.direction = .down
        
        toView.addGestureRecognizer(gesutereUp)
        toView.addGestureRecognizer(gesutereDown)
    }
    
    func swipeHandler(_ sender: UISwipeGestureRecognizer) {
        let indexPath = IndexPath(row: currentIndex, section: 0)
        guard let cell  = collectionView?.cellForItem(at: indexPath) as? EventCollectionViewCell else { return }
        // double swipe Up transition
        if cell.isOpened == true && sender.direction == .up {
            pushToViewController(getViewController())
            
//            if let rightButton = navigationItem.rightBarButtonItem as? AnimatingBarButton {
//                rightButton.animationSelected(true)
//            }
        }
        
        let open = sender.direction == .up ? true : false
        cell.cellIsOpen(open)
        cellsIsOpen[indexPath.row] = cell.isOpened
        //cellsIsOpen[(indexPath as NSIndexPath).row] = cell.isOpened
    }
}

// MARK: UIScrollViewDelegate

extension EventViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        pageLabel.text = "\(currentIndex+1)/\(items.count)"
    }
}

// MARK: UICollectionViewDataSource

extension EventViewController {
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        super.collectionView(collectionView, willDisplay: cell, forItemAt: indexPath)
        guard let cell = cell as? EventCollectionViewCell else { return }
        
        //let index = (indexPath as NSIndexPath).row % currentNews.count
        //let info = items[index]
        //cell.backgroundImageView?.image = UIImage(named: "x") //remove info.imageName
        cell.customTitle.text = currentNews[indexPath.row][0]//info.title
        cell.descriptionLabel.text = currentNews[indexPath.row][1]
        cell.publishedLabel.text = currentNews[indexPath.row][3]
        cell.authorLabel.text = currentNews[indexPath.row][2]
        cell.backgroundImageView.image = newsImage[indexPath.row]
        //cell.cellIsOpen(cellsIsOpen[index], animated: false)
        cell.cellIsOpen(cellsIsOpen[indexPath.row], animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? EventCollectionViewCell
            , currentIndex == (indexPath as NSIndexPath).row else { return }
        
        if cell.isOpened == false {
            cell.cellIsOpen(true)
        } else {
            pushToViewController(getViewController())
            
//            if let rightButton = navigationItem.rightBarButtonItem as? AnimatingBarButton {
//                rightButton.animationSelected(true)
//            }
        }
    }
}

// MARK: UICollectionViewDataSource
extension EventViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentNews.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: EventCollectionViewCell.self), for: indexPath)
    }
}
