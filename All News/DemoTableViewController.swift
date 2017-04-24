//
//  DemoTableViewController.swift
//  TestCollectionView
//
//  Created by Alex K. on 24/05/16.
//  Copyright © 2016 Alex K. All rights reserved.
//

import UIKit
import expanding_collection


class DemoTableViewController: ExpandingTableViewController {
  
    @IBOutlet weak var descriptionTextField: UITextView!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    
    fileprivate var scrollOffsetY: CGFloat = 0
    override func viewDidLoad() {
    super.viewDidLoad()
        configureNavBar()
        titleLabel.text = currentNews[0][0]
        descriptionTextField.text = currentNews[0][1]
        timeLabel.text = currentNews[0][3]
        newsImageView.image = UIImage(named: "x")
  }
    
}
// MARK: Helpers

extension DemoTableViewController {
  
  fileprivate func configureNavBar() {
    navigationItem.leftBarButtonItem?.image = navigationItem.leftBarButtonItem?.image!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    navigationItem.rightBarButtonItem?.image = navigationItem.rightBarButtonItem?.image!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
  }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height
    }
    
}

// MARK: Actions

extension DemoTableViewController {
  
  @IBAction func backButtonHandler(_ sender: AnyObject) {
    // buttonAnimation
    let viewControllers: [EventViewController?] = navigationController?.viewControllers.map { $0 as? EventViewController } ?? []

    for _ in viewControllers {
//      if let rightButton = viewController?.navigationItem.rightBarButtonItem as? AnimatingBarButton {
//        rightButton.animationSelected(false)
//      }
    }
    popTransitionAnimation()
  }
}

// MARK: UIScrollViewDelegate

extension DemoTableViewController {
  
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.contentOffset.y < -50 {
      // buttonAnimation
//      let viewControllers: [DemoViewController?] = navigationController?.viewControllers.map { $0 as? DemoViewController } ?? []

//      for viewController in viewControllers {
//        if let rightButton = viewController?.navigationItem.rightBarButtonItem as? AnimatingBarButton {
//          rightButton.animationSelected(false)
//        }
//      }
      popTransitionAnimation()
    }
    
    scrollOffsetY = scrollView.contentOffset.y
  }
}
