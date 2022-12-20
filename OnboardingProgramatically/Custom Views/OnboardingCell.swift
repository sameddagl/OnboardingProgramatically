//
//  OnboardingCell.swift
//  OnboardingProgramatically
//
//  Created by Samed Dağlı on 20.12.2022.
//

import UIKit

final class OnboardingCell: UICollectionViewCell {
    static let reuseID = "OnboardingCell"
    
    private let cellImage = UIImageView()
    private let titleLabel = TitleLabel(alignment: .center, fontSize: 30)
    private let descriptionLabel = SecondaryLabel(alignment: .center, fontSize: 15)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    func set(page: PageModel) {
        cellImage.image = page.image
        titleLabel.text = page.title
        descriptionLabel.text = page.description
    }
    
    private func configure() {
        addSubview(cellImage)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        cellImage.contentMode = .scaleAspectFit
        
        cellImage.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
            make.width.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.5)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalTo(cellImage)
            make.bottom.equalTo(self).offset(-30)
            make.leading.equalTo(self).offset(30)
            make.trailing.equalTo(self).offset(-30)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(cellImage)
            make.bottom.equalTo(descriptionLabel.snp.top).offset(-10)
            make.leading.equalTo(self).offset(40)
            make.trailing.equalTo(self).offset(-40)
        }
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
