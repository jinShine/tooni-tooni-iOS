//
//  WeekViewController.swift
//  toonitooni
//
//  Created by buzz on 2021/04/26.
//

import UIKit

class WeekViewController: BaseViewController {

  // MARK: - UI Properties

  @IBOutlet weak var navigationView: GeneralNavigationView!
  @IBOutlet weak var weekMenuBarView: WeekMenuBarView!
  @IBOutlet weak var weekCategoryView: WeekCategoryView!
  @IBOutlet weak var contentCollectionView: UICollectionView!

  // MARK: - Properties

  let webToons: [WebToon] = webToonDatas

  // MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    didSelectWeekMenuBarItem()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    selectCurrentWeekDay()
  }

  // MARK: - Setup

  func setupUI() {
    view.backgroundColor = .white
    setupNavigationView()
    setupContentCollectionView()
  }

  func setupNavigationView() {
    navigationView.title(tabItem?.title)
    navigationView.bigTitle(false)
  }

  func setupContentCollectionView() {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .horizontal
    flowLayout.minimumInteritemSpacing = .zero
    flowLayout.minimumLineSpacing = .zero
    flowLayout.itemSize = CGSize(width: view.frame.width, height: contentCollectionView.frame.height)

    contentCollectionView.collectionViewLayout = flowLayout
    contentCollectionView.showsVerticalScrollIndicator = false
    contentCollectionView.showsHorizontalScrollIndicator = false
    contentCollectionView.isPagingEnabled = true
    contentCollectionView.backgroundColor = .white
    contentCollectionView.dataSource = self
    contentCollectionView.delegate = self

    let weekWebToonListCell = UINib(nibName: WeekWebToonListCell.reuseIdentifier, bundle: nil)
    contentCollectionView.register(
      weekWebToonListCell,
      forCellWithReuseIdentifier: WeekWebToonListCell.reuseIdentifier
    )
  }
}

// MARK: - Handler

extension WeekViewController {

  private func didSelectWeekMenuBarItem() {
    weekMenuBarView.didSelectWeekMenuBarItem = { [weak self] menuBar, indexPath in
      self?.contentCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
  }
}

// MARK: - Helper methods

extension WeekViewController {

  private func selectCurrentWeekDay() {
    let indexPath = IndexPath(item: WeekMenuBarItem.currentWeekDay, section: 0)
    contentCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredHorizontally)
  }
}

// MARK: - CollectionView datasource

extension WeekViewController: UICollectionViewDataSource {

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return WeekMenuBarItem.total.rawValue
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekWebToonListCell.reuseIdentifier, for: indexPath) as? WeekWebToonListCell else {
      return UICollectionViewCell()
    }

    cell.bind(webToons)

    return cell
  }
}

// MARK: - CollectionView delegate

extension WeekViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
  }

  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let position = Int(scrollView.contentOffset.x / view.frame.width)
    let indexPath = IndexPath(item: position, section: 0)

    weekMenuBarView.selectMenuBarItem(at: indexPath)
  }
}
