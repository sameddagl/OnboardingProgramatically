//
//  OnboardingViewController.swift
//  OnboardingProgramatically
//
//  Created by Samed Dağlı on 20.12.2022.
//

import UIKit
import SnapKit

final class OnboardingViewController: UIViewController {
    private var collectionView: UICollectionView!
    private var pageControl = UIPageControl()
    private let nextButton = UIButton()
    
    private let pages = [
        PageModel(animationName: "dishes", title: "Delicious Dishes", description: "Experince a variety of amazing dishes from different cultures around the world"),
        PageModel(animationName: "cook", title: "World Class Chefs", description: "Our dishes are prepared by only the best"),
        PageModel(animationName: "deliveryGuy", title: "Instant delivery", description: "Your orders will be delivered instantly")
    ]
    private var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == pages.count - 1{
                self.nextButton.setTitle("Get started", for: .normal)
            }
            else {
                self.nextButton.setTitle("Next", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    @objc private func nextTapped() {
        if currentPage < pages.count - 1 {
            currentPage += 1
            collectionView.scrollToItem(at: IndexPath(row: currentPage, section: 0), at: .centeredHorizontally, animated: true)
        }
        else {
            UserDefaults.standard.hasOnboarded = true
            
            let vc = HomeVC()
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            present(vc, animated: true)
        }
    }
}

extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.reuseID, for: indexPath) as! OnboardingCell
        cell.set(page: pages[indexPath.row])
        return cell
    }
}

extension OnboardingViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        currentPage = Int(pageNumber)
    }
}


//MARK: - UI Related
extension OnboardingViewController {
    private func layout() {
        configureView()
        createCollectionView()
        configureePageControl()
        configureNextButton()
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func createCollectionView() {
        collectionView = UICollectionView(frame: .init(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.8), collectionViewLayout: createFlowLayout())
        
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: OnboardingCell.reuseID)
        view.addSubview(collectionView)
    }
    
    private func createFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: view.frame.width, height: view.frame.height * 0.8)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        return layout
    }
    
    private func configureePageControl() {
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = currentPage
        pageControl.currentPageIndicatorTintColor = .systemPink
        pageControl.pageIndicatorTintColor = .systemGray5
        
        view.addSubview(pageControl)
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(collectionView.snp.bottom).offset(0)
        }
    }
    
    private func configureNextButton() {
        nextButton.setTitle("Next", for: .normal)
        nextButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        
        nextButton.backgroundColor = .systemPink
        
        nextButton.layer.cornerRadius = 10
        nextButton.layer.borderColor = UIColor.white.cgColor
        nextButton.layer.borderWidth = 2
        
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        
        view.addSubview(nextButton)
        
        nextButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(pageControl.snp.bottom).offset(10)
            make.width.equalTo(120)
            make.height.equalTo(50)
        }
    }
}
