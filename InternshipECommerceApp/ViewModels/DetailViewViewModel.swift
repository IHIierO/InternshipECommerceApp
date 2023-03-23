//
//  DetailViewViewModel.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 22.03.2023.
//

import UIKit

protocol DetailViewViewModelDelegate: AnyObject {
    func updateDetailView()
}

final class DetailViewViewModel: NSObject {
    
    private var detail: Detail?
    public weak var delegate: DetailViewViewModelDelegate?
    
    // MARK: - fetch detail data
    public func fetchDetail() {
        Service.shared.execute(.detailRequest, expexting: Detail.self) {
            [weak self] results in
            switch results {
            case .success(let responseModel):
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)){
                    let results = responseModel
                    self?.detail = results
                    self?.delegate?.updateDetailView()
                        //self?.dataManagerViewModel.updatePublishers(for: .latest)
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    // MARK: - updateImageBlockDetailView
    public func updateImageBlockDetailView(for view: UIView) {
        guard let detail = detail else {return}
        guard let view = view as? ImagesBlockDetailView else {return}
        view.imagesScrollView.contentSize.width = view.imagesScrollView.frame.width * CGFloat(detail.image_urls.count)
        
        for (i, imageString) in detail.image_urls.enumerated() {
            let imageView = UIImageView()
            
            imageView.frame = CGRect(x: view.imagesScrollView.frame.width * CGFloat(i),
                                     y: 0,
                                     width: view.imagesScrollView.frame.width,
                                     height: view.imagesScrollView.frame.height)
            
            guard let url = URL(string: imageString) else {return}
            ImageLoader.shared.dowloadImage(url) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        imageView.image = image
                    }
                case .failure(let error):
                    print(String(describing: error))
                    break
                }
            }
            view.imagesScrollView.addSubview(imageView)
        }
    }
    // MARK: - updateDescriptionBlockDetailView
    public func updateDescriptionBlockDetailView(for view: UIView) {
        guard let detail = detail else {return}
        guard let view = view as? DescriptionBlockDetailView else {return}
            view.nameLabel.text = detail.name
            view.priceLabel.text = "$" + " " + String(describing: detail.price)
            view.descriptionLabel.text = detail.description
            
            let attachment = NSTextAttachment()
            attachment.image = UIImage(systemName: "star")?.withTintColor(UIColor(hexString: "#F6C042"))
            attachment.bounds = CGRect(x: 0, y: 0, width: 16, height: 16)
            
            let myAttribute: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont(name: CustomFonts.montserratRegular, size: 13.0) ?? .systemFont(ofSize: 13)]
            
            let imageString = NSMutableAttributedString(attachment: attachment)
            let ratingString = "\(detail.rating) (\(detail.number_of_reviews) reviews)"
            let textString = NSAttributedString(string: ratingString, attributes: myAttribute)
            imageString.append(textString)
            let range = (imageString.string as NSString).range(of: "(\(detail.number_of_reviews) reviews)")
            imageString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor(hexString: "#808080")], range: range)
            
            view.ratingLabel.attributedText = imageString
            
        view.colorsLabel.isHidden = false
            for i in 0 ..< detail.colors.count {
                let button = UIButton(configuration: .filled())
                button.configuration?.baseBackgroundColor = UIColor(hexString: "\(detail.colors[i])")
                button.configuration?.background.strokeColor = .systemGray3
                button.configuration?.cornerStyle = .large
                button.widthAnchor.constraint(equalToConstant: 32).isActive = true
                button.heightAnchor.constraint(equalToConstant: 24).isActive = true
                view.colorsStackView.addArrangedSubview(button)
            
        }
    }
    // MARK: - updateTotalBlockDetailView
    public func updateTotalBlockDetailView(for view: UIView) {
        guard let detail = detail else {return}
        guard let view = view as? TotalBlockDetailView else {return}
        view.price = detail.price
        view.addToCartButton.configuration?.title = "# " + String(describing: detail.price) + " " + "ADD TO CART"
    }
}

