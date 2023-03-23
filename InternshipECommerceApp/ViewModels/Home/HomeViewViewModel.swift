//
//  File.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 14.03.2023.
//

import UIKit
import Combine

//MARK: - HomeViewViewModelDelegate
protocol HomeViewViewModelDelegate: AnyObject {
    func didLoadInitialData()
    func didSelectLatest(_ latest: Latest)
}

final class HomeViewViewModel: NSObject {
    
    private var dataSource: UICollectionViewDiffableDataSource<HomeSectionKind, Int>?
    
    public weak var delegate: HomeViewViewModelDelegate?
    
    
    /// Section kind enum
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
    
    /// Latest products container
    private var latests: [Latest] = [] {
        didSet {
            for latest in latests {
                let viewModel = LatestCollectionViewCellViewModel(
                    imageUrl: URL(string: latest.image_url),
                    categoryLabel: latest.category,
                    nameLabel: latest.name,
                    priceLabel: latest.price)
                if !latestCellViewModels.contains(viewModel) {
                    latestCellViewModels.append(viewModel)
                }
            }
        }
    }
    private var latestCellViewModels: [LatestCollectionViewCellViewModel] = []
    
    /// Flash sales products container
    private var flashSales: [FlashSale] = [] {
        didSet {
            for flashSale in flashSales {
                let viewModel = FlashSaleCollectionViewCellViewModel(
                    imageUrl: URL(string: flashSale.image_url),
                    categoryLabel: flashSale.category,
                    nameLabel: flashSale.name,
                    discountLabel: flashSale.discount,
                    priceLabel: flashSale.price)
                if !flashSaleCellViewModels.contains(viewModel) {
                    flashSaleCellViewModels.append(viewModel)
                }
            }
        }
    }
    private var flashSaleCellViewModels: [FlashSaleCollectionViewCellViewModel] = []
    
    private let dataManagerViewModel = DataManagerViewModel()
    private var cancellables = Set<AnyCancellable>()
    
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
        return section
    }
    private func createLatestSection() -> NSCollectionLayoutSection {
        let item = CreateSection.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), contentInsets: .init(top: 8, leading: 8, bottom: 8, trailing: 8))
        let group = CreateSection.createGroup(alignment: .horizontal, width: .fractionalWidth(0.35), height: .fractionalWidth(0.42), item: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(32))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
    private func createFlashSaleSection() -> NSCollectionLayoutSection {
        let item = CreateSection.createItem(width: .fractionalWidth(1), height: .fractionalHeight(1), contentInsets: .init(top: 8, leading: 8, bottom: 8, trailing: 8))
        let group = CreateSection.createGroup(alignment: .horizontal, width: .fractionalWidth(0.49), height: .fractionalWidth(0.63), item: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
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
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
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
        let menuItemCount = MenuItems.allCases.count
        switch sections {
        case .menu:
            return menuItemCount
        case .latest:
            return latestCellViewModels.count
        case .flashSale:
            return flashSaleCellViewModels.count
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
            guard let menuItemCell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuItemCollectionViewCell.reuseId, for: indexPath) as? MenuItemCollectionViewCell else {
                return cell
            }
            let model = MenuItems.allCases
            menuItemCell.configure(with: model[indexPath.row])
            return menuItemCell
        case .latest:
            guard let latestCell = collectionView.dequeueReusableCell(withReuseIdentifier: LatestCollectionViewCell.reuseId, for: indexPath) as? LatestCollectionViewCell else {
                return cell
            }
            let viewModels = latestCellViewModels
            latestCell.configure(with: viewModels[indexPath.row])
            return latestCell
        case .flashSale:
            guard let flashSaleCell = collectionView.dequeueReusableCell(withReuseIdentifier: FlashSaleCollectionViewCell.reuseId, for: indexPath) as? FlashSaleCollectionViewCell else {
                return cell
            }
            let viewModels = flashSaleCellViewModels
            flashSaleCell.configure(with: viewModels[indexPath.row])
            return flashSaleCell
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let sections = HomeSectionKind(rawValue: indexPath.section)
        switch sections {
        case .menu:
            break
        case .latest:
            let latest = latests[indexPath.row]
            delegate?.didSelectLatest(latest)
        case .flashSale:
            break
        case .brands:
            break
        case .none:
            break
        }
    }
    
}

// MARK: - Fetch Data
extension HomeViewViewModel {
    private func fetchLatest() {
        Service.shared.execute(.latestRequest, expexting: GetAllLatests.self) {
            [weak self] results in
            switch results {
            case .success(let responseModel):
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)){
                    let results = responseModel.latest
                    self?.latests = results
                    self?.dataManagerViewModel.updatePublishers(for: .latest)
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    private func fetchFlashSale() {
        Service.shared.execute(.flashSaleRequest, expexting: GetAllLFlashSale.self) {
            [weak self] results in
            switch results {
            case .success(let responseModel):
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)){
                    let results = responseModel.flash_sale
                    self?.flashSales = results
                    self?.dataManagerViewModel.updatePublishers(for: .flashSale)
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    public func fetchAllData() {
        fetchLatest()
        fetchFlashSale()
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else {return}
            strongSelf.dataManagerViewModel.allDataEnabled
                .contains(true)
                .sink { _ in
                    self?.delegate?.didLoadInitialData()
                }
                .store(in: &strongSelf.cancellables)
        }
    }
}
