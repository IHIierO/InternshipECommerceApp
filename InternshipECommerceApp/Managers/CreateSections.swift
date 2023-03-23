//
//  CreateSections.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 14.03.2023.
//

import UIKit

enum GroupAlignment {
    case vertical
    case horizontal
}

struct CreateSection {
    
    /// Сreat item for UIcollectionView
    /// - Parameters:
    ///   - width: item width
    ///   - height: item height
    ///   - contentInsets: contetn insets
    static func createItem (width: NSCollectionLayoutDimension,
                            height: NSCollectionLayoutDimension,
                            contentInsets: NSDirectionalEdgeInsets
    ) -> NSCollectionLayoutItem {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: width, heightDimension: height))
        item.contentInsets = contentInsets
        return item
    }
    
    /// Create group for UIcollectionView
    /// - Parameters:
    ///   - alignment: group alignment
    ///   - width: group width
    ///   - height: group height
    ///   - item: subItem for group
    ///   - count: item count
    static func createGroup (alignment: GroupAlignment,
                             width: NSCollectionLayoutDimension,
                             height: NSCollectionLayoutDimension,
                             item: NSCollectionLayoutItem,
                             count: Int
    ) -> NSCollectionLayoutGroup {
        switch alignment {
        case .vertical:
            return NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: width, heightDimension: height), subitem: item, count: count)
        case .horizontal:
            return NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: width, heightDimension: height), subitem: item, count: count)
        }
    }
    
    /// Create group for UIcollectionView
    /// - Parameters:
    ///   - alignment: group alignment
    ///   - width: group width
    ///   - height: group height
    ///   - item: subItems for group
    static func createGroup (alignment: GroupAlignment,
                             width: NSCollectionLayoutDimension,
                             height: NSCollectionLayoutDimension,
                             item: [NSCollectionLayoutItem]
    ) -> NSCollectionLayoutGroup {
        switch alignment {
        case .vertical:
            return NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: width, heightDimension: height), subitems: item)
        case .horizontal:
            return NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: width, heightDimension: height), subitems: item)
        }
    }
}

