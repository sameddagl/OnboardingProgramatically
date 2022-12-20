//
//  OnboardingCell.swift
//  OnboardingProgramatically
//
//  Created by Samed Dağlı on 20.12.2022.
//

import UIKit
import Lottie

final class OnboardingCell: UICollectionViewCell {
    static let reuseID = "OnboardingCell"
        
    private var animationView = LottieAnimationView()
    private let titleLabel = TitleLabel(alignment: .center, fontSize: 30)
    private let descriptionLabel = SecondaryLabel(alignment: .center, fontSize: 15)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    override func prepareForReuse() {
    }
    
    func set(page: PageModel) {
        titleLabel.text = page.title
        descriptionLabel.text = page.description
        animationView.animation = LottieAnimation.named(page.animationName)
        animationView.play()
    }
    
    private func configure() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        configureAnimationView()
        
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(-30)
            make.leading.equalTo(self).offset(30)
            make.trailing.equalTo(self).offset(-30)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.bottom.equalTo(descriptionLabel.snp.top).offset(-10)
            make.leading.equalTo(self).offset(40)
            make.trailing.equalTo(self).offset(-40)
        }
    }
    
    private func configureAnimationView() {
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1
        addSubview(animationView)
                
        animationView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self)
            make.width.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
