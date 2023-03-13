//
//  TabBarViewController.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 13.03.2023.
//

import UIKit

class TabBarController: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarConfig()
        setTabBarAppearance()
    }
    
    private func tabBarConfig(){
        let homeViewController = createNavigationControllers(
            viewControllers: HomeViewController(),
            tabBarItemImage: "tabBarItemHome",
            tabBarItemBage: nil,
            tag: 0
        )
        let favoriteViewController = createNavigationControllers(
            viewControllers: HomeViewController(),
            tabBarItemImage: "tabBarItemFavorite",
            tabBarItemBage: nil,
            tag: 1
        )
        let shoppingCartController = createNavigationControllers(
            viewControllers: HomeViewController(),
            tabBarItemImage: "tabBarItemShoppingCart",
            tabBarItemBage: nil,
            tag: 2
        )
        let conversationsController = createNavigationControllers(
            viewControllers: HomeViewController(),
            tabBarItemImage: "tabBarItemConversations",
            tabBarItemBage: nil,
            tag: 3
        )
        let profileController = createNavigationControllers(
            viewControllers: HomeViewController(),
            tabBarItemImage: "tabBarItemProfile",
            tabBarItemBage: nil,
            tag: 4
        )
        viewControllers = [homeViewController, favoriteViewController, shoppingCartController, conversationsController, profileController]
        [homeViewController, favoriteViewController, shoppingCartController, conversationsController, profileController].forEach({
            $0.navigationBar.prefersLargeTitles = true
            $0.navigationItem.largeTitleDisplayMode = .automatic
        })
    }
    
    private func createNavigationControllers(viewControllers: UIViewController, tabBarItemImage: String, tabBarItemBage: String?, tag: Int) -> UINavigationController{
        let tabBarItem = UITabBarItem(title: nil, image: UIImage(named: tabBarItemImage), tag: tag)
        tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: .zero, bottom: -10, right: .zero)
        tabBarItem.titlePositionAdjustment = .init(horizontal: 0, vertical: 10 )
        tabBarItem.badgeValue = tabBarItemBage
        let navigationController = UINavigationController(rootViewController: viewControllers)
        navigationController.tabBarItem = tabBarItem
        return navigationController
    }
    
    private func setTabBarAppearance(){
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        //tabBar.isTranslucent = true
        tabBar.backgroundColor = UIColor(hexString: "#FAF9FF")
        
        let customLayer = CAShapeLayer()
        customLayer.path = createPath()
        tabBar.layer.insertSublayer(customLayer, at: 0)
        
        customLayer.fillColor = UIColor(hexString: "#FFFFFF").cgColor
        
        tabBar.tintColor = UIColor(hexString: "#909090")
    }
    
    private func createPath() -> CGPath {
        
        let cornerRad: CGFloat = 30.0
        let centerWidth = self.tabBar.frame.width / 2
        let topLeftArc: CGPoint = CGPoint(x: self.tabBar.bounds.minX + cornerRad, y: self.tabBar.bounds.minY + cornerRad)
        let topRightArc: CGPoint = CGPoint(x: self.tabBar.bounds.maxX - cornerRad, y: self.tabBar.bounds.minY + cornerRad)
        let botRightArc: CGPoint = CGPoint(x: self.tabBar.bounds.maxX - cornerRad, y: self.tabBar.bounds.maxY + 10)
        let botLeftArc: CGPoint = CGPoint(x: self.tabBar.bounds.minX + cornerRad, y: self.tabBar.bounds.maxY + 10)
        
        let path = UIBezierPath()
        
        // start point
        path.move(to: CGPoint(x: self.tabBar.bounds.minX, y: self.tabBar.bounds.minY + cornerRad))
        
        // topLeftArc
        path.addArc(withCenter: topLeftArc, radius: cornerRad, startAngle: .pi * 1.0, endAngle: .pi * 1.5, clockwise: true)
    
        // topRightArc
        path.addArc(withCenter: topRightArc, radius: cornerRad, startAngle: -.pi * 0.5, endAngle: 0.0, clockwise: true)
        
        // botRightArc
        path.addArc(withCenter: botRightArc, radius: cornerRad, startAngle: 0.0, endAngle: .pi * 0.5, clockwise: true)
        
        // botLeftArc
        path.addArc(withCenter: botLeftArc, radius: cornerRad, startAngle: .pi * 0.5, endAngle: .pi * 1.0, clockwise: true)
        
        path.close()
        
        return path.cgPath
    }
    
//    func changeBageValue(){
//        if let tabBarItems = self.tabBar.items{
//            let i = tabBarItems[2]
//            i.badgeValue = Persons.ksenia.productsInCart.count > 0 ? "\(Persons.ksenia.productsInCart.count)" : nil
//        }
//    }
}
