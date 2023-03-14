//
//  File.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 14.03.2023.
//

import UIKit

final class HomeViewViewModel: NSObject {
    
    private var dataSource: UICollectionViewDiffableDataSource<HomeSectionKind, Int>?
    private enum HomeSectionKind: Int, CaseIterable {
        case menu, latest, flashSale, brands
        
        var sectionName: String {
            switch self {
            case .menu:
                return ""
            case .latest:
                return "Latest"
            case .flashSale:
                return "Flash Sale"
            case .brands:
                return "Brands"
            }
        }
    }
    
    // MARK: - Create layout
    public func createLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex, layoutEnvirnment) -> NSCollectionLayoutSection? in
            guard let section = HomeSectionKind(rawValue: sectionIndex) else {
                return nil
            }
            switch section {
            case .latest:
                return self?.createLatestSection()
            case .flashSale:
                return self?.createFlashSaleSection()
            case .brands:
                return self?.createBrandsSection()
            case .menu:
                return self?.createMenuSection()
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        
        return layout
    }
    private func createMenuSection() -> NSCollectionLayoutSection {
        let item = CreateSection.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), contentInsets: .init(top: 8, leading: 8, bottom: 8, trailing: 8))
        let group = CreateSection.createGroup(alignment: .horizontal, width: .fractionalWidth(0.18), height: .fractionalWidth(0.2), item: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        //section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        return section
    }
    private func createLatestSection() -> NSCollectionLayoutSection {
        let item = CreateSection.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), contentInsets: .init(top: 8, leading: 8, bottom: 8, trailing: 8))
        let group = CreateSection.createGroup(alignment: .horizontal, width: .fractionalWidth(0.3), height: .fractionalWidth(0.4), item: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
       // section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(32))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
    private func createFlashSaleSection() -> NSCollectionLayoutSection {
        let item = CreateSection.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), contentInsets: .init(top: 8, leading: 8, bottom: 8, trailing: 8))
        let group = CreateSection.createGroup(alignment: .horizontal, width: .fractionalWidth(0.46), height: .fractionalWidth(0.58), item: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        //section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(32))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
    private func createBrandsSection() -> NSCollectionLayoutSection {
        let item = CreateSection.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), contentInsets: .init(top: 8, leading: 8, bottom: 8, trailing: 8))
        let group = CreateSection.createGroup(alignment: .horizontal, width: .fractionalWidth(0.3), height: .fractionalWidth(0.4), item: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
       // section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(32))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension HomeViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let sections = HomeSectionKind.allCases
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sections = HomeSectionKind(rawValue: section)
        let menuItemCount = MenuItem.allCases.count
        switch sections {
        case .menu:
            return menuItemCount
        case .latest:
            return 4
        case .flashSale:
            return 3
        case .brands:
            return 4
        case .none:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemBlue
        let sections = HomeSectionKind(rawValue: indexPath.section)
        switch sections {
        case .menu:
            return cell
        case .latest:
            return cell
        case .flashSale:
            return cell
        case .brands:
            return cell
        case .none:
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderForCollectionView.reuseId, for: indexPath) as? HeaderForCollectionView else {
            fatalError()
        }
        let sections = HomeSectionKind(rawValue: indexPath.section)
        header.headerLabel.text = sections?.sectionName
        switch sections {
        case .menu:
            return header
        case .latest:
            return header
        case .flashSale:
            return header
        case .brands:
            return header
        case .none:
            return header
        }
    }
    
}
