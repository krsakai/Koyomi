//
//  Koyomi.swift
//  Pods
//
//  Created by Shohei Yokoyama on 2016/10/09.
//
//

import UIKit

@IBDesignable
final public class Koyomi: UICollectionView {
    
    @IBInspectable var sectionSpace: CGFloat = 1.5
    @IBInspectable var cellSpace: CGFloat = 0.5
    @IBInspectable var weekCellHeight: CGFloat = 25
    public var inset: UIEdgeInsets = UIEdgeInsetsZero {
        didSet {
            setCollectionViewLayout(layout, animated: false)
        }
    }
    
    @IBInspectable public var sectionSeparatorColor: UIColor = .grayColor() {
        didSet {
            sectionSeparator.backgroundColor = sectionSeparatorColor
        }
    }
    @IBInspectable public var separatorColor: UIColor = .grayColor() {
        didSet {
            backgroundColor = separatorColor
        }
    }
    
    public var currentDateString: String {
        return model.dateString(in: .current)
    }
    
    private static let cellIdentifier = "KoyomiCell"
    
    private lazy var model: DateModel = .init()
    private let sectionSeparator: UIView = .init()
    
    private var layout: UICollectionViewLayout {
        return KoyomiLayout(inset: inset, cellSpace: cellSpace, sectionSpace: sectionSpace, weekCellHeight: weekCellHeight)
    }
    
    private var dayLabelFont: UIFont?
    private var weekLabelFont: UIFont?

    // MARK: - Initialization -

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
        collectionViewLayout = layout
    }
    
    public init(frame: CGRect, sectionSpace: CGFloat = 1.5, cellSpace: CGFloat = 0.5, inset: UIEdgeInsets = UIEdgeInsetsZero, weekCellHeight: CGFloat = 25) {
        super.init(frame: frame, collectionViewLayout: KoyomiLayout(inset: inset, cellSpace: cellSpace, sectionSpace: sectionSpace, weekCellHeight: weekCellHeight))
        self.sectionSpace = sectionSpace
        self.cellSpace = cellSpace
        self.inset = inset
        self.weekCellHeight = weekCellHeight
        configure()
    }
    
    public func display(in month: MonthType) {
        model.display(in: month)
        reloadData()
    }
    
    public func setDayFont(fontName name: String = ".SFUIText-Medium", size: CGFloat) {
        dayLabelFont = UIFont(name: name, size: size)
    }
    
    public func setWeekFont(fontName name: String = ".SFUIText-Medium", size: CGFloat) {
        weekLabelFont = UIFont(name: name, size: size)
    }
    
    // MARK: - override -
    
    override public func reloadData() {
        super.reloadData()
        setCollectionViewLayout(layout, animated: false)
    }
}

// MARK: - Private Methods -

private extension Koyomi {
    func configure() {
        delegate      = self
        dataSource    = self
        scrollEnabled = false
        
        backgroundColor = UIColor.grayColor()
        
        registerClass(KoyomiCell.self, forCellWithReuseIdentifier: Koyomi.cellIdentifier)
        
        sectionSeparator.backgroundColor = sectionSeparatorColor
        sectionSeparator.frame = CGRect(x: inset.left, y: inset.top + weekCellHeight, width: frame.width, height: sectionSpace)
        addSubview(sectionSeparator)
    }
    
    func configure(cell: KoyomiCell, at indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.whiteColor()
        cell.content = indexPath.section == 0 ? DateModel.weeks[indexPath.row] : model.dayString(at: indexPath)
        
        if indexPath.section == 0 {
            
            if let font = weekLabelFont {
                cell.setContentFont(fontName: font.fontName, size: font.pointSize)
            }
        } else {
            if let font = dayLabelFont {
                cell.setContentFont(fontName: font.fontName, size: font.pointSize)
            }
        }
    }
}

// MARK: - UICollectionViewDelegate -


extension Koyomi: UICollectionViewDelegate {
    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // TODO: -
    }
}

// MARK: - UICollectionViewDataSource -

extension Koyomi: UICollectionViewDataSource {
    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? DateModel.weeks.count : DateModel.maxCellCount
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Koyomi.cellIdentifier, forIndexPath: indexPath) as! KoyomiCell
        configure(cell, at: indexPath)
        return cell
    }
}
