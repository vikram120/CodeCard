//
//  ViewController.swift
//  CodeCard
//
//  Created by Vikram Kunwar on 07/03/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cardCollectionView: UICollectionView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    var filteredCards: [Card] = []
    var allCards: [Card] = []
    var segmentTitles: [String] = ["All"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        loadCardsFromAPI()
        setupSegmentedControl()
        selectDefaultSegment()
    }
    
    private func setupCollectionView() {
        cardCollectionView.dataSource = self
        cardCollectionView.delegate = self
    }
    
    private func loadCardsFromAPI() {
        async {
            do {
                let api = APIImpl.shared
                let jsonData = try await api.getCards()
                self.allCards = try JSONDecoder().decode([Card].self, from: Data(jsonData.utf8))
                self.filteredCards = self.allCards
                self.populateSegmentTitles()
                DispatchQueue.main.async {
                    self.setupSegmentedControl()
                    self.cardCollectionView.reloadData()
                }
            } catch {
                print("Error fetching card data: \(error)")
            }
        }
    }
    
    private func setupSegmentedControl() {
        segmentControl.removeAllSegments()
        for (index, title) in segmentTitles.enumerated() {
            segmentControl.insertSegment(withTitle: truncatedTitle(title), at: index, animated: false)
        }
        segmentControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        let font = UIFont.systemFont(ofSize: 8)
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
    }
    
    private func selectDefaultSegment() {
        segmentControl.selectedSegmentIndex = 0
        segmentedControlValueChanged(segmentControl)
    }
    
    private func truncatedTitle(_ title: String) -> String {
        let maxLength = 30
        return title.count > maxLength ? String(title.prefix(maxLength)) + "..." : title
    }
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let selectedTitle = segmentTitles[sender.selectedSegmentIndex]
        filteredCards = selectedTitle == "All" ? allCards : allCards.filter { $0.types.contains(selectedTitle) }
        cardCollectionView.reloadData()
    }
    
    private func populateSegmentTitles() {
        segmentTitles.removeAll()
        segmentTitles.append("All")
        segmentTitles += allCards.flatMap { $0.types }.removingDuplicates()
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ListOfCardsCVC
        let card = filteredCards[indexPath.item]
        
        cell.cardName.text = card.nameEnglish
        if let imageUrl = card.imageUrls.first, let url = URL(string: imageUrl) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        cell.cardImg.image = UIImage(data: data)
                    }
                }
            }
        }
        return cell
    }
}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var set = Set<Element>()
        var result = [Element]()
        for item in self {
            if set.insert(item).inserted {
                result.append(item)
            }
        }
        return result
    }
}
