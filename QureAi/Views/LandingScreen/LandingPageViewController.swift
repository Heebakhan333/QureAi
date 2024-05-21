//
//  LandingPageViewController.swift
//  QureAi
//
//  Created by Heeba Khan on 16/05/24.
//

import UIKit

class LandingPageViewController: UIViewController {
    
    //MARK: Variables
    var themeManager: ThemeManager = AppThemeManager()
    var viewModel: LandingPageViewModel!
    var autoScrollTimer: Timer?
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            updateButtonTitle()
        }
    }
    var hasReachedLastPage = false
    var scrollDirectionIsForward = true
    var isManualScrolling = false
    
    
    //MARK: Outlets
    @IBOutlet weak var onboardingBackgroundView: UIView!
    @IBOutlet weak var onboardingBackgroundImageView: UIImageView!
    @IBOutlet weak var onboardingCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var onboardingQureLogo: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    //MARK: Actions
    @IBAction func pageControlAction(_ sender: UIPageControl) {
    }
    @IBAction func getStartedButtonAction(_ sender: UIButton) {
        // checks if this is the last page then go to worklist
        if currentPage == viewModel.items.count - 1 {
            print("go to nect page")
        } else if hasReachedLastPage {
            print("go to nect page")
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            onboardingCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    
    
    
    //MARK: private functions
    private func setupUI() {
        viewModel = LandingPageViewModel()
        viewModel.fetchItems()
        self.getStartedButton.setTitle(AppStrings.next, for: .normal)
        self.getStartedButton.titleLabel?.font = UIFont.customFont(.boldItalic, size: 30)
        self.getStartedButton.tintColor = AppColors.getStartedBtnColor
        self.getStartedButton.backgroundColor = AppColors.accentColor
        self.onboardingQureLogo.image = AppImages.qureOnboardingLogo
        self.onboardingBackgroundView.backgroundColor = .clear
        self.onboardingQureLogo.contentMode = .scaleAspectFit
        self.onboardingCollectionView.bouncesHorizontally = false
        self.onboardingCollectionView.showsHorizontalScrollIndicator = false
        setUpCollectionView()
    }
    
    //Sets up collection view ui and data
    private func setUpCollectionView(){
        let nib = UINib(nibName: CellIdentifiers.landingPageCollectionViewCell, bundle: nil)
        onboardingCollectionView.register(nib, forCellWithReuseIdentifier: CellIdentifiers.landingPageCollectionViewCell)
        // Set the data source and delegate
        onboardingCollectionView.dataSource = self
        onboardingCollectionView.delegate = self
        onboardingCollectionView.reloadData()
        startAutoScroll()
    }
    
    func updateButtonTitle() {
        if currentPage == viewModel.items.count - 1 {
            hasReachedLastPage = true
            getStartedButton.setTitle(AppStrings.getStarted, for: .normal)
        } else if hasReachedLastPage {
            getStartedButton.setTitle(AppStrings.getStarted, for: .normal)
        } else {
            getStartedButton.setTitle(AppStrings.next, for: .normal)
        }
    }
    
    func startAutoScroll() {
        autoScrollTimer?.invalidate()
        autoScrollTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollToNextItem), userInfo: nil, repeats: true)
    }
    
    func switchToDarkTheme() {
        themeManager.currentTheme = DarkTheme()
    }
    
    func switchToLightTheme() {
        themeManager.currentTheme = LightTheme()
    }
    
}

//MARK: CollectionViewDelegates and DataSources
extension LandingPageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.landingPageCollectionViewCell, for: indexPath) as! LandingPageCollectionViewCell
        let item = viewModel.items[indexPath.item]
        cell.setDataInCell(onboardingModel: item)
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension LandingPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Adjust item size as needed
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        startAutoScroll()
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        scrollViewDidEndScrolling(scrollView)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isManualScrolling = true // Mark manual scrolling start
        autoScrollTimer?.invalidate() // Pause auto-scrolling
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollViewDidEndScrolling(scrollView)
        }
    }
    
    private func scrollViewDidEndScrolling(_ scrollView: UIScrollView) {
        isManualScrolling = false // Mark manual scrolling end
        startAutoScroll() // Resume auto-scrolling
    }
}

//MARK: Infinite paging
extension LandingPageViewController {
    @objc func scrollToNextItem() {
        guard !isManualScrolling else { return } // Pause auto-scrolling if manual scrolling is in progress
        let numberOfSlides = (viewModel.items.count  + viewModel.items.count)
        guard numberOfSlides > 0 else { return }
        
        var nextIndex: Int
        
        if scrollDirectionIsForward {
            nextIndex = currentPage + 1
        } else {
            nextIndex = currentPage - 1
        }
        
        if scrollDirectionIsForward {
            nextIndex = currentPage + 1
            if nextIndex >= numberOfSlides {
                nextIndex = numberOfSlides - 2
                scrollDirectionIsForward = false
            }
        } else {
            nextIndex = currentPage - 1
            if nextIndex < 0 {
                nextIndex = 1
                scrollDirectionIsForward = true
            }
        }
        
        // Update scroll direction if necessary
        if nextIndex == 0 || nextIndex == viewModel.items.count - 1 {
            scrollDirectionIsForward = !scrollDirectionIsForward
        }
        let indexPath = IndexPath(item: nextIndex, section: 0)
        onboardingCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        currentPage = nextIndex
    }
    
    
}






