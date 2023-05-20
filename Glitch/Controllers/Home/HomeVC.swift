//
//  MainVC.swift
//  Glitch
//
//  Created by Yujean Cho on 2023/05/13.
//

import Foundation
import UIKit
import SnapKit

class HomeVC: UIViewController {
    
    private lazy var backView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "BackView")
        return view
    }()
    
    lazy var titleButtonView: TopCategroyButtonView = {
        let button = TopCategroyButtonView()
        button.firstButton.setTitle("Trending", for: .normal)
        button.secondButton.setTitle("Community", for: .normal)
        button.firstButton.addTarget(self, action: #selector(tappedTrendingButton), for: .touchUpInside)
        button.secondButton.addTarget(self, action: #selector(tappedCommunityButton), for: .touchUpInside)
        return button
    }()
    
    lazy var contentView1: UIView = {
        let view = UIView()
        view.isHidden = false
        return view
    }()
    
    lazy var contentView2: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    
    lazy var trendingVC: TrendingVC = {
        let vc = TrendingVC()
        
        vc.tableView.register(TrendingTableViewCell.self, forCellReuseIdentifier: "TrendingTableViewCell")
        
        vc.tableView.dataSource = self
        vc.tableView.delegate = self
        return vc
    }()
    
    lazy var cummunityVC: TrendingVC = {
        let vc = TrendingVC()
        
        vc.tableView.register(TrendingTableViewCell.self, forCellReuseIdentifier: "TrendingTableViewCell")
        
        vc.tableView.dataSource = self
        vc.tableView.delegate = self
        return vc
    }()
    
    @objc func tappedTrendingButton() {
        titleButtonView.firstButton.setTitleColor(.nWhite, for: .normal)
        titleButtonView.secondButton.setTitleColor(UIColor(red: 0.342, green: 0.342, blue: 0.342, alpha: 1), for: .normal)
        
        contentView1.isHidden = false
        contentView2.isHidden = true
    }
    
    @objc func tappedCommunityButton() {
        titleButtonView.firstButton.setTitleColor(UIColor(red: 0.342, green: 0.342, blue: 0.342, alpha: 1), for: .normal)
        titleButtonView.secondButton.setTitleColor(.nWhite, for: .normal)
        
        contentView2.isHidden = false
        contentView1.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .nDarkBlack
        
        setupNavigationBar()
        setupViews()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupViews() {
        
        addChild(trendingVC)
        trendingVC.view.frame = contentView1.frame
        contentView1.addSubview(trendingVC.view)
        trendingVC.didMove(toParent: self)
        
        addChild(cummunityVC)
        cummunityVC.view.frame = contentView2.frame
        contentView2.addSubview(cummunityVC.view)
        cummunityVC.didMove(toParent: self)
        
        [
            backView,
            titleButtonView,
            contentView1,
            contentView2
        ].forEach { view.addSubview($0) }
        
        
        backView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleButtonView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(57.0)
            $0.leading.equalToSuperview().inset(24.0)
            $0.height.equalTo(29.0)
            $0.trailing.equalToSuperview()
        }
        
        contentView1.snp.makeConstraints {
            $0.top.equalTo(titleButtonView.snp.bottom).offset(14.0)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        contentView2.snp.makeConstraints {
            $0.top.equalTo(titleButtonView.snp.bottom).offset(14.0)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell", for: indexPath) as! TrendingTableViewCell
        
        switch tableView {
        case trendingVC.tableView:
            switch indexPath.row {
            case 0:
                cell.elementView.logoView.image = UIImage(named: "NFT1")
                cell.elementView.titleLabel.text = "Oninr"
                cell.elementView.heartView.button.setImage(UIImage(named: "selectedHeart"), for: .normal)
                
                cell.elementView.imageView.removeFromSuperview()
                cell.elementView.heartView.snp.makeConstraints {
                    $0.leading.equalTo(cell.elementView.contentLabel.snp.leading)
                    $0.top.equalTo(cell.elementView.contentLabel.snp.bottom).offset(20.0)
                }
            case 1:
                cell.elementView.logoView.image = UIImage(named: "NFT2")
                cell.elementView.titleLabel.text = "CryptoCities"
                cell.elementView.typeLabel.text = "CSTW"
                cell.elementView.contentLabel.text = """
                The $TSUKA airdrop is now LIVE.
                A $100,000 prize pool was announced, don't miss out
                
                http://tsuka.cash
                
                $PLSX #pulsex #pulsechain $HEX #HEX #PLSX $PSYOP $PEPE
                $WAGMI #1000x $DONS #pepeislove
                """
                cell.elementView.imageView.image = UIImage(named: "CryptoCities")
            case 2:
                cell.elementView.logoView.image = UIImage(named: "NFT3")
                cell.elementView.titleLabel.text = "Nina Dobrev"
                cell.elementView.typeLabel.text = "CSTW"
                cell.elementView.contentLabel.text = """
                🚨 $PLS token airdrop is live!
                
                Check eligibility and claim on their site:
                🔗 https://pulsechainclaims.com
                """
                cell.elementView.imageView.image = UIImage(named: "NinaDobrev")
            case 3:
                cell.elementView.logoView.image = UIImage(named: "Avalanche")
                cell.elementView.titleLabel.text = "Avalanche"
                cell.elementView.typeLabel.text = "CSTW"
                cell.elementView.contentLabel.text = """
                This year's Avalanche Summit showcased the innovation, passion, talent and growth of the Avalanche ecosystem and the community
                
                Here's an album of some select photos from Day 1 at Summit, and stay tuned for photos from Day 2 & 3 next week!
                """
                cell.elementView.imageView.image = UIImage(named: "Avax")
            default:
                break
            }
        case cummunityVC.tableView:
            cell.elementView.logoView.image = UIImage(named: "NFT3")
        default:
            break
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
}

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TrendingDetailVC()
        
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = true
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var height: CGFloat = 0.0
        
        switch tableView {
        case trendingVC.tableView:
            switch indexPath.row {
            case 0:
                height = 248.0
            case 1:
                height = 438.0
            case 2:
                height = 380.0
            default:
                height = 420.0
            }
        case cummunityVC.tableView:
            break
        default:
            break
        }
        
        return height
    }
}
