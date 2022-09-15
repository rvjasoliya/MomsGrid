//
//  IntroViewController.swift
//  Peppy
//
//  Created by Jaydeep Godhani on 07/07/21.
//

import UIKit

class IntroViewController: UIViewController{

    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var pageViewCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
        
    var imageViewArray =
        [
            "ic-onboarding-illustration-1",
            "ic-onboarding-illustration-2",
            "ic-onboarding-illustration-3"
        ]
    var descTextArray =
        [
            "Connect with other moms around you.",
            "Finds moms who matches with your interests",
            "Start chatting to say hello moms you like one."
        ]

    override func viewDidLoad() {
        super.viewDidLoad()
        pageViewCollectionView.delegate = self
        pageViewCollectionView.dataSource = self
        pageControl.numberOfPages = imageViewArray.count
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = UIColor.init(patternImage: UIImage(named: "ic_active_slider")!)
        pageControl.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        pageControl.isUserInteractionEnabled = false
        // Do any additional setup after loading the view.
    }
    @IBAction func nextButtonAction(_ sender: UIButton) {
        if self.imageViewArray.count != 0 {
            self.scrollToPreviousOrNextCell(direction: "Next")
        }
    }
    @IBAction func skipButtonAction(_ sender: UIButton) {
        let signInVC = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        navigationController?.pushViewController(signInVC, animated: true)
    }
    @objc func changePage(sender: UIPageControl) -> () {
        print(sender.currentPage)
        let x = CGFloat(sender.currentPage) * pageViewCollectionView.frame.size.width
        pageViewCollectionView.setContentOffset(CGPoint(x:x, y:0), animated: true)
    }
    
    func scrollToPreviousOrNextCell(direction: String)
    {
        let lastIndex = (self.imageViewArray.count) - 1
        let visibleIndices = self.pageViewCollectionView.indexPathsForVisibleItems
        let nextIndex = visibleIndices[0].row + 1
        let skipIndex = lastIndex
        let nextIndexPath: IndexPath = IndexPath.init(item: nextIndex, section: 0)
        let skipIndexPath: IndexPath = IndexPath.init(item: skipIndex, section: 0)
        if direction == "Skip"
        {
            self.pageViewCollectionView.scrollToItem(at: skipIndexPath, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = skipIndex
            nextButton.setTitle("Gets Started", for: .normal)
            skipButton.isHidden = true
            nextButton.addTarget(self, action: #selector(getStartButtonAction), for: .touchUpInside)
        }
        else if direction == "Next"
        {
            if nextIndex <= lastIndex
            {
                self.pageViewCollectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
                pageControl.currentPage = nextIndex
                if nextIndex == lastIndex
                {
                    pageControl.currentPage = nextIndex
                    nextButton.setTitle("Gets Started", for: .normal)
                    skipButton.isHidden = true
                    nextButton.addTarget(self, action: #selector(getStartButtonAction), for: .touchUpInside)
                }
            }
        }
    }
    @objc private func getStartButtonAction(_ sender: UIButton){
        let signInVC = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        navigationController?.pushViewController(signInVC, animated: true)
    }
    
}
extension IntroViewController: UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageViewArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageViewCollectionViewCell", for: indexPath) as! PageViewCollectionViewCell
        cell.imageView.image = UIImage(named: imageViewArray[indexPath.row])
        cell.middleLabel.text = descTextArray[indexPath.row]
        cell.middleLabel.numberOfLines = 2
        return cell
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
}
extension IntroViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = imageView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
}
